Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5811F95C
	for <dwarves@vger.kernel.org>; Thu, 25 Sep 2025 01:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758763376; cv=none; b=gtQUGKQiHr4ZUFRhl0Mby2/Qnu87sjOHjGzrgzNLcf460fyR1HhyPF4bw+uV7q4ue1epR3/oZDUb/Y9nuSQK7Hp/pJ/Ti1vUtptEgUBkrJeXEB6eHxUhuSknV7elHX0B/w/YWko4oU3HCkbvUF5WjwGqR+TIBnDIRKiVaaMgn70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758763376; c=relaxed/simple;
	bh=o0EaVucAffVjVNWgKC9SycpMt7zNfoJTy3Oflm8S4Uk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EK0g4Gdfr/Dyi2koLofpRg5rPCdzKiLLjqEwgTkXFKHza6+Ka1cWw0mnVKE2Mpbj3yDdne1gBlAT+oqNMZYJGhn74eFq9zFb242Ga6iaiIqArgE6XwYRjDBuy8Gbhl90WEcQ6oW3VT//u5UpKkvnufiqMCq7rzUTKNOIHaRguqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqaTlCv/; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqaTlCv/"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-425715aeccdso2191055ab.2
        for <dwarves@vger.kernel.org>; Wed, 24 Sep 2025 18:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758763373; x=1759368173; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1DItSFqISv8b0sp2o1o+gwdJ26XpE/NHjR7F/HcZXZM=;
        b=AqaTlCv/5ocwmfE0L/k9VQ0vdSXpB1EtptQ+3o3T9Zci2oThWegTnJlmoA0D5uuEko
         qTnzCjVl+AylRJqKgyKlH5Bvr7ZeM7NyjYx7qBAxvM+wh/au4tRTPgdnjtmAH/oSh3w4
         Q5kQYDSca4dxka2tNQmAK1NmWYMCBEZnehnp5J6aAZbVHAP+GjGMbWFY9scBPRt4GYNW
         2tvFLABfhquu3zi2+WXEwCIux2yzFQVl1mrFjYwnvvM13MGsM1Ujm/tSyVdjBtYTST4d
         tyEDjDpTUI4o33oz5bZfkcrH/G7TGqTtpn0FViw2Vq9eEhigNIETxGh3yIZl7NU+5p/e
         Wtvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758763373; x=1759368173;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1DItSFqISv8b0sp2o1o+gwdJ26XpE/NHjR7F/HcZXZM=;
        b=CTDPVMwW01YoyJaKQ4vebEyT1w4QMh+LBJQhSMAYgStgFsCZJhZd6awK4PI5CW+6Sr
         3zkbvbSoYwC/7r/YUO2iS2cba1c/UGtOAjk8NBqRHVe7dN5GnHdl5gfZshnHOWRaC1qz
         0lIX1J5iP6AcdK2h4p6q/Nudoje1q0LO8YhW0Dzyy7f0zNvD3JbnPr1ImQmKoMy6YxCy
         aw3pj21xt53IodqLmd5s+eLeg9JjqJtvLqLKxIiSLma4MI9BAFl0By5OYotZlJnwZgT2
         Jo20LR0NWw98IUBpqyBZS+TztFvh5FRgm7ZXqhQD4lbbZwHCJ+Vw+O1RFDaRwv76c6Tb
         ncgg==
X-Forwarded-Encrypted: i=1; AJvYcCV0s/RGUVy6q8gX0vutsnXHqdV6koSFdf9PNi+/8HiX0PMk6rwXR3qVaaUHF7MS6NmBgWHNWWh/@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgw1hxsgIHpMHk9v1Trp/xp7lRJ2dFfXd4X6uDToFDZUiRzzHu
	Gu7e6EOv8mAWqmzFzrkkDpqDLQVEvJxThFPoCPP8aXceHy9uJXd5+Evp
X-Gm-Gg: ASbGncsvSm4rVa8lTVMpTSRGUyI2JMjkwszBazYafU49b/lEvW5rE6T9juXj9RmiZUm
	8rTrVaDw+EDhinNgQ/CU489mAUuPktWlmytoMD00nVgD60jKbJEpCber6Fd6xssOPlkZ7PyQZ3x
	qMVAXHh/K0niC5YWtRBWOOQ9TjKM299SAXzW9A8dIuutK4n6Zn49gWJaxuQgGykgBP1Ts6GTanF
	6JhK05Hq14DbauwjWNgWokEWu4zF+Mem+inNXsEcseVBhpZfRytH+nYQpizIwMWxKTkCBLpO7iz
	1pDBn7aWMTyxjDlnkW1ztrtriEkD3J7AGpgKxBWuLN3HS6Hmj6lceAIB2A10dyQ=
X-Google-Smtp-Source: AGHT+IE+Mr9sbqIiUqiFxCLoQppQyUvIwE99EE7EeQ/11eChZXXpB6ohyOTfNUFAafgN6j19FmIbxg==
X-Received: by 2002:a05:6e02:12e6:b0:424:553b:f2f5 with SMTP id e9e14a558f8ab-425955e82cdmr27176215ab.10.1758763373411;
        Wed, 24 Sep 2025 18:22:53 -0700 (PDT)
Received: from [172.19.1.71] ([70.41.76.87])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a6508a1bfsm291892173.18.2025.09.24.18.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 18:22:52 -0700 (PDT)
Message-ID: <4fb8a812fdd01f115a99317c8e46ad055b5bf102.camel@gmail.com>
Subject: Re: [PATCH dwarves v1 2/2] btf_encoder: implement
 KF_IMPLICIT_PROG_AUX_ARG kfunc flag handling
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org, 
 alan.maguire@oracle.com, acme@kernel.org, andrii <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, tj@kernel.org, 
	kernel-team@meta.com
Date: Wed, 24 Sep 2025 18:22:37 -0700
In-Reply-To: <20250924211512.1287298-3-ihor.solodrai@linux.dev>
References: <20250924211512.1287298-1-ihor.solodrai@linux.dev>
	 <20250924211512.1287298-3-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-24 at 14:15 -0700, Ihor Solodrai wrote:
> When a kfunc is marked with KF_IMPLICIT_PROG_AUX_ARG, do not emit the
> last parameter of this function to BTF.

[...]

> @@ -887,6 +923,12 @@ static int32_t btf_encoder__add_func_proto_for_state=
(struct btf_encoder *encoder
>  	nr_params =3D state->nr_parms;
>  	type_id =3D state->ret_type_id;
> =20
> +	if (is_kfunc_state(state) && KF_IMPLICIT_PROG_AUX_ARG & state->elf->kfu=
nc_flags) {
> +		if (validate_kfunc_with_implicit_prog_aux_arg(state))
> +			return -1;
> +		nr_params--;
> +	}
> +
>  	id =3D btf_encoder__emit_func_proto(encoder, type_id, nr_params);
>  	if (id < 0)
>  		return id;

This change hides the fact that function accepts one more parameter
both from kernel BTF and from program BTF (via vmlinux.h).
Do we anticipate other implicit parameter types?
Because if we do, it seems like having some generic KF_IMPLICIT_ARG
and hiding it only from vmlinux.h seem more flexible.
