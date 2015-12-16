From: Arnaldo Carvalho de Melo <acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] dwarves print: Fix holes accounting
Date: Wed, 16 Dec 2015 14:58:39 -0300
Message-ID: <20151216175839.GB6843@kernel.org>
References: <1449614826-2278-1-git-send-email-jolsa@kernel.org>
 <1449614826-2278-2-git-send-email-jolsa@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1449614826-2278-2-git-send-email-jolsa-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Olsa <jolsa-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Joe Mario <jmario-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Tue, Dec 08, 2015 at 11:47:04PM +0100, Jiri Olsa escreveu:
> Sometimes the hole could be missing, try to bypass
> this issue by comparing last and current offsets.

Can you provide an example of before and after this change? What real
case triggered this?

- Arnaldo
 
> Signed-off-by: Jiri Olsa <jolsa-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  dwarves_fprintf.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> index 71d8ce9f982b..df80af255c67 100644
> --- a/dwarves_fprintf.c
> +++ b/dwarves_fprintf.c
> @@ -1268,6 +1268,17 @@ size_t class__fprintf(struct class *class, const struct cu *cu,
>  		}
>  		pos = tag__class_member(tag_pos);
>  
> +		/*
> +		 * Sometimes the hole could be missing, try to bypass
> +		 * this issue by comparing last and current offsets.
> +		 */
> +		if (last) {
> +			uint32_t tmp = last->byte_offset + last->byte_size + last->hole;
> +
> +			if (pos->byte_offset > tmp)
> +				sum_holes += pos->byte_offset - tmp;
> +		}
> +
>  		if (last != NULL &&
>  		    pos->byte_offset != last->byte_offset &&
>  		    !cconf.suppress_comments)
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
