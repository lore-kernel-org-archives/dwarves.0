Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9C6198823
	for <dwarves@vger.kernel.org>; Mon, 26 Aug 2024 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724690221; cv=none; b=SRFvAJHs7vbtZJleEepl3e8mwvn3RSWpaVmZ8q+TB8xeBztM2EuGRinAzhHhYzbXA5+gE4KmeJdU1ESsWphMRuzZccY0N+N4s+Q72tqISwCd+EAhfZsUGUcFQfTVE9sghfMIzpdhPFHZt67fdnkAc9ovrcrHQqjNNO+c389qpLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724690221; c=relaxed/simple;
	bh=vfjbXlrZtRPtQRBf4eNnLP9hGQ0H64XLc3HXP+RaV+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SgSEatvc0NtwU4xm3pIA4G+xvSqn3o7B64CViL6hIsww/sDOgybVzHP0yoEqiTn0ROUxtlL3Nj46RSLrk9+0yayWsNI95XKhZfq2TUsmrYZouU8Dva74g/DEIF/wBqGWy9VRLX/YpWE38qAMRTOt+ckwXq8Tt309dSWQIslZhNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr; spf=none smtp.mailfrom=obs.cr; dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b=SzGAEq1b; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=obs.cr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="SzGAEq1b"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5dca00a72easo3732652eaf.2
        for <dwarves@vger.kernel.org>; Mon, 26 Aug 2024 09:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1724690218; x=1725295018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdHMOJ6AgDa5/wbWxRIn5n3d4W7b4pyd+CGVoJ5M5jw=;
        b=SzGAEq1bMYvs9y0pbaosKlt6qO+dM1SH0Wui+k/eB6X46KE7A06xKTpbBX8+yWBfOL
         Znvz9ZzfHq9jF4ruYWTovAVNA+Ktori36Va0WF58ZSeFo0QInu8PmwXcfa61ynuZNkb9
         q7UQ9YkDE3ZJxeavXQ0juShD2KqCOvJyl7/HGC0IXWvSDdBy0VK1r2kTsgJbpN2cKiNC
         d18E9vEqouz1nvm+tLBuocSVynL2ymraf2yh7fOgbIRqHxyPY9qOJpcemW9zGhdent9i
         uOYGMEPlB+kuALmV5mlFvVataiL9QDj4U8wAg0r0C7yMSAu0g2tZoiRgbGdQIoiMTu5f
         FnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724690218; x=1725295018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdHMOJ6AgDa5/wbWxRIn5n3d4W7b4pyd+CGVoJ5M5jw=;
        b=Pf6g7KF/M4RWZvuNPFiTIMQPjjYHJtkvOugkNY69qY8zQl5GVSE+VumWCUBCvkmtwJ
         8plb5ZKrOpi4OWrI1KF2h9O8RpUSHgvOah9E3AwYgsllt6Yj4Zr9cWWToSwcILCkYaKj
         JLVvC8qVhLcm8PJaymKtbxpmFXiyfpxPmGjtz7WadNaCG2TpPrpiYGQ2k9i4+Xpr+RGn
         wjRIfgOTtTYByBvZ+qaHQowuyzU2OmkbTTUIg+vGtC7JlHqMUZQ7LH19AjWXn8fBLevZ
         +HT5MfZ4WYJ8JzCuqUaNbLrQYjcV4HX4cz3iM+s+KGJFMp+QGjNkEWm8SeEczs9XRFu2
         7cFg==
X-Gm-Message-State: AOJu0YyoJBiWYgZw5x8Pt7TSELZg+YXDHvjHJ7VR2bl9B+15yE8wwyXy
	pqeBeA2KNSHUszdeUwyx0YNgliPDEFwllsUqQc5u11Im3Fsowj+HhF8vR1AwbDgAe0HV9H2xFX+
	Qv77ilwdVzMzZRqmmQvU2y4Fttt4+ul/SfLsPHydIJVY5tyJb
X-Google-Smtp-Source: AGHT+IHtDWQo6teil08YXNEnxgWDaUXpLQoakq3OnFxBD9WWb1Q9fr09lTDvEdgwylGpKw5N0gtGXro0ihzYXes9aaE=
X-Received: by 2002:a05:6820:1621:b0:5dc:95e1:b264 with SMTP id
 006d021491bc7-5dea67ac2f0mr377655eaf.3.1724690218557; Mon, 26 Aug 2024
 09:36:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823212835.1078351-1-hawkinsw@obs.cr> <ZsyWmWL7n4QbE1mp@x1>
 <ZsyXAcCv8sBwxLH1@x1> <ZsyYGPUEtP5zP3i6@x1>
In-Reply-To: <ZsyYGPUEtP5zP3i6@x1>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Mon, 26 Aug 2024 12:36:45 -0400
Message-ID: <CADx9qWh=Sw2Cr2Y8K_2ExTFJecTrhenN9TzVH0kyKL+buWVa2Q@mail.gmail.com>
Subject: Re: [PATCH 0/1] btf_loader support for subprogram linkage
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 10:58=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Aug 26, 2024 at 11:53:56AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, Aug 26, 2024 at 11:52:13AM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > On Fri, Aug 23, 2024 at 05:28:30PM -0400, Will Hawkins wrote:
> > > > First,
> > > >
> > > > I am a huge fan of pahole (and friends). I volunteered to work on
> > > > helping to edit the BTF spec for the IETF and so I've started to lo=
ok
> > > > more deeply at BTF and the tools.
> > > >
> > > > Second, I hope that what I am offering is being sent to the right p=
lace
> > > > and is in the right format. I tried to follow what seems to be the
> > > > "right thing" by looking at mailing list archives.
> > > >
> > > > This patch add supports to the btf_loader for subprogram (BTF_KIND_=
FUNC)
> > > > linkages. For example,
> > > >
> > > > ```
> > > > $ cat a.c
> > > > static int x() {
> > > >   return 5;
> > > > }
> > > > $ gcc -gbtf -g -O0 -c a.c
> > > > $ ~/code/pahole/build/pfunct -Fbtf --compile a.o
> > > > int x(void) /* linkage=3Dstatic */
> > > > {
> > > >   return 0;
> > > > }
> > > > ```
> > >
> > > So, I'm changing this to become:
> > >
> > >   $ ~/code/pahole/build/pfunct -Fbtf --compile a.o
> > >   static int x(void)
> > >   {
> > >     return 0;
> > >   }
> > >
> > > As --compile is supposed to generate compileable code that is as much=
 as
> > > possible from the type information similar to the original code, ok?
> >
> > I see, your patch isn't the one adding that linkage comment, you're jus=
t
> > collecting it from BTF, I'll then add a followup patch to get to the
> > output I described.
>
> So I'll looked up what that linkage field comes from and:
>
> commit ce516fb0cf2a3d9fc45c2a9c7ab2cf4bd24965a0
> Author: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
> Date:   Sun Jul 8 19:47:26 2007 -0300
>
>     [LIB]: Support DW_AT_MIPS_linkage_name
>
>     Another C++ specific case:
>
>     -       class TypeTemplate ByName(const string  &, size_t);
>     +       class TypeTemplate ByName(const string  &, size_t); /* linkag=
e=3D_ZN4ROOT6Reflex12TypeTemplate6ByNameERKSsj */
>
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
>
> So its not really "static" or "stern", but the mangled name in languages
> such as C++, so I think this patch needs reworking, there is ambiguity
> on the "linkage" term, we should use some other term :-\

Completely understand! I will rework it and propose something different.

I am just thankful that you are so welcoming of the contribution! Your
enthusiasm has made a contributor for life!

Will


>
> - Arnaldo
