Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE88352C3C
	for <dwarves@vger.kernel.org>; Fri, 29 May 2026 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780082943; cv=none; b=NddL2S9vC77T0Y+iJ5SQeh85LSMTz0waPSwGJB51YRzL+Iu8nIozmgwLq6QkIxv3XSZ1bAr5Ap3noWlFYeWyaDvhzDARrofwrETih8x9WD6hgwyZvTyFmh3JNmvdA8nCh1CuC5KXKts3rm2T65ait3mklmZEKYy2WM9y6pr2FCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780082943; c=relaxed/simple;
	bh=I8+LTCBFW8qmHgWpBSurpegyjyGehQlJ3sSI5si5i3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQHE2cAjclduMiqPMOOksLMIq1cJjR7ldP3LC7bybp6vJyUNXH20wWlGRtlkD5kmkojsPchA3+mxSt745v4FdyfqgYFEzL0jw/JGEbIgxGLwt/2xf+4nb7O4GkNOEVqRRlJLFWaxrOwgNNNzaZsX8tSWYk7U6j3bS/JORZdbaBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdBvC/6l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdBvC/6l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CFC1F00893;
	Fri, 29 May 2026 19:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780082941;
	bh=4ZW5uKBmzUebPgRKGfi5SSKzArb30l8jjjYPuGa43Nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SdBvC/6lD60G2Pbfqt8ycSXKXdP8U9QBo6iEkIJVMpN15SIeTySlDd/1uPzvVnVQ7
	 wNkuHSGxgCACoPvV7TvFi8gprG00HgUDTjrcOdT9ZmIclA/2sadx0UbUPqsSgStl/V
	 DQNPPMYF927om8ZiYSSv3niF4LZ0r5Ts8Y12xGrQrEOV0KnZ0lGAeKZznV+RFLvOtT
	 pDjw8gQVSqKnj5LZFy8lrdIzfiCxa8+c/qHAGSyp6AhSc/1fIEHRrkaIb+LISiQQIn
	 md4sZM3oDXK0fpPTtLDkXBlgAK0FZXTbV6GE+KoutGPyChvojK9R/rrNLpydy4IVao
	 VDxKTq96QeQrA==
Date: Fri, 29 May 2026 16:28:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: dwarves@vger.kernel.org
Subject: Re: pahole treats embedded structures a holes
Message-ID: <ahno-Wd92sAnRkK9@x1>
References: <20260528051152.GA27820@lst.de>
 <ahhFlsCJzkxLt3M6@x1>
 <20260528135852.GA30243@lst.de>
 <ahicHN7iwtCwasPj@x1>
 <20260529040210.GA13350@lst.de>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260529040210.GA13350@lst.de>

On Fri, May 29, 2026 at 06:02:10AM +0200, Christoph Hellwig wrote:
> On Thu, May 28, 2026 at 04:48:44PM -0300, Arnaldo Carvalho de Melo wrote:
> > acme@number:~$ readelf -wi git/build/allmodconfig/fs/xfs/xfs_buf.o  | g=
rep -m1 DW_AT_producer
=20
> hch@brick:~/work/xfs$ readelf -wi fs/xfs/xfs_buf.o  | grep -m1 DW_AT_prod=
ucer
>     <d>   DW_AT_producer    : (indirect string, offset: 0x6012): GNU C11 =
15.2.0 -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -mno-sse4a -m64 -mno=
-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3D3 -mskip-rax-setup -=
march=3Dx86-64 -mtune=3Dgeneric -mno-red-zone -mcmodel=3Dkernel -mstack-pro=
tector-guard-reg=3Dgs -mstack-protector-guard-symbol=3D__ref_stack_chk_guar=
d -mindirect-branch=3Dthunk-extern -mindirect-branch-register -mindirect-br=
anch-cs-prefix -mfunction-return=3Dthunk-extern -g -gdwarf-5 -O2 -std=3Dgnu=
11 -fshort-wchar -funsigned-char -fno-common -fno-PIE -fno-strict-aliasing =
-fms-extensions -fcf-protection=3Dbranch -falign-jumps=3D1 -falign-loops=3D=
1 -fno-asynchronous-unwind-tables -fno-jump-tables -fpatchable-function-ent=
ry=3D16,16 -fno-delete-null-pointer-checks -fno-allow-store-data-races -fst=
ack-protector-strong -fomit-frame-pointer -fzero-init-padding-bits=3Dall -f=
no-stack-clash-protection -fmin-function-alignment=3D16 -fstrict-flex-array=
s=3D3 -fno-strict-overflow -fstack-check=3Dno -fconserve-stack -fno-builtin=
-wcslen -fno-var-tracking -femit-struct-debug-baseonly

> > then, please take a look at this sequence:

> > acme@number:~$ readelf -wi git/build/allmodconfig/fs/xfs/xfs_buf.o  | g=
rep -w xfs_buf$ -B1 -A12
=20
> hch@brick:~/work/xfs$ readelf -wi fs/xfs/xfs_buf.o  | grep -w xfs_buf$ -B=
1 -A12
>  <1><f1c>: Abbrev Number: 93 (DW_TAG_structure_type)
>     <f1d>   DW_AT_name        : (indirect string, offset: 0x3358): xfs_buf
>     <f21>   DW_AT_byte_size   : 344
>     <f23>   DW_AT_alignment   : 8
>     <f23>   DW_AT_decl_file   : 46
>     <f23>   DW_AT_decl_line   : 138
>     <f24>   DW_AT_decl_column : 8
>     <f24>   DW_AT_sibling     : <0x10a2>
>  <2><f28>: Abbrev Number: 39 (DW_TAG_member)
>     <f29>   DW_AT_name        : (indirect string, offset: 0x5e80): b_rhas=
h_head
>     <f2d>   DW_AT_decl_file   : 46
>     <f2d>   DW_AT_decl_line   : 146
>     <f2e>   DW_AT_decl_column : 20
>     <f2f>   DW_AT_type        : <0x9c8>
=20
> > acme@number:~$ readelf -wi git/build/allmodconfig/fs/xfs/xfs_buf.o  | g=
rep '<5b22>' -A12
=20
> hch@brick:~/work/xfs$ readelf -wi fs/xfs/xfs_buf.o  | grep '<0x9c8>' -A12

This part is the tricky one, see that the 0x isn't there inside the
<TYPE> in my grep, I guess whoever wrote readelf used this to get the
offset, not the many entries pointing to it :-)

You need to do this:

hch@brick:~/work/xfs$ readelf -wi fs/xfs/xfs_buf.o  | grep '<9c8>' -A12

Without the 0x, so that I can see what is the type for that member.

Or better, please send me your fs/xfs/xfs_buf.o, that will be easier,
I'll try it myself, and if I reproduce your results, I'll be able to fix
it and test on the same fs/xfs/xfs_buf.o file.

- Arnaldo

>     <9ce>   DW_AT_type        : <0x9c8>
>  <1><9d2>: Abbrev Number: 29 (DW_TAG_structure_type)
>     <9d3>   DW_AT_name        : (indirect string, offset: 0x303): rhlist_=
head
>     <9d7>   DW_AT_declaration : 1
>  <1><9d7>: Abbrev Number: 29 (DW_TAG_structure_type)
>     <9d8>   DW_AT_name        : (indirect string, offset: 0x27b4): rhasht=
able_compare_arg
>     <9dc>   DW_AT_declaration : 1
>  <1><9dc>: Abbrev Number: 17 (DW_TAG_pointer_type)
>     <9dd>   DW_AT_byte_size   : 8
>     <9dd>   DW_AT_type        : <0x9d7>
>  <1><9e1>: Abbrev Number: 29 (DW_TAG_structure_type)
>     <9e2>   DW_AT_name        : (indirect string, offset: 0x2ce3): rhasht=
able_params
>     <9e6>   DW_AT_declaration : 1
> --
>     <f2f>   DW_AT_type        : <0x9c8>
>     <f33>   DW_AT_data_member_location: 0
>  <2><f34>: Abbrev Number: 39 (DW_TAG_member)
>     <f35>   DW_AT_name        : (indirect string, offset: 0x25e): b_rhash=
_key
>     <f39>   DW_AT_decl_file   : 46
>     <f39>   DW_AT_decl_line   : 148
>     <f3a>   DW_AT_decl_column : 15
>     <f3b>   DW_AT_type        : <0xcb1>
>     <f3f>   DW_AT_data_member_location: 8
>  <2><f40>: Abbrev Number: 39 (DW_TAG_member)
>     <f41>   DW_AT_name        : (indirect string, offset: 0x3fbd): b_leng=
th
>     <f45>   DW_AT_decl_file   : 46
>     <f45>   DW_AT_decl_line   : 149
> --
>     <1fa9>   DW_AT_type        : <0x9c8>
>  <1><1fad>: Abbrev Number: 33 (DW_TAG_subprogram)
>     <1fae>   DW_AT_external    : 1
>     <1fae>   DW_AT_name        : (indirect string, offset: 0x5b66): __SCT=
__tp_func_xfs_buf_backing_vmalloc
>     <1fb2>   DW_AT_decl_file   : 3
>     <1fb3>   DW_AT_decl_line   : 793
>     <1fb5>   DW_AT_decl_column : 1
>     <1fb6>   DW_AT_prototyped  : 1
>     <1fb6>   DW_AT_type        : <0x6e>
>     <1fba>   DW_AT_declaration : 1
>     <1fba>   DW_AT_sibling     : <0x1fce>
>  <2><1fbe>: Abbrev Number: 6 (DW_TAG_formal_parameter)
>     <1fbf>   DW_AT_type        : <0x27f>
>=20
>=20
> > iacme@number:~$ readelf -wi git/build/allmodconfig/fs/xfs/xfs_buf.o  | =
grep '<5b42>' -A4
> >  <1><5b42>: Abbrev Number: 8 (DW_TAG_pointer_type)
> >     <5b43>   DW_AT_byte_size   : 8
> >     <5b43>   DW_AT_type        : <0x5b22>
> >  <1><5b47>: Abbrev Number: 30 (DW_TAG_structure_type)
> >     <5b48>   DW_AT_name        : (indirect string, offset: 0x14c84): rh=
list_head
>=20
> hch@brick:~/work/xfs$ readelf -wi fs/xfs/xfs_buf.o  | grep '<0x9c8>' -A4
>     <9ce>   DW_AT_type        : <0x9c8>
>  <1><9d2>: Abbrev Number: 29 (DW_TAG_structure_type)
>     <9d3>   DW_AT_name        : (indirect string, offset: 0x303): rhlist_=
head
>     <9d7>   DW_AT_declaration : 1
>  <1><9d7>: Abbrev Number: 29 (DW_TAG_structure_type)
> --
>     <f2f>   DW_AT_type        : <0x9c8>
>     <f33>   DW_AT_data_member_location: 0
>  <2><f34>: Abbrev Number: 39 (DW_TAG_member)
>     <f35>   DW_AT_name        : (indirect string, offset: 0x25e): b_rhash=
_key
>     <f39>   DW_AT_decl_file   : 46
> --
>     <1fa9>   DW_AT_type        : <0x9c8>
>  <1><1fad>: Abbrev Number: 33 (DW_TAG_subprogram)
>     <1fae>   DW_AT_external    : 1
>     <1fae>   DW_AT_name        : (indirect string, offset: 0x5b66): __SCT=
__tp_func_xfs_buf_backing_vmalloc
>     <1fb2>   DW_AT_decl_file   : 3
