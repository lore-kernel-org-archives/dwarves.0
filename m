Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524AAC433EF
	for <linux-dwarves@archiver.kernel.org>; Tue, 19 Oct 2021 10:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3481D61027
	for <linux-dwarves@archiver.kernel.org>; Tue, 19 Oct 2021 10:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbhJSKKJ (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 19 Oct 2021 06:10:09 -0400
Received: from foss.arm.com ([217.140.110.172]:46980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234794AbhJSKKI (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Tue, 19 Oct 2021 06:10:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38650D6E;
        Tue, 19 Oct 2021 03:07:56 -0700 (PDT)
Received: from e126130.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 324DD3F70D;
        Tue, 19 Oct 2021 03:07:55 -0700 (PDT)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     acme@redhat.com
Cc:     dwarves@vger.kernel.org, douglas.raillard@arm.com
Subject: [PATCH v1 2/2] pahole.c: Add --inner_anonymous option
Date:   Tue, 19 Oct 2021 11:07:24 +0100
Message-Id: <20211019100724.325570-3-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019100724.325570-1-douglas.raillard@arm.com>
References: <20211019100724.325570-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

From: Douglas Raillard <douglas.raillard@arm.com>

Allow making the inner struct/enum/union anonymous. This permits using
the header to inspect pointer values using -E, without having to care
about avoiding duplicate type definitions such as:

    struct foo { ... };
    struct bar {
        struct foo {
	     ....
	} a;
    };

With --inner_anonymous, the conflict between the two definitions of
struct foo is gone:

    struct foo { ... };
    struct bar {
        struct {
	     ....
	} a;
    };

Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
---
 pahole.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/pahole.c b/pahole.c
index 80271b5..b9c6305 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1125,6 +1125,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_hashbits		   329
 #define ARGP_devel_stats	   330
 #define ARGP_skip_encoding_btf_tag 331
+#define ARGP_inner_anonymous       332
 
 static const struct argp_option pahole__options[] = {
 	{
@@ -1232,6 +1233,11 @@ static const struct argp_option pahole__options[] = {
 		.key  = 'E',
 		.doc  = "expand class members",
 	},
+	{
+		.name = "inner_anonymous",
+		.key  = ARGP_inner_anonymous,
+		.doc  = "expanded class members are anonymous",
+	},
 	{
 		.name = "nr_members",
 		.key  = 'n',
@@ -1650,6 +1656,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf_load.ptr_table_stats = true;	break;
 	case ARGP_skip_encoding_btf_tag:
 		conf_load.skip_encoding_btf_tag = true;	break;
+	case ARGP_inner_anonymous:
+		conf.inner_anonymous = true;            break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
-- 
2.25.1

