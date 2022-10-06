Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47ACDC433F5
	for <linux-dwarves@archiver.kernel.org>; Thu,  6 Oct 2022 16:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiJFQFS (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 6 Oct 2022 12:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiJFQFR (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 6 Oct 2022 12:05:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7EB12AAC
        for <dwarves@vger.kernel.org>; Thu,  6 Oct 2022 09:05:12 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id l22so3505586edj.5
        for <dwarves@vger.kernel.org>; Thu, 06 Oct 2022 09:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXv7ZBuj5OMsCP6dQyxNXvBmkSJomidYV/fGL/gokqE=;
        b=SaTDj2E4Cf4DUDYNoFXQYCvuebBJdV3Onb6SX+K/0uBwX5/WINMo3jds3ArUIj1Wqk
         P0ZWtpY54shC+vi1eyjH4zByPKd60CjNSdmuGn7Kqx1RfX74H15Xq0CB1OyusO8l6QY2
         yPDsORc+Twpb2uQY+bKzAfgfS905Lahf/HbAzlOfwYZsYhJulpmWFRaUmSDF68zwNs8j
         dCLlRU3PeVFK1ftoEun4zh1fRVPyL0oY9+bycPijP5oXJA/Jmdj6AGLmvAQ2uVhyX4fo
         doFepqxjChKZGKtNarTBJIkuI8oVZpN6RjW/A0Dn5L2lnUua/hoxgcinpcuVd8TNdNuf
         xJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXv7ZBuj5OMsCP6dQyxNXvBmkSJomidYV/fGL/gokqE=;
        b=WlVGGt+4TYPVTJDwfw/y+SJRp6N9e7cVZa805OuNC10fleofwwqvm6itp3G+DQGsU5
         onMz4QTJWR8lp7e5UX+a7pd/K1isC4q89ueQ6mT7oPqLlqTtPNx6ygxl5BUi/RBvJj+k
         iamkqu8g5gfB8olKUVl+AdH/l5yDlQJ9DDekPOw0jEM3VuvbuhyuC3FFqoFGA9tyJnyh
         VnKuTPkGWafZDcsiAZ+1zHCI0qKkKm6klJLTmiPhHxOUesyimk86y6jj5jZTjDN/CdK1
         GAEB+fedHwqZhnfrjZyPb72MpqSwfN5wSde06gg5iKsgpV3Tv5hguGmPMC1YdyWuqc9l
         79YQ==
X-Gm-Message-State: ACrzQf2cBiKwGnSJe01nzNslJ0e8Iqao2/CqwugYQCK5cEkH+BohV51S
        K5cGnZ+1B1ovwrWTaYr8AyaKvQzdfS86K5M0Y4k=
X-Google-Smtp-Source: AMsMyM7SuxAmKW/rzK85oqsQFYY9W9+qFc6JHTN73zpNld7HyTglVCIZbi1SEQ2GZUD7bdiOOklnuRe6fKPHJS/SxzE=
X-Received: by 2002:a05:6402:1856:b0:458:db1e:20ec with SMTP id
 v22-20020a056402185600b00458db1e20ecmr526222edy.14.1665072310444; Thu, 06 Oct
 2022 09:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <878d0959-7f80-471e-69d5-5228822b4365@suse.cz> <YzypIDbTomaZOPOY@kernel.org>
 <a57a66b1-9457-a84f-6f66-9695aab01b1a@suse.cz> <Yz2Wmd0WgiwmPglm@kernel.org>
 <Yz2mNfP2mmqAhkUn@kernel.org> <f1eb3b92-c98a-9128-742d-795d8b6846ac@suse.cz>
 <Yz7bevBJAm0JiLfp@kernel.org> <Yz7fdFPTpwALxvak@kernel.org>
In-Reply-To: <Yz7fdFPTpwALxvak@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 6 Oct 2022 09:04:58 -0700
Message-ID: <CAEf4BzaonLxP77zj9ReaEWdZ-Whh4JUts3S5YO8v9vVuCfMdiQ@mail.gmail.com>
Subject: Re: Encountered error while encoding BTF due to Unsupported DW_TAG_unspecified_type(0x3b)
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Yonghong Song <yhs@fb.com>, dwarves@vger.kernel.org,
        Nick Clifton <nickc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Thu, Oct 6, 2022 at 7:00 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, Oct 06, 2022 at 10:43:22AM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Thu, Oct 06, 2022 at 01:54:37PM +0200, Martin Li=C5=A1ka escreveu:
> > > On 10/5/22 17:43, Arnaldo Carvalho de Melo wrote:
> > > > Em Wed, Oct 05, 2022 at 11:37:13AM -0300, Arnaldo Carvalho de Melo =
escreveu:
> > > > So I built and installed from
> > > > git://sourceware.org/git/binutils-gdb.git, it got on /usr/local/bin=
,
> > > > taking precedence above /usr/bin/, and didn't get any
> > > > DW_TAG_unspecified_type:
> >
> > > Well, it's more trickier what gcc driver runs as a GAS even though yo=
u prefixed
> > > /usr/local/bin.
> >
> > ok
>
> > > $ echo '' | gcc -c -x c - --verbose 2>&1 | grep 'as\>'
> > >  /usr/lib64/gcc/x86_64-suse-linux/12/../../../../x86_64-suse-linux/bi=
n/as -v --64 -o -.o /tmp/cclvchQd.s
>
> > > Anyway, the easiest approach how to use a different gas is using -B g=
cc option, which
> > > would search the location for 'as' binary:
>
> > > $ pwd
> > > /home/marxin/Programming/binutils/objdir/gas
> > > $ ./as-new --version
> > > GNU assembler (GNU Binutils) 2.39.50.20221004
> > > ...
> > > $ ln -s as-new as
> > > $ gcc -Wp,-MMD,arch/x86/entry/.entry.o.d -nostdinc -I./arch/x86/inclu=
de -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I=
./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/ua=
pi -include ./include/linux/compiler-version.h -include ./include/linux/kco=
nfig.h -D__KERNEL__ -fmacro-prefix-map=3D./=3D -D__ASSEMBLY__ -fno-PIE -m64=
    -c -o arch/x86/entry/entry.o arch/x86/entry/entry.S -g -B/home/marxin/P=
rogramming/binutils/objdir/gas
> > >
> > > (note I'm using make defconfig), and not I can see:
> >
> > 'make defconfig' doesn't produce DWARF, so I continued using my
> > .config, moved the -B to right after 'gcc' in the above command line an=
d
> > finally get:
> >
> > 15e20ce2324a:~/git/linux # readelf -wi ./arch/x86/entry/entry.o
> > Contents of the .debug_info section:
> >
> >   Compilation Unit @ offset 0:
> >    Length:        0x35 (32-bit)
> >    Version:       5
> >    Unit Type:     DW_UT_compile (1)
> >    Abbrev Offset: 0
> >    Pointer Size:  8
> >  <0><c>: Abbrev Number: 1 (DW_TAG_compile_unit)
> >     <d>   DW_AT_stmt_list   : 0
> >     <11>   DW_AT_low_pc      : 0
> >     <19>   DW_AT_high_pc     : 19
> >     <1a>   DW_AT_name        : (indirect string, offset: 0): arch/x86/e=
ntry/entry.S
> >     <1e>   DW_AT_comp_dir    : (indirect string, offset: 0x17): /root/g=
it/linux
> >     <22>   DW_AT_producer    : (indirect string, offset: 0x27): GNU AS =
2.39.50
> >     <26>   DW_AT_language    : 32769  (MIPS assembler)
> >  <1><28>: Abbrev Number: 2 (DW_TAG_subprogram)
> >     <29>   DW_AT_name        : (indirect string, offset: 0x36): entry_i=
bpb
> >     <2d>   DW_AT_external    : 1
> >     <2d>   DW_AT_type        : <0x37>
> >     <2e>   DW_AT_low_pc      : 0
> >     <36>   DW_AT_high_pc     : 19
> >  <1><37>: Abbrev Number: 3 (DW_TAG_unspecified_type)
> >  <1><38>: Abbrev Number: 0
> >
> > 15e20ce2324a:~/git/linux #
> >
> > Which pahole -J barfs on:
> >
> > 15e20ce2324a:~/git/linux # pahole -J ./arch/x86/entry/entry.o
> > [1] UNKNOWN (anon) Unexpected kind for reference
> > 15e20ce2324a:~/git/linux #
> >
> > But if we ask it to exclude asm CUs (<26>   DW_AT_language    : 32769
> > (MIPS assembler)) then it ignores it, so this is a workaround.
> >
> > 15e20ce2324a:~/git/linux # pahole --lang_exclude asm -V -J ./arch/x86/e=
ntry/entry.o
> > 15e20ce2324a:~/git/linux #
> >
> > Now I'm looking at how to get the BTF encoder grokking this.
>
> This is what I came up with, Andrii, Yonghong, wdyt?
>

Does `const void` make sense? Why not just keeping it as "void"?
"const void" might confuse tooling and BTF verifier in kernel, but I
haven't checked. Just trying to understand why we need extra "const".

> As an additional info clang 14 (haven't tested with other versions)
> encodes such ASM Labels as DW_TAG_label and this thus isn't an issue
> there.
>
> - Arnaldo
>
> commit 15ec614672da043008df31aa6ee85ebc5105d4fd
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Tue Oct 4 18:22:53 2022 -0300
>
>     btf_encoder: Encode DW_TAG_unspecified_type as BTF_KIND_CONST
>
>     This first appeared for assembler files in the Linux kernel with rece=
nt
>     GNU compilers, we don't have anything in BTF, AFAIK, to properly
>     represent that, so, for now, lets go with BTF_KIND_CONST.
>
>     Testing it:
>
>     Built binutils from git://sourceware.org/git/binutils-gdb.git, then u=
sed
>     gcc's -B option to point to the directory with the new as, that is bu=
ilt
>     as as-new, so make a symlink, ending up with:
>
>       15e20ce2324a:~/git/linux # readelf -wi ./arch/x86/entry/entry.o
>       Contents of the .debug_info section:
>
>         Compilation Unit @ offset 0:
>          Length:        0x35 (32-bit)
>          Version:       5
>          Unit Type:     DW_UT_compile (1)
>          Abbrev Offset: 0
>          Pointer Size:  8
>        <0><c>: Abbrev Number: 1 (DW_TAG_compile_unit)
>           <d>   DW_AT_stmt_list   : 0
>           <11>   DW_AT_low_pc      : 0
>           <19>   DW_AT_high_pc     : 19
>           <1a>   DW_AT_name        : (indirect string, offset: 0): arch/x=
86/entry/entry.S
>           <1e>   DW_AT_comp_dir    : (indirect string, offset: 0x17): /ro=
ot/git/linux
>           <22>   DW_AT_producer    : (indirect string, offset: 0x27): GNU=
 AS 2.39.50
>           <26>   DW_AT_language    : 32769  (MIPS assembler)
>        <1><28>: Abbrev Number: 2 (DW_TAG_subprogram)
>           <29>   DW_AT_name        : (indirect string, offset: 0x36): ent=
ry_ibpb
>           <2d>   DW_AT_external    : 1
>           <2d>   DW_AT_type        : <0x37>
>           <2e>   DW_AT_low_pc      : 0
>           <36>   DW_AT_high_pc     : 19
>        <1><37>: Abbrev Number: 3 (DW_TAG_unspecified_type)
>        <1><38>: Abbrev Number: 0
>
>     So we have that asm label encoded by GNU AS 2.39.50 as a
>     DW_TAG_subprogram that has as its DW_AT_type the DW_TAG_unspecified_t=
ype
>     0x37 that we encode as a BTF_KIND_CONST pointing to 0 (void):
>
>       15e20ce2324a:~/git/linux # pahole -J ./arch/x86/entry/entry.o
>       15e20ce2324a:~/git/linux # pahole -JV ./arch/x86/entry/entry.o
>       btf_encoder__new: './arch/x86/entry/entry.o' doesn't have '.data..p=
ercpu' section
>       Found 0 per-CPU variables!
>       Found 1 functions!
>       File ./arch/x86/entry/entry.o:
>       [1] CONST (anon) type_id=3D0
>       [2] FUNC_PROTO (anon) return=3D1 args=3D(void)
>       [3] FUNC entry_ibpb type_id=3D2
>       15e20ce2324a:~/git/linux # pfunct -F btf ./arch/x86/entry/entry.o
>       entry_ibpb
>       15e20ce2324a:~/git/linux # pfunct --proto -F btf ./arch/x86/entry/e=
ntry.o
>       const void  entry_ibpb(void);
>       15e20ce2324a:~/git/linux #
>
>       15e20ce2324a:~/git/linux # tools/bpf/bpftool/bpftool btf dump file =
./arch/x86/entry/entry.o format raw
>       [1] CONST '(anon)' type_id=3D0
>       [2] FUNC_PROTO '(anon)' ret_type_id=3D1 vlen=3D0
>       [3] FUNC 'entry_ibpb' type_id=3D2 linkage=3Dstatic
>       15e20ce2324a:~/git/linux #
>
>     I think this is what can be done to avoid having to skip ASM DWARF wh=
en
>     gets widely used, i.e. binutils gets updated.
>
>     Reported-by: Martin Li=C5=A1ka <mliska@suse.cz>
>     Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
>     Cc: Yonghong Song <yhs@fb.com>
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 7ad3f29ef153d8d6..7e50ba711ccc14d6 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -962,6 +962,8 @@ static int btf_encoder__encode_tag(struct btf_encoder=
 *encoder, struct tag *tag,
>                 return btf_encoder__add_enum_type(encoder, tag, conf_load=
);
>         case DW_TAG_subroutine_type:
>                 return btf_encoder__add_func_proto(encoder, tag__ftype(ta=
g), type_id_off);
> +       case DW_TAG_unspecified_type:
> +               return btf_encoder__add_ref_type(encoder, BTF_KIND_CONST,=
 0, NULL, false);
>         default:
>                 fprintf(stderr, "Unsupported DW_TAG_%s(0x%x): type: 0x%x\=
n",
>                         dwarf_tag_name(tag->tag), tag->tag, ref_type_id);
