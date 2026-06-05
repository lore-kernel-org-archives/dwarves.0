Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025BF33DEC2
	for <dwarves@vger.kernel.org>; Fri,  5 Jun 2026 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687704; cv=none; b=uTSMVnRfK2eH5W8isfOgpqJMMzqUKmjX3eGLmxLFTVn7pEQeNJS6Ayz40sAB1xeqOcMXyHNYEG8QZYo4K74WB1hDywoVULdAlmqUIQh0PuQEIpFM8q1ZKx08+flfG12jIPfbEM58+VcidmuUDOSeIhJmhDcYhLaPtZe9qztQYyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687704; c=relaxed/simple;
	bh=UPucVU/5QZJZpBCWykR2Smj4Vc3qqaelWa5bF/QCH94=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VP73JRidFgOdlME5OKSOyVbin9kBNZteLj9oEVqmeOy9NH0zIGN5d6W9a1kYKbKVKjZZsVL2P88BdIjC8fFwaHwfJjJWTE3S+LXLOg4hsoCQjs+f0ergdNw1thgv/cqGCcoccMLFAHHTO3ZzCSAG1tD3d9cPf8zHMDqjkO1/9mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzWw/Bi8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzWw/Bi8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B163A1F00893;
	Fri,  5 Jun 2026 19:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780687702;
	bh=i/Ntp4AcngzDJOVlyoivWn6WR3TYxb68hM/h+PXwOaY=;
	h=Date:From:To:Subject;
	b=FzWw/Bi8pTLE1nLmQrPIQK3gvowTN+5mL9+SCdez2u4Yybb+sTOc14vRtEzcTTozl
	 JhxYLzZ7azzDFUaVtCaIKYg0+gXeozKW7A1jjNopr59un2MR7Bhp5Xm0SjC7esKgRG
	 ntSIokddEVCNuU7m8SirtlXAW/WxHrpZz9oQDX/Prrhd2/jGLf7+JIZkU4UzR/Ti1M
	 teBMlDfP9aFH8QFfcLs67JQ5/7uOgJq18TuLtU+FIFXV3lBVEDzyd6PNZYPrha2NsZ
	 yJF/L7v+g4hCKe494AP6tB1M64PqHn4MlGSJ54F7hMVEBMR4GZx/IFUn1onXrgEcoh
	 CxKU27y69ePow==
Date: Fri, 5 Jun 2026 16:28:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: dwarves@vger.kernel.org
Subject: Re: pahole treats embedded structures a holes
Message-ID: <aiMjUoE_CPn7hJtv@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

FYI and documentation. I'll work on looking at the DW_AT_producer tag
for those compiler options to show in the pretty printing output, as
well as checking potential implications for BTF generation, but I think
that one will end up being harmless because of the combination of all
DWARF CUs the types suppressed by CU would eventually be resolved.

- Arnaldo

----- Forwarded message from Arnaldo Carvalho de Melo <acme@kernel.org> ---=
--

Date: Mon, 1 Jun 2026 12:18:58 -0300
=46rom: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: pahole treats embedded structures a holes
Message-ID: <ah2i4lHbSgilDxQd@x1>

On Sat, May 30, 2026 at 05:22:20AM +0200, Christoph Hellwig wrote:
> Here is a compressed xfs_buf.o.  I don't think it's the same as before,
> but it shows the same symptoms.

TIL: -femit-struct-debug-baseonly

TLDR; you enabled CONFIG_DEBUG_INFO_REDUCED while distros use:

acme@x1:~/git/linux$ grep CONFIG_DEBUG_INFO_ /lib/modules/`uname -r`/config
# CONFIG_DEBUG_INFO_NONE is not set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=3Dy
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_DEBUG_INFO_REDUCED is not set
CONFIG_DEBUG_INFO_COMPRESSED_NONE=3Dy
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_BTF=3Dy
CONFIG_DEBUG_INFO_BTF_MODULES=3Dy
acme@x1:~/git/linux$

I'm adding a TODO entry to notice that and add a comment at that point
stating that the type for a embedded struct wasn't found and that the
user probably is using -femit-struct-debug-baseonly and maybe
CONFIG_DEBUG_INFO_REDUCED.

Please consider replying with this message to the mailing list to leave
this documented in the archives :-)

- Arnaldo

Longer analysis:

acme@x1:~$ pahole -C xfs_buf xfs_buf.o  | head
struct xfs_buf {
	struct rhash_head          b_rhash_head;         /*     0     0 */

	/* XXX 8 bytes hole, try to pack */

	xfs_daddr_t                b_rhash_key;          /*     8     8 */
	int                        b_length;             /*    16     4 */

	/* XXX 4 bytes hole, try to pack */

acme@x1:~$ pahole -C b_rhash_head xfs_buf.o=20
pahole: type 'b_rhash_head' not found
acme@x1:~$ pahole -C xfs_buf xfs_buf.o  | head
struct xfs_buf {
	struct rhash_head          b_rhash_head;         /*     0     0 */

	/* XXX 8 bytes hole, try to pack */

	xfs_daddr_t                b_rhash_key;          /*     8     8 */
	int                        b_length;             /*    16     4 */

	/* XXX 4 bytes hole, try to pack */

acme@x1:~$ pahole -C rhash_head xfs_buf.o=20
pahole: type 'rhash_head' not found
acme@x1:~$

acme@x1:~$ readelf -wi xfs_buf.o | grep DW_AT_producer
    <d>   DW_AT_producer    : (indirect string, offset: 0x28e6): GNU C11 15=
=2E2.0 -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -mno-sse4a -m64 -mno=
-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3D3 -mskip-rax-setup -=
march=3Dx86-64 -mtune=3Dgeneric -mno-red-zone -mcmodel=3Dkernel -mstack-pro=
tector-guard-reg=3Dgs -mstack-protector-guard-symbol=3D__ref_stack_chk_guar=
d -mindirect-branch=3Dthunk-extern -mindirect-branch-register -mindirect-br=
anch-cs-prefix -mfunction-return=3Dthunk-extern -g -O2 -std=3Dgnu11 -fshort=
-wchar -funsigned-char -fno-common -fno-PIE -fno-strict-aliasing -fms-exten=
sions -fcf-protection=3Dbranch -falign-jumps=3D1 -falign-loops=3D1 -fno-asy=
nchronous-unwind-tables -fno-jump-tables -fpatchable-function-entry=3D16,16=
 -fno-delete-null-pointer-checks -fno-allow-store-data-races -fstack-protec=
tor-strong -fomit-frame-pointer -fzero-init-padding-bits=3Dall -fno-stack-c=
lash-protection -fmin-function-alignment=3D16 -fstrict-flex-arrays=3D3 -fno=
-strict-overflow -fstack-check=3Dno -fconserve-stack -fno-builtin-wcslen -f=
no-var-tracking -femit-struct-debug-baseonly
acme@x1:~$

acme@x1:~/git/linux$ git grep -B4 -A4 -- -femit-struct-debug-baseonly
rust/Makefile-  -mno-pointers-to-nested-functions -mno-string \
rust/Makefile-  -mno-strict-align -mstrict-align -mdirect-extern-access \
rust/Makefile-  -mexplicit-relocs -mno-check-zero-division \
rust/Makefile-  -fconserve-stack -falign-jumps=3D% -falign-loops=3D% \
rust/Makefile:  -femit-struct-debug-baseonly -fno-ipa-cp-clone -fno-ipa-sra=
 \
rust/Makefile-  -fno-partial-inlining -fplugin-arg-arm_ssp_per_task_plugin-=
% \
rust/Makefile-  -fno-reorder-blocks -fno-allow-store-data-races -fasan-shad=
ow-offset=3D% \
rust/Makefile-  -fzero-call-used-regs=3D% -fno-stack-clash-protection \
rust/Makefile-  -fno-inline-functions-called-once -fsanitize=3Dbounds-stric=
t \
--
scripts/Makefile.debug-ifdef CONFIG_DEBUG_INFO_REDUCED
scripts/Makefile.debug-DEBUG_CFLAGS     +=3D -fno-var-tracking
scripts/Makefile.debug-DEBUG_RUSTFLAGS  +=3D -Cdebuginfo=3D1
scripts/Makefile.debug-ifdef CONFIG_CC_IS_GCC
scripts/Makefile.debug:DEBUG_CFLAGS     +=3D -femit-struct-debug-baseonly
scripts/Makefile.debug-endif
scripts/Makefile.debug-else
scripts/Makefile.debug-DEBUG_RUSTFLAGS  +=3D -Cdebuginfo=3D2
scripts/Makefile.debug-endif
acme@x1:~/git/linux$

----- 8< -----
-femit-struct-debug-baseonly is a GCC (GNU Compiler Collection)
command-line flag used to drastically reduce the size of object files by
limiting the amount of debug information generated for structures,
unions, and classes.

It works by strictly filtering which type definitions are included in
the final DWARF debug symbols based on where those types are
declared.

How it Works

When you compile a source file (e.g., main.c), the compiler normally
emits debug information for all types used or declared within that file,
including those from deeply nested external header files.

With -femit-struct-debug-baseonly enabled, GCC uses aggressive filtering
rules:

Matches Base File Name: Debug information is only generated for
structs/unions/classes if the base name of the file where the type is
declared matches the base name of the file being compiled.

Practical Example:

If you are compiling foo.c, debug symbols will only be generated for
types declared directly inside foo.c and its direct companion header
foo.h. Types declared in other included headers (like standard_lib.h)
are completely ignored.

Key Benefits

Smaller Binaries:

It severely reduces the storage footprint of debug ELF and object files.

Faster Link Times:

Less debug information means linkers have less data to process and
deduplicate.

Faster Debugger Loading:

Debuggers like GDB or IDE symbol loaders can load the project
significantly faster.

Caveats & Constraints

Limited Debugging Visibility:

Because it aggressively strips type data, your debugger might not
recognize or be able to pretty-print structures declared in external
files or libraries during a live debugging session.

Format Restriction: This flag exclusively functions with DWARF debug
output format.

Alternative Flags: It is a stricter, more aggressive variant of
-femit-struct-debug-reduced.

If you require fine-grained control, you can instead use
-femit-struct-debug-detailed.

----- 8< -----

----- End forwarded message -----
