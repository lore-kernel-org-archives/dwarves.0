From: Mark Wielaard <mjw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [patch] Don't die when encountering unknown tags, just warn
Date: Wed, 18 May 2011 17:07:00 +0200
Message-ID: <1305731220.3497.15.camel@springer.wildebeest.org>
References: <1301174586.8262.8.camel@springer.wildebeest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1301174586.8262.8.camel-OO0OHOuVXW89n/EXqpbZ8ns8WZQLr0HW@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: dwarves@vger.kernel.org

Hi,

I would still like to see this patch applied if possible.
Please let me know if this is the right way to fix the issue or whether
you like some other solution.

Thanks,

Mark

On Sat, 2011-03-26 at 22:23 +0100, Mark Wielaard wrote:
> Hi,
> 
> I was playing with pahole against a binary compiled with an unreleased
> gcc. This version outputs some DW_TAGs that pahole doesn't know about.
> These tags have been added to elftuils git, but aren't yet in any
> release.
> 
> The problem was that all errors from die__process_tag () are treated the
> same (it returns NULL and then all callers interpret that as out of
> memory). So this patch adds an explicit UNKNOWN_TAG return value so
> callers can decide to ignore it and just carry on instead of terminating
> the program where appropriate.
> 
> With this patch in place pahole will just print a warning when
> encountering an unknown tag and ignore that die.
> 
> Cheers,
> 
> Mark
> differences between files attachment
> (0001-dwarf_loader-Warn-on-unknown-tags.patch)
> From 59311550b8b2355c9a2f74e00d9ccf1317c5efd2 Mon Sep 17 00:00:00 2001
> From: Mark Wielaard <mjw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Date: Sat, 26 Mar 2011 20:39:32 +0100
> Subject: [PATCH] dwarf_loader: Warn on unknown tags.
> 
> Don't die when encountering unknown tags, just warn.
> ---
>  dwarf_loader.c |   30 ++++++++++++++++++++++--------
>  1 files changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 9b4a500..5db1e45 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -905,6 +905,8 @@ static void __cu__tag_not_handled(Dwarf_Die *die, const char *fn)
>  
>  #define cu__tag_not_handled(die) __cu__tag_not_handled(die, __FUNCTION__)
>  
> +#define UNKNOWN_TAG ((struct tag *) -1L)
> +
>  static struct tag *__die__process_tag(Dwarf_Die *die, struct cu *cu,
>  				      int toplevel, const char *fn);
>  
> @@ -1132,7 +1134,7 @@ static struct tag *die__create_new_subroutine_type(Dwarf_Die *die,
>  			continue;
>  		default:
>  			tag = die__process_tag(die, cu, 0);
> -			if (tag == NULL)
> +			if (tag == NULL || tag == UNKNOWN_TAG)
>  				goto out_delete;
>  
>  			if (cu__add_tag(cu, tag, &id) < 0)
> @@ -1244,6 +1246,9 @@ static int die__process_class(Dwarf_Die *die, struct type *class,
>  			if (tag == NULL)
>  				return -ENOMEM;
>  
> +			if (tag == UNKNOWN_TAG)
> +				return -EINVAL;
> +
>  			long id = -1;
>  
>  			if (cu__table_add_tag(cu, tag, &id) < 0) {
> @@ -1276,10 +1281,11 @@ static int die__process_namespace(Dwarf_Die *die, struct namespace *namespace,
>  	struct tag *tag;
>  	do {
>  		tag = die__process_tag(die, cu, 0);
> -		if (tag == NULL)
> -			goto out_enomem;
> +		if (tag == NULL || tag == UNKNOWN_TAG)
> +			goto out_bad;
>  
>  		long id = -1;
> +
>  		if (cu__table_add_tag(cu, tag, &id) < 0)
>  			goto out_delete_tag;
>  
> @@ -1293,8 +1299,8 @@ static int die__process_namespace(Dwarf_Die *die, struct namespace *namespace,
>  	return 0;
>  out_delete_tag:
>  	tag__delete(tag, cu);
> -out_enomem:
> -	return -ENOMEM;
> +out_bad:
> +	return tag ? -EINVAL : -ENOMEM;
>  }
>  
>  static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
> @@ -1358,6 +1364,8 @@ static int die__process_inline_expansion(Dwarf_Die *die, struct cu *cu)
>  			tag = die__process_tag(die, cu, 0);
>  			if (tag == NULL)
>  				goto out_enomem;
> +			if (tag == UNKNOWN_TAG)
> +				continue;
>  
>  			if (cu__add_tag(cu, tag, &id) < 0)
>  				goto out_delete_tag;
> @@ -1447,6 +1455,11 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
>  			continue;
>  		default:
>  			tag = die__process_tag(die, cu, 0);
> +			if (tag == UNKNOWN_TAG) {
> +				tag__print_not_supported(dwarf_tag(die));
> +				continue;
> +			}
> +
>  			if (tag == NULL)
>  				goto out_enomem;
>  
> @@ -1455,7 +1468,6 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
>  
>  			goto hash;
>  		}
> -
>  		if (tag == NULL)
>  			goto out_enomem;
>  
> @@ -1527,11 +1539,11 @@ static struct tag *__die__process_tag(Dwarf_Die *die, struct cu *cu,
>  		tag = die__create_new_variable(die, cu);	break;
>  	default:
>  		__cu__tag_not_handled(die, fn);
> -		tag = NULL;
> +		tag = UNKNOWN_TAG;
>  		break;
>  	}
>  
> -	if (tag != NULL)
> +	if (tag != NULL && tag != UNKNOWN_TAG)
>  		tag->top_level = top_level;
>  
>  	return tag;
> @@ -1543,6 +1555,8 @@ static int die__process_unit(Dwarf_Die *die, struct cu *cu)
>  		struct tag *tag = die__process_tag(die, cu, 1);
>  		if (tag == NULL)
>  			return -ENOMEM;
> +		if (tag == UNKNOWN_TAG)
> +			return -EINVAL;
>  
>  		long id = -1;
>  		cu__add_tag(cu, tag, &id);


--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
