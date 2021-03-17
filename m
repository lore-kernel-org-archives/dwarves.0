Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1D0C433DB
	for <linux-dwarves@archiver.kernel.org>; Wed, 17 Mar 2021 23:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D70C664F24
	for <linux-dwarves@archiver.kernel.org>; Wed, 17 Mar 2021 23:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCQX1K (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 17 Mar 2021 19:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhCQX1C (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 17 Mar 2021 19:27:02 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EF0C06174A
        for <dwarves@vger.kernel.org>; Wed, 17 Mar 2021 16:27:02 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id bt4so1931343pjb.5
        for <dwarves@vger.kernel.org>; Wed, 17 Mar 2021 16:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=8S32ug4CQqcdmyM0JNI3B9stLwddO49pPlNnXcRlfxw=;
        b=NKjv7n5lgWwQRnmjhfsj3D+efcWRXL6O59dcAZsgQiuSIETuTdxKDvyvQpYV05IfdG
         gONgYRVCKZ06B2uy8CsZNLn9Sixs3dwWZmzDXA/O0cuaM8psnGh0i1zg3gXCqXfICwb+
         nEJ8+yvLP06OVR8dU2kC5TI/3ea44Xujkzs4IT3Gw78rPW0cS21ss7viV00RMp3Knw9f
         qNu2TEPXUZcE5D9Vfp3P3RiLpT7+y/KZoGIYSTCt29QwjLSR1KTPsIMzVrBhq1FCOg5n
         s3cFg6bpxlRbExLC49tfAAn4Xu/ZWqOBFwe8kJ61GY8VieoLNAi1vD/xQhlp9NiM6WcC
         2bUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=8S32ug4CQqcdmyM0JNI3B9stLwddO49pPlNnXcRlfxw=;
        b=Zd1Kmpy3gXFe6mSfap7pYroamH0Sxv4Feu2Zvd61W6hpPUjVGqtxLC3HihV3qy5VjR
         UO+EyVOG7m7w72iAdFdWlZfcoHF7kTDWMXzkIEInIZGsINv90hEsLIere7PpEc6/be4N
         BMknj/yMs47yBv0aecNzQb+PaMynis5Q6+swmsRzFBqkLKWRd79GIthNFsEGqYw/RdTI
         +U7R6FCv34EO92eVaIjt5Djmy60N2y5MN5XAZVyanw/F8ldvqxG1CyLJqQcY2qoIucKP
         Rbe6aCbk3o7YgRlpibHwKJ3y8geYOpFgv2caulxCeE3pwZTCNxiwd4rz4KWgz/kGRfe3
         YxqQ==
X-Gm-Message-State: AOAM533jT+lel45fMkMBYlzLgN3wN4mEp00HdMycucG0qT134ZWrCFcg
        fYkibnZkdAG/g4ce+brwto/Xd+kbxzySCg==
X-Google-Smtp-Source: ABdhPJxlZmHFbkqaNuOpTio4HVUxrKM2Wehq9hWKX1q6yC//ftG/nSiJ1FSmVVmj8PSJsmfYWjKKow==
X-Received: by 2002:a17:90a:ff05:: with SMTP id ce5mr1165831pjb.156.1616023621707;
        Wed, 17 Mar 2021 16:27:01 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:3974:b32d:1ca1:54f9])
        by smtp.gmail.com with ESMTPSA id v1sm145943pgh.17.2021.03.17.16.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 16:27:00 -0700 (PDT)
Date:   Wed, 17 Mar 2021 16:26:57 -0700
From:   Fangrui Song <maskray@google.com>
To:     dwarves@vger.kernel.org
Cc:     Bill Wendling <morbo@google.com>
Subject: pahole -J usage in kernel scripts/link-vmlinux.sh
Message-ID: <20210317232657.mdnsuoqx6nbddjgt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hi BTF folks,

I have discovered some problems with pahole -J.
Its usage in kernel scripts/link-vmlinux.sh is like (make LLVM=1 bzImage):

ld.lld -m elf_x86_64 --emit-relocs --discard-none -z max-page-size=0x200000 --build-id=sha1 --orphan-handling=warn -o .tmp_vmlinux.btf -T ./arch/x86/kernel/vmlinux.lds --whole-archive arch/x86/kernel/head_64.o arch/x86/kernel/head64.o arch/x86/kernel/ebda.o arch/x86/kernel/platform-quirks.o init/built-in.a usr/built-in.a arch/x86/built-in.a kernel/built-in.a certs/built-in.a mm/built-in.a fs/built-in.a ipc/built-in.a security/built-in.a crypto/built-in.a block/built-in.a lib/built-in.a arch/x86/lib/built-in.a lib/lib.a arch/x86/lib/lib.a drivers/built-in.a sound/built-in.a net/built-in.a virt/built-in.a arch/x86/pci/built-in.a arch/x86/power/built-in.a arch/x86/video/built-in.a --no-whole-archive --start-group --end-group
pahole -J .tmp_vmlinux.btf
llvm-objcopy --only-section=.BTF --set-section-flags .BTF=alloc,readonly --strip-all .tmp_vmlinux.btf .btf.vmlinux.bin.o

pahole -J adds .BTF and rewrites .tmp_vmlinux.btf, then llvm-objcopy produces .btf.vmlinux.bin.o of just one section.
Why doesn't pahole provide a command generating an object file with just the .BTF section?



When I contributed https://git.kernel.org/linus/90ceddcb495008ac8ba7a3dce297841efcd7d584 ,
I remember pahole at that time added a non-SHF_ALLOC .BTF , now (1.20) .BTF becomes SHF_ALLOC.
This is problematic if pahole does not have full-fledged binary manipulation ability (objcopy,llvm-objcopy).

In particular, there are two bugs:

* pahole does not respect max-page-size (p_align of PT_LOAD). See the .text section, its
   sh_offset != sh_addr (mod max-page-size)

  Section Headers:
    [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
    [ 0]                   NULL            0000000000000000 000000 000000 00      0   0  0
-  [ 1] .text             PROGBITS        ffffffff81000000 200000 1003917 00  AX  0   0 4096
+  [ 1] .text             PROGBITS        ffffffff81000000 001000 e0169a 00  AX  0   0 4096

* pahole does not rewrite p_offset/p_filesz of PT_LOAD segments.
   Because of the first bug, pahole -J rewritten object file generally has small offsets.
   If p_offset/p_filesz of PT_LOAD segments are not rewritten, the file offset range of .symtab may be within
   a PT_LOAD range. llvm-objcopy --strip-all considers .symtab as part of the PT_LOAD and refuses --strip-all:

   error: '.tmp_vmlinux.btf': string table '.strtab' cannot be removed because it is referenced by the symbol table '.symtab'

   This is very rare, though.


So I suggest:

* pahole -J: restore the previous non-SHF_ALLOC behavior. Don't rewrite sh_offset of existing sections.
   Place the new non-SHF_ALLOC .BTF section at the end.
   Then not rewriting PT_LOAD will be justified.
* Add a new option incorporating the current pahole -J + llvm-objcopy
