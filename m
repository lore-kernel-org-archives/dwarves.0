Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE6C18AF9;
	Wed,  3 Apr 2024 21:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712180627; cv=none; b=Ff/2yymvn25ty9B5Jyqb65U7iZ18U0fAbs82Nll40mpOmetitlunISaBBnHB19OdRCOSg6uJSKNX/Ti/BFFqgOspjTgzoabJTBP8xpEXXetKrJuE5Q8HSbFjIWJ2KECJ0LtayXBDyWB6IGdI/pTRJrHuJZk9sQN0dTe3pWIYqmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712180627; c=relaxed/simple;
	bh=qz3lx3iAh+klXstZPi5xLCPVRy/cZMQXYrPBSNlDwcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFXtN2LiXBsVDsZpVMe+h8hsk6p0tuqInSd8DsjGFrvqHsGkcU2oVfx5Qn5KKVqS5ivWXh2eNyLf+f4SOZ90X2tmECKp1476hRL5sGU5NIu4Dd3bTFQqk1YLvpjb1CpIKmaeUBVTko9qWse0oLWMdz1E0gBvAOmPzIK7FRbCZ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2cFDPQQ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2cFDPQQ"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so275908a12.0;
        Wed, 03 Apr 2024 14:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712180625; x=1712785425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrZX5EZ+WvwBmXot/y5VRczZ+2VAk8/7mvL3vchR854=;
        b=V2cFDPQQSVtZZe9TegXcbqWBr46rOZ9WlKS1dNp5LNZpdwBbahbB/tkxHFb7e5Llls
         uYp6RAnWiL5j2HNAbVFHWDvTJAtYLT40K62OEWh63w2qpgPTnP2ExmxbIhTmAZES1/k+
         4cuwlJ+U4047ReyDwB1k8QgkNQvQQ5AYUQhVCwmKHMOwEnEfaiAviwO424JoDQoF828K
         n5rAjVh5To6nJlRQZrnYY0Sw8dmsZbRu6R6XRTyWakxS6ltnYSyWWSpBOz9ztyC4CFlO
         9sFpkhdRnZClkRcpx53kIOsm50JKeFaA0tTI1y5qdJfHPEpNLF9odKNPcwVFHwBaRBjo
         i/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712180625; x=1712785425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PrZX5EZ+WvwBmXot/y5VRczZ+2VAk8/7mvL3vchR854=;
        b=CmhTG6ERye8zUNMNM4dz0dVMVKHOEM2JTY8rxy40ccEKYAX0BbKXQ0DqGJhWrkQmEB
         K829xoPJNI2BPpfAGnMTLMuiUxDKytQO8W5Gtm1p5873REm+2vD71zmgm3qQWgldClUs
         rGNMpceTeX5QE7Ws3FoVKI4mFdSjFox/R1ThtW2cV6WNIhtOdiL9C+EmzUZj+dNNp2G5
         3au12DGNVL8f4wj8Nm5kjbSXBxeMawWI+QMNrC5TrQ4vzHvr2hYCJvuL/BXzGgqvfPEw
         e+nCZ4oHh6KWlKEsy0nr3aCC0Ok4rac/eYcjUhYJvtQU8tZEw8qtbs9RMR5qPQDstQXw
         tlaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU8GU+sGlPklFrBGDpMlEIdPxLOpZQpnfXev1+LK9DfPUAYqj6/Sp2pomBPrEosLyz+E9vVnIyrBTfVDH+dYovqBrN
X-Gm-Message-State: AOJu0YwKRvoavEDuBckJ9wXtz9nO36F0cH/MJ9fzOIWvAYjEH7BZQMet
	rKCKgY1H+RgcDqHZcfZALjPIxVx77q2caloshpN0IhFHBXjyjOswY4Lw4iPQmtCTXOUkFmtc4OH
	RG4C7vDncn+gRZ9rFvfMQDELn0SE=
X-Google-Smtp-Source: AGHT+IGhjk3YTqQaPK8qrcoDD1jahcqinXtFdw0FSWnel92cd9UzCzgmEEzSwWupcOjxzUFq1MUjIoSajPfBhdQzsj8=
X-Received: by 2002:a17:90b:f87:b0:2a0:97f0:955e with SMTP id
 ft7-20020a17090b0f8700b002a097f0955emr767443pjb.37.1712180625106; Wed, 03 Apr
 2024 14:43:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402193945.17327-1-acme@kernel.org> <20240402193945.17327-3-acme@kernel.org>
 <CAEf4Bza1BG+f__D4fvDvZueGxL0yrMuVu6LZQmNyme584L7r4w@mail.gmail.com> <Zg3MRC4bhJgMmDTt@x1>
In-Reply-To: <Zg3MRC4bhJgMmDTt@x1>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Apr 2024 14:43:32 -0700
Message-ID: <CAEf4BzYqstFaJXK_h+sqa2nsosD_V0gQvbL+mcE+W0UqZs4nKA@mail.gmail.com>
Subject: Re: [PATCH 02/12] pahole: Disable BTF multithreaded encoded when
 doing reproducible builds
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, 
	Clark Williams <williams@redhat.com>, Kate Carcia <kcarcia@redhat.com>, bpf@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Alan Maguire <alan.maguire@oracle.com>, Kui-Feng Lee <kuifeng@fb.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 2:38=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Wed, Apr 03, 2024 at 11:19:33AM -0700, Andrii Nakryiko wrote:
> > We can still produce per-thread smaller BTFs in parallel, that won't
> > hurt reproducibility. You only need to concatenate them in
> > reproducible order at the very end.
> >
> > Or maybe it's already working like this, not sure, I'm a bit rusty in
> > pahole internals nowadays, sorry :)
>
> Yeah, its just that I didn't get to that point yet, I just stopped here
> to have the parallel reproducible feature working, will continue with
> the parallel BTF part.

Great to hear, thanks, Arnaldo!

>
> - Arnaldo
>
> > > diff --git a/pahole.c b/pahole.c
> > > index 96e153432fa212a5..fcb4360f11debeb9 100644
> > > --- a/pahole.c
> > > +++ b/pahole.c
> > > @@ -3173,6 +3173,14 @@ struct thread_data {
> > >         struct btf_encoder *encoder;
> > >  };
> >
> > [...]
