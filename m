Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77032C433FE
	for <linux-dwarves@archiver.kernel.org>; Wed,  5 Oct 2022 16:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiJEQ7Q (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 5 Oct 2022 12:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJEQ7P (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 5 Oct 2022 12:59:15 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EEA62A95
        for <dwarves@vger.kernel.org>; Wed,  5 Oct 2022 09:59:14 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id w191so6883010pfc.5
        for <dwarves@vger.kernel.org>; Wed, 05 Oct 2022 09:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cryptohaze-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l1/c9PnkC4Q/fsotPEkvhuUS21SuYoqIUbm3xp9gc/A=;
        b=UhTz4K/YKJwMMOySZEUJPFl5s36fcjUhZNwn3AR4KCZdCm8lVA34TqkEL0xazw9ZKM
         WJpAg9zx0uiuoLLpz7b4Mu4TeJV/QoDW7WfNSAWAa7UsMv/C5GHVCetYF4Q0IxbnOAR7
         SV3SP/GIg6DM+lUj3hszTCAoYI61/aK2Ln9ogtgUMz7HXc19B3gdtshCPAsKK3rtMSCE
         PC8Qzp8zsOzDtqaJsnTfJ1Yx/aVhY0+CNrv1G0ysIG8PAp31qNTxEzC/EJJN9JuPBZQs
         LgZczeIWZman9pJ9Dy2AByBc1NIzcIuqW9KMtartoAx4g4RT/2tVf8DyTAQqAmyqhrZp
         9i1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1/c9PnkC4Q/fsotPEkvhuUS21SuYoqIUbm3xp9gc/A=;
        b=vDGNII2M5F/UyDzHPFRTNhjfiaNDU/DqGVCHfJuwdnb1A6Rob6vzuNSgB152LLXGig
         XFdsaKsazzL/cqnv/HjstUc+8oHzqLhiHhA8W56tLijw+JVIoYDhUVGmh/hwL+nZJ5Ws
         QYGWAFBKopgx7jRoMUs0O6Rahbf4qID90HpIE+112TPylu9dTBuZ4Bn2kUGXELUETzMp
         aAMpA8PLE9MbJQa1Pix6aVa8lex46IaZAC8XFWRatD7Ncju5dj3laGSemfroS3ww2VZm
         5bWRf7k7RSue/aZjQe1GIrhSUii5VbK5KkBpA4esWONcTur7GGGVdcapiYktXIOHxh2B
         k54g==
X-Gm-Message-State: ACrzQf2mziRK5pbOtmlknGN2inLsQcSXJ6WQiYsnhGvPy0Hx6QGBKDJ1
        paMUCJN+VkmF1GD/FhorjFXAbkKykPmoi96cV/A=
X-Google-Smtp-Source: AMsMyM73g9OQ/Qi3mu8+Bfh66FVKR8FRPMbpui13jb4wC/ofEupFbAU3NIyEt966J/lPb8DddzEJbg==
X-Received: by 2002:a63:6742:0:b0:452:59b9:22e with SMTP id b63-20020a636742000000b0045259b9022emr614323pgc.205.1664989153358;
        Wed, 05 Oct 2022 09:59:13 -0700 (PDT)
Received: from [10.137.0.11] ([66.195.179.45])
        by smtp.gmail.com with ESMTPSA id j9-20020a170903024900b0017d97d13b18sm3231425plh.65.2022.10.05.09.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 09:59:12 -0700 (PDT)
Message-ID: <202acb12-2e38-1ba1-500a-ae9827fecf61@cryptohaze.com>
Date:   Wed, 5 Oct 2022 10:59:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: Ubuntu kernels and die__process: DW_TAG ... got INVALID!
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org
References: <17a34291-e28c-b08d-cfec-d455c72c4c54@cryptohaze.com>
 <Yz12qzXbbGPzH2Bl@kernel.org>
From:   Bitweasil <bitweasil@cryptohaze.com>
In-Reply-To: <Yz12qzXbbGPzH2Bl@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org


On 10/5/22 06:20, Arnaldo Carvalho de Melo wrote:
> Em Tue, Oct 04, 2022 at 03:10:06PM -0600, Bitweasil escreveu:
>> When trying to extract the layout of kernel structures that should exist on
>> recent kernels from the Ubuntu debug kernel repo, I get the following error:
>>
>> die__process: DW_TAG_compile_unit, DW_TAG_type_unit or DW_TAG_partial_unit
>> expected got INVALID!
>> pahole: type 'mount' not found
>>
>> As far as I can tell, 'struct mount' should still exist - and I can pull
>> other structures out without trouble.  The issue starts appearing somewhere
>> in the 5.15 kernel version - earlier kernels work exactly as expected and I
>> can extract the full offsets.
>>
>> https://elixir.bootlin.com/linux/v5.15.48/source/fs/mount.h indicates that
>> 'struct mount' still exists in the source, and it remains present into the
>> 6.0 kernel with no substantial changes. I can also produce the same response
>> with some of the other structures in that file - mountpoint, mnt_namespace,
>> and mnt_pcp all lead to the same error message.
>>
>> I've tried building pahole from head (Oct 4, 2022, e819d737) without any
>> changes to the behavior, and v1.21 and 1.24 both lead to the same results.
> Are you sure? The error message should be this in 1.24:
>
> because:
>
>          if (tag == DW_TAG_skeleton_unit) {
>                  static bool warned;
>
>                  if (!warned) {
>                          fprintf(stderr, "WARNING: DW_TAG_skeleton_unit used, please look for a .dwo file and use it instead.\n"
>                                          "         A future version of pahole will support do this automagically.\n");
>                          warned = true;
>                  }
>                  return 0; // so that other units can be processed
>          }
>
>          if (tag == DW_TAG_partial_unit) {
>                  static bool warned;
>
>                  if (!warned) {
>                          fprintf(stderr, "WARNING: DW_TAG_partial_unit used, some types will not be considered!\n"
>                                          "         Probably this was optimized using a tool like 'dwz'\n"
>                                          "         A future version of pahole will support this.\n");
>                          warned = true;
>                  }
>                  return 0; // so that other units can be processed
>          }
>
>          if (tag != DW_TAG_compile_unit && tag != DW_TAG_type_unit) {
>                  fprintf(stderr, "%s: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got %s (0x%x)!\n",
>                          __FUNCTION__, dwarf_tag_name(tag), tag);
>                  return -EINVAL;
>          }

Yes, I recognize the error text is slightly different in 1.24, but it 
was the same error with either version.

However, seeing that it worked for your system led to some 
experimentation, and I believe the issue is one of either libdw or 
libelf versions.  I did my initial testing on Ubuntu 20.04, which has 
libdw/libelf 0.176-1.1build1 - and building 1.24 and head from source 
fail on that.

If I add the "-F btf" flag, v1.21 on 20.04 is able to get the structure.

However, on Ubuntu 22.04, with libdw/libelf 0.186-1build1, I get the 
expected results without "-F btf", even with pahole v1.22.

This gives me several options that resolve the issue usefully - thank 
you for your prompt response and testing!

-Bit

> But its strange, there are no units other than DW_TAG_compile_unit in
> that vmlinux file:
>
> ⬢[acme@toolbox boot]$ readelf -wi vmlinux-5.15.0-48-generic | grep 'DW_TAG_.*_unit' | grep -v DW_TAG_compile_unit
> ⬢[acme@toolbox boot]$
>   
>> Steps to reproduce (warning, will take ~10GB - the unzipped kernel debug
>> symbols are rather large):
>   
>> cd /tmp
>> wget http://ddebs.ubuntu.com/pool/main/l/linux/linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb
>> ar x linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb
>> tar -xf data.tar.xz
>> cd usr/lib/debug/boot
>> pahole -C mount vmlinux-5.15.0-48-generic
>> die__process: DW_TAG_compile_unit, DW_TAG_type_unit or DW_TAG_partial_unit
>> expected got INVALID!
>> pahole: type 'mount' not found
>> Any suggestions on how to resolve this?  I'm not familiar enough with the
>> various debug formats to know how to troubleshoot beyond this point right
>> now.
> Works for me:
>
> ⬢[acme@toolbox pahole]$ wget http://ddebs.ubuntu.com/pool/main/l/linux/linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb
> --2022-10-05 09:11:56--  http://ddebs.ubuntu.com/pool/main/l/linux/linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb
> Resolving ddebs.ubuntu.com (ddebs.ubuntu.com)... 185.125.190.17, 91.189.91.48, 91.189.91.49, ...
> Connecting to ddebs.ubuntu.com (ddebs.ubuntu.com)|185.125.190.17|:80... connected.
> HTTP request sent, awaiting response... 200 OK
> Length: 1055842672 (1007M) [application/vnd.debian.binary-package]
> Saving to: ‘linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb’
>
> linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.dde 100%[===================================================================================================================================================================>]   1007M  13.3MB/s    in 74s
>
> 2022-10-05 09:13:11 (13.5 MB/s) - ‘linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb’ saved [1055842672/1055842672]
>
> ⬢[acme@toolbox pahole]$ mkdir ubuntu-kernel
> ⬢[acme@toolbox pahole]$ mv linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb ubuntu-kernel
> ⬢[acme@toolbox pahole]$ cd ubuntu-kernel
> ⬢[acme@toolbox ubuntu-kernel]$ ls -la
> total 1031148
> drwxr-xr-x. 1 acme acme        138 Oct  5 09:13 .
> drwxrwxr-x. 1 acme acme       5074 Oct  5 09:13 ..
> -rw-r--r--. 1 acme acme 1055842672 Aug 31 08:39 linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb
> ⬢[acme@toolbox ubuntu-kernel]$ ar x linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb
> ⬢[acme@toolbox ubuntu-kernel]$ ls -la
> total 2062252
> drwxr-xr-x. 1 acme acme        214 Oct  5 09:13 .
> drwxrwxr-x. 1 acme acme       5074 Oct  5 09:13 ..
> -rw-r--r--. 1 acme acme     155352 Oct  5 09:13 control.tar.xz
> -rw-r--r--. 1 acme acme 1055687128 Oct  5 09:13 data.tar.xz
> -rw-r--r--. 1 acme acme          4 Oct  5 09:13 debian-binary
> -rw-r--r--. 1 acme acme 1055842672 Aug 31 08:39 linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb
> ⬢[acme@toolbox ubuntu-kernel]$ tar -xf data.tar.xz
> ⬢[acme@toolbox ubuntu-kernel]$ cd usr/lib/debug/boot
> ⬢[acme@toolbox boot]$ ls -la
> total 719136
> drwxr-xr-x. 1 acme acme        50 Aug 26 06:12 .
> drwxr-xr-x. 1 acme acme        14 Oct  5 09:13 ..
> -rw-r--r--. 1 acme acme 736393784 Aug 26 06:12 vmlinux-5.15.0-48-generic
> ⬢[acme@toolbox boot]$ ls -la
> total 719136
> drwxr-xr-x. 1 acme acme        50 Aug 26 06:12 .
> drwxr-xr-x. 1 acme acme        14 Oct  5 09:13 ..
> -rw-r--r--. 1 acme acme 736393784 Aug 26 06:12 vmlinux-5.15.0-48-generic
> ⬢[acme@toolbox boot]$ pahole -C mount vmlinux-5.15.0-48-generic
> struct mount {
> 	struct hlist_node          mnt_hash;             /*     0    16 */
> 	struct mount *             mnt_parent;           /*    16     8 */
> 	struct dentry *            mnt_mountpoint;       /*    24     8 */
> 	struct vfsmount            mnt;                  /*    32    32 */
> 	/* --- cacheline 1 boundary (64 bytes) --- */
> 	union {
> 		struct callback_head mnt_rcu __attribute__((__aligned__(8))); /*    64    16 */
> 		struct llist_node  mnt_llist;            /*    64     8 */
> 	} __attribute__((__aligned__(8)));               /*    64    16 */
> 	struct mnt_pcp *           mnt_pcp;              /*    80     8 */
> 	struct list_head           mnt_mounts;           /*    88    16 */
> 	struct list_head           mnt_child;            /*   104    16 */
> 	struct list_head           mnt_instance;         /*   120    16 */
> 	/* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
> 	const char  *              mnt_devname;          /*   136     8 */
> 	struct list_head           mnt_list;             /*   144    16 */
> 	struct list_head           mnt_expire;           /*   160    16 */
> 	struct list_head           mnt_share;            /*   176    16 */
> 	/* --- cacheline 3 boundary (192 bytes) --- */
> 	struct list_head           mnt_slave_list;       /*   192    16 */
> 	struct list_head           mnt_slave;            /*   208    16 */
> 	struct mount *             mnt_master;           /*   224     8 */
> 	struct mnt_namespace *     mnt_ns;               /*   232     8 */
> 	struct mountpoint *        mnt_mp;               /*   240     8 */
> 	union {
> 		struct hlist_node  mnt_mp_list;          /*   248    16 */
> 		struct hlist_node  mnt_umount;           /*   248    16 */
> 	};                                               /*   248    16 */
> 	/* --- cacheline 4 boundary (256 bytes) was 8 bytes ago --- */
> 	struct list_head           mnt_umounting;        /*   264    16 */
> 	struct fsnotify_mark_connector * mnt_fsnotify_marks; /*   280     8 */
> 	__u32                      mnt_fsnotify_mask;    /*   288     4 */
> 	int                        mnt_id;               /*   292     4 */
> 	int                        mnt_group_id;         /*   296     4 */
> 	int                        mnt_expiry_mark;      /*   300     4 */
> 	struct hlist_head          mnt_pins;             /*   304     8 */
> 	struct hlist_head          mnt_stuck_children;   /*   312     8 */
>
> 	/* size: 320, cachelines: 5, members: 27 */
> 	/* forced alignments: 1 */
> } __attribute__((__aligned__(8)));
>
> ⬢[acme@toolbox boot]$ pahole --version
> v1.24
> ⬢[acme@toolbox boot]$
>
> And it even has BTF info, which makes processing much faster but without
> some attributes:
>
> ⬢[acme@toolbox boot]$ readelf -SW vmlinux-5.15.0-48-generic | grep -i btf
>    [28] .BTF              PROGBITS        ffffffff8279d1e0 199d1e0 4ef6b2 00   A  0   0  1
>    [29] .BTF_ids          PROGBITS        ffffffff82c8c894 1e8c894 0005e8 00   A  0   0  1
> ⬢[acme@toolbox boot]$
>
> ⬢[acme@toolbox boot]$ pahole -F btf -C mount vmlinux-5.15.0-48-generic
> struct mount {
> 	struct hlist_node          mnt_hash;             /*     0    16 */
> 	struct mount *             mnt_parent;           /*    16     8 */
> 	struct dentry *            mnt_mountpoint;       /*    24     8 */
> 	struct vfsmount            mnt;                  /*    32    32 */
> 	/* --- cacheline 1 boundary (64 bytes) --- */
> 	union {
> 		struct callback_head mnt_rcu;            /*    64    16 */
> 		struct llist_node  mnt_llist;            /*    64     8 */
> 	};                                               /*    64    16 */
> 	struct mnt_pcp *           mnt_pcp;              /*    80     8 */
> 	struct list_head           mnt_mounts;           /*    88    16 */
> 	struct list_head           mnt_child;            /*   104    16 */
> 	struct list_head           mnt_instance;         /*   120    16 */
> 	/* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
> 	const char  *              mnt_devname;          /*   136     8 */
> 	struct list_head           mnt_list;             /*   144    16 */
> 	struct list_head           mnt_expire;           /*   160    16 */
> 	struct list_head           mnt_share;            /*   176    16 */
> 	/* --- cacheline 3 boundary (192 bytes) --- */
> 	struct list_head           mnt_slave_list;       /*   192    16 */
> 	struct list_head           mnt_slave;            /*   208    16 */
> 	struct mount *             mnt_master;           /*   224     8 */
> 	struct mnt_namespace *     mnt_ns;               /*   232     8 */
> 	struct mountpoint *        mnt_mp;               /*   240     8 */
> 	union {
> 		struct hlist_node  mnt_mp_list;          /*   248    16 */
> 		struct hlist_node  mnt_umount;           /*   248    16 */
> 	};                                               /*   248    16 */
> 	/* --- cacheline 4 boundary (256 bytes) was 8 bytes ago --- */
> 	struct list_head           mnt_umounting;        /*   264    16 */
> 	struct fsnotify_mark_connector * mnt_fsnotify_marks; /*   280     8 */
> 	__u32                      mnt_fsnotify_mask;    /*   288     4 */
> 	int                        mnt_id;               /*   292     4 */
> 	int                        mnt_group_id;         /*   296     4 */
> 	int                        mnt_expiry_mark;      /*   300     4 */
> 	struct hlist_head          mnt_pins;             /*   304     8 */
> 	struct hlist_head          mnt_stuck_children;   /*   312     8 */
>
> 	/* size: 320, cachelines: 5, members: 27 */
> };
>
> ⬢[acme@toolbox boot]$
