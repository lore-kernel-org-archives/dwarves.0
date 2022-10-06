Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1A9C433FE
	for <linux-dwarves@archiver.kernel.org>; Thu,  6 Oct 2022 14:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiJFOAd (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 6 Oct 2022 10:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiJFOA1 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 6 Oct 2022 10:00:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E7086835
        for <dwarves@vger.kernel.org>; Thu,  6 Oct 2022 07:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A84BB82077
        for <dwarves@vger.kernel.org>; Thu,  6 Oct 2022 14:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB834C433D7;
        Thu,  6 Oct 2022 14:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665064823;
        bh=Fvb12tpgsKH3DClawJEWk3dxM88j38IjpD4jRJ/w8FE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lKHrLEQlrZhoLyPnc829Q3DdeL56hK9D4XYzp+lrkSmtwK/hnFRmtw3ijoDe3pdoA
         eL4lG0PCPQ7WXb+1/zB0LRpB0feSbF8pG7uzXjKjsU56k5QlahbIGqWSA/y1UVTpKL
         RvKagCQ6YXuc0+BdTSLlT/BVt/aFSEmMFkCQXfFUgoSPmw1hbb+aS5f4/xlNMXBCmT
         N6TFoOXG+JvqHbtK53JU3aHN0khX+7AWMx0E2Y0AWOImkmaKxkA1VIaOPvb9Lyt8H/
         xiqpWt6S0pb5PjeQPI7kEBlXDOX14nkaoqx7Ut6rPeSCr9BhZ74VvCBd6znTKy0Rc+
         FupkFqHFyEOIQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 79B7A4062C; Thu,  6 Oct 2022 11:00:20 -0300 (-03)
Date:   Thu, 6 Oct 2022 11:00:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>
Cc:     dwarves@vger.kernel.org, Nick Clifton <nickc@redhat.com>
Subject: Re: Encountered error while encoding BTF due to Unsupported
 DW_TAG_unspecified_type(0x3b)
Message-ID: <Yz7fdFPTpwALxvak@kernel.org>
References: <878d0959-7f80-471e-69d5-5228822b4365@suse.cz>
 <YzypIDbTomaZOPOY@kernel.org>
 <a57a66b1-9457-a84f-6f66-9695aab01b1a@suse.cz>
 <Yz2Wmd0WgiwmPglm@kernel.org>
 <Yz2mNfP2mmqAhkUn@kernel.org>
 <f1eb3b92-c98a-9128-742d-795d8b6846ac@suse.cz>
 <Yz7bevBJAm0JiLfp@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yz7bevBJAm0JiLfp@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Thu, Oct 06, 2022 at 10:43:22AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Oct 06, 2022 at 01:54:37PM +0200, Martin Liška escreveu:
> > On 10/5/22 17:43, Arnaldo Carvalho de Melo wrote:
> > > Em Wed, Oct 05, 2022 at 11:37:13AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > So I built and installed from
> > > git://sourceware.org/git/binutils-gdb.git, it got on /usr/local/bin,
> > > taking precedence above /usr/bin/, and didn't get any
> > > DW_TAG_unspecified_type:
>  
> > Well, it's more trickier what gcc driver runs as a GAS even though you prefixed
> > /usr/local/bin.
> 
> ok
  
> > $ echo '' | gcc -c -x c - --verbose 2>&1 | grep 'as\>'
> >  /usr/lib64/gcc/x86_64-suse-linux/12/../../../../x86_64-suse-linux/bin/as -v --64 -o -.o /tmp/cclvchQd.s
  
> > Anyway, the easiest approach how to use a different gas is using -B gcc option, which
> > would search the location for 'as' binary:
  
> > $ pwd
> > /home/marxin/Programming/binutils/objdir/gas
> > $ ./as-new --version
> > GNU assembler (GNU Binutils) 2.39.50.20221004
> > ...
> > $ ln -s as-new as
> > $ gcc -Wp,-MMD,arch/x86/entry/.entry.o.d -nostdinc -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/compiler-version.h -include ./include/linux/kconfig.h -D__KERNEL__ -fmacro-prefix-map=./= -D__ASSEMBLY__ -fno-PIE -m64    -c -o arch/x86/entry/entry.o arch/x86/entry/entry.S -g -B/home/marxin/Programming/binutils/objdir/gas
> > 
> > (note I'm using make defconfig), and not I can see:
> 
> 'make defconfig' doesn't produce DWARF, so I continued using my
> .config, moved the -B to right after 'gcc' in the above command line and
> finally get:
> 
> 15e20ce2324a:~/git/linux # readelf -wi ./arch/x86/entry/entry.o
> Contents of the .debug_info section:
> 
>   Compilation Unit @ offset 0:
>    Length:        0x35 (32-bit)
>    Version:       5
>    Unit Type:     DW_UT_compile (1)
>    Abbrev Offset: 0
>    Pointer Size:  8
>  <0><c>: Abbrev Number: 1 (DW_TAG_compile_unit)
>     <d>   DW_AT_stmt_list   : 0
>     <11>   DW_AT_low_pc      : 0
>     <19>   DW_AT_high_pc     : 19
>     <1a>   DW_AT_name        : (indirect string, offset: 0): arch/x86/entry/entry.S
>     <1e>   DW_AT_comp_dir    : (indirect string, offset: 0x17): /root/git/linux
>     <22>   DW_AT_producer    : (indirect string, offset: 0x27): GNU AS 2.39.50
>     <26>   DW_AT_language    : 32769	(MIPS assembler)
>  <1><28>: Abbrev Number: 2 (DW_TAG_subprogram)
>     <29>   DW_AT_name        : (indirect string, offset: 0x36): entry_ibpb
>     <2d>   DW_AT_external    : 1
>     <2d>   DW_AT_type        : <0x37>
>     <2e>   DW_AT_low_pc      : 0
>     <36>   DW_AT_high_pc     : 19
>  <1><37>: Abbrev Number: 3 (DW_TAG_unspecified_type)
>  <1><38>: Abbrev Number: 0
> 
> 15e20ce2324a:~/git/linux #
> 
> Which pahole -J barfs on:
> 
> 15e20ce2324a:~/git/linux # pahole -J ./arch/x86/entry/entry.o
> [1] UNKNOWN (anon) Unexpected kind for reference
> 15e20ce2324a:~/git/linux #
> 
> But if we ask it to exclude asm CUs (<26>   DW_AT_language    : 32769
> (MIPS assembler)) then it ignores it, so this is a workaround.
> 
> 15e20ce2324a:~/git/linux # pahole --lang_exclude asm -V -J ./arch/x86/entry/entry.o
> 15e20ce2324a:~/git/linux #
> 
> Now I'm looking at how to get the BTF encoder grokking this.

This is what I came up with, Andrii, Yonghong, wdyt?

As an additional info clang 14 (haven't tested with other versions)
encodes such ASM Labels as DW_TAG_label and this thus isn't an issue
there.

- Arnaldo

commit 15ec614672da043008df31aa6ee85ebc5105d4fd
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Tue Oct 4 18:22:53 2022 -0300

    btf_encoder: Encode DW_TAG_unspecified_type as BTF_KIND_CONST
    
    This first appeared for assembler files in the Linux kernel with recent
    GNU compilers, we don't have anything in BTF, AFAIK, to properly
    represent that, so, for now, lets go with BTF_KIND_CONST.
    
    Testing it:
    
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
    0x37 that we encode as a BTF_KIND_CONST pointing to 0 (void):
    
      15e20ce2324a:~/git/linux # pahole -J ./arch/x86/entry/entry.o
      15e20ce2324a:~/git/linux # pahole -JV ./arch/x86/entry/entry.o
      btf_encoder__new: './arch/x86/entry/entry.o' doesn't have '.data..percpu' section
      Found 0 per-CPU variables!
      Found 1 functions!
      File ./arch/x86/entry/entry.o:
      [1] CONST (anon) type_id=0
      [2] FUNC_PROTO (anon) return=1 args=(void)
      [3] FUNC entry_ibpb type_id=2
      15e20ce2324a:~/git/linux # pfunct -F btf ./arch/x86/entry/entry.o
      entry_ibpb
      15e20ce2324a:~/git/linux # pfunct --proto -F btf ./arch/x86/entry/entry.o
      const void  entry_ibpb(void);
      15e20ce2324a:~/git/linux #
    
      15e20ce2324a:~/git/linux # tools/bpf/bpftool/bpftool btf dump file ./arch/x86/entry/entry.o format raw
      [1] CONST '(anon)' type_id=0
      [2] FUNC_PROTO '(anon)' ret_type_id=1 vlen=0
      [3] FUNC 'entry_ibpb' type_id=2 linkage=static
      15e20ce2324a:~/git/linux #
    
    I think this is what can be done to avoid having to skip ASM DWARF when
    gets widely used, i.e. binutils gets updated.
    
    Reported-by: Martin Liška <mliska@suse.cz>
    Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
    Cc: Yonghong Song <yhs@fb.com>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/btf_encoder.c b/btf_encoder.c
index 7ad3f29ef153d8d6..7e50ba711ccc14d6 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -962,6 +962,8 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
 		return btf_encoder__add_enum_type(encoder, tag, conf_load);
 	case DW_TAG_subroutine_type:
 		return btf_encoder__add_func_proto(encoder, tag__ftype(tag), type_id_off);
+	case DW_TAG_unspecified_type:
+		return btf_encoder__add_ref_type(encoder, BTF_KIND_CONST, 0, NULL, false);
 	default:
 		fprintf(stderr, "Unsupported DW_TAG_%s(0x%x): type: 0x%x\n",
 			dwarf_tag_name(tag->tag), tag->tag, ref_type_id);
