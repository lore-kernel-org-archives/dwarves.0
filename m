Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECF9C433FE
	for <linux-dwarves@archiver.kernel.org>; Wed,  5 Oct 2022 12:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJEMVG (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 5 Oct 2022 08:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiJEMVF (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 5 Oct 2022 08:21:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2111052E5E
        for <dwarves@vger.kernel.org>; Wed,  5 Oct 2022 05:21:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEC926166F
        for <dwarves@vger.kernel.org>; Wed,  5 Oct 2022 12:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B108DC43141;
        Wed,  5 Oct 2022 12:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664972462;
        bh=CNtj8LPHWoeTl+Y3FDmBqPOl41ySqKEO3yGUyYuIflE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=toHQsT0iy0632TRq6H9B8afhHLaG2EqvcQx8uxj7U1tiJJHKrfJ4eMGZXPn6ONLWI
         VSzAdrx1vVL+UqzTQkVyeDsRsKglvq//45nsJd+xtUQvRyMYCLsmEPKtgNTMawCBTw
         BAis9YL96yj7tOMOQJ1oWEQUbeqXU118QaV2NqlSrqO0RqvjvXH7rKcw0UJddVP8cw
         p1L6xI2CS9HFE+jKaCUsJiZ5zN02KU+yBTMLNqrmPgZN5kFlDdaNP65TsAoDD9i5K5
         iD3XvM2WRtVzB1Qp/3d+8V5L6q6SZlnRhf+Gio+gHKEh2lGTKQMsTTzX17vjNi7yj6
         D9mKKhxJJTTIw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6CA464062C; Wed,  5 Oct 2022 09:20:59 -0300 (-03)
Date:   Wed, 5 Oct 2022 09:20:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Bitweasil <bitweasil@cryptohaze.com>
Cc:     dwarves@vger.kernel.org
Subject: Re: Ubuntu kernels and die__process: DW_TAG ... got INVALID!
Message-ID: <Yz12qzXbbGPzH2Bl@kernel.org>
References: <17a34291-e28c-b08d-cfec-d455c72c4c54@cryptohaze.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17a34291-e28c-b08d-cfec-d455c72c4c54@cryptohaze.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Tue, Oct 04, 2022 at 03:10:06PM -0600, Bitweasil escreveu:
> When trying to extract the layout of kernel structures that should exist on
> recent kernels from the Ubuntu debug kernel repo, I get the following error:
> 
> die__process: DW_TAG_compile_unit, DW_TAG_type_unit or DW_TAG_partial_unit
> expected got INVALID!
> pahole: type 'mount' not found
> 
> As far as I can tell, 'struct mount' should still exist - and I can pull
> other structures out without trouble.  The issue starts appearing somewhere
> in the 5.15 kernel version - earlier kernels work exactly as expected and I
> can extract the full offsets.
> 
> https://elixir.bootlin.com/linux/v5.15.48/source/fs/mount.h indicates that
> 'struct mount' still exists in the source, and it remains present into the
> 6.0 kernel with no substantial changes. I can also produce the same response
> with some of the other structures in that file - mountpoint, mnt_namespace,
> and mnt_pcp all lead to the same error message.
> 
> I've tried building pahole from head (Oct 4, 2022, e819d737) without any
> changes to the behavior, and v1.21 and 1.24 both lead to the same results.

Are you sure? The error message should be this in 1.24:

because:

        if (tag == DW_TAG_skeleton_unit) {
                static bool warned;

                if (!warned) {
                        fprintf(stderr, "WARNING: DW_TAG_skeleton_unit used, please look for a .dwo file and use it instead.\n"
                                        "         A future version of pahole will support do this automagically.\n");
                        warned = true;
                }
                return 0; // so that other units can be processed
        }

        if (tag == DW_TAG_partial_unit) {
                static bool warned;

                if (!warned) {
                        fprintf(stderr, "WARNING: DW_TAG_partial_unit used, some types will not be considered!\n"
                                        "         Probably this was optimized using a tool like 'dwz'\n"
                                        "         A future version of pahole will support this.\n");
                        warned = true;
                }
                return 0; // so that other units can be processed
        }

        if (tag != DW_TAG_compile_unit && tag != DW_TAG_type_unit) {
                fprintf(stderr, "%s: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got %s (0x%x)!\n",
                        __FUNCTION__, dwarf_tag_name(tag), tag);
                return -EINVAL;
        }


But its strange, there are no units other than DW_TAG_compile_unit in
that vmlinux file:

⬢[acme@toolbox boot]$ readelf -wi vmlinux-5.15.0-48-generic | grep 'DW_TAG_.*_unit' | grep -v DW_TAG_compile_unit
⬢[acme@toolbox boot]$
 
> Steps to reproduce (warning, will take ~10GB - the unzipped kernel debug
> symbols are rather large):
 
> cd /tmp
> wget http://ddebs.ubuntu.com/pool/main/l/linux/linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb
> ar x linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb
> tar -xf data.tar.xz
> cd usr/lib/debug/boot
> pahole -C mount vmlinux-5.15.0-48-generic

> die__process: DW_TAG_compile_unit, DW_TAG_type_unit or DW_TAG_partial_unit
> expected got INVALID!
> pahole: type 'mount' not found

> Any suggestions on how to resolve this?  I'm not familiar enough with the
> various debug formats to know how to troubleshoot beyond this point right
> now.

Works for me:

⬢[acme@toolbox pahole]$ wget http://ddebs.ubuntu.com/pool/main/l/linux/linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb
--2022-10-05 09:11:56--  http://ddebs.ubuntu.com/pool/main/l/linux/linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb
Resolving ddebs.ubuntu.com (ddebs.ubuntu.com)... 185.125.190.17, 91.189.91.48, 91.189.91.49, ...
Connecting to ddebs.ubuntu.com (ddebs.ubuntu.com)|185.125.190.17|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 1055842672 (1007M) [application/vnd.debian.binary-package]
Saving to: ‘linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb’

linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.dde 100%[===================================================================================================================================================================>]   1007M  13.3MB/s    in 74s

2022-10-05 09:13:11 (13.5 MB/s) - ‘linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb’ saved [1055842672/1055842672]

⬢[acme@toolbox pahole]$ mkdir ubuntu-kernel
⬢[acme@toolbox pahole]$ mv linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb ubuntu-kernel
⬢[acme@toolbox pahole]$ cd ubuntu-kernel
⬢[acme@toolbox ubuntu-kernel]$ ls -la
total 1031148
drwxr-xr-x. 1 acme acme        138 Oct  5 09:13 .
drwxrwxr-x. 1 acme acme       5074 Oct  5 09:13 ..
-rw-r--r--. 1 acme acme 1055842672 Aug 31 08:39 linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb
⬢[acme@toolbox ubuntu-kernel]$ ar x linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb
⬢[acme@toolbox ubuntu-kernel]$ ls -la
total 2062252
drwxr-xr-x. 1 acme acme        214 Oct  5 09:13 .
drwxrwxr-x. 1 acme acme       5074 Oct  5 09:13 ..
-rw-r--r--. 1 acme acme     155352 Oct  5 09:13 control.tar.xz
-rw-r--r--. 1 acme acme 1055687128 Oct  5 09:13 data.tar.xz
-rw-r--r--. 1 acme acme          4 Oct  5 09:13 debian-binary
-rw-r--r--. 1 acme acme 1055842672 Aug 31 08:39 linux-image-unsigned-5.15.0-48-generic-dbgsym_5.15.0-48.54_amd64.ddeb
⬢[acme@toolbox ubuntu-kernel]$ tar -xf data.tar.xz
⬢[acme@toolbox ubuntu-kernel]$ cd usr/lib/debug/boot
⬢[acme@toolbox boot]$ ls -la
total 719136
drwxr-xr-x. 1 acme acme        50 Aug 26 06:12 .
drwxr-xr-x. 1 acme acme        14 Oct  5 09:13 ..
-rw-r--r--. 1 acme acme 736393784 Aug 26 06:12 vmlinux-5.15.0-48-generic
⬢[acme@toolbox boot]$ ls -la
total 719136
drwxr-xr-x. 1 acme acme        50 Aug 26 06:12 .
drwxr-xr-x. 1 acme acme        14 Oct  5 09:13 ..
-rw-r--r--. 1 acme acme 736393784 Aug 26 06:12 vmlinux-5.15.0-48-generic
⬢[acme@toolbox boot]$ pahole -C mount vmlinux-5.15.0-48-generic
struct mount {
	struct hlist_node          mnt_hash;             /*     0    16 */
	struct mount *             mnt_parent;           /*    16     8 */
	struct dentry *            mnt_mountpoint;       /*    24     8 */
	struct vfsmount            mnt;                  /*    32    32 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	union {
		struct callback_head mnt_rcu __attribute__((__aligned__(8))); /*    64    16 */
		struct llist_node  mnt_llist;            /*    64     8 */
	} __attribute__((__aligned__(8)));               /*    64    16 */
	struct mnt_pcp *           mnt_pcp;              /*    80     8 */
	struct list_head           mnt_mounts;           /*    88    16 */
	struct list_head           mnt_child;            /*   104    16 */
	struct list_head           mnt_instance;         /*   120    16 */
	/* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
	const char  *              mnt_devname;          /*   136     8 */
	struct list_head           mnt_list;             /*   144    16 */
	struct list_head           mnt_expire;           /*   160    16 */
	struct list_head           mnt_share;            /*   176    16 */
	/* --- cacheline 3 boundary (192 bytes) --- */
	struct list_head           mnt_slave_list;       /*   192    16 */
	struct list_head           mnt_slave;            /*   208    16 */
	struct mount *             mnt_master;           /*   224     8 */
	struct mnt_namespace *     mnt_ns;               /*   232     8 */
	struct mountpoint *        mnt_mp;               /*   240     8 */
	union {
		struct hlist_node  mnt_mp_list;          /*   248    16 */
		struct hlist_node  mnt_umount;           /*   248    16 */
	};                                               /*   248    16 */
	/* --- cacheline 4 boundary (256 bytes) was 8 bytes ago --- */
	struct list_head           mnt_umounting;        /*   264    16 */
	struct fsnotify_mark_connector * mnt_fsnotify_marks; /*   280     8 */
	__u32                      mnt_fsnotify_mask;    /*   288     4 */
	int                        mnt_id;               /*   292     4 */
	int                        mnt_group_id;         /*   296     4 */
	int                        mnt_expiry_mark;      /*   300     4 */
	struct hlist_head          mnt_pins;             /*   304     8 */
	struct hlist_head          mnt_stuck_children;   /*   312     8 */

	/* size: 320, cachelines: 5, members: 27 */
	/* forced alignments: 1 */
} __attribute__((__aligned__(8)));

⬢[acme@toolbox boot]$ pahole --version
v1.24
⬢[acme@toolbox boot]$

And it even has BTF info, which makes processing much faster but without
some attributes:

⬢[acme@toolbox boot]$ readelf -SW vmlinux-5.15.0-48-generic | grep -i btf
  [28] .BTF              PROGBITS        ffffffff8279d1e0 199d1e0 4ef6b2 00   A  0   0  1
  [29] .BTF_ids          PROGBITS        ffffffff82c8c894 1e8c894 0005e8 00   A  0   0  1
⬢[acme@toolbox boot]$

⬢[acme@toolbox boot]$ pahole -F btf -C mount vmlinux-5.15.0-48-generic
struct mount {
	struct hlist_node          mnt_hash;             /*     0    16 */
	struct mount *             mnt_parent;           /*    16     8 */
	struct dentry *            mnt_mountpoint;       /*    24     8 */
	struct vfsmount            mnt;                  /*    32    32 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	union {
		struct callback_head mnt_rcu;            /*    64    16 */
		struct llist_node  mnt_llist;            /*    64     8 */
	};                                               /*    64    16 */
	struct mnt_pcp *           mnt_pcp;              /*    80     8 */
	struct list_head           mnt_mounts;           /*    88    16 */
	struct list_head           mnt_child;            /*   104    16 */
	struct list_head           mnt_instance;         /*   120    16 */
	/* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
	const char  *              mnt_devname;          /*   136     8 */
	struct list_head           mnt_list;             /*   144    16 */
	struct list_head           mnt_expire;           /*   160    16 */
	struct list_head           mnt_share;            /*   176    16 */
	/* --- cacheline 3 boundary (192 bytes) --- */
	struct list_head           mnt_slave_list;       /*   192    16 */
	struct list_head           mnt_slave;            /*   208    16 */
	struct mount *             mnt_master;           /*   224     8 */
	struct mnt_namespace *     mnt_ns;               /*   232     8 */
	struct mountpoint *        mnt_mp;               /*   240     8 */
	union {
		struct hlist_node  mnt_mp_list;          /*   248    16 */
		struct hlist_node  mnt_umount;           /*   248    16 */
	};                                               /*   248    16 */
	/* --- cacheline 4 boundary (256 bytes) was 8 bytes ago --- */
	struct list_head           mnt_umounting;        /*   264    16 */
	struct fsnotify_mark_connector * mnt_fsnotify_marks; /*   280     8 */
	__u32                      mnt_fsnotify_mask;    /*   288     4 */
	int                        mnt_id;               /*   292     4 */
	int                        mnt_group_id;         /*   296     4 */
	int                        mnt_expiry_mark;      /*   300     4 */
	struct hlist_head          mnt_pins;             /*   304     8 */
	struct hlist_head          mnt_stuck_children;   /*   312     8 */

	/* size: 320, cachelines: 5, members: 27 */
};

⬢[acme@toolbox boot]$
