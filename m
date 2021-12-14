Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC028C433F5
	for <linux-dwarves@archiver.kernel.org>; Tue, 14 Dec 2021 14:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbhLNOGR (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 14 Dec 2021 09:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbhLNOGR (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 14 Dec 2021 09:06:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAE3C061574
        for <dwarves@vger.kernel.org>; Tue, 14 Dec 2021 06:06:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 960D6B819BD
        for <dwarves@vger.kernel.org>; Tue, 14 Dec 2021 14:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CECEC34601;
        Tue, 14 Dec 2021 14:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639490774;
        bh=wOTw2/tGkQIE81yrPWHn5r7Z5Xsqbnx8GZQpwEp1i/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZyXl0SUd9PTJYOw1jdESVOH1bYRWzsvZDFz5s2D/Xgo6JB7HNoXVO1errQlG+noiY
         7Mz/2fHTMzBFRf7IbqlQ4omTi1xe1XHHxWfimcDD0pV4DSrq3/dVIdVyfSdZrG8vKt
         cFMdBUpDbol9dK0oa7pmfbLh1Wa3IJiJcDCwJYLvpQRpLJpvUeawJ5qJPOhO1ZmAaO
         2OyP05PI4py4hN9TEGI+P0eZvz/9dd+qHXXJ1gCWbFu+Xjyhmz0WpuaH1hU0YbRrL7
         kJDy88Ti9/eeDwZvHzHOtvDvNR279uJBoJrFrm7ytC4Ypz7aZ03Xo34uRcY2itiSil
         eF6YA3GH253Sg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7B5DC405D8; Tue, 14 Dec 2021 11:06:12 -0300 (-03)
Date:   Tue, 14 Dec 2021 11:06:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH v2 3/6] fprintf: Print types only once
Message-ID: <Ybik1ExxhsM0DyDA@kernel.org>
References: <20211207173151.2283946-1-douglas.raillard@arm.com>
 <20211207173151.2283946-4-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207173151.2283946-4-douglas.raillard@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Tue, Dec 07, 2021 at 05:31:48PM +0000, Douglas RAILLARD escreveu:
> From: Douglas Raillard <douglas.raillard@arm.com>
> 
> Use (struct tag).visited member to track what type has been printed
> already to avoid printing it twice. This allows producing a valid C
> header along with --expand_types.

And here you changed the default, i.e. it is useful to have the current
--expand_types behaviour of expanding types as it traverse containers,
so I think this needs another option to ask for this new
behaviour, I think we can have that as --expand_types_once that would be
used instead of --expand_types, ok?

- Arnaldo
 
> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
> ---
>  dwarves.h         |  3 ++-
>  dwarves_fprintf.c | 22 ++++++++++++++++------
>  pahole.c          | 34 ++++++++++++++++++----------------
>  3 files changed, 36 insertions(+), 23 deletions(-)
> 
> diff --git a/dwarves.h b/dwarves.h
> index 52d162d..fc5b3fa 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -413,6 +413,7 @@ struct tag {
>  	type_id_t	 type;
>  	uint16_t	 tag;
>  	bool		 visited;
> +	bool		 printed;
>  	bool		 top_level;
>  	bool		 has_btf_type_tag;
>  	uint16_t	 recursivity_level;
> @@ -1370,7 +1371,7 @@ static inline const char *enumerator__name(const struct enumerator *enumerator)
>  
>  void enumeration__delete(struct type *type);
>  void enumeration__add(struct type *type, struct enumerator *enumerator);
> -size_t enumeration__fprintf(const struct tag *tag_enum,
> +size_t enumeration__fprintf(struct tag *tag_enum,
>  			    const struct conf_fprintf *conf, FILE *fp);
>  
>  int dwarves__init(void);
> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> index c5921d7..2c5dce6 100644
> --- a/dwarves_fprintf.c
> +++ b/dwarves_fprintf.c
> @@ -278,8 +278,8 @@ size_t typedef__fprintf(const struct tag *tag, const struct cu *cu,
>  {
>  	struct type *type = tag__type(tag);
>  	const struct conf_fprintf *pconf = conf ?: &conf_fprintf__defaults;
> -	const struct tag *tag_type;
> -	const struct tag *ptr_type;
> +	struct tag *tag_type;
> +	struct tag *ptr_type;
>  	char bf[512];
>  	int is_pointer = 0;
>  	size_t printed;
> @@ -394,13 +394,14 @@ out:
>  	return type->max_tag_name_len;
>  }
>  
> -size_t enumeration__fprintf(const struct tag *tag, const struct conf_fprintf *conf, FILE *fp)
> +size_t enumeration__fprintf(struct tag *tag, const struct conf_fprintf *conf, FILE *fp)
>  {
>  	struct type *type = tag__type(tag);
>  	struct enumerator *pos;
>  	int max_entry_name_len = enumeration__max_entry_name_len(type);
>  	size_t printed = fprintf(fp, "enum%s%s {\n", type__name(type) ? " " : "", type__name(type) ?: "");
>  	int indent = conf->indent;
> +	tag->printed = 1;
>  
>  	if (indent >= (int)sizeof(tabs))
>  		indent = sizeof(tabs) - 1;
> @@ -651,10 +652,14 @@ static size_t type__fprintf(struct tag *type, const struct cu *cu,
>  	size_t printed = 0;
>  	int expand_types = conf->expand_types;
>  	int suppress_offset_comment = conf->suppress_offset_comment;
> +	bool type_printed;
>  
>  	if (type == NULL)
>  		goto out_type_not_found;
>  
> +	type_printed = type->printed;
> +	type->printed = 1;
> +
>  	if (conf->expand_pointers) {
>  		int nr_indirections = 0;
>  
> @@ -794,7 +799,7 @@ print_default:
>  	case DW_TAG_structure_type:
>  		ctype = tag__type(type);
>  
> -		if (type__name(ctype) != NULL && !expand_types) {
> +		if (type__name(ctype) != NULL && (!expand_types || type_printed)) {
>  			printed += fprintf(fp, "%s %-*s %s",
>  					   (type->tag == DW_TAG_class_type &&
>  					    !tconf.classes_as_structs) ? "class" : "struct",
> @@ -813,7 +818,7 @@ print_default:
>  	case DW_TAG_union_type:
>  		ctype = tag__type(type);
>  
> -		if (type__name(ctype) != NULL && !expand_types) {
> +		if (type__name(ctype) != NULL && (!expand_types || type_printed)) {
>  			printed += fprintf(fp, "union %-*s %s", tconf.type_spacing - 6, type__name(ctype), name ?: "");
>  		} else {
>  			tconf.type_spacing -= 8;
> @@ -823,7 +828,7 @@ print_default:
>  	case DW_TAG_enumeration_type:
>  		ctype = tag__type(type);
>  
> -		if (type__name(ctype) != NULL)
> +		if (type__name(ctype) != NULL || type_printed)
>  			printed += fprintf(fp, "enum %-*s %s", tconf.type_spacing - 5, type__name(ctype), name ?: "");
>  		else
>  			printed += enumeration__fprintf(type, &tconf, fp);
> @@ -1000,6 +1005,8 @@ static size_t union__fprintf(struct type *type, const struct cu *cu,
>  	uint32_t initial_union_cacheline;
>  	uint32_t cacheline = 0; /* This will only be used if this is the outermost union */
>  
> +	type__tag(type)->printed = 1;
> +
>  	if (indent >= (int)sizeof(tabs))
>  		indent = sizeof(tabs) - 1;
>  
> @@ -1394,6 +1401,8 @@ static size_t __class__fprintf(struct class *class, const struct cu *cu,
>  				 type__name(type) ?: "");
>  	int indent = cconf.indent;
>  
> +	class__tag(class)->printed = 1;
> +
>  	if (indent >= (int)sizeof(tabs))
>  		indent = sizeof(tabs) - 1;
>  
> @@ -1856,6 +1865,7 @@ size_t tag__fprintf(struct tag *tag, const struct cu *cu,
>  	size_t printed = 0;
>  	struct conf_fprintf tconf;
>  	const struct conf_fprintf *pconf = conf;
> +	tag->printed = 1;
>  
>  	if (conf == NULL) {
>  		tconf = conf_fprintf__defaults;
> diff --git a/pahole.c b/pahole.c
> index f3a51cb..42ba110 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -2964,22 +2964,24 @@ out_btf:
>  			goto dump_it;
>  		}
>  
> -		if (class)
> -			class__find_holes(tag__class(class));
> -		if (reorganize) {
> -			if (class && tag__is_struct(class))
> -				do_reorg(class, cu);
> -		} else if (find_containers)
> -			print_containers(cu, class_id, 0);
> -		else if (find_pointers_in_structs)
> -			print_structs_with_pointer_to(cu, class_id);
> -		else if (class) {
> -			/*
> -			 * We don't need to print it for every compile unit
> -			 * but the previous options need
> -			 */
> -			tag__fprintf(class, cu, &conf, stdout);
> -			putchar('\n');
> +		if (!class->printed) {
> +			if (class)
> +				class__find_holes(tag__class(class));
> +			if (reorganize) {
> +				if (class && tag__is_struct(class))
> +					do_reorg(class, cu);
> +			} else if (find_containers)
> +				print_containers(cu, class_id, 0);
> +			else if (find_pointers_in_structs)
> +				print_structs_with_pointer_to(cu, class_id);
> +			else if (class) {
> +				/*
> +				 * We don't need to print it for every compile unit
> +				 * but the previous options need
> +				 */
> +				tag__fprintf(class, cu, &conf, stdout);
> +				putchar('\n');
> +			}
>  		}
>  	}
>  
> -- 
> 2.25.1

-- 

- Arnaldo
