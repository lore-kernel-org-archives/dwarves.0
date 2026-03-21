Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D6D2DCF45
	for <dwarves@vger.kernel.org>; Sat, 21 Mar 2026 23:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774134614; cv=none; b=b9OnKyuQbPyxjb6WcdbszlmyONpEkAzLVV7yOihFsJk+GTQZzTJlu5SGVErn/XXVhhzcDBYkOQ86W7O8dDy0s5b4ynC7f8shAU+J9wn1BABid5RW0HYGllnp5xqB5wVAt8oB/XrmkDR+sfQah+aKkAB4wkQDIkF7jkIVlm1TyW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774134614; c=relaxed/simple;
	bh=qjWzt5zxOCmdPCFHzeqxoxvc2n4W4pGiamCu95fl7Vo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mu81r5K5lqMubKNu+16QjpN+rVGgPxVN1vo3P9A/QU9/Jh8ENegclbFK758CS4rg5rfreV9vgnS2LBTwYg31aefBFZjOC/8WdxnqVIwmGQtZATtAyPBMyy2rglAMkGHfi+9uugVQErY3g1njWR1db3a8cGLyN86kZR2H4Drhil0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+/6yhVG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+/6yhVG"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so16915105e9.3
        for <dwarves@vger.kernel.org>; Sat, 21 Mar 2026 16:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774134612; x=1774739412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RAiqI595arRy4CAIyc0bHqmknX0/3hwV7qho4fXUmuU=;
        b=P+/6yhVGo4wMQucMbq/GlhPczaBF3PrqmIgBMZEbtSUDbuVKO99Ry/gizlM037N0FY
         ENPs1RyDBELaQ9d7lNUbSuj/m6MleDqrCt7fCvAHpEDMQYWckpSGQQzRiFPEmGUD8Tu3
         1O0Bmx+sX09TrYIthM9janfDyMcpiqkqB7X6UAg4l3uG3bVW2CYiwrxBb25B+j0KYfgt
         laVITwgheouZLGdz7GwFwQ+tE+DivstkuGY5uzOXO5qpRXWAmGqgKk1p5g2PTfL8oeMe
         SBl18GF57MO7zh8P2PQrQ4hAL9BxiYxkfLyY1rkZqCXpTa98PDe1T+i0hDc1lO2uNa1B
         auDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774134612; x=1774739412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAiqI595arRy4CAIyc0bHqmknX0/3hwV7qho4fXUmuU=;
        b=KoIzuGerOG0hMxUNWf09kEeSLKoqJEBxpNMODqGBEIcrSLy0Fud8ONiRkvd6Ktu8GJ
         fddfBwW5cUP3f69B5OCuAewyhl0kRuAuJCIffXMWO1XbnpJL7l8zwTnyTPVbG9nL5pXI
         23O/dzd8NnW2iethY4KnLoQ4C5D2EDUj9ovv4EJujSbPhx+pOQi6DZ+Hb8lp1XWmawdZ
         Fq2G98YN+01pkF8nDFDuIzKI+27/RKfg6magKb0HlNq89jOHh+Uetu8zW+AF0Vw29C+T
         aiFJkkxSIjb+uaeFxZ2I0fp0nZh2lzdZ0OzRI4vNOyh9sUgx0XF/MUpyVm9K2s6LcyFE
         TZag==
X-Forwarded-Encrypted: i=1; AJvYcCXMJSpw6fgWHh9f7S7VpGNxMNGGSx3ovqIsLUBXltnMKv3Npi6nSbinYV2RZeJ9+R2rXk5h9Qpe@vger.kernel.org
X-Gm-Message-State: AOJu0YxfB23KjrCynYwIfXow0mOc51bdW2mCKH5PUWrUfAiVRrGnX/lL
	9VVblpRcqfc972qQN1t43MGTMDc7rMFWVM4IVg0RUbNEocRQB/vOkTxL
X-Gm-Gg: ATEYQzw6lVzWdorNtJ8J+gBWU3CFcw9Cde4U2zp02DX4HRRJw4/ajyg4dRnd19Rktds
	21Z63c1eQQmMhrD88Mc0nzFw/W4a2LdliBOPzayQMXanKp7Q1I2UYITFip/ahog7wRV+AYwYFG8
	vPVo/FJLdBBsVe/+BFsyRVdpBtrm2R8dhTQST3nuDDcsdGJF1fXLQBIatYFSZKBa+ua5mhJ1wTw
	GaaEY7FtzvyJiSGQ49KqvhvLbFipiYEHfWuYd0VkBGOgPLXxLhA4nnXrbaF1eotjfTf80XnM2km
	Hxl84Twev17Cl/tPJRdhU8gqKGQwranTwVR2wM4QRLnAmsoKPXj43Z/XXOKr/fTrXZoGUf9Xvnt
	2Gi/gkDzpcwKM+ZINTuJ70ziMRReembOAxJ6ZHtm/wlUMQ/a+zPPEkHATyQXCf4OtBQ0Q0ICHlW
	FSlN4kmsoBMR0=
X-Received: by 2002:a05:600c:a418:b0:485:3423:727d with SMTP id 5b1f17b1804b1-486ff03f502mr84577345e9.26.1774134611611;
        Sat, 21 Mar 2026 16:10:11 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8ba4baesm364878975e9.13.2026.03.21.16.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 16:10:11 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 22 Mar 2026 00:10:09 +0100
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH dwarves v3 7/9] dwarf_loader: Handle expression lists
Message-ID: <ab8lUbZE83_XEyyR@krava>
References: <20260320190917.1970524-1-yonghong.song@linux.dev>
 <20260320190953.1974467-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320190953.1974467-1-yonghong.song@linux.dev>

On Fri, Mar 20, 2026 at 12:09:53PM -0700, Yonghong Song wrote:

SNIP

> +	if (byte_size <= cu->addr_size || !cu->agg_use_two_regs) {
> +		switch (expr[0].atom) {
> +		case DW_OP_reg0 ... DW_OP_reg31:
> +			if (loc_num != 0)
> +				break;
> +			*ret = expr[0].atom;
> +			if (*ret == expected_reg)
> +				return *ret;
> +			break;
> +		case DW_OP_breg0 ... DW_OP_breg31:
> +			if (loc_num != 0)
> +				break;
> +			bool has_op_stack_value = false;
> +			for (int i = 1; i < exprlen; i++) {
> +				if (expr[i].atom == DW_OP_stack_value) {
> +					has_op_stack_value = true;
> +					break;
> +				}
> +			}
> +			if (!has_op_stack_value)
> +				break;
> +			/* The existence of DW_OP_stack_value means that
> +			 * DW_OP_bregX register is used as value.
> +			 */
> +			*ret = expr[0].atom - DW_OP_breg0 + DW_OP_reg0;
> +			if (*ret == expected_reg)
> +				return *ret;
> +		}
> +	} else {
> +		/* cu->addr * 2 */
> +		int off = 0;
> +		for (int i = 0; i < exprlen; i++) {
> +			if (expr[i].atom == DW_OP_piece) {
> +				int num = expr[i].number;
> +				if (i == 0) {
> +					off = num;
> +					continue;
> +				}
> +				if (off < cu->addr_size) (*lower_half) |= (1 << off);
> +				else (*upper_half) |= (1 << (off - cu->addr_size));
> +				off += num;

this is really hard for me to read.. I think it needs to follow common
formatting rules and it deserves some explanation either in comments
or in changelog

> +			} else if (expr[i].atom >= DW_OP_reg0 && expr[i].atom <= DW_OP_reg31) {
> +				if (off < cu->addr_size)
> +					*ret = expr[i].atom;
> +				else if (*ret < 0)
> +					*ret = expr[i].atom;
> +			}
> +			/* FIXME: not handling DW_OP_bregX yet since we do not have
> +			 * a use case for it yet for linux kernel.
> +			 */
> +		}
> +	}
> +
>  	return PARM_CONTINUE;
>  }
>  
> +/* The lower_half and upper_half, computed in parameter__multi_exprs(), are handled here.
> + */
> +static int parameter__handle_two_addr_len(int expected_reg, unsigned long lower_half, unsigned long upper_half,
> +					  int ret, Dwarf_Die *die, struct conf_load *conf, struct cu *cu,
> +					  struct parameter *parm) {
> +	if (!lower_half && !upper_half)
> +		return ret;
> +
> +	if (ret != expected_reg)
> +		return ret;
> +
> +	if (!conf->true_signature)
> +		return PARM_DEFAULT_FAIL;
> +
> +	/* Both halfs are used based on dwarf */
> +	if (lower_half && upper_half)
> +		return PARM_TWO_ADDR_LEN;
> +
> +	/* FIXME: parm->name may be NULL due to abstract origin. We do not want to
> +	 * update abstract origin as the type in abstract origin may be used
> +	 * in some other places. We could remove abstract origin in this parameter
> +	 * and add name and type in parameter itself. Right now, for current bpf-next
> +	 * repo, we do not have instances below where parm->name is NULL for x86_64 arch.
> +	 */
> +	if (!parm->name)
> +		return PARM_TO_BE_IMPROVED;
> +
> +	/* FIXME: Only support single field now so we can have a good parameter name and
> +	 * type for it.
> +	 */
> +	if (__builtin_popcountll(lower_half) >= 2 || __builtin_popcountll(upper_half) >= 2)
> +		return PARM_TO_BE_IMPROVED;
> +
> +	int field_offset;
> +	if (__builtin_popcountll(lower_half) == 1)
> +		field_offset = __builtin_ctzll(lower_half);
> +	else
> +		field_offset = cu->addr_size + __builtin_ctzll(upper_half);
> +
> +	/* FIXME: Only struct type is supported. */
> +	Dwarf_Die member_die;
> +	if (!get_member_with_offset(die, field_offset, &member_die))
> +		return PARM_TO_BE_IMPROVED;
> +
> +	const char *member_name = attr_string(&member_die, DW_AT_name, conf);
> +	int len = sizeof(parm->name) + strlen(member_name) + 3;

this seems wrong, shoud be strlen for parm->name? maybe asprintf is
better option in here?

> +	char *new_name = malloc(len);

also there's cu__malloc, and we should check if the allocation failed

> +	sprintf(new_name, "%s__%s", parm->name, member_name);
> +	parm->name = new_name;

I wonder this will leak, because normally the name is allocated with
dwarf_formstring and we don't need to free it, but now we do

jirka
