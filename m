Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B873826ED37
	for <dwarves@vger.kernel.org>; Thu,  2 Apr 2026 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775138617; cv=pass; b=ah7TuHJtvF+vBxdZH+QkWAyOrhuvyOupDf8WDMSJXW1INbGIlxDHaFSVNjms/+t5R7wTt3Ovfmc+rJ8mvff7KDEHMjBMniAGtNpp6YmNwxi/To/AiURhQv2OAvjy6ZezaEOiFxVsTwCguuioBhtmr0c7DmOA1zHuTQBRHFZJ0BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775138617; c=relaxed/simple;
	bh=ZyBDNZT3tKZUZ7qDcwZh0zaNOQse6P3km81WUeBgAxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UH9I8Y0eMxNbKOP5rTbJ/RUMSo3ELF1NNSYYv1wctUYobGG7yg9n5e54hHV0EO7OTdPCuPCZeXvH9KnKv4vzvf8Q6UYKghBGVd5dFTzjBWlJLwiXoOQmPg3l3wU6OS/unUWL/+EqzoQh/tuHClQlI75HtV+l5kXOg9h/Gj0Hw0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGl5chNo; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGl5chNo"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d0deb7ad5so900450f8f.2
        for <dwarves@vger.kernel.org>; Thu, 02 Apr 2026 07:03:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775138614; cv=none;
        d=google.com; s=arc-20240605;
        b=ZqZ4gFYBF38V/Rf5OGXMpfVEDa9sXOI4oaQUKsovWa13z9m1Qw8SBeFEQSBmLfg+0K
         BN2YeMs2+uF04rr2BXItUZ3ODmM4NljFg/wnodRU59yBqwdvUc+94dhQlQkiWY1Scftk
         WVbJzrQqJZxf4GOvoLfXG7Cr4IrgBsoZrDtpNxDp046bqBqiq6zlIDZIgEa5GmnAtAzp
         d10LIJI++FgpmXY/6QqQiwYSa3hid74PYgn2THCe9hjmXTSwQpISLlmreej2is6IYnw+
         leCE8EUkZ4NZfkyGJisDqTHFD7drbFiVHDSL4IZwL1hXbuyGF0eTZYdP8kEHv37XvG8Y
         iC/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H2Q1xAI7WKIB5uC/FrFV4Uhab7Dfj4POcaruiaTCtVI=;
        fh=liAZA0z0OJ50PLyMFpFPigcbMf+wGcj1RBVqZ7Zz7SA=;
        b=hnXKhS+zqcpi6gt5uxWMTEpFCJ/iczltAg6Jx5fjbt9Mh5jaYLgtFhtcEx2+QtX1K9
         AB2wL8WI91a64NQp1GekDsHQT2OYuCZj6BsCnI9JyCKPr6z+Oc2tTdphk7+2p9j95+xM
         Ug6p48vplVF8ktsaEoGym6DT+sH3a3omo/JWJYCPrFc8uBdsTJRV9qxl/5Ehm0hMZWOl
         YQT/JNbEl9mofXrdUl+j1Lad8MaOZpT56MNnjYIALJ233Zolt6rvnTknCNFK6QzCpFaO
         4UJQf6dILOvnqve0L9VjU8pEpd1+J2+Ph1PC0IgR6FmUTJxuAZ0AFDh23RukNS/cztJK
         fTOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775138614; x=1775743414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2Q1xAI7WKIB5uC/FrFV4Uhab7Dfj4POcaruiaTCtVI=;
        b=hGl5chNoqz3PsH30zOjS/V307lHsahG1n+DiONTGTfKLxImmaKSp9Cm53M2hKKPdMS
         yMuK09lY94MMpgrUAorwhInvStLF+M669P7jm5kECl8yvOhGqKjeHEQUre4Md32wI9B6
         BVT7P2v0XOC1az529bxAmOF2cJX1ThMrGdTA6ScJ4YzEmwiNm0yQ9V1Y9ieFnUfJN+VC
         Q8ChTV4dOXXNnrnLghVKd+Le3kXEw2vIs4fCr6n1Kzv/DccP44SQC3fp0e5+rA3PcrqM
         OOSQi+fy3cUBH4ahQ0svZ7ibTaxblSUa7I1axPbQ+eplzLsQ8jEpGqVbRMKK8Gmfs4de
         scUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775138614; x=1775743414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H2Q1xAI7WKIB5uC/FrFV4Uhab7Dfj4POcaruiaTCtVI=;
        b=EbyAi4+lt2DU8zUbKG0KlHBcoUix5LYOizm+MCwyxiDyEYLlOtMhFU3hUyC5Y8+K3o
         FBOxNAHfXwjtIFpTrMyfaTj7RFUueF0FTGZJEYIU219QWm2w4am50xNzwPKfdj1bz4Dr
         +G6LfMqwCSjHWgTjKhRH3gybNqP0Q8TMMD1LOtSfNXb6G5kp7fdu3U/gCUGB8L2UOyI+
         Cye7OrsxFjMv56Xjw3YdwPO4D2bfk4EO5rNV7exTOndrjZbeAzka6J2fdqO9I+nQl7Ox
         u2lkncXSGA9+PZTvusA2g/qYkhDQUJIIw1S/NaZYvLzW4wiD8cAY4CBlfyk0woP1RuQ/
         fC4w==
X-Forwarded-Encrypted: i=1; AJvYcCUCQRV3mxUGpvdAongPHbCujgFx06SL3H+pJfB1KkYDoDGmyqUA5nyBUVbE9ilJbbx/uiXsMgAs@vger.kernel.org
X-Gm-Message-State: AOJu0YydLoEqPnVXFIAAT/2sfsvlp3SMbA8jIUHR+X2acVCQ8lq/ug/c
	2/JMqwQWAzV/JfSau6JAG65SaqtvA1u515KDKhuPyRDjNnlis3DzMRwq5Tpc12f/I5h5Iq5HJK5
	TrHfEPqKVp7Mx6gagAuWkOVyLlipszdY=
X-Gm-Gg: AeBDies9ns8UTsbJw8BPksxRYTizBv0NzEwAHP4xGF54SL4yY+NrlfB6U7prrZGo+WV
	MetOXjucd+ERGw6htNrYtFwalhelS8qxaKCSJaAVYt97+/j/3GzLtRHvKTPznpG8LNJWJBj04Hg
	i+eBoPk7vl0SkrD4jwgaBUhDcuDGVCh75BgxxmUH5wcMzmWshzxTH1DldXqRcPAauSGnoPYmRSo
	mcsz/4UG51oPtx0YZy9liEAosz3DHUrDWDkiIB7Gm1PawL8CWF8nhpyn+TnWfF0wb7R1WU/fHdR
	Q74zN2qmCpYSp8W+1ToE9a350d1w28sDW8AdA4Yug1SWJ2EyCHpuZaveZwdwCcc4FFT7AFgVLfE
	N5niwNQx2HVc+P3RkkCWqYYU/4g==
X-Received: by 2002:a05:6000:2586:b0:43c:f257:c6fc with SMTP id
 ffacd0b85a97d-43d15049fd3mr14986480f8f.10.1775138613931; Thu, 02 Apr 2026
 07:03:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226085240.1908874-1-alan.maguire@oracle.com> <3da0919f-f8fd-4cc4-8e86-aa55604e923c@oracle.com>
In-Reply-To: <3da0919f-f8fd-4cc4-8e86-aa55604e923c@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Apr 2026 07:03:22 -0700
X-Gm-Features: AQROBzBasgf2AsC8zBYeCQj-zVL3P3HcSzo4m83GUp8nUho0cf5OPOiV1zncz7s
Message-ID: <CAADnVQ+C=XBhXasNNrwrq7Y9=p0RyoQ882h9+k+LkOB8BtRNMA@mail.gmail.com>
Subject: Re: [PATCH v3 dwarves 0/2] pahole: add BTF layout encoding feature
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, dwarves <dwarves@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 1:01=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> On 26/02/2026 08:52, Alan Maguire wrote:
> > A soon-to-arrive v9 series will add support to add BTF layout
> > information to BTF; this describes the BTF kinds known about at
> > time of encoding in order to support parsing even in cases where
> > the kinds are not known to the parser; the layout relates a
> > BTF kind to the amount of space it consumes via an optional single
> > element following the BTF type or a set of vlen-specified objects.
> >
> > This series implements the support for the BTF "layout" feature
> > but does not require the libbpf changes to support it; the feature
> > test uses a weak declaration of btf__new_empty_opts() to handle the
> > unsupported case.
> >
> > To test pahole with this feature, the following approach can be used;
> >
> > 1. Specify -DLIBBPF_EMBEDDED=3DOFF option to cmake
> > 2. Install latest libbpf with associated patch series with layout suppo=
rt
> >
> > Alternatively with embedded libbpf the changes can be applied to
> > the embedded libbpf in lib/bpf/src.
> >
> > Changes since v2 [1]:
> >
> > - Resynced, renamed kind_layout -> layout
> > - Avoid encoding layout info in split BTF since it is a waste of space
> >
> > Changes since v1 [2]:
> >
> >  - Resynced with latest pahole
> >
> > [1] https://lore.kernel.org/dwarves/20251210202752.813919-1-alan.maguir=
e@oracle.com/
> > [2] https://lore.kernel.org/dwarves/20250528095349.788793-1-alan.maguir=
e@oracle.com/
> >
>
> Now that the kernel/libbpf side has landed, I'm aiming to land the pahole=
 side shortly.
> We'll need to resync with libbpf when it is synced on github too, but for=
 now it would
> be good to get these patches in; unless anyone objects I'll do this today=
. Thanks!

Ship it. You could have landed it the same day kernel patches landed.
There was no need for delay.
