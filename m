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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC330C43381
	for <linux-dwarves@archiver.kernel.org>; Fri,  5 Feb 2021 22:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E3EB64FF5
	for <linux-dwarves@archiver.kernel.org>; Fri,  5 Feb 2021 22:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhBEWng (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhBENnU (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 5 Feb 2021 08:43:20 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8601C061356
        for <dwarves@vger.kernel.org>; Fri,  5 Feb 2021 05:42:39 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id c19so5234021qtp.2
        for <dwarves@vger.kernel.org>; Fri, 05 Feb 2021 05:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ex0vuOuT0A88stBA/se/KcPkQGfalK3n6k9EL0PLw04=;
        b=jbN5L4FF0ns0Fu9f3MT0Q9pY9If7HN+erYJFO6t5R8hl2N9ODJ80KRQHotFVQ57R0y
         az7oD86L1IL0Wgo3BxhYoDqMVgGYq05pqfMBIeRu+LzzhvtI3Opdnc/6v7WDkK9GFb1e
         9zCH9pPU8tsIg016I0vp+LLrt74A5np9YzRxB3b8GvMST99MsRP6hxnzc5eqtznVHXEG
         0MQvU2zgnETJV4ht264THFpeM0Ah0CZpEvttR/0VgQyFgJJJQ+RqmGY+8FrSUg1W5g3f
         9uChM7Jz22zHhSI5hU7ObY5VZgEmbCr0fn8SxhTu3MzUdKZnTGoCexGjPZ8A5FCQBosX
         3Duw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ex0vuOuT0A88stBA/se/KcPkQGfalK3n6k9EL0PLw04=;
        b=QHvThTbimynEzxUXVm/qtox6MDaPA02lk8NNlhEkwwquY62X/rbI4YRDixyChrlwoV
         aspykkw24BqcQJjIeetxWsyil42fPduUGfgPJWUkoTrCNUXjOJl0aF57Zk5BO0RM88jy
         fA9R1y+5O8gFG1rh5DEMmDcRSHAacmPKodkF91VWdgorNGn9LKlp8HV5/MaBSh/mRC98
         YWQVNzKgFXL64z5a2ZKwBX4CBG2e+XI/VDlOioAC4fmnyvXvly5pg/A1wWLEIXlYeZ6K
         VkpeYN+5ASUxEB8nsX96EWoaygBsxRyIGs7uYzlDoTyNj5MK30lolJxcjrKFblDukUma
         tJ8w==
X-Gm-Message-State: AOAM533MklPUSBEyJboVLlioI4Nz0hSngwb6koJNJQIu245yjaPaKRKx
        wI0I+495W7MdMlWppy3E0UantQ2NsoNDHwmCAhTFrPk8BvdMtCerdYcFlhuI6VQCBKB/CiSUsIC
        VRcOhbRj2JYICDhSVdfyb539Omq4NHJr+s8ynb1mVgzdblzDEHib7e0a+v/CHH3bqE0b+
X-Google-Smtp-Source: ABdhPJyedtu2hOD+NDzfyRsR16vbD8etc3H9cWiVxAdaB43HGxmS5EukGG6WB+TDjaPii7ElTsri9d9dNuEsyg==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:656b:9716:1ea:3de6])
 (user=gprocida job=sendgmr) by 2002:a05:6214:1144:: with SMTP id
 b4mr4269505qvt.12.1612532558809; Fri, 05 Feb 2021 05:42:38 -0800 (PST)
Date:   Fri,  5 Feb 2021 13:42:17 +0000
In-Reply-To: <20210205134221.2953163-1-gprocida@google.com>
Message-Id: <20210205134221.2953163-2-gprocida@google.com>
Mime-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210205134221.2953163-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH dwarves v3 1/5] btf_encoder: Funnel ELF error reporting
 through a macro
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     acme@kernel.org, andrii@kernel.org, ast@kernel.org,
        gprocida@google.com, maennich@google.com, kernel-team@android.com,
        kernel-team@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

This adds elf_error which prepends error messages with the function
and appends a readable ELF error status.

Also capitalise ELF consistently in error messages.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/libbtf.c b/libbtf.c
index 9f76283..7bc49ba 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -27,6 +27,16 @@
 #include "dwarves.h"
 #include "elf_symtab.h"
 
+/*
+ * This depends on the GNU extension to eliminate the stray comma in the zero
+ * arguments case.
+ *
+ * The difference between elf_errmsg(-1) and elf_errmsg(elf_errno()) is that the
+ * latter clears the current error.
+ */
+#define elf_error(fmt, ...) \
+	fprintf(stderr, "%s: " fmt ": %s.\n", __func__, ##__VA_ARGS__, elf_errmsg(-1))
+
 struct btf *base_btf;
 uint8_t btf_elf__verbose;
 uint8_t btf_elf__force;
@@ -103,15 +113,13 @@ try_as_raw_btf:
 			goto errout;
 
 		if (elf_version(EV_CURRENT) == EV_NONE) {
-			fprintf(stderr, "%s: cannot set libelf version.\n",
-				__func__);
+			elf_error("cannot set libelf version");
 			goto errout;
 		}
 
 		btfe->elf = elf_begin(btfe->in_fd, ELF_C_READ_MMAP, NULL);
 		if (!btfe->elf) {
-			fprintf(stderr, "%s: cannot read %s ELF file: %s.\n",
-				__func__, filename, elf_errmsg(elf_errno()));
+			elf_error("cannot read %s ELF file", filename);
 			goto errout;
 		}
 	}
@@ -127,7 +135,7 @@ try_as_raw_btf:
 			goto try_as_raw_btf;
 		}
 		if (btf_elf__verbose)
-			fprintf(stderr, "%s: cannot get elf header.\n", __func__);
+			elf_error("cannot get ELF header");
 		goto errout;
 	}
 
@@ -141,7 +149,7 @@ try_as_raw_btf:
 		btf__set_endianness(btfe->btf, BTF_BIG_ENDIAN);
 		break;
 	default:
-		fprintf(stderr, "%s: unknown elf endianness.\n", __func__);
+		fprintf(stderr, "%s: unknown ELF endianness.\n", __func__);
 		goto errout;
 	}
 
@@ -707,15 +715,13 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 	}
 
 	if (elf_version(EV_CURRENT) == EV_NONE) {
-		fprintf(stderr, "Cannot set libelf version: %s.\n",
-			elf_errmsg(elf_errno()));
+		elf_error("Cannot set libelf version");
 		goto out;
 	}
 
 	elf = elf_begin(fd, ELF_C_RDWR, NULL);
 	if (elf == NULL) {
-		fprintf(stderr, "Cannot update ELF file: %s.\n",
-			elf_errmsg(elf_errno()));
+		elf_error("Cannot update ELF file");
 		goto out;
 	}
 
@@ -723,8 +729,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 
 	ehdr = gelf_getehdr(elf, &ehdr_mem);
 	if (ehdr == NULL) {
-		fprintf(stderr, "%s: elf_getehdr failed: %s.\n", __func__,
-			elf_errmsg(elf_errno()));
+		elf_error("elf_getehdr failed");
 		goto out;
 	}
 
@@ -736,7 +741,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 		btf__set_endianness(btf, BTF_BIG_ENDIAN);
 		break;
 	default:
-		fprintf(stderr, "%s: unknown elf endianness.\n", __func__);
+		fprintf(stderr, "%s: unknown ELF endianness.\n", __func__);
 		goto out;
 	}
 
@@ -768,8 +773,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 		    elf_update(elf, ELF_C_WRITE) >= 0)
 			err = 0;
 		else
-			fprintf(stderr, "%s: elf_update failed: %s.\n",
-				__func__, elf_errmsg(elf_errno()));
+			elf_error("elf_update failed");
 	} else {
 		const char *llvm_objcopy;
 		char tmp_fn[PATH_MAX];
-- 
2.30.0.478.g8a0d178c01-goog

