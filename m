Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF24AC433FE
	for <linux-dwarves@archiver.kernel.org>; Mon, 10 Oct 2022 20:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJJUIf (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 10 Oct 2022 16:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJJUIc (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 10 Oct 2022 16:08:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672D11D0E0
        for <dwarves@vger.kernel.org>; Mon, 10 Oct 2022 13:08:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8C4A60EFB
        for <dwarves@vger.kernel.org>; Mon, 10 Oct 2022 20:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E135AC433D7;
        Mon, 10 Oct 2022 20:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665432510;
        bh=Xx7467/VEZaF25ONrtrun/D6iSVpJwBDxo15SfV8s1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kymc4nUZvOUGthCYzBXj2lP5i24rdeRniYIwTn7bOUzot/INxmJwcxHMD2Q4lJd0z
         n0XWgXBF7lfo2vazE/SsUJqG5iUN0ios9IJMH7/qc7JI5q8r4t3XIDmF3KNJYAHTEi
         tXyh58dQ5RvVg2q/17j+dv/QKaFw1Hwq308Jht8R0LZ1YXUycczCxDVIzYYbp6M6Cc
         Yiz3jY5IdzWXQVegmRlDvSPYI7J40FpB48OI8r9Zdj4NJEPBo4gSkXIlBoXC1/6dag
         O2u7IYCKvX/tzYv6+1HR1HTFjHdgmjxwGMCoaBtWEy3v7B1oNO9Gb2ooEH4WyWHO+L
         rhWUNEGT2Lr0g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CC6134062C; Mon, 10 Oct 2022 17:08:26 -0300 (-03)
Date:   Mon, 10 Oct 2022 17:08:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@meta.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Yonghong Song <yhs@fb.com>, dwarves@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>
Subject: Re: Encountered error while encoding BTF due to Unsupported
 DW_TAG_unspecified_type(0x3b)
Message-ID: <Y0R7uu3s/imnvPzM@kernel.org>
References: <Yz2Wmd0WgiwmPglm@kernel.org>
 <Yz2mNfP2mmqAhkUn@kernel.org>
 <f1eb3b92-c98a-9128-742d-795d8b6846ac@suse.cz>
 <Yz7bevBJAm0JiLfp@kernel.org>
 <Yz7fdFPTpwALxvak@kernel.org>
 <CAEf4BzaonLxP77zj9ReaEWdZ-Whh4JUts3S5YO8v9vVuCfMdiQ@mail.gmail.com>
 <Yz8PBLflC2VDm9qw@kernel.org>
 <Y0CKQHhcTSWYqNpj@kernel.org>
 <166780df-a8ca-6dfb-88e9-9e489efc6bf7@meta.com>
 <Y0QK1nmVjqr95od1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y0QK1nmVjqr95od1@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Mon, Oct 10, 2022 at 09:06:46AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Oct 07, 2022 at 05:25:21PM -0700, Yonghong Song escreveu:
> > For function entry_ibpb, actually the kernel has a prorotype,

> > include/asm/nospec-branch.h:extern void entry_ibpb(void);

> > But unfortunately since the function is defined in asm code.
> > The actual type information is not encoded in dwarf so pahole
> > does not have enough info from vmlinux dwarf to get func
> > types. The compiler does not generate func types based on
> > declarations.

> Right

> > This may prevent people from tracing functions defined in
> > asm code but this should be extremely rare.
> > So I agree that BTF type id 0 is probably the best choice.
> 
> Thanks for your comments, that is the way I'll do it.

Done, some prep patches then the patch below.

If possible, please ack :-)

- Arnaldo

commit 3abc72d9d56ec0cbfffc1794d2bf5d527d1e88ba
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Mon Oct 10 11:20:07 2022 -0300

    btf_encoder: Encode DW_TAG_unspecified_type returning routines as void
    
    Since we don´t have how to encode this info in BTF, and from what we
    saw, at least in this case:
    
    Built binutils from git://sourceware.org/git/binutils-gdb.git, then used
    gcc's -B option to point to the directory with the new as, that is built
    as as-new, so make a symlink, ending up with:
    
      15e20ce2324a:~/git/linux # readelf -wi ./arch/x86/entry/entry.o
      Contents of the .debug_info section:
    
        Compilation Unit @ offset 0:
         Length:        0x35 (32-bit)
         Version:       5
         Unit Type:     DW_UT_compile (1)
         Abbrev Offset: 0
         Pointer Size:  8
       <0><c>: Abbrev Number: 1 (DW_TAG_compile_unit)
          <d>   DW_AT_stmt_list   : 0
          <11>   DW_AT_low_pc      : 0
          <19>   DW_AT_high_pc     : 19
          <1a>   DW_AT_name        : (indirect string, offset: 0): arch/x86/entry/entry.S
          <1e>   DW_AT_comp_dir    : (indirect string, offset: 0x17): /root/git/linux
          <22>   DW_AT_producer    : (indirect string, offset: 0x27): GNU AS 2.39.50
          <26>   DW_AT_language    : 32769  (MIPS assembler)
       <1><28>: Abbrev Number: 2 (DW_TAG_subprogram)
          <29>   DW_AT_name        : (indirect string, offset: 0x36): entry_ibpb
          <2d>   DW_AT_external    : 1
          <2d>   DW_AT_type        : <0x37>
          <2e>   DW_AT_low_pc      : 0
          <36>   DW_AT_high_pc     : 19
       <1><37>: Abbrev Number: 3 (DW_TAG_unspecified_type)
       <1><38>: Abbrev Number: 0
    
    So we have that asm label encoded by GNU AS 2.39.50 as a
    DW_TAG_subprogram that has as its DW_AT_type the DW_TAG_unspecified_type
    0x37 that we convert to 0 (void):
    
      15e20ce2324a:~/git/linux # pahole -J ./arch/x86/entry/entry.o
      15e20ce2324a:~/git/linux # pahole -JV ./arch/x86/entry/entry.o
      btf_encoder__new: 'entry.o' doesn't have '.data..percpu' section
      Found 0 per-CPU variables!
      Found 1 functions!
      File entry.o:
      [1] FUNC_PROTO (anon) return=0 args=(void)
      [2] FUNC entry_ibpb type_id=1
      15e20ce2324a:~/git/linux # pfunct -F btf ./arch/x86/entry/entry.o
      entry_ibpb
      15e20ce2324a:~/git/linux # pfunct --proto -F btf ./arch/x86/entry/entry.o
      void  entry_ibpb(void);
      15e20ce2324a:~/git/linux #
    
      15e20ce2324a:~/git/linux # tools/bpf/bpftool/bpftool btf dump file ./arch/x86/entry/entry.o format raw
      [1] FUNC_PROTO '(anon)' ret_type_id=0 vlen=0
      [2] FUNC 'entry_ibpb' type_id=1 linkage=static
      15e20ce2324a:~/git/linux #
    
    I think this is what can be done to avoid having to skip ASM DWARF when
    gets widely used, i.e. binutils gets updated.
    
    Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
    Cc: Martin Liška <mliska@suse.cz>
    Cc: Yonghong Song <yhs@meta.com>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/btf_encoder.c b/btf_encoder.c
index fb2ca77e2e9bf144..a5fa04a84ee246ee 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -593,6 +593,19 @@ static int32_t btf_encoder__add_func_param(struct btf_encoder *encoder, const ch
 	}
 }
 
+static int32_t btf_encoder__tag_type(struct btf_encoder *encoder, uint32_t type_id_off, uint32_t tag_type)
+{
+	if (tag_type == 0)
+		return 0;
+
+	if (encoder->cu->unspecified_type.tag && tag_type == encoder->cu->unspecified_type.type) {
+		// No provision for encoding this, turn it into void.
+		return 0;
+	}
+
+	return type_id_off + tag_type;
+}
+
 static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct ftype *ftype, uint32_t type_id_off)
 {
 	struct btf *btf = encoder->btf;
@@ -603,7 +616,7 @@ static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct f
 
 	/* add btf_type for func_proto */
 	nr_params = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
-	type_id = ftype->tag.type == 0 ? 0 : type_id_off + ftype->tag.type;
+	type_id = btf_encoder__tag_type(encoder, type_id_off, ftype->tag.type);
 
 	id = btf__add_func_proto(btf, type_id);
 	if (id > 0) {
@@ -966,6 +979,15 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
 		return btf_encoder__add_enum_type(encoder, tag, conf_load);
 	case DW_TAG_subroutine_type:
 		return btf_encoder__add_func_proto(encoder, tag__ftype(tag), type_id_off);
+        case DW_TAG_unspecified_type:
+		/* Just don't encode this for now, converting anything with this type to void (0) instead.
+		 *
+		 * If we end up needing to encode this, one possible hack is to do as follows, as "const void".
+		 *
+		 * Returning zero means we skipped encoding a DWARF type.
+		 */
+               // btf_encoder__add_ref_type(encoder, BTF_KIND_CONST, 0, NULL, false);
+               return 0;
 	default:
 		fprintf(stderr, "Unsupported DW_TAG_%s(0x%x): type: 0x%x\n",
 			dwarf_tag_name(tag->tag), tag->tag, ref_type_id);
@@ -1487,7 +1509,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 {
 	uint32_t type_id_off = btf__type_cnt(encoder->btf) - 1;
 	struct llvm_annotation *annot;
-	int btf_type_id, tag_type_id;
+	int btf_type_id, tag_type_id, skipped_types = 0;
 	uint32_t core_id;
 	struct function *fn;
 	struct tag *pos;
@@ -1510,8 +1532,13 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 	cu__for_each_type(cu, core_id, pos) {
 		btf_type_id = btf_encoder__encode_tag(encoder, pos, type_id_off, conf_load);
 
+		if (btf_type_id == 0) {
+			++skipped_types;
+			continue;
+		}
+
 		if (btf_type_id < 0 ||
-		    tag__check_id_drift(pos, core_id, btf_type_id, type_id_off)) {
+		    tag__check_id_drift(pos, core_id, btf_type_id + skipped_types, type_id_off)) {
 			err = -1;
 			goto out;
 		}
