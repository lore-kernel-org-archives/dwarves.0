Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A92C43217
	for <linux-dwarves@archiver.kernel.org>; Tue,  7 Dec 2021 17:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240018AbhLGRfT (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 7 Dec 2021 12:35:19 -0500
Received: from foss.arm.com ([217.140.110.172]:37316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240016AbhLGRfT (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Tue, 7 Dec 2021 12:35:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABBA611D4;
        Tue,  7 Dec 2021 09:31:48 -0800 (PST)
Received: from e126130.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BDB783F73B;
        Tue,  7 Dec 2021 09:31:47 -0800 (PST)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     acme@redhat.com
Cc:     dwarves@vger.kernel.org, douglas.raillard@arm.com
Subject: [PATCH v2 5/6] pahole.c: Add --expanded_prefix option
Date:   Tue,  7 Dec 2021 17:31:50 +0000
Message-Id: <20211207173151.2283946-6-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207173151.2283946-1-douglas.raillard@arm.com>
References: <20211207173151.2283946-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

From: Douglas Raillard <douglas.raillard@arm.com>

Allow prefixing type names and enum members with an arbitrary string as
a way of creating a manual namespace for additional types displayed with
--expand_types.

Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
---
 man-pages/pahole.1 | 5 +++++
 pahole.c           | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index c1ec63e..f845e24 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -122,6 +122,11 @@ Skip COUNT input records.
 Expand class members. Useful to find in what member of inner structs where an
 offset from the beginning of a struct is.
 
+.TP
+.B \-\-expanded_prefix
+Add prefix to type names that are not specified using --class_name. This helps
+avoiding conflicts with existing headers in types expanded by --expand_types.
+
 .TP
 .B \-F, \-\-format_path
 Allows specifying a list of debugging formats to try, in order. Right now this
diff --git a/pahole.c b/pahole.c
index e0a1438..e828c31 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1127,6 +1127,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_skip_encoding_btf_decl_tag 331
 #define ARGP_skip_missing          332
 #define ARGP_skip_encoding_btf_type_tag 333
+#define ARGP_expanded_prefix 334
 
 static const struct argp_option pahole__options[] = {
 	{
@@ -1234,6 +1235,12 @@ static const struct argp_option pahole__options[] = {
 		.key  = 'E',
 		.doc  = "expand class members",
 	},
+	{
+		.name = "expanded_prefix",
+		.key  = ARGP_expanded_prefix,
+		.arg  = "NAME_PREFIX",
+		.doc  = "Add prefix to all the nested types displayed with --expand_types",
+	},
 	{
 		.name = "nr_members",
 		.key  = 'n',
@@ -1666,6 +1673,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf_load.skip_missing = true;          break;
 	case ARGP_skip_encoding_btf_type_tag:
 		conf_load.skip_encoding_btf_type_tag = true;	break;
+	case ARGP_expanded_prefix:
+		conf.name_prefix = arg;                 break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
-- 
2.25.1

