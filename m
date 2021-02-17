Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA66C433DB
	for <linux-dwarves@archiver.kernel.org>; Wed, 17 Feb 2021 11:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 766B464D73
	for <linux-dwarves@archiver.kernel.org>; Wed, 17 Feb 2021 11:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhBQLKL (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 17 Feb 2021 06:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhBQLJ6 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 17 Feb 2021 06:09:58 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2608AC0617A9
        for <dwarves@vger.kernel.org>; Wed, 17 Feb 2021 03:08:26 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id u8so9717267qvm.5
        for <dwarves@vger.kernel.org>; Wed, 17 Feb 2021 03:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ICJenGYVVB2UMBJ+iIKGIow1eUvegxgyz46lhETpOEo=;
        b=PEhEAThsEfNyW5iaB/O495UGeIjmkOQhOja4zRTQcigkQrN0VXhnDEqu5yCsVz8hJt
         C3RSWAwyrkRcLgJ250YHpCYOhR/d7SbD87sVPf+kQaADqe18hrMxJwgHC3vC3e1r/5hM
         i6N0SqLKpqT8Yx55U6WIOJhX3XeVVnpUHv4bAJyrcc7RgXMWl7TFjX7EWybymD1i0rE9
         fjBEAdbQQpasahkwXL5h00bGF9Z8Z4C9h7a3YEYQMxNDoH1G2jx7Jc6+u1aQqbMwWw85
         jHjpHOC+RgJSJPx5UhjMsOnAiVNqt8qFkWUBGOllF96E7qFkPTIe5Pr/lpNKxSCUoeon
         LYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ICJenGYVVB2UMBJ+iIKGIow1eUvegxgyz46lhETpOEo=;
        b=IbBKpXH/O0yXNP2+fmDmPJilyXKx/SJmL0QWNEPKJJRjU+Fgqw0rhU1OB512j6WjJM
         zln+2vuhl2H0WVIPf4ctuj5m55llw+4iZleYI1AauXNHUbEE6DbR+q8mUv3iY9YY0Pfe
         SNcyAoe1yjZqMkBpj2xvX+cl3N0QyXRHucDpbUup6bD/ka3zTc6MZbfFTfgjyZMGyUvu
         39Y+f+DEeCBCTR78l35OcsfxfNcG98PspJbg/AV4Uo4yZLFWLXniOAuEYvoYRInigSvb
         Joym7KNlMTuzglA/0fTZDwnfzN4WpxiTawM7r7B40a6FEdU1fwCm6b5KglqqAnpAftIu
         O1OA==
X-Gm-Message-State: AOAM531DFTUUIMxpzl22lo4dHmO2KpsuYP8hKnD+2skNLL9tZXkoaa9o
        orc5iQCVZErbNSxMte1eaXTyauBHn088O4UpmXGzdBaT045rwUT4GehI+uG6CA6rCws26GpQY3g
        g7XzKfkYUDu4AYAJen7Xj/6uTpBch4gTewQw+sSCgh6RujLA+AJXiOAGcNc/vQvGpM3dh
X-Google-Smtp-Source: ABdhPJziMOSsIQGNdtJaRQPRS9whDjRhhEU+hGOvIG0l8uCjwtm9jd+lI0E/ouyizbEYfP8GW+SMxFAcBfbP4Q==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:61b3:1cb2:c180:c3f])
 (user=gprocida job=sendgmr) by 2002:a05:6214:16cf:: with SMTP id
 d15mr23910944qvz.32.1613560105235; Wed, 17 Feb 2021 03:08:25 -0800 (PST)
Date:   Wed, 17 Feb 2021 11:08:04 +0000
In-Reply-To: <20210217110804.75923-1-gprocida@google.com>
Message-Id: <20210217110804.75923-6-gprocida@google.com>
Mime-Version: 1.0
References: <20210205134221.2953163-1-gprocida@google.com> <20210217110804.75923-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH dwarves v4 5/5] btf_encoder: Align .BTF section to 8 bytes
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org, acme@kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, gprocida@google.com,
        maennich@google.com, kernel-team@android.com, kernel-team@fb.com,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

This is to avoid misaligned access to BTF type structs when
memory-mapping ELF objects.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/libbtf.c b/libbtf.c
index 9ff03ca..ee677fa 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -744,6 +744,14 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 		goto out;
 	}
 
+	/*
+	 * We'll align .BTF to 8 bytes to cater for all architectures. It'd be
+	 * nice if we could fetch this value from somewhere. The BTF
+	 * specification does not discuss alignment and its trailing string
+	 * table is not currently padded to any particular alignment.
+	 */
+	const size_t btf_alignment = 8;
+
 	/*
 	 * First we check if there is already a .BTF section present.
 	 */
@@ -821,6 +829,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 		elf_error("elf_getshdr(btf_scn) failed");
 		goto out;
 	}
+	btf_shdr.sh_addralign = btf_alignment;
 	btf_shdr.sh_entsize = 0;
 	btf_shdr.sh_flags = 0;
 	if (dot_btf_offset)
-- 
2.30.0.478.g8a0d178c01-goog

