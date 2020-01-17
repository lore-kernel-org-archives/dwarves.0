From: Arnaldo Carvalho de Melo <arnaldo.melo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] pahole: fix compiler warning
Date: Fri, 17 Jan 2020 13:28:26 -0300
Message-ID: <20200117162826.GA21253@kernel.org>
References: <cover.1579221668.git.hex@fb.com>
 <d0b9a8c3bd459fb41f9b4dfb80d5a5972b5c2949.1579221668.git.hex@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d0b9a8c3bd459fb41f9b4dfb80d5a5972b5c2949.1579221668.git.hex-b10kYP2dOMg@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yulia Kartseva <hex-b10kYP2dOMg@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Thu, Jan 16, 2020 at 04:59:12PM -0800, Yulia Kartseva escreveu:
> From: Julia Kartseva <hex-b10kYP2dOMg@public.gmane.org>
> 
> Signed-off-by: Julia Kartseva <hex-b10kYP2dOMg@public.gmane.org>
> ---
>  pahole.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pahole.c b/pahole.c
> index 829c9ab..7ac49c2 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -684,8 +684,8 @@ static void print_structs_with_pointer_to(struct cu *cu, uint32_t type)
>  	uint32_t id;
>  
>  	cu__for_each_struct_or_union(cu, id, pos) {
> +		struct structure *str = NULL;
>  		bool looked = false;
> -		struct structure *str;

I just fixed this one after trying to build it on RHEL7, thanks!

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=9b09f578b7d1e75cf168e9b3098d4fb17504f26e

- Arnaldo
  
>  		if (pos->type.namespace.name == 0)
>  			continue;
> -- 
> 2.17.1
> 

-- 

- Arnaldo
