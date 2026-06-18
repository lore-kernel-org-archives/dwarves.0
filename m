Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372E523392B
	for <dwarves@vger.kernel.org>; Thu, 18 Jun 2026 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781790675; cv=none; b=Qh3KAsEk5UErVkJ3QteQgRnNUzt8ImUgJokdjJDgRX8iBzcPSnHVfVoGlsICB0C+ldx7zO3hM98ABzMDw0D3AcXjrizdOptOgJ2LcSy4VvSBsomZB7mv68qh8UGTyG/fufgSAcksq3ErFI0U8nvmpWEGTeIOVRlv0lX9Vl2icQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781790675; c=relaxed/simple;
	bh=9iSUeXkAB3tEQ3tgiM/gY5/5plZ7vGB2+KvXs3v7cSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeBajFYwKj2EUh+pCQJ69V7W6P7Xca0LstySLOmpUju1h/G1+EF+K+jLb/oOc7VZvXvHRHdJhFdBGiPIaJ07GygI9+6iZmJZmgid+WuAGvf7E8nlJyzbBVZ9kcUTPTzFQFMWKQ98/NsZ5vmxhzj7CieIOtilL+IFDBkNTyw4rN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFOw0DBx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFOw0DBx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5242B1F000E9;
	Thu, 18 Jun 2026 13:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781790673;
	bh=jQ1CKxJfemp56RLATonhkvebyCB6kjdfrdp6o+lx/x0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iFOw0DBxxFZXBo1zbd4OMKyn9RpuB5lTtyhgQGwhurUiAdK6mEscijyA+4ZrOwt0y
	 FIgpLOq8n1vzKFxVY/EsbtQP7ArgpEOITvAk2C91jKb6/JOSBKu559RoTofc6rP7jL
	 lwnnZdN8vGNSAIeZEqyuRf2UfYQb4gg/cS5nbilp5K9OAX7DvEBt+TddUHjCm/v1dB
	 ReFThZGNTOaGCU5UQ7r0xlLWhKIvxG5Tv0jJX02JdFraJf3x4krjtz1Ss7ektuD7cS
	 3bdCxjYVdPSYWEqSDw2xaC7Q3/uXjOCRjSDv+eH7ZwFFWwO39fMw8vDIMr2j1dL66p
	 v5gu1hTcjiZSw==
Date: Thu, 18 Jun 2026 10:51:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 1/3] dwarf_loader: Initial support for DW_TAG_variant_part
Message-ID: <ajP3zsT0rub9kEKt@x1>
References: <20260323211533.1909029-1-acme@kernel.org>
 <20260323211533.1909029-2-acme@kernel.org>
 <78c51d5b-554c-42c0-ac6d-2e7738d9f3ca@oracle.com>
 <adaSEUa3QbcL26JT@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adaSEUa3QbcL26JT@x1>

On Wed, Apr 08, 2026 at 02:36:17PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Apr 08, 2026 at 03:05:35PM +0100, Alan Maguire wrote:
> > On 23/03/2026 21:15, Arnaldo Carvalho de Melo wrote:
> > > +void type__add_variant_part(struct type *type, struct variant_part *vpart);
 
> > >  struct class_member *
> > >  	type__find_first_biggest_size_base_type_member(struct type *type,
  
> > do we also need some cleanup for the variant parts in type__delete() something like:
> > 
> > 	list_for_each_entry_safe(pos, n, type->variant_parts, node) {
> > 		list_del_int(&pos->node);
> > 		free(pos);
> > 	}
 
> Right, I'll fix it in v2, there are some other issues that Claude
> detected that I'll address in the enumeration case, one of them can be
> seen here:

Done with:

static void type__delete_variant_parts(struct type *type, struct cu *cu)
{
        struct variant_part *pos, *next;

        type__for_each_variant_part_safe_reverse(type, pos, next) {
                list_del_init(&pos->tag.node);
                variant_part__delete(pos, cu);
        }
}

Called from type__delete(), as you suggested.
 
> ⬢ [acme@toolbx pahole]$ pahole -C ProgramKind /tmp/build/perf-tools-next/tests/workloads/code_with_type.a
> enum ProgramKind {
> 	PathLookup = 0,
> 	Relative   = 1,
> 	Absolute   = 2,
> 	�3"��     = 140698500347136,
> } __attribute__((__packed__));
> 
> ⬢ [acme@toolbx pahole]$
> 
> Namely this Rust enum has a DW_TAG_subprogram, that
> enumeration__fprintf() doesn't know about, fixing it now.

Finally got back to working on this:

⬢ [acme@toolbx pahole]$ pahole -C ProgramKind /tmp/build/perf-tools-next/tests/workloads/code_with_type.a
enum ProgramKind {
	PathLookup = 0,
	Relative   = 1,
	Absolute   = 2,
	enum ProgramKind new(struct &std::ffi::os_str::OsStr),
} __attribute__((__packed__));

⬢ [acme@toolbx pahole]$

Will submit a v2 series,

- Arnaldo
