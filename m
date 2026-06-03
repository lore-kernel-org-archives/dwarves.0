Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5A43655C5
	for <dwarves@vger.kernel.org>; Wed,  3 Jun 2026 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780519076; cv=none; b=uxKW8c25Sio0dbCnsMe1T3DeJZ4M9sLR5X9hH6twW3yCbcJAS0twkvMO76VtiObCSWvqMwBVT9Ejv8M8o6IkdAHaqyYy2z/y3PPrKIGd2Ek/SjWSRdNf5Xd8zukdKoOMht0G2uqd+NA5CGwxyaY1sEjoevvO5uE4sLsCtsNAKug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780519076; c=relaxed/simple;
	bh=v5MDkuzDjiBP7GOZmOstmq2GPLwNQ0dadL1/CNFKv7M=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=r/teKR9nhsxqqaLLXdLa+1ZulEWrB+YY1TRqNg14nmI+c49ZtZ8EsawL2kcTuFAIodK/QAtPNxkKOdkZK9vekzaJqz/GMuSW5j0cVUZxTxsH9ZkHY74RQa3I0h/2x1ml6zVxEDCVG4VtLMPZzU+P8BYuKW2q8InmxOSCcxzzPpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=K3r5tEpJ; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="K3r5tEpJ"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-3045c195251so13654656eec.1
        for <dwarves@vger.kernel.org>; Wed, 03 Jun 2026 13:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780519073; x=1781123873; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlD1fps65r5GW3H1POgo0WmBfATnB47xWndgmOse2dc=;
        b=K3r5tEpJCQ7gb5s6pWNGC7/ERdydsTH713ZY1Zh9aAsYP6pZbZ6lfA2JYHR7dBeuz9
         uTw6Yk2fkUS4jJdjw23rCS1axXCoFm7YsJXzmPryuPd8xNQy0GZZE2ypJEZ4yknIpLpN
         eiBU0MJAYqqzN5AariemSkKd+azLmyv28/HLexfaqzh0pgRWZij9yeFo1A/YDOaAuXHq
         vCy7Bxm6jDjYnvJIlXLfZumGeqhZj/Kq2MnhVIaJEsV3MHgawM5K8QRZh9eDGhZc6u83
         Wp9m/3FfNPDaHYBgdmNBoaDMBG4giGqLecypwqPZbWgGmTSsG4kx/kil+nOVbpDP9GTd
         L7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780519073; x=1781123873;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hlD1fps65r5GW3H1POgo0WmBfATnB47xWndgmOse2dc=;
        b=cuNRoe/u8KPmBkRkSdGv2MLo+YRlpYUE0quZ2a4DhpWNaaarRw4JLX53RlQjZTDT5c
         RntJfCci96GP5lVwAUg1inelqn6wiy5VDIOMU5FcY5nkRbgEJGTANSqWfZQNgmhO7D4D
         3MFBjVRcoeQOascj5ETIU9LHK7OGJmIkYJWZdtj9utOf/ZKrxqI7Gg1wCzCvsb2npU8D
         fugiCrjilGck/BF2g38ryk7pe19JeRQvZfQvhFCNa33rEKK4KVqKNQh18+n/LM3lY/Sd
         eE3q5mEMlvCay1onu+z34AeBCDU2OwD3KAXz0lMWs5lcDiCKcVsnFt3UAAVgkJQyjAyU
         aSaQ==
X-Forwarded-Encrypted: i=1; AFNElJ/93UmYGh6sOm09i0ew4ZebHTad+HqBe/9Hdtg2eLDlxTFcKwQHmk6zW9DR4xCYnOssLZJTJ+ma@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo1QuuarScpsNkJWELXmc4c0oO+yRQVPHhjKg6sCkcqhvrJLK8
	uPt1Dcjy2E32WHDh6cWDgizLc6DimJbSXXaYVXGV4YpjSYrwMxcgaUL8c3tBYxLO6q8=
X-Gm-Gg: Acq92OGLcWx8rcHpb0/Y2CfKhkFyF9zNKOM+aRMjOnWr4NgCnFSoqem249afe9U4XYz
	UyUnq6wQX7ceoihkWtjNWSMvSNn/GQGXSeqlIAWFlW01GDjcdnS8LTgcW03+tS++bfuh9kUnPBC
	Wp7vZrueQ4YOAL21HaSp8YN9UNJqr9DeArqJlymtfTfPTgT+I4jnIwsdz3aIPj0G6DPFvFRDEBM
	vvRHFOe5XB+LQADZ4Yaw9CUspQUvBbGlu0IOs6jQQZxNrYLfVoO4OLUSCLUhvGlkHY5VT5vboqc
	gAK/xMEWFj4HQuCR/juEqd84SxV3Mv8sZ+HCQMcLFl+TBadi9KuCiO8F16ll5Lcah0urQyRN/6U
	gaxdVDsD7iLgfv7ZmSXxCtgw7/WRCuSaVdvZ9lJMWbJD3adNq26G5L4iTnnyobCSpRZQFi5SMMp
	F8ogeN8Gpyj0114ULOTHs64a1Tq+IzEuG49A==
X-Received: by 2002:a05:7300:f190:b0:2ee:be86:7b90 with SMTP id 5a478bee46e88-3074fbefd7amr2487702eec.29.1780519072706;
        Wed, 03 Jun 2026 13:37:52 -0700 (PDT)
Received: from localhost ([163.114.132.129])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dcad34esm4647412eec.11.2026.06.03.13.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 13:37:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jun 2026 16:37:50 -0400
Message-Id: <DIZPC0U3DHUF.1L1GYMJQGUHGH@etsalapatis.com>
To: "Vineet Gupta" <vineet.gupta@linux.dev>, <dwarves@vger.kernel.org>
Cc: <bpf@vger.kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 <acme@kernel.org>, "Alan Maguire" <alan.maguire@oracle.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, <jose.marchesi@oracle.com>, "David
 Faust" <david.faust@oracle.com>
Subject: Re: [PAHOLE v4 1/3] dwarf_loader: Extract die__add_btf_type_tag()
 helper [NFC]
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260602195512.1511013-1-vineet.gupta@linux.dev>
In-Reply-To: <20260602195512.1511013-1-vineet.gupta@linux.dev>

On Tue Jun 2, 2026 at 3:55 PM EDT, Vineet Gupta wrote:
> NFC change preparing for DW_TAG_GNU_annotation support.
> Extract the btf_type_tag annotation creation logic into helper
> die__add_btf_type_tag().
>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
> Changes since v3 [3]
>  - Fix comment to kernel style [Arnaldo]
>
> Changes since v2 [2]
>  - die__add_btf_type_tag() returns pointer not error code [Alan]
>
> Changes since v1 [1]
>  - NFC reinstate some original comments
>
> [3] https://lore.kernel.org/bpf/20260601183511.594100-1-vineet.gupta@linu=
x.dev/
> [2] https://lore.kernel.org/bpf/20260528223616.2035618-1-vineet.gupta@lin=
ux.dev/
> [1] https://lore.kernel.org/bpf/20260526181818.4159927-1-vineet.gupta@lin=
ux.dev/
> ---
>  dwarf_loader.c | 58 +++++++++++++++++++++++++++++---------------------
>  1 file changed, 34 insertions(+), 24 deletions(-)
>
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 16fb7becffee..42a0f3f74ce3 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1600,14 +1600,44 @@ static struct btf_type_tag_type *die__create_new_=
btf_type_tag_type(Dwarf_Die *di
>  	return tag;
>  }
> =20
> +static struct btf_type_tag_ptr_type *die__add_btf_type_tag(struct btf_ty=
pe_tag_ptr_type *tag,
> +							    Dwarf_Die *die, Dwarf_Die *adie,
> +							    struct cu *cu, struct conf_load *conf)
> +{
> +	struct btf_type_tag_type *annot;
> +	uint32_t id;
> +
> +	if (tag =3D=3D NULL) {
> +		tag =3D die__create_new_btf_type_tag_ptr_type(die, cu);
> +		if (!tag)
> +			return NULL;
> +	}
> +
> +	annot =3D die__create_new_btf_type_tag_type(adie, cu, conf);
> +	if (annot =3D=3D NULL)
> +		return NULL;
> +
> +	if (cu__table_add_tag(cu, &annot->tag, &id) < 0)
> +		return NULL;
> +
> +	struct dwarf_tag *dtag =3D tag__dwarf(&annot->tag);
> +	dtag->small_id =3D id;
> +	cu__hash(cu, &annot->tag);
> +
> +	/*
> +	 * Prepends: for annotations tag1 -> tag2 -> tag3,
> +	 * the tag->tags list ends up as tag3 -> tag2 -> tag1.
> +	 */
> +	list_add(&annot->node, &tag->tags);
> +	return tag;
> +}
> +
>  static struct tag *die__create_new_pointer_tag(Dwarf_Die *die, struct cu=
 *cu,
>  					       struct conf_load *conf)
>  {
>  	struct btf_type_tag_ptr_type *tag =3D NULL;
> -	struct btf_type_tag_type *annot;
>  	Dwarf_Die *cdie, child;
>  	const char *name;
> -	uint32_t id;
> =20
>  	/* If no child tags or skipping btf_type_tag encoding, just create a ne=
w tag
>  	 * and return
> @@ -1627,29 +1657,9 @@ static struct tag *die__create_new_pointer_tag(Dwa=
rf_Die *die, struct cu *cu,
>  		if (strcmp(name, "btf_type_tag") !=3D 0)
>  			continue;
> =20
> -		if (tag =3D=3D NULL) {
> -			/* Create a btf_type_tag_ptr type. */
> -			tag =3D die__create_new_btf_type_tag_ptr_type(die, cu);
> -			if (!tag)
> -				return NULL;
> -		}
> -
> -		/* Create a btf_type_tag type for this annotation. */
> -		annot =3D die__create_new_btf_type_tag_type(cdie, cu, conf);
> -		if (annot =3D=3D NULL)
> -			return NULL;
> -
> -		if (cu__table_add_tag(cu, &annot->tag, &id) < 0)
> +		tag =3D die__add_btf_type_tag(tag, die, cdie, cu, conf);
> +		if (tag =3D=3D NULL)
>  			return NULL;
> -
> -		struct dwarf_tag *dtag =3D tag__dwarf(&annot->tag);
> -		dtag->small_id =3D id;
> -		cu__hash(cu, &annot->tag);
> -
> -		/* For a list of DW_TAG_LLVM_annotation like tag1 -> tag2 -> tag3,
> -		 * the tag->tags contains tag3 -> tag2 -> tag1.
> -		 */
> -		list_add(&annot->node, &tag->tags);
>  	} while (dwarf_siblingof(cdie, cdie) =3D=3D 0);
> =20
>  	return tag ? &tag->tag : tag__new(die, cu);

