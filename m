Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AF7C433FE
	for <linux-dwarves@archiver.kernel.org>; Thu, 29 Sep 2022 12:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbiI2Mu7 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 29 Sep 2022 08:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbiI2Mu5 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 29 Sep 2022 08:50:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F726E8B6
        for <dwarves@vger.kernel.org>; Thu, 29 Sep 2022 05:50:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E29A261143
        for <dwarves@vger.kernel.org>; Thu, 29 Sep 2022 12:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B094C433D7;
        Thu, 29 Sep 2022 12:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664455855;
        bh=YkdJW6sGl3/yyp90fxqW9ewgXvihPXB7u6pEj+dLOTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=poyAygyTNDt5F7Wrh7OcuUJ5J9gaPZsFIlzCVvFjLHYuTAQJtBE0anT98vOwccXY9
         0W3G0fxGODuatK5uTahrjz4GlTzu2yjcqiAAIYut9spLP1FbvEZmm77IDxPFGs14Lm
         RdrbZdZ7wnqc9JUoD+unOEE2KfvRwLiOxmQK/bjWzVtGVUcjhxqdqaa65svGvpQOBt
         e9hHGF0x1pLSMjv9ErsGdqzOpdk9uwCO1L2ijA6FtxPPd2n9UyNjCO1JyDJKiJ5G6m
         eVEYFIf3UxZkqhZdo3JsB7/TzZTweB7tVHh7bTfKzbyn1rSp+XhE9gMZLcwJqkHMvA
         7itX86bN9pkSg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2649D405F0; Thu, 29 Sep 2022 09:50:52 -0300 (-03)
Date:   Thu, 29 Sep 2022 09:50:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>, Yonghong Song <yhs@fb.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        dwarves@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: BTF: A fix and more work to do :Re: die__process_unit:
 DW_TAG_label (0xa) @ <0x7b> not handled!
Message-ID: <YzWUrGNyTo1G2IFP@kernel.org>
References: <YzNHYoI4EZOQdCQ0@dev-arch.thelio-3990X>
 <YzNKEhM+H/X0xUK3@kernel.org>
 <YzNWBxJTKDRBNNDa@dev-arch.thelio-3990X>
 <YzRPXVUfjcyQ4Utz@kernel.org>
 <YzRnfz0sVpX8CzeL@dev-arch.thelio-3990X>
 <YzWSzXKcm6rSWOC5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzWSzXKcm6rSWOC5@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Thu, Sep 29, 2022 at 09:42:53AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Sep 28, 2022 at 08:25:51AM -0700, Nathan Chancellor escreveu:
> > On Wed, Sep 28, 2022 at 10:42:53AM -0300, Arnaldo Carvalho de Melo wrote:
> > > Can you please provide the vmlinux file where this takes place?

> > Sure thing, it is compressed to save some bandwidth while downloading:

> > https://1drv.ms/u/s!AsQNYeB-IEbqnnzsULjM1pXmOlI5?e=qHKjuW

> So, fixed the case reported, DW_TAG_label outside a DW_TAG_lexblock, on
> asm DW_TAG_compile_unit DWARF containers, ...

Forgot the patch:

From f01e5f3a849558b8ed6b310686d10738f4c2f3bf Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Thu, 29 Sep 2022 09:43:16 -0300
Subject: [PATCH 1/1] dwarf_loader: Support DW_TAG_label outside
 DW_TAG_lexblock

This happens with asm CUs, noticed when building the Linux kernel with
clang 15, where we have, for instance:

  Contents of the .debug_info section:

    Compilation Unit @ offset 0x0:
     Length:        0x1df (32-bit)
     Version:       5
     Unit Type:     DW_UT_compile (1)
     Abbrev Offset: 0x0
     Pointer Size:  8
   <0><c>: Abbrev Number: 1 (DW_TAG_compile_unit)
      <d>   DW_AT_stmt_list   : 0x0
      <11>   DW_AT_ranges      : 0xc
      <15>   DW_AT_name        : arch/x86/kernel/verify_cpu.S
      <32>   DW_AT_comp_dir    : /home/nathan/cbl/src/linux
      <4d>   DW_AT_producer    : ClangBuiltLinux clang version 16.0.0 (https://github.com/llvm/llvm-project 7e22179d38c438fedb0d9bb0cff1585843bd7082)
      <c2>   DW_AT_language    : 32769    (MIPS assembler)
   <1><c4>: Abbrev Number: 2 (DW_TAG_label)
      <c5>   DW_AT_name        : startup_64
      <d0>   DW_AT_decl_file   : 0x0
      <d4>   DW_AT_decl_line   : 0x364
      <d8>   DW_AT_low_pc      : 0xffffffff81000000
   <1><e0>: Abbrev Number: 2 (DW_TAG_label)
      <e1>   DW_AT_name        : secondary_startup_64
      <f6>   DW_AT_decl_file   : 0x0
      <fa>   DW_AT_decl_line   : 0x399
      <fe>   DW_AT_low_pc      : 0xffffffff81000060
   <1><106>: Abbrev Number: 2 (DW_TAG_label)
      <107>   DW_AT_name        : secondary_startup_64_no_verify
      <126>   DW_AT_decl_file   : 0x0
      <12a>   DW_AT_decl_line   : 0x39f
      <12e>   DW_AT_low_pc      : 0xffffffff81000065
   <1><136>: Abbrev Number: 2 (DW_TAG_label)
      <137>   DW_AT_name        : verify_cpu
      <142>   DW_AT_decl_file   : 0x0
      <146>   DW_AT_decl_line   : 0x430
      <14a>   DW_AT_low_pc      : 0xffffffff81000150
  <SNIP>

Reported-by: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/dwarves/YzWSzXKcm6rSWOC5@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 631bbd434eb2a4e6..28a912ec725a6e68 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1485,7 +1485,12 @@ static struct tag *die__create_new_label(Dwarf_Die *die,
 	if (label == NULL)
 		return NULL;
 
-	lexblock__add_label(lexblock, label);
+	if (lexblock != NULL) {
+		// asm CUs have labels and they will be in the cu top level tag list
+		// See die__process_unit()
+		lexblock__add_label(lexblock, label);
+	}
+
 	return &label->ip.tag;
 }
 
@@ -2037,6 +2042,12 @@ static struct tag *__die__process_tag(Dwarf_Die *die, struct cu *cu,
 		 */
 		tag = &unsupported_tag;
 		break;
+	case DW_TAG_label:
+		if (conf->ignore_labels)
+			tag = &unsupported_tag; // callers will assume conf->ignore_labels is true
+		else // We can have labels in asm CUs, no lexblock
+			tag = die__create_new_label(die, NULL, cu, conf);
+		break;
 	}
 
 	if (tag != NULL)
@@ -2055,7 +2066,8 @@ static int die__process_unit(Dwarf_Die *die, struct cu *cu, struct conf_load *co
 		if (tag == &unsupported_tag) {
 			// XXX special case DW_TAG_dwarf_procedure, appears when looking at a recent ~/bin/perf
 			// Investigate later how to properly support this...
-			if (dwarf_tag(die) != DW_TAG_dwarf_procedure)
+			if (dwarf_tag(die) != DW_TAG_dwarf_procedure &&
+			    dwarf_tag(die) != DW_TAG_label) // conf->ignore_labels == true, see die__process_tag()
 				tag__print_not_supported(dwarf_tag(die));
 			continue;
 		}
-- 
2.37.3

