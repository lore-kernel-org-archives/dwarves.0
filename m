Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A911E13AD26
	for <dwarves@vger.kernel.org>; Tue, 22 Oct 2024 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729621285; cv=none; b=CYjKGlUu3Y5sfDTFIMoleY5TaD+RrDsOa/upwqEJRE6ij4HXmXsiQuRCprxuOfkibrd/dUIuPXgJnawixFdvTGCU/mZxfdu1/eYy1AHAi20ERmh+ddHAWX+uBpx269/tkV3+v3ng+OubdBy1MVghZuxs3OkrE84D1dqsrbDJhLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729621285; c=relaxed/simple;
	bh=OSdmfSHULjFACsen7xgKTWv6R0Oqjj9AISMFcfxuvWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eu6eocP5gYWN1rZ2rTPtMpwfp5YaXHeVYSwFlVXOfY3s0cOctSm+30tuUi+bKJJFqIrzZ3hzsRs/Q+xcg3SlZcFBF7wzZjxAZHvV3CvxSY3P8Hd0bo4a8ZuVzy7C39p0rbFC3CVirsUFGftBntLeefUVBFSaoUtLniXvO5sCWxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMfFkAz/; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMfFkAz/"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e56750bb13so575626a91.2
        for <dwarves@vger.kernel.org>; Tue, 22 Oct 2024 11:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729621283; x=1730226083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSdmfSHULjFACsen7xgKTWv6R0Oqjj9AISMFcfxuvWk=;
        b=lMfFkAz/CuRGLBKBSCy+1cgIt+c5oF3BJq9MKA4glbd1kUbf8zyV7IFQDagO2cjmTg
         uekzivm4KAUC5KTLyUMHzZbxMiruKAvd/xU+kw52DUUQmEl6kog9cvR/WUfzCO+/YzMB
         sdmTTZkZrsWOMi1APz4AlvFiyR1psGS64RDoKwtdImIy/YO8pnb8BlvAK5cEQ5mOwhfi
         YZ3TBz67XZZYOdLUGydwqCKKhWc1UeZb//6t2hZ62b8l5ZdpuyCbv0wYTS5qoYIM294l
         ym7S2427nOf4QEEmIBNRvs0os8Lfu7D8PHKDwDgL2zXOZGB9NqYHOfV3hgW8mYvhudZT
         ALqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729621283; x=1730226083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSdmfSHULjFACsen7xgKTWv6R0Oqjj9AISMFcfxuvWk=;
        b=UpL1QsYt73AYYUU6eAF2TsHbQ4qo6f6jUjAne5SLimphTtcG9sDoNmTaH/ZDaT7DRe
         jYpMRvI/2PnvRRfBVVqoHWhT75V1r7P+Dq3f5QmhJWVUShnfhIrEVmjLzavrGNrc0sL9
         zyMz65Ba3EdDBH5UvaYvDrDjWg7MQtYSXVgnLyaUKFB5nDjKO503RxaYin/+bzDauV9V
         //b3G+0SC29UeT691GSPZAaOXIrYBkyqK2+GAkI7wBMiSAieMqm7I9zKeYHsc0BfZW7Q
         EzND5CCbiaNrGtOcKF5HKjD9z8DZE+RPn/9zZNARMp7DLL/J6ZZrUpUq9oa0b4S2nGaP
         Ersw==
X-Forwarded-Encrypted: i=1; AJvYcCUzhcQT2GjiyLiTsmOoZXDFqhBeh+Ykt5iREuCrRpZ6XXwBUsLTLV0c2+Op546p+mHrMzBmXp9r@vger.kernel.org
X-Gm-Message-State: AOJu0YwjJZ5Ypqau+6WISp03PTGgOrPgK+xRrpzWi8F5uqYdsyD1FVNN
	IrcsMBDTc0lI8ZqzRagSmtAZf8D0OPk2mB5UHXsoWv+D7eZQIZK1ZI0A3bA3hG3zGMMvs+tVewE
	n4t0eaWHVBRZF8HS3z2zl+iV8c5Q=
X-Google-Smtp-Source: AGHT+IGTP9I/30hrnHXf6FTliwhH82vOp9k07V/qazdxV0xD8c0qCnQ8YAIbaJuY02OBiNH3wtJ8cYM/a5YexWAa9wY=
X-Received: by 2002:a17:90a:a418:b0:2e2:b20b:59de with SMTP id
 98e67ed59e1d1-2e5616e8789mr7893446a91.3.1729621282374; Tue, 22 Oct 2024
 11:21:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018094301.1550149-1-alan.maguire@oracle.com>
In-Reply-To: <20241018094301.1550149-1-alan.maguire@oracle.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 22 Oct 2024 20:21:09 +0200
Message-ID: <CANiq72kMif-BzsNwmh8WpDgc_KohxkHZA2=+F6RjEKV+j8TnmQ@mail.gmail.com>
Subject: Re: [PATCH dwarves] btf_encoder: filter var names before btf name check
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, ojeda@kernel.org, andrii.nakryiko@gmail.com, 
	jolsa@kernel.org, dwarves@vger.kernel.org, stephen.s.brennan@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 11:43=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> ...as this means we avoid seeing multiple messages of the form
>
> PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (=
sym: '__UNIQUE_ID___addressable__RNvXsa_NtCs2vSfyxKMEZc_4core4charNtB5_11Es=
capeDebugNtNtNtNtB7_4iter6traits10exact_size17ExactSizeIterator3len57').
>
> Such symbols are filtered anyway due to the __UNIQUE_ID prefix, so
> warning about them is not necessary; simply reordering the checks
> should ensure we will not see these warnings.
>
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

FWIW, I applied the patch and the `__UNIQUE_ID` warnings indeed go
away (but I don't know if those warnings would be useful to see/fix
for other reasons):

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
