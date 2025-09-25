Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A8C31A57C
	for <dwarves@vger.kernel.org>; Thu, 25 Sep 2025 19:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758828912; cv=none; b=FT0JdHwmyVg7KXsNtlVOaUGo+MbT5648tiU8Nrp/m40Ao/tgXBe3Cvg03FLtCSHB2tL4i24Q2J4xrNruT34ds/TN/PCLXtITWef9o/ZI7pBRzwXbNBZ5SzKmCQ1EIxloPsUhlaJN1BipoRhS0G96uzj/qVtDPZJDdD6Le3p3kD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758828912; c=relaxed/simple;
	bh=QnRG682A4kA/LPWdSxvyk13q+U5Oj2UjRF3fKjiZm8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwEpUCr01JP/qPyJTAMEUERfuZreljygmpUoFHhZzFdh1kcgWcTeZWkrl13C8oExonUiV8YNjDRtdRmGqVD1UGFPFSk2Uhehz6CeOL9bJfnzeyJ4S6RDXVSKVMuGC+q07hjCOp33oqDesYwZQMArMwGKAkSFPxkjib32Kht1Ljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ku4TOjn9; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ku4TOjn9"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-634a4829c81so1910126a12.1
        for <dwarves@vger.kernel.org>; Thu, 25 Sep 2025 12:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758828909; x=1759433709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnRG682A4kA/LPWdSxvyk13q+U5Oj2UjRF3fKjiZm8k=;
        b=ku4TOjn9rU8lldngxboZTX1h1hpYiVGZ8KCU5cKwn7TshmRSklzi7I/+pO2RCBnRhi
         K31JI8y+go/MwuBzdw5V7GyD2ie+cZH/XnaLvJdDAQ1DSZgwMZ7bUSZoNw/Drq0KihLs
         vu/Kc6PQoY+hfKlN++G1+4OWLBKkUlo5Eiq6G2b9U7G9OjzSpIWF1QmbX1rzB0IGCdBF
         h+FOHQg/2qNfkwj3r8qcezvjStBP0bbgJ4NU3q2NNE6Yp3DT9yhB07vI4s2MmnmCZ/zG
         8c6ZFtdub6Olib7VFPkEB4XHszawhos1BxQWgCJV45JT18424mGxFl1IqytPtesg3k1I
         FrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758828909; x=1759433709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QnRG682A4kA/LPWdSxvyk13q+U5Oj2UjRF3fKjiZm8k=;
        b=OhI7nKkvS5NOC2PSUXXb15HH57d3oow1fIMkbmA1LJyyGYsLdCXNxuqxLzBSbi+P8z
         /qUh7YO9j15u+5X9jEkOlCMaVKylUnB8xMEi9eLiNRNEl+d0qnX5EP1HWsVkjavyAcHB
         +dnRhe2l9O6p+kiy/aJMRV1SbW17TTOpXg/bGcbRjirT2lM+PZf0R3R1O+6u6PAbTWwb
         Dzhy4+GSJnIxi/OZidCnVKThPwvIg79OTkX+i5eRUM1ISxJXe114mL/4PgXR0qzNt2yh
         KIgJgxQfjGJ2mUcmK+yM5rWVSJSudPdZEDDxCWN6BBDXQls5bSDJjp6jScmAbCwzbddL
         AODQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh567VVQH/gWz++Hg5J/UyBdVPM0qjUDCkuTHtbQXYAib/Yp1xCy2cweTW9cGooFayHmOWyYv6@vger.kernel.org
X-Gm-Message-State: AOJu0Yylf6LqEdQX8sWNggtwugPq+lIKyYNbx5m1trdBb1OYcyGPTzpl
	HCeZJ+wpqo+yL2M2QdwkVxdMIG+K8P+mb99K5V1xj+jBIF/55Us5wJUcoB7hxsuCdGCfEGM4nUH
	dbMKFumCsH4K9Knn9kXEJKRkZ/g9jXQM=
X-Gm-Gg: ASbGncunnfq+YdTzkoecQDmhafjV3Rnf6QH6Fl/HwIHdCKMJz7FmZxm2AXuiEGbKaRb
	rf47pJy42eSFUq8YG36Tt4ztPXzPaXd9tA+QpEbvLhTaAQDoOkxwNqdPpveCPrgjdLwbI1rQ2Fx
	KrgiqVtZ9VKgtmfXoUbT2TOAkFU2wmCPxE68Gn0mpIrYxcbDt75Rc53OwNzeCd1/93vx8C4tTcu
	friiA==
X-Google-Smtp-Source: AGHT+IFc0CIZpFjAF3DTy6qb/xhOnpmAzDyWjQAVM+jv0r/V/nSSMRPe9emJtXzeTyPjJUA/xSwFUapr5KWsDi28/cI=
X-Received: by 2002:a17:907:6093:b0:b28:f64f:2fd3 with SMTP id
 a640c23a62f3a-b34ba639a5bmr452557766b.35.1758828907994; Thu, 25 Sep 2025
 12:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924211716.1287715-1-ihor.solodrai@linux.dev>
 <20250924211716.1287715-2-ihor.solodrai@linux.dev> <CAADnVQLvuubey0A0Fk=bzN-=JG2UUQHRqBijZpuvqMQ+xy4W4g@mail.gmail.com>
 <6a6403ec-166a-4d48-8bf5-f43ae1759e5f@linux.dev> <CAEf4BzbYXADoUge5C7zhzZAEDESE7YJFwW_jO4-F5L3j-bwPMw@mail.gmail.com>
In-Reply-To: <CAEf4BzbYXADoUge5C7zhzZAEDESE7YJFwW_jO4-F5L3j-bwPMw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 25 Sep 2025 20:34:56 +0100
X-Gm-Features: AS18NWDZKKqxw3yu_dCVfo31fiofhrysGJgq2X0xvlERiaqjb9uGQOJHFbaHPR0
Message-ID: <CAADnVQL+28vPquMgw+hZMT1P6NkE5jLUXf=HDNj65N9np1rgfw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/6] bpf: implement KF_IMPLICIT_PROG_AUX_ARG flag
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	dwarves <dwarves@vger.kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Tejun Heo <tj@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 6:23=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> I do see the benefit of having the generic "KF_MAGIC_ARG(s)" flag on
> the kernel side of things and having access to full BTF information
> for parameters to let verifier know what specific kind of magic
> argument that kfunc has, though. So as an alternative, maybe we can
> create both a kfunc definition *meant for BPF programs* (i.e., without
> magic argument(s)), and then have a full original definition (produced
> by pahole, it will need to understand KF_MAGIC_ARGS anyways) with full
> type information *for internal BPF verifier needs*. I don't know
> what's the best way to do that, maybe just a special ".magic" suffix,
> just to let the verifier easily find that? On the kernel side, if
> kfunc has BPF_MAGIC_ARGS kflag we just look up "my_fancy_kfunc.magic"
> FUNC definition?

Interesting idea. Maybe to simplify backward compat the pahole can
emit two BTFs: kfunc_foo(args), kfunc_foo_impl(args, void *aux)
into vmlinux BTF.
bpftool will emit both in vmlinux.h and bpf side doesn't need to change.
libbpf doesn't need to change either.
The verifier would need a special check to resolve two kfunc BTFs
name into one kallsym name, since both kfuncs is one actual function
on the kernel.
bpf_wq_set_callback_impl() definition doesn't change. Only:
-BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
+BTF_ID_FLAGS(func, bpf_wq_set_callback_impl, KF_PROG_ARG)

and the verifier can check that the last arg is aux__prog when
KF_PROG_ARG is specified.

The runtime performance will be slightly better too, since
no need for wrappers like:

+__bpf_kfunc int bpf_wq_set_callback_impl(struct bpf_wq *wq,
+ int (callback_fn)(void *map, int *key, void *value),
+ unsigned int flags,
+ void *aux__prog)
+{
+ return bpf_wq_set_callback(wq, callback_fn, flags, aux__prog);
+}

It's just one jmpl insn, but still.
