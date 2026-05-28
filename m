Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77DA4315F
	for <dwarves@vger.kernel.org>; Thu, 28 May 2026 19:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997731; cv=none; b=NVl7+3Ec/upNuq9aQwpQ3YytxgbInPZ2LFHIH85r5Ji4QdhQfVu+YqVtHXupZb0dTgPcsOnHdeixqG765Z2UoG5yJX0EGTY/rCZ/m9px/qZ74WY0UJ5LjB5g4JmlDYt2ZwZ96QctFmvjjHVX797abRJvdJDTh+Cz7JPafJtPoAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997731; c=relaxed/simple;
	bh=s4dnvRKp1Nt37MOIiyLbCAvzgZS0GHxgHApB607oxGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OB4hWWttmuS23NY//aZnHja8uj4sMZkQRmfmTkkg1iXvZMtAdSBwlPxPKtXd0ghZUwSYnLCJCAPR/nL7c0QsCyjPdOTd8c2RpQwLk8nLLa8DkPWBmo+8LUVksLGnVHNZhl4NHCRk+6Atk+xpHczW9x44S9VkKGS+NoWVQqnws0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIGFqy55; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIGFqy55"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5771F000E9;
	Thu, 28 May 2026 19:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779997729;
	bh=leUUvrzoEqqfN/kVAIc4qYrEZK7Tf5mKOXgbFRFhhKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PIGFqy55rvLEE0bk4fQL2bvGaTxB+ILePo1OrzWaHwlaJ2rg7L7yb+STy158JziHY
	 3/ruJoBXynRixclXShztts6HXokZpN6UlFfF2lUXE7TVipawa6psG4879xQQNFdppu
	 9LgmpmQ92X0wpWhaY7t7mgF2AEkSVr7YDJmmfU5op8n/kMYqrg28JsMhY/LvfTqQkA
	 T9At9ok25QxpqMAfI7Mw0TMjC86wz+VyF0FzZYakI9zvkiK0MkjqudtyHJsasB4ofn
	 WhO09ncxq14dNZsys8h4SZl0jwaXfwa+o+MfLrObZZ//PMD/+o8IecogCXeuDbgw2l
	 tXazgbAuizvTQ==
Date: Thu, 28 May 2026 16:48:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: dwarves@vger.kernel.org
Subject: Re: pahole treats embedded structures a holes
Message-ID: <ahicHN7iwtCwasPj@x1>
References: <20260528051152.GA27820@lst.de>
 <ahhFlsCJzkxLt3M6@x1>
 <20260528135852.GA30243@lst.de>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260528135852.GA30243@lst.de>

On Thu, May 28, 2026 at 03:58:52PM +0200, Christoph Hellwig wrote:
> On Thu, May 28, 2026 at 10:39:34AM -0300, Arnaldo Carvalho de Melo wrote:
> > > struct rhash_head is a single pointer, so 8 bytes on x86-64, and
> > > xfs_daddr_t is also a 64-bit type, so both the 0 size and the 8
> > > byte hole are clearly wrong.  The kernel .config is attached in case
> > > it matter.

> > Starting from using the BTF info, that becomes available thru sysfs as
> > soon as we load the xfs kernel module:
=20
> This works fine on my installed distro kernel as well.  But this is
> for test builds which are only going to run in a VM.  I don't really
> care about DWARF vs BTF, but I do care about not having to run the
> kernel :)

Sure, I was just checking with what I had at hand, before building the
kernel, to see if the problem was there as well.
=20
> Note that I'm also seeing this for other code than XFS, e.g. the nvme
> driver or block layer code.
=20
> > Now I'll try with a fresh kernel build, with a default fedora kernel
> > config, will take a while, but having access to a separate .o file from
> > the kernel build process, with just DWARF info is what we need to get to
> > the state you're in, that should work, lets see why you're getting the
> > unsatisfactory results you're getting, maybe we need further info about
> > compiler versions, etc, but lets see...
=20
> gcc (Debian 15.2.0-17) 15.2.0

acme@number:~$ pahole -C xfs_buf git/build/allmodconfig/fs/xfs/xfs_buf.o  |=
 head
struct xfs_buf {
	struct rhash_head          b_rhash_head;         /*     0     8 */
	xfs_daddr_t                b_rhash_key;          /*     8     8 */
	int                        b_length;             /*    16     4 */

	/* XXX 4 bytes hole, try to pack */

	struct lockref             b_lockref __attribute__((__aligned__(8))); /*  =
  24    80 */
	/* --- cacheline 1 boundary (64 bytes) was 40 bytes ago --- */
	atomic_t                   b_lru_ref __attribute__((__aligned__(4))); /*  =
 104     4 */
acme@number:~$

acme@number:~$ pahole -E -C xfs_buf git/build/allmodconfig/fs/xfs/xfs_buf.o=
  | head
struct xfs_buf {
	struct rhash_head {
		struct rhash_head * next;                                                =
/*     0     8 */
	} b_rhash_head; /*     0     8 */
	/* typedef xfs_daddr_t -> __s64 */ long long int              b_rhash_key;=
       /*     8     8 */
	int                        b_length;                                      =
       /*    16     4 */

	/* XXX 4 bytes hole, try to pack */

	struct lockref {
acme@number:~$

acme@number:~$ readelf -wi git/build/allmodconfig/fs/xfs/xfs_buf.o  | grep =
-m1 DW_AT_producer
    <e>   DW_AT_producer    : (indirect string, offset: 0x923f): GNU C11 16=
=2E1.1 20260515 (Red Hat 16.1.1-2) -march=3Dznver5 -mpopcnt -msse3 -mssse3 =
-msse4.1 -msse4.2 -mavx2 -mno-fma4 -mno-xop -mfma -mavx512f -mbmi -mbmi2 -m=
aes -mpclmul -mavx512vl -mavx512bw -mavx512dq -mavx512cd -mavx512vbmi -mavx=
512ifma -mavx512vpopcntdq -mavx512vbmi2 -mgfni -mvpclmulqdq -mavx512vnni -m=
avx512bitalg -mavx512bf16 -mavx512vp2intersect -madx -mabm -mno-cldemote -m=
clflushopt -mclwb -mclzero -mcx16 -mno-enqcmd -mf16c -mfsgsbase -mfxsr -mno=
-hle -msahf -mno-lwp -mlzcnt -mmovbe -mmovdir64b -mmovdiri -mmwaitx -mno-pc=
onfig -mpku -mprfchw -mno-ptwrite -mrdpid -mrdrnd -mrdseed -mno-rtm -mno-se=
rialize -mno-sgx -msha -mshstk -mno-tbm -mno-tsxldtrk -mvaes -mno-waitpkg -=
mwbnoinvd -mxsave -mxsavec -mxsaveopt -mxsaves -mno-amx-tile -mno-amx-int8 =
-mno-amx-bf16 -mno-uintr -mno-hreset -mno-kl -mno-widekl -mavxvnni -mno-avx=
512fp16 -mno-avxifma -mno-avxvnniint8 -mno-avxneconvert -mno-cmpccxadd -mno=
-amx-fp16 -mprefetchi -mno-raoint -mno-amx-complex -mno-avxvnniint16 -mno-s=
m3 -mno-sha512 -mno-sm4 -mno-apxf -mno-usermsr -mno-avx10.1 -mno-avx10.2 -m=
no-amx-avx512 -mno-amx-tf32 -mno-amx-fp8 -mno-movrs -mno-amx-movrs -mno-avx=
512bmm --param=3Dl1-cache-size=3D48 --param=3Dl1-cache-line-size=3D64 --par=
am=3Dl2-cache-size=3D1024 -mtune=3Dznver5 -mno-sse -mno-mmx -mno-sse2 -mno-=
3dnow -mno-avx -mno-sse4a -m64 -mno-80387 -mno-fp-ret-in-387 -mpreferred-st=
ack-boundary=3D3 -mskip-rax-setup -mno-red-zone -mcmodel=3Dkernel -mstack-p=
rotector-guard-reg=3Dgs -mstack-protector-guard-symbol=3D__ref_stack_chk_gu=
ard -mindirect-branch=3Dthunk-extern -mindirect-branch-register -mindirect-=
branch-cs-prefix -mfunction-return=3Dthunk-extern -mharden-sls=3Dall -mreco=
rd-mcount -mfentry -mtls-dialect=3Dgnu2 -g -O2 -std=3Dgnu11 -p -fshort-wcha=
r -funsigned-char -fno-common -fno-PIE -fno-strict-aliasing -fms-extensions=
 -fcf-protection=3Dbranch -falign-jumps=3D1 -falign-loops=3D1 -fno-asynchro=
nous-unwind-tables -fno-jump-tables -fpatchable-function-entry=3D64,64 -fno=
-delete-null-pointer-checks -fno-allow-store-data-races -fno-reorder-blocks=
 -fno-ipa-cp-clone -fno-partial-inlining -fstack-protector-strong -ftrivial=
-auto-var-init=3Dpattern -fzero-init-padding-bits=3Dall -fno-stack-clash-pr=
otection -fdiagnostics-show-context=3D2 -fzero-call-used-regs=3Dused-gpr -f=
no-inline-functions-called-once -fmin-function-alignment=3D64 -fstrict-flex=
-arrays=3D3 -fno-strict-overflow -fstack-check=3Dno -fconserve-stack -fno-b=
uiltin-wcslen -fsanitize=3Dkernel-address -fasan-shadow-offset=3D0xdffffc00=
00000000 -fsanitize=3Dbounds-strict -fsanitize=3Dshift -fsanitize=3Dinteger=
-divide-by-zero -fsanitize=3Dbool -fsanitize=3Denum -fsanitize-coverage=3Dt=
race-pc -fsanitize-coverage=3Dtrace-cmp --param=3Dasan-instrumentation-with=
-call-threshold=3D10000 --param=3Dasan-stack=3D1 --param=3Dasan-instrument-=
allocas=3D1 --param=3Dasan-globals=3D1 --param=3Dasan-kernel-mem-intrinsic-=
prefix=3D1
acme@number:~$

then, please take a look at this sequence:

acme@number:~$ readelf -wi git/build/allmodconfig/fs/xfs/xfs_buf.o  | grep =
-w xfs_buf$ -B1 -A12
 <1><15f59>: Abbrev Number: 76 (DW_TAG_structure_type)
    <15f5a>   DW_AT_name        : (indirect string, offset: 0x8a96): xfs_buf
    <15f5e>   DW_AT_byte_size   : 664
    <15f60>   DW_AT_alignment   : 8
    <15f61>   DW_AT_decl_file   : 49
    <15f62>   DW_AT_decl_line   : 138
    <15f63>   DW_AT_decl_column : 8
    <15f64>   DW_AT_sibling     : <0x1610b>
 <2><15f68>: Abbrev Number: 4 (DW_TAG_member)
    <15f69>   DW_AT_name        : (indirect string, offset: 0x4e54): b_rhas=
h_head
    <15f6d>   DW_AT_decl_file   : 49
    <15f6e>   DW_AT_decl_line   : 146
    <15f6f>   DW_AT_decl_column : 20
    <15f70>   DW_AT_type        : <0x5b22>
acme@number:~$

acme@number:~$ readelf -wi git/build/allmodconfig/fs/xfs/xfs_buf.o  | grep =
'<5b22>' -A12
 <1><5b22>: Abbrev Number: 30 (DW_TAG_structure_type)
    <5b23>   DW_AT_name        : (indirect string, offset: 0x1bb8): rhash_h=
ead
    <5b27>   DW_AT_byte_size   : 8
    <5b28>   DW_AT_decl_file   : 160
    <5b29>   DW_AT_decl_line   : 19
    <5b2a>   DW_AT_decl_column : 8
    <5b2b>   DW_AT_sibling     : <0x5b3d>
 <2><5b2f>: Abbrev Number: 4 (DW_TAG_member)
    <5b30>   DW_AT_name        : (indirect string, offset: 0x123e3): next
    <5b34>   DW_AT_decl_file   : 160
    <5b35>   DW_AT_decl_line   : 20
    <5b36>   DW_AT_decl_column : 28
    <5b37>   DW_AT_type        : <0x5b42>
acme@number:~$

iacme@number:~$ readelf -wi git/build/allmodconfig/fs/xfs/xfs_buf.o  | grep=
 '<5b42>' -A4
 <1><5b42>: Abbrev Number: 8 (DW_TAG_pointer_type)
    <5b43>   DW_AT_byte_size   : 8
    <5b43>   DW_AT_type        : <0x5b22>
 <1><5b47>: Abbrev Number: 30 (DW_TAG_structure_type)
    <5b48>   DW_AT_name        : (indirect string, offset: 0x14c84): rhlist=
_head
acme@number:~$

So everything is in this CU (debug info for the .o file), at least here,
what do you see on your system?

- Arnaldo
