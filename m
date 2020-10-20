Return-Path: <SRS0=WuSk=D3=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021ADC43457
	for <linux-dwarves@archiver.kernel.org>; Tue, 20 Oct 2020 09:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97CA7222C8
	for <linux-dwarves@archiver.kernel.org>; Tue, 20 Oct 2020 09:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603184507;
	bh=OA1qcr7/Pj8XH5ta0pxx+F4rhrYU1slhtPgp5uTAEeQ=;
	h=Subject:To:References:From:Date:In-Reply-To:List-ID:From;
	b=TBlrY/PYJ8J/xzNq26dm0HWzrLBriI3X98gxGDWwi/ayj2pxOJDx3OFZCORTLHYQE
	 LnXTPTiGvU8kzi3tYABub3ACURP1aV/Yeeqy7FoKu0y6YhFKnj8KVgqT8RcIXDTgxs
	 I5wjHi7nEL/6fLslv0vYf89L7vPAVj/VdnE8QAj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392285AbgJTJBr (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 20 Oct 2020 05:01:47 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:35978 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392287AbgJTJBo (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 20 Oct 2020 05:01:44 -0400
Received: by mail-ej1-f67.google.com with SMTP id qp15so1560997ejb.3;
        Tue, 20 Oct 2020 02:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I21QrYRSiNW5Fssisck9nCnQyQHsM9KlA2IytBaQecs=;
        b=V/UYjcanYovhp88wg3EA2rZigT5o8Ee8c4liLQ9keUAo6LDAzEscl/u6n8AlDcobsw
         cmEzHe74MALPJ3pcY7RJY/eS1NeQTX0XiAV0EyUM08DPzd0fDyxqlWtvG5CWjWmJzMpw
         s8ASBiH8jVzev5fG+6LySj7f65Pf6minXBNoDgB2DgPnfp97FaD03nm7U9Vq9/vbMz4u
         qzip/pGzyf0a49tnRXffTzuooKqdf+iK6IWpjLXUc8KhzQtCl+KqbTt5KVFfu/mIY0cv
         8f0t7Q7YvRY13xQ3hn6fmeVzobl90o99ofQvnv/nD1hnivGLJA7ISq2sxBTcc0yfXRm7
         cSiw==
X-Gm-Message-State: AOAM531G5/YilYgCjzwhd6K9zbqROX8CTsuS1whb2yIyeQnDooSlWJVD
        AFBbwX8LoFrcWcUUKIenFDQ=
X-Google-Smtp-Source: ABdhPJyVLCqbMqQ78S+5jQwOw0nWKVI/MYFYMbSlKL+Tu8reYDA1DB3CuTq/CJJyxWE1AsRG5yHQuw==
X-Received: by 2002:a17:906:d8a3:: with SMTP id qc3mr2127262ejb.183.1603184501961;
        Tue, 20 Oct 2020 02:01:41 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id e11sm1630465edq.5.2020.10.20.02.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 02:01:40 -0700 (PDT)
Subject: Re: Segfault in pahole 1.18 when building kernel 5.9.1 for arm64
To:     =?UTF-8?Q?=c3=89rico_Rolim?= <erico.erc@gmail.com>,
        dwarves@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Hao Luo <haoluo@google.com>
References: <CAFDeuWM7D-Upi84-JovKa3g8Y_4fjv65jND3--e9u-tER3WmVA@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <82b757bb-1f49-ab02-2f4b-89577d56fec9@kernel.org>
Date:   Tue, 20 Oct 2020 11:01:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAFDeuWM7D-Upi84-JovKa3g8Y_4fjv65jND3--e9u-tER3WmVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hi,

On 19. 10. 20, 1:18, Érico Rolim wrote:
> I'm trying to build kernel 5.9.1 for arm64, and my dotconfig has
> `CONFIG_DEBUG_INFO_BTF=y`, which requires pahole for building. However, pahole
> version 1.18 segfaults during the build, as can be seen below:
> 
> PAHOLE: Error: Found symbol of zero size when encoding btf (sym:
> '__kvm_nvhe_arm64_ssbd_callback_required', cu:
> 'arch/arm64/kernel/cpu_errata.c').

The symbol is an alias coming from arch/arm64/kernel/vmlinux.lds:
__kvm_nvhe_arm64_ssbd_callback_required = arm64_ssbd_callback_required;;

> PAHOLE: Error: Use '-j' or '--force' to ignore such symbols and force
> emit the btf.
> scripts/link-vmlinux.sh: line 141: 43837 Segmentation fault
> LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
>    LD      .tmp_vmlinux.kallsyms1
>    KSYM    .tmp_vmlinux.kallsyms1.o
>    LD      .tmp_vmlinux.kallsyms2
>    KSYM    .tmp_vmlinux.kallsyms2.o
>    LD      vmlinux
>    BTFIDS  vmlinux
> FAILED: load BTF from vmlinux: Unknown error -2make: ***
> [Makefile:1162: vmlinux] Error 255
> 
> It is possible to force the build to continue if
> 
>    LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
> 
> in scripts/link-vmlinux.sh is changed to
> 
>    LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J --btf_encode_force ${1}
> 
> The suggested `-j` or `--force` flags don't exist, since they were removed in
> [1]. I believe `--btf_encode_force` should be suggested instead.

Agreed, '--btf_encode_force' makes pahole to proceed without crashes.

> It should be noted that the same build, but with pahole version 1.17, works
> without issue, so I think this is either a regression in pahole or the script
> will need to be changed for newer versions of pahole.

Yeah, I observe the very same. I reported it at:
https://bugzilla.suse.com/show_bug.cgi?id=1177921

The backtrace:
 > (gdb) where
 > #0  __memmove_sse2_unaligned_erms () at 
../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:300
 > #1  0x00007ffff7f78346 in memcpy (__len=<optimized out>, 
__src=<optimized out>, __dest=<optimized out>, __dest=<optimized out>, 
__src=<optimized out>, __len=<optimized out>) at 
/usr/include/bits/string_fortified.h:34
 > #2  gobuffer__add (gb=0x555555569aa0, s=0x7fffffffb50c, len=12) at 
/usr/src/debug/dwarves-1.18-1.1.x86_64/gobuffer.c:87
 > #3  0x00007ffff7f8671f in btf_elf__add_datasec_type 
(btfe=btfe@entry=0x555555569a40, 
section_name=section_name@entry=0x7ffff7fa43ad ".data..percpu", 
var_secinfo_buf=var_secinfo_buf@entry=0x555555569ac0) at 
/usr/src/debug/dwarves-1.18-1.1.x86_64/libbtf.c:721
 > #4  0x00007ffff7f8d766 in btf_elf__encode (flags=0 '\000', 
btfe=0x555555569a40) at /usr/src/debug/dwarves-1.18-1.1.x86_64/libbtf.c:857
 > #5  btf_elf__encode (btfe=0x555555569a40, flags=<optimized out>) at 
/usr/src/debug/dwarves-1.18-1.1.x86_64/libbtf.h:71
 > #6  0x00007ffff7f7fc70 in btf_encoder__encode () at 
/usr/src/debug/dwarves-1.18-1.1.x86_64/btf_encoder.c:213
 > #7  0x00007ffff7f80d17 in cu__encode_btf (cu=0x55555638d9b0, 
verbose=0, force=false, skip_encoding_vars=false) at 
/usr/src/debug/dwarves-1.18-1.1.x86_64/btf_encoder.c:255
 > #8  0x000055555555ac4d in pahole_stealer (cu=0x55555638d9b0, 
conf_load=<optimized out>) at 
/usr/src/debug/dwarves-1.18-1.1.x86_64/pahole.c:2366
 > #9  0x00007ffff7f89dab in finalize_cu (cus=0x5555555622d0, 
dcu=0x7fffffffd080, conf=0x5555555610e0 <conf_load>, cu=0x55555638d9b0) 
at /usr/src/debug/dwarves-1.18-1.1.x86_64/dwarf_loader.c:2473
 > #10 finalize_cu_immediately (conf=0x5555555610e0 <conf_load>, 
dcu=0x7fffffffd080, cu=0x55555638d9b0, cus=0x5555555622d0) at 
/usr/src/debug/dwarves-1.18-1.1.x86_64/dwarf_loader.c:2317
 > #11 cus__load_module (cus=cus@entry=0x5555555622d0, 
conf=0x5555555610e0 <conf_load>, mod=mod@entry=0x555555564760, 
dw=0x555555565960, elf=elf@entry=0x555555562360, filename=0x7fffffffe846 
"ss") at /usr/src/debug/dwarves-1.18-1.1.x86_64/dwarf_loader.c:2473
 > #12 0x00007ffff7f8a0f1 in cus__process_dwflmod 
(dwflmod=0x555555564760, userdata=<optimized out>, name=<optimized out>, 
base=<optimized out>, arg=0x7fffffffe1b0) at 
/usr/src/debug/dwarves-1.18-1.1.x86_64/dwarf_loader.c:2518
 > #13 0x00007ffff7d4f571 in dwfl_getmodules () from /usr/lib64/libdw.so.1
 > #14 0x00007ffff7f823ed in cus__process_file (filename=0x7fffffffe846 
"ss", fd=3, conf=<optimized out>, cus=0x5555555622d0) at 
/usr/src/debug/dwarves-1.18-1.1.x86_64/dwarf_loader.c:2571
 > #15 dwarf__load_file (cus=0x5555555622d0, conf=<optimized out>, 
filename=0x7fffffffe846 "ss") at 
/usr/src/debug/dwarves-1.18-1.1.x86_64/dwarf_loader.c:2588
 > #16 0x00007ffff7f76771 in cus__load_file 
(cus=cus@entry=0x5555555622d0, conf=conf@entry=0x5555555610e0 
<conf_load>, filename=0x7fffffffe846 "ss") at 
/usr/src/debug/dwarves-1.18-1.1.x86_64/dwarves.c:1958
 > #17 0x00007ffff7f798a8 in cus__load_files (cus=0x5555555622d0, 
conf=0x5555555610e0 <conf_load>, filenames=0x7fffffffe518) at 
/usr/src/debug/dwarves-1.18-1.1.x86_64/dwarves.c:2316
 > #18 0x00005555555576fc in main (argc=3, argv=0x7fffffffe508) at 
/usr/src/debug/dwarves-1.18-1.1.x86_64/pahole.c:2687


I suspect:
commit f3d9054ba8ff1df0fc44e507e3a01c0964cabd42
Author:     Hao Luo <haoluo@google.com>
AuthorDate: Wed Jul 8 13:44:10 2020 -0700

     btf_encoder: Teach pahole to store percpu variables in vmlinux BTF.


Which added this machinery (btf_elf__add_datasec_type in particular).

> - [1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/pahole.c?h=v1.18&id=1abc001417b579b86a9b27ff88c9095d8f498a46
> 
> Thanks,
> Érico
> 


-- 
js
suse labs
