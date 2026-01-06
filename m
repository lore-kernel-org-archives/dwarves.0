Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64B33A1E6D
	for <dwarves@vger.kernel.org>; Tue,  6 Jan 2026 00:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767658292; cv=none; b=fKuMTJCmUkKdbqOzEhuUnHzKpsNo1Ffo+k8/6Wu081Xs/IbelmoLAmDTiTZ3UKK9LhFLwk24MUP+l7JyeBKkVHvFJ7R0gzudAP60RRczzCMV6Cy2UVCdTIUObod8oeUsF3UiHbmT50wX/ZzVej5rOIJMTCR1N/1eE3ehrjqLCFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767658292; c=relaxed/simple;
	bh=F6+3je+EEmJmWIQ0SfdR3X2JK05w+tFnGByabsfYQOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MiqCjMcdwy+SdRilqXDJS4nZB6LZRweX2XvKOSG83NtmNvQTvuvAj7/bNzko8fUpIJgESBpMVJeCUw3ndU7JCGKSF84ngZMACe0BlrZOFqRfU2m+HoXfNRmM3NAKCwEur2psdPDyVPZUNk0vBg2hZquys7IQIdiljyxATwcIQgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGJRLYWu; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGJRLYWu"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34c9edf63a7so523280a91.1
        for <dwarves@vger.kernel.org>; Mon, 05 Jan 2026 16:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767658290; x=1768263090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6+3je+EEmJmWIQ0SfdR3X2JK05w+tFnGByabsfYQOE=;
        b=RGJRLYWuauOf8FhOLxco6O68Frp5yiMECL+YxeGYnxbyrWfYXczrbTe0NhmB+OqETR
         nY5vrcxu6y8c1H99C2IRF1phVezJvyS9itDQKK6JxJwNtroSDMIJbNsf++Rd5LiYljQ3
         42CnBdnTbGFg3fFO42uDwsUfImvRm3XYC6VTFJjhAuA8oi2Qesvh6JSbjB5Jb92dILLP
         1osmwr4H2YSXfnyUDhBwrUo/57PF/MM1WEEKazdwdDxPVQXZL/eNWUqkqRmctXP55dp8
         sH1/h5vavnw9+RiDD3lYeU8ftL9oIhWVjpiIZmhsQmNxYUy0TB8OqtM2TNDp1ieeAVLc
         yJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767658290; x=1768263090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F6+3je+EEmJmWIQ0SfdR3X2JK05w+tFnGByabsfYQOE=;
        b=K00r4hio6TSgFPFy87Me74VWj/igCqGOQ1pdndAGuMRm6N/ffNuL3OZsEywKE21ZjY
         d7CWKutIVi+8p8FgKXwdQYd0sDh59UuF81BKIYJ6EI+wV+d6I29/GQ30hyT8XMtUR94m
         dvZ1WWSIIYPM0/DTCfivttSihUNco1PJaepP4fHgmAHJq/UlTvELxUV2IF/b4CJXV1KX
         eTp6uuRQ/EbFAwXZQ2AHpF634s+eIWiHiDRvSQ/kLhO+zCJhruWaPXiK3WW//6qjFcMH
         yFTyv+YiHrq5z6WeH1feNiH5UWvBWbMGQyf7KKcAyAOAPg7Vos5rvra0ffsjwGWPPPYA
         MKtA==
X-Forwarded-Encrypted: i=1; AJvYcCWOtfCF/wYg9QAKbjRLP41nvaahQ+uBmVxbDKBsu66379xijylEwhZ8iN6bFYG9vL5Xzx3hAqex@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ9Phy8MrLzea6uvwCS5dL+uetUnCay0Sl56LZuuv76Vvf602M
	+4/vIa283LgXptxBCsJJ+Pks6W9imIyvZ6/7do1K2w9EBMjKnxljduFsOyIRA6U7Y7gp/rzT4tP
	wJCdJbVF6yuuZQXl6gpYgrOsCWUsZ5jk=
X-Gm-Gg: AY/fxX7OKXqrX0w59a2b2x51MfRxmsxCGpuDuCA3nls6rAACktJ3uLbiyLrpCnqJ154
	tkmzhx8SsIDZnox3p9vts25gxoXkIW3Gx0QIFTi516/YIoaBDJdGjRXjm2/zGI/kzCFiQQiXlJp
	N8YI/K27mLQDmjXLsCE6iZea/F+1dk8vCsImN5dWwktO+FMatPDwibRwpgy5fg3U+wYDf5mdrPM
	+fzIGTy2gfAwJGljJSYABHjecvmSI0zF0uCWCD45gBG3HTrMRuZt44obfs1nXe1NLMnP7ZvVJQw
	4zyBCJtg0xMnYydMBXScqg==
X-Google-Smtp-Source: AGHT+IF1W5jEPGTE3aO4fb62l3pc/M9aoHV+BLLJRBDWE9QCDCwnUu3zt/BFxfFOf8AaVmseyHCr4NqXQK3qwatTR5s=
X-Received: by 2002:a17:90a:d2c6:b0:340:b908:9665 with SMTP id
 98e67ed59e1d1-34f5f32f41bmr868940a91.37.1767658289829; Mon, 05 Jan 2026
 16:11:29 -0800 (PST)
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
 <19a4596d-06dc-42ae-b149-cc2b52fffae9@oracle.com>
In-Reply-To: <19a4596d-06dc-42ae-b149-cc2b52fffae9@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Jan 2026 16:11:17 -0800
X-Gm-Features: AQt7F2rJzuwfcRiuuaVgCyIvWFj0PWFvoIx4vn4W02DceGhrvAOlPrR6ywNywr0
Message-ID: <CAEf4BzbCxGaFu5E_oYdMxzkqhtVxSnwHawcUv5jM5Sodut5cdA@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 01/10] btf: add kind layout encoding to UAPI
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
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

On Tue, Dec 23, 2025 at 3:09=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 22/12/2025 19:03, Alexei Starovoitov wrote:
> > On Sun, Dec 21, 2025 at 10:58=E2=80=AFPM Alan Maguire <alan.maguire@ora=
cle.com> wrote:
> >>
> >>>
> >>> Hold on. I'm missing how libbpf will sanitize things for older kernel=
s?
> >>
> >> The sanitization we can get from layout info is for handling a kernel =
built with
> >> newer kernel/module BTF. The userspace tooling (libbpf and others) doe=
s not fully
> >> understand it due to the presence of new kinds. In such a case layout =
data gives us
> >> info to parse it by providing info on kind layout, and libbpf can sani=
tize it
> >> to be usable for some cases (where the type graph is not fatally compr=
omised
> >> by the lack of a kind). This will always be somewhat limited, but it
> >> does provide more usability than we have today.
> >
> > I'm even more confused now. libbpf will sanitize BTF for the sake of
> > user space? That's not something it ever did. libbpf sanitizes BTF
> > only to
>
> Right; it's an extension of the sanitization concept from what it does to=
day.
> Today we sanitize newer _program_ BTF to ensure it is acceptable to a ker=
nel which
> lacks specific aspects of that BTF; the goal here is to support some simp=
le sanitization
> of the newer _kernel_ BTF by libbpf to help tools (that know about kind l=
ayout but may lack
> latest kind info kernel has) to make that kernel BTF usable.

Wait, is that really a goal? I get why Alexei is confused now :)

I think we should stick to libbpf sanitizing only BPF program's BTFs
for the sake of loading it into the kernel. If some user space tool is
trying to work with kernel BTF that has BTF features that tool doesn't
support, then we only have two reasonable options: a) tool just fails
to process that BTF altogether or b) the tool is smart enough to
utilize BTF layout information to know which BTF types it can safely
skip (that's where those flags I argue for would be useful). In both
cases libbpf's btf__parse() will succeed because libbpf can utilize
layout info to construct a lookup table for btf__type_by_id(). And
libbpf doesn't need to do anything beyond that, IMO.

We'll teach bpftool to dump as much of BTF as possible (I mean
`bpftool btf dump file`), so it's possible to get an idea of what part
of BTF is not supported and show those that we know about. We could
teach btf_dump to ignore those types that are "safe modifier-like
reference kind" (as marked with that flag I proposed earlier), so that
`format c` works as well (though I wouldn't recommend using such
output as a proper vmlinux.h, users should update bpftool ASAP for
such use cases).

As far as the kernel is concerned, BTF layout is not used and should
not be used or trusted (it can be "spoofed" by the user). It can
validate it for sanity, but that's pretty much it. Other than that, if
the kernel doesn't *completely* understand every single piece of BTF,
it should reject it (and that's also why libbpf should sanitize BPF
object's BTF, of course).

> Both address mismatches between
> kernel BTF version and userspace. The sanitization available in this case=
 is quite limited,
> but it would work for cases like BTF location info where it's optional an=
d doesn't get
> entangled in the type graph. We could call it something else if it would =
help distinguish
> the concepts, but it is a similar sort of activity.
>
>
> > be loaded in the older kernel where the original BTF was
> > generated for a newer one. There is no reason to mangle BTF right until
> > the point of loading. Presence of a kind layout helps user space toolin=
g
> > to print it, but that's not sanitization. The tools will just skip over=
.
>
> With the help of flags, we can do a bit more than just have bpftool print=
 types; we can
> also support generation of a vmlinux.h in some cases, support some fentry=
 tracing etc.
> Anything that requires a close type match or relies on the newer BTF feat=
ures we do not
> support will not work of course, but it still salvages some usability whe=
n kernel BTF is
> newer.
