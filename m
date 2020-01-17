From: Arnaldo Carvalho de Melo <arnaldo.melo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] pahole: fix changelog date in dwarves.spec
Date: Fri, 17 Jan 2020 13:31:23 -0300
Message-ID: <20200117163123.GB21253@kernel.org>
References: <cover.1579221668.git.hex@fb.com>
 <e454b36160ba6cdc0fede26ca2ee8fe15314ae99.1579221668.git.hex@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e454b36160ba6cdc0fede26ca2ee8fe15314ae99.1579221668.git.hex-b10kYP2dOMg@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yulia Kartseva <hex-b10kYP2dOMg@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Thu, Jan 16, 2020 at 04:59:13PM -0800, Yulia Kartseva escreveu:
> From: Julia Kartseva <hex-b10kYP2dOMg@public.gmane.org>
> 
> Signed-off-by: Julia Kartseva <hex-b10kYP2dOMg@public.gmane.org>
> ---
>  rpm/SPECS/dwarves.spec | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied, my bad :-\

- Arnaldo
 
> diff --git a/rpm/SPECS/dwarves.spec b/rpm/SPECS/dwarves.spec
> index 82cb971..6155608 100644
> --- a/rpm/SPECS/dwarves.spec
> +++ b/rpm/SPECS/dwarves.spec
> @@ -127,7 +127,7 @@ make install DESTDIR=%{buildroot}
>  %{_libdir}/%{libname}_reorganize.so
>  
>  %changelog
> -* Mon 16 Dec 2019 Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> - 1.16-1
> +* Mon Dec 16 2019 Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> - 1.16-1
>  - New release: 1.16
>  - BTF encoder: Preserve and encode exported functions as BTF_KIND_FUNC.
>  - BTF loader: Add support for BTF_KIND_FUNC
> -- 
> 2.17.1
> 

-- 

- Arnaldo
