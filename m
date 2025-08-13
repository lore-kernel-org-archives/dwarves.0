Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6252FC884
	for <dwarves@vger.kernel.org>; Wed, 13 Aug 2025 23:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755128713; cv=none; b=s7NfoE575fLDEZflnQq8jy0w555e+eJiTRfxhECQc4LCN6gtKoopnMuXcseJSUz14/TfEjHirfUa9vl1BTMpIuj9Qk5dUTCn1L7E/V8SckfAOLjmuTVX6Kn7/9YpwI573zieOj+/ZnEyFBiGJ/8UsoJVIwRRIcMS66o2qFc+2TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755128713; c=relaxed/simple;
	bh=5aUTDnh+mcN/BWRklgvCVJflxYOpUHUwoyNbRQkg39o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WPbiXfLvxips7/vJ/Rp4xvqq0DdIOSa00UTtmjrVzX5OmLDLLH5eixASAZOhSSVK/hlxcwq2j3vw26EBWVlYVItcXNdzV3Kd27dRHDiODYFNMpgLIEg3xnxJyeHmCyLCYXu2C65jBxs7VGcFYfeVO0HBL3Hd/LSykX2DmL6QZZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OKNRNnbZ; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OKNRNnbZ"
Message-ID: <37030a9d-28d8-4871-8acb-b26c59240710@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755128704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q3JG7jc2QQZ+5GVCee6Wio6B1JGUx68ByGIWarhKWvM=;
	b=OKNRNnbZimhXaSnDV5ZdCZMahJWeWPFc1DqJocfc698EtdnO3k31lvoz3fd859SymEZfrd
	IIotzvKHZMkmGfIxQAVg4ZKd+Ass9eFUnvVZNd6yrPGJEkmdQDr87fJuM/KJ3MeWGdyuSK
	0HsmZ/ZiaWSCVLvKurA9VCd5jX6+Pw0=
Date: Wed, 13 Aug 2025 16:45:00 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: "Segmentation fault" of pahole
To: Changqing Li <changqing.li@windriver.com>, acme@kernel.org,
 dwarves@vger.kernel.org
References: <24bcc853-533c-42ab-bc37-0c13e0baa217@windriver.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <24bcc853-533c-42ab-bc37-0c13e0baa217@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/10/25 6:18 PM, Changqing Li wrote:
> Hi,  Dear maintainers
> 
> I met a "Segmentation fault" error of pahole.   It happened when I 
> passed an ELF file without .symtab section.
> Maybe I passed an  unsupport file, but I think it should not segfault, 
> maybe  a warnning or error message is better.
> 
> 
> Here is the detailed info:
> Pahole version:
> # pahole --version
> v1.29
> 
> Reproduce Command:
> root@intel-x86-64:/~# pahole --btf_features=default -J /boot/ 
> vmlinux-6.12.40-yocto-standard
> pahole[599]: segfault at 8 ip 00007f7c92d819e2 sp 00007f7c799febe0 error 
> 6 in libdwarves.so.1.0.0[189e2,7f7c92d72000+1c000] likely on CPU 0 (core 
> 0, socket 0)
> Code: 74 19 ff ff 48 39 dd 75 ef 4c 89 ef e8 67 19 ff ff 49 8b 7c 24 18 
> e8 8d 13 ff ff 49 8b 14 24 49 8b 44 24 08 4c 89 e7 45 31 e4 <48> 89 42 
> 08 48 89 10 e8 42 19 ff ff e9 30 ff ff ff e8 58 0a ff ff
> Segmentation fault (core dumped)
> 
> root@intel-x86-64:~# file /boot/vmlinux-6.12.40-yocto-standard
> /boot/vmlinux-6.12.40-yocto-standard: ELF 64-bit LSB executable, x86-64, 
> version 1 (SYSV), statically linked, 
> BuildID[sha1]=1e73fe48101f07b9d991dc045ab9f9672a0feac0, stripped
> 
> root@intel-x86-64:/usr/bin# readelf -S /boot/vmlinux-6.12.40-yocto- 
> standard | grep .symtab
>    [ 4] __ksymtab         PROGBITS         ffffffff82c11e00  01e11e00
>    [ 5] __ksymtab_gpl     PROGBITS         ffffffff82c24730  01e24730
>    [ 6] __ksymtab_strings PROGBITS         ffffffff82c397f0  01e397f0
> 
> 
> (gdb) bt
> #0  elf_functions__new (elf=<optimized out>) at /usr/src/debug/ 
> pahole/1.29/btf_encoder.c:196
> #1  0x00007ffff7f92a7d in btf_encoder__elf_functions 
> (encoder=encoder@entry=0x7fffd8008dc0) at /usr/src/debug/pahole/1.29/ 
> btf_encoder.c:1374
> #2  0x00007ffff7f94489 in btf_encoder__new (cu=cu@entry=0x7fffd8001e50, 
> detached_filename=<optimized out>, warning: could not convert 'btf' from 
> the host encoding (ANSI_X3.4-1968) to UTF-32.
> This normally should not happen, please file a bug report.
> base_btf=0x0,
>      verbose=<optimized out>, conf_load=conf_load@entry=0x555555565280 
> <conf_load>) at /usr/src/debug/pahole/1.29/btf_encoder.c:2431
> #3  0x000055555555db49 in pahole_stealer__btf_encode (cu=0x7fffd8001e50, 
> conf_load=0x555555565280 <conf_load>)
>      at /usr/src/debug/pahole/1.29/pahole.c:3126
> #4  pahole_stealer (cu=0x7fffd8001e50, conf_load=0x555555565280 
> <conf_load>) at /usr/src/debug/pahole/1.29/pahole.c:3187
> #5  0x00007ffff7f9d023 in cus__steal_now (cus=<optimized out>, 
> cu=<optimized out>, conf=<optimized out>)
>      at /usr/src/debug/pahole/1.29/dwarf_loader.c:3266
> #6  dwarf_loader__worker_thread (arg=0x7fffffffe700) at /usr/src/debug/ 
> pahole/1.29/dwarf_loader.c:3672
> #7  0x00007ffff7dbe722 in start_thread (arg=<optimized out>) at 
> pthread_create.c:448
> #8  0x00007ffff7e314fc in __GI___clone3 () at ../sysdeps/unix/sysv/ 
> linux/x86_64/clone3.S:78
> (gdb)
> 
> 
> Command  "pahole --btf_features=default -J /boot/.debug/vmlinux-6.12.40- 
> yocto-standard " works well since   /boot/.debug/vmlinux-6.12.40-yocto- 
> standard has  .symtab section.
> root@intel-x86-64:/usr/bin# file /boot/.debug/vmlinux-6.12.40-yocto- 
> standard
> /boot/.debug/vmlinux-6.12.40-yocto-standard: ELF 64-bit LSB executable, 
> x86-64, version 1 (SYSV), statically linked, 
> BuildID[sha1]=1e73fe48101f07b9d991dc045ab9f9672a0feac0, with debug_info, 
> not stripped
> 
> root@intel-x86-64:/usr/bin# readelf -S /boot/.debug/vmlinux-6.12.40- 
> yocto-standard | grep .symtab
>    [ 4] __ksymtab         NOBITS           ffffffff82c11e00  00001000
>    [ 5] __ksymtab_gpl     NOBITS           ffffffff82c24730  00001000
>    [ 6] __ksymtab_strings NOBITS           ffffffff82c397f0  00001000
>    [49] .symtab           SYMTAB           0000000000000000  154cf200
> 

Hi Changqing Li, thanks for the bug report.

I couldn't reproduce this error with a stripped vmlinux:

$ objcopy --strip-all ~/kernels/bpf-next/.tmp_vmlinux1 vmlinux-strip-all

v1.29 fails with:
$ ./build/pahole --btf_features=default -J $(realpath vmlinux-strip-all)
Error creating BTF encoder.

v1.30 fails with:
$ ./build/pahole --btf_features=default -J $(realpath vmlinux-strip-all)
pahole: /home/isolodrai/pahole/vmlinux-strip-all: Invalid argument

Different errors are not nice, but at least no segfault.

Could you please share the vmlinux binary that causes the error?
And also check if you get a segfault on v1.30 too?

Thanks.

> 
> Analyzation:
> if the ELF file doesn't have .symtab section, in function | 
> elf_functions__new, |funcs->symtab will be NULL, goto out_delete, then 
> run elf_functions__delete.
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/ 
> btf_encoder.c?id=06350d14776a77e16ea5064030fea63bbdd22f27#n176
> 
> And segfault happened in line: list_del(&funcs->node), since funcs- 
>  >node  not added into the list elf_functions_list yet.
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tree/ 
> btf_encoder.c?id=06350d14776a77e16ea5064030fea63bbdd22f27#n170
> 
> Should we check if the node is added into list elf_functions_list before 
> list_del?  Please help to review this issue, thanks.
> 
> Regards
> Changqing
> 
> 
> 
> 

