Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F45C4332F
	for <linux-dwarves@archiver.kernel.org>; Tue, 22 Nov 2022 00:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiKVAA1 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 21 Nov 2022 19:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiKVAA0 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 21 Nov 2022 19:00:26 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9D760DE
        for <dwarves@vger.kernel.org>; Mon, 21 Nov 2022 16:00:25 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d18-20020a170902f15200b001890fdda8a5so5342041plb.4
        for <dwarves@vger.kernel.org>; Mon, 21 Nov 2022 16:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YxQ6EnBfyddd0H6ZDfJqrFmnCriE05hnp9qFFrRqdWw=;
        b=sJ8BD1nwy3D2d1HdQ7QAcRlwsmjU2xLPojrtpbCHck8v/QlQloNoAETeumBEOeZfJo
         bvfJeKDua6udRsAVcVPyam67TH6hOqA/KAjjJZEz26eWb1QBjg+PKjKh94D7UTyTqbEV
         QUZNptd3KC5gis19uw885aHse9uuNiEKIrN58T3vLQQ0SY0zHg9kZIy9lWk7JzJS9a3h
         VWk9//rpUs5syVxwdxpTuto7KPjnjhHL6+hDDtSGA5Ubc92i7gFRH0k/VkVK4+OZ7eOa
         PP7gmSW34b7mL46D8SE3pGY70U5iurD4sdo5yLWwYoCsT6hlm3cMNEWx7x/5QQrJQCN6
         bzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YxQ6EnBfyddd0H6ZDfJqrFmnCriE05hnp9qFFrRqdWw=;
        b=vOjoKdtZMZo9QQ1ohpwgosL/fCcifzJZUrdsXBiQbGmOnYQGI/7736ytsuLasUkD+W
         lWkilm/p+uUH2u7Fmj1dtP0/PWRCOIKjj47Hw+rEsbyoAtU2GshMlZtcxIMRIJFI7514
         iISUlqJX396v1Vwfd552krkn4wsbYQeQQ4qS2ng9fdnB7I1bJZYNf8uc41pJ1aNMQ9JB
         e/Jf7FEHRFh6bCxq0hOCxPFnmS97/DBtQQl2gGJNBHpcaTJNTVtIYQ0Aw4IMpkO4coCV
         3T9FKmlcOpYey0XluLGzHYFfNMS1qNiBByEHZ4ccdgjm5lnQ5H4IwugjgaWcgyzKCcYm
         Hm0A==
X-Gm-Message-State: ANoB5plg/LpCg7pC3IGXROlR3KdKSkUx4cY4rc09iYKhVcfNTsd0NyzF
        VNCygiQfpIRIGqwlELknXERyUloMFNJSuJnCWfcCwYHPv++8SwnnmBIp6WNOLw4IblRL4IXtwHc
        xoSWEAkU8PTxLktQONQOeln16ylizmjkqxfBnGHF7nVJgPYtn3MIwp8tso30=
X-Google-Smtp-Source: AA0mqf79MdrNdVuC5p810Hw9QIAO5en8qxAUOf/SrF4q1q2DA2P2HFUz4+95fgKdg9fvPdJn/RlVJHFNUw==
X-Received: from fawn.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5795])
 (user=morbo job=sendgmr) by 2002:a17:902:e1cb:b0:189:6f3:63dd with SMTP id
 t11-20020a170902e1cb00b0018906f363ddmr1543603pla.168.1669075225131; Mon, 21
 Nov 2022 16:00:25 -0800 (PST)
Date:   Tue, 22 Nov 2022 00:00:11 +0000
In-Reply-To: <20221122000011.241697-1-morbo@google.com>
Mime-Version: 1.0
References: <20221122000011.241697-1-morbo@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221122000011.241697-2-morbo@google.com>
Subject: [PATCH 1/1] btf_encoder: Generate a new .BTF section even if one exists
From:   Bill Wendling <morbo@google.com>
To:     dwarves@vger.kernel.org
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

LLD generates a zero-length .BTF section (BFD doesn't generate this
section). It shares the same address as .BTF_ids (or any section below
it). E.g.:

  [24] .BTF              PROGBITS        ffffffff825a1900 17a1900 000000
  [25] .BTF_ids          PROGBITS        ffffffff825a1900 17a1900 000634

Writing new data to that section doesn't adjust the addresses of
following sections. As a result, the "-J" flag produces a corrupted
file, causing further commands to fail.

Instead of trying to adjust everything, just add a new section with the
.BTF data and adjust the name of the original .BTF section. (We can't
remove the old .BTF section because it has variables that are referenced
elsewhere.)

Link: https://lore.kernel.org/dwarves/20210317232657.mdnsuoqx6nbddjgt@google.com/
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Fangrui Song <maskray@google.com>
Cc: dwarves@vger.kernel.org
Signed-off-by: Bill Wendling <morbo@google.com>
---
 btf_encoder.c | 88 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 34 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index a5fa04a84ee2..bd1ce63e992c 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1039,6 +1039,9 @@ static int btf_encoder__write_elf(struct btf_encoder *encoder)
 	Elf_Data *btf_data = NULL;
 	Elf_Scn *scn = NULL;
 	Elf *elf = NULL;
+	const char *llvm_objcopy;
+	char tmp_fn[PATH_MAX];
+	char cmd[PATH_MAX * 2];
 	const void *raw_btf_data;
 	uint32_t raw_btf_size;
 	int fd, err = -1;
@@ -1081,42 +1084,58 @@ static int btf_encoder__write_elf(struct btf_encoder *encoder)
 
 	raw_btf_data = btf__raw_data(btf, &raw_btf_size);
 
+	llvm_objcopy = getenv("LLVM_OBJCOPY");
+	if (!llvm_objcopy)
+		llvm_objcopy = "llvm-objcopy";
+
+	/* Use objcopy to add a .BTF section */
+	snprintf(tmp_fn, sizeof(tmp_fn), "%s.btf", filename);
+	close(fd);
+	fd = creat(tmp_fn, S_IRUSR | S_IWUSR);
+	if (fd == -1) {
+		fprintf(stderr, "%s: open(%s) failed!\n", __func__,
+			tmp_fn);
+		goto out;
+	}
+
+	if (write(fd, raw_btf_data, raw_btf_size) != raw_btf_size) {
+		fprintf(stderr, "%s: write of %d bytes to '%s' failed: %d!\n",
+			__func__, raw_btf_size, tmp_fn, errno);
+		goto unlink;
+	}
+
 	if (btf_data) {
-		/* Existing .BTF section found */
-		btf_data->d_buf = (void *)raw_btf_data;
-		btf_data->d_size = raw_btf_size;
-		elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
-
-		if (elf_update(elf, ELF_C_NULL) >= 0 &&
-		    elf_update(elf, ELF_C_WRITE) >= 0)
-			err = 0;
-		else
-			elf_error("elf_update failed");
-	} else {
-		const char *llvm_objcopy;
-		char tmp_fn[PATH_MAX];
-		char cmd[PATH_MAX * 2];
-
-		llvm_objcopy = getenv("LLVM_OBJCOPY");
-		if (!llvm_objcopy)
-			llvm_objcopy = "llvm-objcopy";
-
-		/* Use objcopy to add a .BTF section */
-		snprintf(tmp_fn, sizeof(tmp_fn), "%s.btf", filename);
-		close(fd);
-		fd = creat(tmp_fn, S_IRUSR | S_IWUSR);
-		if (fd == -1) {
-			fprintf(stderr, "%s: open(%s) failed!\n", __func__,
-				tmp_fn);
-			goto out;
-		}
-
-		if (write(fd, raw_btf_data, raw_btf_size) != raw_btf_size) {
-			fprintf(stderr, "%s: write of %d bytes to '%s' failed: %d!\n",
-				__func__, raw_btf_size, tmp_fn, errno);
+		/*
+		 * Existing .BTF section found. LLD creates a zero-sized .BTF
+		 * section. Adding data to that section doesn't change the
+		 * addresses of the other sections, causing an overwriting of
+		 * data. These commands are a bit convoluted, but they will add
+		 * a new .BTF section with the proper size. Note though that
+		 * the __start_btf and __stop_btf variables aren't affected by
+		 * this change, but then they aren't added when using
+		 * "--add-section" either.
+		 */
+		snprintf(cmd, sizeof(cmd),
+			 "%s --add-section .BTF.new=%s "
+			 "--rename-section .BTF=.BTF.old %s",
+			 llvm_objcopy, tmp_fn, filename);
+		if (system(cmd)) {
+			fprintf(stderr, "%s: failed to add .BTF section to '%s': %d!\n",
+				__func__, filename, errno);
 			goto unlink;
 		}
 
+		snprintf(cmd, sizeof(cmd),
+			 "%s --rename-section .BTF.new=.BTF %s",
+			 llvm_objcopy, filename);
+		if (system(cmd)) {
+			fprintf(stderr, "%s: failed to rename .BTF section to '%s': %d!\n",
+				__func__, filename, errno);
+			goto unlink;
+		}
+
+		err = 0;
+	} else {
 		snprintf(cmd, sizeof(cmd), "%s --add-section .BTF=%s %s",
 			 llvm_objcopy, tmp_fn, filename);
 		if (system(cmd)) {
@@ -1126,10 +1145,11 @@ static int btf_encoder__write_elf(struct btf_encoder *encoder)
 		}
 
 		err = 0;
-	unlink:
-		unlink(tmp_fn);
 	}
 
+unlink:
+	unlink(tmp_fn);
+
 out:
 	if (fd != -1)
 		close(fd);
-- 
2.38.1.584.g0f3c55d4c2-goog

