Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF73317BEAB
	for <dwarves@vger.kernel.org>; Fri, 20 Sep 2024 19:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726859925; cv=none; b=E/pjCW0tu1qP3aaUQ69X893pNU+26/2O/cwTvn2v7RC2VGJnwiNA7tFlE+2ZmxpJyAD5YXNRwI0LSploJEH0ClxYBS2gm07lid7fCOGAad/wNgutRai6DWKRNlMO9oPy1pyb1D/GVddKPgWHoYz6Ppinl2qgDkJlHvsmm0Ygtwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726859925; c=relaxed/simple;
	bh=x7GnpK+yKMocQnN+n+QmSpnaG8Q5LpDGnQM4BowiOyM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oIN8/NexnOVlSErPN3Jg4vnaOIkYDhvB/QpvAh1YPM7QLbhprWIueb/vm21Jcozav+/BkER9OYY1t4UB1CxQT8rzZRsTnBFCTzrlWHTZhwDUIRl2hlTzPIvVk4LfRB7r1ZUD0KRt/foIhKa/iJO1oP/6aAwKn/85Xkl1mSTz6C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPaxgv02; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPaxgv02"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7db53a20d1fso1655075a12.0
        for <dwarves@vger.kernel.org>; Fri, 20 Sep 2024 12:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726859923; x=1727464723; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yezXV1WX1irPiLLbyM+jtY9Yd+l/8vd3DSsnd6lDoq0=;
        b=fPaxgv02mBcnIRVufrHbYFQCvT9swmOhdZZ7jYX4j0KdT4IGwYdP81YpOq+VZ/nUTH
         xs01ygNz5dHP2kIiBip/naaI/ba8GyijUpZPfUwtdHbb1Wup16LUIjmiHCRlSdVadNQw
         O9Tbz7sN9ZEe0FIUJo+Y9+nV2NtnTCRS/oXFXIwNzWPvTe76hZGuDIvB3U1nODEQ5Ke6
         3xO6K3St2Pws7NnEmaIEJuE7560U02d8i5yjbF36e5n1U9HLeaB9i7eq1zhJE09ClxX6
         aYLAbmJPQTN/OEgSDBdwNug5joOTPrIZfOi8LFQgN5jisdRqG7oovK/RJmTckMhGtfab
         MNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726859923; x=1727464723;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yezXV1WX1irPiLLbyM+jtY9Yd+l/8vd3DSsnd6lDoq0=;
        b=r9XKe8G3gmhr4hrZVkbw2BLnxbM5lGJfNPVqxZJXE56uaGWHXGesFTjp44c7z59/U/
         twfj1AbosOMZKPbxF4ho+Mq2DcCm2YleSCZNRG+WKfI8aQkVTE2/WBjFfbxlOOdaFVDQ
         VLOV257gAmLaBcady43OitLPYyFueYrLMewWO2j+byYd6UiV7HJpToCgJIcj+Yr0SgP6
         +C7pbBJX4E6tgXMAkVDskAb4qxXgDi1zjzMCaPhbxEV0Q1Lb1yMdVocp3fkmbl2i7me7
         kSj0iebfIgyzCqJ3jXKt1lT4SXQj+iOZH9LdRK4cWYMkPJXPogXiYoktwf+VvYNGYr93
         qu7Q==
X-Gm-Message-State: AOJu0YzAr+qp7WWVWtV5uhdXagTI8HiEW+9yzKiJdc+9fWbiojxmSNzO
	nvAK5vQqVfnraziuDpXkY78ggrrfxeVsTyXDzihJUdgQKeHRrO4I
X-Google-Smtp-Source: AGHT+IF5ghfcpZOTGfIAtQ6lYW1lwRMSmr0uWEwnbq4b5RK1iqdtpYnaDKS5aT2ZYCpSiMNoWiQ5ag==
X-Received: by 2002:a05:6a20:2d22:b0:1cf:3ec5:e779 with SMTP id adf61e73a8af0-1d30c99bd8bmr4937102637.5.1726859922880;
        Fri, 20 Sep 2024 12:18:42 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7b1a2sm10186377b3a.132.2024.09.20.12.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 12:18:42 -0700 (PDT)
Message-ID: <2be35785218e6df18d3e05ddcaf0406227e05109.camel@gmail.com>
Subject: Re: [PATCH v2 dwarves 1/3] btf_encoder: record BTF-centric function
 state instead of DWARF-centric
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org
Cc: dwarves@vger.kernel.org, olsajiri@gmail.com, shung-hsi.yu@suse.com, 
	jirislaby@kernel.org
Date: Fri, 20 Sep 2024 12:18:37 -0700
In-Reply-To: <20240916134946.3893204-2-alan.maguire@oracle.com>
References: <20240916134946.3893204-1-alan.maguire@oracle.com>
	 <20240916134946.3893204-2-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-16 at 14:49 +0100, Alan Maguire wrote:

[...]

> When this is done, memory consumption peaks at 1Gb rather than
> ~4Gb for vmlinux generation.  Time taken appears to be approximately
> the same for -j1, but slightly faster for multiple threads;
> for example:

Hi Alan,

Sorry for delayed reply.
I tried this patch with selftests vmlinux and see huge reduction indeed:

$ /usr/bin/time -v \
    pahole -j1 --btf_features=3Dconsistent_func --btf_encode_detached=3Dold=
.btf vmlinux
  ...
  Maximum resident set size (kbytes): 3123660

$ /usr/bin/time -v \
    pahole -j1 --btf_features=3Dconsistent_func --btf_encode_detached=3Dnew=
.btf vmlinux
  ...
  Maximum resident set size (kbytes): 464400

[...]

> In terms of functions encoded, 360 fewer functions make it into
> BTF due to the different approach in consistency checking, but after
> examining these cases, they do appear to be legitimately inconsistent
> functions where the optimized versions have parameter mismatches
> with the non-optimized expectations.
>=20
> Mileage may vary of course, and any testing folks could do would
> be greatly appreciated!

Interestingly, I don't see any difference in generated "consistent"
funcs (BPF selftests kernel config, compiled using mainline clang):

$ comm -3 <(bpftool btf dump file new.btf | grep ' FUNC ' | sed "s/.*'\(.*\=
)'.*/\1/" | sort) \
          <(bpftool btf dump file old.btf | grep ' FUNC ' | sed "s/.*'\(.*\=
)'.*/\1/" | sort) \
          | tee | wc -l
0

A few nitpicks below, but overall looks great.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -669,18 +692,25 @@ static int32_t btf_encoder__tag_type(struct btf_enc=
oder *encoder, uint32_t tag_t
>  	return encoder->type_id_off + tag_type;
>  }
> =20
> -static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, =
struct ftype *ftype)
> +static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, =
struct ftype *ftype, struct elf_function *func)

It is a bit unfortunate that we now have this "doubled" representation
and both ftype and elf_function pointers have to be passed through
several layers.
Ihor (in CC) is now working on having single btf_encoder for each
processed CU (in order to be able to sort btf's by CU names before
merging to a single BTF for dedup, thus making reproducible builds
cheaper). I wonder if this could be further extended to have a
separate BTF for functions and merge only consistent functions from
this BTF to a final BTF.

[...]

> @@ -694,20 +724,34 @@ static int32_t btf_encoder__add_func_proto(struct b=
tf_encoder *encoder, struct f
> =20
>  	/* add parameters */
>  	param_idx =3D 0;
> -	ftype__for_each_parameter(ftype, param) {
> -		const char *name =3D parameter__name(param);
> +	if (ftype) {
> +		ftype__for_each_parameter(ftype, param) {
> +			const char *name =3D parameter__name(param);
> +
> +			type_id =3D param->tag.type =3D=3D 0 ? 0 : encoder->type_id_off + par=
am->tag.type;
> +			++param_idx;
> +			if (btf_encoder__add_func_param(encoder, name, type_id, param_idx =3D=
=3D nr_params))
> +				return -1;
> +		}
> =20
> -		type_id =3D param->tag.type =3D=3D 0 ? 0 : encoder->type_id_off + para=
m->tag.type;
>  		++param_idx;
> -		if (btf_encoder__add_func_param(encoder, name, type_id, param_idx =3D=
=3D nr_params))
> -			return -1;
> -	}
> +		if (ftype->unspec_parms)
> +			if (btf_encoder__add_func_param(encoder, NULL, 0, param_idx =3D=3D nr=
_params))
> +				return -1;
> +	} else {
> +		for (param_idx =3D 0; param_idx < nr_params; param_idx++) {
> +			struct btf_encoder_func_parm *p =3D &state->parms[param_idx];
> +			name =3D btf__name_by_offset(btf, p->name_off);
> =20
> -	++param_idx;
> -	if (ftype->unspec_parms)
> -		if (btf_encoder__add_func_param(encoder, NULL, 0, param_idx =3D=3D nr_=
params))
> -			return -1;
> +			/* adding BTF data may result in a move of the
> +			 * name string memory, so make a temporary copy.
> +			 */
> +			strncpy(tmp_name, name, sizeof(tmp_name));

When compiling with fresh gcc (14.2.1) there is a warning reported at this =
line:

btf_encoder.c:749:25: warning: =E2=80=98strncpy=E2=80=99 specified bound 12=
8 equals destination size [-Wstringop-truncation]
  749 |                         strncpy(tmp_name, name, sizeof(tmp_name));
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Which seems to be a legit warning, given section CAVEATS from strncpy man p=
age.
There is also a second warning like this (see below).
(when compiled with BUILD_TYPE=3DRelease).

> =20
> +			if (btf_encoder__add_func_param(encoder, tmp_name, p->type_id, param_=
idx =3D=3D nr_params))
> +				return -1;
> +		}
> +	}
>  	return id;
>  }
> =20
> @@ -831,53 +875,170 @@ static int32_t btf_encoder__add_decl_tag(struct bt=
f_encoder *encoder, const char

[...]

> -static bool funcs__match(struct btf_encoder *encoder, struct elf_functio=
n *func, struct function *f2)
> +static bool names__match(struct btf *btf1, const struct btf_type *t1,
> +			struct btf *btf2, const struct btf_type *t2)
>  {

[...]

> +static bool types__match(struct btf_encoder *encoder,
> +			 struct btf *btf1, int type_id1,
> +			 struct btf *btf2, int type_id2)
> +{

[...]

> +		switch (btf_kind(t1)) {
> +		case BTF_KIND_INT:

Nit: ints have a meaningful .size field and are followed by a u32 word,
     both should be compared.

> +		case BTF_KIND_FLOAT:
> +		case BTF_KIND_FWD:

Nit: BTF_KIND_FWD should go to default, fwd__kind steps over it.

> +		case BTF_KIND_TYPEDEF:
> +		case BTF_KIND_STRUCT:
> +		case BTF_KIND_UNION:
> +		case BTF_KIND_ENUM:
> +		case BTF_KIND_ENUM64:
> +			return names__match(btf1, t1, btf2, t2);
> +		case BTF_KIND_PTR:
> +		case BTF_KIND_VOLATILE:
> +		case BTF_KIND_CONST:
> +		case BTF_KIND_RESTRICT:
> +		case BTF_KIND_TYPE_TAG:
> +			id1 =3D t1->type;
> +			id2 =3D t2->type;
> +			break;
> +		case BTF_KIND_ARRAY: {
> +			const struct btf_array *a1 =3D btf_array(t1);
> +			const struct btf_array *a2 =3D btf_array(t2);
> +
> +			if (a1->nelems !=3D a2->nelems)
> +				return false;
> +			id1 =3D a1->type;
> +			id2 =3D a2->type;
> +			break;
> +		}
> +		case BTF_KIND_FUNC_PROTO: {
> +			const struct btf_param *p1 =3D btf_params(t1);
> +			const struct btf_param *p2 =3D btf_params(t2);
> +			int i, vlen =3D btf_vlen(t1);
> +
> +			if (vlen !=3D btf_vlen(t2))
> +				return false;
> +			if (!types__match(encoder, btf1, t1->type,
> +					  btf2, t2->type))
> +				return false;
> +			for (i =3D 0; i < vlen; i++, p1++, p2++) {
> +				if (!types__match(encoder, btf1, t1->type,
> +						  btf2, t2->type))
> +					return false;
> +			}
> +			return true;
> +		}
> +		default:
> +			return false;
> +		}
> +	} while (1);
> +
> +	return false;
> +}
> +
> +static bool funcs__match(struct btf_encoder *encoder, struct elf_functio=
n *func,
> +			 struct btf *btf1, struct btf_encoder_func_state *s1,
> +			 struct btf *btf2, struct btf_encoder_func_state *s2)
> +{
> +	uint8_t i;
> +
> +	if (!s1->initialized || !s2->initialized)
>  		return true;

Nit: is it even possible to get here when !s1->initialized || !s2->initiali=
zed?
     Maybe log something about inconsistent state?

> =20
> -	if (!func->state.got_proto)
> -		func->state.got_proto =3D proto__get(f1, func->state.proto, sizeof(fun=
c->state.proto));
> +	if (s1->nr_parms !=3D s2->nr_parms) {
> +		btf_encoder__log_func_skip(encoder, func,
> +					   "param count mismatch; %d params !=3D %d params\n",
> +					   s1->nr_parms, s2->nr_parms);
> +		return false;
> +	}
> +	if (!types__match(encoder, btf1, s1->ret_type_id, btf2, s2->ret_type_id=
)) {
> +		btf_encoder__log_func_skip(encoder, func, "return type mismatch\n");
> +		return false;
> +	}
> +	if (s1->nr_parms =3D=3D 0)
> +		return true;
> =20
> -	if (proto__get(f2, proto, sizeof(proto))) {
> -		if (strcmp(func->state.proto, proto) !=3D 0) {
> -			if (encoder->verbose)
> -				printf("function mismatch for '%s'('%s'): '%s' !=3D '%s'\n",
> -				       name, f1->alias ?: name,
> -				       func->state.proto, proto);
> +	for (i =3D 0; i < s1->nr_parms; i++) {
> +		if (!types__match(encoder, btf1, s1->parms[i].type_id,
> +				  btf2, s2->parms[i].type_id)) {
> +			if (encoder->verbose) {
> +				const char *p1 =3D btf__name_by_offset(btf1, s1->parms[i].name_off);
> +				const char *p2 =3D btf__name_by_offset(btf2, s2->parms[i].name_off);
> +
> +				btf_encoder__log_func_skip(encoder, func,
> +							   "param type mismatch for param#%d %s %s %s\n",
> +							   i + 1,
> +							   p1 ?: "",
> +							   p1 && p2 ? "!=3D" : "",
> +							   p2 ?: "");
> +			}
>  			return false;
>  		}
>  	}
> @@ -886,119 +1047,212 @@ static bool funcs__match(struct btf_encoder *enc=
oder, struct elf_function *func,

[...]

> -static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct=
 function *fn)
> +static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct=
 function *fn, struct elf_function *func)
>  {

[...]

> +	if (!fn) {
> +		struct btf_encoder_func_state *state =3D &func->state;
> +		uint16_t idx;
> +
> +		if (!state || state->nr_annots =3D=3D 0)
> +			return 0;
> +
> +		for (idx =3D 0; idx < state->nr_annots; idx++) {
> +			struct btf_encoder_func_annot *a =3D &state->annots[idx];
> +
> +			value =3D btf__str_by_offset(encoder->btf, a->value);
> +			/* adding BTF data may result in a mode of the
> +			 * value string memory, so make a temporary copy.
> +			 */
> +			strncpy(tmp_value, value, sizeof(tmp_value));

(Second warning from gcc 14.2.1 is reported here)

> +			component_idx =3D a->component_idx;
> +
> +			tag_type_id =3D btf_encoder__add_decl_tag(encoder, tmp_value, btf_fn_=
id, component_idx);
> +			if (tag_type_id < 0)
> +				break;
> +		}

[...]

