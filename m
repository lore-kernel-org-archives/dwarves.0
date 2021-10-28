Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC7DC433EF
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 13:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FA2F60FC4
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 13:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhJ1NVC (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 28 Oct 2021 09:21:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229641AbhJ1NVC (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 28 Oct 2021 09:21:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 227DC60F56;
        Thu, 28 Oct 2021 13:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635427115;
        bh=VAYNmts2HvxyOlQblzQB09fyZ9VngEs/vDMoRgwahas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LIEey/SVh3cBvHahocI2toHkQbb82iG4xoBxHoEpTsZ/p0Fb8ZYp09S8lik5Zg0bL
         ss2m6I7isIdPWC4gaKQ+tPU3MmRODD6EvOR2uQWFAi1S8urGIp9qvu1M50+gKPtwz8
         ayAkuMOXmRDfx3TKV1dnLHRaB8wMka1GEaSb7Pev/HISdq4eIxf2AGLALkvEOyXe1E
         EgduflLm7joJ2yRQiQuZPxksMPyJmKBvuHvSu24FvOuQRYZurwUg8TJRCm1mw6UgK0
         /XP59AakWHsb9nDRSZLe+ixgzpyt3a48J28xySNMG6Ei5ve1uH6BLrqqq2VwRrGt/a
         pw+1CdEEEKaaA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6B3D5410A1; Thu, 28 Oct 2021 10:18:32 -0300 (-03)
Date:   Thu, 28 Oct 2021 10:18:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH v3 4/6] dwarves_fprintf: Move cacheline_size into struct
 conf_fprintf
Message-ID: <YXqjKKSH5wyqUGtn@kernel.org>
References: <20211028122710.881181-1-douglas.raillard@arm.com>
 <20211028122710.881181-5-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028122710.881181-5-douglas.raillard@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Thu, Oct 28, 2021 at 01:27:08PM +0100, Douglas RAILLARD escreveu:
> From: Douglas Raillard <douglas.raillard@arm.com>
> 
> Remove the global variable and turn it into a member in struct
> conf_fprintf, so that it can be used by other parts of the code.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
> ---
>  codiff.c          |  4 +++-
>  ctracer.c         |  3 ++-
>  dtagnames.c       |  3 ++-
>  dwarves.c         |  6 +-----
>  dwarves.h         |  6 ++++--
>  dwarves_fprintf.c | 30 ++++++++++++++++++------------
>  pahole.c          |  8 +++++---
>  pdwtags.c         |  4 +++-
>  pfunct.c          |  4 +++-
>  pglobal.c         |  4 +++-
>  prefcnt.c         |  4 +++-
>  11 files changed, 47 insertions(+), 29 deletions(-)
> 
> diff --git a/codiff.c b/codiff.c
> index 13a94c1..35aee3f 100644
> --- a/codiff.c
> +++ b/codiff.c
> @@ -778,11 +778,13 @@ failure:
>  		goto out;
>  	}
>  
> -	if (dwarves__init(0)) {
> +	if (dwarves__init()) {
>  		fputs("codiff: insufficient memory\n", stderr);
>  		goto out;
>  	}
>  
> +	dwarves__resolve_cacheline_size(&conf_load, 0);
> +
>  	if (show_function_diffs == 0 && show_struct_diffs == 0 &&
>  	    show_terse_type_changes == 0)
>  		show_function_diffs = show_struct_diffs = 1;
> diff --git a/ctracer.c b/ctracer.c
> index d0b2623..10ecac6 100644
> --- a/ctracer.c
> +++ b/ctracer.c
> @@ -940,10 +940,11 @@ int main(int argc, char *argv[])
>  	FILE *fp_functions;
>  	int rc = EXIT_FAILURE;
>  
> -	if (dwarves__init(0)) {
> +	if (dwarves__init()) {
>  		fputs("ctracer: insufficient memory\n", stderr);
>  		goto out;
>  	}
> +	dwarves__resolve_cacheline_size(NULL, 0);
>  
>  	if (argp_parse(&ctracer__argp, argc, argv, 0, &remaining, NULL) ||
>  	    remaining < argc) {
> diff --git a/dtagnames.c b/dtagnames.c
> index 6cb51f1..343f055 100644
> --- a/dtagnames.c
> +++ b/dtagnames.c
> @@ -34,10 +34,11 @@ int main(int argc __maybe_unused, char *argv[])
>  	int err, rc = EXIT_FAILURE;
>  	struct cus *cus = cus__new();
>  
> -	if (dwarves__init(0) || cus == NULL) {
> +	if (dwarves__init() || cus == NULL) {
>  		fputs("dtagnames: insufficient memory\n", stderr);
>  		goto out;
>  	}
> +	dwarves__resolve_cacheline_size(NULL, 0);
>  
>  	err = cus__load_files(cus, NULL, argv + 1);
>  	if (err != 0) {
> diff --git a/dwarves.c b/dwarves.c
> index bb8af5b..81fa47b 100644
> --- a/dwarves.c
> +++ b/dwarves.c
> @@ -2458,12 +2458,8 @@ void cus__set_loader_exit(struct cus *cus, void (*loader_exit)(struct cus *cus))
>  	cus->loader_exit = loader_exit;
>  }
>  
> -void dwarves__fprintf_init(uint16_t user_cacheline_size);
> -
> -int dwarves__init(uint16_t user_cacheline_size)
> +int dwarves__init(void)
>  {
> -	dwarves__fprintf_init(user_cacheline_size);
> -
>  	int i = 0;
>  	int err = 0;
>  
> diff --git a/dwarves.h b/dwarves.h
> index c2fea0a..6ad355d 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -96,6 +96,7 @@ struct conf_fprintf {
>  	const char *header_type;
>  	const char *range;
>  	uint32_t   skip;
> +	uint16_t   cacheline_size;
>  	uint8_t	   indent;
>  	uint8_t	   expand_types:1;
>  	uint8_t	   expand_pointers:1;
> @@ -569,7 +570,7 @@ void tag__not_found_die(const char *file, int line, const char *func);
>  					  __LINE__, __func__); } while (0)
>  
>  size_t tag__size(const struct tag *tag, const struct cu *cu);
> -size_t tag__nr_cachelines(const struct tag *tag, const struct cu *cu);
> +size_t tag__nr_cachelines(const struct conf_fprintf *conf, const struct tag *tag, const struct cu *cu);
>  struct tag *tag__follow_typedef(const struct tag *tag, const struct cu *cu);
>  struct tag *tag__strip_typedefs_and_modifiers(const struct tag *tag, const struct cu *cu);
>  
> @@ -1331,8 +1332,9 @@ void enumeration__add(struct type *type, struct enumerator *enumerator);
>  size_t enumeration__fprintf(const struct tag *tag_enum,
>  			    const struct conf_fprintf *conf, FILE *fp);
>  
> -int dwarves__init(uint16_t user_cacheline_size);
> +int dwarves__init(void);
>  void dwarves__exit(void);
> +void dwarves__resolve_cacheline_size(const struct conf_load *conf, uint16_t user_cacheline_size);
>  
>  const char *dwarf_tag_name(const uint32_t tag);
>  
> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> index 1c1d949..efccd90 100644
> --- a/dwarves_fprintf.c
> +++ b/dwarves_fprintf.c
> @@ -127,7 +127,7 @@ const char *dwarf_tag_name(const uint32_t tag)
>  	return "INVALID";
>  }
>  
> -static const struct conf_fprintf conf_fprintf__defaults = {
> +static struct conf_fprintf conf_fprintf__defaults = {
>  	.name_spacing = 23,
>  	.type_spacing = 26,
>  	.emit_stats   = 1,
> @@ -135,11 +135,10 @@ static const struct conf_fprintf conf_fprintf__defaults = {
>  
>  const char tabs[] = "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t";
>  
> -static size_t cacheline_size;
>  
> -size_t tag__nr_cachelines(const struct tag *tag, const struct cu *cu)
> +size_t tag__nr_cachelines(const struct conf_fprintf *conf, const struct tag *tag, const struct cu *cu)
>  {
> -	return (tag__size(tag, cu) + cacheline_size - 1) / cacheline_size;
> +	return (tag__size(tag, cu) + conf->cacheline_size - 1) / conf->cacheline_size;
>  }
>  
>  static const char *tag__accessibility(const struct tag *tag)
> @@ -611,7 +610,7 @@ static size_t type__fprintf_stats(struct type *type, const struct cu *cu,
>  {
>  	size_t printed = fprintf(fp, "\n%.*s/* size: %d, cachelines: %zd, members: %u",
>  				 conf->indent, tabs, type->size,
> -				 tag__nr_cachelines(type__tag(type), cu), type->nr_members);
> +				 tag__nr_cachelines(conf, type__tag(type), cu), type->nr_members);
>  
>  	if (type->nr_static_members != 0)
>  		printed += fprintf(fp, ", static members: %u */\n", type->nr_static_members);
> @@ -1307,11 +1306,11 @@ static size_t class__fprintf_cacheline_boundary(struct conf_fprintf *conf,
>  						FILE *fp)
>  {
>  	int indent = conf->indent;
> -	uint32_t cacheline = offset / cacheline_size;
> +	uint32_t cacheline = offset / conf->cacheline_size;
>  	size_t printed = 0;
>  
>  	if (cacheline > *conf->cachelinep) {
> -		const uint32_t cacheline_pos = offset % cacheline_size;
> +		const uint32_t cacheline_pos = offset % conf->cacheline_size;
>  		const uint32_t cacheline_in_bytes = offset - cacheline_pos;
>  
>  		if (cacheline_pos == 0)
> @@ -1753,7 +1752,7 @@ static size_t __class__fprintf(struct class *class, const struct cu *cu,
>  		}
>  		printed += fprintf(fp, " */\n");
>  	}
> -	cacheline = (cconf.base_offset + type->size) % cacheline_size;
> +	cacheline = (cconf.base_offset + type->size) % conf->cacheline_size;
>  	if (cacheline != 0)
>  		printed += fprintf(fp, "%.*s/* last cacheline: %u bytes */\n",
>  				   cconf.indent, tabs,
> @@ -1980,15 +1979,22 @@ static long cacheline__size(void)
>  #endif
>  }
>  
> -void dwarves__fprintf_init(uint16_t user_cacheline_size)
> +void dwarves__resolve_cacheline_size(const struct conf_load *conf, uint16_t user_cacheline_size)
>  {
> +	uint16_t size;
> +
>  	if (user_cacheline_size == 0) {
>  		long sys_cacheline_size = cacheline__size();
>  
>  		if (sys_cacheline_size > 0)
> -			cacheline_size = sys_cacheline_size;
> +			size = sys_cacheline_size;
>  		else
> -			cacheline_size = 64; /* Fall back to a sane value */
> +			size = 64; /* Fall back to a sane value */
>  	} else
> -		cacheline_size = user_cacheline_size;
> +		size = user_cacheline_size;
> +
> +	if (conf)
> +		conf->conf_fprintf->cacheline_size = size;
> +
> +	conf_fprintf__defaults.cacheline_size = size;
>  }
> diff --git a/pahole.c b/pahole.c
> index 80271b5..6ab2f80 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1684,8 +1684,8 @@ static void do_reorg(struct tag *class, struct cu *cu)
>  	tag__fprintf(class__tag(clone), cu, &conf, stdout);
>  	if (savings != 0) {
>  		const size_t cacheline_savings =
> -		      (tag__nr_cachelines(class, cu) -
> -		       tag__nr_cachelines(class__tag(clone), cu));
> +		      (tag__nr_cachelines(&conf, class, cu) -
> +		       tag__nr_cachelines(&conf, class__tag(clone), cu));
>  
>  		printf("   /* saved %d byte%s", savings,
>  		       savings != 1 ? "s" : "");
> @@ -3143,11 +3143,13 @@ int main(int argc, char *argv[])
>  		goto out;
>  	}
>  
> -	if (dwarves__init(cacheline_size)) {
> +	if (dwarves__init()) {
>  		fputs("pahole: insufficient memory\n", stderr);
>  		goto out;
>  	}
>  
> +	dwarves__resolve_cacheline_size(&conf_load, cacheline_size);
> +
>  	if (prettify_input_filename) {
>  		if (strcmp(prettify_input_filename, "-") == 0) {
>  			prettify_input = stdin;
> diff --git a/pdwtags.c b/pdwtags.c
> index 270ddc4..2b5ba1b 100644
> --- a/pdwtags.c
> +++ b/pdwtags.c
> @@ -131,11 +131,13 @@ int main(int argc, char *argv[])
>  	int remaining, rc = EXIT_FAILURE, err;
>  	struct cus *cus = cus__new();
>  
> -	if (dwarves__init(0) || cus == NULL) {
> +	if (dwarves__init() || cus == NULL) {
>  		fputs("pwdtags: insufficient memory\n", stderr);
>  		goto out;
>  	}
>  
> +	dwarves__resolve_cacheline_size(&pdwtags_conf_load, 0);
> +
>  	if (argp_parse(&pdwtags__argp, argc, argv, 0, &remaining, NULL) ||
>  	    remaining == argc) {
>                  argp_help(&pdwtags__argp, stderr, ARGP_HELP_SEE, argv[0]);
> diff --git a/pfunct.c b/pfunct.c
> index e69c9cd..5485622 100644
> --- a/pfunct.c
> +++ b/pfunct.c
> @@ -721,11 +721,13 @@ int main(int argc, char *argv[])
>  	if (symtab_name != NULL)
>  		return elf_symtabs__show(argv + remaining);
>  
> -	if (dwarves__init(0)) {
> +	if (dwarves__init()) {
>  		fputs("pfunct: insufficient memory\n", stderr);
>  		goto out;
>  	}
>  
> +	dwarves__resolve_cacheline_size(&conf_load, 0);
> +
>  	struct cus *cus = cus__new();
>  	if (cus == NULL) {
>  		fputs("pfunct: insufficient memory\n", stderr);
> diff --git a/pglobal.c b/pglobal.c
> index 516d3f0..9341244 100644
> --- a/pglobal.c
> +++ b/pglobal.c
> @@ -303,11 +303,13 @@ int main(int argc, char *argv[])
>                  goto out;
>  	}
>  
> -	if (dwarves__init(0)) {
> +	if (dwarves__init()) {
>  		fputs("pglobal: insufficient memory\n", stderr);
>  		goto out;
>  	}
>  
> +	dwarves__resolve_cacheline_size(&conf_load, 0);
> +
>  	struct cus *cus = cus__new();
>  	if (cus == NULL) {
>  		fputs("pglobal: insufficient memory\n", stderr);
> diff --git a/prefcnt.c b/prefcnt.c
> index b37192f..8010afd 100644
> --- a/prefcnt.c
> +++ b/prefcnt.c
> @@ -136,11 +136,13 @@ int main(int argc __maybe_unused, char *argv[])
>  	int err;
>  	struct cus *cus = cus__new();
>  
> -	if (dwarves__init(0) || cus == NULL) {
> +	if (dwarves__init() || cus == NULL) {
>  		fputs("prefcnt: insufficient memory\n", stderr);
>  		return EXIT_FAILURE;
>  	}
>  
> +	dwarves__resolve_cacheline_size(NULL, 0);
> +
>  	err = cus__load_files(cus, NULL, argv + 1);
>  	if (err != 0) {
>  		cus__fprintf_load_files_err(cus, "prefcnt", argv + 1, err, stderr);
> -- 
> 2.25.1

-- 

- Arnaldo
