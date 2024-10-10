Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B84190059
	for <dwarves@vger.kernel.org>; Thu, 10 Oct 2024 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550655; cv=none; b=UOAZRsMz/OPvrcK2MR39jSM5J/E1fO69CKjvP2U/pzL9RlaCIwpuaeuhl7lo8yEQ+LIGjllIxlpMavPWYIWC5kT0CWyUzju9W7asrJWo7XwMXoKpA7PPTdse5t2ckvNGQSLa1Hdvb4tOYQoU1ebVwaSXcuybvBVHnqmrFJjGyg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550655; c=relaxed/simple;
	bh=uN/zbvZR4VopGXWQN9YiBZz8mjVU2/9vt3RynKCd2SQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VTp09tGRXgiLDKkngorcH2i9cJR2V+af1qpzB706iM6JTwCOSUtwI2f8l1DkPSGZU9xqa9p8jCyc3aRCyjlhOfHqG+4M/UrPTk/UlBDY9S5wGRFt+l2C9wAPTAOykIKnt5v8QjixmxW+ODEL6s94KYnqo5gWhFLHNJ/396CqcNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hd5lgMYQ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hd5lgMYQ"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7e9f955cb97so356328a12.3
        for <dwarves@vger.kernel.org>; Thu, 10 Oct 2024 01:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728550653; x=1729155453; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gxAFqVuyk9Pb5YLLczGXOl6YRQ1JLxJyZL3/sYcfsJk=;
        b=hd5lgMYQAhMfmodGU9GoKPSHQA3SeiBIjqIId5A4dWZEv9oEboO6BDrTV/djbzMrqa
         nG15jop9jDCUtQLj/YNYh8Dd/ddRPH/FMNJ/XyX9+JYyHflXWn1bUG2E0ByCJQlvYK9Q
         VQQi4y+/FnhDcbP2by20FHaG6K765WTBg/PgNYfFrdjUUnBGagQfJNJpUDqcOAXVaw4E
         NgNhyLtc9KWiX7uqcjMLChGsjYKYNhtCqGM7W4652k9xQ7GVwwD9VvscYNbMn4MYSf/B
         awEHOEl/4wi94GDEgadoB5k5h5YeT1+8RWBiu3na+zJCJE6LKFqmXx62VVNwCSA48nhH
         +oPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728550653; x=1729155453;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gxAFqVuyk9Pb5YLLczGXOl6YRQ1JLxJyZL3/sYcfsJk=;
        b=vj0dlo4DJKKIk4DA2NiUtiekcNd+2EU+AZubGNdt32zUAFCiiNHMriXxatDkpgtREA
         9ONy+H7KWAJOSI8Ib5do5YCPqM9d6M2vRbmcpuKlYsbk2JKoWrjyTxBGa9RqMTa8ZtYa
         kjOp7+4OeFFZQWxvCZDJuZQUUB4KtKiTiREk+8KyZh2oP6pYDkSCnQlq83NOob0KbQIg
         CNylHbPnPxKZhKLR4ESyUngYtR2JDbK4fZsYrptgon80nP6fqiX4XVUHhxzl6rt+TqWe
         8DNq+esHuIe0FFOKtptucqSophCbu1W9vTG2a9ZJFurYHWi6Z20vsFggiRefaLodttcd
         o9pg==
X-Forwarded-Encrypted: i=1; AJvYcCU/ENQxBSCb4zu2oGFDqLPi73Gke0cqq8/SVL06Klw5BjreSSFVTYWAfGSJh51FuZZHJtrMRdzL@vger.kernel.org
X-Gm-Message-State: AOJu0YwaXCpYQ3YxHHfWVmKZpGIUjz2umjxmwGBWgIK9QkYXn2+SFV05
	SaY3QIlunt2o/y2EUv809s1E4bipPs1fWrUi5lp1hNm1ddy48Snb
X-Google-Smtp-Source: AGHT+IHCpMGRqqby6aleiLCtmccnxPgvUo3dZ2t0EJuflsf/r2Yh72vc3wx0kMX5/qodQgvgb2P2gw==
X-Received: by 2002:a05:6a20:38a2:b0:1d8:a96c:e9bf with SMTP id adf61e73a8af0-1d8a96cea69mr5180046637.44.1728550652969;
        Thu, 10 Oct 2024 01:57:32 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea448e6235sm636967a12.3.2024.10.10.01.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:57:32 -0700 (PDT)
Message-ID: <9f0b3a85b37d10bff446a43b2c154b1abd723d5f.camel@gmail.com>
Subject: Re: [PATCH v2 dwarves 4/5] btf_encoder: make elf_functions.entry an
 elf_function list
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org
Date: Thu, 10 Oct 2024 01:57:28 -0700
In-Reply-To: <20241009233520.989453-5-ihor.solodrai@pm.me>
References: <20241009233520.989453-1-ihor.solodrai@pm.me>
	 <20241009233520.989453-5-ihor.solodrai@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 23:35 +0000, Ihor Solodrai wrote:
> btf_encoder__save_func() accumulates observations of DWARF functions,
> maintaining an elf_function per function name.
>=20
> Part of this routine is a funcs_match() call, which requires access to
> BTF implicitly referenced by btf_encoder_func_state.  In case when
> elf_functions table is maintained for each btf_encoder this is not an
> issue, because every btf_encoder_func_state available to this encoder
> can only reference its own BTF. However, if elf_functions becomes
> shared, existing elf_function/btf_encoder_function_state structs can
> be produced by other encoders with their own BTFs. In this case
> funcs_match() can not be called unless BTFs are available and writes
> to them are synchronized in some manner (which is not desirable).

Nit: Something is missing in explanation at this point.
     In the paragraph above you describe why funcs_match()
     can't be called concurrently.

     I think a sentence is needed explaining that the solution is to
     forgo concurrent funcs_match() calls and simply accumulate info
     about all functions in DWARF.

> Accumulated states are later merged between encoders in
> btf_encoder__add_saved_funcs(). To enable sharing of the elf_functions
> table between encoders, two members are introduced to struct
> elf_function:
>   - elf_function *next - to enable linked-list
>   - btf_encoder *owner - to find elf_function corresponding to a
>     particular encoder in a list
>=20
> Each element of elf_functions->entries is a head of a list that stores
> elf_function structs one for each encoder that searched for this
> function name at least once.
>=20
> btf_encoder__find_function() is modified to perform the search on
> shared elf_functions table, and atomically update a corresponding list
> as necessary.
>=20
> At this point each btf_encoder is still maintaining it's own
> elf_functions table, but the updated implementation is used.
>=20
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> ---

Aside from a few nits, I think the logic makes sense.
Not sure if it is worth it to separate patches #4 and #5.

>  btf_encoder.c | 117 +++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 93 insertions(+), 24 deletions(-)
>=20
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 9e05b56..f88c2e1 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -86,10 +86,15 @@ struct btf_encoder_func_state {
>  };
> =20
>  struct elf_function {
> +	// bsearch key
>  	const char	*name;
> -	char		*alias;
> -	bool		 generated;
> -	size_t		prefixlen;
> +	size_t		 prefixlen;
> +	// for list search
> +	struct elf_function *next;
> +	const struct btf_encoder *owner;

Nit: 'encoder' might be a better name for this field.

> +	// encoder-specific state
> +	char *alias;
> +	bool generated;
>  	struct btf_encoder_func_state state;
>  };
> =20
> @@ -106,7 +111,7 @@ struct elf_functions {
>  	struct list_head node; // for elf_functions_list
>  	Elf *elf; // source ELF
>  	struct elf_symtab *symtab;
> -	struct elf_function *entries;
> +	struct elf_function *entries; // an array, each element is a head of a =
list
>  	int cnt;
>  	int suffix_cnt; /* number of .isra, .part etc */
>  };
> @@ -169,10 +174,29 @@ static struct elf_functions *elf_functions__get(Elf=
 *elf)
>  	return NULL;
>  }
> =20
> -static inline void elf_functions__delete(struct elf_functions *funcs)
> +static void __elf_functions__delete(struct elf_functions *funcs)
>  {
> +	for (int i =3D 0; i < funcs->cnt; i++) {
> +		// free all list elements except the head
> +		struct elf_function *func =3D funcs->entries[i].next;
> +
> +		while (func) {
> +			struct elf_function *next =3D func->next;
> +
> +			free(func->alias);
> +			zfree(&func->state.annots);
> +			zfree(&func->state.parms);
> +			free(func);
> +			func =3D next;
> +		}
> +	}
>  	free(funcs->entries);
>  	elf_symtab__delete(funcs->symtab);
> +}
> +
> +static inline void elf_functions__delete(struct elf_functions *funcs)
> +{
> +	__elf_functions__delete(funcs);
>  	list_del(&funcs->node);
>  	free(funcs);
>  }
> @@ -204,6 +228,7 @@ out_error:
>  	return NULL;
>  }
> =20
> +

Nit: useless newline.

>  int btf_encoder__pre_cus__load_module(struct process_dwflmod_parms *parm=
s, Dwfl_Module *mod, Dwarf *dw, Elf *elf)
>  {
>  	struct elf_functions *funcs =3D elf_functions__new(elf);
> @@ -1301,12 +1326,30 @@ static int32_t btf_encoder__add_func(struct btf_e=
ncoder *encoder, struct functio
>  	return 0;
>  }
> =20
> +#define for_each_elf_function(func, head) \
> +	for (struct elf_function *func =3D head; func; func =3D func->next)
>
> +static inline struct elf_function *find_elf_function_in_list(struct elf_=
function *list_head,
> +							     const struct btf_encoder *encoder)

Nit: just 'find_elf_function'?

> +{
> +	for_each_elf_function(f, list_head) {
> +		if (f->owner =3D=3D encoder)
> +			return f;
> +	}
> +
> +	return NULL;
> +}
> +
>  static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
>  {
>  	int i;
> =20
>  	for (i =3D 0; i < encoder->functions.cnt; i++) {
> -		struct elf_function *func =3D &encoder->functions.entries[i];
> +		struct elf_function *func =3D find_elf_function_in_list(&encoder->func=
tions.entries[i], encoder);
> +
> +		if (!func)
> +			continue;
> +
>  		struct btf_encoder_func_state *state =3D &func->state;
>  		struct btf_encoder *other_encoder =3D NULL;
> =20

[...]

