Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241F1194AEF
	for <dwarves@vger.kernel.org>; Mon, 26 Aug 2024 20:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724703860; cv=none; b=Sm2We8aCqkeGp4cdnxwrgOQ9lQ8NRW6sY+qCN9+EYOi/OgObhV1uqmt/lPuGl/bgYO8rBCamXCFZrm1NlwhqVca0nc6rGGMOIura7UgB0JrWG55/VlkCYRPeQrtnQgvLc4wdWvviiA0PvYsx2RgLhqXOXx+nhbaLSUhuQ4z/xbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724703860; c=relaxed/simple;
	bh=2WcH7zNjs/4tIMC3w7G3LS3a20sMNEt/cgDLDefQ7Rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJwT0CQLaS2mLBNf3IGOJDYiLO3Ji7wW29BN8c8loXb07Q9iGc7hMjMsK0xR5GhbQF5NlX6LfACWC2fgbIfmvSlmUFFsdBDLCM2w7mWLci7+deg/Ekrkmob36mH4qVvmITcETfC20VbXj1jQeDlg3gGpVAtr9LmBn4RXPwjyQUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr; spf=none smtp.mailfrom=obs.cr; dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b=DbC1+xs7; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=obs.cr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="DbC1+xs7"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6bf7707dbb6so36471006d6.0
        for <dwarves@vger.kernel.org>; Mon, 26 Aug 2024 13:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1724703858; x=1725308658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ih8j4MUp8fPRAl82Mshj0OfdEII9T1nJW4bPBvdw3w=;
        b=DbC1+xs7Bbx3chpv6yvyr48AMvm49jrxBoyHEnGfW2OhjMOg0C0Klw5WpR0vSpj/LL
         KmiuVMOBb1t2o34BKDjLlFoXW+GvBQSYzSD/nHvEckOrjWl8G+rItgYKh8HL285Z/SOr
         Zz41kKye3ljle/kIaSXiCsn6yzPncpw3IZ6UI1PCnaKBB+IkcDniU/zDiOXgq8bH1nF8
         1OeHpfI8AOV7J2nySSzOUKMzzBEQMI3Pzcg9ro5Rv1lKRK0BN5nvgxvl9Vtv4y63NOr5
         HJ+oZYbKSFGPBJkbOGsLZZkg3Gune+fM5SLricHhCdbQpANcAiQtXOW/r9e/4SpoiRW1
         XLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724703858; x=1725308658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Ih8j4MUp8fPRAl82Mshj0OfdEII9T1nJW4bPBvdw3w=;
        b=MN1ZOvrRsWoAcav6J0GNpkeOYvUfXorgzDWqo0HCQLf3+KB2wr2MXrvlmX39cWCmey
         Upj2V8K9lr0wp1BbToZWmoKpfHtDhoBd/8gJFk+UY7IVy8jMU/ihoscDbAso74RZyeLy
         ULH+a9/tbMhKJeHdf2qdRWrVELICmNxsFpayipCtF6hFwfbNYVbpsvrYYlhgwxqiMauP
         N5gZAYkaxBAOe7wNxF6398/m8BgZAdCzBetmatCSqEHGBlKFAU+n0M/lDwZ+ltDclcjo
         wxgIFizNp9RmwQ3f/xoyoodJ+1r+MqDhzW1MGX9bUldYlqzdkaFiWPrPU3e+bT4M3Rkj
         sXTg==
X-Gm-Message-State: AOJu0Yx8BjHZdQmHPKVZ4RqYKC+RGcvblnoAUqWvzs8K70Bq1jYb7Jnn
	SFWmGZQp0qqkT9XO/oDBUixx4vBHuhD4d9J7fv86Fw5o4i125PYV0bzPBVfAhzWaKla5v8rsi/2
	sOQ3MH2EBd7ulNNLCb8NN/IuzuUFmlNLVt/2OGA==
X-Google-Smtp-Source: AGHT+IFJkPvAa4xe+kdLhaJ7BaOAeub6t2tcBbzSxLWZAGNXSZM6geeS56keZR4+ziaLtdM4xhDevcsgwSb4lrh+RuM=
X-Received: by 2002:a05:6214:224d:b0:6b5:1584:62bf with SMTP id
 6a1803df08f44-6c32ae9c191mr17011026d6.6.1724703857877; Mon, 26 Aug 2024
 13:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823212835.1078351-1-hawkinsw@obs.cr> <ZsyWmWL7n4QbE1mp@x1>
 <ZsyXAcCv8sBwxLH1@x1> <ZsyYGPUEtP5zP3i6@x1> <CADx9qWh=Sw2Cr2Y8K_2ExTFJecTrhenN9TzVH0kyKL+buWVa2Q@mail.gmail.com>
 <Zsze05ar-q9iKvrS@x1>
In-Reply-To: <Zsze05ar-q9iKvrS@x1>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Mon, 26 Aug 2024 16:24:05 -0400
Message-ID: <CADx9qWhT4McMfjwm5iZ8hJhuJMxjJqjwRdp73doMXJSC-NnjQw@mail.gmail.com>
Subject: Re: [PATCH 0/1] btf_loader support for subprogram linkage
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 4:00=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Aug 26, 2024 at 12:36:45PM -0400, Will Hawkins wrote:
> > On Mon, Aug 26, 2024 at 10:58=E2=80=AFAM Arnaldo Carvalho de Melo <acme=
@kernel.org> wrote:
> > > commit ce516fb0cf2a3d9fc45c2a9c7ab2cf4bd24965a0
> > > Author: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
> > > Date:   Sun Jul 8 19:47:26 2007 -0300
>
> > >     [LIB]: Support DW_AT_MIPS_linkage_name
>
> > >     Another C++ specific case:
>
> > >     -       class TypeTemplate ByName(const string  &, size_t);
> > >     +       class TypeTemplate ByName(const string  &, size_t); /* li=
nkage=3D_ZN4ROOT6Reflex12TypeTemplate6ByNameERKSsj */
>
> > >     Signed-off-by: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
>
> > > So its not really "static" or "stern", but the mangled name in langua=
ges
>
> oops, "extern"
>
> > > such as C++, so I think this patch needs reworking, there is ambiguit=
y
> > > on the "linkage" term, we should use some other term :-\
> >
> > Completely understand! I will rework it and propose something different=
.
> >
> > I am just thankful that you are so welcoming of the contribution! Your
> > enthusiasm has made a contributor for life!
>
> Another recommendation, please don't point the field to strings like
> "extern" or "static", as DWARF is not language specific, pahole manages
> to handle C mostly, C++ to a great degree but I also used it with Go,
> Rust.
>
> We want to make it more language agnostic, so while the "linkage" as a
> mangled name is not language specific, "static" or "extern" may be.
>
> So just keep it using the DWARF constant/enumeration, so that at
> dwarves_fprintf.c time we can, based on the language encoded in the
> debugging info (for BTF we assume C until we introduce some way to
> encode Rust (The kernel can be written using Rust, so we're bound to
> have something in that direction introduced in BTF at some point)).

100% understood!

Thank you for the feedback!
Will


>
> - Arnaldo
