From: "=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen-pxSi+dnQzZMxHbG02/KK1g@public.gmane.org>
Subject: Re: speedup in tag lookup using hash tables
Date: Tue, 12 Feb 2008 13:24:44 +0200 (EET)
Message-ID: <Pine.LNX.4.64.0802121301180.31652@kivilampi-30.cs.helsinki.fi>
References: <20080212000310.GB4157@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080212000310.GB4157-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

On Mon, 11 Feb 2008, Arnaldo Carvalho de Melo wrote:

> 	Today I optimized the dwarves a bit by using a per object file
> hash table for tag lookup, it yelded almost 50% speedup on pahole when
> running on a vmlinux file :-)
>
> 	codiff doesn't makes that much tag lookups, so we didn't got
> much improvements there,

Because I had to do these file by file anyway, I ended up using modified 
timestamps in my scripts to avoid loading .o files altogether when one 
wasn't recompiled. It helped some.

> but I'm doing experiments on dead tag elimination
> that probably will help a lot there, but for that I have first to grok
> Ulrich Drepper's libdisasm to find out what are the tags that are really
> used by looking at accesses to register indexed memory areas that use as
> a base pointer what is in local/global variables and function
> parameters.
>
> 	This also will provide the basis for detecting access patterns
> that will ultimatelly allow libdwarves_reorganize to do struct
> reorganizations to improve locality of reference, etc.

This sounds nice, I was thinking something similar earlier but would have 
tried to do that with some kind of source analysis.

> 	Please take a look at v1.6 that I pushed today and tell me your
> impressions.

Thanks, I'll check that later on. My bruteforce inline remover run over 
all include/ stuff just finished yesterday after ~1.5 days (ie. ~5800 
inlines compile tested on ~90 slaves, next time I'll have to plug ccache 
into that site-specific distribute thing I use to speed it up a lot :-)), 
I'll post the results later on to lkml+netdev with some patches and 
thoughts, the winner seems to be this beauty :-) :
   -110805  869 funcs, 198 +, 111003 -, diff: -110805 --- skb_put
...And 22 other are in 10000+ category and 235 1kB+ (some overlap 
exists due to __-funcs). What still remains to do are the non-include/ 
headers which might reveal some candies too.


-- 
 i.
