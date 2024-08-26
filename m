Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE1F187FEA
	for <dwarves@vger.kernel.org>; Mon, 26 Aug 2024 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724684127; cv=none; b=SEfHUJhFKeZEJW8OkFgku/sWAS5m7F3dn1K2w7fRF9E2xU8DavOr/IqKBTbBS4fBEbb+1Z2zOlJx4CiP/Ai5uU94CWVolWkWikRZWh9IVR2hoS/NyrLJU6OPxvQ6RuW5bBZOUJBx9f4rgbFA98OhiiKKKh34b0dFGL5bHq4dUuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724684127; c=relaxed/simple;
	bh=Xaxt3sxTt4SJfX/1FvpU++CsDj/xCqMcMKtT5PjmTaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJLJdK8XiLyHBOMfYJSq7FHCJl98i13SPAImPNpRSehQUDoaLG1jfJv8uSTq15D6pXIt6Z1Efa8rcMaJSzfUGmnwXGSOYn85byvv6DEpMqnzxIbUzFjRiP9w49QnHJSaaCN63q2Q/qQPkU9QjdPTKRwFexLw+oJuMONNKN55uYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr; spf=none smtp.mailfrom=obs.cr; dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b=HS0ria2r; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=obs.cr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="HS0ria2r"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6bf7f4a1334so19782096d6.2
        for <dwarves@vger.kernel.org>; Mon, 26 Aug 2024 07:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1724684123; x=1725288923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+Nt7FtSCPozCdqV/IG7HKDOjCJn/uZRxRcX8jx/6v0=;
        b=HS0ria2r8wNO050wY1KiCAc9JbKvOL8HGUBXJYvui/EcQKJTBj/y+JDv4lmprIaMVU
         4MQ4Z7ttf7JQpg/wLXgfMapIBuLmePwOJMxx+XBKCsXhsjAHMiGP4ONAoF0M9rk8LSIw
         WqCEDNxXItdBAZO2VHfC7n6rk9A7h76mePj3FRe+XwFVBOQc7ZsTADAX7kcRTHgEKnpp
         RLit0cQznEWRRFf4Dn6fixDiaSEYj8uRqJqpmKhldvbhRVi5ff6CRukdxL9eBnzhSVLn
         61ncdapMOKWjDhM1fZ4zQBgyGVfhtuvCOTjWov/BJPa8U0puMe8bik2mlVNQjt/VKQBV
         PJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724684123; x=1725288923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+Nt7FtSCPozCdqV/IG7HKDOjCJn/uZRxRcX8jx/6v0=;
        b=l623SpKocEprYbi0h9iAxgnp+CjjkzBsdtT9E7/AoXHC/pjFOa6GOq9F6pwr4xqyWG
         VWJO7ZBRRlK5lR31ag2458l3wUG9QueGRsNWkXf1aNc+WKGMRdWQ62+CeNfqAlxDyd1t
         lInZJxJqr1jbsnUNOdsC1T64XbWv7LLS0TWEOSJUR3bjPL7doDXUmibueNEmkaSCbHEz
         WgptrSG2Cuav75807ua3B0eOvI6kDvZLbofxNXTeMujwXxWY7cxeaG9qQTikqs+Dp98O
         CR1N4o0Zig5MY+dvR34L1r0lbdniYH1EC1NYlKZU1cie960eqw7/nuaIe7JhgTVp7zCs
         62Iw==
X-Gm-Message-State: AOJu0YzJDSKm3oZnKLhx4KC0V8HF0562tgx2tlbAKgD5pi3REsBR9+pV
	gXWf2eDC3et0hvdCnPayCPZpwT0qqPSRtqTKClkcwNdZ35US8R9l2gZmXaAALSwx4VTIqArsfYo
	N4v8dhy/XUnFRF4RXkzTKdq1kSemOA44xHVoF8KJpX/cgzruF
X-Google-Smtp-Source: AGHT+IE9YuMo2JjyW+sIlHYCMIeBRluVIMc05oQhW+vfaTNuv2zRL+D9289lHADLhJTif3tWX/YmaEEcvXrbV2M1FWg=
X-Received: by 2002:a05:6214:4904:b0:6c1:6add:6989 with SMTP id
 6a1803df08f44-6c16dcb2b2cmr130630786d6.42.1724684123270; Mon, 26 Aug 2024
 07:55:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823212835.1078351-1-hawkinsw@obs.cr> <ZsyWmWL7n4QbE1mp@x1>
In-Reply-To: <ZsyWmWL7n4QbE1mp@x1>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Mon, 26 Aug 2024 10:55:10 -0400
Message-ID: <CADx9qWioTbXy_+HzHQEjW434Z0WyNWAQdF5jgW20giAWDGUjyw@mail.gmail.com>
Subject: Re: [PATCH 0/1] btf_loader support for subprogram linkage
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 10:52=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, Aug 23, 2024 at 05:28:30PM -0400, Will Hawkins wrote:
> > First,
> >
> > I am a huge fan of pahole (and friends). I volunteered to work on
> > helping to edit the BTF spec for the IETF and so I've started to look
> > more deeply at BTF and the tools.
> >
> > Second, I hope that what I am offering is being sent to the right place
> > and is in the right format. I tried to follow what seems to be the
> > "right thing" by looking at mailing list archives.
> >
> > This patch add supports to the btf_loader for subprogram (BTF_KIND_FUNC=
)
> > linkages. For example,
> >
> > ```
> > $ cat a.c
> > static int x() {
> >   return 5;
> > }
> > $ gcc -gbtf -g -O0 -c a.c
> > $ ~/code/pahole/build/pfunct -Fbtf --compile a.o
> > int x(void) /* linkage=3Dstatic */
> > {
> >       return 0;
> > }
> > ```
>
> So, I'm changing this to become:
>
>   $ ~/code/pahole/build/pfunct -Fbtf --compile a.o
>   static int x(void)
>   {
>         return 0;
>   }
>
> As --compile is supposed to generate compileable code that is as much as
> possible from the type information similar to the original code, ok?
>
> Thanks!

I agree with this 100%. I *almost* made that change, but didn't want
to overstep my bounds!

Will


>
> - Arnaldo
>
> > Sincerely,
> > Will
> >
> > Will Hawkins (1):
> >   btf_loader: Support linkages for BTF subprograms
> >
> >  btf_loader.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > --
> > 2.45.2
> >
> >
