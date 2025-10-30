Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7402B17A318
	for <dwarves@vger.kernel.org>; Thu, 30 Oct 2025 00:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783381; cv=none; b=GzRQtAEDpGd1RsgF/VQx+vJnVYjN5jX6kfOD7JjxFoVtp8Ioy1ZsftppN6K6DzX1zXtlAbJXAqQE9KTqAIasVUYDE1jBYteQRIy9h8a+3mURv5Di6lsRQFIuKwXlAAqv9VNEheJYDfVRlbbqs51F8q0sYM0SeDIX/VKoTI+qyG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783381; c=relaxed/simple;
	bh=lkkYvAfGJyHErUCtLY2pHZe5NAqZZAtOb5uiVNeM6TE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XJ8gafsoNCLBv4FpNgt8ItiJTttt/4yq1rr1iLaEk5nlFYbcm1rb3kifJ6wm/z+zbTWHZydL6hPFLd0cKb4WLY09ED8nl6976WGjsaIS/eCWehjFJEpd4pcBM4F1JkO7C6zmbmB7fHa97dastYgDKalvnl1JhZj6kEunu21TeDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zzfc9pkO; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zzfc9pkO"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77f5d497692so677701b3a.1
        for <dwarves@vger.kernel.org>; Wed, 29 Oct 2025 17:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761783380; x=1762388180; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=msuM7kcIsqN5uFPie9riIUGHCFzbf5VjirHQu/5O5dA=;
        b=Zzfc9pkO/MSLJn/tAbvAFdT+4SIAsjRLFKldRI33ISdo3jKT6919RNOxmoxjHDM3+S
         y2wxCdktGShMV3se+xdNBDXmbBmWC625dsk8aAqrc5/mLZAcmYbgsfKCwmGL7q59pdNh
         3WmfFx5nOqvu5tnDOuSmfyr+pfL5wDTec67/tEcCyDINWXCAA7JFPVrs/aENGlJo+8YK
         o/ltYt8G8z5HPfi3p1IkyW94zCSgQaaZYi1gh2zKnA0Mp0b5WuVs3EuVKfo6jKOXGrMX
         YfZ4B5OnzJDrRmIB1Oz8E4koMIxyvCPsF8nL/7TosD6xvk0v56uapEE657//gsQaMhOQ
         MgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761783380; x=1762388180;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=msuM7kcIsqN5uFPie9riIUGHCFzbf5VjirHQu/5O5dA=;
        b=RS6GrN5uKCqVslS8eNt9wwy39T9Vu7gWPgH8MErlyumsNautnFUQppVdNb5j3QpdzE
         GSbfVTO8XqiUVOfEV5tTpei7zdL6reRl0G8lBBvWeD0HftjEoZxINyClzNrRKbt7x2z8
         9n6AfA1pOvsq2BHUlnvr9ECit0tsy05r8u8+RxVTF6MIAXM0yU5nhusveyIK4xBBJm0/
         REBuYyibu3EQKvgC8/NbpUicNWFqyJY56MC0xTczAxgRYqgb9hM/bawWm9gYi6BmV245
         vlTn8uyVTAreyKI/IK+XBYOm7S1Hct+Fn3EJVkZ8G8mhUMrk9uuW6bhMPFR85CLmwixB
         gN9Q==
X-Gm-Message-State: AOJu0Yyf5TBUtLYfyfGJG/QqYJbeKOyVyovUoKwaVGGoWVXY1LoTQB3w
	sY0AnIK+nwQYfaTfDYUUGRBboZIUnb3B5PFqIghLgnYaCtlL1AWdENWD
X-Gm-Gg: ASbGncsk1jlatQRaNr2ZH1YnX98+w0wb04fV73+zf9XAkF8njAP2q2qeTHhYIL3zrS4
	8OYTB6yGxj3iYZNnG0uovS0Ln2CfDce/3M8dY8s0SN35xKadKwEhfmqNnBbykyCMddW0gKikPo7
	k6jVAhC1AW28oc/2w3oaV9H3lxVVPhBJ0LS+CYC+4CsG7owMP2wmwo57jEXg0qfi72baa6QtzP2
	BNUL5cCRqUntioIEndndYoxDuaWRHfVUQCQps/pre4rMckFUU5m4oI27BohH4XFtI2/FtJobPo3
	0d26DgnSst8UDxRh4zRW9uV8nwV71x106YHv/lwr5N0E+LX0/XkDl+8yJNCqjvf6jKO0/Dc2Fge
	1Oo5lUOEvmXL/hqui9dBEo3T1iaRYXVIhpwH2+plLUFYWL6pBtxPLz/wvq4bq6fFl0j3r8tpvuW
	7eS/trRzqwRB4JPm7EwEdkKHveNg==
X-Google-Smtp-Source: AGHT+IGYNCGnTE8vldzzzwfa8aWZAFdxGb9LI3wHfrcY6NJc1hj5Ms2gdLFdB5J+/1Q91lTKZZou9Q==
X-Received: by 2002:a05:6a20:3ca6:b0:2e5:c9ee:96fa with SMTP id adf61e73a8af0-34786a1ea4amr1488329637.34.1761783379640;
        Wed, 29 Oct 2025 17:16:19 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:3086:7e8a:8b32:fa24? ([2620:10d:c090:500::5:6b34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b712ce3a6efsm14732052a12.24.2025.10.29.17.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 17:16:19 -0700 (PDT)
Message-ID: <c03a5ebfadf924be0ab0679a48d33d323d7ea7e5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 5/8] bpf: Re-define bpf_wq_set_callback as
 magic kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
	andrii@kernel.org, ast@kernel.org
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org, 
	tj@kernel.org, kernel-team@meta.com
Date: Wed, 29 Oct 2025 17:16:17 -0700
In-Reply-To: <20251029190113.3323406-6-ihor.solodrai@linux.dev>
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
	 <20251029190113.3323406-6-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-29 at 12:01 -0700, Ihor Solodrai wrote:

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 67914464d503..3c9e963d879b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[...]

> @@ -12916,9 +12919,10 @@ static bool is_bpf_throw_kfunc(struct bpf_insn *=
insn)
>  	       insn->imm =3D=3D special_kfunc_list[KF_bpf_throw];
>  }
> =20
> -static bool is_bpf_wq_set_callback_impl_kfunc(u32 btf_id)
> +static bool is_bpf_wq_set_callback_kfunc(u32 btf_id)
>  {
> -	return btf_id =3D=3D special_kfunc_list[KF_bpf_wq_set_callback_impl];
> +	return btf_id =3D=3D special_kfunc_list[KF_bpf_wq_set_callback_impl] ||
> +	       btf_id =3D=3D special_kfunc_list[KF_bpf_wq_set_callback];

If insn->imm is patched in add_kfunc_call() there will be no need to
handle two cases here.

>  }
> =20
>  static bool is_callback_calling_kfunc(u32 btf_id)
> @@ -14035,7 +14039,7 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>  		meta.r0_rdonly =3D false;
>  	}
> =20
> -	if (is_bpf_wq_set_callback_impl_kfunc(meta.func_id)) {
> +	if (is_bpf_wq_set_callback_kfunc(meta.func_id)) {
>  		err =3D push_callback_call(env, insn, insn_idx, meta.subprogno,
>  					 set_timer_callback_state);
>  		if (err) {
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testi=
ng/selftests/bpf/bpf_experimental.h
> index 2cd9165c7348..68a49b1f77ae 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h

Nit: The tests won't fail with the above changes, right?
     If so, we usually ship changes to selftests in separate patches.

> @@ -580,11 +580,6 @@ extern void bpf_iter_css_destroy(struct bpf_iter_css=
 *it) __weak __ksym;
> =20
>  extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int fla=
gs) __weak __ksym;
>  extern int bpf_wq_start(struct bpf_wq *wq, unsigned int flags) __weak __=
ksym;
> -extern int bpf_wq_set_callback_impl(struct bpf_wq *wq,
> -		int (callback_fn)(void *map, int *key, void *value),
> -		unsigned int flags__k, void *aux__ign) __ksym;
> -#define bpf_wq_set_callback(timer, cb, flags) \
> -	bpf_wq_set_callback_impl(timer, cb, flags, NULL)

...
