Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449B73ED109
	for <dwarves@vger.kernel.org>; Thu, 28 May 2026 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779975580; cv=none; b=n+zEJWk9rz/4CiPa07caPUqITxdlIVIHkRjlU43d/5jP03E0cIw1NQaS3q/YdxbBzWo5U5O32/+qWLKoa6sCGSjaW88hgVsCyIyKAJqSuuquKIRJFt/Aygvh6Tn+50P9U3q72TcX3KNP/9krpPgRaMUY6ucugbnmkHdNsDLiCTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779975580; c=relaxed/simple;
	bh=dMKI3KcZ5CRpBK5pcHvS9Mu39FPp6/dsNb4AA3wk/h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unkq6u0t4vQjMRlxg0hFtsld+m1fQrSC2jrkbYlHLH5WlOEG0pjAVle+qqNMwFnDxlCT/8vLPjWTpk+6CCW9QvJa8UQWSYagoGmOFHopLPTdkg9/SwzyjOJumtdu6ywkXyC3T6Z/tFif+ReGAFrejv69wpruh1kc5L7LAt/7FCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeDvWMph; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeDvWMph"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2329C1F000E9;
	Thu, 28 May 2026 13:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779975578;
	bh=jrcJEV1RsanEhH1mr7a8Uhrm8JBF4rxCP/BU7WdQSis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eeDvWMphRTtk0g/DGu3w+rUNFbksDhwqMWZNZah9Oc416zSZRtaE5Q4GIhnMHng9g
	 mfB8NO/wZ6pD2Vh0rBFlIjiOCTavCSBq8Nnd67PigwXdtalHnP3De1I6Enj0ap6M2o
	 i/PQaig9lLOn7jB3bSghsiXRvMXICrEMWeKj2NyZvXFTFPxBRiZsUi9mZ2NdisWpi/
	 N7n/EsX31qnsP+y+XvlFN41PuR1gVLEyiU+FYyP87z36rBJOI4eH3Nn04N3LCK8zW3
	 ovGP/z5O1vMBdf2IktXD+Q8vOfrXvaxU6BOpoLCTg8HPomSNknOrQrjH4QR4+ABPF7
	 gW4Lx6VOLtA6g==
Date: Thu, 28 May 2026 10:39:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: dwarves@vger.kernel.org
Subject: Re: pahole treats embedded structures a holes
Message-ID: <ahhFlsCJzkxLt3M6@x1>
References: <20260528051152.GA27820@lst.de>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528051152.GA27820@lst.de>

On Thu, May 28, 2026 at 07:11:52AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this is a pretty old bug as far as I can tell, but I finally tried to
> track it down and failed.
> 
> When running dwarves, both the package in Debian testing and a build of
> todays git tree on Debian testing, it treats a lot of C structures
> embedded into others as holes instead of having a size for them.  I
> think this generally structures defined in other header files and
> not the file containing the offending struct.
> 
> E.g. if I run pahole on fs/xfs/xfs_buf.o on a current mainline kernel,
> the output for struct xfs_buf starts like this:
> 
> struct xfs_buf {
>         struct rhash_head          b_rhash_head;         /*     0     0 */
> 
>         /* XXX 8 bytes hole, try to pack */
> 
>         xfs_daddr_t                b_rhash_key;          /*     8     8 */
> 
> struct rhash_head is a single pointer, so 8 bytes on x86-64, and
> xfs_daddr_t is also a 64-bit type, so both the 0 size and the 8
> byte hole are clearly wrong.  The kernel .config is attached in case
> it matter.

Starting from using the BTF info, that becomes available thru sysfs as
soon as we load the xfs kernel module:

acme@x1:~$ ls -la /sys/kernel/btf/xfs
ls: cannot access '/sys/kernel/btf/xfs': No such file or directory
acme@x1:~$ sudo modprobe xfs
acme@x1:~$ ls -la /sys/kernel/btf/xfs
-r--r--r--. 1 root root 630917 May 28 10:33 /sys/kernel/btf/xfs
acme@x1:~$
acme@x1:~$ pahole --sizes /sys/kernel/btf/xfs | sort -nr -k2 | grep xfs | head 
xfs_mount	4032	8
xfs_dquot_acct	1320	0
xfs_cil_ctx	1240	2
xfsstats	1088	0
__xfsstats	1088	0
xfs_inode	984	2
xfs_quotainfo	552	1
xfs_dquot	536	3
xfs_perag	480	4
xfs_da_state	480	1
acme@x1:~$

Now to the 'xfs_buf' struct:

acme@x1:~$ pahole /sys/kernel/btf/xfs -C xfs_buf | head
struct xfs_buf {
	struct rhash_head          b_rhash_head;         /*     0     8 */
	xfs_daddr_t                b_rhash_key;          /*     8     8 */
	int                        b_length;             /*    16     4 */
	unsigned int               b_hold;               /*    20     4 */
	atomic_t                   b_lru_ref;            /*    24     4 */
	xfs_buf_flags_t            b_flags;              /*    28     4 */
	struct semaphore           b_sema;               /*    32    24 */
	struct list_head           b_lru;                /*    56    16 */
	/* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
acme@x1:~$

Seems ok, expanding it:

acme@x1:~$ pahole -E /sys/kernel/btf/xfs -C xfs_buf | head
struct xfs_buf {
	struct rhash_head {
		struct rhash_head * next;                                                /*     0     8 */
	} b_rhash_head; /*     0     8 */
	/* typedef xfs_daddr_t -> __s64 */ long long int              b_rhash_key;       /*     8     8 */
	int                        b_length;                                             /*    16     4 */
	unsigned int               b_hold;                                               /*    20     4 */
	/* typedef atomic_t */ struct {
		int                counter;                                              /*    24     4 */
	} b_lru_ref; /*    24     4 */
acme@x1:~$

Looks ok and with your description of the struct, a pointer, 8 bytes,
etc.

Now I'll try with a fresh kernel build, with a default fedora kernel
config, will take a while, but having access to a separate .o file from
the kernel build process, with just DWARF info is what we need to get to
the state you're in, that should work, lets see why you're getting the
unsatisfactory results you're getting, maybe we need further info about
compiler versions, etc, but lets see...

- Arnaldo
