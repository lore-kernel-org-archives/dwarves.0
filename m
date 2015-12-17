From: Jiri Olsa <jolsa-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/3] dwarves print: Pass into struct conf_fprintf
 class__fprintf_cacheline_boundary
Date: Thu, 17 Dec 2015 10:17:01 +0100
Message-ID: <20151217091701.GA5123@krava.brq.redhat.com>
References: <1449614826-2278-1-git-send-email-jolsa@kernel.org>
 <1449614826-2278-3-git-send-email-jolsa@kernel.org>
 <20151216180017.GC6843@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151216180017.GC6843-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jiri Olsa <jolsa-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Joe Mario <jmario-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

On Wed, Dec 16, 2015 at 03:00:17PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Dec 08, 2015 at 11:47:05PM +0100, Jiri Olsa escreveu:
> > Passing into struct conf_fprintf class__fprintf_cacheline_boundary,
> > so the next patch is more easy to read.
> 
> "Passing struct conf_fprintf to class__fprintf_cacheline_boundary(), so
> the next patch is more easy to read."
> 
> ?

exactly ;-)

jirka
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
