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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C817C433E0
	for <linux-dwarves@archiver.kernel.org>; Wed, 17 Feb 2021 11:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EE2C64DEC
	for <linux-dwarves@archiver.kernel.org>; Wed, 17 Feb 2021 11:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhBQLJa (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 17 Feb 2021 06:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhBQLJA (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 17 Feb 2021 06:09:00 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B64C06178B
        for <dwarves@vger.kernel.org>; Wed, 17 Feb 2021 03:08:20 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id y18so2086188wma.8
        for <dwarves@vger.kernel.org>; Wed, 17 Feb 2021 03:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=CtyPUVbXhc5CDRZLtdHVem+8lAgiUhAKNAjbcL0rPXE=;
        b=PoCIn0uyIl6lXycffqtFFJqz/msRd6zXJMEsOtAkL16xrfSuU9+ZDpyV+ggWH0OtgA
         XTAw5Ji/YiGGohzvGFcypyRxBytlHzM+oNqHyJsoN9WVPa3JH7nNQIaxy5UJBJczU+Pa
         xg2qksgjRVQIKqxEGacDNN1IyL9/T+xeb424GKaD9Ff8VcL4BW75zZl1GrGxKT7QM4EJ
         fjdrPXG10sqbEwHfvM6cG9XVX1dub0A71yBb5aD/rRKkI4bGaPRJwHxFUaKH0fE7rEgp
         vJf1vNlWSNiKRLN9vIxN9bwU+RPxjt2o5j9zBoLQyctVpwpzFMhsylEINxnR+NQw1NSP
         5nxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CtyPUVbXhc5CDRZLtdHVem+8lAgiUhAKNAjbcL0rPXE=;
        b=JTrxTzr3EYpJ5oyB6u/BtNfp0dUz3LF2qbhZ1iNROABsaBSANpxw+LfhEsqklRmMDi
         YxL/WDTHMFz9VBDeVXThQyFyMzpPXzUP2y2GTI2wapRDz2w69hcqUqlZ2Z42GxK0/j4I
         E7Q/TlsW37iJIlSvHKwzBdpk5J5Bzlx12ZghfHULGt403ml8idsXINDThoWbjKResGyF
         1w0qt0XKKe7djrVYEyJkrEABEP2M5Xek1cdjXOEoVSsC7zp0/ZkPqgnZyqw9sKcP7AsB
         3pb19CopbeoGN/Oxl9qK4lh3WygZyrljvTdcbD0uwP8zB0HvzfnojPfft8i5rLsCWl70
         gxqQ==
X-Gm-Message-State: AOAM532uRAIgZPFCdQhhS/BAyXBU/4Vr61OSNX/sT0OcYxL8dl4dxoph
        aGhs6wOBNN7vVjf9GV0RMnX7UgKwiou0cNhLViDwcAaJe0uqBG6g+DDXOyiUblEgagbfSCEeDGJ
        IvPiP/6K0FlQG8qbovuP6B/g8qUWwtu84NWBtbntBkIHffeGgAPLlhymgwp0zSGbad7eo
X-Google-Smtp-Source: ABdhPJym3p+zIhDoQ+3jBbV+a0GOC2AQpwjftZY+ZDQpPFM7fGDhIg3x/c2hdrCQkQttCGyodvElvcISkRuMUA==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:61b3:1cb2:c180:c3f])
 (user=gprocida job=sendgmr) by 2002:a05:600c:2d44:: with SMTP id
 a4mr6563054wmg.95.1613560098890; Wed, 17 Feb 2021 03:08:18 -0800 (PST)
Date:   Wed, 17 Feb 2021 11:08:01 +0000
In-Reply-To: <20210217110804.75923-1-gprocida@google.com>
Message-Id: <20210217110804.75923-3-gprocida@google.com>
Mime-Version: 1.0
References: <20210205134221.2953163-1-gprocida@google.com> <20210217110804.75923-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH dwarves v4 2/5] btf_encoder: Do not use both structs and
 pointers for the same data
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org, acme@kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, gprocida@google.com,
        maennich@google.com, kernel-team@android.com, kernel-team@fb.com,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Many operations in the libelf API return a pointer to a user-provided
struct (on success) or NULL (on failure).

There are a couple of places in btf_elf__write where both structs and
pointers to the same structs are used. Holding on to the pointers
raises ownership and lifetime issues unnecessarily and the code is
cleaner with only a single access path for these data.

The code now treats the returned pointers as booleans.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/libbtf.c b/libbtf.c
index 7bc49ba..ace8896 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -698,8 +698,7 @@ int32_t btf_elf__add_datasec_type(struct btf_elf *btfe, const char *section_name
 
 static int btf_elf__write(const char *filename, struct btf *btf)
 {
-	GElf_Shdr shdr_mem, *shdr;
-	GElf_Ehdr ehdr_mem, *ehdr;
+	GElf_Ehdr ehdr;
 	Elf_Data *btf_data = NULL;
 	Elf_Scn *scn = NULL;
 	Elf *elf = NULL;
@@ -727,13 +726,12 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 
 	elf_flagelf(elf, ELF_C_SET, ELF_F_DIRTY);
 
-	ehdr = gelf_getehdr(elf, &ehdr_mem);
-	if (ehdr == NULL) {
+	if (!gelf_getehdr(elf, &ehdr)) {
 		elf_error("elf_getehdr failed");
 		goto out;
 	}
 
-	switch (ehdr_mem.e_ident[EI_DATA]) {
+	switch (ehdr.e_ident[EI_DATA]) {
 	case ELFDATA2LSB:
 		btf__set_endianness(btf, BTF_LITTLE_ENDIAN);
 		break;
@@ -751,10 +749,10 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 
 	elf_getshdrstrndx(elf, &strndx);
 	while ((scn = elf_nextscn(elf, scn)) != NULL) {
-		shdr = gelf_getshdr(scn, &shdr_mem);
-		if (shdr == NULL)
+		GElf_Shdr shdr;
+		if (!gelf_getshdr(scn, &shdr))
 			continue;
-		char *secname = elf_strptr(elf, strndx, shdr->sh_name);
+		char *secname = elf_strptr(elf, strndx, shdr.sh_name);
 		if (strcmp(secname, ".BTF") == 0) {
 			btf_data = elf_getdata(scn, btf_data);
 			break;
-- 
2.30.0.478.g8a0d178c01-goog

