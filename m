Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D326B3E3144
	for <dwarves@vger.kernel.org>; Wed, 11 Mar 2026 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251538; cv=pass; b=a3GkbFHVTLLWMM5oKXHBARzzP27sw3nPXU9lDsC3tp+Y5LZ8KYLgzQICOONdwTmuU2LZm1zWO7gIXSKxw36vS2HUk7eHc/RIycN+eHZXugl4UrFZ96Lhi6FYByXgFNnrJpoo0jgxMY+oFiCOqDfvRrXBILd436Zpz5U3R8OnNWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251538; c=relaxed/simple;
	bh=vMpReo10GUnLpPyz/99nveri6JI8OFWDwKYxJmDwRao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=co/FuhQ6jBMxzs+79+IWENnTi1d8hlXt0FuvjJB/b2XJX0wMbd0B8RhN338uwckuNbROoEZWDYWjCf+uPYvFLBG/iW4ZgTtu1icwPQKRooIsXEuXNzMZWzdl3X4qrcMo9FT1Ja+1mcjQ62MwU51erS4kWR4nTjjOJZiWIOF997s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Do6hQU7C; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Do6hQU7C"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3598e065d8dso53364a91.2
        for <dwarves@vger.kernel.org>; Wed, 11 Mar 2026 10:52:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773251537; cv=none;
        d=google.com; s=arc-20240605;
        b=VP5WqiXfLuOcfU9nrY42u8pLfSGGFklq4GVoxQEIMkOt1afADvpmuMQfHFEdrRBc1/
         za//MsG1t4Ph0+JQwV/n9/sPsC+HrvEje9Sz82O4GIs5leTtl/7mLbGGIdQNti6VwJiC
         I1UisS7PqaIgm2EzQWHhM7YJfFcl0hgK7CHkOSyHEfCvG3CD//c8AeaTyVkXincSfWHY
         TypVE3ECJps5fQzVCDD89TQgMB/GL90iNIyOdBxCF8mLMEPhOXO3/k71wRcnkq+IaMY8
         asjfC36fUgsHe8wE5BZ/KyO/SRejufhovWqonI7ZsZ+ZxQTSfyiccEjthAXN0k2JSpBw
         mbvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FdI9Exj0v8OQnm3T+xWDMFtUnbuu07xMkRoM7mEsgJA=;
        fh=uHXe4sJ1bIrb5rZ3Nh/3VK2czCbpnCEYyN17fgq0Mcs=;
        b=G8y84fISradJzXTJreDc3UqQKh4o+jHw0QCs2JN0LVwwmskWkSZTiMwXKF6O4Exw5H
         vMTOmiYEtRg5UvV7zXK0cDgLMtQFQEAvJTRvl76xMH06X7DhSnHYmsZeKQRFyP/eOcLh
         aLWViBlaejRgR8d8E8QnVXnEg+rlrxnyFyeB3KqkNp7SBZUt/UEp6IpRn9VsDB3nV6I1
         radXAes2Fl53Iyxo6fpkTe2Dn90f6cB6DHqY4aqpDr8oJLmLYhvqQ/BWxTbVRVHnkT8d
         13k1nP4QO/IkfdvS8KlguXcYJECNqTBaPTe+qLkHUK5fIwsuvyYPHD+I+jyanMBs3GWh
         fhiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773251537; x=1773856337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdI9Exj0v8OQnm3T+xWDMFtUnbuu07xMkRoM7mEsgJA=;
        b=Do6hQU7CfyiZCiIHY4bmlLbnLxwan0TfLdn2Zq0htzJ4O0GNXIrcmy08irE1ecXuqj
         9E5xibKWJOd5E2UCV6BJo66ZpIkjYYnPU7YfFtStxQc7ti+7GUmukzkD/K7pDoZIYkO7
         r4XGHEGx8gXktKPCX/VRYToNOcRu//cyWPB7/YP3chmYdIjAks3YT7H6UlY6vSBbQ5fj
         eJGovS7NXELIEx7YqX6pTFyyqk+/h5CFzGk2uJFFRxg3/qddubVysiUbKr+HqNjwgva0
         kFzZlJ8hUz0XGxKfc8zvqnQ9WnEgCEaVxbNbnzImtfn7ePMpNjtgARpaMhbBfc+uRC7M
         QnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773251537; x=1773856337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FdI9Exj0v8OQnm3T+xWDMFtUnbuu07xMkRoM7mEsgJA=;
        b=dgX/T2Xf3NMbLPACYLpe8aOKRb1WMhm+z/WAEjl2Fz4URBiUj6MG/z3qWDxjG5qZwb
         pKsE0AfuAl0I9xSAKltNtqoAEZH955te3mzkTRgcGmA1xT8THxvsbOHipOsX3GTOsun7
         4wESNQxqs4/amjMDuZnsS8beoVhwyv93f0d3JgnmegS9hxSeJOG/QGbticvkGBYPM5Ez
         nx+b8YXW/0kue+5a33n5dX0Hvx7qIGGtknb6SCx561d/3PEBSsCy+WybgF52QeHMdlWv
         L8Yi4k3WDcRPXkkKKaRjs2kghbR8iREC9F0P3VXSH0hYXbKYoYWR4ixitgH0HSyNBx8+
         kYcg==
X-Forwarded-Encrypted: i=1; AJvYcCWTFVOIQaXb23tjpNYaukzFSLEgUY7NcP1dTEnyTyQZnN+mSbQ1Tw4uQu0Y36MAZBMBGuG5Dksv@vger.kernel.org
X-Gm-Message-State: AOJu0YyjBVlq0B7Phncj6VQ8epnuvD4Ot/DFcdx6LZMB503bgU98FOcL
	5A8DKcfKJd8jLL9vRp6JSG3MmvhtRH7ngQ7IObcmRHYJBfdHBbEE+qWPHdtsMRO3XFLlBz2ZwTq
	OSUQgp88fBL5miLBZsLGg8I4Y9J34moo=
X-Gm-Gg: ATEYQzyzrWrkFeOcQ8QO4WjBnDP8+U1Rkvx46Sm8+9RAh1CunkslzDs+xszyfa+0fbS
	H3J+b34VtuozLwBqg/Iz5uCybXkc4K0B1NWlhix/dh8fakPAI6aIyPdrcgIcM1POujw1KUcDtRo
	+MpopdvmV3H8ifwjJQqCG8awIRMiH4K54Hd6YMmMcr0W8NHMk2GqZ4ecKBsnjPQJfxefMw4pkiR
	3TWQ1wktNjFjhH2nLIu7r54f9PYZZR/V6lPYlTJZVqCXEkI4ccE/V2JAaIyltkTObmBcRRrXlzZ
	unguZus=
X-Received: by 2002:a17:902:f60b:b0:2ae:b991:a44f with SMTP id
 d9443c01a7336-2aeb991a833mr8434945ad.50.1773251537290; Wed, 11 Mar 2026
 10:52:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306113630.1281527-1-alan.maguire@oracle.com> <b8ec9336-5204-4b1f-a7bf-995858b22b18@oracle.com>
In-Reply-To: <b8ec9336-5204-4b1f-a7bf-995858b22b18@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 10:52:04 -0700
X-Gm-Features: AaiRm53N3m_FOpJqyt3YFy_5DszUqVFYLox_su51bOe-o1h2In5UUlb7LuXacFs
Message-ID: <CAEf4BzYgArb8DhgNdOikPYSqCjYSasmT1TA8d26=WSk+aPWFOA@mail.gmail.com>
Subject: Re: [PATCH v13 bpf-next 0/8] Add BTF layout to BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 10:35=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> On 06/03/2026 11:36, Alan Maguire wrote:
> > Update struct btf_header to add a new "layout" section containing
> > a description of how to parse the BTF kinds known about at BTF
> > encoding time.  This provides the opportunity for tools that might
> > not know all of these kinds - as is the case when older tools run
> > on more newly-generated BTF - to still parse the BTF provided,
> > even if it cannot all be used.
> >
>
> looks like patch 2 needs a resync with bpf-next [1]; let me know if there=
's
> any additional feedback and I can roll it into an updated revision if nee=
ded.
>

please see my comment/question about potentially truncating btf_header
(internally) and how that situation should be dealt with for writable
BTF situation, but other than that looks good to me

> Thanks!
>
> [1] https://patchwork.kernel.org/project/netdevbpf/patch/20260306113630.1=
281527-9-alan.maguire@oracle.com/
