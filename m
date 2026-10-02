Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0D84AEBD4;
	Fri,  2 Oct 2026 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790958364; cv=none; b=Q0bxrzjPvYrU4jXQTIy1uRaHY1Mn3S7bqVvPIsnGnmTMiTN21EVZSQ0bHr+HxqYljcqMPXXzXjQYWaEzyhMklhS4wDVe7/mWToRxPVou7C23v+0jqx3iEGZHNOTYDZxSa6b2rE4pCYG9+oGG2xyb7Cvmdrf9PMkvT+va7MevM9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790958364; c=relaxed/simple;
	bh=qTWhSWIGJ5dKICCs3WVmVKYS9vcEorOKTNJpApVo2Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gaexh8L2Rm4X4guU1n3OklUs7/cIgTauDTrFiXSgbqkZJ6tk94GOa49GP21R9vOskO5+IR1r2LFQEa7NhhBZjZdK7mCaFeczwfxZnRVfUIBSIwtZvjd0EySR7AgWo6xH6n8wpuRgCST/wzyPdg2vsP4UF4tIwg2iIzIiPGvidLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XY9KBDvV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XY9KBDvV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3ADE1F000FF;
	Fri,  2 Oct 2026 16:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790958363;
	bh=Z+tczB0ff+GcvA3l0VojhNNKNUieaScKIojzODtxPxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XY9KBDvVSP2YZ+qhLRrthzXoS2zrPh5QgexKeA0VShHs4XtkEwgMqa1CqoB5kMjOm
	 RNN9+kCfWeElbjLWnO324pdcSJ2neko2RVlWV+625JAOleOJHyrMjGkiYIXb8pg5Go
	 KTper5e1448RF8f0ubfmZeDYHUPfhiSRVOi24PTGD18Q4pQpE4zdLawqCL+e7HeutW
	 cUUtfYlA1IzRtFxDIG98NoUiw9uV434HEKzSXkw5OQUvcZz1c1mYlJdI0rF8vU+CGg
	 tzDOPCBzPhkA9q8QjdXMSzCjqkzFgy+XhVUBX9kw7J1cQvDQyvsimWVUK//T35mQau
	 uV6RBhM77Yv9w==
Date: Fri, 2 Oct 2026 18:25:58 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
	dwarves@vger.kernel.org
Subject: Re: Many instances of "no BTF func for kfunc ..." and "unresolved
 symbol ..." from resolve_btfids after pahole 1.32 upgrade
Message-ID: <20261002162558.GB288990@ax162>
References: <20261001224346.GA576434@ax162>
 <efa1ae47-3ccf-4689-9fde-a0294985ccfb@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efa1ae47-3ccf-4689-9fde-a0294985ccfb@linux.dev>

Hi Yonghong,

On Fri, Oct 02, 2026 at 10:40:12AM +0100, Yonghong Song wrote:
> Could you try the following patch to see whether it solved the issue.
> I didn't have environment to test arm, powerpc, riscv, etc.

Yes, I had to manually apply it but it does appear to resolve this
issue. I'll put it through my full build matrix soon but should you send
it formally, feel free to add

  Tested-by: Nathan Chancellor <nathan@kernel.org> # build

> diff --git a/btf_encoder.c b/btf_encoder.c
> index d6b9be6..2f137ee 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -2913,7 +2913,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>                 encoder->tag_kfuncs      = conf_load->btf_decl_tag_kfuncs;
>                 encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
>                 encoder->encode_attributes = conf_load->btf_attributes;
> -               encoder->true_signature = conf_load->true_signature;
> +               encoder->true_signature = conf_load->true_signature && cu->param_loc_supported;
>                 encoder->verbose         = verbose;
>                 encoder->has_index_type  = false;
>                 encoder->need_index_type = false;
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 1e5363a..9f9b9c9 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -1518,6 +1518,22 @@ static bool arch__arg_align_two_regs(const GElf_Ehdr *ehdr)
>         }
>  }
> +/*
> + * Architectures whose argument register mapping has been validated for
> + * matching clang parameter locations and reconstructing true signatures.
> + * Other architectures keep only the basic optimized-out detection.
> + */
> +static bool arch__param_loc_supported(const GElf_Ehdr *ehdr)
> +{
> +       switch (ehdr->e_machine) {
> +       case EM_X86_64:
> +       case EM_AARCH64:
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
>  static struct template_type_param *template_type_param__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
>  {
>         struct template_type_param *ttparm = tag__alloc(cu, sizeof(*ttparm));
> @@ -3777,7 +3793,8 @@ static void function__analyze_parameter_locations(struct function *fn, struct cu
>  {
>         struct ftype *ftype = &fn->proto;
>         struct parameter *pos;
> -       bool true_sig_enabled = conf->true_signature && ftype->signature_changed;
> +       bool true_sig_enabled = cu->param_loc_supported && conf->true_signature &&
> +                               ftype->signature_changed;
>         bool check_locations = !cu->producer_clang || ftype->signature_changed;
>         int reg_idx = 0;
> @@ -3785,7 +3802,8 @@ static void function__analyze_parameter_locations(struct function *fn, struct cu
>                 /* Producer is clang and the signature was not changed: match
>                  * each parameter against its expected ABI argument register.
>                  */
> -               function__match_clang_parameter_locations(ftype, cu);
> +               if (cu->param_loc_supported)
> +                       function__match_clang_parameter_locations(ftype, cu);
>                 return;
>         }
> @@ -4533,6 +4551,7 @@ static int cu__set_common(struct cu *cu, struct conf_load *conf,
>         cu->nr_register_params = arch__nr_register_params(&ehdr);
>         cu->agg_use_two_regs = arch__agg_use_two_regs(&ehdr);
>         cu->arg_align_two_regs = arch__arg_align_two_regs(&ehdr);
> +       cu->param_loc_supported = arch__param_loc_supported(&ehdr);
>         arch__set_register_params(&ehdr, cu);
>         return 0;
>  }
> diff --git a/dwarves.h b/dwarves.h
> index f3453ed..6b75ece 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -305,6 +305,7 @@ struct cu {
>         uint8_t          producer_clang:1;
>         uint8_t          agg_use_two_regs:1;    /* An aggregate like {long a; long b;} */
>         uint8_t          arg_align_two_regs:1;  /* An over-aligned arg starts on an even register */
> +       uint8_t          param_loc_supported:1; /* Parameter location analysis is validated for this arch */
>         uint8_t          nr_register_params;
>         int              register_params[ARCH_MAX_REGISTER_PARAMS];
>         int              functions_saved;
> 

-- 
Cheers,
Nathan
