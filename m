Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B13636CA8A
	for <dwarves@vger.kernel.org>; Thu, 30 Oct 2025 18:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761849749; cv=none; b=MAck1fMQPC/2dMUxP9hqIS1IBVVTzc7NILSSwINvfoYKsA9dI96k2nOVmq2c+nH9J6AnE1LIY5BTpoOyLQL0WCF8Oa8pMVcIY/DaLp73nLS0kT1c8c1OUeRx5D6LDsdtZnqudxKgVxaBsDohCr5Bzn+CbaunAWVOe82MsB2mZpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761849749; c=relaxed/simple;
	bh=fqtnOdojOdFfgjwtxnv71uAMW/0p0vRttvQJJj7ox8Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l9QXNRjtIVKRtQlDVKokBUT/j3AR3eHMXuLKJOPMmqHqqhCV/1guj1qKGSQfarE82HVz79cJH4aMegQY6iKXfc64wKW0o4wLrnlLwk0FsREn8qZ/gTCi0OUMyKJU98gKNqjnY0Z13LwjQsSqnhs6wux5TRjeLlGDeR9TuDBM0UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mr6yogZa; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mr6yogZa"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33f9aec69b6so1861252a91.1
        for <dwarves@vger.kernel.org>; Thu, 30 Oct 2025 11:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761849748; x=1762454548; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fwrkrZIUazJ7bwJv5R2Mr8CVBfe2F2MQtH76Kc4QL0U=;
        b=mr6yogZards/f+97gGCpQxv75Gfbai9BnLx5ecRHTldW644NNqJ7Im/2K+FqU8mtUU
         K1yGCHSrm/9uBDxf1X+kksYl0tijQH64AgYGanho6JU4tDv6YaKeW/lMhChWOMcofflQ
         itzvzD/hq1vsHXnPhN+co8LWMFNHrjTrJskC4WQkW29ToHVjfM/h99Fskr2412Ez6Fu/
         Bs8yFfA9+SWZ5dTHDu0NgB3Ko4LswpOtgO7nb7c4OlR1BuirilyBaUHTszq4vpWGwFr5
         TpWg1aCk+67/FVFFhtAfEp+zglWFa0jR2DSTWt3bWgeXDNE0z8Ni1x47GvGEthq358Ay
         bONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761849748; x=1762454548;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fwrkrZIUazJ7bwJv5R2Mr8CVBfe2F2MQtH76Kc4QL0U=;
        b=jpqUCMWG02EjJ95wQjaOmY9LQDLLvPSCKc8NbmvRfaSEVrHYrNoUEm8l/aqlbrOuFS
         MVP+FPu2n6tPeISkY/t4hW1IQIwHKPnNAh0o8foE7Wc12xMvrD7TI73hUcqcD56xQr/4
         59tpTI+RsPKwBkTJktUSNrLb95xaI78ruXsweSTvem5HlX5bNdW2UbnDMNQKwRrCW9Zd
         4lDDtmXUHFcFtn1/1YA8Vx5+Vs8MAzks3v0eIxHifWTysv4kZs3fpSV6b4QnTFXtqg5I
         ghduOnEj+XcIj/y3hQ8NY56kGiiKD3lQDfhJ8mKDWMtb/lPJ0aiUllmW3wwBqlEO3Glo
         QEqA==
X-Gm-Message-State: AOJu0YwHFoiRFrH/31Q4ONqDqr67ADiMUgbh/wgPUO6ZANu/HPZnLf/u
	tTrae7YgF8rpAGsSm42fi0lkvBQqLtfy2O8siVjYg8Ovxt6ughrMu5yO
X-Gm-Gg: ASbGncvyAg6nwjcBvmfaWqXRD4IJDoZpzwJ3Nb9OkEgaHR5xdF62He8+40lR+fehkbG
	syNjIoVCRszZKGHLkokrOr5ryKTotBRj4aoxssWWY2XF0JmZw961gV0059U6pyeG9oGtmOLgb9K
	19Ak0s+Q7qMh+0ihpJDRqU6zHKJ9QOOsvvKS6cyfkzkmnXjfmO1Ve9Mbs7pxT0UQFlCn7c3BX+f
	t7H8qART2DCbZ0Grl7Mlvo+nWalNhiRl0EvZXUh79JbpJ64+fthxOY10Kisz70vc8qKYAOfYNX8
	8PRY73TKD8ZvKsHFH9a43IZAvZiISNb1RE5132iYNhwmEdqXtRZQarLhZTsTqs6CMhdy1KOHBJo
	YGt+/VeoS3OUo5AeOWyzbEIvA9cbsIsv5U+mQ0ynAn3QiVQj3Wq8MzD7hzttNwfvVsNRanQ68UA
	5ioG+3eSbL
X-Google-Smtp-Source: AGHT+IEOmCJTpNFIXtxyOp5mwzIkcVae3pLCciRt7rZVx/1uKSxUgWjvR9oDLlzFVkUnfq1L5jZwPA==
X-Received: by 2002:a17:90b:530c:b0:339:ec9c:b26d with SMTP id 98e67ed59e1d1-34082fa950bmr1078051a91.8.1761849747632;
        Thu, 30 Oct 2025 11:42:27 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34050b9edeasm3349299a91.14.2025.10.30.11.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 11:42:27 -0700 (PDT)
Message-ID: <4558f35eb191c2605542b368f1dab4f69231ab8c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/8] bpf: magic kernel functions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, Ihor Solodrai	
 <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, andrii@kernel.org,
 ast@kernel.org
Cc: dwarves@vger.kernel.org, acme@kernel.org, tj@kernel.org,
 kernel-team@meta.com
Date: Thu, 30 Oct 2025 11:42:24 -0700
In-Reply-To: <145364f5-3752-41b7-92d9-c97437b95b9a@oracle.com>
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
	 <50ddff79d33d6e2d57e104f610273d647530ddbc.camel@gmail.com>
	 <99115d79a7808ca1290726561e36b64ec56e2a1e.camel@gmail.com>
	 <6e0b67d02cf7243b01a163589b3b58d1e4a0fdd8.camel@gmail.com>
	 <145364f5-3752-41b7-92d9-c97437b95b9a@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-30 at 18:26 +0000, Alan Maguire wrote:

[...]

> Okay so bear with me as this is probably a massive over-simplification.
> It seems like what we want here is a way to establish a relationship
> between the BTF associated with the _impl function and the kfunc-visible
> form (without the implicit arguments), right? Once we have that
> relationship, it's sort of implicit which are the implicit arguments;
> they're the ones the _impl variant has and the non-impl variant doesn't
> have. So to me - and again I'm probably missing a lot - the key thing is
> to establish that relationship between kfunc and kfunc_impl. Couldn't we
> leverage the kernel build machinery around resolve_btf_ids to construct
> these pairwise mappings of BTF ids? That way we keep pahole out of the
> loop (aside from generating BTF for both variants as usual) and
> compatibility issues aren't there as much because resolve_btfids travels
> with the kernel, no changes needed for pahole.
>=20
> I'm guessing the above is missing something though?

Andrii does not like having to declare two functions manually in C code:

  __bpf_kfunc foo_impl(p__implicit);
  __bpf_kfunc foo(void);    <-------- don't want to declare this explicitly

But prototypes for both functions are needed in the BTF.
And the only place that can invent new BTFs is pahole.
Imo, that's a bit of an over-complication =C2=AF\_(=E3=83=84)_/=C2=AF.
 =20
