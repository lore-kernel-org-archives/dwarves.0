Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EED1334368
	for <dwarves@vger.kernel.org>; Thu, 30 Oct 2025 20:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761856760; cv=none; b=TpArHU+yR+BIqSxusb9hfddfU2ykzXSezx0OVSEyrfOkWyGLNS6owDWrqH3Tj1pNc0f4q+se/XZ+JcGPy6t2D+cben726fvRxlHTluBZXrWjCv9v7cIZtQ1d9z5XEtlYO63KPebsU8gxeod0pH86Q7kUkWcEIQtf50IB82bLtTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761856760; c=relaxed/simple;
	bh=427Rca5prW0gyO9JhZt6v83K/5kytr1sVweef4u7XLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IKUQu7mugn3HWiN3OOzZY7eyHLrric1Q4oedkWe+LrUtwGoK61WEU5aZqE+PLaXqp8rUsMGUeACqtXnrtlxRfZKdYPxeFuo6gw1r0rnRxjetExiAGPCIz33YxQxW+XUUP7QS3s4ux9W8YpePX5o0u1BLw8knqWNbCrT7XD7updc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lokCSupd; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lokCSupd"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34088fbd65aso194111a91.0
        for <dwarves@vger.kernel.org>; Thu, 30 Oct 2025 13:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761856758; x=1762461558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54uQxC9vNGy1WiRTzW7VsRoDrK4tbblHhACpzBe+y70=;
        b=lokCSupdzyRCNBNUoJ4aJJMDYsfm2AVHCbwlgVb2l7ud3QneNC9mUa1fOOTa+VslJ3
         j72633Gvva9a5D4uuntRJlqO1xuY6wBnpCSrpJ7YaRmkKKtXneR/KTw8JphF76NSinxj
         aCen6cjw0WBOap0KdPZnLd6dUfl2jfdG53quBzvqtINgtYB9ZN1Z3wdhJYUjRDrgI5D0
         OtpkMEvIL4vOZjC39v1SkyzsS7WCBMwG79fgXhn2Af4vE5Kp9rflVt9qK12nDBKKi3Tz
         gS0Hexr1eZMPOCe32AX7SWcq8FismiYLaD0EwHEHBLE8raMZwptWwPVuc2u4Iw0lF7Iv
         G/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761856758; x=1762461558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54uQxC9vNGy1WiRTzW7VsRoDrK4tbblHhACpzBe+y70=;
        b=OnYy22NgJ/lek+kqlKY+ORxY4D5JFahEcH+LKIbe/ry/YdGQDnHswqBGGf4vXIuhxy
         08YliP+6sf9SWEBKvI66jzXFhqKrER9gVAhPfAXXsNmm2MSgAalyk3l97/wVqq6mqgRL
         y+lIGHPrBOFyr3ivWsXE4yk/HvkUgkGxcWOGtr/K7JAkIBZcOFzeCqgPvdDYOilyNm07
         s1bA1AcBcEJfJgn5jN8st0+s0SdaIx0WlBI0+/dNTr/DNtN2KkcWq+eJ13xgMXDu/Sks
         Kn9SpD7qnmfViGZv/380oLSXmGTf8f5LFgwyv+p839R5FwOHS0Y3w6psoP4gCS3n4i9z
         JsZA==
X-Forwarded-Encrypted: i=1; AJvYcCWamUvDONNyjtV5Hf/NhGYDSdw4C9JNlui0URnRToCDBVhqRjwS6CfSsNOVbDrjS13Nw9ajQXNK@vger.kernel.org
X-Gm-Message-State: AOJu0YxgtfV8ZHm8tNELvMl+089+jqzMexf/KGeFPnkngKLT5ChvMvDO
	PoLSkJF1qpSRthlk2EaAt//uoWGPoU/UvHhX99dnwsCulmzfEnoIbKt6wMtlT0sBkC69brQ8EUy
	qVL2tPk/mYiLgcclTu/Jm5hzByaQSpuM=
X-Gm-Gg: ASbGncswcKDU9trAeZFvlsEQCQgalA1v5z9i8Z+XN1jhv/D6atc9ygiWFRpOIY4irzB
	85ZFA+YTt9r0qgmDhxT6OyntuDzrFxh5EAP9489uBsgeihrZvci8m62pPQLZ7+sTafx0OUhLpOB
	ZNwZ5lBxHc4ed+vZfw/bUGxUJ5LTvtPjnF0PuuhF3iYGyEmaMozjrGl+PHog7s45GstgYFXA/1B
	wgDRNt02fAKR+S5ux+mawmlYrjdaNjKpQki24DuqkcPPgTYTxeMwA3jNX0himv6JT/dJu3Bb52/
	PuFeS6nI+0Q=
X-Google-Smtp-Source: AGHT+IHUpFVzkNgGh2rza5GnzINbGOJZMhcYojFaQZEHFBey2w1r0wNE25M0SGd43C/RDmPU7w90kFs6gXLJBoYQhTM=
X-Received: by 2002:a17:90b:3504:b0:340:776d:f4ca with SMTP id
 98e67ed59e1d1-3408308a99dmr1420420a91.26.1761856758226; Thu, 30 Oct 2025
 13:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
 <50ddff79d33d6e2d57e104f610273d647530ddbc.camel@gmail.com>
 <99115d79a7808ca1290726561e36b64ec56e2a1e.camel@gmail.com>
 <6e0b67d02cf7243b01a163589b3b58d1e4a0fdd8.camel@gmail.com>
 <145364f5-3752-41b7-92d9-c97437b95b9a@oracle.com> <710129ad-ebe6-4a92-a21f-3aa1f762fe74@linux.dev>
 <CAEf4Bza1cXRvw+v1CXmpWBF9ivnk+8-JWOUqRQJ2EE95j3i1Pw@mail.gmail.com> <e17948a1-542a-45b5-8fbc-8f469025b223@linux.dev>
In-Reply-To: <e17948a1-542a-45b5-8fbc-8f469025b223@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Oct 2025 13:38:59 -0700
X-Gm-Features: AWmQ_blhYjLOhUC5j677fzo8QOrq-H-IU6yyvWeCA56Dx-B7O6ztE4L21dkdUIs
Message-ID: <CAEf4BzbnroefwJUGAZstLZ5g7ZSyCDjLRRWaOM=bp0m8BR7sHg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/8] bpf: magic kernel functions
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>, Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	andrii@kernel.org, ast@kernel.org, dwarves@vger.kernel.org, acme@kernel.org, 
	tj@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 1:02=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 10/30/25 12:47 PM, Andrii Nakryiko wrote:
> > On Thu, Oct 30, 2025 at 11:46=E2=80=AFAM Ihor Solodrai <ihor.solodrai@l=
inux.dev> wrote:
> >>
> >> On 10/30/25 11:26 AM, Alan Maguire wrote:
> >>> On 30/10/2025 18:14, Eduard Zingerman wrote:
> >>>> On Wed, 2025-10-29 at 23:11 -0700, Eduard Zingerman wrote:
> >>>>> On Wed, 2025-10-29 at 17:44 -0700, Eduard Zingerman wrote:
> >>>>>> On Wed, 2025-10-29 at 12:01 -0700, Ihor Solodrai wrote:
> >>>>>>
> >>>>>> [...]
> >>>>
> >>>> Scheme discussed off-list for new functions with __implicit args:
> >>>> - kernel source code:
> >>>>
> >>>>     __bpf_kfunc void foo(struct bpf_prog_aux p__implicit)
> >>>>      BTF_ID_FLAGS(foo, KF_IMPLICIT_ARGS)
> >>>>
> >>>> - pahole:
> >>>>   - renames foo to foo_impl
> >>>>   - adds bpf-side definition for 'foo' w/o implicit args
> >>>>   vmlinux btf:
> >>>>
> >>>>     __bpf_kfunc void foo_impl(struct bpf_prog_aux p__implicit);
> >>>>     void foo(void);
> >>>>
> >>>> - resolve_btfids puts the 'foo' (the one w/o implicit args) id to al=
l
> >>>>   id lists (no changes needed for this, follows from pahole changes)=
;
> >>>> - verifier.c:add_kfunc_call()
> >>>>   - Sees the id of 'foo' and kfunc flags with KF_IMPLICIT_ARGS
> >>>>   - Replaces the id with id of 'foo_impl'.
> >>>>
> >>>> This will break the following scenario:
> >>>> - new kfunc is added with __implicit arg
> >>>> - kernel is built with old pahole
> >>>> - vmlinux.h is generated for such kernel
> >>>> - bpf program is compiled against such vmlinux.h
> >>>> - attempt to run such program on a new kernel compiled with new paho=
le
> >>>>   will fail.
> >>>>
> >>>> Andrei and Alexei deemed this acceptable.
> >>>
> >>> Okay so bear with me as this is probably a massive over-simplificatio=
n.
> >>> It seems like what we want here is a way to establish a relationship
> >>> between the BTF associated with the _impl function and the kfunc-visi=
ble
> >>> form (without the implicit arguments), right? Once we have that
> >>> relationship, it's sort of implicit which are the implicit arguments;
> >>> they're the ones the _impl variant has and the non-impl variant doesn=
't
> >>> have. So to me - and again I'm probably missing a lot - the key thing=
 is
> >>> to establish that relationship between kfunc and kfunc_impl. Couldn't=
 we
> >>> leverage the kernel build machinery around resolve_btf_ids to constru=
ct
> >>> these pairwise mappings of BTF ids? That way we keep pahole out of th=
e
> >>> loop (aside from generating BTF for both variants as usual) and
> >>> compatibility issues aren't there as much because resolve_btfids trav=
els
> >>> with the kernel, no changes needed for pahole.
> >>
> >> We've had a couple of rounds of back and forth on this.
> >>
> >> The reasoning here is that going forward we want to make a kfunc with
> >> implicit arguments easy to define. That is:
> >>
> >>     __bpf_kfunc int bpf_kfunc(int arg, struct bpf_prog_aux *aux__impl)=
 {}
> >
> > I don't think we even need __impl suffix for argument name with
> > KF_IMPLICIT_ARGS, right?
>
> I mentioned options that we discussed before in the cover letter.
>
> Basically, pahole needs to figure out how many arguments to omit *somehow=
*.
> Using a name suffix (aka annotation) seems to be the most flexible way, a=
s
> it allows to avoid changes in pahole if/when we add new implicit arg type=
s.


Ah, right, I forgot we discussed this. Ok, arg suffix isn't too bad.

>
> >
> >>     BTF_ID_FLAGS(func, bpf_kfunc, KF_IMPLICIT_ARGS)
> >>
> >> That's it.
> >>
> >> In order to keep pahole out of the loop, it's necessary to have both
> >> interface and implementation declarations in the kernel. Something
> >> like this:
> >>
> >>     __bpf_kfunc_interface int bpf_kfunc(int arg) {}
> >>     __bpf_kfunc int bpf_kfunc_impl(int arg, struct bpf_prog_aux *aux__=
impl) {}
> >>     BTF_ID_FLAGS(func, bpf_kfunc, KF_IMPLICIT_ARGS)
> >>
> >> Which shifts most of the burden of resolving KF_IMPLICIT_ARGS to the
> >> verifier. But then of course both variants will be callable from BPF,
> >> which is another thing we'd like to avoid.
> >>
> >> pahole provides an ability to modify BTF only, and make that
> >> bpf_kfunc_impl (almost) invisible to the user, which is great.
> >>
> >> The downside is that maintaining backwards compatibility between
> >> kernel, pahole and BPF binaries is difficult.
> >>
> >
> > I think we should differentiate backwards compat for all existing
> > _impl kfuncs and BPF programs that used to work with them, and then,
> > separately, what happens going forward with newly added non-_impl
> > kfuncs with KF_IMPLICIT_ARGS and BPF programs that want to make use of
> > these _impl-less kfuncs.
> >
> > For existing _impl kfuncs ("legacy" case), backwards compat is 100%
> > preserved, even if the kernel was built with an old pahole that
> > doesn't yet know about KF_IMPLICTI_ARGS. There will be BTF for both
> > _impl and _impl-less func_protos, all that will work. And BPF programs
> > are explicitly calling _impl kfuncs. So even if pahole didn't do
> > anything special for KF_IMPLICIT_ARGS, verifier should work fine, it
> > will find _impl BTF, etc.
> >
> > For all new _impl-less kfunc definitions and/or BPF programs that
> > switch to _impl-less calls, yes, we will document and require that
> > kernel BTF has to be generated with a newer pahole. We can enforce
> > that in Kconfig, but it's a bit too strict/too soon as it's irrelevant
> > and unnecessary for the majority of BPF users that don't care about
> > _impl-less stuff.
>
> I think some kind of build-time enforcement will be necessary.
> It's *very* easy to unintentionally use old(-er) pahole version
> for kernel build, especially when the new version is recent.
>

I'd try to avoid failing kernel build if pahole is not recent enough
for this feature.

How about we teach resolve_btfids() to check whether kernel BTF is
"conformant" (i.e., it has xxx and xxx_impl func_protos, and xxx
doesn't have implicit args, while _impl has implicit args), and if
it's not conformant, we just effectively make such _impl-less kfunc
not a kfunc. Would resolving such BTF_ID to zero do the trick?

> >
> > Keep in mind, right now we have 4-5 such _impl special functions, but
> > going forward we will probably have lots. sched-ext is poised to use
> > that very extensively throughout a lot of its kfuncs, so requiring
> > these explicit _impl wrappers just to support older pahole with newer
> > kernels I think doesn't make sense in the grand scheme of things.
> > Getting the latest pahole released/packaged/used for kernel build for
> > distros shouldn't be a big deal at all. It's not really like upgrading
> > the compiler toolchain at all.
> >
> >>
> >>>
> >>> I'm guessing the above is missing something though?
> >>>
> >>> Thanks!
> >>>
> >>> Alan
> >>
>
