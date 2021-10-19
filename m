Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46417C433F5
	for <linux-dwarves@archiver.kernel.org>; Tue, 19 Oct 2021 10:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E3E060FF2
	for <linux-dwarves@archiver.kernel.org>; Tue, 19 Oct 2021 10:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhJSKoE (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 19 Oct 2021 06:44:04 -0400
Received: from foss.arm.com ([217.140.110.172]:47394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230117AbhJSKoE (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Tue, 19 Oct 2021 06:44:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB90BD6E;
        Tue, 19 Oct 2021 03:41:51 -0700 (PDT)
Received: from e126130.arm.com (unknown [10.57.55.219])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0B3B83F70D;
        Tue, 19 Oct 2021 03:41:50 -0700 (PDT)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     acme@redhat.com
Cc:     dwarves@vger.kernel.org, douglas.raillard@arm.com
Subject: [PATCH v1] pahole: Add --skip_missing option
Date:   Tue, 19 Oct 2021 11:42:00 +0100
Message-Id: <20211019104200.334089-1-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

From: Douglas Raillard <douglas.raillard@arm.com>

Add a --skip_missing option that allows pahole to keep going in case one
of the type passed to -C (e.g. via a file) does not exist.

This is useful for intropsection software such as debugging kernel
modules that can handle various kernel configurations and versions for
which some recently added types are missing. The consumer of the header
becomes responsible of gating the uses of the type with #ifdef
CONFIG_XXX, rather than pahole bailing out on the first unknown type.

Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
---
 dwarves.h |  2 ++
 pahole.c  | 17 +++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/dwarves.h b/dwarves.h
index 30d33fa..6be6094 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -43,6 +43,7 @@ struct conf_fprintf;
  * @get_addr_info - wheter to load DW_AT_location and other addr info
  * @nr_jobs - -j argument, number of threads to use
  * @ptr_table_stats - print developer oriented ptr_table statistics.
+ * @skip_missing - skip missing types rather than bailing out.
  */
 struct conf_load {
 	enum load_steal_kind	(*steal)(struct cu *cu,
@@ -59,6 +60,7 @@ struct conf_load {
 	bool			ignore_labels;
 	bool			ptr_table_stats;
 	bool			skip_encoding_btf_tag;
+	bool			skip_missing;
 	uint8_t			hashtable_bits;
 	uint8_t			max_hashtable_bits;
 	uint16_t		kabi_prefix_len;
diff --git a/pahole.c b/pahole.c
index 80271b5..68e3c8a 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1125,6 +1125,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_hashbits		   329
 #define ARGP_devel_stats	   330
 #define ARGP_skip_encoding_btf_tag 331
+#define ARGP_skip_missing          332
 
 static const struct argp_option pahole__options[] = {
 	{
@@ -1500,6 +1501,11 @@ static const struct argp_option pahole__options[] = {
 		.key  = ARGP_skip_encoding_btf_tag,
 		.doc  = "Do not encode TAGs in BTF."
 	},
+	{
+		.name = "skip_missing",
+		.key  = ARGP_skip_missing,
+		.doc = "skip missing types passed to -C rather than stop",
+	},
 	{
 		.name = NULL,
 	}
@@ -1650,6 +1656,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf_load.ptr_table_stats = true;	break;
 	case ARGP_skip_encoding_btf_tag:
 		conf_load.skip_encoding_btf_tag = true;	break;
+	case ARGP_skip_missing:
+		conf_load.skip_missing = true;          break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -2879,8 +2887,13 @@ out_btf:
 		static type_id_t class_id;
 		struct tag *class = cu__find_type_by_name(cu, prototype->name, include_decls, &class_id);
 
-		if (class == NULL)
-			return ret; // couldn't find that class name in this CU, continue to the next one.
+		// couldn't find that class name in this CU, continue to the next one.
+		if (class == NULL) {
+			if (conf_load->skip_missing)
+				continue;
+			else
+				return ret;
+		}
 
 		if (prototype->nr_args != 0 && !tag__is_struct(class)) {
 			fprintf(stderr, "pahole: attributes are only supported with 'class' and 'struct' types\n");
-- 
2.25.1

