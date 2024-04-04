Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1DF745D9;
	Thu,  4 Apr 2024 09:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223759; cv=none; b=I+QtzUQAfVCpmlezEGdgWRhuIEQFZnUwKGZZ2VPTKufelrq6/1WiHnA0v+PW7Klg3is8r+KX/lujDkqIHzGI1EvQRRnXQwUuqacIReUVhdnqvqisKR1I8zLNmLYjwv6vHG01t8MbBsxiglt4nZ+Gj8S/3qKy7XhaSaaYpx2nXcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223759; c=relaxed/simple;
	bh=Nv4tCPNjY9Kj6wER2y+WlKSvitQzvSKZvQWf7/8PMCw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2tNTMlMzsiN3T2uipDDlb97RyYkqbVoPalv2HRQbfztsx15hAuI52FF6Q9xyX2gjUvVwb5cI3NjxGkymEoECkAjH2vu5vCjzsZryZpz/ApQ4yY0axVajyUOJM38fxbKTDly3U6XEBfSuMGewCofeD2cM+YgfCxTqiC+EYmJdDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0ZH589w; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0ZH589w"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516c5c39437so962401e87.1;
        Thu, 04 Apr 2024 02:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712223755; x=1712828555; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s3fkohgRC0tlP/pIjLvttE4gpA+YPfkqpdX/jo6hDkc=;
        b=T0ZH589w+zMNkxxdxOgEfDxrYUkNmoLGCBv5iUqPOaY8prMAc66mAn4t2cfc13JC8L
         K5lcmzdOBjqATHFOn9wfON/r03WWp83uv5kCwAChM7DQ9DB+Uk1JWUgtoQplY4W5/zkm
         qXleiMjt8kE/gG15hGor3Oiw8zKOTptnOb086pU3j4eE6sRphrDpCBpjRZFPKohr2urb
         ZGqG1n/2DtT2A61OX/CpoE3rWMWPu0Xz5ScvvA0Z4XkmYRnsXCJ//h0A8AAF+NQR+B5I
         S81ZhfETuTFebptohT7VWCVZnhjHoIceXOv3UYpMIZOU9f55KIefv4qI3ddGV0eI5URy
         b5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712223755; x=1712828555;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s3fkohgRC0tlP/pIjLvttE4gpA+YPfkqpdX/jo6hDkc=;
        b=L6R0/1qKb7O1e18UIMnNGWGRazHgd8xEgMg3mCM6XICcnKr5QR0pkwizEJ3YfC4HRx
         qgZgxcPP/PcgvEKlDlkx1Q6pZxf4so5kDwdfSXuq/GlsCss4lomvJ+EGKVTQ852Tpm+8
         x3MEL/MtiFAb94hUl+5xo3BdLUEfSJ5T5bGF8QS1KBifmn8FBXzCDGKA9zlLsb2kMjAN
         NcguoCzOlZ9SbitipmFJ5px6JE9gMgUqEt3ZVU0Os9Iy0Tu7xY+3EWd10yLps+mu2R7q
         y0lAoA3V4c6j+3rxUFGIcDT1JNsHH6jnLVPR4xEfC6tk31pgHZYF6ePM46Zz3Fa1MK0U
         91wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJnam77g89aroWE09CDbNuBe/0uLrSWVJgPiIENU8/7L5zpml637KObac3Ukcab9Jrj7Wh2Y0dALu2judQz4T7TDiO
X-Gm-Message-State: AOJu0YwNYxvdJzq5PrDPii14QsFNjIKgpHLm3AOR6ncMRTBucssvMjg9
	HIfGf6fShmNZ4PXVphz/OBvGHC/W40fUnSBoHstsBB8Pfs8Ekn+Q
X-Google-Smtp-Source: AGHT+IHIMr1RDjHUEkNCWpraC7YSqGwLktZL5WZFHppUeAvCoC26dqBgykVpIuC64tCC3D0ZnL0s1w==
X-Received: by 2002:a05:6512:2f2:b0:516:b148:6d6 with SMTP id m18-20020a05651202f200b00516b14806d6mr1568680lfq.50.1712223754890;
        Thu, 04 Apr 2024 02:42:34 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c000900b00414674a1a40sm2026082wmc.45.2024.04.04.02.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 02:42:34 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 4 Apr 2024 11:42:32 +0200
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Kui-Feng Lee <kuifeng@fb.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH 03/12] dwarf_loader: Separate creating the cu/dcu pair
 from processing it
Message-ID: <Zg52CPcTJHqzB0A7@krava>
References: <20240402193945.17327-1-acme@kernel.org>
 <20240402193945.17327-4-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240402193945.17327-4-acme@kernel.org>

On Tue, Apr 02, 2024 at 04:39:36PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> We will need it so that we add the dcu to a list in the same order as
> the CUs are in the DWARF file (vmlinux mostly).
> 
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Kui-Feng Lee <kuifeng@fb.com>
> Cc: Thomas Weiﬂschuh <linux@weissschuh.net>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  dwarf_loader.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 1dffb3f433cb7c8e..125e361ef2bf3f7b 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -3207,8 +3207,7 @@ struct dwarf_thread {
>  	void			*data;
>  };
>  
> -static int dwarf_cus__create_and_process_cu(struct dwarf_cus *dcus, Dwarf_Die *cu_die,
> -					    uint8_t pointer_size, void *thr_data)
> +static struct dwarf_cu *dwarf_cus__create_cu(struct dwarf_cus *dcus, Dwarf_Die *cu_die, uint8_t pointer_size)
>  {
>  	/*
>  	 * DW_AT_name in DW_TAG_compile_unit can be NULL, first seen in:
> @@ -3218,17 +3217,32 @@ static int dwarf_cus__create_and_process_cu(struct dwarf_cus *dcus, Dwarf_Die *c
>  	const char *name = attr_string(cu_die, DW_AT_name, dcus->conf);
>  	struct cu *cu = cu__new(name ?: "", pointer_size, dcus->build_id, dcus->build_id_len, dcus->filename, dcus->conf->use_obstack);
>  	if (cu == NULL || cu__set_common(cu, dcus->conf, dcus->mod, dcus->elf) != 0)
> -		return DWARF_CB_ABORT;
> +		return NULL;
>  
>  	struct dwarf_cu *dcu = dwarf_cu__new(cu);
>  
> -	if (dcu == NULL)
> -		return DWARF_CB_ABORT;
> +	if (dcu == NULL) {
> +		cu__delete(cu);

hm, I dont see cu__delete being called before, why do we need that?

jirka

> +		return NULL;
> +	}
>  
>  	dcu->type_unit = dcus->type_dcu;
>  	cu->priv = dcu;
>  	cu->dfops = &dwarf__ops;
>  
> +	return dcu;
> +}
> +
> +static int dwarf_cus__create_and_process_cu(struct dwarf_cus *dcus, Dwarf_Die *cu_die,
> +					    uint8_t pointer_size, void *thr_data)
> +{
> +	struct dwarf_cu *dcu = dwarf_cus__create_cu(dcus, cu_die, pointer_size);
> +
> +	if (dcu == NULL)
> +		return DWARF_CB_ABORT;
> +
> +	struct cu *cu = dcu->cu;
> +
>  	if (die__process_and_recode(cu_die, cu, dcus->conf) != 0 ||
>  	    cus__finalize(dcus->cus, cu, dcus->conf, thr_data) == LSK__STOP_LOADING)
>  		return DWARF_CB_ABORT;
> -- 
> 2.44.0
> 
