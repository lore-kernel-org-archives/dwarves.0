Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B5BC433F5
	for <linux-dwarves@archiver.kernel.org>; Tue,  3 May 2022 14:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbiECPC0 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 3 May 2022 11:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237603AbiECPCU (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 3 May 2022 11:02:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8209B39808
        for <dwarves@vger.kernel.org>; Tue,  3 May 2022 07:58:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EC61B81F28
        for <dwarves@vger.kernel.org>; Tue,  3 May 2022 14:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D287AC385A4;
        Tue,  3 May 2022 14:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651589925;
        bh=qSwfJE5aqpjFP2SV7JeqGrwbk90p7mJCjF/jfJuBZVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B0imAy1uuP9mO+bu7ttioZC0EIu9ulbOoIXYhOcMY7CGhDX1dLMpsgTSRyO7rB+R0
         YjjoZFSfTc+k5yYS+Zq3u7Y4H/HyX6X4Wol14gWkqZgQ1zJB5gJNp8yVV0q5zmAD3B
         cD4n0h2tmCxqNbMnjqQ2gxQrERAqp9FcDYjxLsRaJIOCkFmYKK9D5p4+mZMT3u6w7y
         T/bGYsiDfsecWPMgQqa9jM5N9r5AD2DqBKKRanjW/L2stE3Jmxj44og18m8Jh/V3ER
         WyTLNZQDdtg12BwGGZo2Y9apk5lvjcdsbnWEQ/td/fiJwKs7gM7bnsxTiJTL7qvqV3
         zTlrMINT/511g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B9271400B1; Tue,  3 May 2022 11:58:42 -0300 (-03)
Date:   Tue, 3 May 2022 11:58:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin Reboredo <yakoyoku@gmail.com>
Cc:     arnaldo.melo@gmail.com, dwarves@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH] pahole: Implement cu_exclude_lang flag
Message-ID: <YnFDItzfx2JD7Gw7@kernel.org>
References: <20220421144715.8154-1-yakoyoku@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421144715.8154-1-yakoyoku@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Thu, Apr 21, 2022 at 11:47:15AM -0300, Martin Reboredo escreveu:
> Exclude compilation units that have the language id equal to the one
> from the --cu_exclude_lang=LANG flag.
> 
> Required by Rust Linux builds due to failing BTF checks product of
> things like rustc's struct reordering.

Sorry, when I saw this patch I already had committed a similar one, can
you please take a look?

Its in the "next" branch at:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=next

- Arnaldo
 
> Signed-off-by: Martin Reboredo <yakoyoku@gmail.com>
> Tested-by: Martin Reboredo <yakoyoku@gmail.com>
> ---
>  dwarves.h | 18 ++++++++++++++++++
>  pahole.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/dwarves.h b/dwarves.h
> index 456b037..9d57a4f 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -204,6 +204,24 @@ enum dwarf_languages {
>      LANG_ObjC_plus_plus	= 0x11,	/* Objective-C++ */
>      LANG_UPC		= 0x12,	/* Unified Parallel C */
>      LANG_D		= 0x13,	/* D */
> +    LANG_Python	= 0x14,	/* Python */
> +    LANG_OpenCL	= 0x15,	/* OpenCL */
> +    LANG_Go	= 0x16,	/* Go */
> +    LANG_Modula3	= 0x17,	/* Modula-3 */
> +    LANG_Haskell	= 0x18,	/* Haskell */
> +    LANG_C_plus_plus_03	= 0x19, /* ISO C++:2003 */
> +    LANG_C_plus_plus_11	= 0x1a, /* ISO C++:2011 */
> +    LANG_OCaml	= 0x1b,	/* OCaml */
> +    LANG_Rust	= 0x1c,	/* Rust */
> +    LANG_C11	= 0x1d,	/* ISO C:2011 */
> +    LANG_Swift	= 0x1e,	/* Swift */
> +    LANG_Julia	= 0x1f,	/* Julia */
> +    LANG_Dylan	= 0x20,	/* Dylan */
> +    LANG_C_plus_plus_14	= 0x21, /* ISO C++:2014 */
> +    LANG_Fortran03	= 0x22,	/* ISO/IEC 1539-1:2004 */
> +    LANG_Fortran08	= 0x23,	/* ISO/IEC 1539-1:2010 */
> +    LANG_RenderScript	= 0x24, /* RenderScript Kernal Language */
> +    LANG_BLISS	= 0x25,	/* BLISS */
>  };
>  
>  /** struct debug_fmt_ops - specific to the underlying debug file format
> diff --git a/pahole.c b/pahole.c
> index a909b22..1c961fb 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -57,6 +57,8 @@ static size_t class__include_prefix_len;
>  static char *cu__exclude_prefix;
>  static size_t cu__exclude_prefix_len;
>  
> +static uint32_t cu__exclude_lang;
> +
>  static char *decl_exclude_prefix;
>  static size_t decl_exclude_prefix_len;
>  
> @@ -615,6 +617,10 @@ static struct cu *cu__filter(struct cu *cu)
>  		     cu__exclude_prefix_len) == 0))
>  		return NULL;
>  
> +  if (cu__exclude_lang != 0 &&
> +	    cu__exclude_lang == cu->language)
> +		return NULL;
> +
>  	return cu;
>  }
>  
> @@ -988,6 +994,39 @@ static void cu__account_nr_methods(struct cu *cu)
>  	}
>  }
>  
> +static const struct {
> +  const char *name;
> +  uint32_t id;
> +} language_table[] = {
> +	{ "C", LANG_C },
> +	{ "C89", LANG_C89 },
> +	{ "C99", LANG_C99 },
> +	{ "C11", LANG_C11 },
> +	{ "C++", LANG_C_plus_plus },
> +	{ "C++03", LANG_C_plus_plus_03 },
> +	{ "C++11", LANG_C_plus_plus_11 },
> +	{ "C++14", LANG_C_plus_plus_14 },
> +	{ "Fortran77", LANG_Fortran77 },
> +	{ "Fortran90", LANG_Fortran90 },
> +	{ "Fortran95", LANG_Fortran95 },
> +	{ "Fortran03", LANG_Fortran03 },
> +	{ "Fortran08", LANG_Fortran08 },
> +	{ "Go", LANG_Go },
> +	{ "Haskell", LANG_Haskell },
> +	{ "Rust", LANG_Rust },
> +	{ NULL, 0 },
> +};
> +
> +static uint32_t language_id(const char *lang) {
> +	for (int l = 0; language_table[l].name; l++) {
> +		if (strcmp(lang, language_table[l].name) == 0) {
> +			return language_table[l].id;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static char tab[128];
>  
>  static void print_structs_with_pointer_to(struct cu *cu, uint32_t type)
> @@ -1137,6 +1176,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
>  #define ARGP_skip_missing          332
>  #define ARGP_skip_encoding_btf_type_tag 333
>  #define ARGP_compile		   334
> +#define ARGP_exclude_lang	   335
>  
>  static const struct argp_option pahole__options[] = {
>  	{
> @@ -1512,6 +1552,12 @@ static const struct argp_option pahole__options[] = {
>  		.key  = ARGP_devel_stats,
>  		.doc  = "Print internal data structures stats",
>  	},
> +	{
> +		.name = "cu_exclude_lang",
> +		.key  = ARGP_exclude_lang,
> +		.arg  = "LANG",
> +		.doc  = "exclude LANGuage compilation units",
> +	},
>  	{
>  		.name = "skip_encoding_btf_decl_tag",
>  		.key  = ARGP_skip_encoding_btf_decl_tag,
> @@ -1681,6 +1727,8 @@ static error_t pahole__options_parser(int key, char *arg,
>  		conf_load.hashtable_bits = atoi(arg);	break;
>  	case ARGP_devel_stats:
>  		conf_load.ptr_table_stats = true;	break;
> +	case ARGP_exclude_lang:
> +		cu__exclude_lang = language_id(arg);	break;
>  	case ARGP_skip_encoding_btf_decl_tag:
>  		conf_load.skip_encoding_btf_decl_tag = true;	break;
>  	case ARGP_skip_missing:
> -- 
> 2.36.0

-- 

- Arnaldo
