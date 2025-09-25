Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95062874E9
	for <dwarves@vger.kernel.org>; Thu, 25 Sep 2025 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758793999; cv=none; b=nkRE4pJjOUkthV8VY6kc4bJHKWsN0j0Qbab8hJ5j61NfeuTmVb/2Ft1Cn+pG18JNZNJg1WR/7jDE9Dgs9f8r+K7wkvwuqRFertPfrRM1TSFXsuI4kpZ5AUH38vmLgrgOQIA9wlT7xADzNYF6q9gpLIn+f9r/g7SKC8le8o8pLpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758793999; c=relaxed/simple;
	bh=lu9Tc9pURgZ0381dUEwXBCbkX3e5TEeN4qRYRoLV158=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aldyctXvQOomN8dbRIqDDjSijWGQ5ln9fNAWUSGQrwlDC8lqhcIFQBczFu2uNzfvSjJMTrZx949WxwXYVSpMVjMVs4HUerp81z+kjnGl9n2GSkogsEdBFWVHftanCfJfeWCHBX1NFa4v2gQqp9xtT06lpOnfR2S4o4qTkyVYFbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHklCjot; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHklCjot"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso469343f8f.2
        for <dwarves@vger.kernel.org>; Thu, 25 Sep 2025 02:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758793996; x=1759398796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZcpU2w/VB5YKX06iIgQfBUU6i35jTYfqMGO23xOBP4=;
        b=UHklCjotzVCgszSSsq1v32EDLcxKlRu4szU1a2b3oaBr9pZhVGP0NIOY64YBiSGtzQ
         H8lYKnwa1VzQFAtLSHuTZ6/sBQ9II9ThxzRy6kBMWtokey5FALe2AxmtQfgiI3b7CRZA
         +EsbO0lIzzsSTEu9kL0peL068UUyjUSflva/xP0G+oYhQVN7UcP9PILSimUf5DbdgW6P
         T/uLENxBPymw+kq5ZNQzlitN0miER0HWXlhE8uco4YU/E9zDR80guRW5h+tlRRnMcuc/
         yaAPZc93j6gR9Q7kOpVlojdVVj8bLun/Ta4geqfG0mR4SP6T8Z70ZesYD2Hn9WzGEOSP
         0I+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758793996; x=1759398796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZcpU2w/VB5YKX06iIgQfBUU6i35jTYfqMGO23xOBP4=;
        b=PokTR/CTCDRvFEB/L1CilJASik4hKIToWZym7RGxVy4ThRANswdjWKTbK0vdmWbk9d
         llwUnFiNrRHvz7H/nRnSsYKCvJnQx0rKeqfdAYqbmN9WkZWnnUW8qqVwzcF8gQRjuEWe
         /6RwN4aNDZeRmtBzp/E5W9smSZ1Y8hA7NYvZi81fq2KD+2pcynkQ3zImNqE6oKkVRdow
         Gj51+O/WzyWWsNua2F2kqwsekKD86hCMLWc+mneJzlyBEM3GEqnY2Bzg7aY5ykoFC4vk
         k5/R16Hg2PfMHjcOW1J/cGhIr6hCXEe6No5ei99KGRAx/zMqurv/a9DjzCkJ+EoSotMw
         cSGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdHLq9+7+1mkg15zcobwPtFP9E8WQbxQxoQiFAKLzk1Xv/Rjyui4E5IMze4P7FtonIhcnpnWng@vger.kernel.org
X-Gm-Message-State: AOJu0YyM1rLEVNzgRZshWDMCrU+I1diQNnkRCiZ5309CnLwdvo7jmfkn
	4UJLNTl4doFvrh97FcythK23x5kt4B3f6RcXasCrTfChudNU4wRhNa5N5A9IhmY4MsywCsalxNL
	wNQd9Rv+OIrraqCrR9uG+eAgQxciZflA=
X-Gm-Gg: ASbGnctLiIV0YOi0cXYwjVO//Zt5DP+Q3oN9kYBZDXNMRa2Hr3F8JDbMP3reBDdbKml
	0lCMOWm5ZAnuZErfd9Z+DByBvpzXYz/iyuKZ6RoF83+hZhx7BWF3YaIaoMVl/B0sAB5p8JnFqJ/
	29zeB7VbBeLgvQy9pMNN6lX8fLMkLUTSN0bTeNBL5unP6EPU3p1IHTTPZIrZvqyFScjf7djE/8f
	4WghlrqkxfXZiWG
X-Google-Smtp-Source: AGHT+IEmU8rnXWa62/3qZo+R7CiKruEkD4ZCa9MZ8GPj2WiUPf+P7ttT+U2icSZcwgkOfcyw7mPkVrfynUcxItvgZY4=
X-Received: by 2002:a05:6000:25c3:b0:3b7:8da6:1bb4 with SMTP id
 ffacd0b85a97d-40e4accc86fmr2650916f8f.58.1758793995865; Thu, 25 Sep 2025
 02:53:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924211716.1287715-1-ihor.solodrai@linux.dev> <20250924211716.1287715-4-ihor.solodrai@linux.dev>
In-Reply-To: <20250924211716.1287715-4-ihor.solodrai@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 25 Sep 2025 10:53:03 +0100
X-Gm-Features: AS18NWDbLB5YJC0TDfFpCPIYOHpFNKW8roC_ShfUbE2jyM3iqoVhOozM0foMtQw
Message-ID: <CAADnVQLG1=xr9OWKZna0hjfswZ+pZ8RM3fAtsVd+aYW7xaFFcQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/6] selftests/bpf: update bpf_wq_set_callback macro
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, dwarves <dwarves@vger.kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 10:17=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux=
.dev> wrote:
>
> Subsequent patch introduces bpf_wq_set_callback kfunc with an
> implicit bpf_prog_aux argument.
>
> To ensure backward compatibility add a weak declaration and make
> bpf_wq_set_callback macro to check for the new kfunc first.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  tools/testing/selftests/bpf/bpf_experimental.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testi=
ng/selftests/bpf/bpf_experimental.h
> index d89eda3fd8a3..341408d017ea 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -583,8 +583,13 @@ extern int bpf_wq_start(struct bpf_wq *wq, unsigned =
int flags) __weak __ksym;
>  extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
>                 int (callback_fn)(void *map, int *key, void *value),
>                 unsigned int flags__k, void *aux__ign) __ksym;
> +extern int bpf_wq_set_callback(struct bpf_wq *wq,
> +               int (callback_fn)(void *map, int *key, void *value),
> +               unsigned int flags) __weak __ksym;
>  #define bpf_wq_set_callback(timer, cb, flags) \
> -       bpf_wq_set_callback_impl(timer, cb, flags, NULL)
> +       (bpf_wq_set_callback ? \
> +               bpf_wq_set_callback(timer, cb, flags) : \
> +               bpf_wq_set_callback_impl(timer, cb, flags, NULL))

There is also drivers/hid/bpf/progs/hid_bpf_helpers.h
Pls double check that hid-bpf still compiles and works.
