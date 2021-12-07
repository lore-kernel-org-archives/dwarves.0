Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6099C433F5
	for <linux-dwarves@archiver.kernel.org>; Tue,  7 Dec 2021 17:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240021AbhLGRfV (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 7 Dec 2021 12:35:21 -0500
Received: from foss.arm.com ([217.140.110.172]:37322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240016AbhLGRfU (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Tue, 7 Dec 2021 12:35:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1C9E13A1;
        Tue,  7 Dec 2021 09:31:49 -0800 (PST)
Received: from e126130.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 024313F73B;
        Tue,  7 Dec 2021 09:31:48 -0800 (PST)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     acme@redhat.com
Cc:     dwarves@vger.kernel.org, douglas.raillard@arm.com
Subject: [PATCH v2 6/6] pahole.c: Add --forward_decl option
Date:   Tue,  7 Dec 2021 17:31:51 +0000
Message-Id: <20211207173151.2283946-7-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207173151.2283946-1-douglas.raillard@arm.com>
References: <20211207173151.2283946-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

From: Douglas Raillard <douglas.raillard@arm.com>

Print forward declaration for types supporting it. This allows creating
a self-contained header where it is guaranteed that union and struct
pointers will compile correctly regardless of their declaration order.

Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
---
 dwarves.h         |  4 ++++
 dwarves_fprintf.c |  5 +----
 pahole.c          | 22 ++++++++++++++++++++++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/dwarves.h b/dwarves.h
index 0967e5c..3f4b31b 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -1046,6 +1046,10 @@ struct type {
 
 void __type__init(struct type *type);
 
+size_t type__fprintf(struct tag *type, const struct cu *cu,
+		     const char *name, const struct conf_fprintf *conf,
+		     FILE *fp);
+
 size_t tag__natural_alignment(struct tag *tag, const struct cu *cu);
 
 static inline struct class *type__class(const struct type *type)
diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index 2c5dce6..c116184 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -199,9 +199,6 @@ size_t tag__fprintf_decl_info(const struct tag *tag,
 
 static size_t __class__fprintf(struct class *class, const struct cu *cu,
 			       const struct conf_fprintf *conf, FILE *fp);
-static size_t type__fprintf(struct tag *type, const struct cu *cu,
-			    const char *name, const struct conf_fprintf *conf,
-			    FILE *fp);
 
 static size_t array_type__fprintf(const struct tag *tag,
 				  const struct cu *cu, const char *name,
@@ -637,7 +634,7 @@ static size_t type__fprintf_stats(struct type *type, const struct cu *cu,
 static size_t union__fprintf(struct type *type, const struct cu *cu,
 			     const struct conf_fprintf *conf, FILE *fp);
 
-static size_t type__fprintf(struct tag *type, const struct cu *cu,
+size_t type__fprintf(struct tag *type, const struct cu *cu,
 			    const char *name, const struct conf_fprintf *conf,
 			    FILE *fp)
 {
diff --git a/pahole.c b/pahole.c
index e828c31..73579f5 100644
--- a/pahole.c
+++ b/pahole.c
@@ -59,6 +59,8 @@ static size_t cu__exclude_prefix_len;
 static char *decl_exclude_prefix;
 static size_t decl_exclude_prefix_len;
 
+static bool print_forward_decl;
+
 static uint16_t nr_holes;
 static uint16_t nr_bit_holes;
 static uint16_t hole_size_ge;
@@ -1128,6 +1130,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_skip_missing          332
 #define ARGP_skip_encoding_btf_type_tag 333
 #define ARGP_expanded_prefix 334
+#define ARGP_forward_decl 335
 
 static const struct argp_option pahole__options[] = {
 	{
@@ -1241,6 +1244,11 @@ static const struct argp_option pahole__options[] = {
 		.arg  = "NAME_PREFIX",
 		.doc  = "Add prefix to all the nested types displayed with --expand_types",
 	},
+	{
+		.name = "forward_decl",
+		.key  = ARGP_forward_decl,
+		.doc  = "Print a forward declaration for types that support it",
+	},
 	{
 		.name = "nr_members",
 		.key  = 'n',
@@ -1675,6 +1683,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf_load.skip_encoding_btf_type_tag = true;	break;
 	case ARGP_expanded_prefix:
 		conf.name_prefix = arg;                 break;
+	case ARGP_forward_decl:
+		print_forward_decl = true;                 break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -2898,6 +2908,10 @@ out_btf:
 	bool skip;
 	const char *prefix = conf_load->conf_fprintf->name_prefix;
 	const size_t prefix_len = prefix ? strlen(prefix) : 0;
+
+	struct conf_fprintf pconf = *conf_load->conf_fprintf;
+	pconf.expand_types = false;
+
 	cu__for_each_type(cu, id, pos) {
 		if (tag__is_type(pos)) {
 			const char *name = type__name(tag__type(pos));
@@ -2917,6 +2931,14 @@ out_btf:
 				}
 			}
 		}
+		if (print_forward_decl && (tag__is_union(pos) || tag__is_struct(pos))) {
+			const char *name = type__name(tag__type(pos));
+			if (name) {
+				type__fprintf(pos, cu, NULL, &pconf, stdout);
+				pos->printed = false;
+				printf(";\n");
+			}
+		}
 	}
 
 	list_for_each_entry_safe(prototype, n, &class_names, node) {
-- 
2.25.1

