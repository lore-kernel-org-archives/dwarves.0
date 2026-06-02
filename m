Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E972D23A6
	for <dwarves@vger.kernel.org>; Tue,  2 Jun 2026 01:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780362270; cv=none; b=uxH0kkPbEyVJOvL7v6CDk6q9W4+2kSZTSX3bU8HWVqh3pq3hMq+jwGPoyDyfRde6fGj5yhINBsHGcBPbJtCjeAJ5Wi3N9YHSEwBkBI/UEBi274BlSnZEeHUAxhwyBh/yVQdC8fzCrdQf+udlAsBKIMJfCT6L3qWORZ+H8kcsCDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780362270; c=relaxed/simple;
	bh=Ql8vq1xR9tsUsD1dWB8RlcejMDnwtkyA3X3mQ0CFekQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=K6MisijurDnf4+GhI8RQ9DDCCr4ZXEiUVEwAV2k6WOaXF11a4iJxiy5YUtb1jYcKIzrvoMWcdVrvf7AIk0oA2wJL7WxlZllaYZvTjd0/xWfAMqptcTeV6PYYcMPd3n3dMvxQC767YKthbJgcRpG4LgSb782J6z64jQvEVMwJPUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Vqt6P1NX; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Vqt6P1NX"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-304f0039c02so7020895eec.1
        for <dwarves@vger.kernel.org>; Mon, 01 Jun 2026 18:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780362267; x=1780967067; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDY71PuzhgL1hDqcewB/vdE2cj5ti+RW7PqBPWItBRY=;
        b=Vqt6P1NXjb3kap7lCw5bzUd06FB7XG0kJYLr87gWp/BRfDUfOQc64pv94TNOj0/sHz
         LISSSj+EUeijF2MDzYld7ZPihRWwhQKJ4ZWhdX11uQxj533HRHhcKEXZPXDBKuY7nqop
         kuiTulPrLf6sMYfo5yAdt9CRZjEXDL1l+qgQ0/ikCNY9YRGyeAb2VJmYDcPwATilM4Mt
         AV9Yl01vNh8LMhSf5W9/U2iC7RRlUrhEQSwaxqaw9tBRZBHQ5x+mmBXhX9hko3G51sx0
         40swfg/O3mk4MCBYM2onTdIsaK1mQSh30DLWzLBtTczYYi1yoaua0aMIfpjvChVWnsww
         CYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780362267; x=1780967067;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mDY71PuzhgL1hDqcewB/vdE2cj5ti+RW7PqBPWItBRY=;
        b=SkszxtnJePLOG8Qc4w9WbDsfdcl0oLFzuxjazTfiLk+pGr7JDFaBg9CkBF8vb9xRcW
         7LAIGOiJdf5PKUf7V7WspxTA4ElQIdT7TNLIhjdc70S9N3pbgLIoCDMtmTVGzHk62BSb
         PeGJpLcZ97Zy+5yD7lT90wO7A5S48avCev0doxjdDqHYNw87jVMOY6dVLm6hALkKUUjy
         POYRk6k+8g9M/SDyuljNRSmWvTGHa7aqyBRK5RnqjPJFLNTojFP+ATcwu18TtlqH5Wrf
         XPx96KOCz5lp2wQ3k/ymODhPsNxgyyUzGuP49+P6l79Il166JZW+4ssi23XGeH3QEqu0
         HiNg==
X-Forwarded-Encrypted: i=1; AFNElJ/8AklXqrWX3tJKw/g1b1dgGyG2splWsJ/JOGShahI232E9ecMTohn9sE6miFD2nffI4nB/8ukF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw33bwRfZTwl85uNHiKa38H3DlMgW57g7TcqT+60gbhYYEPv65E
	AamBilevZCOMdyBBvrIycQJjIFPPRYzoUuv6Bv63nzm1Y40R5IJ9Ph966NKhNC3qpGY=
X-Gm-Gg: Acq92OGLWl9TtwXWzM7zR8QCyfHGFPo3RA0BKbWiOJqR4OZWXYAL6cc4pI2ucAUglNc
	J8S4YVDq3/HN7VltZqqFB4mW8qVBcEH8niQ/lvCWG0hv0No8bVDr/OsZAikvaG9XByADRiCpIKG
	i9lWjS8MjLFVrgT4U9/+guqNO3ggIjE+dKfaDx9HzcaXkwEZi8fsMOjuZuRCSQ13naEozgCoIp0
	wxdXnUoSZi/cyzd2YkSrw245krQbR667i009E9mZnDxr4opuP+Gkz3nsc2+qq0st3WXpfYkc2dG
	jGpHJBRGLlx2LChC4rPTc2ED2x/zK/qqbP05E8rEm58UHOcIOa38nQNI8CLoM92RAoOnFEbESyC
	GZ5dcd0l78ghK2AO8qZQ3a42ChLajxaLhFt/sNbUMeMWYTWIv+4hYXHvdx4G0vZ2Thp/nTchOoX
	fW7VWIDGAA+8OXHDo=
X-Received: by 2002:a05:7301:5803:b0:2d9:6373:ad22 with SMTP id 5a478bee46e88-304fa4ff6ebmr6051547eec.12.1780362266795;
        Mon, 01 Jun 2026 18:04:26 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::4f12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed563d09sm10141117eec.15.2026.06.01.18.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 18:04:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 21:04:23 -0400
Message-Id: <DIY5R0P9CJKJ.3S0RU6SR33V49@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 <acme@kernel.org>, "Alan Maguire" <alan.maguire@oracle.com>,
 <jose.marchesi@oracle.com>, "David Faust" <david.faust@oracle.com>
Subject: Re: [PAHOLE v3 2/3] dwarf_loader: Add support for
 DW_TAG_GNU_annotation
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Vineet Gupta" <vineet.gupta@linux.dev>, <dwarves@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260601183511.594100-1-vineet.gupta@linux.dev>
 <20260601183511.594100-2-vineet.gupta@linux.dev>
In-Reply-To: <20260601183511.594100-2-vineet.gupta@linux.dev>

On Mon Jun 1, 2026 at 2:35 PM EDT, Vineet Gupta wrote:
> gcc 16 was first release to support DW_TAG_GNU_annotation and this patch
> enables the same in pahole. Bulk of changes are in dwarf_loader but
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
>   GCC-style btf_type_tag resolution, with cycle detection.
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
> - Update pfunct-btf-decl-tags.sh test to use GCC 16+ when available and
>   now passes.
>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> ---
> Changes since v2 [2]
>  - Removed loop detection logic
>  - Move test changes to different patch
>
> Changes since v1 [1]
>  - NFC Reduce indentation with early exits (Alexei offlist)
>
> [2] https://lore.kernel.org/bpf/20260528223616.2035618-2-vineet.gupta@lin=
ux.dev/
> [1] https://lore.kernel.org/bpf/20260526181818.4159927-2-vineet.gupta@lin=
ux.dev/
> ---
>
>  btf_encoder.c     |   1 +
>  dutil.h           |   8 ++++
>  dwarf_loader.c    | 102 ++++++++++++++++++++++++++++++++++++++++++----
>  dwarves.h         |   3 +-
>  dwarves_fprintf.c |   8 +++-
>  5 files changed, 110 insertions(+), 12 deletions(-)
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
> index ff78aa6dfd10..abe0e62b412f 100644
> --- a/dutil.h
> +++ b/dutil.h
> @@ -35,6 +35,14 @@
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
>  static inline __attribute__((const)) bool is_power_of_2(unsigned long n)
>  {
>          return (n !=3D 0 && ((n & (n - 1)) =3D=3D 0));
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 8b5b526299b5..878565884f85 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -908,6 +908,12 @@ static int tag__recode_dwarf_bitfield(struct tag *ta=
g, struct cu *cu, uint16_t b
>  	return -ENOMEM;
>  }
> =20
> +static bool die__tag_is_annotation(Dwarf_Die *die)
> +{
> +	unsigned int tag =3D dwarf_tag(die);
> +	return tag =3D=3D DW_TAG_LLVM_annotation || tag =3D=3D DW_TAG_GNU_annot=
ation;

Can we also have a shorthand static inline for

tag =3D=3D DW_TAG_LLVM_annotation || tag =3D=3D DW_TAG_GNU_annotation

? Would be nice in a bunch of places.

> +}
> +
>  static int add_llvm_annotation(Dwarf_Die *die, int component_idx, struct=
 conf_load *conf,
>  			       struct list_head *head)

>  {
> @@ -943,7 +949,7 @@ static int add_child_llvm_annotations(Dwarf_Die *die,=
 int component_idx,

Since this is not just LLVM annotations can we rename it to
*_tag_annotations or something similar? Same for all other llvm-named
fucntions we are explicitly handling GCC tags in.

> =20
>  	die =3D &child;
>  	do {
> -		if (dwarf_tag(die) =3D=3D DW_TAG_LLVM_annotation) {
> +		if (die__tag_is_annotation(die)) {
>  			ret =3D add_llvm_annotation(die, component_idx, conf, head);
>  			if (ret)
>  				return ret;
> @@ -953,6 +959,35 @@ static int add_child_llvm_annotations(Dwarf_Die *die=
, int component_idx,
>  	return 0;
>  }
> =20
> +/* Handle gcc sytle btf_decl_tag annotations for functions/struct/member=
 tags

Typo: sytle -> style

> + * Pointers are handled seperately, inline in die__create_new_pointer_ta=
g ()

Typo: seperately -> separately, also maybe remove the space before the ()

> + */
> +static int add_gnu_annotation_chain(Dwarf_Die *die, int component_idx,
> +				    struct conf_load *conf, struct list_head *head)
> +{
> +	Dwarf_Attribute attr;
> +	Dwarf_Die annot_die;
> +
> +	if (dwarf_attr(die, DW_AT_GNU_annotation, &attr) =3D=3D NULL ||
> +	    dwarf_formref_die(&attr, &annot_die) =3D=3D NULL)
> +		return 0;
> +
> +	for (;;) {
> +		if (dwarf_tag(&annot_die) !=3D DW_TAG_GNU_annotation)
> +			break;
> +
> +		int ret =3D add_llvm_annotation(&annot_die, component_idx, conf, head)=
;

E.g., here imo it makes sense to keep the llvm name since AFAICT this is
one of the places where we normalize the GCC tags.

> +		if (ret)
> +			return ret;
> +
> +		if (dwarf_attr(&annot_die, DW_AT_GNU_annotation, &attr) =3D=3D NULL ||
> +		    dwarf_formref_die(&attr, &annot_die) =3D=3D NULL)
> +			break;
> +	}
> +
> +	return 0;
> +}
> +
>  int class_member__dwarf_recode_bitfield(struct class_member *member,
>  					struct cu *cu)
>  {
> @@ -1596,6 +1631,8 @@ static struct btf_type_tag_type *die__create_new_bt=
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
> @@ -1636,19 +1673,21 @@ static struct tag *die__create_new_pointer_tag(Dw=
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
> +	/* Handle LLVM style annotation tags if present */
Can we move this comment to right below the goto? It's slightly
confusing here.

For that matter, why are we processing LLVM and GNU tags in succession?
Could we just turn check_gnu_attr into a separate function and instead
of a goto do=20

return check_gnu_attr();

?

Then again mixing the two types of tags seems theoretically possible
and the least surprising thing to do is handle both.

> +	if (!dwarf_haschildren(die) || dwarf_child(die, &child) !=3D 0)
> +		goto check_gnu_attr;
> +
>  	cdie =3D &child;
>  	do {
> -		if (dwarf_tag(cdie) !=3D DW_TAG_LLVM_annotation)
> +		if (!die__tag_is_annotation(cdie))
>  			continue;
> =20
>  		/* Only check btf_type_tag annotations */
> @@ -1661,6 +1700,31 @@ static struct tag *die__create_new_pointer_tag(Dwa=
rf_Die *die, struct cu *cu,
>  			return NULL;
>  	} while (dwarf_siblingof(cdie, cdie) =3D=3D 0);
> =20
> +check_gnu_attr:
> +	/* Check for GCC-style DW_AT_GNU_annotation attribute */
> +	if (tag !=3D NULL ||
> +	    dwarf_attr(die, DW_AT_GNU_annotation, &attr) =3D=3D NULL ||
> +	    dwarf_formref_die(&attr, &annot_die) =3D=3D NULL)
> +		goto out;
> +
> +	for (;;) {
> +		if (dwarf_tag(&annot_die) !=3D DW_TAG_GNU_annotation)
> +			break;
> +
> +		name =3D attr_string(&annot_die, DW_AT_name, conf);
> +		if (strcmp(name, "btf_type_tag") !=3D 0)
> +			break;
> +
> +		tag =3D die__add_btf_type_tag(tag, die, &annot_die, cu, conf);
> +		if (tag =3D=3D NULL)
> +			return NULL;
> +
> +		if (dwarf_attr(&annot_die, DW_AT_GNU_annotation, &attr) =3D=3D NULL ||
> +		    dwarf_formref_die(&attr, &annot_die) =3D=3D NULL)
> +			break;
> +	}
> +
> +out:
>  	return tag ? &tag->tag : tag__new(die, cu);
>  }
> =20
> @@ -1689,6 +1753,12 @@ static struct tag *die__create_new_class(Dwarf_Die=
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
> @@ -2050,10 +2120,13 @@ static int die__process_class(Dwarf_Die *die, str=
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
> +		case DW_TAG_GNU_annotation:
>  			if (add_llvm_annotation(die, -1, conf, &class->namespace.annots))
>  				return -ENOMEM;
>  			continue;
> @@ -2359,6 +2432,7 @@ static int die__process_function(Dwarf_Die *die, st=
ruct ftype *ftype,
>  				goto out_enomem;
>  			continue;
>  		case DW_TAG_LLVM_annotation:
> +		case DW_TAG_GNU_annotation:
>  			if (add_llvm_annotation(die, -1, conf, &(tag__function(&ftype->tag)->=
annots)))
>  				goto out_enomem;
>  			continue;
> @@ -2407,6 +2481,12 @@ static struct tag *die__create_new_function(Dwarf_=
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
> @@ -2468,6 +2548,9 @@ static struct tag *__die__process_tag(Dwarf_Die *di=
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
> @@ -2493,7 +2576,8 @@ static int die__process_unit(Dwarf_Die *die, struct=
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
> index 5ec16e750e83..42b8e39aa2dd 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -670,7 +670,8 @@ static inline int tag__is_tag_type(const struct tag *=
tag)
>  	       tag->tag =3D=3D DW_TAG_volatile_type ||
>  	       tag->tag =3D=3D DW_TAG_atomic_type ||
>  	       tag->tag =3D=3D DW_TAG_unspecified_type ||
> -	       tag->tag =3D=3D DW_TAG_LLVM_annotation;
> +	       tag->tag =3D=3D DW_TAG_LLVM_annotation ||
> +	       tag->tag =3D=3D DW_TAG_GNU_annotation;

Another place where we can just have an "is annotation tag" predicate.

>  }
> =20
>  static inline const char *tag__decl_file(const struct tag *tag,
> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> index 1ec478c2a027..a514d7e98923 100644
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
> @@ -731,7 +734,7 @@ static type_id_t skip_llvm_annotations(const struct c=
u *cu, type_id_t id)

Rename this function to not be llvm-specific anymore?

>  		if (id =3D=3D 0)
>  			break;
>  		type =3D cu__type(cu, id);
> -		if (type =3D=3D NULL || type->tag !=3D DW_TAG_LLVM_annotation || type-=
>type =3D=3D id)
> +		if (type =3D=3D NULL || (type->tag !=3D DW_TAG_LLVM_annotation && type=
->tag !=3D DW_TAG_GNU_annotation) || type->type =3D=3D id)

Same as before wrt predicate

>  			break;
>  		id =3D type->type;
>  	}
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

