Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC1B30C34E
	for <dwarves@vger.kernel.org>; Thu, 25 Sep 2025 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821095; cv=none; b=u5MQM46p7LqxsTFhlqNKRFKLPf0KhTMdzi+Ex44wDLHl19NgId3DkUwrX0sg/bCUPp0+8YaIZIoHVo3QCixiYKLUxkmQ0rZWB3GObIceeL6P3+T0sU9a+L/XVWxmQknxZMWd379lOHw1m4OateSXuguaT9O4S4u5tr3n6UjZcIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821095; c=relaxed/simple;
	bh=uic5NLXZ3Gwk6TwZghx+l81X4gMVRQfY7RrGNWUQ7Sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auXfI6JZrGuBUntAPZEEJv3MRHFcxFpdi1eq0kBmMYa2ehBLPnq62u4Xsj94/2kRcjc6FqTMiyw5y7hQ0vAIbNjBN2E9sWHwkLGdNSoIMFwYWJ3UedlooX/FyDuNfaPZCMaPWkzSHqc0IPJ0VDZnbIFvuMiL/KL1kQ3XsrTzTmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyCSQdQS; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyCSQdQS"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77f41086c11so1214283b3a.0
        for <dwarves@vger.kernel.org>; Thu, 25 Sep 2025 10:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758821093; x=1759425893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qGWEFcKf1Q/BMH/xe5kNdjXU907WuDD9TQHcEONvz4=;
        b=RyCSQdQSZTqQ0YP26TUxX9cAZt0GZfWmVzcsg/6nKyLw/03GHFvWvwxWSqQO2Gu9y1
         tBMUCPDAt3JjP3VKXyKxmWdwJZtFW9quO+q4MffPo4FNVqakZT9L1w5Hkd9VnLD88mCM
         41wXaNW0XXRMdtqQeojdQ8EkPxSQJ0hRsnyX9TwnuuyE2EIq3Oy9hhlmm85OuktSHZ4Y
         v5hC60uc/Bk7Bd0gBDsfxCwuEd0j1lFone9ONp9RWHUYN8Q0HMAuaaEPkau38MiedbdG
         IljEJAh9J6SqXFjHatvVN/QamYoCUFh0fiL69yAOBgysOdvoS94qBEqWNRrkEzdun3GN
         osrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821093; x=1759425893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qGWEFcKf1Q/BMH/xe5kNdjXU907WuDD9TQHcEONvz4=;
        b=V/nN3QAFfQgVAUhjJQp3rdhAGO/0SN5+qRYHeZIChQD3ppY4qmVPLI3ZXUqyHeHdYd
         oco0OJQdhZPQ3kV6KISM6EmEDpc7bSgWo54iRmCkPWH2JHaDl8Rjnil6UKa7cKvjSOGA
         KTQ7c7S3tSckXeHwQWqBLufLSGOTFsgkXgc0h2fa+pt2uCy8YQHwEUBTyEr/2gAez2nh
         d0tSR1/Gun4IWX1reADT4O+oXemd9emC/2jWZv6hK68l6DMxJD/SbrZlZLfNl1EHCdyH
         1Nal1Tfi7rkEqNJGJmVdZduK/nLOvLyfS8mTmlnd3h+jYdyGsZsQyfT5mEnJsClXkG/U
         vzuA==
X-Forwarded-Encrypted: i=1; AJvYcCV+pVctQuLzTj1brAMQnuc7vDFROfA2HzsvVhmpSFiUyn79lssCBX6sKQUPrvDyuYEnNvL28Vc6@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk+N5N/HiMw4DZMG+hTHuoRcfh72N42G81Cu2tog7buUkfj34m
	wVKa2dIXMIK3J7q38JCZXla1vHjN+vjfz/zkvBIFo64m2mpn9q7CMi9CmsR01BN5nPAh9lTEaze
	YA+kdaNm8WWcx9pSMFucdtGiQ4rpDX8Q=
X-Gm-Gg: ASbGnctS/RDgwhayg/rYT/q0W0AXqOefBJVQrSByiHh35cNrH64TrMAXs6EnDTIBJRH
	GGag+dDTqche2ksvaBFVuptZ3kk1aPUcR6MxDdmq8WZH+xSCkmuL+G7NnWolY3jHV6xBASRt1CP
	AKT6Tm0JrvLao3L658XDdB9BiQxVP8QysjPGe4Yj5UotoKOLM3LHW8V17G/GjKLH66CbTKHMGY7
	FMOspjzcsXffW09go6aGrE=
X-Google-Smtp-Source: AGHT+IF1cmY38iSiCpyQnw40ZuYKLljDr6khypvNT+srsTL/4Xar1WHSbWp2jzFJi25Z8p7njhvgPwEjacIHTL82YmM=
X-Received: by 2002:a05:6a20:6a26:b0:2e0:9b1a:6425 with SMTP id
 adf61e73a8af0-2e7d37f2c7cmr5674507637.52.1758821093555; Thu, 25 Sep 2025
 10:24:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924211716.1287715-1-ihor.solodrai@linux.dev> <20250924211716.1287715-4-ihor.solodrai@linux.dev>
In-Reply-To: <20250924211716.1287715-4-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Sep 2025 10:24:39 -0700
X-Gm-Features: AS18NWAPHXouIW6u15vmyeweW5NUjq0Wu_ulwmAdbjT6wmZjfyVCKaCsh-JWbeM
Message-ID: <CAEf4Bza+fdzaPnFs-NWets5TA=80TPdaiydDXo-ykO9OdD_bvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/6] selftests/bpf: update bpf_wq_set_callback macro
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org, 
	eddyz87@gmail.com, tj@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 2:17=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
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


use bpf_ksym_exists(), it has additional "fool-proofing" checks

> +               bpf_wq_set_callback(timer, cb, flags) : \
> +               bpf_wq_set_callback_impl(timer, cb, flags, NULL))
>
>  struct bpf_iter_kmem_cache;
>  extern int bpf_iter_kmem_cache_new(struct bpf_iter_kmem_cache *it) __wea=
k __ksym;
> --
> 2.51.0
>
