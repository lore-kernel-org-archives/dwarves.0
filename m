Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED34C433FE
	for <linux-dwarves@archiver.kernel.org>; Mon, 10 Oct 2022 12:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiJJMGx (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 10 Oct 2022 08:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiJJMGx (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 10 Oct 2022 08:06:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17691CB2B
        for <dwarves@vger.kernel.org>; Mon, 10 Oct 2022 05:06:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44584B80E79
        for <dwarves@vger.kernel.org>; Mon, 10 Oct 2022 12:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12F0C433C1;
        Mon, 10 Oct 2022 12:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665403609;
        bh=Uo5jIv/gKfU2KPX9XWIFo13NA4A775Qy2Qv5/b25XRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U0CJkab5GMFQTy/1MZU1yxAPm4ASK3ajFwnlHOSfyTVi6Wa4753kAASIi2wgwVlNh
         wYpG5FcbWW2z9GSXm7i5w5YqU90wpvBaRNNiZuC2Uxw7Oqw2isiWh+vSgKh4pPBpym
         0mFAJDSnVKWHbdIE6qxkiRh/Gty+RqFJKlv2Txzvh+XMDGV1rRIGkFut2GcxEolpiv
         lbj+1mmgoO6nb94pwIZz9Re2pmWFdjZsaFSKyZM7GUKETxFcLoQ2FPVzZR1lyFhvqK
         cXZl/Sff7FEGW7dHF3dS/YY/N01p2y5BVmeSDMQhqWQCi6tDZgyKKcZMaXQybuOOLr
         YEpIS00n68hbA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2BC474062C; Mon, 10 Oct 2022 09:06:46 -0300 (-03)
Date:   Mon, 10 Oct 2022 09:06:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@meta.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Yonghong Song <yhs@fb.com>, dwarves@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>
Subject: Re: Encountered error while encoding BTF due to Unsupported
 DW_TAG_unspecified_type(0x3b)
Message-ID: <Y0QK1nmVjqr95od1@kernel.org>
References: <a57a66b1-9457-a84f-6f66-9695aab01b1a@suse.cz>
 <Yz2Wmd0WgiwmPglm@kernel.org>
 <Yz2mNfP2mmqAhkUn@kernel.org>
 <f1eb3b92-c98a-9128-742d-795d8b6846ac@suse.cz>
 <Yz7bevBJAm0JiLfp@kernel.org>
 <Yz7fdFPTpwALxvak@kernel.org>
 <CAEf4BzaonLxP77zj9ReaEWdZ-Whh4JUts3S5YO8v9vVuCfMdiQ@mail.gmail.com>
 <Yz8PBLflC2VDm9qw@kernel.org>
 <Y0CKQHhcTSWYqNpj@kernel.org>
 <166780df-a8ca-6dfb-88e9-9e489efc6bf7@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <166780df-a8ca-6dfb-88e9-9e489efc6bf7@meta.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Fri, Oct 07, 2022 at 05:25:21PM -0700, Yonghong Song escreveu:
> 
> 
> On 10/7/22 1:21 PM, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Oct 06, 2022 at 02:23:16PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Thu, Oct 06, 2022 at 09:04:58AM -0700, Andrii Nakryiko escreveu:
> > > > On Thu, Oct 6, 2022 at 7:00 AM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > > > > Em Thu, Oct 06, 2022 at 10:43:22AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > > 15e20ce2324a:~/git/linux # readelf -wi ./arch/x86/entry/entry.o
> > > > > > Contents of the .debug_info section:
> > > 
> > > > > >    Compilation Unit @ offset 0:
> > > > > >     Length:        0x35 (32-bit)
> > > > > >     Version:       5
> > > > > >     Unit Type:     DW_UT_compile (1)
> > > > > >     Abbrev Offset: 0
> > > > > >     Pointer Size:  8
> > > > > >   <0><c>: Abbrev Number: 1 (DW_TAG_compile_unit)
> > > > > >      <d>   DW_AT_stmt_list   : 0
> > > > > >      <11>   DW_AT_low_pc      : 0
> > > > > >      <19>   DW_AT_high_pc     : 19
> > > > > >      <1a>   DW_AT_name        : (indirect string, offset: 0): arch/x86/entry/entry.S
> > > > > >      <1e>   DW_AT_comp_dir    : (indirect string, offset: 0x17): /root/git/linux
> > > > > >      <22>   DW_AT_producer    : (indirect string, offset: 0x27): GNU AS 2.39.50
> > > > > >      <26>   DW_AT_language    : 32769  (MIPS assembler)
> > > > > >   <1><28>: Abbrev Number: 2 (DW_TAG_subprogram)
> > > > > >      <29>   DW_AT_name        : (indirect string, offset: 0x36): entry_ibpb
> > > > > >      <2d>   DW_AT_external    : 1
> > > > > >      <2d>   DW_AT_type        : <0x37>
> > > > > >      <2e>   DW_AT_low_pc      : 0
> > > > > >      <36>   DW_AT_high_pc     : 19
> > > > > >   <1><37>: Abbrev Number: 3 (DW_TAG_unspecified_type)
> > > > > >   <1><38>: Abbrev Number: 0
> > > 
> > > > > > 15e20ce2324a:~/git/linux #
> > > 
> > > > > > Which pahole -J barfs on:
> > > 
> > > > > > 15e20ce2324a:~/git/linux # pahole -J ./arch/x86/entry/entry.o
> > > > > > [1] UNKNOWN (anon) Unexpected kind for reference
> > > > > > 15e20ce2324a:~/git/linux #
> > > 
> > > > > > But if we ask it to exclude asm CUs (<26>   DW_AT_language    : 32769
> > > > > > (MIPS assembler)) then it ignores it, so this is a workaround.
> > > 
> > > > > > 15e20ce2324a:~/git/linux # pahole --lang_exclude asm -V -J ./arch/x86/entry/entry.o
> > > > > > 15e20ce2324a:~/git/linux #
> > > 
> > > > > > Now I'm looking at how to get the BTF encoder grokking this.
> > > 
> > > > > This is what I came up with, Andrii, Yonghong, wdyt?
> > > > Does `const void` make sense? Why not just keeping it as "void"?
> > > > "const void" might confuse tooling and BTF verifier in kernel, but I
> > > > haven't checked. Just trying to understand why we need extra "const".
> > > 
> > > I was trying to have an entry for that DW_TAG_unspecified_type type
> > > instead of plain changing the type for entry_ibpb (a DW_TAG_subprogram)
> > > straight to 0 (void).
> > 
> > I think this is the best way forward at the moment, i.e. to just change
> > the type for such DW_TAG_subprogram to zero, aka void, losing this
> > information by default.
> > 
> > I'll have a --btf_encode_unspecified_type as this const void trick as an
> > opt-in, who knows if this ends up being useful :-)
> 
> For function entry_ibpb, actually the kernel has a prorotype,
> 
> include/asm/nospec-branch.h:extern void entry_ibpb(void);

> But unfortunately since the function is defined in asm code.
> The actual type information is not encoded in dwarf so pahole
> does not have enough info from vmlinux dwarf to get func
> types. The compiler does not generate func types based on
> declarations.

Right
 
> This may prevent people from tracing functions defined in
> asm code but this should be extremely rare.
> So I agree that BTF type id 0 is probably the best choice.

Thanks for your comments, that is the way I'll do it.
 
> > - Arnaldo
> > > I.e. we wouldn't lose that info that the return type for that "function"
> > > (it was encoded as a DW_TAG_subprogram) isn't defined. Using straight
> > > void would state that it doesn't return anything.
> > > 
> > > I couldn't find a way to use KCFLAGS to ask Kbuild to pass that -B flag
> > > to gcc so that I could rebuild the whole kernel with it to check if the
> > > build goes thru and then try booting with such BTF info.
> > > 
> > > - Arnaldo
> > > > > As an additional info clang 14 (haven't tested with other versions)
> > > > > encodes such ASM Labels as DW_TAG_label and this thus isn't an issue
> > > > > there.
> > > > > 
> > > > > - Arnaldo
> > > > > 
> > > > > commit 15ec614672da043008df31aa6ee85ebc5105d4fd
> > > > > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > > Date:   Tue Oct 4 18:22:53 2022 -0300
> > > > > 
> > > > >      btf_encoder: Encode DW_TAG_unspecified_type as BTF_KIND_CONST
> > > > > 
> > > > >      This first appeared for assembler files in the Linux kernel with recent
> > > > >      GNU compilers, we don't have anything in BTF, AFAIK, to properly
> > > > >      represent that, so, for now, lets go with BTF_KIND_CONST.
> > > > > 
> > > > >      Testing it:
> > > > > 
> > > > >      Built binutils from git://sourceware.org/git/binutils-gdb.git, then used
> > > > >      gcc's -B option to point to the directory with the new as, that is built
> > > > >      as as-new, so make a symlink, ending up with:
> > > > > 
> > > > >        15e20ce2324a:~/git/linux # readelf -wi ./arch/x86/entry/entry.o
> > > > >        Contents of the .debug_info section:
> > > > > 
> > > > >          Compilation Unit @ offset 0:
> > > > >           Length:        0x35 (32-bit)
> > > > >           Version:       5
> > > > >           Unit Type:     DW_UT_compile (1)
> > > > >           Abbrev Offset: 0
> > > > >           Pointer Size:  8
> > > > >         <0><c>: Abbrev Number: 1 (DW_TAG_compile_unit)
> > > > >            <d>   DW_AT_stmt_list   : 0
> > > > >            <11>   DW_AT_low_pc      : 0
> > > > >            <19>   DW_AT_high_pc     : 19
> > > > >            <1a>   DW_AT_name        : (indirect string, offset: 0): arch/x86/entry/entry.S
> > > > >            <1e>   DW_AT_comp_dir    : (indirect string, offset: 0x17): /root/git/linux
> > > > >            <22>   DW_AT_producer    : (indirect string, offset: 0x27): GNU AS 2.39.50
> > > > >            <26>   DW_AT_language    : 32769  (MIPS assembler)
> > > > >         <1><28>: Abbrev Number: 2 (DW_TAG_subprogram)
> > > > >            <29>   DW_AT_name        : (indirect string, offset: 0x36): entry_ibpb
> > > > >            <2d>   DW_AT_external    : 1
> > > > >            <2d>   DW_AT_type        : <0x37>
> > > > >            <2e>   DW_AT_low_pc      : 0
> > > > >            <36>   DW_AT_high_pc     : 19
> > > > >         <1><37>: Abbrev Number: 3 (DW_TAG_unspecified_type)
> > > > >         <1><38>: Abbrev Number: 0
> > > > > 
> > > > >      So we have that asm label encoded by GNU AS 2.39.50 as a
> > > > >      DW_TAG_subprogram that has as its DW_AT_type the DW_TAG_unspecified_type
> > > > >      0x37 that we encode as a BTF_KIND_CONST pointing to 0 (void):
> > > > > 
> > > > >        15e20ce2324a:~/git/linux # pahole -J ./arch/x86/entry/entry.o
> > > > >        15e20ce2324a:~/git/linux # pahole -JV ./arch/x86/entry/entry.o
> > > > >        btf_encoder__new: './arch/x86/entry/entry.o' doesn't have '.data..percpu' section
> > > > >        Found 0 per-CPU variables!
> > > > >        Found 1 functions!
> > > > >        File ./arch/x86/entry/entry.o:
> > > > >        [1] CONST (anon) type_id=0
> > > > >        [2] FUNC_PROTO (anon) return=1 args=(void)
> > > > >        [3] FUNC entry_ibpb type_id=2
> > > > >        15e20ce2324a:~/git/linux # pfunct -F btf ./arch/x86/entry/entry.o
> > > > >        entry_ibpb
> > > > >        15e20ce2324a:~/git/linux # pfunct --proto -F btf ./arch/x86/entry/entry.o
> > > > >        const void  entry_ibpb(void);
> > > > >        15e20ce2324a:~/git/linux #
> > > > > 
> > > > >        15e20ce2324a:~/git/linux # tools/bpf/bpftool/bpftool btf dump file ./arch/x86/entry/entry.o format raw
> > > > >        [1] CONST '(anon)' type_id=0
> > > > >        [2] FUNC_PROTO '(anon)' ret_type_id=1 vlen=0
> > > > >        [3] FUNC 'entry_ibpb' type_id=2 linkage=static
> > > > >        15e20ce2324a:~/git/linux #
> > > > > 
> > > > >      I think this is what can be done to avoid having to skip ASM DWARF when
> > > > >      gets widely used, i.e. binutils gets updated.
> > > > > 
> > > > >      Reported-by: Martin Liška <mliska@suse.cz>
> > > > >      Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > > >      Cc: Yonghong Song <yhs@fb.com>
> > > > >      Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > > > 
> > > > > diff --git a/btf_encoder.c b/btf_encoder.c
> > > > > index 7ad3f29ef153d8d6..7e50ba711ccc14d6 100644
> > > > > --- a/btf_encoder.c
> > > > > +++ b/btf_encoder.c
> > > > > @@ -962,6 +962,8 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
> > > > >                  return btf_encoder__add_enum_type(encoder, tag, conf_load);
> > > > >          case DW_TAG_subroutine_type:
> > > > >                  return btf_encoder__add_func_proto(encoder, tag__ftype(tag), type_id_off);
> > > > > +       case DW_TAG_unspecified_type:
> > > > > +               return btf_encoder__add_ref_type(encoder, BTF_KIND_CONST, 0, NULL, false);
> > > > >          default:
> > > > >                  fprintf(stderr, "Unsupported DW_TAG_%s(0x%x): type: 0x%x\n",
> > > > >                          dwarf_tag_name(tag->tag), tag->tag, ref_type_id);
> > > 
> > > -- 
> > > 
> > > - Arnaldo
> > 

-- 

- Arnaldo
