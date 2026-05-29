Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DA918DB1A
	for <dwarves@vger.kernel.org>; Fri, 29 May 2026 04:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780027337; cv=none; b=kYaRM1UYpZ3OWnhc2tR7jAuFCED+89xUc5C9OhcmKebfS+jl1reqKVx2GcAmEe26FcYgxxUOUe91wqpvkYo8G3rCh5nuL8r8Mo3WXIW+B4oKrD0RK6exf8Li6I5KMtIuoK76QTQdq+FsFZ5BgKvKg7bSYi8sgBp/bj3zgmh+QAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780027337; c=relaxed/simple;
	bh=hL6R/nh4Nn3ToGqzI5Udmuir0+oJGapO0gWtbk4wTT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPbmaUo3CWsBLVPKMzWXmLxzOzYxSZl+/Usw/KyBMehGrpf8AVbiKJTF5zL8i8hxZkqM7pmE3Vf4YxPy3FAJiYw3WxC7o0DJAxgyqx0LEGfBDMSJNOGBtLl6lLhjEewTxRkutSba0hURiP/Rexl4WsxXhHuzchXWPEqfWR3G58M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1C83C68BEB; Fri, 29 May 2026 06:02:11 +0200 (CEST)
Date: Fri, 29 May 2026 06:02:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org
Subject: Re: pahole treats embedded structures a holes
Message-ID: <20260529040210.GA13350@lst.de>
References: <20260528051152.GA27820@lst.de> <ahhFlsCJzkxLt3M6@x1> <20260528135852.GA30243@lst.de> <ahicHN7iwtCwasPj@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ahicHN7iwtCwasPj@x1>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 28, 2026 at 04:48:44PM -0300, Arnaldo Carvalho de Melo wrote:
> acme@number:~$ readelf -wi git/build/allmodconfig/fs/xfs/xfs_buf.o  | gre=
p -m1 DW_AT_producer

hch@brick:~/work/xfs$ readelf -wi fs/xfs/xfs_buf.o  | grep -m1 DW_AT_produc=
er
    <d>   DW_AT_producer    : (indirect string, offset: 0x6012): GNU C11 15=
=2E2.0 -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -mno-sse4a -m64 -mno=
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



> then, please take a look at this sequence:
>=20
> acme@number:~$ readelf -wi git/build/allmodconfig/fs/xfs/xfs_buf.o  | gre=
p -w xfs_buf$ -B1 -A12

hch@brick:~/work/xfs$ readelf -wi fs/xfs/xfs_buf.o  | grep -w xfs_buf$ -B1 =
-A12
 <1><f1c>: Abbrev Number: 93 (DW_TAG_structure_type)
    <f1d>   DW_AT_name        : (indirect string, offset: 0x3358): xfs_buf
    <f21>   DW_AT_byte_size   : 344
    <f23>   DW_AT_alignment   : 8
    <f23>   DW_AT_decl_file   : 46
    <f23>   DW_AT_decl_line   : 138
    <f24>   DW_AT_decl_column : 8
    <f24>   DW_AT_sibling     : <0x10a2>
 <2><f28>: Abbrev Number: 39 (DW_TAG_member)
    <f29>   DW_AT_name        : (indirect string, offset: 0x5e80): b_rhash_=
head
    <f2d>   DW_AT_decl_file   : 46
    <f2d>   DW_AT_decl_line   : 146
    <f2e>   DW_AT_decl_column : 20
    <f2f>   DW_AT_type        : <0x9c8>


> acme@number:~$ readelf -wi git/build/allmodconfig/fs/xfs/xfs_buf.o  | gre=
p '<5b22>' -A12


hch@brick:~/work/xfs$ readelf -wi fs/xfs/xfs_buf.o  | grep '<0x9c8>' -A12
    <9ce>   DW_AT_type        : <0x9c8>
 <1><9d2>: Abbrev Number: 29 (DW_TAG_structure_type)
    <9d3>   DW_AT_name        : (indirect string, offset: 0x303): rhlist_he=
ad
    <9d7>   DW_AT_declaration : 1
 <1><9d7>: Abbrev Number: 29 (DW_TAG_structure_type)
    <9d8>   DW_AT_name        : (indirect string, offset: 0x27b4): rhashtab=
le_compare_arg
    <9dc>   DW_AT_declaration : 1
 <1><9dc>: Abbrev Number: 17 (DW_TAG_pointer_type)
    <9dd>   DW_AT_byte_size   : 8
    <9dd>   DW_AT_type        : <0x9d7>
 <1><9e1>: Abbrev Number: 29 (DW_TAG_structure_type)
    <9e2>   DW_AT_name        : (indirect string, offset: 0x2ce3): rhashtab=
le_params
    <9e6>   DW_AT_declaration : 1
--
    <f2f>   DW_AT_type        : <0x9c8>
    <f33>   DW_AT_data_member_location: 0
 <2><f34>: Abbrev Number: 39 (DW_TAG_member)
    <f35>   DW_AT_name        : (indirect string, offset: 0x25e): b_rhash_k=
ey
    <f39>   DW_AT_decl_file   : 46
    <f39>   DW_AT_decl_line   : 148
    <f3a>   DW_AT_decl_column : 15
    <f3b>   DW_AT_type        : <0xcb1>
    <f3f>   DW_AT_data_member_location: 8
 <2><f40>: Abbrev Number: 39 (DW_TAG_member)
    <f41>   DW_AT_name        : (indirect string, offset: 0x3fbd): b_length
    <f45>   DW_AT_decl_file   : 46
    <f45>   DW_AT_decl_line   : 149
--
    <1fa9>   DW_AT_type        : <0x9c8>
 <1><1fad>: Abbrev Number: 33 (DW_TAG_subprogram)
    <1fae>   DW_AT_external    : 1
    <1fae>   DW_AT_name        : (indirect string, offset: 0x5b66): __SCT__=
tp_func_xfs_buf_backing_vmalloc
    <1fb2>   DW_AT_decl_file   : 3
    <1fb3>   DW_AT_decl_line   : 793
    <1fb5>   DW_AT_decl_column : 1
    <1fb6>   DW_AT_prototyped  : 1
    <1fb6>   DW_AT_type        : <0x6e>
    <1fba>   DW_AT_declaration : 1
    <1fba>   DW_AT_sibling     : <0x1fce>
 <2><1fbe>: Abbrev Number: 6 (DW_TAG_formal_parameter)
    <1fbf>   DW_AT_type        : <0x27f>


> iacme@number:~$ readelf -wi git/build/allmodconfig/fs/xfs/xfs_buf.o  | gr=
ep '<5b42>' -A4
>  <1><5b42>: Abbrev Number: 8 (DW_TAG_pointer_type)
>     <5b43>   DW_AT_byte_size   : 8
>     <5b43>   DW_AT_type        : <0x5b22>
>  <1><5b47>: Abbrev Number: 30 (DW_TAG_structure_type)
>     <5b48>   DW_AT_name        : (indirect string, offset: 0x14c84): rhli=
st_head

hch@brick:~/work/xfs$ readelf -wi fs/xfs/xfs_buf.o  | grep '<0x9c8>' -A4
    <9ce>   DW_AT_type        : <0x9c8>
 <1><9d2>: Abbrev Number: 29 (DW_TAG_structure_type)
    <9d3>   DW_AT_name        : (indirect string, offset: 0x303): rhlist_he=
ad
    <9d7>   DW_AT_declaration : 1
 <1><9d7>: Abbrev Number: 29 (DW_TAG_structure_type)
--
    <f2f>   DW_AT_type        : <0x9c8>
    <f33>   DW_AT_data_member_location: 0
 <2><f34>: Abbrev Number: 39 (DW_TAG_member)
    <f35>   DW_AT_name        : (indirect string, offset: 0x25e): b_rhash_k=
ey
    <f39>   DW_AT_decl_file   : 46
--
    <1fa9>   DW_AT_type        : <0x9c8>
 <1><1fad>: Abbrev Number: 33 (DW_TAG_subprogram)
    <1fae>   DW_AT_external    : 1
    <1fae>   DW_AT_name        : (indirect string, offset: 0x5b66): __SCT__=
tp_func_xfs_buf_backing_vmalloc
    <1fb2>   DW_AT_decl_file   : 3

