Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA7AC433EF
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Apr 2022 14:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388698AbiDUOuR (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 21 Apr 2022 10:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389464AbiDUOuO (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 21 Apr 2022 10:50:14 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BE442A32
        for <dwarves@vger.kernel.org>; Thu, 21 Apr 2022 07:47:23 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 88-20020a9d0ee1000000b005d0ae4e126fso3422073otj.5
        for <dwarves@vger.kernel.org>; Thu, 21 Apr 2022 07:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BMrwL2aDnkSZ1lEVy3K1SWMpX4fW+Zlq1nfILcQgOTU=;
        b=XJGm7+XyWvjiONbFQ8+eejCB9/DAK+Oh7VNa7YNkbxhkqNQwWxdx6Agnu/JGZl9VvS
         Ha3PAXDmS3mgWoZKd1gqTtZT+1HVOr6gLsVAOnrnMdpKS19Su8HgNxyu+7jAnrmlCjtS
         5FMYYYUWM3ei6m+rVDMkPPyHX0NbGcOL6TASKieoEHksE1+Mi69Uhyg8SeDqymX0Nhlc
         0usg9TcfWZu6K4fi9nkvaTBirF00viV8O9MuHz6YzwnXu8wMfa4okKYNLtp0hTqWzEVU
         essNuoarNbYEsni7t3qfYGe3H8MSm+O4ZPu/CwtGrD0H1CLiUpJ9FjtnPBnFQ/j977wj
         qXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BMrwL2aDnkSZ1lEVy3K1SWMpX4fW+Zlq1nfILcQgOTU=;
        b=3vy9avkmsnxF5TchnWZjdQrb2MRKarS/zmzfKZrJJ59XoAM12wJKv/TpmSCSO1kSfc
         Bl3YvPliyNpcnOqOSxe4xRuYX/UBmqqcclvxAoBQUPTjs5RkGuuVgfY4pGSM1m+GCx/H
         ymgzXXWpMyb2SY87lbsS7Ba8aqhUsr86L4brdsgrlJZsLcAloZ/rhQn420V2FS5HadVa
         5FKc7AFjy/qifJLLIntLGqCk27wyFX/34ZD/5LAeeMVR5p/cPcSYKm/rL9rNpmq/IfRC
         /DO4x3BPURneSelk/2ChpTf/bz6cEiAwyYXM066RjqbGX9yEgKI6Hre3LopS4FrZfBV8
         5IlA==
X-Gm-Message-State: AOAM530aTooi77sgPNbZrKGuUKkLyZM9EGeb0877uFZHVGESZGJgdue6
        25SCKR5J4Hsu8/8EqODoBiEmns2N+qqqvw==
X-Google-Smtp-Source: ABdhPJy11rnFkhQIHF98PrX1VjWB/RI3nRGNtZcZ6CM/1oVjZbXnQDFsaW6vjDdnsnyckXulb/fyrQ==
X-Received: by 2002:a9d:7447:0:b0:605:465c:115e with SMTP id p7-20020a9d7447000000b00605465c115emr22178otk.345.1650552442982;
        Thu, 21 Apr 2022 07:47:22 -0700 (PDT)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id q13-20020a4ab3cd000000b0032830efe365sm7853543ooo.43.2022.04.21.07.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:47:22 -0700 (PDT)
From:   Martin Reboredo <yakoyoku@gmail.com>
To:     arnaldo.melo@gmail.com, dwarves@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net
Subject: [PATCH] pahole: Implement cu_exclude_lang flag
Date:   Thu, 21 Apr 2022 11:47:15 -0300
Message-Id: <20220421144715.8154-1-yakoyoku@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Exclude compilation units that have the language id equal to the one
from the --cu_exclude_lang=LANG flag.

Required by Rust Linux builds due to failing BTF checks product of
things like rustc's struct reordering.

Signed-off-by: Martin Reboredo <yakoyoku@gmail.com>
Tested-by: Martin Reboredo <yakoyoku@gmail.com>
---
 dwarves.h | 18 ++++++++++++++++++
 pahole.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/dwarves.h b/dwarves.h
index 456b037..9d57a4f 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -204,6 +204,24 @@ enum dwarf_languages {
     LANG_ObjC_plus_plus	= 0x11,	/* Objective-C++ */
     LANG_UPC		= 0x12,	/* Unified Parallel C */
     LANG_D		= 0x13,	/* D */
+    LANG_Python	= 0x14,	/* Python */
+    LANG_OpenCL	= 0x15,	/* OpenCL */
+    LANG_Go	= 0x16,	/* Go */
+    LANG_Modula3	= 0x17,	/* Modula-3 */
+    LANG_Haskell	= 0x18,	/* Haskell */
+    LANG_C_plus_plus_03	= 0x19, /* ISO C++:2003 */
+    LANG_C_plus_plus_11	= 0x1a, /* ISO C++:2011 */
+    LANG_OCaml	= 0x1b,	/* OCaml */
+    LANG_Rust	= 0x1c,	/* Rust */
+    LANG_C11	= 0x1d,	/* ISO C:2011 */
+    LANG_Swift	= 0x1e,	/* Swift */
+    LANG_Julia	= 0x1f,	/* Julia */
+    LANG_Dylan	= 0x20,	/* Dylan */
+    LANG_C_plus_plus_14	= 0x21, /* ISO C++:2014 */
+    LANG_Fortran03	= 0x22,	/* ISO/IEC 1539-1:2004 */
+    LANG_Fortran08	= 0x23,	/* ISO/IEC 1539-1:2010 */
+    LANG_RenderScript	= 0x24, /* RenderScript Kernal Language */
+    LANG_BLISS	= 0x25,	/* BLISS */
 };
 
 /** struct debug_fmt_ops - specific to the underlying debug file format
diff --git a/pahole.c b/pahole.c
index a909b22..1c961fb 100644
--- a/pahole.c
+++ b/pahole.c
@@ -57,6 +57,8 @@ static size_t class__include_prefix_len;
 static char *cu__exclude_prefix;
 static size_t cu__exclude_prefix_len;
 
+static uint32_t cu__exclude_lang;
+
 static char *decl_exclude_prefix;
 static size_t decl_exclude_prefix_len;
 
@@ -615,6 +617,10 @@ static struct cu *cu__filter(struct cu *cu)
 		     cu__exclude_prefix_len) == 0))
 		return NULL;
 
+  if (cu__exclude_lang != 0 &&
+	    cu__exclude_lang == cu->language)
+		return NULL;
+
 	return cu;
 }
 
@@ -988,6 +994,39 @@ static void cu__account_nr_methods(struct cu *cu)
 	}
 }
 
+static const struct {
+  const char *name;
+  uint32_t id;
+} language_table[] = {
+	{ "C", LANG_C },
+	{ "C89", LANG_C89 },
+	{ "C99", LANG_C99 },
+	{ "C11", LANG_C11 },
+	{ "C++", LANG_C_plus_plus },
+	{ "C++03", LANG_C_plus_plus_03 },
+	{ "C++11", LANG_C_plus_plus_11 },
+	{ "C++14", LANG_C_plus_plus_14 },
+	{ "Fortran77", LANG_Fortran77 },
+	{ "Fortran90", LANG_Fortran90 },
+	{ "Fortran95", LANG_Fortran95 },
+	{ "Fortran03", LANG_Fortran03 },
+	{ "Fortran08", LANG_Fortran08 },
+	{ "Go", LANG_Go },
+	{ "Haskell", LANG_Haskell },
+	{ "Rust", LANG_Rust },
+	{ NULL, 0 },
+};
+
+static uint32_t language_id(const char *lang) {
+	for (int l = 0; language_table[l].name; l++) {
+		if (strcmp(lang, language_table[l].name) == 0) {
+			return language_table[l].id;
+		}
+	}
+
+	return 0;
+}
+
 static char tab[128];
 
 static void print_structs_with_pointer_to(struct cu *cu, uint32_t type)
@@ -1137,6 +1176,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_skip_missing          332
 #define ARGP_skip_encoding_btf_type_tag 333
 #define ARGP_compile		   334
+#define ARGP_exclude_lang	   335
 
 static const struct argp_option pahole__options[] = {
 	{
@@ -1512,6 +1552,12 @@ static const struct argp_option pahole__options[] = {
 		.key  = ARGP_devel_stats,
 		.doc  = "Print internal data structures stats",
 	},
+	{
+		.name = "cu_exclude_lang",
+		.key  = ARGP_exclude_lang,
+		.arg  = "LANG",
+		.doc  = "exclude LANGuage compilation units",
+	},
 	{
 		.name = "skip_encoding_btf_decl_tag",
 		.key  = ARGP_skip_encoding_btf_decl_tag,
@@ -1681,6 +1727,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf_load.hashtable_bits = atoi(arg);	break;
 	case ARGP_devel_stats:
 		conf_load.ptr_table_stats = true;	break;
+	case ARGP_exclude_lang:
+		cu__exclude_lang = language_id(arg);	break;
 	case ARGP_skip_encoding_btf_decl_tag:
 		conf_load.skip_encoding_btf_decl_tag = true;	break;
 	case ARGP_skip_missing:
-- 
2.36.0

