Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B8542048
	for <dwarves@vger.kernel.org>; Wed,  5 Nov 2025 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762307740; cv=none; b=uHwfThSpesH7k5n8t4oWDeS+QKKaK8KI76fyk4FrehQhPIOkA+oyM2Awk9+GdxUeMjXgHvwPYPXs7wVLthT9PlEiJpQHOPd5INBPYJtlKr/oNohToIpDgLoevlHgEAhIxvN+k1b922KSIEC/Feim4FYYyANiRlLkENwZBDvenl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762307740; c=relaxed/simple;
	bh=4a2cMY6x5xwbiIO4AfwvSZbxZPl0B3iDH/keTNhUNvs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mkf9wTxURFxDs1y0akp4ccP4Ci8erzq+vrxQ3mcBETk7vjkE2szxBmw9PJCaA+HHLVhFtG/OTfBJjYcRIsFGDP43if4DAYVEh+gcl3P3R/T0AEmexB/m5W6tHMpdJROo/P/+lSFxpH/tLtK88izrP/2+NVbESkfEmmpHy6wRQew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGrOzqmp; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGrOzqmp"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-781997d195aso4587697b3a.3
        for <dwarves@vger.kernel.org>; Tue, 04 Nov 2025 17:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762307738; x=1762912538; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wOFMryYkzLr1eG1Ll2Ax7P71j3x/fKg/djMdpST6qzI=;
        b=ZGrOzqmp5zd7nTxRNLU++OiypXC1RcWH9ci7n7JCmHKXme0Bkv9AF0xv6Lq/ubGo3P
         aJWz/S3p8KUQjsocEEYIBpO9hCmN4Xc+EgH2t1KeJBLUUDE+MY3VBYF03l9DCTF7JsQy
         8eEUCoXyyumzjIblLV9XPD8PAOTNKMtj/SQDyrO097ESr9s1rvgpxYe65SeZRphgQwOD
         s37YQIS79rOMN20K/i2RbmvG3zyZcfzOHZtI+Ka85NFf5pgkDgQbF1v3YsGOr+KRg8nf
         +4vuCi9nYMwdS+yVXxzv3T5Skn9ufXK95+M0JplSbMly2Z+zPQamZfljlOYi2FcI1Mo6
         s56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762307738; x=1762912538;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wOFMryYkzLr1eG1Ll2Ax7P71j3x/fKg/djMdpST6qzI=;
        b=L9TCAiYBBhBeQ3gkJm04rx6HXvAEGKovgYrBhldqITcvHYxP4hCZl0h8aMRYWFanGD
         Dove8zsv7RdL5NPqaB+PuEmw3OmTCvjemK75dFm8FcoYkLzX2jnUTi3bteSUaoU+k1Uh
         2ea0UAdCzCy42EweZ+CIjBes2jANkyJdmA/csk1ZlFMyXC7QyK428VkUNjscP874KcYg
         H30tbvO10zRBcIogjQYFAZLaaMph9JqMDNnHwOZk6HsdboZ8BfE5/rwCaf619YWLXZZh
         W3b0hHxnoDV9fT3cyY0mJaHBy0Drzqa0ctPOj3cwzu+c9fQuiRJ9JiER1fRM6kRUDrqL
         Mymg==
X-Forwarded-Encrypted: i=1; AJvYcCXSgXkGGyOOZQK9lM3bw5jDJoEPCFFax1uDSuhzSNydGwTI/iWIX+NHOhukpVOUFv8e3HghK1I+@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6zcUOHz6OLJmNbhF+4PuD0CfwNAhgdwli7b42ayt83sbhu7Qr
	uFksOldv5RhhrQ2ZxQnjdkYb7K5aPnV5jm9S3ipylCy6ghGRLP3FdSS9OsrdczNy
X-Gm-Gg: ASbGncuvWJE7+enbXNVukhZZQJIr4sUaPlQYieSzjUjFg03z8XFoIV/y5lJB0WIqx+n
	y2No5Dfc2mC30XONAtqpPz/6ZCpLanSAU7hCLaycjsYHWNupn1Z8FpXv/rnJe60vO0RvYjBehy0
	6cRfsdfZMIVfUYrlCSDPAuP0j13wWU6Z3GffbwRbezzhlfj0lroV4kKConGEJCuyTTNab+ARmwq
	ianrCua7M7Ddsuht54c4dQrVECSzSqhv5yu5kwjxEoPcq2CXBBpc2ha+QjHf0grL3DOTr6zKD7f
	ghqGX4QjyTMTrB/7tyhaVwaG+ORlVFlApTncSshJkKk//KC3nq/E0H82TgyEOLg/8cZosDDaTvl
	wT2gDNSuCPnt4qgFwVRwzMI7+YJ8LRc7nieleFAkoFBT0iRSOLkhQiPnqH4uIL1d6PesjTOEOcw
	+C7iVLhpuT/fahbeR7E3ElAdE=
X-Google-Smtp-Source: AGHT+IHfZVHaL+1AoBJIOhUwB44Qamd0mYFbRaY+ULhlHYNXA5luFKLu5fdcYEXvOsEuI1V52+wxgA==
X-Received: by 2002:a05:6a20:3d82:b0:342:6380:7ec9 with SMTP id adf61e73a8af0-34f853f6679mr2071627637.37.1762307738521;
        Tue, 04 Nov 2025 17:55:38 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a643:22b:eb9:c921? ([2620:10d:c090:500::5:99aa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd586f862sm4385350b3a.34.2025.11.04.17.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 17:55:38 -0800 (PST)
Message-ID: <da133e69429c39871b6f4f586ca9843c9e35048e.camel@gmail.com>
Subject: Re: [PATCH dwarves v2 2/2] btf_encoder: factor out
 btf_encoder__add_bpf_kfunc()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org, 
	alan.maguire@oracle.com, acme@kernel.org
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 kernel-team@meta.com
Date: Tue, 04 Nov 2025 17:55:36 -0800
In-Reply-To: <20251104233532.196287-3-ihor.solodrai@linux.dev>
References: <20251104233532.196287-1-ihor.solodrai@linux.dev>
	 <20251104233532.196287-3-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-04 at 15:35 -0800, Ihor Solodrai wrote:

[...]

> @@ -1411,6 +1397,28 @@ static int32_t btf_encoder__add_func(struct btf_en=
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

As with previous iteration, 'state' has a link to 'encoder', so there
is no need to pass it as a parameter.

> +	int btf_fn_id, err;
> +
> +	if (encoder->tag_kfuncs && encoder->encode_attributes)
> +		if (btf__add_bpf_arena_type_tags(encoder->btf, state) < 0)
> +			return -1;
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

[...]
