Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C386337107
	for <dwarves@vger.kernel.org>; Tue, 16 Dec 2025 06:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765867890; cv=none; b=GTCRRp+o8XOqfgy9wRlfj/1XDQfoK4f+fFJ8SezaX21BpWctdD3ylvkEj++boYn1rXD3KuO0ajiObb+5Jjy5n2uW7mIOi39G7T3cen2lA86g8Z4RBcCfWTzmT34tVAvYyE5M/U7pNurHOT63yGjPtUUrohdGete2zJPZDievFp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765867890; c=relaxed/simple;
	bh=o0kU/Nr1TmmImImnf9Iz1JacdKj7mtXAIX5NghTd5c0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j8Jdl/dcwbnTsD5SxyW01GOJ+Tm1aztJ7zvoM0vsFQqtrtl4bu15Vm0aSZ/fxvU4Wtr6rqyMgpIKILSWREz/9FqAO8c1whzUY5ye/nkebkPUL6GWQl/VCAOJmQ+b88ujZpoxbi/ZP3vrG61QjSiTJYrE87AuMSpgMsAcko1tSnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbL6ObM/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbL6ObM/"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7aab7623f42so5063033b3a.2
        for <dwarves@vger.kernel.org>; Mon, 15 Dec 2025 22:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765867878; x=1766472678; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y5QrcSQj7JAbNrFLpgKo6GO8x5j8W9VyOVwKxdYcyrM=;
        b=IbL6ObM/WMRxl/zF29uyflKoS10V1QZwmjMarMaZotovRb2ZhAaUUR6p7ioA+YWWIh
         /XrdoC4wwJX8d37scYryVTTxcKGul0zavWpcIO250jwEMrrKpGLVISfaPlRLw3nyGFJC
         sH6RSgzpEbjJT3gz/gH/dHQDvpl5ZI07ppjBbOOVhkRMbkWcHJURveXam2ut1on87AX0
         rDsXk0/pDbLjVmNn+AwrEJfMy3BI2GSvFBAmQlNPEfPsBu/dSI+6DjS8eMHa/vDYBWgp
         sOWvp8TN5i2FFeVQm01jM3cl+TDyRNkhVK5BVcfsddVWhIqQQkaK9eaIHSIQEKR7ugN8
         dtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765867878; x=1766472678;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5QrcSQj7JAbNrFLpgKo6GO8x5j8W9VyOVwKxdYcyrM=;
        b=jIna86h6TYxKjpotmrO5UXcgelDTNlgixNN3PJF9GCQ/L0HjVJEgD5A+kwaq9P2vu7
         PcHPPqrEJtVYl3Gl78ibC7ictyfjMjVSXXAcn4VHgH6b23zq2rbPWc1LC9ri7QxkXn2B
         b9gHvSVRrRiwUQcuBvyESCwShKFY8QkLjzh8pSa7zzfPEjtzqH1SNJPEtY1a4HgMFDzo
         AfWGO1AhS/zgf+YJvtMk9BQH5fYPA2N/XR44e1LgdW7Mcc7QeaLKtTYrlLzLMt/jT5Ul
         UC34dLJ8Ah/zSslLWFI8EA62KP5pk0w4QuNP1Df1j2KmfCz5Kecf3SccXaQz+bD6emiI
         uTrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvmcH0EvaYbgxBOaf66/cgSNtHuSq1XYl0BavmQyp9klDzB6INwj71CqKtxuDt9l7hv6kes6fd@vger.kernel.org
X-Gm-Message-State: AOJu0YxkLtUgPKwmGiNu18USdIedlGV1FEZ2uS03e+dHM8Jw/JtGq8CO
	O9ZFiXmTf9ilnWVAV3mD+x+zcK3detrHx6Xi8EajEtO4pGneqyxceq3N
X-Gm-Gg: AY/fxX4v20Nk4+bJb2Tuocy4UfkdruvWRYxtZjHTMy0KJfUjejnlZnF5pat2Z2ufzs6
	BnhiCxdZMJOIlIM79zQUhETbn30cxgw3Wy1D2XjRPzCzuGwbSnCkrOTbfyxeOmyDm9EbR41MoYu
	bz66y2QPkYLMFDkfo/yjcsvBufcW2v3gzmfLqbAuZwqQKcQaHnxkLgoH24B4SzdOS3ZW9ZBWORH
	gp5uU8bngM5dRS2KPnMGoeD/JLEX71t3ycQObt9f46Q/B6bnJC6Iy3E2VhylmMVt7Z6wie/w5Lv
	taX4PsnJCZeFSEEGc4mFsazGmfM3fI8jKpiYDzLXqsehfqndzOdqGqyaOP0yg1uu/IIPrEQqz1g
	z654KPwyoNKjhrYNa75lT2UYvoBs8CIQvwCdkxdMpfMpevp1rDxLTtyWZcwPoXhKLIVgwbSPNG9
	Pb4s0yz+Kx
X-Google-Smtp-Source: AGHT+IHgoAPUzQ55SCQNMnSVoIE8Vay26cotcjWdxZjKE64zc68lJdcRegnaf3zSJHcV/ulmnyNTvA==
X-Received: by 2002:a05:6a00:8c0f:b0:7e8:4433:8fa0 with SMTP id d2e1a72fcca58-7f6694aa5bdmr12313689b3a.40.1765867878234;
        Mon, 15 Dec 2025 22:51:18 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c27769edsm14464814b3a.23.2025.12.15.22.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 22:51:17 -0800 (PST)
Message-ID: <1351a3a944fab86e7fe1babf8b31cde4e722077e.camel@gmail.com>
Subject: Re: [PATCH v8 bpf-next 06/10] btf: support kernel parsing of BTF
 with kind layout
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Date: Mon, 15 Dec 2025 22:51:14 -0800
In-Reply-To: <20251215091730.1188790-7-alan.maguire@oracle.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
	 <20251215091730.1188790-7-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-15 at 09:17 +0000, Alan Maguire wrote:

If strict kind layout checks are the goal, would it make sense to
check sizes declared in kind_layout for known types?

[...]

> @@ -5215,23 +5216,36 @@ static s32 btf_check_meta(struct btf_verifier_env=
 *env,
>  		return -EINVAL;
>  	}
> =20
> -	if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX ||
> -	    BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
> +	if (!btf_name_offset_valid(env->btf, t->name_off)) {
> +		btf_verifier_log(env, "[%u] Invalid name_offset:%u",
> +				 env->log_type_id, t->name_off);
> +		return -EINVAL;
> +	}
> +
> +	if (BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
>  		btf_verifier_log(env, "[%u] Invalid kind:%u",
>  				 env->log_type_id, BTF_INFO_KIND(t->info));
>  		return -EINVAL;
>  	}
> =20
> -	if (!btf_name_offset_valid(env->btf, t->name_off)) {
> -		btf_verifier_log(env, "[%u] Invalid name_offset:%u",
> -				 env->log_type_id, t->name_off);
> +	if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX && env->btf->kind_layout &&
> +	    ((BTF_INFO_KIND(t->info) + 1) * sizeof(struct btf_kind_layout)) <
> +	     env->btf->hdr.kind_layout_len) {
> +		btf_verifier_log(env, "[%u] unknown but required kind %u",
> +				 env->log_type_id,
> +				 BTF_INFO_KIND(t->info));
>  		return -EINVAL;
> +	} else {
> +		if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX) {
> +			btf_verifier_log(env, "[%u] Invalid kind:%u",
> +					 env->log_type_id, BTF_INFO_KIND(t->info));
> +			return -EINVAL;
> +		}
> +		var_meta_size =3D btf_type_ops(t)->check_meta(env, t, meta_left);
> +		if (var_meta_size < 0)
> +			return var_meta_size;
>  	}
> =20
> -	var_meta_size =3D btf_type_ops(t)->check_meta(env, t, meta_left);
> -	if (var_meta_size < 0)
> -		return var_meta_size;
> -
>  	meta_left -=3D var_meta_size;

It appears that a smaller change here would achieve same results:

    -        if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX ||
    +        u32 layout_kind_max =3D env->btf->hdr.kind_layout_len / sizeof=
(struct btf_kind_layout);
    +        if (BTF_INFO_KIND(t->info) > layout_kind_max ||
                 BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
                     btf_verifier_log(env, "[%u] Invalid kind:%u",
                                      env->log_type_id, BTF_INFO_KIND(t->in=
fo));
                     return -EINVAL;
             }

    +        if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX) {
    +                btf_verifier_log(env, "[%u] unknown but required kind =
%u",
    +                                 env->log_type_id,
    +                                 BTF_INFO_KIND(t->info));
    +        }
    +
             if (!btf_name_offset_valid(env->btf, t->name_off)) {
                     btf_verifier_log(env, "[%u] Invalid name_offset:%u",
                                      env->log_type_id, t->name_off);

wdyt?

But tbh, the "unknown but required kind" message seems unnecessary,

> =20
>  	return saved_meta_left - meta_left;
> @@ -5405,7 +5419,8 @@ static int btf_parse_str_sec(struct btf_verifier_en=
v *env)
>  	start =3D btf->nohdr_data + hdr->str_off;
>  	end =3D start + hdr->str_len;
> =20
> -	if (end !=3D btf->data + btf->data_size) {
> +	if (hdr->hdr_len < sizeof(struct btf_header) &&
> +	    end !=3D btf->data + btf->data_size) {

Given that btf_check_sec_info() checks for overlap and total size,
is this check needed at all?

>  		btf_verifier_log(env, "String section is not at the end");
>  		return -EINVAL;
>  	}

[...]
