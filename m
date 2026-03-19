Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D701397
	for <dwarves@vger.kernel.org>; Thu, 19 Mar 2026 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773923572; cv=none; b=VhQiHV2eAa5u6MRRydRlSIi4RJJn1XSyGtV+kicJcLZGjCk5dkfkvINBYnDF0oxECcOP+GP/FDXkjJ+coVS29vnrbTaFsv3TvEuWL6zW1qSVodyOIaYfi0wuNES2nXXrp3NZMop5yAZaLKjLc4XRAqFInpAw8H5aCNEDx7wk1Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773923572; c=relaxed/simple;
	bh=3tSeU2elXrSfQBDhzpF61FpQoIkFwTQZ4Rxl6OHwvRM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aj1OWD1KJlgJHZUPtSYNZ9SyoHAlQdDYGid/kdYIzKTJhQWDrk1r9G0Entnpif5W7rBLCMmrl7c+1YJIAFeAktiBT0+PXYfDRlur+tZWQrvLt8Igx7MPkETunByJ5jNpU5m3k8YWL7tHQuHQzZott1z2+opvcvZLL+jC9Jc0bnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLaH+zjg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLaH+zjg"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48538c5956bso7756425e9.0
        for <dwarves@vger.kernel.org>; Thu, 19 Mar 2026 05:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773923570; x=1774528370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vT9pqEBN+Zh7lgVxExgn69+vb/2G4ujk+G3nQUYqiX0=;
        b=aLaH+zjg8RTzNICMhdmejQG+NJ1xC6uSYUwCwouBbyHawmZLr3ZsB7O2CCHUbbEQXd
         0eQ1K+dItOcIW85WkV2iH8QjW7Qepxhp3/2FXfQdVSFzReprCLFb++rB0yVJCIXzd4m7
         p98K9WkeHruynzTU2DG67UYkOrpTnxIL9J+2NtrNO416fn+GhITwepKd9TCARkzwn0fp
         c32iqZcSNQyvCLOMoJnhczGvvAWM6YYQomvo2fhh9C8DPrEsBNxnfPRB2XTmJ/HSalq0
         L10DRiPU+RlRLQBnOPm72IMq90k+K1ccczIz9hGLatG5PeTvpxBTkhgZxXJ2p7eO24/i
         l+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773923570; x=1774528370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vT9pqEBN+Zh7lgVxExgn69+vb/2G4ujk+G3nQUYqiX0=;
        b=MrHxivk6yaLeyeECMvYLFfDuP/YGlJ7JwY50ohEF4K3Z791gQR3StI7wii/DfbCkf8
         yBRvHND1kL0+6lFkS33FkuN19dY7RgR7/OhOndidp62TpBQets2gwlYEHru+Lq0XX6YP
         aPRVUTJ97xCDef3Ckfb6x+QfqErMRHh07C1Tcb8QK8krQJWsaCT1idkMoo9FMeg8k9Z+
         69CT6ZZR68G4ZOtmNqad+AnwvFfreIdW89tQK3fDPBBQrttloknkG/avQd125rd3cAj7
         kJUqFziT/g5Ibtx/8B08Q5eKIPQKL7pKO7MkXZH5rAiPqiXVcJusEj1qp+mAZv5oDZ7I
         Xv9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNbU3WEBc75W4qMFlnwxRG2zNimHqtqGoI2KpDhP+lrLm9+0PolMrAN6VfrIfXS5/EmlwnPonw@vger.kernel.org
X-Gm-Message-State: AOJu0YySD20e5DUJ1Ml7Z7qvJWXPlTI1eakcQ9jEIen63gkgZ4Edh+rD
	nd4zCs/8ZvwNeh8XCvmiHMMOVUDtzcCD9xiC9WGJbI3GA61nbZo9vx3C
X-Gm-Gg: ATEYQzxpxljdnGXaajyKyWZw7kHjXe3yEUSB/VpEtRuJs0nnSXny9AQQ7GU7mHxyIuG
	GSWeTAyWanq2Kfq4jUIhGuySl2rYBImD+1AUNZKHResRHIZ8I8j2XrZaIbslsbxPMZK3jj/DFcM
	cbJ9rh7FZpAU0sr4Tz84BUdiIzCzQpHDsSD9kprXxOnw9lJ5/J4aloWxGZSOk7HsvoXPbkGzMkc
	xpIT6it2PiCPl0le1KtFUiPeTTq6kLQwHJI5DXhMjmy3prdvFyZDoRulznB23gvwP8Hsa8n5lEh
	hbOAZkQGne+KTE7zmQLlhWgldmCEB2RSAssaI+zkzRwCFMUGB7dURkh4R/6WYvrOR79pY6vF0Jj
	qZBy5S+V/0K0YqXBTFGMoGKmBL63K9pW2sgZptP6ralTCU3C/teOuS7ub8G1FxFgjmuw+HPm9
X-Received: by 2002:a05:600c:800f:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-486f8b593f0mr46729685e9.13.1773923569628;
        Thu, 19 Mar 2026 05:32:49 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4e5495csm76149195e9.2.2026.03.19.05.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 05:32:49 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 19 Mar 2026 13:32:47 +0100
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH dwarves 1/9] dwarf_loader: Reduce parameter checking with
 clang DW_AT_calling_convention attr
Message-ID: <abvs73VjXf_1byN6@krava>
References: <20260305225455.1151066-1-yonghong.song@linux.dev>
 <20260305225500.1151338-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305225500.1151338-1-yonghong.song@linux.dev>

On Thu, Mar 05, 2026 at 02:55:00PM -0800, Yonghong Song wrote:

SNIP

> ---
>  dwarf_loader.c | 71 +++++++++++++++++++++++++++++++++++++++++++-------
>  dwarves.h      |  2 ++
>  2 files changed, 63 insertions(+), 10 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 16fb7be..610b69e 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1190,6 +1190,10 @@ static ptrdiff_t __dwarf_getlocations(Dwarf_Attribute *attr,
>  	return ret;
>  }
>  
> +struct func_info {
> +	bool signature_changed;
> +};
> +
>  /* For DW_AT_location 'attr':
>   * - if first location is DW_OP_regXX with expected number, return the register;
>   *   otherwise save the register for later return
> @@ -1252,7 +1256,8 @@ out:
>  }
>  
>  static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
> -					struct conf_load *conf, int param_idx)
> +					struct conf_load *conf, int param_idx,
> +					struct func_info *info)
>  {
>  	struct parameter *parm = tag__alloc(cu, sizeof(*parm));
>  
> @@ -1265,6 +1270,8 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
>  		parm->idx = param_idx;
>  		if (param_idx >= cu->nr_register_params || param_idx < 0)
>  			return parm;
> +		if (cu->producer_clang && !info->signature_changed)
> +			return parm;

should you check for info != NULL?

>  		/* Parameters which use DW_AT_abstract_origin to point at
>  		 * the original parameter definition (with no name in the DIE)
>  		 * are the result of later DWARF generation during compilation
> @@ -1337,7 +1344,7 @@ static int formal_parameter_pack__load_params(struct formal_parameter_pack *pack
>  			continue;
>  		}
>  
> -		struct parameter *param = parameter__new(die, cu, conf, -1);
> +		struct parameter *param = parameter__new(die, cu, conf, -1, NULL);
>  
>  		if (param == NULL)
>  			return -1;
> @@ -1502,6 +1509,29 @@ static struct ftype *ftype__new(Dwarf_Die *die, struct cu *cu)
>  	return ftype;
>  }
>  

SNIP

>  	int param_idx = 0;
>  	Dwarf_Die child;
> @@ -2320,7 +2353,7 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
>  			continue;
>  		}
>  		case DW_TAG_formal_parameter:
> -			tag = die__create_new_parameter(die, ftype, lexblock, cu, conf, param_idx++);
> +			tag = die__create_new_parameter(die, ftype, lexblock, cu, conf, param_idx++, info);
>  			break;
>  		case DW_TAG_variable:
>  			tag = die__create_new_variable(die, cu, conf, 0);
> @@ -2391,9 +2424,10 @@ out_enomem:
>  static struct tag *die__create_new_function(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
>  {
>  	struct function *function = function__new(die, cu, conf);
> +	struct func_info info = { function->signature_changed };

would it be easier to add signature_changed to struct ftype or pass
function pointer directly to die__process_function ?

(after reading the rest of the patches, seems like func_info is needed
anyway, so maybe not worth it)

>  
>  	if (function != NULL &&
> -	    die__process_function(die, &function->proto, &function->lexblock, cu, conf) != 0) {
> +	    die__process_function(die, &function->proto, &function->lexblock, cu, conf, &info) != 0) {
>  		function__delete(function, cu);
>  		function = NULL;
>  	}
> @@ -3045,6 +3079,21 @@ static unsigned long long dwarf_tag__orig_id(const struct tag *tag,
>  	return cu->extra_dbg_info ? dtag->id : 0;
>  }
>  
> +static bool attr_producer_clang(Dwarf_Die *die)
> +{
> +	Dwarf_Attribute attr;
> +	const char *producer;
> +
> +	if (dwarf_attr(die, DW_AT_producer, &attr) == NULL)
> +		return false;
> +
> +	producer = dwarf_formstring(&attr);
> +	if (!producer)
> +		return false;
> +

nit you could call attr_string(die, DW_AT_producer, NULL) to get the string

jirka

> +	return !!strstr(producer, "clang");
> +}
> +

SNIP
