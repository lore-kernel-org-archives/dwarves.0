Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F283310784
	for <dwarves@vger.kernel.org>; Fri,  9 Oct 2026 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791551546; cv=none; b=acxL3S+k5/qswd75BJw4UWb/nZd88jHKKMtTkjNAX6evikhDrN4a3zb2rwtV07L1biVso2GBZAD0LIlVT/Sa2ZOK7Y0nJmKH2CytgrgEbh6o0tQHzOG8xYaJTEqQ4vNL38aunwzXK4PowxlwOpbxiaaPL+Qk6He+f+X+FH7zmpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791551546; c=relaxed/simple;
	bh=fNnFTtVTIbl5zAxpPcCO+AoTPFPnCtaVf6V+VFJGHCE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mU8I5r1zQNReua+dRGNIOnQRpe8gQTOCI025sYIL8DL0naN+KhjV+vxdTa3HAhZlRvO80dg6pjWW5K8YAOrXFAR5UonOmDhbAQ+XrWQ8SkyI6OExJy+kR4ugk0drG6f4wkGampEngC/WuaRz8PTCkycQXmX80GDNko8mPHLZnKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Su3O2bQb; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Su3O2bQb"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48b0be347b8so3417461f8f.3
        for <dwarves@vger.kernel.org>; Fri, 09 Oct 2026 06:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791551544; x=1792156344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Dz5N+fpkp93xVi0luIxaL6+g9aD44lsghhKGiHbbMM=;
        b=Su3O2bQbLDbv40qR95sOPKSzsxWiaWnOT+zq565rX1nJrSEOnhiYZIso27pV1I08J0
         k3BZYPvLKYRKD8X20WwAWTeByP5MH3yS/uM8O7bfm7MtoauExnCCYTPv4+IwL/sX3+u6
         0I0oFNU007u4dzBKBenQxkFTgg4uQWZiIvtVgaEkAw11b2OSemOHIqBRWxiOSztPTbx0
         0rL+qkaz5AxYlrHCOOaJqf005gB6mplHOjMcl8Ym6YuymJHpQqcuy8myWa0Z4IXK8DOq
         zHRUJ1PMeJAiJ2ayKliW7gEHNB+Db1cW1HWccQlFjkv3I/7OdVPqq0WWGaRnNfSP0yQM
         vRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791551544; x=1792156344;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Dz5N+fpkp93xVi0luIxaL6+g9aD44lsghhKGiHbbMM=;
        b=pETaEvFiYkykFDtiaKCGLlj2HiLlwONrYIqICJyk4mFBR/uowOhr4kv9YtJXHY1c+Y
         pNC/IugErlfaGtA78UBNpAn4TzxI6nb3N/OHc7rADpSrlXqwx7SLZB5HOLk8ucNH5PkP
         0BYGWZykkPWIC/E+JjLj1htbpBMNh4PChd0U1pO6pV9/ioO/LoYhbT7lpgLaW5JyZvjK
         fd0eSkU9Spzey+zHScEDsdFKAUcc3vr7Gvtgd9XPxGvQk2SYoI2dRmIw0TTL7Uyfhsb0
         ArjxeCkwCaHfr5RJNX5Lbsc43d1I869PwzIhx3l+BgvfmcUM9FJm1ewfC5eQn/bOAloA
         zgfg==
X-Forwarded-Encrypted: i=1; AKwUvBx0PlhGN0Uh+GJyNpUufp45RJ2swVvoOGawRs9p5b9QwdtWryBvIQ6UzYst+kD9hJG4KSvgt3k1@vger.kernel.org
X-Gm-Message-State: AFq9FYIjiJ7XQ5n7Jd3BaTMojWDC1cqC1a5ZL2o6T9dsf3dwo2gU9NN+
	CC5K3mxWBPqD90/NeCHWn7+OozcqvU1VIJ6Iz/ik8NFM03/QBaXMfQGe
X-Gm-Gg: AYBFou2Nq1nqzVrBUtrcjHBDhLXYxVp7r0RqVpV46dmOQ1FUrQnzjilxr8YbZcZituh
	C+VkBOvY8PKmSgvK+TiZqFqOtncWVpxyjwcmjQflDKSQ94KmdhiOJCFPwuFsvnC0NEs4dIT6Y2A
	FHcANqMmiW4iahRdtImgLfVKJqgdYC6suzANIj5ccXC99K0hG5a/Hw6jtoPb7NmHbwJ6Ah86ze1
	eA7uzuHFmVz/yTqqr6zBfqYRGaZwyzcjKOBpE8d2jFbFOT+CDNYHvyHrnBfGmtSLyozPn3WakCv
	kgJN85sS2LkuwMUyEmYigPUi62cN9EUBuFD6uH+8rZQHPiPU30Kqx1s0o8Fgx3VJFapFFoGaca6
	N+vQEqaWIkx0rB5kiwTGfeKXmeqAierY4BqnPMWddN6GXfHOYgP9nPKeaO6RRkezDY0q/g/2SVo
	zck7d25e/9tZ1BZ3bem9qL6WM6RjywJiEIl4BI4J3OY7PVAuRol/TntexHR5W2bnGWu7Qj
X-Received: by 2002:a05:6000:4b05:b0:48b:60d:2b28 with SMTP id ffacd0b85a97d-48dbacdd339mr3235969f8f.39.1791551543436;
        Fri, 09 Oct 2026 06:12:23 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9ab981asm3776784f8f.30.2026.10.09.06.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:12:23 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 9 Oct 2026 15:12:20 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
	qmo@kernel.org, dwarves@vger.kernel.org, daniel@iogearbox.net,
	ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
	martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
	bpf@vger.kernel.org, nsc@kernel.org, puranjay@kernel.org,
	yatsenko@meta.com
Subject: Re: [PATCH v5 dwarves 05/10] pahole: Support inline BTF location
 encoding
Message-ID: <asjoNE3H9ZqL4rsR@krava>
References: <20261002174043.3823987-1-alan.maguire@oracle.com>
 <20261002174043.3823987-6-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002174043.3823987-6-alan.maguire@oracle.com>

On Fri, Oct 02, 2026 at 06:40:33PM +0100, Alan Maguire wrote:

SNIP

> +static int btf_encoder__add_inline_expansion(struct btf_encoder *encoder,
> +					     struct inline_expansion *ie)
> +{
> +	struct ftype *ftype;
> +	struct loc *loc;
> +	struct parameter *param;
> +	uint32_t section_idx, section_offset;
> +	int err;
> +
> +	if (!ie->function || !ie->name ||
> +	    !btf_encoder__inline_addr_to_section(encoder, ie->ip.addr,
> +						 &section_idx, &section_offset))
> +		return 0;

hi,
we get inline locations also from .init.text, which then fail kprobe
address validation.. is there some usecase for keeping .init.text
locations?

I currently disable them in kprobe_multi change I have on top of this,
but I wonder we could just drop them completely in here with something
like:

	if (strstarts(encoder->secinfo[section_idx].name, ".init"))
		return 0;

thanks,
jirka


> +	ftype = &ie->function->proto;
> +	loc = calloc(1, sizeof(*loc));
> +	if (!loc)
> +		return -ENOMEM;
> +	loc->name = strdup(ie->name);
> +	if (!loc->name) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +	loc->section_idx = section_idx;
> +	loc->section_offset = section_offset;
> +	loc->nparams = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
> +	loc->params = calloc(loc->nparams ? loc->nparams : 1, sizeof(*loc->params));
> +	if (!loc->params) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +	inline_expansion__for_each_parameter(ie, param) {
> +		if (param->idx < loc->nparams)
> +			btf_encoder__add_loc_param(param, encoder->addr_base,
> +						   &loc->params[param->idx]);
> +	}
> +	err = btf_encoder__save_func(encoder, ie->function, NULL, loc);
> +	loc = NULL; /* save_func owns loc after this point, including on error */
> +	if (!err)
> +		return 0;
> +out:
> +	loc__delete(loc);
> +	return err;
> +}
> +

SNIP
