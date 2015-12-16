From: Arnaldo Carvalho de Melo <acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] dwarves print: Pass into struct conf_fprintf
 class__fprintf_cacheline_boundary
Date: Wed, 16 Dec 2015 15:00:17 -0300
Message-ID: <20151216180017.GC6843@kernel.org>
References: <1449614826-2278-1-git-send-email-jolsa@kernel.org>
 <1449614826-2278-3-git-send-email-jolsa@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1449614826-2278-3-git-send-email-jolsa-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Olsa <jolsa-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Joe Mario <jmario-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Tue, Dec 08, 2015 at 11:47:05PM +0100, Jiri Olsa escreveu:
> Passing into struct conf_fprintf class__fprintf_cacheline_boundary,
> so the next patch is more easy to read.

"Passing struct conf_fprintf to class__fprintf_cacheline_boundary(), so
the next patch is more easy to read."

?

> Signed-off-by: Jiri Olsa <jolsa-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  dwarves_fprintf.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> index df80af255c67..2d114210831a 100644
> --- a/dwarves_fprintf.c
> +++ b/dwarves_fprintf.c
> @@ -1122,7 +1122,8 @@ static size_t class__fprintf_cacheline_boundary(uint32_t last_cacheline,
>  						size_t sum, size_t sum_holes,
>  						uint8_t *newline,
>  						uint32_t *cacheline,
> -						int indent, FILE *fp)
> +						struct conf_fprintf *cconf,
> +						FILE *fp)
>  {
>  	const size_t real_sum = sum + sum_holes;
>  	size_t printed = 0;
> @@ -1139,7 +1140,7 @@ static size_t class__fprintf_cacheline_boundary(uint32_t last_cacheline,
>  			++printed;
>  		}
>  
> -		printed += fprintf(fp, "%.*s", indent, tabs);
> +		printed += fprintf(fp, "%.*s", cconf->indent, tabs);
>  
>  		if (cacheline_pos == 0)
>  			printed += fprintf(fp, "/* --- cacheline %u boundary "
> @@ -1287,7 +1288,7 @@ size_t class__fprintf(struct class *class, const struct cu *cu,
>  							      sum, sum_holes,
>  							      &newline,
>  							      &last_cacheline,
> -							      cconf.indent,
> +							      &cconf,
>  							      fp);
>  		/*
>  		 * These paranoid checks doesn't make much sense on
> @@ -1477,7 +1478,7 @@ size_t class__fprintf(struct class *class, const struct cu *cu,
>  							     sum, sum_holes,
>  							     &newline,
>  							     &last_cacheline,
> -							     cconf.indent, fp);
> +							     &cconf, fp);
>  	if (!cconf.show_only_data_members)
>  		class__vtable_fprintf(class, cu, &cconf, fp);
>  
> -- 
> 2.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dwarves" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
