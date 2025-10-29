Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244DF3218BA
	for <dwarves@vger.kernel.org>; Wed, 29 Oct 2025 23:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761782104; cv=none; b=CdPxPuqqLdVNrEpKqVsFeTW7F/BK2S7TLJzpGa26iMCxi8u20SRAHUZeQhF39KRtMEMGzIIOziVZnrzfkNJpAIUUGIdN+xbvgpr+wLYMt04kGxWjW9s1PI/JMPxGdeH7ATHONR6iawy/Y7LdxZI7mKyaLHKI6YWUDCDuUS4fdP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761782104; c=relaxed/simple;
	bh=CYuA3OD7N1VyOHmj72f8JRfLIC7SK2GyTfK04raeZz8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rm4jf7zEZnchkSpbrGwx0wIQwaFRfXMqCO/g4C41fjo2usHuXZucyJQbe4DEkUysRdLlSIEQwudREyFrKXur7PdcbTYUi4Yj+OiLcLQKqx5n4YG8FH6rLs3YgJEbXPCDSXc1g8y9docYcTZ8j7YY/2GIlzpa7q/n6zXcEMrmlQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gtoj1i58; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gtoj1i58"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27d3540a43fso5125215ad.3
        for <dwarves@vger.kernel.org>; Wed, 29 Oct 2025 16:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761782102; x=1762386902; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lODhMav5p1K71nbHvBAouQHLQOzUWHcWHd+5BKoeR1c=;
        b=Gtoj1i58LcAU60pZCZ5gB4EGCXj/+K/1GkW0xg9MzOecBHCllhxCKzCO24LjpfE6QE
         eLym776yHabv7Q4ccbiU6mmJ/yJd8VRPNRqgWmXgNShAgYD8ERuxaUTMlNaHMP39B104
         rZLvssqNiJvt8xVJjNeX7mVMjGR4PwjWreg9sYF2xvRKcuQuU4ooZAD+sV4TtQNdCQHB
         6D1YrI240QjV6O3IeZD5EKl8n22dmW1vrFFxPSv+9TTYo4DzW9r1WZDVvdU4Uk6tcWKn
         dR6nzkgCNFXjQ7rkjyTH/3GXzeEb94DKnUxiCf74QXPU5cpPopmLhK9l+FI+NjUxs+7A
         KXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761782102; x=1762386902;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lODhMav5p1K71nbHvBAouQHLQOzUWHcWHd+5BKoeR1c=;
        b=hjj5uVBawJKdrRMewG9ZI9YU+qi+dZ/vyeReRyiDqKlwWAn8fo4oVfzRrivXhzL13J
         fYbNmXdH4qGYk15g3wdIqLmD9izsprXZA95A3aUjrtRSh1cTet8aM2PNzz09mM/Y2FZi
         JWYPsocbEQmoRWkADfJob3jOlGt/K2zmsjzn7X7FNMjyxmlvEgSVgV8KOn1+YG1abMNL
         tEWwq0GkSgPy7pqYjN1yh9427BHWAII3UhLLQGdEQUGATtu0roh4J7ztrTPXi92yWgsu
         Ls7ONpg51/E5fdDWBb61ddDCwn6ra+ZsQnT1C/vC5a648UOmC4+F9ZlDCYWUU+arZ732
         hv7A==
X-Gm-Message-State: AOJu0Yy4glYrJy85ytTQq9iaCJDLWUoNGAGSrJvGPqv89SmPeF5CbZbE
	6uKhBKqy4QThcCGi0oWx7BPxvHQbrSgaba9cAyF7jb5zkLhGorC2ASll
X-Gm-Gg: ASbGncvCWF8FgfB5vQIwRZs3K4wSsHU5hPP/vUjFe5bKnPYab5a7Qfy/AhoLGPRvr1t
	OeQKAzKaH/f0tWZ1aBic0xY6CpP8zXI5b4nVDXMKQl/2xi5BgsbjpTpIC9+RKt+SCQzOFY+kthe
	rPVGNDycKVQMbP7NOflmxCQU4eQzFHLqEOyh2Hrg271PkHmKQ/gVYJJpkvhLFGHZyDQ3hXWOoch
	h+/Sr2HzeEHGWSdbhj1MP5voavglJX/r58TWLgEdzAyxRz9oAaDzHvyOv5g0ePDoTXEme0ahnum
	CNJdOumB9ec71Zf6yaxqP1aQXZB9FFu80exCx15XOfEX6mMQ/PP9QD+l9PL5uw8Y+WppFYU10/w
	dQ4EmlssLrb45kGAjOW/KVvuVKGpBpj+n6hSKDIT2TejfrcOu+R8IB2QTiZhae47OxPPXM3dtdi
	MDZs1c6F4SaQi/oViQxoBNPhfvBY0a0DKVndDLM4+thEYDEAk=
X-Google-Smtp-Source: AGHT+IGSab5b/K48kjoDAIw5ovbxTQ1bdqBd16anwHKOLxBIj1YWvYElMA79LCrE9dJiCPT/HKFH5g==
X-Received: by 2002:a17:902:7448:b0:27f:1c1a:ee43 with SMTP id d9443c01a7336-294deebc4fdmr35815395ad.29.1761782102406;
        Wed, 29 Oct 2025 16:55:02 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:3086:7e8a:8b32:fa24? ([2620:10d:c090:500::5:6b34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf49easm166854335ad.9.2025.10.29.16.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 16:55:02 -0700 (PDT)
Message-ID: <ddf506c9c5c5e9fbfd2c1b7d99bc4d2307fc702d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/8] bpf: Refactor btf_kfunc_id_set_contains
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, 
	andrii@kernel.org, ast@kernel.org
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org, 
	tj@kernel.org, kernel-team@meta.com
Date: Wed, 29 Oct 2025 16:55:00 -0700
In-Reply-To: <20251029190113.3323406-3-ihor.solodrai@linux.dev>
References: <20251029190113.3323406-1-ihor.solodrai@linux.dev>
		 <20251029190113.3323406-3-ihor.solodrai@linux.dev>
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
> btf_kfunc_id_set_contains() is called by fetch_kfunc_meta() in the BPF
> verifier to get the kfunc flags stored in the .BTF_ids ELF section.
> If it returns NULL instead of a valid pointer, it's interpreted by the
> verifier as an illegal kfunc usage which fails the verification.
>=20
> Conceptually, there are two potential reasons for
> btf_kfunc_id_set_contains() to return NULL:
>=20
>   1. Provided kfunc BTF id is not present in relevant kfunc id sets.
>   2. The kfunc is not allowed, as determined by the program type
>      specific filter [1].
>=20
> The filter functions accept a pointer to `struct bpf_prog`, so they
> might implicitly depend on earlier stages of verification, when
> bpf_prog members are set.
>=20
> For example, bpf_qdisc_kfunc_filter() in linux/net/sched/bpf_qdisc.c
> inspects prog->aux->st_ops [2], which is initialized in:
>=20
>     check_attach_btf_id() -> check_struct_ops_btf_id()
>=20
> So far this hasn't been an issue, because fetch_kfunc_meta() is the
> only place where lookup + filter logic is applied to a kfunc id.
>=20
> However in subsequent patches of this series it is necessary to
> inspect kfunc flags earlier in BPF verifier, in the add_kfunc_call().
>=20
> To resolve this, refactor btf_kfunc_id_set_contains() into two
> interface functions: btf_kfunc_flags() that does not apply the
> filters, and btf_kfunc_flags_if_allowed() that does.
>=20
> [1] https://lore.kernel.org/all/20230519225157.760788-7-aditi.ghag@isoval=
ent.com/
> [2] https://lore.kernel.org/all/20250409214606.2000194-4-ameryhung@gmail.=
com/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

This preserves original semantics, as far as I can tell,
although a more logical split for API functions seem to be:
- btf_kfunc_is_allowed()
- btf_kfunc_flags()

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

