Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3C0C433F5
	for <linux-dwarves@archiver.kernel.org>; Tue,  7 Dec 2021 17:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240015AbhLGRfP (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 7 Dec 2021 12:35:15 -0500
Received: from foss.arm.com ([217.140.110.172]:37298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhLGRfP (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Tue, 7 Dec 2021 12:35:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9472413A1;
        Tue,  7 Dec 2021 09:31:44 -0800 (PST)
Received: from e126130.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BC8783F73B;
        Tue,  7 Dec 2021 09:31:43 -0800 (PST)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     acme@redhat.com
Cc:     dwarves@vger.kernel.org, douglas.raillard@arm.com
Subject: [PATCH v2 2/6] Revert "pahole.c: Add --inner_anonymous option"
Date:   Tue,  7 Dec 2021 17:31:47 +0000
Message-Id: <20211207173151.2283946-3-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207173151.2283946-1-douglas.raillard@arm.com>
References: <20211207173151.2283946-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

From: Douglas Raillard <douglas.raillard@arm.com>

This reverts commit 6bf42c504b25f7daf9b601655ba1f8ba9ae3dd79.

Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
---
 man-pages/pahole.1 | 7 -------
 pahole.c           | 8 --------
 2 files changed, 15 deletions(-)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 583e8a9..c1ec63e 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -122,13 +122,6 @@ Skip COUNT input records.
 Expand class members. Useful to find in what member of inner structs where an
 offset from the beginning of a struct is.
 
-.TP
-.B \-\-inner_anonymous
-Allow making inner structs, enums and unions anonymous, so that when using -E
-to expand types we don't end up with multiple definitions for the expanded
-inner structs/enums/unions, allowing the resulting expanded struct to be
-compilable.
-
 .TP
 .B \-F, \-\-format_path
 Allows specifying a list of debugging formats to try, in order. Right now this
diff --git a/pahole.c b/pahole.c
index 0f4ca57..f3a51cb 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1127,7 +1127,6 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_skip_encoding_btf_decl_tag 331
 #define ARGP_skip_missing          332
 #define ARGP_skip_encoding_btf_type_tag 333
-#define ARGP_inner_anonymous       334
 
 static const struct argp_option pahole__options[] = {
 	{
@@ -1235,11 +1234,6 @@ static const struct argp_option pahole__options[] = {
 		.key  = 'E',
 		.doc  = "expand class members",
 	},
-	{
-		.name = "inner_anonymous",
-		.key  = ARGP_inner_anonymous,
-		.doc  = "expanded class members are anonymous",
-	},
 	{
 		.name = "nr_members",
 		.key  = 'n',
@@ -1672,8 +1666,6 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf_load.skip_missing = true;          break;
 	case ARGP_skip_encoding_btf_type_tag:
 		conf_load.skip_encoding_btf_type_tag = true;	break;
-	case ARGP_inner_anonymous:
-		conf.inner_anonymous = true;            break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
-- 
2.25.1

