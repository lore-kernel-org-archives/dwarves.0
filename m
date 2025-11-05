Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2719F2ED866
	for <dwarves@vger.kernel.org>; Wed,  5 Nov 2025 22:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762380476; cv=none; b=dIzNbbyREjBbizJBh1Ob0KVUe0ZF7VunWm1MH003hURRBl5VtTEVQED81/JMHeCHpUhMQRCne0o26LJDFunA4Haqse8eS+I1W7IQpvETlaHK+2ftdtKK1m5C58XocgySTnyC3Hz+WPWqjrM2LPIrIPMtZT92xGtrSYEFsLBMj0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762380476; c=relaxed/simple;
	bh=5krTRkoMQzSVD4dkgq2VoRoFS4p0YotvMcCijGLNDL8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XYg9+e/fnjCRMM3Gy4jv8/J2ySzSJHsK/sI5aSLh5ZvEGsXhZy+4jMl5WU5XQ4H25cdVT1goWjYQJUbZeKJvw9HKOo4bvg3d3XcF8r44tkDlT6xhGILqXGQKw4K9ptcgEoaKHEsw6Z3F9Vtis8kda5eCojMancl3Xd9iV9z5JTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfLZkk5n; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfLZkk5n"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so339841b3a.1
        for <dwarves@vger.kernel.org>; Wed, 05 Nov 2025 14:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762380474; x=1762985274; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M2Ubau25FQKUQ99DQtgmPUMsvH7h9LKNq2dn1/ErqV8=;
        b=IfLZkk5nXFYwW2zpZC8YGJF+SA3i57u9HzPtHmkwDIj2mSE3Kmg+8Z4hjOOHOnIIll
         /kTBu2Ul6fLViKdB9JJQRsBJEocSvjyUHsljdkcW4LVYRy75gH/PYX11+yoKxWYJdtDt
         CPCkKorqfYnyTioB3xYLr/fAI++Yh82xmnE27YHqEen/AmjW6Y9JjspepiNu2YHRl4wz
         Atwe8negtjGlIb9SdS2b7txOHaBqaRmGeKd/ZJLjlwSfaK+7csDqPWl/ffmTpcKAkWkL
         l4FKWhi/vUL4+9igAaIckk0Aa7tMVCHZnE/9VjyjcHjxOBBfudHGklV6nTL242OJvh5u
         FruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762380474; x=1762985274;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M2Ubau25FQKUQ99DQtgmPUMsvH7h9LKNq2dn1/ErqV8=;
        b=r/s0EKhvXv0dbrRxo4KnNjX384ismx1T1IzKp+JWthCsQH1+x4jY4lwzI6BtOUtCEG
         M0wEbV3k5+Yl6TMh/i8B9ym4oaoHPNNUx6leXpnKNytfoQWx/ozDhfu76fOE/0Ll25J8
         G+fTn8XdMnq2cuU876ZhfJqsyvKrr1vYk1VmVXxCEGuK/YNfg9C6on80vL01ndGPUfPf
         7y5UyqGwMIawtzjt3hxy3HdVbr7KIoWtqQVy8pKisBtR80pSdgnLxtKZSzMRTXfZuJAA
         1L7AUq+wZvsINHTPJ2raLpeqJ23dk8m+hKO0OCdAW4nX+/PhV8zrhDEj24KZmjXIP/90
         rZLg==
X-Forwarded-Encrypted: i=1; AJvYcCWHSlT0zWSuNaDNb0AgmYEa+Qh2DtNpd05FQgF8N0Ahauj2Tz4OaP5D1j7V+viraHUHR/7bupHX@vger.kernel.org
X-Gm-Message-State: AOJu0YwnvAjo5GTbCQnyzDs1DZQaQlu5qR+BhqaACTCyMt/s+0phDSzm
	i02Fnm6ocCZ+wvKjBhQKfe2s2RTrWxA7f7QG3lqx2MvZ0iIYTBSw5ePd
X-Gm-Gg: ASbGncsxqPvp0WnM+gwZxZ6ac6zVd7/xTwBcvxdg1ssQ18WHyfXWyZARN1SbOwN9yqI
	+vzhdlGxiSPHyQCR0eNKkYBcLZ9S+hcOrd9ZlasmGuqJnMBbtt8gYAQ56LVDoka7NHrs7rkvTuv
	176eCF2v7KCfguESlLAejRq5JYyi5QlbBx9VpbYHOqssbkxoS+SeatGsetqahIaYZbjbUhGCOxy
	91KCLt1g45hKYIiGmZOr4g6t7imuzpgd0ElhcHAHQQdfEXheCVR0kSB0BjuvzqwsenLNb+FXm5o
	3/xhFI4Psd6TPR4KXwNXM3eqIontvSaEPTH7i0BrUxZWtLSmIrj9pP6dcK7NHhVb2DU+77+fw3H
	GXJnKWdPWUO7jj9AzDB2HTODgndphh0JJBflTclM2gwkU93QAf1+BRdHKDg/iCCQRJcvOh5cYXc
	Z10+6WqQIBRZpWEeOntgJYkCyU6JjSufNEffo=
X-Google-Smtp-Source: AGHT+IFdZOB0M+qj11LfJg/Kpz/HRb0u4801UcFyALDLujBt3wuysLdvfZewJByj820lfVxAXmPVMg==
X-Received: by 2002:a05:6a00:3e16:b0:77e:d2f7:f307 with SMTP id d2e1a72fcca58-7af706c387emr1294327b3a.9.1762380474262;
        Wed, 05 Nov 2025 14:07:54 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:cdf2:29c1:f331:3e1? ([2620:10d:c090:500::6:8aee])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af7f84fc12sm450647b3a.2.2025.11.05.14.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 14:07:53 -0800 (PST)
Message-ID: <5348259229fb7ae5b37b026cc4a403450cb3d62d.camel@gmail.com>
Subject: Re: [PATCH dwarves v3 3/3] btf_encoder: Factor out BPF kfunc
 emission
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org, 
	alan.maguire@oracle.com, acme@kernel.org
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 kernel-team@meta.com
Date: Wed, 05 Nov 2025 14:07:52 -0800
In-Reply-To: <20251105185926.296539-4-ihor.solodrai@linux.dev>
References: <20251105185926.296539-1-ihor.solodrai@linux.dev>
	 <20251105185926.296539-4-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-05 at 10:59 -0800, Ihor Solodrai wrote:

[...]

> @@ -1408,6 +1394,28 @@ static int32_t btf_encoder__add_func(struct btf_en=
coder *encoder,
>  		return -1;
>  	}
> =20
> +	return btf_fn_id;
> +}
> +
> +static int btf_encoder__add_bpf_kfunc(struct btf_encoder *encoder,
> +				      struct btf_encoder_func_state *state)
> +{
> +	int btf_fn_id, err;
> +
> +	if (encoder->tag_kfuncs && encoder->encode_attributes)
> +		if (btf__add_bpf_arena_type_tags(encoder->btf, state) < 0)
> +			return -1;

Nit: maybe keep the error check consistent with the one below? E.g.:
       err =3D btf__add_bpf_arena_type_tags(...);
       if (err)
          return err;
     ?
> +
> +	btf_fn_id =3D btf_encoder__add_func(encoder, state);
> +	if (btf_fn_id < 0)
> +		return -1;
> +
> +	if (encoder->tag_kfuncs && !encoder->skip_encoding_decl_tag) {
> +		err =3D btf__tag_kfunc(encoder->btf, state->elf, btf_fn_id);
> +		if (err < 0)
> +			return -1;
> +	}
> +
>  	return 0;
>  }
> =20

[...]
