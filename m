From: Jiri Olsa <jolsa-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC/PATCH 0/3] dwarves print: Cacheline accounting fixes
Date: Wed, 16 Dec 2015 17:57:29 +0100
Message-ID: <20151216165729.GA2265@krava.brq.redhat.com>
References: <1449614826-2278-1-git-send-email-jolsa@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1449614826-2278-1-git-send-email-jolsa-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Olsa <jolsa-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Arnaldo Carvalho de Melo <acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Joe Mario <jmario-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

On Tue, Dec 08, 2015 at 11:47:03PM +0100, Jiri Olsa wrote:
> hi,
> hit 2 issues when used pahole
>  - sometimes it did not account the hole between variables
>  - when using -E to extract inner struct, cacheline boundaries were wrong
> 
> with this patchset I was able to get it work on structs
> that I was investigating, but I'm not sure I covered all
> parts or fixed it in proper way.

any feedback?

thanks,
jirka
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
