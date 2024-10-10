Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE101BE855
	for <dwarves@vger.kernel.org>; Thu, 10 Oct 2024 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550671; cv=none; b=XpUz43prAT5GH0EnV5sap4A24pOPRhU1HtqdzUPHppKCRP6c8gB5ijBujQYiZzv+SwPrDK/eSRHOr1m2j+RNd99dKsR3Ps9J9oPCG+4E9E+/QNNftNyAYsYRdL/7AuIMe4Pws4qQfn9o7OPpisA0hPiZ03wE9UVYwWPhLRuhq6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550671; c=relaxed/simple;
	bh=P7hEOENLIeXQ7aCQUuiOqXtAhvSVIvqkl7fWm1NUklU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pu6lue8NKII2TYfk5vreAHXC6b1pL4qjjTdubBNKBjJZuEsSNp8OqzuSXw4vWBczi67pLz0N/vh8uOYUJCR/aLBt7sWs8FXk9yZxiQDhhIPLo3+WGVwzhloBnr1mWVKH63XdoIsesikqebYfi3vmnXGZb/yOFywe3v4v9ylrXKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiD/nGcj; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiD/nGcj"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e01eff831so521661b3a.2
        for <dwarves@vger.kernel.org>; Thu, 10 Oct 2024 01:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728550669; x=1729155469; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BWzqqrad9XbUFeOKlxYScW7hMwy380lrjIBN6tFkbRk=;
        b=TiD/nGcjp1Y6HtptKLji27l6GeACR+phmGo+x3V+770z/lniIxFlw6BxviIBaJgG3v
         yZQ0lhCM0TkrQRqMqKdOi1mfJmnJOAnclIOPcDla/5InlBsWQniz6M2gO87JtrHxiJ+s
         pjKaWJBxxJjnoszmyT6khdYickHQbI4tURrzZGe20F9aSYR9DFf3EvQ28qwBNc/Cbi4V
         LpI6AsfJl98E4jAVuoqtKZ2ZVneoX3P4NsQXzU7+x9/hpUqPl9dG30/RoGrNH351GVg1
         SxBJ3GCUltb1WCcceaHkHnt3I6fQ+ZXopeJVTQGdb1EPEi/VVpX5P+8WtHyCnFN9Oe85
         55Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728550669; x=1729155469;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BWzqqrad9XbUFeOKlxYScW7hMwy380lrjIBN6tFkbRk=;
        b=rtD2/tRC3Q2mILt2G+UX32oX7EcJgvunbGv2D+s+1elQkWPwPB9xK9U5kROZupuJ1+
         N/vVfAF5N6/1fauhbTrk3CCyAEBSWEPaLfPyBJK9P9sQZ9/Yh4bu8W/6MSfNsRSLRW79
         AW5tECsCucDsvInlC5NDmybnQz8GiZgAqhRb/mWr6xGRGFVhPQNHcLq6gpHfuO0X9Zrj
         +eIXgZ8ceXgky/zCGOBmcl64bPJFxRDvNDLw/K0M+YXWhxkguxQwPBnjOlRal4dU2KHJ
         ochCpi89Zm0miZDFHxr7kLUx9x5Wqn1PxHGC58DJH/8MfsPP24CQ5BMYooLK4dk31izF
         LSBg==
X-Forwarded-Encrypted: i=1; AJvYcCV7IJEyApF6wMsURlCR9AJ2U8zI0kz/2zDep0QB876pQRRRoKaAqd7f3yuaComKwel4rgQuXbm1@vger.kernel.org
X-Gm-Message-State: AOJu0YygOGLCDBHI11L3EOiwqMGbDWO+eljLZy6/2Aj+ReKB4xIMWv25
	midY0f+3TIY+7mGbYQjGAvmsAuniPqqFleDBY0Q1YwJDb200BHFAKZyOQw==
X-Google-Smtp-Source: AGHT+IEzUQ0Tr/KJHYNJ/XFqQSF5/cSsiBEYtE9z7NrM5BxllfgXIW0Jz83PIE1yIeK3Y+vZC6GV3A==
X-Received: by 2002:a05:6a00:84f:b0:714:1d96:e6bd with SMTP id d2e1a72fcca58-71e1db88700mr8715835b3a.13.1728550668634;
        Thu, 10 Oct 2024 01:57:48 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea44909222sm634370a12.44.2024.10.10.01.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:57:48 -0700 (PDT)
Message-ID: <93c40bd77cd1a779a6de8ca92e862ad2e551653b.camel@gmail.com>
Subject: Re: [PATCH v2 dwarves 5/5] btf_encoder: switch to shared
 elf_functions table
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org
Date: Thu, 10 Oct 2024 01:57:43 -0700
In-Reply-To: <20241009233520.989453-6-ihor.solodrai@pm.me>
References: <20241009233520.989453-1-ihor.solodrai@pm.me>
	 <20241009233520.989453-6-ihor.solodrai@pm.me>
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

[...]

I think the logic makes sense, please find a few comments below.

[...]

> @@ -1340,44 +1355,51 @@ static inline struct elf_function *find_elf_funct=
ion_in_list(struct elf_function
>  	return NULL;
>  }
> =20
> -static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
> +
> +// Each element of elf_functions->entries is a list of a variable
> +// number of elf_function structs, because not all encoders saved a
> +// particular function.  However each function saved by at least one
> +// encoder needs to be added to BTF _somewhere_. Here we traverse the
> +// entire elf_functions table, and for each list of elf_function
> +// structs a function is added to the BTF of the encoder of the first
> +// elf_function in the list.
> +int btf_encoder__add_saved_funcs(struct btf_encoder *base_encoder)
>  {
> -	int i;
> +	struct elf_functions *functions =3D base_encoder->functions;
> =20
> -	for (i =3D 0; i < encoder->functions.cnt; i++) {
> -		struct elf_function *func =3D find_elf_function_in_list(&encoder->func=
tions.entries[i], encoder);
> +	for (int i =3D 0; i < functions->cnt; i++) {
> +		struct elf_function *list_head =3D &functions->entries[i];
> +		struct btf_encoder_func_state *state;
> +		struct elf_function *func;
> =20
> -		if (!func)
> +		// list_head without an owner means no encoder
> +		// has saved a function with this name

Nit: // and /**/ style comments are now mixed in this function,
     I think that kernel style prefers /**/.

> +		if (!list_head->owner)
>  			continue;
> =20
> -		struct btf_encoder_func_state *state =3D &func->state;
> -		struct btf_encoder *other_encoder =3D NULL;
> +		func =3D list_head;
> +		state =3D &func->state;
> =20
>  		if (!state->initialized || state->processed)
>  			continue;

I don't think that `!state->initialized` check is needed after your
changes. The `state->processed` flag also seems unnecessary, as
algorithm traverses all records collected for a name, so each one of
them would be `processed` one by one.

> -		/* merge optimized-out status across encoders; since each
> -		 * encoder has the same elf symbol table we can use the
> -		 * same index to access the same elf symbol.
> -		 */
> -		btf_encoders__for_each_encoder(other_encoder) {
> -			struct elf_function *other_func;
> -			struct btf_encoder_func_state *other_state;
> -			uint8_t optimized, unexpected, inconsistent;
> -			other_func =3D find_elf_function_in_list(&other_encoder->functions.en=
tries[i], other_encoder);
> =20
> -			if (other_encoder =3D=3D encoder || !other_func)
> +		for_each_elf_function(other_func, list_head) {
> +			if (func =3D=3D other_func)
>  				continue;
> =20
> -			other_state =3D &other_func->state;
> -			if (!other_state->initialized)
> +			struct btf_encoder_func_state *other_state =3D &other_func->state;
> +			uint8_t optimized, unexpected, inconsistent;
> +
> +			if (!other_func || !other_state->initialized || other_state->processe=
d)
>  				continue;
> +
>  			optimized =3D state->optimized_parms | other_state->optimized_parms;
>  			unexpected =3D state->unexpected_reg | other_state->unexpected_reg;
>  			inconsistent =3D state->inconsistent_proto | other_state->inconsisten=
t_proto;
>  			if (!unexpected && !inconsistent &&
> -			    !funcs__match(encoder, func,
> -					  encoder->btf, state,
> -					  other_encoder->btf, other_state))
> +			    !funcs__match(func->owner, func,
> +					  func->owner->btf, state,
> +					  other_func->owner->btf, other_state))
>  				inconsistent =3D 1;
>  			state->optimized_parms =3D other_state->optimized_parms =3D optimized=
;
>  			state->unexpected_reg =3D other_state->unexpected_reg =3D unexpected;

There is also no need to maintain merged state of
`state->unexpected_reg` and company, as far as I understand there are
no more consumers for this information.
E.g. change the function like this:

  int btf_encoder__add_saved_funcs(struct btf_encoder *base_encoder)
  {
	struct elf_functions *functions =3D base_encoder->functions;

	for (int i =3D 0; i < functions->cnt; i++) {
		struct elf_function *list_head =3D &functions->entries[i];
		struct btf_encoder_func_state *state;
		struct elf_function *func;

		// list_head without an owner means no encoder
		// has saved a function with this name
		if (!list_head->owner)
			continue;

		func =3D list_head;
		state =3D &func->state;

		bool unexpected =3D false, inconsistent =3D false;

                for_each_elf_function(other_func, list_head) {
			struct btf_encoder_func_state *other_state =3D &other_func->state;

			unexpected |=3D other_state->unexpected_reg;
			inconsistent |=3D  other_state->inconsistent_proto;
			if (!unexpected && !inconsistent &&
			    !funcs__match(func->owner, func,
					  func->owner->btf, state,
					  other_func->owner->btf, other_state))
				inconsistent =3D 1;
		}
		/* do not exclude functions with optimized-out parameters; they
		 * may still be _called_ with the right parameter values, they
		 * just do not _use_ them.  Only exclude functions with
		 * unexpected register use or multiple inconsistent prototypes.
		 */
		if (!unexpected && !inconsistent) {
			if (btf_encoder__add_func((struct btf_encoder *)func->owner, NULL, func)=
)
				return -1;
		}
	}
	return 0;
  }

> @@ -1391,7 +1413,7 @@ static int btf_encoder__add_saved_funcs(struct btf_=
encoder *encoder)
>  		 * unexpected register use or multiple inconsistent prototypes.
>  		 */
>  		if (!state->unexpected_reg && !state->inconsistent_proto) {
> -			if (btf_encoder__add_func(encoder, NULL, func))
> +			if (btf_encoder__add_func((struct btf_encoder *)func->owner, NULL, fu=
nc))

Nit: given that const is cast away here, is there a need to declare `->owne=
r` field as const?

>  				return -1;
>  		}
>  		state->processed =3D 1;

[...]

> diff --git a/pahole.c b/pahole.c
> index 0ff6bc2..a45aa7a 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -3256,23 +3256,23 @@ static int pahole_threads_collect(struct conf_loa=
d *conf, int nr_threads, void *
>  				  int error)
>  {
>  	struct thread_data **threads =3D (struct thread_data **)thr_data;
> +	struct btf_encoder *encoders[nr_threads];
>  	int i;
>  	int err =3D 0;
> =20
>  	if (error)
>  		goto out;
> =20
> -	for (i =3D 0; i < nr_threads; i++) {
> -		/*
> -		 * Merge content of the btf instances of worker threads to the btf
> -		 * instance of the primary btf_encoder.
> -                */
> -		if (!threads[i]->btf)
> -			continue;
> -		err =3D btf_encoder__add_encoder(btf_encoder, threads[i]->encoder);
> -		if (err < 0)
> -			goto out;
> -	}
> +	for (i =3D 0; i < nr_threads; i++)
> +		encoders[i] =3D threads[i]->encoder;
> +
> +	/*
> +	 * Merge content of the btf instances of worker threads to the btf
> +	 * instance of the primary btf_encoder.
> +	 */
> +	err =3D btf_encoder__merge_encoders(btf_encoder, encoders, nr_threads);

Nit: it looks like simply adding a call to btf_encoder__add_saved_funcs()
     here would minimize changes to pahole_threads_collect() and make
     btf_encoder__merge_encoders() unnecessary.

> +	if (err < 0)
> +		goto out;
>  	err =3D 0;
> =20
>  out:

[...]


