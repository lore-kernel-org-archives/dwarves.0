Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5575A22314
	for <dwarves@vger.kernel.org>; Tue,  6 Feb 2024 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230411; cv=none; b=P1pKfNdMGK6hgzJaPElRdqiyksKQ0SQkhqwTjobMaaIRDELH7oMnE3cgGIVk2jwnLhuyarhWnY2+bhPGKighbwd6FKdAeO/dpNBjApt1GQ6l1fVnbJmTGk2V4/xJ8Ae1uqa18UMzlc4t3yBHuUaIM1klgRCgDEszybWlv7E9gGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230411; c=relaxed/simple;
	bh=VEeOg3FPkd2OCWjErFlGcs6yOUjejBHfDYTBcoSvKVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rP1RKqPal9EiYFmDcSLWmFFD0kZpMrouY9h2vMzjlGAl+Vg8KjL8PFTdzFzI0/v7oxbJEk/f/RPnGdRBXU8p5EKAabhFPbj4Fs0OQVm1Z2SS6wJfZxCs5g7gusn2QzF/tI2G8OTY0gLikfRsWXOHESaftRdfUcDU2C0ocbuWvfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CM1BQ+Go; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6dGhHtr0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CM1BQ+Go";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6dGhHtr0"
Date: Tue, 6 Feb 2024 15:40:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707230407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTy9PV8Gt0qTgeX0dGuepvC5Gi5PkQmri7em8dh8zqc=;
	b=CM1BQ+GoEmgJQS/PfTha9n6eHaiXCyUEQR2l1ohO1yreu8pkv/QIEvgJV9go3tKOi0DmiC
	lsJLDdw4SjCkpeFRpue1uDoQ55WcDmoYy+v6BdbArMwrpVCpLwDD5jQDoGJQ8eAwbGPpm8
	JYY0TlYbN8LFra1dKBK6ZQSulhym7l45T65aOvTYtBxeuK1wGgnYQN1LT0TQW28AbuDH5o
	lGIzBjKD9SnTViVPu2EltCabHJDh+24iuysSSLQciSjKc4EF3BMrQHNXYhKS9/mlIHZBND
	VAMoL8xXBOZlmryDjf1DaiDN4wqf/bHEBSePqwJ3h1m/lkVq8OXPghWb/fqikw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707230407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTy9PV8Gt0qTgeX0dGuepvC5Gi5PkQmri7em8dh8zqc=;
	b=6dGhHtr0dZvp5L2mDNPMLwhc6b/tF3qt3ldO8k8rBvvGn5kTuP40WG10OReUX6x7mn1+fd
	OixTEyBEqCYIlVCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>,
	dwarves@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Encoding BTF information from DWARF causes "has void type" error.
Message-ID: <20240206144006.1KQTetWT@linutronix.de>
References: <20240206120226.6r7n4vQ3@linutronix.de>
 <ZcI3TVlOYuQfCWv2@x1>
 <ZcJA-mrVh5qmkxfV@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZcJA-mrVh5qmkxfV@x1>

On 2024-02-06 11:23:54 [-0300], Arnaldo Carvalho de Melo wrote:
> > > compiling and running pahole afterwards:
> > > | make kernel/pahole-tc.o && pahole -J --btf_gen_floats -j --lang_exc=
lude=3Drust  kernel/pahole-tc.o
> > > |   CC      kernel/pahole-tc.o
> > > | error: found variable 'per_cpu_struct' in CU 'kernel/pahole-tc.c' t=
hat has void type
> > >=20
> > > This doesn't look good. If I swap the order of "lock" and "something"
> > > within per_cpu_struct then it goes away.
> > > The dwarf/die object it complains about has only DW_AT_abstract_origin
> > > and DW_AT_location set.
>=20
> Are you sure?

I added to variable__new():
|                      for (i =3D 0; i < DW_AT_hi_user; i++) {
|                              if (dwarf_hasattr(die, i))
|                                      fprintf(stderr, "  =3D> ATTR %x\n", =
i);
|                      }

and I get:
|  =3D> ATTR 2
|  =3D> ATTR 31

so this what I have to say in my defence ;)

> What I see:
>=20
> =E2=AC=A2[acme@toolbox pahole]$ cp sebastian-rt-void-variable-btf/pahole-=
tc/pahole-tc-bad.o .
> =E2=AC=A2[acme@toolbox pahole]$ pahole --btf_encode pahole-tc-bad.o
> error: found variable 'per_cpu_struct' in CU 'kernel/pahole-tc.c' that ha=
s void type
> =E2=AC=A2[acme@toolbox pahole]$
>=20
> =E2=AC=A2[acme@toolbox pahole]$ readelf -wi sebastian-rt-void-variable-bt=
f/pahole-tc/pahole-tc-bad.o | grep DW_TAG_variable -A5 | grep -w per_cpu_st=
ruct -B1 -A4
>  <1><764>: Abbrev Number: 29 (DW_TAG_variable)
>     <765>   DW_AT_name        : (indirect string, offset: 0x184): per_cpu=
_struct
>     <769>   DW_AT_decl_file   : 1
>     <769>   DW_AT_decl_line   : 9
>     <76a>   DW_AT_decl_column : 8
>     <76b>   DW_AT_type        : <0x73c>
> =E2=AC=A2[acme@toolbox pahole]$
>=20
> =E2=AC=A2[acme@toolbox pahole]$ readelf -wi sebastian-rt-void-variable-bt=
f/pahole-tc/pahole-tc-bad.o | grep '<73c>.*DW_TAG_structure_type' -A7
>  <1><73c>: Abbrev Number: 4 (DW_TAG_structure_type)
>     <73d>   DW_AT_name        : (indirect string, offset: 0x184): per_cpu=
_struct
>     <741>   DW_AT_byte_size   : 136
>     <742>   DW_AT_decl_file   : 1
>     <743>   DW_AT_decl_line   : 4
>     <744>   DW_AT_decl_column : 8
>     <745>   DW_AT_sibling     : <0x764>
>  <2><749>: Abbrev Number: 1 (DW_TAG_member)
> =E2=AC=A2[acme@toolbox pahole]$
>=20
> But when using verbose mode:
>=20
> [95] FUNC function type_id=3D94
> search cu 'kernel/pahole-tc.c' for percpu global variables.
> Variable 'per_cpu_struct' from CU 'kernel/pahole-tc.c' at address 0x0 enc=
oded
> [96] VAR per_cpu_struct type=3D90 linkage=3D0
> Variable 'per_cpu_struct' from CU 'kernel/pahole-tc.c' at address 0x0 enc=
oded
> [97] VAR per_cpu_struct type=3D91 linkage=3D0
> error: found variable 'per_cpu_struct' in CU 'kernel/pahole-tc.c' that ha=
s void type
> [98] DATASEC .data..percpu size=3D136 vlen=3D2
> 	type=3D96 offset=3D0 size=3D136
> 	type=3D97 offset=3D0 size=3D136
> =E2=AC=A2[acme@toolbox pahole]$ pahole -V --btf_encode pahole-tc-bad.o
>=20
> It ends up considering two variables with that name?

Yes. That is the odd part. The second one comes from the guard()
construct which has also a this_cpu_ptr() as part of local_lock(). After
a while I figured out that dwarf_tag->id is the same as in dwarfdump
output and this matched the "t".

> =E2=AC=A2[acme@toolbox pahole]$ readelf -wi sebastian-rt-void-variable-bt=
f/pahole-tc/pahole-tc-bad.o | grep per_cpu_struct -B1 -A5
>  <1><73c>: Abbrev Number: 4 (DW_TAG_structure_type)
>     <73d>   DW_AT_name        : (indirect string, offset: 0x184): per_cpu=
_struct
>     <741>   DW_AT_byte_size   : 136
>     <742>   DW_AT_decl_file   : 1
>     <743>   DW_AT_decl_line   : 4
>     <744>   DW_AT_decl_column : 8
>     <745>   DW_AT_sibling     : <0x764>
> --
>  <1><764>: Abbrev Number: 29 (DW_TAG_variable)
>     <765>   DW_AT_name        : (indirect string, offset: 0x184): per_cpu=
_struct
>     <769>   DW_AT_decl_file   : 1
>     <769>   DW_AT_decl_line   : 9
>     <76a>   DW_AT_decl_column : 8
>     <76b>   DW_AT_type        : <0x73c>
>     <76f>   DW_AT_location    : 9 byte block: 3 0 0 0 0 0 0 0 0 	(DW_OP_a=
ddr: 0)
> =E2=AC=A2[acme@toolbox pahole]$
>=20
> Just dumping some more info in case Jiri or Alan thinks about something.

Thank you for looking at this Arnaldo.

> - Arnaldo

Sebastian
