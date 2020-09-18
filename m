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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E90C43466
	for <linux-dwarves@archiver.kernel.org>; Fri, 18 Sep 2020 20:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F16C1208DB
	for <linux-dwarves@archiver.kernel.org>; Fri, 18 Sep 2020 20:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SxasEJPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgIRUlF (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 18 Sep 2020 16:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgIRUlE (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 18 Sep 2020 16:41:04 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590D7C0613CE
        for <dwarves@vger.kernel.org>; Fri, 18 Sep 2020 13:41:04 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id m13so6132406qtu.10
        for <dwarves@vger.kernel.org>; Fri, 18 Sep 2020 13:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2i1X6lAr7YnUPMItpyCtUy7Ef5GBEYRGYKlWo3HW8/E=;
        b=SxasEJPbM5y7GsYWk4RCO0ktzE8SxML2i1KAhy5V9o4UtP2Sm6yE9c/pWQKLhjOKun
         ke7DDI648R+9KXP9/OaGRf6fcDB2B3lME6/gcqZFfJUV5jsS4tqBe+u+li1OWN5+vLm3
         MFbe0ZLY3jRFOh7pQoeeTfTLN6AQEvzJcJ7gaWF3jArcmupMXMy0WBRfAikGVsXjPbiF
         llRzg8qDosGEzNnIscMjkTV5irKt8UjzqJLYsdRwj93i8DzS1ejw7AoXQml8BITs88Am
         MJr1EtCIpTEsUCWZs4txJdmYhCj7baOVacjrvTVOw1fpguPPR8c86LCUP13RQm96bmY7
         yz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2i1X6lAr7YnUPMItpyCtUy7Ef5GBEYRGYKlWo3HW8/E=;
        b=VATQxEV9a5ddlqqTrKWqg1cVXHGttC6e9mS4GwrUXK2rKOlQd420acaWvUOVQZI409
         g9E5i+PyovtyrVo1sBPD3R8HIeLnjty1T33mKOr3G4dN28MV+ivNXJOOPvX4qnyAfW7d
         kAkjaM6VrW2m9Qf4nFpqGPQWCfWHMxQmQEfOZ82+a3wg+4t5qg5314Y6GRJVOo4nH1ab
         yzOxkpEMQROg5ovmtrVqmKn9VRDjXnLuOzRTr84nYQG8rXkZMIDLgEvpHujBBhN3ySzx
         nGOczJtNn0wEsU3HX0jgRa+FsJq3hc5F/KMrcWJC5IcMJNaxb6BrHn2tItvaE0iRwzTv
         TvxQ==
X-Gm-Message-State: AOAM533VClKXDJatiAWEn67WuDIEsjJ3Qx4W9SFRUbna5P86AjZFWVgw
        Mc5TLaMXdoSr/l7Exv/0Ay5PtJ5DyF8=
X-Google-Smtp-Source: ABdhPJy/jFsdfJ++6yI1F+hNvAUOevtsxYneuMAsZqFzObvsaDtP9LNIUSdSbU+8WT9ts/3krXghlcY07o8=
Sender: "haoluo via sendgmr" <haoluo@haoluo.svl.corp.google.com>
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:f693:9fff:fef4:e444])
 (user=haoluo job=sendgmr) by 2002:ad4:5a0e:: with SMTP id ei14mr20819312qvb.15.1600461663547;
 Fri, 18 Sep 2020 13:41:03 -0700 (PDT)
Date:   Fri, 18 Sep 2020 13:40:57 -0700
In-Reply-To: <20200918204058.1030519-1-haoluo@google.com>
Message-Id: <20200918204058.1030519-2-haoluo@google.com>
Mime-Version: 1.0
References: <20200918204058.1030519-1-haoluo@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH 1/2] btf_encoder: Make encoding vars into BTF optional.
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

Introduce an option --btf_encode_symbols to pahole so that pahole
will only encode global symbols upon request. On the kernel side,
we can add a Kconfig to turn on this feature. This would make the
rollout of pahole v1.18 safe against potential bugs in the feature
introduced in commit f3d9054ba8ff ("btf_encoder: Teach pahole to
store percpu variables in vmlinux BTF.").

Signed-off-by: Hao Luo <haoluo@google.com>
---
 btf_encoder.c |  5 ++++-
 btf_encoder.h |  2 +-
 pahole.c      | 11 ++++++++++-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 982f59d..54ffdd1 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -237,7 +237,7 @@ static struct variable *hashaddr__find_variable(const struct hlist_head hashtabl
 	return NULL;
 }
 
-int cu__encode_btf(struct cu *cu, int verbose, bool force)
+int cu__encode_btf(struct cu *cu, int verbose, bool force, bool encode_symbols)
 {
 	bool add_index_type = false;
 	uint32_t type_id_off;
@@ -314,6 +314,9 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force)
 		}
 	}
 
+	/* if there is no request to encode symbols, just finish. */
+	if (!encode_symbols)
+		goto out;
 
 	if (btfe->percpu_shndx == 0 || !btfe->symtab)
 		goto out;
diff --git a/btf_encoder.h b/btf_encoder.h
index bca2348..f2e95fe 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -13,6 +13,6 @@ struct cu;
 
 int btf_encoder__encode();
 
-int cu__encode_btf(struct cu *cu, int verbose, bool force);
+int cu__encode_btf(struct cu *cu, int verbose, bool force, bool encode_symbols);
 
 #endif /* _BTF_ENCODER_H_ */
diff --git a/pahole.c b/pahole.c
index e1cde61..079d951 100644
--- a/pahole.c
+++ b/pahole.c
@@ -26,6 +26,7 @@
 static bool btf_encode;
 static bool ctf_encode;
 static bool first_obj_only;
+static bool btf_encode_symbols;
 
 static uint8_t class__include_anonymous;
 static uint8_t class__include_nested_anonymous;
@@ -809,6 +810,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_header_type	   314
 #define ARGP_size_bytes		   315
 #define ARGP_range		   316
+#define ARGP_btf_encode_symbols	   317
 
 static const struct argp_option pahole__options[] = {
 	{
@@ -1087,6 +1089,11 @@ static const struct argp_option pahole__options[] = {
 		.key  = 'J',
 		.doc  = "Encode as BTF",
 	},
+	{
+		.name = "btf_encode_symbols",
+		.key  = ARGP_btf_encode_symbols,
+		.doc  = "Encode global symbols in BTF. Off by default."
+	},
 	{
 		.name = "force",
 		.key  = 'j',
@@ -1207,6 +1214,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf.range = arg;			break;
 	case ARGP_header_type:
 		conf.header_type = arg;			break;
+	case ARGP_btf_encode_symbols:
+		btf_encode_symbols = true;		break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -2352,7 +2361,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
 		goto filter_it;
 
 	if (btf_encode) {
-		cu__encode_btf(cu, global_verbose, force);
+		cu__encode_btf(cu, global_verbose, force, btf_encode_symbols);
 		return LSK__KEEPIT;
 	}
 
-- 
2.28.0.681.g6f77f65b4e-goog

