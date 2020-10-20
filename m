Return-Path: <SRS0=WuSk=D3=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4B2C433E7
	for <linux-dwarves@archiver.kernel.org>; Tue, 20 Oct 2020 12:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D479822265
	for <linux-dwarves@archiver.kernel.org>; Tue, 20 Oct 2020 12:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603196418;
	bh=EnGv0MFvniAMktEmBQLAQeOA6GSZykQGPJQwZFpJbu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MuiZoi+6u3BxbUe1InBLwac0QTIO8p1Tf/3CAqFb4K/NhyCZlLLB6Y+VAfqRJaH4h
	 +WlF3R4tWeqFxElqiqtXBOPM4+NVPQyBhMJHf7jxL9wIf1dDxoYehAdMXWvCYjG8nP
	 Pjp0pu27ycTPxdPVtqGJ/6gIHyxLX88hgm2ANYSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394370AbgJTMUS (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 20 Oct 2020 08:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394088AbgJTMUS (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Tue, 20 Oct 2020 08:20:18 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14EFC2222F;
        Tue, 20 Oct 2020 12:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603196417;
        bh=EnGv0MFvniAMktEmBQLAQeOA6GSZykQGPJQwZFpJbu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KoWFD7p4h8oNaarWyr54GOzPn0sRHLXL4qeLKbMOhKk92dmULKQJ62kcKfrVUl1MS
         a2ucocpuJ9xe80bHEVDA5yrebxuBn4gY5kMkk5BmKhTBKYxwLGZi4jjGPFppEBveaH
         9oi0olveij9UJn7adyi1F70MAfloNGyUhhboIR1c=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 27D9B403C2; Tue, 20 Oct 2020 09:20:15 -0300 (-03)
Date:   Tue, 20 Oct 2020 09:20:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     =?iso-8859-1?Q?=C9rico?= Rolim <erico.erc@gmail.com>,
        dwarves@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Hao Luo <haoluo@google.com>, Andrii Nakryiko <andriin@fb.com>
Subject: Re: Segfault in pahole 1.18 when building kernel 5.9.1 for arm64
Message-ID: <20201020122015.GH2294271@kernel.org>
References: <CAFDeuWM7D-Upi84-JovKa3g8Y_4fjv65jND3--e9u-tER3WmVA@mail.gmail.com>
 <82b757bb-1f49-ab02-2f4b-89577d56fec9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82b757bb-1f49-ab02-2f4b-89577d56fec9@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Tue, Oct 20, 2020 at 11:01:39AM +0200, Jiri Slaby escreveu:
> Hi,
> 
> On 19. 10. 20, 1:18, Érico Rolim wrote:
> > I'm trying to build kernel 5.9.1 for arm64, and my dotconfig has
> > `CONFIG_DEBUG_INFO_BTF=y`, which requires pahole for building. However, pahole
> > version 1.18 segfaults during the build, as can be seen below:
> > 
> > PAHOLE: Error: Found symbol of zero size when encoding btf (sym:
> > '__kvm_nvhe_arm64_ssbd_callback_required', cu:
> > 'arch/arm64/kernel/cpu_errata.c').
> 
> The symbol is an alias coming from arch/arm64/kernel/vmlinux.lds:
> __kvm_nvhe_arm64_ssbd_callback_required = arm64_ssbd_callback_required;;
> 
> > PAHOLE: Error: Use '-j' or '--force' to ignore such symbols and force
> > emit the btf.
> > scripts/link-vmlinux.sh: line 141: 43837 Segmentation fault
> > LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
> >    LD      .tmp_vmlinux.kallsyms1
> >    KSYM    .tmp_vmlinux.kallsyms1.o
> >    LD      .tmp_vmlinux.kallsyms2
> >    KSYM    .tmp_vmlinux.kallsyms2.o
> >    LD      vmlinux
> >    BTFIDS  vmlinux
> > FAILED: load BTF from vmlinux: Unknown error -2make: ***
> > [Makefile:1162: vmlinux] Error 255
> > 
> > It is possible to force the build to continue if
> > 
> >    LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
> > 
> > in scripts/link-vmlinux.sh is changed to
> > 
> >    LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J --btf_encode_force ${1}
> > 
> > The suggested `-j` or `--force` flags don't exist, since they were removed in
> > [1]. I believe `--btf_encode_force` should be suggested instead.
> 
> Agreed, '--btf_encode_force' makes pahole to proceed without crashes.
> 
> > It should be noted that the same build, but with pahole version 1.17, works
> > without issue, so I think this is either a regression in pahole or the script
> > will need to be changed for newer versions of pahole.
> 
> Yeah, I observe the very same. I reported it at:
> https://bugzilla.suse.com/show_bug.cgi?id=1177921

Would it be possible to try with
https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=tmp.libbtf_encoder
?

This switches to using libbpf for the BTF encoder and may have fixed
this problem.

- Arnaldo
 
> The backtrace:
> > (gdb) where
> > #0  __memmove_sse2_unaligned_erms () at
> ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:300
> > #1  0x00007ffff7f78346 in memcpy (__len=<optimized out>, __src=<optimized
> out>, __dest=<optimized out>, __dest=<optimized out>, __src=<optimized out>,
> __len=<optimized out>) at /usr/include/bits/string_fortified.h:34
> > #2  gobuffer__add (gb=0x555555569aa0, s=0x7fffffffb50c, len=12) at
> /usr/src/debug/dwarves-1.18-1.1.x86_64/gobuffer.c:87
> > #3  0x00007ffff7f8671f in btf_elf__add_datasec_type
> (btfe=btfe@entry=0x555555569a40,
> section_name=section_name@entry=0x7ffff7fa43ad ".data..percpu",
> var_secinfo_buf=var_secinfo_buf@entry=0x555555569ac0) at
> /usr/src/debug/dwarves-1.18-1.1.x86_64/libbtf.c:721
> > #4  0x00007ffff7f8d766 in btf_elf__encode (flags=0 '\000',
> btfe=0x555555569a40) at /usr/src/debug/dwarves-1.18-1.1.x86_64/libbtf.c:857
> > #5  btf_elf__encode (btfe=0x555555569a40, flags=<optimized out>) at
> /usr/src/debug/dwarves-1.18-1.1.x86_64/libbtf.h:71
> > #6  0x00007ffff7f7fc70 in btf_encoder__encode () at
> /usr/src/debug/dwarves-1.18-1.1.x86_64/btf_encoder.c:213
> > #7  0x00007ffff7f80d17 in cu__encode_btf (cu=0x55555638d9b0, verbose=0,
> force=false, skip_encoding_vars=false) at
> /usr/src/debug/dwarves-1.18-1.1.x86_64/btf_encoder.c:255
> > #8  0x000055555555ac4d in pahole_stealer (cu=0x55555638d9b0,
> conf_load=<optimized out>) at
> /usr/src/debug/dwarves-1.18-1.1.x86_64/pahole.c:2366
> > #9  0x00007ffff7f89dab in finalize_cu (cus=0x5555555622d0,
> dcu=0x7fffffffd080, conf=0x5555555610e0 <conf_load>, cu=0x55555638d9b0) at
> /usr/src/debug/dwarves-1.18-1.1.x86_64/dwarf_loader.c:2473
> > #10 finalize_cu_immediately (conf=0x5555555610e0 <conf_load>,
> dcu=0x7fffffffd080, cu=0x55555638d9b0, cus=0x5555555622d0) at
> /usr/src/debug/dwarves-1.18-1.1.x86_64/dwarf_loader.c:2317
> > #11 cus__load_module (cus=cus@entry=0x5555555622d0, conf=0x5555555610e0
> <conf_load>, mod=mod@entry=0x555555564760, dw=0x555555565960,
> elf=elf@entry=0x555555562360, filename=0x7fffffffe846 "ss") at
> /usr/src/debug/dwarves-1.18-1.1.x86_64/dwarf_loader.c:2473
> > #12 0x00007ffff7f8a0f1 in cus__process_dwflmod (dwflmod=0x555555564760,
> userdata=<optimized out>, name=<optimized out>, base=<optimized out>,
> arg=0x7fffffffe1b0) at
> /usr/src/debug/dwarves-1.18-1.1.x86_64/dwarf_loader.c:2518
> > #13 0x00007ffff7d4f571 in dwfl_getmodules () from /usr/lib64/libdw.so.1
> > #14 0x00007ffff7f823ed in cus__process_file (filename=0x7fffffffe846 "ss",
> fd=3, conf=<optimized out>, cus=0x5555555622d0) at
> /usr/src/debug/dwarves-1.18-1.1.x86_64/dwarf_loader.c:2571
> > #15 dwarf__load_file (cus=0x5555555622d0, conf=<optimized out>,
> filename=0x7fffffffe846 "ss") at
> /usr/src/debug/dwarves-1.18-1.1.x86_64/dwarf_loader.c:2588
> > #16 0x00007ffff7f76771 in cus__load_file (cus=cus@entry=0x5555555622d0,
> conf=conf@entry=0x5555555610e0 <conf_load>, filename=0x7fffffffe846 "ss") at
> /usr/src/debug/dwarves-1.18-1.1.x86_64/dwarves.c:1958
> > #17 0x00007ffff7f798a8 in cus__load_files (cus=0x5555555622d0,
> conf=0x5555555610e0 <conf_load>, filenames=0x7fffffffe518) at
> /usr/src/debug/dwarves-1.18-1.1.x86_64/dwarves.c:2316
> > #18 0x00005555555576fc in main (argc=3, argv=0x7fffffffe508) at
> /usr/src/debug/dwarves-1.18-1.1.x86_64/pahole.c:2687
> 
> 
> I suspect:
> commit f3d9054ba8ff1df0fc44e507e3a01c0964cabd42
> Author:     Hao Luo <haoluo@google.com>
> AuthorDate: Wed Jul 8 13:44:10 2020 -0700
> 
>     btf_encoder: Teach pahole to store percpu variables in vmlinux BTF.
> 
> 
> Which added this machinery (btf_elf__add_datasec_type in particular).
> 
> > - [1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/pahole.c?h=v1.18&id=1abc001417b579b86a9b27ff88c9095d8f498a46
> > 
> > Thanks,
> > Érico
> > 
> 
> 
> -- 
> js
> suse labs

-- 

- Arnaldo
