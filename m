Return-Path: <SRS0=zo6D=C3=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD180C43465
	for <linux-dwarves@archiver.kernel.org>; Fri, 18 Sep 2020 20:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B23E208DB
	for <linux-dwarves@archiver.kernel.org>; Fri, 18 Sep 2020 20:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BJPlKM2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIRUlJ (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 18 Sep 2020 16:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgIRUlG (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 18 Sep 2020 16:41:06 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065A6C0613CE
        for <dwarves@vger.kernel.org>; Fri, 18 Sep 2020 13:41:06 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id z12so4580003qvp.11
        for <dwarves@vger.kernel.org>; Fri, 18 Sep 2020 13:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=YWCTSL0bsm250clPnoyunKa/R8V4ka6jWeBscDrF+7Q=;
        b=BJPlKM2iTFa6PnFK742qPk7LfAPI4Y91onb7P6dEcJ1gqf7tGpn/wXCb4jbZBGNf2h
         CJeUglFS7vJ833ms3IBBYN6Zo6airAwhlRPDvUEatG6b0dxGHBr5Rkysv6I6/vL5g8xj
         n89C00t4uUc9bS/7y62XjQHQB5NnKZqvrlM82O3ciY0PqD9FXi+tubyvra6/RkMUrFGb
         Dm3D+ydydGWp4m4OGf1+McZFqOdPlcFTFl0LEBLQWvYpiFSdibPf1EcSliC0cIyKAc0k
         C4TC5pg7U4GaKsZxOjQurlw8Pcr7H+rATwYISIre+yFRZg2Smp3/9dCEkeDycM1oy5NP
         ZfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YWCTSL0bsm250clPnoyunKa/R8V4ka6jWeBscDrF+7Q=;
        b=gMHjVcP5rr93r7lvAquVbYXDsccltYm6/sKaVbJ+CIKypm7dsRjPOItfZEzWC6Xprm
         EhpP5nmonc3a5isO8t3+RjdjRzHSghEeMU2ZKRy6+8yQmQnvA8Se2rDqyYG3mX2edYv9
         kMJmYn+bOi8TuFtjvgWyBR0KktysNmsdsLGllpmGmmphOmm6cCIRlrUywa+t18quKYrV
         JLUDspBivPZEg7OLMwG/RIkOXvZh2oXogI1l0qilCyknzeYYsdgxNMekQ4deSiUJ1n8d
         MNnr41uXLcrDu5nNdYrtaBW0oUZ6SjgvqslOtj5RSu9yFk92ZZKr0AbQUk3aatdOjD5x
         7NaQ==
X-Gm-Message-State: AOAM530pMPnI831xDDGJ/PUd5unPJ7RzwdU9XrXypTaVYxgZ+60rpgW/
        J1OtfgCUnmTEWuMG7m5eceNleKedi4U=
X-Google-Smtp-Source: ABdhPJzPq/tV5W173hzbDbQ31Hze7Q2y/iT8P4A/GnD1Me0EnGFd83MlubQ2cBANd/u5SBNbGQ0jA/eiLuI=
Sender: "haoluo via sendgmr" <haoluo@haoluo.svl.corp.google.com>
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:f693:9fff:fef4:e444])
 (user=haoluo job=sendgmr) by 2002:ad4:5a0e:: with SMTP id ei14mr20819408qvb.15.1600461665225;
 Fri, 18 Sep 2020 13:41:05 -0700 (PDT)
Date:   Fri, 18 Sep 2020 13:40:58 -0700
In-Reply-To: <20200918204058.1030519-1-haoluo@google.com>
Message-Id: <20200918204058.1030519-3-haoluo@google.com>
Mime-Version: 1.0
References: <20200918204058.1030519-1-haoluo@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH 2/2] btf_encoder: Introduce option '--btf_encode_force'
From:   Hao Luo <haoluo@google.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        daniel@iogearbox.net, dwarves@vger.kernel.org, yhs@fb.com,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Commit f3d9054ba8ff ("btf_encoder: Teach pahole to store percpu
variables in vmlinux BTF.") introduced an option '-j' that makes best
effort in emitting VAR entries in BTF. Before no one has been using
this flag, replace the one-letter option '-j' with a full flag name
'--btf_encode_force' to save '-j' for future uses.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 pahole.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/pahole.c b/pahole.c
index 079d951..3297729 100644
--- a/pahole.c
+++ b/pahole.c
@@ -27,6 +27,7 @@ static bool btf_encode;
 static bool ctf_encode;
 static bool first_obj_only;
 static bool btf_encode_symbols;
+static bool btf_encode_force;
 
 static uint8_t class__include_anonymous;
 static uint8_t class__include_nested_anonymous;
@@ -62,7 +63,6 @@ static int show_reorg_steps;
 static const char *class_name;
 static LIST_HEAD(class_names);
 static char separator = '\t';
-static bool force;
 
 static struct conf_fprintf conf = {
 	.emit_stats = 1,
@@ -811,6 +811,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_size_bytes		   315
 #define ARGP_range		   316
 #define ARGP_btf_encode_symbols	   317
+#define ARGP_btf_encode_force      318
 
 static const struct argp_option pahole__options[] = {
 	{
@@ -1095,8 +1096,8 @@ static const struct argp_option pahole__options[] = {
 		.doc  = "Encode global symbols in BTF. Off by default."
 	},
 	{
-		.name = "force",
-		.key  = 'j',
+		.name = "btf_encode_force",
+		.key  = ARGP_btf_encode_force,
 		.doc  = "Ignore those symbols found invalid when encoding BTF."
 	},
 	{
@@ -1143,7 +1144,6 @@ static error_t pahole__options_parser(int key, char *arg,
 	case 'J': btf_encode = 1;
 		  conf_load.get_addr_info = true;
 		  no_bitfield_type_recode = true;	break;
-	case 'j': force = true;				break;
 	case 'l': conf.show_first_biggest_size_base_type_member = 1;	break;
 	case 'M': conf.show_only_data_members = 1;	break;
 	case 'm': stats_formatter = nr_methods_formatter; break;
@@ -1216,6 +1216,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf.header_type = arg;			break;
 	case ARGP_btf_encode_symbols:
 		btf_encode_symbols = true;		break;
+	case ARGP_btf_encode_force:
+		btf_encode_force = true;		break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -2361,7 +2363,8 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 		goto filter_it;
 
 	if (btf_encode) {
-		cu__encode_btf(cu, global_verbose, force, btf_encode_symbols);
+		cu__encode_btf(cu, global_verbose, btf_encode_force,
+			       btf_encode_symbols);
 		return LSK__KEEPIT;
 	}
 
-- 
2.28.0.681.g6f77f65b4e-goog

