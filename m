Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5EB3AB285
	for <dwarves@vger.kernel.org>; Wed,  3 Jun 2026 20:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780519358; cv=none; b=SJ+3bAfFJtAaEGtl/VFCYzwFmZDFnM0Xrrj+CvpPd/iKrfu8e58VlLWgetoYwNyAzdqUicfZCv/abVAJxtEHMd9sCN0GNkdsUtlyJ7mYMxJlWf54Xn8gFi4SDdXButGR32UjpS67op7yFRI9p/A8QXWwCSu9wAE2YcB24Fn0tQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780519358; c=relaxed/simple;
	bh=BsieX/ax1mNutVYDAh2Daj1QSKmPQlrh5nHtWvE8Ohw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=EzqcBFSbampPHFGAenr3Tsa6GZv2OdBP/WiE5GFTXzkXDkV5WYtS9SWNov3nKmVyfgzlp+8TM2bbVifeKXnz2uBtMDtOdTgNiWdrm2POmypEFcPg/b8fR6M1AjKB8loJTjeZ7uj+aPIpXAK/Y51sQPcOW+pd6KtQvuOY9O5fx40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=VZdWF8DV; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="VZdWF8DV"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-304ddfcf72cso7569935eec.0
        for <dwarves@vger.kernel.org>; Wed, 03 Jun 2026 13:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780519356; x=1781124156; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvT2+x4G9JpkaKmus1uX6Ef7BTSEX4iWTHvHXLMocXA=;
        b=VZdWF8DVJ3uQE5tkRNBcBRXw+t3VLlGip/aQOBbkILNosElUZceeTj0JIuo230/Rio
         NtOeUuzrgkIxJZSjF8FHjOMYLQp1zJCmPSv9K7BMsZh6HWjWfTpfW2aevEosJK8uqXTp
         AEOgpKb8KAIqScsBsfpoHM6bMP+7W0R0Q/BcleK0ZOce3mYSD/CT2x7JWX+ZU+SCl44o
         qBT2zpcX6MYrUAiGwDeufNkCmi5k0t5x9Gs4rNlkGW/AxOKis8MZ9SbYPkRAwebl+V8h
         KuMpI7k9YBHMpsHxDYKnjl3lxvGVBKtMUu/gcuqTRbQR8ncNK4Uw1IY9q0MZ4fYflZmo
         M/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780519356; x=1781124156;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RvT2+x4G9JpkaKmus1uX6Ef7BTSEX4iWTHvHXLMocXA=;
        b=UZIb0gQh+2DQ5U9xP6EBrg6lHm666uZcALnD1pScK5Q+1kYSZYfpJEToLhOJZxYhO3
         xa4xHglZ6lnB9LHG/kSfCTX3jd6/XhN+6WlhqB82WApfjCp5YsXjNycTklr6E2VouLTn
         r+up/ikjJTKlliNnLGksfJSc9S9F1hhnjIdU48ROCoW9DpdCDz7bgMhQada6ZGWEPtzB
         wdBnHqd5Aq5EW203gEY2Lwl03M1VNYyeSHrTDr0qcLg4zjqGXW0fLmj4pIbaDteD69iq
         gGo+0S3dDglc6usAQxL6yj91Ch66UGsP/saFhTKqqrXT6Rh8PkN0JZiZcW0iDNw+5J8P
         Bl6w==
X-Forwarded-Encrypted: i=1; AFNElJ9i9Dv8H6QkFx/RekQqTgLAQC2R4PfeWE5QFEPDK/QVaeQafusLuuDKhTT7McELN7+mwEiRv9Ke@vger.kernel.org
X-Gm-Message-State: AOJu0Yx095DSVGGVaCXJvllcmK2RuwYWML9QHvAPhTfiZofaVSsf+JxM
	VlLwpf4f51mcK5uCsuA/j/JwKfbhdVS3UjYd1nBNl7hGfQMoJktDa19RR1DRlMpOSdo=
X-Gm-Gg: Acq92OFmrp7KoTBq6JOHOu37v15y0pffUwmp/i8SbYdFiA2falD5P6EJhZ34pyXkaNb
	5muw4Q7k0v3bkQaKbPMhGSluhtsYRLDW2KkTLJB6tty8fmS3xQHtfJu29WjqLFdDHffzFwKMlyV
	vyIj5g0pOTGjV3Z4yzkhoQi2CEhQev/sY4JcdY2NZWZhL9UAhrbt94z23XMLqWzG3Rv/aEWhJfd
	643eJv/y6MukjCSJIA8eKyqzXqXGbr6iu6IixaaSqvRHFDi+6Bqp6MQyIk5FKB89IdaV88J0h1x
	/4XeDPeuhEfkfqh6O28CImoiv16aI0hQh9tDwwa1rJtc5PVvaoAlYRzNMrjP2cRc8olmKc8TMWF
	X5rsrtrxJJ4IFoyXZb3is8Ph8iAbF2Et1/UJdG0NCYMbopowtg2HnBi33zHT3ml3DJceqJilsUM
	xVVs3LG8xNz2DkelM=
X-Received: by 2002:a05:7300:dc85:b0:2ea:edc0:4fbe with SMTP id 5a478bee46e88-3074fa9f774mr2271452eec.14.1780519356030;
        Wed, 03 Jun 2026 13:42:36 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::202f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df75ff6sm3369927eec.26.2026.06.03.13.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 13:42:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jun 2026 16:42:33 -0400
Message-Id: <DIZPFN4T6C21.XQFZ3BP37AJD@etsalapatis.com>
Subject: Re: [PAHOLE v4 2/3] dwarf_loader: Add support for
 DW_TAG_GNU_annotation
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Vineet Gupta" <vineet.gupta@linux.dev>, <dwarves@vger.kernel.org>
Cc: <bpf@vger.kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 <acme@kernel.org>, "Alan Maguire" <alan.maguire@oracle.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <jose.marchesi@oracle.com>, "David
 Faust" <david.faust@oracle.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260602195512.1511013-1-vineet.gupta@linux.dev>
 <20260602195512.1511013-2-vineet.gupta@linux.dev>
In-Reply-To: <20260602195512.1511013-2-vineet.gupta@linux.dev>

On Tue Jun 2, 2026 at 3:55 PM EDT, Vineet Gupta wrote:
> gcc 16 was the first release to support DW_TAG_GNU_annotations and this
> patch enables the same in pahole. Bulk of changes are dwarf_loader but
> btf_encoder also gains support with minimal changes.
>
> GCC encodes btf_type_tag and btf_decl_tag annotations differently from
> LLVM. While LLVM uses DW_TAG_LLVM_annotation (0x6000) as child DIEs,
> GCC uses DW_TAG_GNU_annotation (0x6001) as standalone sibling DIEs
> referenced via DW_AT_GNU_annotation (0x2139) attributes, with chaining
> through the same attribute on annotation DIEs themselves.
>
> Handle both encoding styles:
>
> For btf_type_tag (pointer annotations):
> - Recognize DW_TAG_GNU_annotation alongside DW_TAG_LLVM_annotation in
>   child annotation scanning.
> - Follow DW_AT_GNU_annotation attribute chains on pointer types for
>   GCC-style btf_type_tag resolution.
> - Normalize DW_TAG_GNU_annotation to DW_TAG_LLVM_annotation in the
>   internal representation so downstream code works unchanged.
>
> For btf_decl_tag (function/struct/member annotations):
> - Add add_gnu_annotation_chain() to follow DW_AT_GNU_annotation
>   attribute chains on function, struct, and member DIEs.
> - GCC puts DW_AT_GNU_annotation on the function/struct DIE itself
>   (not as child DIEs), referencing sibling annotation DIEs that chain
>   via the same attribute.
>
> Also:
> - Silently skip standalone DW_TAG_GNU_annotation DIEs at CU level.
> - Add tag__is_annotation() helper macro for annotation tag checks.
> - Rename add_llvm_annotation -> add_tag_annotation,
>   skip_llvm_annotations -> skip_tag_annotations since these now
>   handle both LLVM and GNU annotation formats.
>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

One thing, we accept for both LLVM and GCC annotation tags being used as
LLVM annotation tags because we check against tags__is_annotation().
This is valid imo.

> ---
> Changes since v3 [3]
>  - Add helper tag__is_annotation [Emil]
>  - Rename some functions containing "llvm" as they are common to LLVM/GCC=
 tags [Emil]
>  - Deduplicate checks before loop and inside loop in add_gnu_annotation_c=
hain() and check_gnu_attr [Arnaldo]
>  - Fix some typos and move some comments [Emi]
>
> Changes since v2 [2]
>  - Removed loop detection logic [Alan]
>  - Move test changes to different patch [Alan]
>
> Changes since v1 [1]
>  - NFC Reduce indentation with early exits (Alexei offlist)
>
> [3] https://lore.kernel.org/bpf/20260601183511.594100-2-vineet.gupta@linu=
x.dev/
> [2] https://lore.kernel.org/bpf/20260528223616.2035618-2-vineet.gupta@lin=
ux.dev/
> [1] https://lore.kernel.org/bpf/20260526181818.4159927-2-vineet.gupta@lin=
ux.dev/
> ---
>  btf_encoder.c     |   1 +
>  dutil.h           |  11 +++++
>  dwarf_loader.c    | 105 +++++++++++++++++++++++++++++++++++++++-------
>  dwarves.h         |   2 +-
>  dwarves_fprintf.c |  12 ++++--
>  5 files changed, 110 insertions(+), 21 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 633bc6162ce0..d5af706d7638 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1831,6 +1831,7 @@ static int btf_encoder__encode_tag(struct btf_encod=
er *encoder, struct tag *tag,
>  		name =3D namespace__name(tag__namespace(tag));
>  		return btf_encoder__add_ref_type(encoder, BTF_KIND_TYPEDEF, ref_type_i=
d, name, false);
>  	case DW_TAG_LLVM_annotation:
> +	case DW_TAG_GNU_annotation:
>  		name =3D tag__btf_type_tag(tag)->value;
>  		return btf_encoder__add_ref_type(encoder, BTF_KIND_TYPE_TAG, ref_type_=
id, name, false);
>  	case DW_TAG_structure_type:
> diff --git a/dutil.h b/dutil.h
> index ff78aa6dfd10..be02c68cf4a7 100644
> --- a/dutil.h
> +++ b/dutil.h
> @@ -35,6 +35,17 @@
>  #define DW_TAG_LLVM_annotation 0x6000
>  #endif
> =20
> +#ifndef DW_TAG_GNU_annotation
> +#define DW_TAG_GNU_annotation 0x6001
> +#endif
> +
> +#ifndef DW_AT_GNU_annotation
> +#define DW_AT_GNU_annotation 0x2139
> +#endif
> +
> +#define tag__is_annotation(tag) \
> +	((tag) =3D=3D DW_TAG_LLVM_annotation || (tag) =3D=3D DW_TAG_GNU_annotat=
ion)
> +
>  static inline __attribute__((const)) bool is_power_of_2(unsigned long n)
>  {
>          return (n !=3D 0 && ((n & (n - 1)) =3D=3D 0));
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 42a0f3f74ce3..14f71c9043aa 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -908,7 +908,12 @@ static int tag__recode_dwarf_bitfield(struct tag *ta=
g, struct cu *cu, uint16_t b
>  	return -ENOMEM;
>  }
> =20
> -static int add_llvm_annotation(Dwarf_Die *die, int component_idx, struct=
 conf_load *conf,
> +static bool die__tag_is_annotation(Dwarf_Die *die)
> +{
> +	return tag__is_annotation(dwarf_tag(die));
> +}
> +
> +static int add_tag_annotation(Dwarf_Die *die, int component_idx, struct =
conf_load *conf,
>  			       struct list_head *head)
>  {
>  	struct llvm_annotation *annot;
> @@ -943,16 +948,40 @@ static int add_child_llvm_annotations(Dwarf_Die *di=
e, int component_idx,
> =20
>  	die =3D &child;
>  	do {
> -		if (dwarf_tag(die) =3D=3D DW_TAG_LLVM_annotation) {
> -			ret =3D add_llvm_annotation(die, component_idx, conf, head);
> -			if (ret)
> -				return ret;
> -		}
> +		if (!die__tag_is_annotation(die))
> +			continue;
> +
> +		ret =3D add_tag_annotation(die, component_idx, conf, head);
> +		if (ret)
> +			return ret;
>  	} while (dwarf_siblingof(die, die) =3D=3D 0);
> =20
>  	return 0;
>  }
> =20
> +/*
> + * Handle gcc style btf_decl_tag annotations for functions/struct/member=
 tags.
> + * Pointers are handled separately, inline in die__create_new_pointer_ta=
g()
> + */
> +static int add_gnu_annotation_chain(Dwarf_Die *die, int component_idx,
> +				    struct conf_load *conf, struct list_head *head)
> +{
> +	Dwarf_Attribute attr;
> +	Dwarf_Die annot_die;
> +
> +	while (dwarf_attr(die, DW_AT_GNU_annotation, &attr) !=3D NULL &&
> +	       dwarf_formref_die(&attr, &annot_die) !=3D NULL &&
> +	       dwarf_tag(&annot_die) =3D=3D DW_TAG_GNU_annotation) {
> +		int ret =3D add_tag_annotation(&annot_die, component_idx, conf, head);
> +		if (ret)
> +			return ret;
> +
> +		die =3D &annot_die;
> +	}
> +
> +	return 0;
> +}
> +
>  int class_member__dwarf_recode_bitfield(struct class_member *member,
>  					struct cu *cu)
>  {
> @@ -1596,6 +1625,8 @@ static struct btf_type_tag_type *die__create_new_bt=
f_type_tag_type(Dwarf_Die *di
>  		return NULL;
> =20
>  	tag__init(&tag->tag, cu, die);
> +	/* Normalize DW_TAG_GNU_annotation to DW_TAG_LLVM_annotation internally=
 */
> +	tag->tag.tag =3D DW_TAG_LLVM_annotation;
>  	tag->value =3D attr_string(die, DW_AT_const_value, conf);
>  	return tag;
>  }
> @@ -1637,19 +1668,21 @@ static struct tag *die__create_new_pointer_tag(Dw=
arf_Die *die, struct cu *cu,
>  {
>  	struct btf_type_tag_ptr_type *tag =3D NULL;
>  	Dwarf_Die *cdie, child;
> +	Dwarf_Attribute attr;
> +	Dwarf_Die annot_die;
>  	const char *name;
> =20
> -	/* If no child tags or skipping btf_type_tag encoding, just create a ne=
w tag
> -	 * and return
> -	 */
> -	if (!dwarf_haschildren(die) || dwarf_child(die, &child) !=3D 0 ||
> -	    conf->skip_encoding_btf_type_tag)
> +	/* If skipping btf_type_tag encoding, just create a new tag, return */
> +	if (conf->skip_encoding_btf_type_tag)
>  		return tag__new(die, cu);
> =20
> -	/* Otherwise, check DW_TAG_LLVM_annotation child tags */
> +	if (!dwarf_haschildren(die) || dwarf_child(die, &child) !=3D 0)
> +		goto check_gnu_attr;
> +
> +	/* Handle LLVM style annotation tags if present */
>  	cdie =3D &child;
>  	do {
> -		if (dwarf_tag(cdie) !=3D DW_TAG_LLVM_annotation)
> +		if (!die__tag_is_annotation(cdie))
>  			continue;
> =20
>  		/* Only check btf_type_tag annotations */
> @@ -1662,6 +1695,26 @@ static struct tag *die__create_new_pointer_tag(Dwa=
rf_Die *die, struct cu *cu,
>  			return NULL;
>  	} while (dwarf_siblingof(cdie, cdie) =3D=3D 0);
> =20
> +check_gnu_attr:
> +	if (tag !=3D NULL)
> +		goto out;
> +
> +	/* Handle GCC-style DW_AT_GNU_annotation attribute */
> +	while (dwarf_attr(die, DW_AT_GNU_annotation, &attr) !=3D NULL &&
> +	       dwarf_formref_die(&attr, &annot_die) !=3D NULL &&
> +	       dwarf_tag(&annot_die) =3D=3D DW_TAG_GNU_annotation) {
> +		name =3D attr_string(&annot_die, DW_AT_name, conf);
> +		if (strcmp(name, "btf_type_tag") !=3D 0)
> +			break;
> +
> +		tag =3D die__add_btf_type_tag(tag, die, &annot_die, cu, conf);
> +		if (tag =3D=3D NULL)
> +			return NULL;
> +
> +		die =3D &annot_die;
> +	}
> +
> +out:
>  	return tag ? &tag->tag : tag__new(die, cu);
>  }
> =20
> @@ -1690,6 +1743,12 @@ static struct tag *die__create_new_class(Dwarf_Die=
 *die, struct cu *cu, struct c
>  		}
>  	}
> =20
> +	if (class !=3D NULL &&
> +	    add_gnu_annotation_chain(die, -1, conf, &class->type.namespace.anno=
ts) !=3D 0) {
> +		class__delete(class, cu);
> +		class =3D NULL;
> +	}
> +
>  	return class ? &class->type.namespace.tag : NULL;
>  }
> =20
> @@ -2051,11 +2110,14 @@ static int die__process_class(Dwarf_Die *die, str=
uct type *class,
>  			cu__hash(cu, &member->tag);
>  			if (add_child_llvm_annotations(die, member_idx, conf, &class->namespa=
ce.annots))
>  				return -ENOMEM;
> +			if (add_gnu_annotation_chain(die, member_idx, conf, &class->namespace=
.annots))
> +				return -ENOMEM;
>  			member_idx++;
>  		}
>  			continue;
>  		case DW_TAG_LLVM_annotation:
> -			if (add_llvm_annotation(die, -1, conf, &class->namespace.annots))
> +		case DW_TAG_GNU_annotation:
> +			if (add_tag_annotation(die, -1, conf, &class->namespace.annots))
>  				return -ENOMEM;
>  			continue;
>  		default: {
> @@ -2360,7 +2422,8 @@ static int die__process_function(Dwarf_Die *die, st=
ruct ftype *ftype,
>  				goto out_enomem;
>  			continue;
>  		case DW_TAG_LLVM_annotation:
> -			if (add_llvm_annotation(die, -1, conf, &(tag__function(&ftype->tag)->=
annots)))
> +		case DW_TAG_GNU_annotation:
> +			if (add_tag_annotation(die, -1, conf, &(tag__function(&ftype->tag)->a=
nnots)))
>  				goto out_enomem;
>  			continue;
>  		default:
> @@ -2408,6 +2471,12 @@ static struct tag *die__create_new_function(Dwarf_=
Die *die, struct cu *cu, struc
>  		function =3D NULL;
>  	}
> =20
> +	if (function !=3D NULL &&
> +	    add_gnu_annotation_chain(die, -1, conf, &function->annots) !=3D 0) =
{
> +		function__delete(function, cu);
> +		function =3D NULL;
> +	}
> +
>  	return function ? &function->proto.tag : NULL;
>  }
> =20
> @@ -2469,6 +2538,9 @@ static struct tag *__die__process_tag(Dwarf_Die *di=
e, struct cu *cu,
>  		 */
>  		tag =3D &unsupported_tag;
>  		break;
> +	case DW_TAG_GNU_annotation:
> +		tag =3D &unsupported_tag;
> +		break;
>  	case DW_TAG_label:
>  		if (conf->ignore_labels)
>  			tag =3D &unsupported_tag; // callers will assume conf->ignore_labels =
is true
> @@ -2494,7 +2566,8 @@ static int die__process_unit(Dwarf_Die *die, struct=
 cu *cu, struct conf_load *co
>  			// XXX special case DW_TAG_dwarf_procedure, appears when looking at a=
 recent ~/bin/perf
>  			// Investigate later how to properly support this...
>  			if (dwarf_tag(die) !=3D DW_TAG_dwarf_procedure &&
> -			    dwarf_tag(die) !=3D DW_TAG_label) // conf->ignore_labels =3D=3D t=
rue, see die__process_tag()
> +			    dwarf_tag(die) !=3D DW_TAG_label && // conf->ignore_labels =3D=3D=
 true, see die__process_tag()
> +			    dwarf_tag(die) !=3D DW_TAG_GNU_annotation)
>  				tag__print_not_supported(die);
>  			continue;
>  		}
> diff --git a/dwarves.h b/dwarves.h
> index 5ec16e750e83..75c311a2f8ee 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -670,7 +670,7 @@ static inline int tag__is_tag_type(const struct tag *=
tag)
>  	       tag->tag =3D=3D DW_TAG_volatile_type ||
>  	       tag->tag =3D=3D DW_TAG_atomic_type ||
>  	       tag->tag =3D=3D DW_TAG_unspecified_type ||
> -	       tag->tag =3D=3D DW_TAG_LLVM_annotation;
> +	       tag__is_annotation(tag->tag);
>  }
> =20
>  static inline const char *tag__decl_file(const struct tag *tag,
> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> index 1ec478c2a027..757e4992a1f7 100644
> --- a/dwarves_fprintf.c
> +++ b/dwarves_fprintf.c
> @@ -140,6 +140,8 @@ const char *dwarf_tag_name(const uint32_t tag)
>  		return dwarf_gnu_tag_names[tag - DW_TAG_MIPS_loop];
>  	else if (tag =3D=3D DW_TAG_LLVM_annotation)
>  		return "LLVM_annotation";
> +	else if (tag =3D=3D DW_TAG_GNU_annotation)
> +		return "GNU_annotation";
>  	return "INVALID";
>  }
> =20
> @@ -658,6 +660,7 @@ static const char *__tag__name(const struct tag *tag,=
 const struct cu *cu,
>  		snprintf(bf, len, "%s", variable__name(tag__variable(tag)));
>  		break;
>  	case DW_TAG_LLVM_annotation:
> +	case DW_TAG_GNU_annotation:
>  		type =3D cu__type(cu, tag->type);
>  		if (type =3D=3D NULL && tag->type !=3D 0)
>  			tag__id_not_found_snprintf(bf, len, tag->type);
> @@ -723,7 +726,7 @@ static size_t type__fprintf_stats(struct type *type, =
const struct cu *cu,
>  	return printed;
>  }
> =20
> -static type_id_t skip_llvm_annotations(const struct cu *cu, type_id_t id=
)
> +static type_id_t skip_tag_annotations(const struct cu *cu, type_id_t id)
>  {
>  	struct tag *type;
> =20
> @@ -731,7 +734,7 @@ static type_id_t skip_llvm_annotations(const struct c=
u *cu, type_id_t id)
>  		if (id =3D=3D 0)
>  			break;
>  		type =3D cu__type(cu, id);
> -		if (type =3D=3D NULL || type->tag !=3D DW_TAG_LLVM_annotation || type-=
>type =3D=3D id)
> +		if (type =3D=3D NULL || !tag__is_annotation(type->tag) || type->type =
=3D=3D id)
>  			break;
>  		id =3D type->type;
>  	}
> @@ -838,7 +841,7 @@ inner_struct:
>  next_type:
>  	switch (type->tag) {
>  	case DW_TAG_pointer_type: {
> -		type_id_t ptype_id =3D skip_llvm_annotations(cu, type->type);
> +		type_id_t ptype_id =3D skip_tag_annotations(cu, type->type);
> =20
>  		if (ptype_id !=3D 0) {
>  			int n;
> @@ -936,7 +939,8 @@ print_modifier: {
>  		else
>  			printed +=3D enumeration__fprintf(type, &tconf, fp);
>  		break;
> -	case DW_TAG_LLVM_annotation: {
> +	case DW_TAG_LLVM_annotation:
> +	case DW_TAG_GNU_annotation: {
>  		struct tag *ttype =3D cu__type(cu, type->type);
>  		if (ttype) {
>  			type =3D ttype;

