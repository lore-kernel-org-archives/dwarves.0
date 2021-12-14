Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1037C433EF
	for <linux-dwarves@archiver.kernel.org>; Tue, 14 Dec 2021 14:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhLNOCu (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 14 Dec 2021 09:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhLNOCt (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 14 Dec 2021 09:02:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472D7C06173F
        for <dwarves@vger.kernel.org>; Tue, 14 Dec 2021 06:02:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D907D6150C
        for <dwarves@vger.kernel.org>; Tue, 14 Dec 2021 14:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007E8C34607;
        Tue, 14 Dec 2021 14:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639490568;
        bh=4f+f4aYmvblEwl1lnv3yQ7WuYCGftCPabuxSxWvMaVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uBGPbCkegQ6HBl9Qup73tyA5s8Bx7ZRoeR9MWxYonz9RRF/oDRrL7vk/4PGc5cruL
         ycRncJyvTyovPjzTcq5ptgRqitpEtih64ySBcMfs8uOGKspVfrB8mSAjG5zSckBG3u
         7IAkBh4P/HAXEHIo/NmFj/qJQl/mRpRxA/+9wvu244bebU3tJ9e+oRChXgJQKHJVHx
         O//n/3jNAw10SPpBe1hIR9S5YLTuHbu9cMtBvpcc9HecTlfgjKmqKpgYehzzlAk1z7
         4HpUZ7O4s7Rdv6CNyos22cGxzaH0xzgBT2ExW0z2jEcyG6kVuEKOI2elr0yo+KiRnr
         goUXykOXpYQPQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 03E07405D8; Tue, 14 Dec 2021 11:02:44 -0300 (-03)
Date:   Tue, 14 Dec 2021 11:02:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Douglas RAILLARD <douglas.raillard@arm.com>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
Subject: Re: [PATCH v2 3/6] fprintf: Print types only once
Message-ID: <YbikBKrz3HW8QE/X@kernel.org>
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

This doesn't match the patch, where you ended up using a new tar.printed
field, have you tried with .visited and ended up finding out .printed
was needed?

- Arnaldo

> already to avoid printing it twice. This allows producing a valid C
> header along with --expand_types.
> 
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
