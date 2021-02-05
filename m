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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48E1C4332B
	for <linux-dwarves@archiver.kernel.org>; Fri,  5 Feb 2021 22:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B058264FF8
	for <linux-dwarves@archiver.kernel.org>; Fri,  5 Feb 2021 22:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhBEWno (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbhBENnW (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 5 Feb 2021 08:43:22 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A599AC06121D
        for <dwarves@vger.kernel.org>; Fri,  5 Feb 2021 05:42:41 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id a75so5794427qkg.16
        for <dwarves@vger.kernel.org>; Fri, 05 Feb 2021 05:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Jm9Rl/O23yAE3HZ62rmeV5YrYLNhsE5EvtDbKOWTIow=;
        b=ITUIwpQ8q9tGG4CIbJ0ci2ur/ZJSsEfgdPWAsLObON4aNaUKWMRH5VuROapZFGrYus
         5fa4bI8iLDZEm6l3nYLFzlHxdrDFx1EUQaNjXPKHot4OYnaoGLNYA1h6JiSpo7jIlsRk
         9kGukaEg//ID1Nn1O0irdtWgsIy+PqYgGTCvcp4DYU/jZ0z6ALvjbt6mBliklwtDJrP9
         2bdtZhULisqdwWNw2HrnTW6zNKNpRYi/LKfkYQ2eH5/6iRYGGXS+nw4oYVROKHHzq8+u
         GBJ+Wo6dJDdLsur/AV9T2DNq+iNqolHUVKv3hNLa9huQZxg88b2FUgzoTsihgXyKgR04
         HXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Jm9Rl/O23yAE3HZ62rmeV5YrYLNhsE5EvtDbKOWTIow=;
        b=pWCuty0I14xygb0D4ChDkk4YB8GqasJ3oLh4UNXx6xZ7EoM/UQOM8cpVOA9KizK/y2
         rKPCbeZef3i1O/1SbfjuMnlqBIwv1cHh5EN0LdryDBAe3HYMRI2IqI2EeeXB+Azp3jpm
         zUjTfskbay2hqmXxYyIZUDX/ZJAvkj5VvAEr8VedH28Gzx9gXUyLNrF3Y+mDu4T+78xo
         /oA7cNCFzbyaLEgcUJK+gace8lw+lAUUOblUADvYUHhv5Ck0CndPqOXAXYS0PhFQLkgX
         nC1jjFW6UaHD4jnXn4WK4i/+ZaVy3TOILyTIvJNQbQD567+sVPZaQJKO0TgpfdExeSOh
         KVyA==
X-Gm-Message-State: AOAM533ERWgEcqkqt12HdRIGT9rG7UFW+If5w/fZhfX5PABiQdc9a45j
        W6tth6GZhSGYoXSKmIg/V2a9aKAzAHpw93EXcsK85qZqrcykMNtgaGFpcYxNmyEvneyLqyVElI6
        Zq5WesCJqCQWFCd0wHow/wsQrijLyKYugOZoVlK43UEKg13XqawXF/hLhdyGp9tfPyK9W
X-Google-Smtp-Source: ABdhPJzIz42Mwp/Z6N9/StY2UCNjQr9VPyc9b4cxNS9Y9mkf9ti9vhjfcwqC/1Op+ISWE/P5kp6cce7rWt8WIw==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:656b:9716:1ea:3de6])
 (user=gprocida job=sendgmr) by 2002:a05:6214:906:: with SMTP id
 dj6mr4375856qvb.28.1612532560829; Fri, 05 Feb 2021 05:42:40 -0800 (PST)
Date:   Fri,  5 Feb 2021 13:42:18 +0000
In-Reply-To: <20210205134221.2953163-1-gprocida@google.com>
Message-Id: <20210205134221.2953163-3-gprocida@google.com>
Mime-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210205134221.2953163-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH dwarves v3 2/5] btf_encoder: Do not use both structs and
 pointers for the same data
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     acme@kernel.org, andrii@kernel.org, ast@kernel.org,
        gprocida@google.com, maennich@google.com, kernel-team@android.com,
        kernel-team@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Many operations in the libelf API return a pointer to a user-provided
struct (on success) or NULL (on failure).

There are a couple of places in btf_elf__write where both structs and
pointers to the same structs are used. Holding on to the pointers
raises ownership and lifetime issues unncessarily and the code is
cleaner with only a single access path for these data.

The code now treats the returned pointers as booleans.

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

