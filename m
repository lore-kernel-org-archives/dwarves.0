Return-Path: <SRS0=ASgQ=C6=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E453C4363C
	for <linux-dwarves@archiver.kernel.org>; Mon, 21 Sep 2020 19:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13BA42193E
	for <linux-dwarves@archiver.kernel.org>; Mon, 21 Sep 2020 19:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HfLUwE+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgIUTx6 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 21 Sep 2020 15:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbgIUTx5 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 21 Sep 2020 15:53:57 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB40C061755
        for <dwarves@vger.kernel.org>; Mon, 21 Sep 2020 12:53:57 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id k14so9912656qvw.20
        for <dwarves@vger.kernel.org>; Mon, 21 Sep 2020 12:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=vyoKpoBzL35FdHc+AALny97cxRHkgoPWpHUgxYMHO0o=;
        b=HfLUwE+LZp+6UGfaTFae3NoMwfIb64b4anNVEuoogUaruMQ6ycpCbkuIdXkjAmWMbm
         xvB7QZMC5I8Obp3nV6E6BjlIPW/vRALPfBJ2e8xDqAV5LGqPt02ydjqg9Z3UABicgqAz
         O9HXOwVN5lGnHODO5f6cK+K6tFJy3KPCKT189t8hbZPh1O5nSzkMAbyAiSjPUknJUj2f
         mfA9mkbhKzrVFQXseLtjicEyyQC7Gw2fjaV+pYWRtp69kg6cQw1mpRxmAMVLhgMSzJ1n
         kIzkbMrgou4hdbiy+iR4/wwAy4CF2qLgMlsU5xcguaRugx9PmPY3MFuEwoo0YtkK8wj6
         OPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vyoKpoBzL35FdHc+AALny97cxRHkgoPWpHUgxYMHO0o=;
        b=myW7Byv2bW5N8pYxDI9/imUIGgeyCfM66vo7EKmddUI8PUWBrIfzwT6qbn2QUVav0A
         lFHqa8QfUofq3xpY2i7qAUnMDqztxZJMwSepRwOHmRwbt7IEBilTNSPqQN1IPOUlR8xh
         UIhNxxysngV+PNeGGWqFqPaiJRwAlAb+vef/0l3noTQPc69etoKGp5VpImw5mabHwTeW
         ndVeX8ZN4tZIUgxgLKCvLPu+vhtpB4KbV8Vx+yUiTPwufSahda00jK75/ul8z7XFoT8O
         obkIP9TyH0JDyT5n4hW5gZAmOSoQjXP7V4dAjHjdmNj6na1TI8pTEAkgCCY3W11OdeEA
         hbng==
X-Gm-Message-State: AOAM532iQOn/Yah0WLfCCPk3K+I9zBSUnTEwwt6enfqMx2KCw0/vHMp8
        rdmaprGjJrHxj7dzmI+Lsq52GT2ih2o=
X-Google-Smtp-Source: ABdhPJxCajJHCQHc94+ps7yahMg71Mq7KP3OFv5+f3w0iAH7v/9F9pQP7Hz00DAukh9dI0ufAq2AiYu1IHg=
Sender: "haoluo via sendgmr" <haoluo@haoluo.svl.corp.google.com>
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:f693:9fff:fef4:e444])
 (user=haoluo job=sendgmr) by 2002:ad4:58aa:: with SMTP id ea10mr1763672qvb.58.1600718036816;
 Mon, 21 Sep 2020 12:53:56 -0700 (PDT)
Date:   Mon, 21 Sep 2020 12:53:10 -0700
In-Reply-To: <20200921195310.3070085-1-haoluo@google.com>
Message-Id: <20200921195310.3070085-3-haoluo@google.com>
Mime-Version: 1.0
References: <20200921195310.3070085-1-haoluo@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v2 2/2] btf_encoder: Introduce option '--btf_encode_force'
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
variables in vmlinux BTF.") introduced an option '-j' that makes
effort in emitting VAR entries in BTF. Before no one has been using
this flag, replace the one-letter option '-j' with a full flag name
'--btf_encode_force' to save '-j' for future uses.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 pahole.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/pahole.c b/pahole.c
index 4cc8d9f..ee5f2f7 100644
--- a/pahole.c
+++ b/pahole.c
@@ -27,6 +27,7 @@ static bool btf_encode;
 static bool ctf_encode;
 static bool first_obj_only;
 static bool skip_encoding_btf_vars;
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
 #define ARGP_skip_encoding_btf_vars 317
+#define ARGP_btf_encode_force	   318
 
 static const struct argp_option pahole__options[] = {
 	{
@@ -1095,8 +1096,8 @@ static const struct argp_option pahole__options[] = {
 		.doc  = "Do not encode VARs in BTF."
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
 	case ARGP_skip_encoding_btf_vars:
 		skip_encoding_btf_vars = true;		break;
+	case ARGP_btf_encode_force:
+		btf_encode_force = true;		break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -2361,7 +2363,8 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 		goto filter_it;
 
 	if (btf_encode) {
-		cu__encode_btf(cu, global_verbose, force, skip_encoding_btf_vars);
+		cu__encode_btf(cu, global_verbose, btf_encode_force,
+			       skip_encoding_btf_vars);
 		return LSK__KEEPIT;
 	}
 
-- 
2.28.0.681.g6f77f65b4e-goog

