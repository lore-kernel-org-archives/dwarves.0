Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EEE17C211
	for <dwarves@vger.kernel.org>; Fri,  9 Jan 2026 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767922828; cv=none; b=oTF8RFvyHVB6ToGfo4+E11bC/zlI4JjjGe7Yev6LgPW64BFmj7vENdU+oYwU3YBxIDMLEYs48s9C3oYMQCFawpwwOTL+/l2wz9fioF24UBYqukLVikKHaDvkMhyG+zBNw57mW17XawiLbcf2A20BQ5EAup4lrZ8sCQuJ7KelCFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767922828; c=relaxed/simple;
	bh=81J4LA5bo7pOuTCo9B3kawOjqPfdoS2Hn+58/gmh544=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/WVtd2dmyDsJhkkQv0xqJjssMDAs82oJlq6BzviCEIlN6YXrUkNa5BizbaSIfFPZi9KDfe/5+I+6jLrVYJw8jO59f5TeTSVRCDv82hnvE7KS+8Z0O4939ppmSkJKMFj6NWbAZ4fi7Jru7M0VglvP7rRXFPCres7yDD6Ou38VpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LP5Fgsyn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LP5Fgsyn"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so26256055e9.2
        for <dwarves@vger.kernel.org>; Thu, 08 Jan 2026 17:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767922825; x=1768527625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2sV8f7odv0MgM7mujEiPRpCm2IQeH7buA1wwEi8ms0=;
        b=LP5FgsynToOz35guVVErO8tgi9ES/F+xDXyID0cOKrYEqmS+JWakrlXtRkm0Lcd0Mk
         1/3wDSwpqVCGxDtxxeb1CpC6I7fprYOSkOEb1GK0rhs7Wu6UCl/zQMlX8DgnCpYfZ7Co
         fZauDNGd0v1f1nEyd8ZOMAtQbw51+rX1VeQNXF4Lk56GZS3r9+XP5x0tl2p0mztopFXL
         zjirQJl5HgxX4Xzk3acskUOG0qELBZF2QS4/2hv99vpGtwUSCRybxZ49kNKNSBc2Zkyx
         Ss89OWkm4EEOM/KHMMUxX7n45jvBM1Pv8PbXp91irsx4VvimhXkZ1Ad7/5fZmPjjSOTE
         Takg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767922825; x=1768527625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G2sV8f7odv0MgM7mujEiPRpCm2IQeH7buA1wwEi8ms0=;
        b=EiOUfvlqzfKwdWwHP5e4v8nujrV0Z/IvH3inMD8OdG7ev4Wb/732EaR7sUlBbMd5Nw
         JXcnhlLm8ZV6NH5GDwQUsCUjVox4kFN81wBu2diq1cvk4K3DuEC3hO6lMIar1WQXmbzI
         CLObthxKQhs4LuFXHNNMfL2m8rSjCXHfy9ktlzwdHkzS/RizlnWkRjwxcoNlg4R+1ksZ
         7uTj7ygmfPV2sYjnyuEPlS1hsJLMtZ4vg1aoQTgN7xwoX7qA6x93l2UZYoS2pW00Gpof
         fRyXQazj/AUcqi/GHE38lpBcIkGeA1mHu03fzebvAGZTk7JPycsC3SWAOdNREhlozmQz
         7Yjw==
X-Forwarded-Encrypted: i=1; AJvYcCX8gF6RFLl1mkm61E7t5B3GcBY5u4fk7sCFPjFYa/vl7yIn+hWfzATZ+pHJ7GpGNQS9EPktJvdI@vger.kernel.org
X-Gm-Message-State: AOJu0YzOMkNqA9iTrC0zYf40sW49Qgzpsb9HKjBbfO0jOMtjeZNAQvN3
	pa1pfZkkyxqpPvu6dTb/UkjvvVcnuF6m3q1/XDyUZJ9hyqF8W5EzgD8Wpb4IBsAeZtBlJCYvCMo
	OfOcPhnrpzTObVjtAibcWExXVqwrNnyY=
X-Gm-Gg: AY/fxX7BLmQHfomijQnrsvH/D2kPVdY2C/KdmJ2jCB5FtRj3lDWCUJJfqMgQl1KuVfS
	ianD19wzBrghuNp2Qwp21i80dBPgiPqS1I0YNOh0Um1oiNS9rxioHHvirvWaR0HqaS/CHJTmkLE
	TpMad8RadFdn2CZ1W8evjGhAePhaYgK7m6c7u1J5UO7Mbchq4Yd+sLlqeYHUiO5x5Xsx95hFAwg
	yge2oVP3nLlzE+GTNRYNVz5ehgSHV41HgfDucrJCNwAqsRAsKhAZ1aYvqGKzhs9Yo5y9b6pFZf4
	zcPAo1cFVcaBrcNYP4WeSPQLkSUI
X-Google-Smtp-Source: AGHT+IFjUrqIKdkXZ177kIq9JduigwsE8A5l/PhaAxkvCTAydOPbEx0Ewc+kGiRQ17Tw9rGiRlKAV3WBMN88hPzuvQ8=
X-Received: by 2002:a05:600c:1911:b0:477:b734:8c22 with SMTP id
 5b1f17b1804b1-47d84b1a36dmr96438195e9.8.1767922824664; Thu, 08 Jan 2026
 17:40:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-2-alan.maguire@oracle.com> <CAEf4Bzaw6KRU2yDbawOe+eusCjCwvg0FwhkpvGA3HE=gC=ZLbQ@mail.gmail.com>
 <42914a9b-0f34-4cee-bc36-4847373fa0b5@oracle.com> <CAEf4BzZuikZK5cZQyV=ge6UBKHxc+dwTLjcHZB_1Smw1AwntNA@mail.gmail.com>
 <e2df60e1-db17-4b75-8e0e-56fcfdb53686@oracle.com> <CAEf4BzarPLAcwKApft_nBVM_d3WW58zytZfLQVz387TF2c2FVg@mail.gmail.com>
 <CAADnVQ+achE6ebfCxyfHyxMMFJ-Oq=hUK=JkWUAGwz+7HeV4Qw@mail.gmail.com>
 <22c54404-512c-4229-8c93-8ec1321619e0@oracle.com> <CAADnVQ+VU_nRgPS0H6j6=macgT49+eW7KCf7zPEn9V5K0HN5-A@mail.gmail.com>
 <19a4596d-06dc-42ae-b149-cc2b52fffae9@oracle.com> <CAEf4BzbCxGaFu5E_oYdMxzkqhtVxSnwHawcUv5jM5Sodut5cdA@mail.gmail.com>
 <CAADnVQKYTMPyWLNn-5HHnA23Ay3qNdGUJ9TNVcy62zPEf013Xg@mail.gmail.com>
 <CAEf4Bzb5askzzBL4BnR1tcjio+jW3zdVs_pPPgSq7vd+N5zuXA@mail.gmail.com>
 <64de60b6-4912-4ec8-9c85-342b314c3c5c@oracle.com> <CAEf4BzZYS5QN0B-B7HfPrmiag26-XYqiGNEv+n0gAMhg5uYjrA@mail.gmail.com>
In-Reply-To: <CAEf4BzZYS5QN0B-B7HfPrmiag26-XYqiGNEv+n0gAMhg5uYjrA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 8 Jan 2026 17:40:12 -0800
X-Gm-Features: AZwV_Qi5h1uh5O0gLnBmmZhTh6XAYqtLzhnc3X3kX2Jh9TG5XrysF9QYkHbaOQ8
Message-ID: <CAADnVQLFCPDoRQt4nWxsHVt3AG=HnyE=PepaniWv1yeigozaoA@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 01/10] btf: add kind layout encoding to UAPI
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves <dwarves@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Thierry Treyer <ttreyer@meta.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 5:24=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jan 8, 2026 at 10:55=E2=80=AFAM Alan Maguire <alan.maguire@oracle=
.com> wrote:
> >
> > On 06/01/2026 01:19, Andrii Nakryiko wrote:
> > > On Mon, Jan 5, 2026 at 4:51=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > >>
> > >> On Mon, Jan 5, 2026 at 4:11=E2=80=AFPM Andrii Nakryiko
> > >> <andrii.nakryiko@gmail.com> wrote:
> > >>>
> > >>> On Tue, Dec 23, 2025 at 3:09=E2=80=AFAM Alan Maguire <alan.maguire@=
oracle.com> wrote:
> > >>>>
> > >>>> On 22/12/2025 19:03, Alexei Starovoitov wrote:
> > >>>>> On Sun, Dec 21, 2025 at 10:58=E2=80=AFPM Alan Maguire <alan.magui=
re@oracle.com> wrote:
> > >>>>>>
> > >>>>>>>
> > >>>>>>> Hold on. I'm missing how libbpf will sanitize things for older =
kernels?
> > >>>>>>
> > >>>>>> The sanitization we can get from layout info is for handling a k=
ernel built with
> > >>>>>> newer kernel/module BTF. The userspace tooling (libbpf and other=
s) does not fully
> > >>>>>> understand it due to the presence of new kinds. In such a case l=
ayout data gives us
> > >>>>>> info to parse it by providing info on kind layout, and libbpf ca=
n sanitize it
> > >>>>>> to be usable for some cases (where the type graph is not fatally=
 compromised
> > >>>>>> by the lack of a kind). This will always be somewhat limited, bu=
t it
> > >>>>>> does provide more usability than we have today.
> > >>>>>
> > >>>>> I'm even more confused now. libbpf will sanitize BTF for the sake=
 of
> > >>>>> user space? That's not something it ever did. libbpf sanitizes BT=
F
> > >>>>> only to
> > >>>>
> > >>>> Right; it's an extension of the sanitization concept from what it =
does today.
> > >>>> Today we sanitize newer _program_ BTF to ensure it is acceptable t=
o a kernel which
> > >>>> lacks specific aspects of that BTF; the goal here is to support so=
me simple sanitization
> > >>>> of the newer _kernel_ BTF by libbpf to help tools (that know about=
 kind layout but may lack
> > >>>> latest kind info kernel has) to make that kernel BTF usable.
> > >>>
> > >>> Wait, is that really a goal? I get why Alexei is confused now :)
> > >>>
> > >>> I think we should stick to libbpf sanitizing only BPF program's BTF=
s
> > >>> for the sake of loading it into the kernel. If some user space tool=
 is
> > >>> trying to work with kernel BTF that has BTF features that tool does=
n't
> > >>> support, then we only have two reasonable options: a) tool just fai=
ls
> > >>> to process that BTF altogether or b) the tool is smart enough to
> > >>> utilize BTF layout information to know which BTF types it can safel=
y
> > >>> skip (that's where those flags I argue for would be useful). In bot=
h
> > >>> cases libbpf's btf__parse() will succeed because libbpf can utilize
> > >>> layout info to construct a lookup table for btf__type_by_id(). And
> > >>> libbpf doesn't need to do anything beyond that, IMO.
> > >>>
> > >>> We'll teach bpftool to dump as much of BTF as possible (I mean
> > >>> `bpftool btf dump file`), so it's possible to get an idea of what p=
art
> > >>> of BTF is not supported and show those that we know about. We could
> > >>> teach btf_dump to ignore those types that are "safe modifier-like
> > >>> reference kind" (as marked with that flag I proposed earlier), so t=
hat
> > >>> `format c` works as well (though I wouldn't recommend using such
> > >>> output as a proper vmlinux.h, users should update bpftool ASAP for
> > >>> such use cases).
> > >>>
> > >>> As far as the kernel is concerned, BTF layout is not used and shoul=
d
> > >>> not be used or trusted (it can be "spoofed" by the user). It can
> > >>> validate it for sanity, but that's pretty much it. Other than that,=
 if
> > >>> the kernel doesn't *completely* understand every single piece of BT=
F,
> > >>> it should reject it (and that's also why libbpf should sanitize BPF
> > >>> object's BTF, of course).
> > >>
> > >> +1 to all of the above, except ok-to-skip flag, since I feel
> > >> it will cause more bike sheding and arguing whether a particular
> > >> new addition to BTF is skippable or not. Like upcoming location info=
.
> > >
> > > I was thinking about something like TYPE_TAG, where it's in the chain
> > > of types and is unavoidable when processing STRUCT and its field.
> > > Having a flag specifying that it's ref-like (so btf_type::type field
> > > points to a valid type ID) would allow it to still make sense of the
> > > entire struct and its fields, though you might be missing some
> > > (presumably) optional and highly-specialized extra annotation.
> > >
> > > But it's fine not to add it, just some type graphs will be completely
> > > unprocessable using old tools. Perhaps not such a big deal.
> > >
> > > I suspect all the newly added BTF kinds will be of "ok-to-skip" kind,
> > > whether they are more like DECL_TAG (roots pointing to other types) o=
r
> > > TYPE_TAG (in the middle of type chain, being pointed to from STRUCT
> > > fields, PROTO args, etc).
> > >
> > >> Is it skippable? kinda. Or, say, we decide to add vector types to BT=
F.
> > >> Skippable? One might argue that they are while they are mandatory
> > >> for some other use case.
> > >> Looking at it differently, if the kernel is old and cannot understan=
d that
> > >> BTF feature the libbpf has to sanitize it no matter skippable or not=
.
> > >> While from btf__parse() pov it also doesn't matter.
> > >> btf_new()->btf_parse_hdr() will remember kind layout,
> > >> and btf_parse_type_sec() can construct the index for the whole thing
> > >> with layout info,
> > >> while btf_validate_type() has to warn about unknown kind regardless
> > >> of skippable flag. The tool (bpftool or else) needs to yell when
> > >> final vmlinux.h is incomplete. Skipping printing modifier-like decl_=
tag
> > >> is pretty bad for vmlinux.h. It's really not skippable (in my opinio=
n)
> > >> though one might argue that they are.
> > >
> > > Yeah, I agree about vmlinux.h. One way to enforce this would be to
> > > have btf_dump emit something uncompilable as
> > > "HERE_BE_DRAGONS_SKIPPED_SOMETHING"  as if it was const/volatile
> > > modified.
> > >
> > > But yeah, we don't want bikeshedding. It's fine.
> > >
> >
> > Ok so is it best to leave out flags entirely then? If so where we
> > are now is to have each kind layout entry have a string name offset,
> > a singular element size and a vlen-specified object size. To be
> > conservative it might make sense to allow 16 bits for each size field,
> > leaving us with 64 bits per kind, 160 bytes in total for the 20 kinds.
> > We could cut down further by leaving out kind name strings if needed.
>
> Are we sure we will *never* need flags? I'd probably stick to
> single-byte sizes and have 2 bytes reserved for flags or whatever we
> might need in the future?

Just to clarify what I was saying.
I think it's a good thing to have flags space and reserve it.
I just struggle to see the value of 'ok-to-skip' flag.

So 2 bytes of reserved space for flags makes sense to me.
