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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC214C433E0
	for <linux-dwarves@archiver.kernel.org>; Fri,  5 Feb 2021 13:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8299F64FBC
	for <linux-dwarves@archiver.kernel.org>; Fri,  5 Feb 2021 13:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhBENq2 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 5 Feb 2021 08:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhBENoC (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 5 Feb 2021 08:44:02 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE03EC061224
        for <dwarves@vger.kernel.org>; Fri,  5 Feb 2021 05:42:48 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id d1so5213300qtp.11
        for <dwarves@vger.kernel.org>; Fri, 05 Feb 2021 05:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=tAOVQ3G2eN9dGCWyxwwne5gBaM7loqyQjU9wOYpr/6I=;
        b=OH+gSvlZu8rebHPUVoqKDmTFHlv+/7sQvcchXxOZT1Jn21iONeHO5qh0iOgXDZWX7q
         jeC17g6FkVEOtLw2JujRlsXjCBYN14uQ/OGcRwPWafs4nX0OA8kWZjC42AjACQRY3E+O
         6K/exEZWEsXQ7RObfSoLk6W2LbPGLqRruEHRwzRRiJvTCBgd82+1G8ivxl2sOdOftuJg
         m2WBkw65oW3/j1LRV1+a1nZkqeU/kLZ7Q1IpGzztRAi0qeh1hjeMjoO8ZWfgx29MYJIa
         TUwZpYnUIxODrp3LiKHFcqxHFa/CINvN3it27Eev4QLEzWMsmWlQfsjBnm/+Twr7/tdz
         Qe0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tAOVQ3G2eN9dGCWyxwwne5gBaM7loqyQjU9wOYpr/6I=;
        b=S406vi7dqdXAXi2PHEpfhpOU7bw0U3/NsoGAsizY1Yh8wu38r1cZreeFQBF+t8iO02
         n6hFjCj9a9jscaPT6BnSxXghJyB2KKovEpjPnuPNUGhFvkGvc6JXnwX5o4/byD4/Dmdo
         IKnB9AA726yXx7GPR2KZVJtS6dLlM4WcI1KDc3PrJT47ndG4+BLtyqT1Cqnt0/843LDY
         LYugkjlypGCA9vnWTynCBza/foZUwOEEkcPYUCzy0vNsj8EA3/Cea/hBOTrPOMGlHstx
         kumMTYPGBGGJz1ZpI/4qCH2elqTqsQ81ZpjQBW04PyEgNO9bAwdgmqoWh8nfb4ExD8Vs
         aEHQ==
X-Gm-Message-State: AOAM531M1e2q+a2lgvzuOGOnMtj3fNVhcvWsEAqTYsDz8SXJhExzVa4q
        qIIvf9I6oOQaG6eWQLIrtDwzg5zwLCxGSKx20h9bF1RcT5SZYMyEM6ZKb2Ay79z78Kus55JeHFR
        9HRQGM6mphgPuz3ro0q21F34EEGGQOYgsJEy+D1RP3a3oLxHJPYFR9hVSDY4EclbXbxmk
X-Google-Smtp-Source: ABdhPJz5wihZxlw8hgR5CE0fmzuZmzIXYPXLcOoH3i+RKhajR348e6cGEOGc6mhYA8VGyVScObuVOOKwC0tm4w==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:656b:9716:1ea:3de6])
 (user=gprocida job=sendgmr) by 2002:a05:6214:a54:: with SMTP id
 ee20mr4390536qvb.16.1612532567845; Fri, 05 Feb 2021 05:42:47 -0800 (PST)
Date:   Fri,  5 Feb 2021 13:42:21 +0000
In-Reply-To: <20210205134221.2953163-1-gprocida@google.com>
Message-Id: <20210205134221.2953163-6-gprocida@google.com>
Mime-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210205134221.2953163-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH dwarves v3 5/5] btf_encoder: Align .BTF section to 8 bytes
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     acme@kernel.org, andrii@kernel.org, ast@kernel.org,
        gprocida@google.com, maennich@google.com, kernel-team@android.com,
        kernel-team@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

This is to avoid misaligned access to BTF type structs when
memory-mapping ELF objects.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/libbtf.c b/libbtf.c
index 9f4abb3..6754a17 100644
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

