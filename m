Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C2CC433F5
	for <linux-dwarves@archiver.kernel.org>; Tue,  7 Dec 2021 17:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbhLGRfS (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 7 Dec 2021 12:35:18 -0500
Received: from foss.arm.com ([217.140.110.172]:37310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240018AbhLGRfR (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Tue, 7 Dec 2021 12:35:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B01113A1;
        Tue,  7 Dec 2021 09:31:47 -0800 (PST)
Received: from e126130.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6A3503F73B;
        Tue,  7 Dec 2021 09:31:46 -0800 (PST)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     acme@redhat.com
Cc:     dwarves@vger.kernel.org, douglas.raillard@arm.com
Subject: [PATCH v2 4/6] pahole.c: Add prefix to expanded type names
Date:   Tue,  7 Dec 2021 17:31:49 +0000
Message-Id: <20211207173151.2283946-5-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207173151.2283946-1-douglas.raillard@arm.com>
References: <20211207173151.2283946-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

From: Douglas Raillard <douglas.raillard@arm.com>

Add the prefix specified by --expanded_prefix to type names that have
not been specificaly requested using -C. This allows manual namespacing
so that these inner types will not conflict with existing headers.

Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
---
 dwarves.h |  1 +
 pahole.c  | 29 +++++++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/dwarves.h b/dwarves.h
index fc5b3fa..0967e5c 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -90,6 +90,7 @@ struct conf_load {
  */
 struct conf_fprintf {
 	const char *prefix;
+	const char *name_prefix;
 	const char *suffix;
 	int32_t	   type_spacing;
 	int32_t	   name_spacing;
diff --git a/pahole.c b/pahole.c
index 42ba110..e0a1438 100644
--- a/pahole.c
+++ b/pahole.c
@@ -2882,6 +2882,33 @@ out_btf:
 
 	bool include_decls = find_pointers_in_structs != 0 || stats_formatter == nr_methods_formatter;
 	struct prototype *prototype, *n;
+	static type_id_t class_id;
+
+	uint32_t id;
+	struct tag *pos;
+	bool skip;
+	const char *prefix = conf_load->conf_fprintf->name_prefix;
+	const size_t prefix_len = prefix ? strlen(prefix) : 0;
+	cu__for_each_type(cu, id, pos) {
+		if (tag__is_type(pos)) {
+			const char *name = type__name(tag__type(pos));
+			if (name && prefix) {
+				skip = false;
+				list_for_each_entry_safe(prototype, n, &class_names, node) {
+					if (!strcmp(prototype->name, name)) {
+						skip = true;
+						break;
+					}
+				}
+				if (!skip) {
+					const size_t len = 1024 + prefix_len;
+					char *bf = malloc(len);
+					snprintf(bf, len, "%s%s", prefix, name);
+					tag__namespace(pos)->name = bf;
+				}
+			}
+		}
+	}
 
 	list_for_each_entry_safe(prototype, n, &class_names, node) {
 
@@ -2891,8 +2918,6 @@ out_btf:
 				prototype->type_enum_resolved = type__find_type_enum(tag__type(prototype->class), cu, prototype->type_enum) == 0;
 			continue;
 		}
-
-		static type_id_t class_id;
 		struct tag *class = cu__find_type_by_name(cu, prototype->name, include_decls, &class_id);
 
 		// couldn't find that class name in this CU, continue to the next one.
-- 
2.25.1

