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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F98C4332E
	for <linux-dwarves@archiver.kernel.org>; Tue, 26 Jan 2021 19:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C44523121
	for <linux-dwarves@archiver.kernel.org>; Tue, 26 Jan 2021 19:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbhAZFnS (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbhAYNJ2 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 25 Jan 2021 08:09:28 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5561DC061797
        for <dwarves@vger.kernel.org>; Mon, 25 Jan 2021 05:06:47 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id o79so3677660wme.9
        for <dwarves@vger.kernel.org>; Mon, 25 Jan 2021 05:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=dHCmE0oVXoubM3rTHyQSPX2MJEXLHemPJUmiQIz1gjE=;
        b=SFOnqGDYvQ3UMYg+Xxq0/jYMkh+nolREupxeeXaZMo7t5sbzBXzhvyD5ZZrXjZHi56
         6yyQt6i+aptZKrd6GbcvAUOhf1M5c5fHGYt0F3jPjGCwknFrb8GBxUbScLTCXjZ/Kjsh
         MG1RbRLYNJ/p1+xjcOOLWENFojsvHpETaL8oUJjGPqL8bz6mNHsJxnZFKh73VkenHEI+
         h0y5yuf8DTlo2A0ODTBssz1IVUjCPI+B/3N0ZbzHwaeDfCfsm0fM2JW1lnZ28ih3JZx2
         Ouyq8rBiyKRIr8wv8RIdeICRhz6gxKtkiQgM3aJ9A/RctlU2CNK1yyVVBjL91Mefzs41
         RZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dHCmE0oVXoubM3rTHyQSPX2MJEXLHemPJUmiQIz1gjE=;
        b=ZrxQ1ln/2zpMU75VHg+aI/zKRgKMghYVahkLZ5K0vBo2lXkFTRN2mKhInfcEoMkyKr
         PuPZflgqOIleVbep4mn0UFMdzBRWsa57/VotOf1QF4PsUI9MaG9CPflAhQpaWiKGmEGQ
         3Nuzw3Xc/KByc0HhDGFwcMfJKYk39sJb6hqPXF/Ll5VW5bW/hsFbKG0lavJzNpZ6cB3r
         FV5yySPmd8SDhEl97RCOcOR4nbazfFmMNxJN8cW8kwR/NAIPhQX4fAeACUr3o0COVUO+
         qs+6oh0iCR/8nkh6dgWo7YInNloiMvGtX7uKNTQgItyhlP3SGaHYOUEIlqxBdWf9FVuR
         Sd6Q==
X-Gm-Message-State: AOAM533QGe4QKnQ9M6LzBo5udoKvvdxkkzKVW9orE6YcqSRR9qkk8+1r
        PSsN/CHEIEA5mddOx7Dmh3PMhB03VA1ZKppbAn7tNXp0DwccXs3PLeSAPjVkW+Zl0S+4pOpP4HN
        HrW7LQwdlJN7SIvuGBltpmvq1ZNIiJkyzwHEfY9c3eF107VLVGsEX7PuNbZTA9QQ07oYK
X-Google-Smtp-Source: ABdhPJwLbiQP/xW54xaHyoWge2cRYZKMzVdicac9X6ZmG5acd/9J8zAyuqNenerL/j1SSHfRzykZLtvkQw3dOA==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:a6ae:11ff:fe11:4f04])
 (user=gprocida job=sendgmr) by 2002:a1c:e0d4:: with SMTP id
 x203mr49589wmg.160.1611580004135; Mon, 25 Jan 2021 05:06:44 -0800 (PST)
Date:   Mon, 25 Jan 2021 13:06:25 +0000
In-Reply-To: <20210125130625.2030186-1-gprocida@google.com>
Message-Id: <20210125130625.2030186-5-gprocida@google.com>
Mime-Version: 1.0
References: <20210125130625.2030186-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH dwarves 4/4] btf_encoder: Align .BTF section to 8 bytes
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
memory-mapping ELF sections.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/libbtf.c b/libbtf.c
index 4726e16..fa00053 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -755,7 +755,13 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 	 * This actually happens in practice with vmlinux which has .strtab
 	 * after .shstrtab, resulting in a (small) hole the size of the original
 	 * .shstrtab.
+	 *
+	 * We'll align .BTF to 8 bytes to cater for all architectures. It'd be
+	 * nice if we could fetch this value from somewhere. The BTF
+	 * specification does not discuss alignment and its trailing string
+	 * table is not currently padded to any particular alignment.
 	 */
+	const size_t btf_alignment = 8;
 
 	/*
 	 * First we look if there was already a .BTF section present and
@@ -848,8 +854,8 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 	elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
 
 	/* Update .BTF section in the SHT */
-	size_t new_btf_offset = high_water_mark;
-	size_t new_btf_size = raw_btf_size;
+	size_t new_btf_offset = roundup(high_water_mark, btf_alignment);
+	size_t new_btf_size = roundup(raw_btf_size, btf_alignment);
 	GElf_Shdr btf_shdr_mem;
 	GElf_Shdr *btf_shdr = gelf_getshdr(btf_scn, &btf_shdr_mem);
 	if (!btf_shdr) {
@@ -857,6 +863,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 			__func__, elf_errmsg(elf_errno()));
 		goto out;
 	}
+	btf_shdr->sh_addralign = btf_alignment;
 	btf_shdr->sh_entsize = 0;
 	btf_shdr->sh_flags = 0;
 	if (dot_btf_offset)
-- 
2.30.0.280.ga3ce27912f-goog

