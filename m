Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47B65BACF
	for <dwarves@vger.kernel.org>; Wed,  7 Feb 2024 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707309026; cv=none; b=rhKDdTLEkDpJexHz/g7Qp2WDPf/q5RQSo8BuQvZaQNfcPlvGTYY/J9gBP+ro+sqPlGGbTHoNDLLwAkPm+/hr5lhCMwg9LQ1B2gCgBu/jHbFS9qRF3sAEbwqocbcdPY8woIBFfdDGFp5aT8oAKvXNkQA8k4TBcjydgV7cZTtW4fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707309026; c=relaxed/simple;
	bh=SQ2UcatYUXxkBY+KBtZ897cKuWR07oyiqibihlfnFhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kch5DV77Fm8o1LmCs7zQbAEmz5MZ5gVC9O6F9lGjZDgdsPd7JjML/hfeB92FUIjnkw3XBvTxAbxG+7UFaOQgYYMyGEGg9vl0XAa9mNlSZKS4mEqi6z8QWEHwPIUB1vBrtsDC0IUuFJ5nAKwVYFA4a2UQDLsl3oNUs2L04+DYz8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OdHzP5su; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BM9BuLGb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OdHzP5su";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BM9BuLGb"
Date: Wed, 7 Feb 2024 13:30:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707309022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ODwAbJK9JNHf1LpQ+YB/9Y4kk4H1rgzpQfmpgB5yJ/o=;
	b=OdHzP5suEDL4WqZFL5+9hHLPxV7P3O0/xydjebsstobgmtvWuD2k56r0WaGMzzgzBmdXZ7
	Hwf6AYQCxaYCYCY+IIe77BBJdHSmXp2v8pKeeHQOnVavnfAGVN7caZAe13HIxjO5zdz/nb
	mPS+b820Ut+tCT7otcDjb8oyUS2YqJh53BWswcb5h9MaRDyVf/ABS12Wcbtg7dvg+AGw3n
	F8oM4hdU7p5zUYSAyGvvC2qOBjhqnIBePPgI3cm1j+no32H38rXFAs987goQBAND2fTgIV
	Fuf0HiZm1eK38nFU1grlS26duwpsvodLl840YkmwcHtr/X/+fhI9gyVjsNbOiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707309022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ODwAbJK9JNHf1LpQ+YB/9Y4kk4H1rgzpQfmpgB5yJ/o=;
	b=BM9BuLGbLR12r2fGwOjX6K+nxtx+eimLXAZY6wOedmF2f4JQpUv7sTHhzfFZECl1MfNYOA
	u5XrMPCpXA8YrIBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Encoding BTF information from DWARF causes "has void type" error.
Message-ID: <20240207123021.zCd9dUk2@linutronix.de>
References: <20240206120226.6r7n4vQ3@linutronix.de>
 <ZcI3TVlOYuQfCWv2@x1>
 <ZcJA-mrVh5qmkxfV@x1>
 <e009cb74-feba-47c9-9d5d-b99517261017@oracle.com>
 <15bd5441-9e34-426b-9715-df43beedf1c8@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <15bd5441-9e34-426b-9715-df43beedf1c8@oracle.com>

On 2024-02-07 11:03:15 [+0000], Alan Maguire wrote:
> On 07/02/2024 10:01, Alan Maguire wrote:
> > The problem is the conditional check above; I can't see why it needs to
> > be guarded here. We never want to do an address-based lookup for a
> > variable and not have it be the same variable name as we have from DWARF
> > - which is the one we're trying to encode, right? The following fixes
> > the issue for me, can you try this out if you get a chance? I might be
> > missing something about that check so other folks please do weigh in if
> > something looks broken. Thanks!

So the former patch worked.

> apologies, but my suggested fix is wrong I believe.  When tested with
> vmlinux BTF generation, around 100 per-cpu variables disappeared.
> I believe the fix should instead be (deliberately leaving in
> verbose output to help debug future issues):

no worries.

=E2=80=A6
> This works for both vmlinux generation and the problem you ran into.

the .o file was a reduced testcase. It works with the "complete" file
here, too. However once that file is merged into vmlinux.o I get the error
again:
| $ pahole -J --btf_gen_floats -j --lang_exclude=3Drust pahole-tc2/skbuff.o
| $ pahole -J --btf_gen_floats -j --lang_exclude=3Drust pahole-tc2/vmlinux.=
o --btf_encode_force
| error: found variable 'napi_alloc_cache' in CU 'net/core/skbuff.c' that h=
as void type
| error: found variable 'napi_alloc_cache' in CU 'net/core/skbuff.c' that h=
as void type
| error: found variable 'napi_alloc_cache' in CU 'net/core/skbuff.c' that h=
as void type
| error: found variable 'napi_alloc_cache' in CU 'net/core/skbuff.c' that h=
as void type

The -V output is huge and I don't really know what to look at. The
skbuff.o skipped __UNIQUE_ID_guard826 and a few "NULLs" and the address
for __UNIQUE_ID_guard826 was 0. In the vmlinux.o the address for
__UNIQUE_ID_guard826 is 19440.

I uploaded the two .o at
	https://breakpoint.cc/pahole-tc2.tar.xz

it decompresses to 1.1GiB.

> The explanation is that prior to this, we get an adjusted value for
> "addr" to do per-cpu variable lookup, where we subtract the per-cpu base
> address. We should also use that adjusted address to check for a zero
> address in the test to see if we need to use names to resolve per-cpu
> variable identity. The problem was the __UNIQUE_ID variable had a
> non-zero var->ip.addr value but its value relative to the per-cpu base
> was 0. With the adjusted value, we do the name matching and skip the
> encoding as intended I believe.
>=20
> Alan

Sebastian
