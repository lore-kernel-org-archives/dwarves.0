Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A340E2F60DB
	for <dwarves@vger.kernel.org>; Thu, 30 Oct 2025 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761848067; cv=none; b=bVWx0lvVPOR1kawmTIqnFhe0bxi12y1u7n577G401Rav/cl8KJVgjyhRE85RZXL2yWpsFIckL+sK/Ev+FFN5MUb8Ky8t0hZsl8oyJTENd43ZNK8kXUTAfPcDDXZCv+m0ms98rBU3Hxd7W4NdQoxQ/l/sSfCrOutxLQsMWcZZKEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761848067; c=relaxed/simple;
	bh=Vtup7Vk14+3WzvkzparKCp/zUYoI072L/pGdrLo3/pU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HqlvQryalpzfYD+BMPMwMjkFyUSalu58b/M0L7Kr/gEJ7Mvxq1n5tEl+3fNymfwJddOLcHkEdITzbXSFch/zCDb7S4RwWY24J1GsBLPEi9JSiaZOgwljHTkm7g4MRtae7hjgfEE1iu94a9N+ZQINs/mvBcaD43zTRDqRoz/eYIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2Ev4uXC; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2Ev4uXC"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33b9dc8d517so1424004a91.0
        for <dwarves@vger.kernel.org>; Thu, 30 Oct 2025 11:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761848065; x=1762452865; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kcpEkofwlWURd9gB9IDTOn9GwBh/yocoE4wQi5/K1VQ=;
        b=Z2Ev4uXCxelKw61xA5y2y29Ffwy8+8NfyDPq4JF1tVvmAN5j2TIc3YHhCzzLeT/BVs
         6hCOwDKpl0cGtOuFudPv115znA92bwOiqKFm2wUBR8bcNYncwNVZ1Rgcum6C1NsLIn1x
         8XUCfruXBZbIxn6eMB0O6uAS0Y3HZKoai6Hi1jh0R8thOuy4cNOQhzkMEXofHXWhvzzT
         9p3G6/EG300ulSpGKuFCOlGGzW8nXTYOGvhNwjw0htU+mjDDsHva7sPlFcO3IVqJRwwS
         WzopFm6Z16vCfYRBSWJV3wE3WZ2MnOwH+/dgEOK3k6ihkcFdjs5xpYiOX9ei/jZzQT6R
         XqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761848065; x=1762452865;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kcpEkofwlWURd9gB9IDTOn9GwBh/yocoE4wQi5/K1VQ=;
        b=bz/PvVkyRmGIsBh6ADWHEEEs0edKlJa2UbOY3pjmT3du4XEQOZx9WLBbcilAhkIrQq
         NSTCjEmoA/yedmwiMeh1UALf50u/3NxSinFoqQA/n+JD1m/fsik3S2ElXkzjQWmNYA4u
         dFLvjXQHUtuSh6QOgmSodnHsbJckB84ZEJYnx33EsLhd1qtizs2v7znPk3F/eXi01+v2
         QpeqmETi8lARpskawRr371+16wLboUthkvt1k4d+6FPejKf7U4/uzSpnATifmBmMUFGG
         t5vA8kutQigJQ/cuhn/zYeEkmo/0gYHsR4BGKPv5EiwwkKmOUX9XpHsa+1hkpWLp8NjN
         GLVw==
X-Gm-Message-State: AOJu0YwAUEd5Ny+gIKrCO7jzczeCRyzX0wggqfDo/MmkkjOLbABLDjnv
	WnaEEyCmLaR/ikpiXE60nIcREUkIvVuOcKVieaD/yGYQT4FPhCdLR9j8
X-Gm-Gg: ASbGncuZYW6hEpIeBw0CiECBIwUiQhndpk7I5rdWmnCatyNKBnXpRSB+E2BPiioFCGH
	RCTh2ZVRQ4hhHb4QKiybI0phPuSYdqunZn/xVah9EFJOvilyAVUGkqak6loA11eWnmjjpTf4F76
	FUfUF6ePW65tEb50/RbRewuRI7evnd6aZ945Poy7AKXn0D31dnNywMh/1Uedb+rm+xnTu/2awy7
	dudDIjtonkp1laPq9BDgD9eh1ZP+N5s0x/eLODS4YY4Ee2PJcTE6ydYvxJQTFZYJPFHjWuEoWy9
	KGTtePQ1Z9Sir91OrK4OgRkb29Z+ZgEPGzNCncfg05dTJyp1EjW+45tamXadbiDsE/x/EHkBKrz
	dNgF+0QE9JHbQ0IphrV4ecQkkA3mrY/lhfAYM466/IhLZAe3+43GL59kwY+a4es1JHO9AnZHB6Z
	C0JIH81s+E
X-Google-Smtp-Source: AGHT+IE14aet7qzT0MVooGUS0zry3BxwljbWZ3dPTpldPTUIieCUHsztTs1rJTFWIdJGB0m/xmNXiA==
X-Received: by 2002:a17:90b:3c06:b0:330:7ff5:2c58 with SMTP id 98e67ed59e1d1-34082fc413dmr1080122a91.7.1761848064840;
        Thu, 30 Oct 2025 11:14:24 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b92f01355f1sm60016a12.9.2025.10.30.11.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 11:14:24 -0700 (PDT)
Message-ID: <6e0b67d02cf7243b01a163589b3b58d1e4a0fdd8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/8] bpf: magic kernel functions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
	andrii@kernel.org, ast@kernel.org
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org, 
	tj@kernel.org, kernel-team@meta.com
Date: Thu, 30 Oct 2025 11:14:21 -0700
In-Reply-To: <99115d79a7808ca1290726561e36b64ec56e2a1e.camel@gmail.com>
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
		 <50ddff79d33d6e2d57e104f610273d647530ddbc.camel@gmail.com>
	 <99115d79a7808ca1290726561e36b64ec56e2a1e.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-29 at 23:11 -0700, Eduard Zingerman wrote:
> On Wed, 2025-10-29 at 17:44 -0700, Eduard Zingerman wrote:
> > On Wed, 2025-10-29 at 12:01 -0700, Ihor Solodrai wrote:
> >=20
> > Do we break compatibility with old pahole versions after this
> > patch-set? Old paholes won't synthesize the _impl kfuncs, so:
> > - binary compatibility between new-kernel/old-pahole + old-bpf
> > =C2=A0 will be broken, as there would be no _impl kfuncs;
> > - new-kernel/old-pahole + new-bpf won't work either, as kernel will
> > be
> > =C2=A0 unable to find non-_impl function names for existing kfuncs.
> >=20
> > [...]
>=20
> Point being, if we are going to break backwards compatibility the
> following things need an update:
> - Documentation/process/changes.rst
>   minimal pahole version has to be bumped
> - scripts/Makefile.btf
>   All the different flags and options for different pahole
>   versions can be dropped.
>=20
> ---
>=20
> On the other hand, I'm not sure this useful but relatively obscure
> feature grants such a compatibility break. Some time ago Ihor
> advocated for just having two functions in the kernel, so that BTF
> will be generated for both. And I think that someone suggested putting
> the fake function to a discard-able section.
> This way the whole thing can be done in kernel only.
> E.g. it will look like so:
>=20
>   __bpf_kfunc void btf_foo_impl(struct bpf_prog_aux p__implicit)
>   { /* real impl here */ }
>=20
>   __bpf_kfunc_proto void btf_foo(void) {}
>=20
> Assuming that __bpf_kfunc_proto hides all the necessary attributes.
> Not much boilerplate, and a tad easier to understand where second
> prototype comes from, no need to read pahole.

Scheme discussed off-list for new functions with __implicit args:
- kernel source code:

    __bpf_kfunc void foo(struct bpf_prog_aux p__implicit)
	BTF_ID_FLAGS(foo, KF_IMPLICIT_ARGS)

- pahole:
  - renames foo to foo_impl
  - adds bpf-side definition for 'foo' w/o implicit args
  vmlinux btf:

    __bpf_kfunc void foo_impl(struct bpf_prog_aux p__implicit);
    void foo(void);

- resolve_btfids puts the 'foo' (the one w/o implicit args) id to all
  id lists (no changes needed for this, follows from pahole changes);
- verifier.c:add_kfunc_call()
  - Sees the id of 'foo' and kfunc flags with KF_IMPLICIT_ARGS
  - Replaces the id with id of 'foo_impl'.

This will break the following scenario:
- new kfunc is added with __implicit arg
- kernel is built with old pahole
- vmlinux.h is generated for such kernel
- bpf program is compiled against such vmlinux.h
- attempt to run such program on a new kernel compiled with new pahole
  will fail.

Andrei and Alexei deemed this acceptable.
