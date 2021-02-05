Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F8DC4332E
	for <linux-dwarves@archiver.kernel.org>; Fri,  5 Feb 2021 22:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C640064FFC
	for <linux-dwarves@archiver.kernel.org>; Fri,  5 Feb 2021 22:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhBEWoB (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbhBENng (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 5 Feb 2021 08:43:36 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE12AC06121F
        for <dwarves@vger.kernel.org>; Fri,  5 Feb 2021 05:42:43 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id m7so7028465ybm.19
        for <dwarves@vger.kernel.org>; Fri, 05 Feb 2021 05:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IfrsKiM9qTPCm/mu8IvDda9E8qIyarKKAm3lIwYPM20=;
        b=kw2tnKgzpXRLq/FqFTSuKJnVTUwBFoe6uff7J2jbvTcndve02E6mDJ8rCruNugyAts
         rlS8Kvjxzr6gfSq1DDmlFxih48bdx0gJhhwGihjxmfB1Q5YxUPbFzCFxjFX2rCuhzUaw
         WNGY8moTkd6Nhlq313HeCqdYi/orDKDKiQgJo558nRTYgkCjdOOF/TRrJ7rp519idd9e
         yyS855aB5dsK2wBQl8jaqrqJvGjIsXVFrHvKdDbbw3BUW9pdT4LQ2b6iLx2m9lIA19Vq
         Gylnftm4KHwIJsQHEWQtTyI4lq4eUmQN21aLMT7Cg3D+O4KZCxipK2Z2wktGENEIZusN
         ieag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IfrsKiM9qTPCm/mu8IvDda9E8qIyarKKAm3lIwYPM20=;
        b=JOzaeUXhAhO+Z8FRiu2NTnYcymlhvkBtTGDidTzMgpDS3sC2QzJWljs7qa6/LXFF4S
         SwC93U/psGkOJo+m57Io/i7hFVYbOOCZtJSLfnqpc+ks9WRFqMeKRUZcc6buOL4eRVIJ
         Rqwawch0SwcEZNWB8jO6MEkExk3cqz+ZjiqliFV9uqW/ljlrT4529ghJ7wl7WkUZzWKu
         oZYhcGOgsCW7K00pHnuHeWRxVZqjaApPGUm2FXqfREeYNSOfS/J2Zu2msMR1pvBu+mYs
         qfPr4+7kQht/5HT7P42DOj9r+WvIOshXw/yubrk7Fro64vDLgTzk+HucXAJRM724PFP7
         +xxQ==
X-Gm-Message-State: AOAM531G/8Nd31q4x02mqdkHwZ7hNjPBuecMcSC3N3LHZq+npEkagvcy
        Lz8lpx9i4VBqXG7VHcbIWFXpyNFNEqGpn03GKhroTdTwyhTQlUi4pFFT5U8DcrauLrpUnIhh+4Z
        Jk6wVLH9pRreyZ0V2PfqRDQXvIoiTBm9U8xN2ciuJ9fTYmCQaa78scKfy+0OPmyZsUwN/
X-Google-Smtp-Source: ABdhPJyI1NCzzeWtf0SgohHDK9KQ1fbnKF8fZb+IoqC/+CQBb5mfhvDAQak9cwHQ8DFF/jncptcNKBvQNRZEkA==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:656b:9716:1ea:3de6])
 (user=gprocida job=sendgmr) by 2002:a25:3610:: with SMTP id
 d16mr6573081yba.454.1612532563011; Fri, 05 Feb 2021 05:42:43 -0800 (PST)
Date:   Fri,  5 Feb 2021 13:42:19 +0000
In-Reply-To: <20210205134221.2953163-1-gprocida@google.com>
Message-Id: <20210205134221.2953163-4-gprocida@google.com>
Mime-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210205134221.2953163-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH dwarves v3 3/5] btf_encoder: Traverse sections using a for-loop
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     acme@kernel.org, andrii@kernel.org, ast@kernel.org,
        gprocida@google.com, maennich@google.com, kernel-team@android.com,
        kernel-team@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

The pointer (iterator) scn can be made local to the loop and a more
general while-loop is not needed.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/libbtf.c b/libbtf.c
index ace8896..4ae7150 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -700,7 +700,6 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 {
 	GElf_Ehdr ehdr;
 	Elf_Data *btf_data = NULL;
-	Elf_Scn *scn = NULL;
 	Elf *elf = NULL;
 	const void *raw_btf_data;
 	uint32_t raw_btf_size;
@@ -748,7 +747,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 	 */
 
 	elf_getshdrstrndx(elf, &strndx);
-	while ((scn = elf_nextscn(elf, scn)) != NULL) {
+	for (Elf_Scn *scn = elf_nextscn(elf, NULL); scn; scn = elf_nextscn(elf, scn)) {
 		GElf_Shdr shdr;
 		if (!gelf_getshdr(scn, &shdr))
 			continue;
-- 
2.30.0.478.g8a0d178c01-goog

