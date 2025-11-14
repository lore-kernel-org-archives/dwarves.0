Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3282126F293
	for <dwarves@vger.kernel.org>; Fri, 14 Nov 2025 02:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763086501; cv=none; b=iUGSaGq2XnohdUXqCtW8nireO6+7WOyEBbBRaRYfyZiO+z7kVxbRuib9t54kPvdykylLn6Av+D90QtOMv/akHp1K7pUwlbt3Llqll0ERvANHtOHR744ya42fiJflA+/hF+tOgGPBMGxNDFl+1LlUCsOEc48YD1Ejg31TVxgEGCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763086501; c=relaxed/simple;
	bh=DXtlWO0jsUNktnEF4l6xnCGN9M9bdHJPkp/4oqliQ6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcEZZkjTEPAsNanbKL2oa8pX53jjiNKojvdJ7jvULFewhLnLnZrTqtq9JETr6Z8fVSuEMdTFg5CPcxTtIgZxNgMS4DDKpVb+RkDxAxrLnmnD9wv+xQMDLx4Mr/6cc48p2JMwK7H0j89FVf3PzSVBwlZkammNzrFVDO0iK0VIb6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bd0oMkks; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bd0oMkks"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47755a7652eso10449525e9.0
        for <dwarves@vger.kernel.org>; Thu, 13 Nov 2025 18:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763086498; x=1763691298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXtlWO0jsUNktnEF4l6xnCGN9M9bdHJPkp/4oqliQ6Q=;
        b=bd0oMkkshisMBRYqle4/GGpclAISJqLbZ+xruRN34Rdx9k/dtEG3NWlHSfo2PeeTJn
         KQLijeJZIq7sAh+6o9I2XwTjpgJTXL7i0aS+Zg6hylkz18G4HiMPDHjBrP8+N/llJZaI
         4C8mKB/TIzKDds6Zc8sHYv7sqN67PSia9MB0R1yUxYdWGgzv3nc+Nr6mE1T3uKQ4Z7MK
         u3Ar4l8LetksG0HcjXF8uyc5zZ8d4a17+b9gSkqhGHlrwHQ2xa6/bmEwSCpuIHhlkKRl
         JeDmFJhinkg1zGCTibTHA80KI6h9GhKTcybwfdplHfwFYMzOHUNw7bdLdhhma6ELCSEJ
         E8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763086498; x=1763691298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DXtlWO0jsUNktnEF4l6xnCGN9M9bdHJPkp/4oqliQ6Q=;
        b=m7C7d+2SL0yIZkL5MBVY4ZvDtEwUtp9LmW1/w9lfDjpKzCtwYENagMRKtSnUX0EDdE
         dz8aM0guHAAYw0QZOM5TMbx417OTL8YqdXDVDhZiDvIYPTZ1hTVyL/5kA+QDxcAEcAmQ
         kOj9jCkhljakalH+H39R32FR5fOj5wImg25YEiZXKPgQnRz7mKofIfGYRxfJJa40rT/6
         pHclPj/P3orCvdxVIwBAdd0lJESU7OdJRg8/f2oRbmnUGXzTtz8IGBKulhNF/VRH6/4w
         KhrXNJQ3TSxBZoaXepl7WlTDY+/HCUqisO0ge1Os8OGkjhZ+atme2o+Hk6GJ/ocN89PO
         LddQ==
X-Forwarded-Encrypted: i=1; AJvYcCULoSQXtT7lEVWWg/J7C1CIrdtbPGAFqXAKi1oi7e7yNmHkIGpPiyLjHfaX7JpgQ+CegcxAKi8x@vger.kernel.org
X-Gm-Message-State: AOJu0YxFjvUV+rjrSr+6+WC3Ch7wBOUqHtQOvJuNF9CodKEUgEtg8T9F
	bZHCFytVG1B/6a7SPej5faGLVt4EhcTbZAu4mcUFn09ukJYT5SswqS0QMdF2jMj+O1ooD5Y+xl3
	Ut/Rsjrs5pGN3tINe8GOwhMBd3IumqeU=
X-Gm-Gg: ASbGncvEkTTByK9tkTCaAgPrEHwxZRQllR0r5r75jrFu72C3bdyH/0Al/hnN25SO4hl
	6oZX6Fc4RFTw0CG21enU9F5FTKIohDAmeE8ANPXT7jbj0Hzbb4WVYxRiObEh9I/LFvyQpiyorMr
	43EC02UiCQSElCWwkiVomYXw+LGaCYNsbUuJJU2WL0yeObzZH8L8kYNC7Qs8aYL8AsodpedO6mG
	prjzryG7WZH0QYbNLZgAQkvalDrPSFf482OlU9Z5s4+hzhaNYcJ+zc7DAhECNbIYr9IcgCA8YlY
	+fSX5St39vGKcCAYd0V3r4wgITvIk4EgQeFpJY8=
X-Google-Smtp-Source: AGHT+IGq8Zt+pVviat5YdddCLTZlt3qtwpaXQ99vIA+FGg9ovsF0ZqTybYh6tjDO47bdjpp3Oq69PypcopQt8kTYvao=
X-Received: by 2002:a05:6000:430d:b0:42b:3b62:cd86 with SMTP id
 ffacd0b85a97d-42b5933dbf7mr870772f8f.6.1763086498404; Thu, 13 Nov 2025
 18:14:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106012835.260373-1-ihor.solodrai@linux.dev>
 <520bd6d8-b0a1-40f2-a674-b4c6ed02e254@oracle.com> <CAADnVQJj6EcntgiAm6Kv8FJvP3tQcG=EzWt-uFuzszHtcw4gmg@mail.gmail.com>
 <aRaPnq2QJN1iFF_3@x1>
In-Reply-To: <aRaPnq2QJN1iFF_3@x1>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 13 Nov 2025 18:14:47 -0800
X-Gm-Features: AWmQ_bk2T-XSB88o6iYBIKRGd2t1lxi3j-bcbJRWYtMwoIYC3mxjS1Y5-B6Hi_U
Message-ID: <CAADnVQKaGgRemVtOQRgg=UmZCu5N1p6=XT+YW-668hy6dod6UA@mail.gmail.com>
Subject: Re: [PATCH dwarves v4 0/3] btf_encoder: refactor emission of BTF funcs
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	dwarves <dwarves@vger.kernel.org>, Eduard <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 6:10=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Nov 13, 2025 at 09:20:44AM -0800, Alexei Starovoitov wrote:
> > On Thu, Nov 13, 2025 at 8:37=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> > >
> > > On 06/11/2025 01:28, Ihor Solodrai wrote:
> > > > This series refactors a few functions that handle how BTF functions
> > > > are emitted.
> > > >
> > > > v3->v4: Error handling nit from Eduard
> > > > v2->v3: Add patch removing encoder from btf_encoder_func_state
> > > >
> > > > v3: https://lore.kernel.org/dwarves/20251105185926.296539-1-ihor.so=
lodrai@linux.dev/
> > > > v2: https://lore.kernel.org/dwarves/20251104233532.196287-1-ihor.so=
lodrai@linux.dev/
> > > > v1: https://lore.kernel.org/dwarves/20251029190249.3323752-2-ihor.s=
olodrai@linux.dev/
> > > >
> > >
> > > series applied to the next branch of
> > > https://git.kernel.org/pub/scm/devel/pahole/pahole.git/
> >
> > Same rant as before...
> > Can we please keep it normal with all changes going to master ?
> > This 'next' branch confused people in the past.
>
> I think the problem before was that it sat there for far too long.
>
> I see value in it staying there for a short period for some eventual
> rebase and for some CI thing, to avoid polluting, think of it as some
> topic branch on the way to master.

I'm still missing the value proposition.
Right now Yonghong is also sending pahole patches,
Ihor will start moving things from pahole to resolve_btfid,
Donglin ais lso working on btf sorting,
and finally Alan has large loc* patchset.
Some or all of them will conflict.

What do they suppose to use as a base?
'next' branch? All of them or some?
How will you differentiate and educate developers ?

Really, 'next' branch is not a good idea.
