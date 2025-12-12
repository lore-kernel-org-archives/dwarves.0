Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F0E2727F8
	for <dwarves@vger.kernel.org>; Fri, 12 Dec 2025 07:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765523371; cv=none; b=oJnVxcOJhMePQClZNtv3UMrdtF5MzblDaN+TBp8ApZ2lgq2dY+NczPY3Sl7KD4bDkON25xza4qOl3+qqD+2cWxGqjYKdasUsK2IoTqGTz6lxorc5VeFVgGIOU0TaeF+X+WWINaNVMD38Pz8ohHEGTE0mI7XShG/p2vJTwbFBOYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765523371; c=relaxed/simple;
	bh=rcFIJSID1VDJnjvbTDVTD6FbXH4CfZBKvwp6ewb69eI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wq/iFXmLESDbJfh1aoLIUpKLDvjaZ0h13kpmuEVXDh6cq7IVWP+Bp50SwKVjgOB+/J2eVdyEbAcBy94rZRbRHl7zdHIoRPr1VXbLT31OkTxmIZ0orcsw/GOUh68zUN3moNeujekYdJ9ZHyoiYOoCBJSenNjJlAwuTeNL/GnFb5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ubz2INzF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ubz2INzF"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29d7b019e0eso12205105ad.2
        for <dwarves@vger.kernel.org>; Thu, 11 Dec 2025 23:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765523369; x=1766128169; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=taRaJ5VlWHSJuUogRunxbYADYYPRbeksELcn5Rh5qyI=;
        b=Ubz2INzFYWzJluuIuAe6UXjiqDjUq7/PsZsMLuX40oyGYZwEhENyjbAz3EnZN07AmD
         t60BW5maS5asuN1Pj9yjR4PY6Z7Z+RK4hhB0KmUwQOirC03p04HojfaYdwaND/Cyc+kl
         jKqzBanw94QMeYUW+GdqePZsZf9IsSQyL4T0BGOiWNrzQnFYgETncM8BzXkVaheTROKF
         KEIEaCmjmJGd7JJb22kLnkBbZjLBp12rzi/yKTJIFjfKtvkcy42gvz7pSh676SFmKpDw
         ZVuUbDZlJ04Z0atZD0GV9X8wlEwOHwkXjUF0FHqAbVeeYl/zuNrR4EQiiWAHUkX3igSB
         NoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765523369; x=1766128169;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=taRaJ5VlWHSJuUogRunxbYADYYPRbeksELcn5Rh5qyI=;
        b=Gby0HbrhsUlDIS9mAVekM+U4xgVQO4esygQBNVpOUrIZhh3yAHA1iUXlhZE0HordeO
         YpC3UbUT3pmd/21Ba9OtHGjhMHMpcqL8DL7OWMtveISJiM69KBdgJAwJfiNu9aO9HCb0
         tMZj+fVvSWmW+Q2p1J1PVfIWs/uIgvchQj05uJ6bHwxmxFgZhw22r4QKnwvR/NHrElHJ
         ZNzSpz8cA0NyIurTJgctNYLjsayEUzGdT37lv0kSHbYwFQbGMk7JO8vGBTDXf2ARbalD
         wj0ibbs2Mx9y+mFSQk8ZlB6GqRWoWev258qe54wAm5LTGo9f6YDgjITbLJlwdxNYj2Ye
         Eaog==
X-Forwarded-Encrypted: i=1; AJvYcCW4V960PORMMZGIwyaciojf8oLr8Zvc1shgxTRm0ltXgVgeDFoTvbu1FJ9ovtgsSSi7uTsgzeQu@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ5qnnKV8JkHcWU+CBrtl9u7qYhzB8VUtVFZ69U84HAZhnh8xt
	9B+lGSyHL8UpY7EKVB/D+fFGrJFNu7rzhCFzaEws0AuKiiQ7Q36pVtSR
X-Gm-Gg: AY/fxX5uFcoYWTfJe95KSBnCnY8DjhuJO4/PINLrho3cren+R4COEepvzyvo0PRzBfU
	zfr1SYqVXqAagH4PyvbT+L44nHoAiBhM3ecMCqIBR9ZX3oq02XAZhw5dMLShD3qW8GOxXl2aSAG
	S/1s4HKxyMWMhuc6Ixo80aN6d2eJbur/LI2c5PjaShUCq48wVOWc3yls32yU5FbxHdVEi/fbqFw
	gjZGUxmQPOw0R0qTIq8FOQZPZAQLmbIUaTrOpclSDTYKniuIQRd2jeA0PwFcgZTelgHyen1USvz
	oovc+/jNWYJbUixhxvdORu3Hp/O1HkJcn71pyQvlMc///aXq41EtkjppjHIhxhhoK3FIeK5YS/U
	dqSPpjkpqBLE68oXyoWPR9KdsE8ZWGHBNIAelVZh1LnGyOlcwP5GZ+H4eIVGHvpvP4jv8tF9TZ+
	DN/f07rLELCWElHEE9j/B6wYd4MZCMECZoKsGzZFP2K/o=
X-Google-Smtp-Source: AGHT+IFofls55I9SmzDD+JUpzLkrd9iqjAHtwopQZ9d48ulj+lsYXpWt5ararv/5zaraLa80YwAWHQ==
X-Received: by 2002:a17:903:46c6:b0:29d:9b3c:4fc8 with SMTP id d9443c01a7336-29f23d40decmr12993205ad.61.1765523368880;
        Thu, 11 Dec 2025 23:09:28 -0800 (PST)
Received: from [10.200.2.32] (fs98a57d9c.tkyc007.ap.nuro.jp. [152.165.125.156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9b37356sm43756675ad.2.2025.12.11.23.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 23:09:28 -0800 (PST)
Message-ID: <386068b11e146a9dbb502f770d7e012e3dea950f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] resolve_btfids: Introduce enum
 btf_id_kind
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>, Nathan
 Chancellor <nathan@kernel.org>, Nicolas Schier	 <nsc@kernel.org>, Tejun Heo
 <tj@kernel.org>, David Vernet <void@manifault.com>,  Andrea Righi
 <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Shuah Khan
 <shuah@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt	 <justinstitt@google.com>,
 Alan Maguire <alan.maguire@oracle.com>, Donglin Peng	
 <dolinux.peng@gmail.com>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-kbuild@vger.kernel.org
Date: Fri, 12 Dec 2025 16:09:21 +0900
In-Reply-To: <20251205223046.4155870-4-ihor.solodrai@linux.dev>
References: <20251205223046.4155870-1-ihor.solodrai@linux.dev>
		 <20251205223046.4155870-4-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-12-05 at 14:30 -0800, Ihor Solodrai wrote:
> Instead of using multiple flags, make struct btf_id tagged with an
> enum value indicating its kind in the context of resolve_btfids.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

(But see a question below).

> @@ -213,14 +218,19 @@ btf_id__add(struct rb_root *root, char *name, bool =
unique)
>  			p =3D &(*p)->rb_left;
>  		else if (cmp > 0)
>  			p =3D &(*p)->rb_right;
> -		else
> -			return unique ? NULL : id;
> +		else if (kind =3D=3D BTF_ID_KIND_SYM && id->kind =3D=3D BTF_ID_KIND_SY=
M)

Nit: I'd keep the 'unique' parameter alongside 'kind' and resolve this
     condition on the function callsite.

> +			return id;
> +		else {
> +			pr_err("Unexpected duplicate symbol %s of kind %d\n", name, id->kind)=
;
> +			return NULL;
> +		}

[...]

> @@ -491,28 +515,24 @@ static int symbols_collect(struct object *obj)
>  			id =3D add_symbol(&obj->funcs, prefix, sizeof(BTF_FUNC) - 1);
>  		/* set8 */
>  		} else if (!strncmp(prefix, BTF_SET8, sizeof(BTF_SET8) - 1)) {
> -			id =3D add_set(obj, prefix, true);
> +			id =3D add_set(obj, prefix, BTF_ID_KIND_SET8);
>  			/*
>  			 * SET8 objects store list's count, which is encoded
>  			 * in symbol's size, together with 'cnt' field hence
>  			 * that - 1.
>  			 */
> -			if (id) {
> +			if (id)
>  				id->cnt =3D sym.st_size / sizeof(uint64_t) - 1;
> -				id->is_set8 =3D true;
> -			}
>  		/* set */
>  		} else if (!strncmp(prefix, BTF_SET, sizeof(BTF_SET) - 1)) {
> -			id =3D add_set(obj, prefix, false);
> +			id =3D add_set(obj, prefix, BTF_ID_KIND_SET);
>  			/*
>  			 * SET objects store list's count, which is encoded
>  			 * in symbol's size, together with 'cnt' field hence
>  			 * that - 1.
>  			 */
> -			if (id) {
> +			if (id)

Current patch is not a culprit, but shouldn't resolve_btfids fail if
`id` cannot be added? (here and in a hunk above).

>  				id->cnt =3D sym.st_size / sizeof(int) - 1;
> -				id->is_set =3D true;
> -			}
>  		} else {
>  			pr_err("FAILED unsupported prefix %s\n", prefix);
>  			return -1;

[...]

