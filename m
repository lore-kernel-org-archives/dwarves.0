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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DA6C35257
	for <linux-dwarves@archiver.kernel.org>; Mon, 21 Sep 2020 19:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8CF72193E
	for <linux-dwarves@archiver.kernel.org>; Mon, 21 Sep 2020 19:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XSrOe4XJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgIUTxz (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 21 Sep 2020 15:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbgIUTxz (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 21 Sep 2020 15:53:55 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFF1C061755
        for <dwarves@vger.kernel.org>; Mon, 21 Sep 2020 12:53:55 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id y17so11846584qkf.15
        for <dwarves@vger.kernel.org>; Mon, 21 Sep 2020 12:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=NkDZcRY3De1hSvtpPkrbUQZa6hDc7W+Q+JsVyUUmZWE=;
        b=XSrOe4XJ1v9dbh0GdNneErWkN9R42VSSV9rwWYLstBuo7453koM7EESt3SlO8cibKt
         srPn5EFgXXhCTQjkwWO5mXUYFm47Y0lCkmnMfuyxPQ2F9zjFDNwJa+kaYm/EPnw6/NJ5
         6q1hQpUmOpkXX8IxAIMB7x6PHv3dICVlailSJJ3m1auKeVmC9+vOarJkKqS7Csmc0a4u
         NwthANxr//Bxsq9+w9raGAoTZz0QqTMF6R/yVsyE9256atiZCFzXKPNwTG4qgY1I3nhM
         KFyQ6qidbKoiqVC5jR3ID6vnSYMPJwFIrfv+y8QcoxA0+azvs0QytcjvsrWE8+I3VmL9
         YjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NkDZcRY3De1hSvtpPkrbUQZa6hDc7W+Q+JsVyUUmZWE=;
        b=NTupewKD6XKXw2M7uzyR/phbrn5Bz/82/RcPKh4R5jL7VatQ3iNvEumqP0lv52aJ86
         kCMkb7gF7S++tPlhA//e8WQA/HjfAgI7iw3gImx3s03DAmfDRheq3MQp5IEPB2WE1yOu
         GFaMYgkuPiM4znjtGE+2i7lsmUmnYy1Olu1iKUX7HJKgc6n3InAF9JxmTr1XQ3TltCvH
         +uyQK7ODTyNBskVETV5VBccG5JTTgMB1HEIrIxM56z2xb7HfLajMe6WmADQx15skfNZh
         xu7MCm4wmMdDHP2/EQ+71+W6DT02WmjUbU/OwGHuXhjZCLtWwN84b0zYG2W95k9H8CJB
         4siQ==
X-Gm-Message-State: AOAM532lOImOUJkAUET2lzrrSMNWbAltQqjtcpiWY4yS7Yt4qCzTk17l
        JoyeM0GrT1aZurpT1jldKWChPGZ2WIs=
X-Google-Smtp-Source: ABdhPJy4Gzdl4oYDxOeqaS3alIPKF5GHgAYIV2HpPP2MLlMDvPhf9SbH62UDcn+yLgLzF6bUmx8v3EslLuE=
Sender: "haoluo via sendgmr" <haoluo@haoluo.svl.corp.google.com>
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:f693:9fff:fef4:e444])
 (user=haoluo job=sendgmr) by 2002:a0c:b21b:: with SMTP id x27mr1924162qvd.12.1600718034526;
 Mon, 21 Sep 2020 12:53:54 -0700 (PDT)
Date:   Mon, 21 Sep 2020 12:53:09 -0700
In-Reply-To: <20200921195310.3070085-1-haoluo@google.com>
Message-Id: <20200921195310.3070085-2-haoluo@google.com>
Mime-Version: 1.0
References: <20200921195310.3070085-1-haoluo@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v2 1/2] btf_encoder: Allow disabling BTF var encoding.
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

A new feature was introduced in commit f3d9054ba8ff ("btf_encoder:
Teach pahole to store percpu variables in vmlinux BTF.") which encodes
kernel percpu variables into BTF. Add a flag --skip_encoding_btf_vars
to allow users to toggle this feature off, so that the rollout of
pahole v1.18 can be protected by potential bugs in this feature.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 btf_encoder.c |  5 ++++-
 btf_encoder.h |  3 ++-
 pahole.c      | 11 ++++++++++-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 982f59d..d26c0b6 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -237,7 +237,8 @@ static struct variable *hashaddr__find_variable(const struct hlist_head hashtabl
 	return NULL;
 }
 
-int cu__encode_btf(struct cu *cu, int verbose, bool force)
+int cu__encode_btf(struct cu *cu, int verbose, bool force,
+		   bool skip_encoding_vars)
 {
 	bool add_index_type = false;
 	uint32_t type_id_off;
@@ -314,6 +315,8 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force)
 		}
 	}
 
+	if (skip_encoding_vars)
+		goto out;
 
 	if (btfe->percpu_shndx == 0 || !btfe->symtab)
 		goto out;
diff --git a/btf_encoder.h b/btf_encoder.h
index bca2348..46fb231 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -13,6 +13,7 @@ struct cu;
 
 int btf_encoder__encode();
 
-int cu__encode_btf(struct cu *cu, int verbose, bool force);
+int cu__encode_btf(struct cu *cu, int verbose, bool force,
+		   bool skip_encoding_vars);
 
 #endif /* _BTF_ENCODER_H_ */
diff --git a/pahole.c b/pahole.c
index e1cde61..4cc8d9f 100644
--- a/pahole.c
+++ b/pahole.c
@@ -26,6 +26,7 @@
 static bool btf_encode;
 static bool ctf_encode;
 static bool first_obj_only;
+static bool skip_encoding_btf_vars;
 
 static uint8_t class__include_anonymous;
 static uint8_t class__include_nested_anonymous;
@@ -809,6 +810,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_header_type	   314
 #define ARGP_size_bytes		   315
 #define ARGP_range		   316
+#define ARGP_skip_encoding_btf_vars 317
 
 static const struct argp_option pahole__options[] = {
 	{
@@ -1087,6 +1089,11 @@ static const struct argp_option pahole__options[] = {
 		.key  = 'J',
 		.doc  = "Encode as BTF",
 	},
+	{
+		.name = "skip_encoding_btf_vars",
+		.key  = ARGP_skip_encoding_btf_vars,
+		.doc  = "Do not encode VARs in BTF."
+	},
 	{
 		.name = "force",
 		.key  = 'j',
@@ -1207,6 +1214,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf.range = arg;			break;
 	case ARGP_header_type:
 		conf.header_type = arg;			break;
+	case ARGP_skip_encoding_btf_vars:
+		skip_encoding_btf_vars = true;		break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -2352,7 +2361,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 		goto filter_it;
 
 	if (btf_encode) {
-		cu__encode_btf(cu, global_verbose, force);
+		cu__encode_btf(cu, global_verbose, force, skip_encoding_btf_vars);
 		return LSK__KEEPIT;
 	}
 
-- 
2.28.0.681.g6f77f65b4e-goog

