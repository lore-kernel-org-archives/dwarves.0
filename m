Return-Path: <SRS0=a5OZ=EB=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0013C4363A
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 22:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B5CF20878
	for <linux-dwarves@archiver.kernel.org>; Mon, 26 Oct 2020 22:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DN9kQFY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392812AbgJZWS2 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 26 Oct 2020 18:18:28 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:54263 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392619AbgJZWS2 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 26 Oct 2020 18:18:28 -0400
Received: by mail-pl1-f202.google.com with SMTP id c4so6935828pll.20
        for <dwarves@vger.kernel.org>; Mon, 26 Oct 2020 15:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Bf+WO1TAsV2HZxGdXF8a8oAKOTovVn61Ori8bgHycsc=;
        b=DN9kQFY9wBa8UGO7zVjPxkG8dXP4E3LASRpdk0Max3yl/XmGxLZagn3QRbfzSgcURv
         0TNMTaGH6us1InThp2YrLnLSebl1JEEaQCEW9dpPMmaQmWoHjNqfSZQ+idZdoWMACQdE
         blHBTqFfxHv9BNHQo1/zsh3m4hacg5qvKqcQmkNnEwBKAK63KULObitQZs7qPgvof6+E
         1Ze6N+aaAulW4NNEu6t+VDs1uppzMkmKXi/DdZNWGoNEE7/9il2E0FJti+bPWlnFFH6H
         MK6iMLw3DFsm7QAAQQuq+zPetUdLlFTPaoZwTdC8i+14HdkeacPcPeZujJo8r11Ky86j
         BS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Bf+WO1TAsV2HZxGdXF8a8oAKOTovVn61Ori8bgHycsc=;
        b=oohQuJ1TiBpf+kng8Ro7PKOJtM6FMuxD4KryoyBrsA9VLjWidiNsGj3xHIjabCIG6h
         Go/MRTzfl/L2/3WKNHZmC6AG+uX+ZB9WogrEtFl1msHO2bQ42TUj9MnjsNreRqHgrVZ2
         UfEclbY4SIwhLtvGPQsrkhQExVgkWLbNyZUV622Gc3P/qyUtrjT0CpYN/DE2gbjsdT6q
         wuGu17jA4a5S30K0Yqw5MJjPxcFia8hq8zlMhCIGGfTBQ6SOvlEU/Dw5zq5e3+gZeUnj
         BFzqFLdQYQE3vly5B+yCF1NDBnCQhEteDtiBykHG0csMGsyAyuO+q+R42vNDStQRmZSB
         MElQ==
X-Gm-Message-State: AOAM533UF99FOTYD1I5E691aQRHXT5vFhaLCc5O3sDDJVJJMXQSujVKP
        X72J5/jU6rodjmP/vtg31RLKgi/5Mtk=
X-Google-Smtp-Source: ABdhPJxKV1eLIaZx5zYK3F0yk/QMjnaWxTTTKapKlniF24tKJFdiXOYM4C5kFIDDEdnwPRjFWf2Rt82WWpA=
Sender: "haoluo via sendgmr" <haoluo@haoluo.svl.corp.google.com>
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:f693:9fff:fef4:e444])
 (user=haoluo job=sendgmr) by 2002:a62:1ace:0:b029:163:9dce:5496 with SMTP id
 a197-20020a621ace0000b02901639dce5496mr7589463pfa.72.1603750705921; Mon, 26
 Oct 2020 15:18:25 -0700 (PDT)
Date:   Mon, 26 Oct 2020 15:18:22 -0700
Message-Id: <20201026221822.29021-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH] btf_encoder: Check var type after checking var addr.
From:   Hao Luo <haoluo@google.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Commit 2e719cc ("btf_encoder: revamp how per-CPU variables are
encoded") adds percpu_var_exists() to filter out the symbols that
are not percpu var. However, the check comes after checking the
var's type. There can be symbols that are of zero type. If we hit
that, btf_encoder will not work without '--btf_encode_force'.
So we should check percpu_var_exists before checking var's type.

Tested:
 haoluo@haoluo:~/kernel/tip$ gcc --version
 gcc (GCC) 10.2.0
 Copyright (C) 2020 Free Software Foundation, Inc.
 This is free software; see the source for copying conditions.  There is NO
 warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

 Before:

 haoluo@haoluo:~/kernel/tip$ make clean -s
 haoluo@haoluo:~/kernel/tip$ make -j 32 -s
   LINK     resolve_btfids
 error: found variable in CU 'kernel/bpf/btf.c' that has void type
 Encountered error while encoding BTF.
 FAILED: load BTF from vmlinux: Unknown error -2make: *** [Makefile:1164: vmlinux] Error 255

 After:

 haoluo@haoluo:~/kernel/tip$ make clean -s
 haoluo@haoluo:~/kernel/tip$ make -j 32 -s
   LINK     resolve_btfids
 haoluo@haoluo:~/kernel/tip$

Fixes: 2e719cc ("btf_encoder: revamp how per-CPU variables are encoded")
Signed-off-by: Hao Luo <haoluo@google.com>
---
 btf_encoder.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 2a6455b..b5f8f3e 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -441,9 +441,12 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 		if (var->spec)
 			var = var->spec;
 
+		if (!percpu_var_exists(addr, &size, &name))
+			continue; /* not a per-CPU variable */
+
 		if (var->ip.tag.type == 0) {
-			fprintf(stderr, "error: found variable in CU '%s' that has void type\n",
-				cu->name);
+			fprintf(stderr, "error: found variable '%s' in CU '%s' that has void type\n",
+				name, cu->name);
 			if (force)
 				continue;
 			err = -1;
@@ -452,8 +455,6 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
 
 		type = var->ip.tag.type + type_id_off;
 		linkage = var->external ? BTF_VAR_GLOBAL_ALLOCATED : BTF_VAR_STATIC;
-		if (!percpu_var_exists(addr, &size, &name))
-			continue; /* not a per-CPU variable */
 
 		if (btf_elf__verbose) {
 			printf("Variable '%s' from CU '%s' at address 0x%lx encoded\n",
-- 
2.29.0.rc1.297.gfa9743e501-goog

