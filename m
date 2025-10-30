Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7390936CDF7
	for <dwarves@vger.kernel.org>; Thu, 30 Oct 2025 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761849483; cv=none; b=YhmOJYAXvCcN2hpuCV/iyqAwUbElIuRpIAiyrfZYQdg+KLFPRZuLAtgh7mo0MSAhzKYRH84SFoUFRBbambQoUrEK0YerA6tl/e4NsCfzi2fRrbIn37DbeXmpIGSQhq1W+1GkEvhXcPI5BZMoTwpns9owX4kHIBLDFdr5eRUjbdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761849483; c=relaxed/simple;
	bh=TlrV1DnithshF+h4ADVjqUfqCPrrq1n4qZHi7Mikd8w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cThcezzysBcREZfP00MtQ2SfTBQGogKjkC7SG6lJfvz2O9whhig5gwCiQmtyJSgTm4EVKSnycpxeCBfVF5UuGcHR1nh2OO2tbHm1p61aPUrbyLAbxsTJQ5grVaMKE5ae/MsgiMQaUPhPi5NbmP52pqxIoqQjYfEg5HqO4qMA9ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lY4DSTxB; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lY4DSTxB"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-794e300e20dso2088810b3a.1
        for <dwarves@vger.kernel.org>; Thu, 30 Oct 2025 11:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761849479; x=1762454279; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=geHfP5DlVcwtHVtcc7C58k5v0O4j7Yun6i2OcvgG2TI=;
        b=lY4DSTxBv+uT5Gz06ahDl2m57hvaBEOoXvlVDbnBrYRdFUr6ghCK5bmZ/85J0badEk
         KSXdjRTf5r/RQZ+mkTBCBdIMMtD7l9lAysibups6Njd5Zw8tkPMyG7tS7XPKNfXUKpuu
         18vDh7rwe7WoOZl8H4qVTk6MTNAKO9XsppCoR0kgrJkFGP/kB/tEGXiXbOaoDbrsocAP
         3h9AD5pMlG+L8cbE2HaFD8lhJ+AhFUp8vzde5I71vJiEKmjY9Dvhwym6sK8TJ72RLCu+
         lyN3tLkOern5KbYHcrbkFhYpBNwGEsUzOyMvEuP6kib/0dSpjnV9pJBxDDephb7f7kE4
         XkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761849479; x=1762454279;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=geHfP5DlVcwtHVtcc7C58k5v0O4j7Yun6i2OcvgG2TI=;
        b=inUnv3YC9ffEf+e8liwXnXRUMtPGJtB1ckdyu+32fbRXpLXiwRR5ko39+yd75+EJ7R
         4NxF6Axr7V6tr0qT4pcFVKty0flqUli0r1onR75D+JveBcfccgeigSfLmD4Rh4gy6aUV
         pKPJm8X8+OCjXZOQiYmZaOVdGtbABl9dojEg/TA3fPHDxcrs+2nL37XOGApAY4zv0Rl6
         LQyeUHAY31oD/sqZgsTBrF2SgzQ+e6XiUiXBOlPeHT4M3ywXhVszHNXMgmhI72fRjQDT
         JhW6nwSOB4qM2CP9QCqUW4vXDDhLd5GdwMIlaZlobfA2FDyPzIreoobJ6DwpPcKce9tj
         BDhQ==
X-Gm-Message-State: AOJu0YyamfAC7592mzHVmnYuJWNDdyxpfdcWrcjK3BREr7MVm4enndRw
	n/UARkMxybsJ+BjblLAOfeVWQygYjneDMcTnz4sWxAQolEU4Cwqe0d2m
X-Gm-Gg: ASbGnctS6dJgvd5EIo3WEzs4uNyNH7W/DkrAFb7vSxAHlCYdbX7b/wQ2d5zb6waT5Vi
	7QCO2xhFQlvjobbtjWvbZpRytiWB7QPn6hJEaayvdZIHIwviZXwur9i/d3VRYU6faw1VULGKh37
	W7lmxfC7bDgpcxrYtLb4fPIyCW18y1gQeqrWVJdXLPjuJWP6nAOK5ndDFnGvrt5k3OrRFhDiOXR
	exP/JbZU3LoV0B2BUOYNXg/VkQfxnLth5zp0zfzXIwm24/jJoTpquzsA6D44fqZbVBaNuL8CqWa
	GA2zg3+6GXWxV4OyDKLy9gOcZ23SyTZ10tzFFvd0F5TrDlxJJhRCxM0hhqf2wFF/tr2gE09P2OU
	MQ+UsVO+BUJVgMJOcmByC7qmE3mI6yoEeORJHlI7CkigZXHOg9Nrj3qBlXO7hb4v+rxGjR3H59z
	inP5ZyZEpS
X-Google-Smtp-Source: AGHT+IHmC2/V/ZkMIcPjBdonhp4BifhpepDvNUFzZLcARo9bBPDRE8JHLCJcMWAZ0gF8aGgsFpEfCA==
X-Received: by 2002:a17:902:d4c3:b0:271:fa2d:534c with SMTP id d9443c01a7336-29519b9eed1mr9558365ad.22.1761849478577;
        Thu, 30 Oct 2025 11:37:58 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2950ed75b46sm14657215ad.101.2025.10.30.11.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 11:37:58 -0700 (PDT)
Message-ID: <d72a8a0313f2c7c7ce0c1d0bc9b49458b9bd59c7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/8] bpf: magic kernel functions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
	andrii@kernel.org, ast@kernel.org
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org, 
	tj@kernel.org, kernel-team@meta.com
Date: Thu, 30 Oct 2025 11:37:55 -0700
In-Reply-To: <7b44aae0-b2d1-4398-8721-04c052aa2a77@linux.dev>
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
	 <50ddff79d33d6e2d57e104f610273d647530ddbc.camel@gmail.com>
	 <99115d79a7808ca1290726561e36b64ec56e2a1e.camel@gmail.com>
	 <6e0b67d02cf7243b01a163589b3b58d1e4a0fdd8.camel@gmail.com>
	 <7b44aae0-b2d1-4398-8721-04c052aa2a77@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-30 at 11:24 -0700, Ihor Solodrai wrote:
> On 10/30/25 11:14 AM, Eduard Zingerman wrote:
> > On Wed, 2025-10-29 at 23:11 -0700, Eduard Zingerman wrote:
> > > On Wed, 2025-10-29 at 17:44 -0700, Eduard Zingerman wrote:
> > > > On Wed, 2025-10-29 at 12:01 -0700, Ihor Solodrai wrote:
> > > >=20
> > > > Do we break compatibility with old pahole versions after this
> > > > patch-set? Old paholes won't synthesize the _impl kfuncs, so:
> > > > - binary compatibility between new-kernel/old-pahole + old-bpf
> > > > =C2=A0 will be broken, as there would be no _impl kfuncs;
> > > > - new-kernel/old-pahole + new-bpf won't work either, as kernel will
> > > > be
> > > > =C2=A0 unable to find non-_impl function names for existing kfuncs.
> > > >=20
> > > > [...]
> > >=20
> > > Point being, if we are going to break backwards compatibility the
> > > following things need an update:
> > > - Documentation/process/changes.rst
> > >   minimal pahole version has to be bumped
> > > - scripts/Makefile.btf
> > >   All the different flags and options for different pahole
> > >   versions can be dropped.
> > >=20
> > > ---
> > >=20
> > > On the other hand, I'm not sure this useful but relatively obscure
> > > feature grants such a compatibility break. Some time ago Ihor
> > > advocated for just having two functions in the kernel, so that BTF
> > > will be generated for both. And I think that someone suggested puttin=
g
> > > the fake function to a discard-able section.
> > > This way the whole thing can be done in kernel only.
> > > E.g. it will look like so:
> > >=20
> > >   __bpf_kfunc void btf_foo_impl(struct bpf_prog_aux p__implicit)
> > >   { /* real impl here */ }
> > >=20
> > >   __bpf_kfunc_proto void btf_foo(void) {}
> > >=20
> > > Assuming that __bpf_kfunc_proto hides all the necessary attributes.
> > > Not much boilerplate, and a tad easier to understand where second
> > > prototype comes from, no need to read pahole.
> >=20
> > Scheme discussed off-list for new functions with __implicit args:
> > - kernel source code:
> >=20
> >     __bpf_kfunc void foo(struct bpf_prog_aux p__implicit)
> > 	BTF_ID_FLAGS(foo, KF_IMPLICIT_ARGS)
> >=20
> > - pahole:
> >   - renames foo to foo_impl
> >   - adds bpf-side definition for 'foo' w/o implicit args
> >   vmlinux btf:
> >=20
> >     __bpf_kfunc void foo_impl(struct bpf_prog_aux p__implicit);
> >     void foo(void);
>=20
> I believe it's the other way around:
>      void foo_impl(struct bpf_prog_aux p__implicit);
>      __bpf_kfunc void foo(void);
>=20
> foo() is callable from BPF, but foo_impl() is not.
> But we still want foo_impl() in BTF so that the verifier can find the=20
> correct prototype.
>=20
> Andrii, please confirm.

Oops, yes, 'foo' gets __bpf_kfunc.

> > - resolve_btfids puts the 'foo' (the one w/o implicit args) id to all
> >   id lists (no changes needed for this, follows from pahole changes);
> > - verifier.c:add_kfunc_call()
> >   - Sees the id of 'foo' and kfunc flags with KF_IMPLICIT_ARGS
> >   - Replaces the id with id of 'foo_impl'.
> >=20
> > This will break the following scenario:
> > - new kfunc is added with __implicit arg
> > - kernel is built with old pahole
> > - vmlinux.h is generated for such kernel
> > - bpf program is compiled against such vmlinux.h
> > - attempt to run such program on a new kernel compiled with new pahole
> >   will fail.
>=20
> I think you meant "new kernel compiled with old pahole".

No, new kernel compiled with new pahole.
As it will have a different prototype for 'foo' compared to one
encoded in the old program binary 'btf'.

>=20
> >=20
> > Andrei and Alexei deemed this acceptable.
