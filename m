From: Arnaldo Carvalho de Melo <acme-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Subject: Re: Brain fart alert
Date: Wed, 20 Mar 2013 10:37:28 -0300
Message-ID: <20130320133728.GE1964@ghostprotocols.net>
References: <CACHCVZ6oDyFwGbC4EwF_wsR9tCkoych5N6buLhRRLcyaL6iifw@mail.gmail.com>
 <20120820180216.GE3046@infradead.org>
 <CACHCVZ5EJadxOTJ0T4phSfAcm1FK7wfeDTp9QcSa1V1JCpa8SA@mail.gmail.com>
 <1346674948.3090.40.camel@springer.wildebeest.org>
 <5060DC56.4080609@gmail.com>
 <CACHCVZ6uvDW1CpyxXio3P17EL6bE=FKGDNm11RNZTceR-dWLjg@mail.gmail.com>
 <1361876163.4930.4.camel@bordewijk.wildebeest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1361876163.4930.4.camel-Et2QWsRS+g7yukXOleVwRPp4M6BF03vq@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Wielaard <mjw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Nicolas <nikos42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Tue, Feb 26, 2013 at 11:56:03AM +0100, Mark Wielaard escreveu:
> On Tue, 2013-02-26 at 02:50 +0100, Nicolas wrote:
> > Hello,
> > 
> > Just pinging the list, about the alert triggered by the example in my
> > last email (brainfart2.cpp).
> 
> The issue is:

Right, I don't recall why this was problematic, so I'm just doing what
you suggest and adding URL for this message in two mailing list archives
for the dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org mailing list.

Will try running again my regression tests on all the debuginfo packages
in a recent Fedora to check if this changes the behavior in some object.

- Arnaldo
 
>  [    69]    class_type
>              name                 (string) "C"
>              byte_size            (data1) 8
>              decl_file            (data1) 1
>              decl_line            (data1) 11
>              containing_type      (ref4) [    69]
>              sibling              (ref4) [    aa]
>  [    77]      inheritance
>                type                 (ref4) [    57]
>                data_member_location (sdata) 0
>                accessibility        (data1) public (1)
>  [    7e]      member
>                name                 (strp) "_vptr.C"
>                type                 (ref4) [    bc]
>                data_member_location (sdata) 0
>                artificial           (flag) Yes
> 
> class__fprintf sees the inheritance and member at the same
> data_member_location and skips the member (which contains the real
> size).
> 
> You could work around it with the following patch:
> 
> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> index 23da5b1..90d830a 100644
> --- a/dwarves_fprintf.c
> +++ b/dwarves_fprintf.c
> @@ -1386,8 +1386,7 @@ size_t class__fprintf(struct class *class, const
> struct cu
>                 ++printed;
>  
>                 /* XXX for now just skip these */
> -               if (tag_pos->tag == DW_TAG_inheritance &&
> -                   pos->virtuality == DW_VIRTUALITY_virtual)
> +               if (tag_pos->tag == DW_TAG_inheritance)
>                         continue;
>  
>                 /*
> 
> Just ignoring the virtuality. But I don't really understand the special
> casing and sizing issues around inheritance. So why this works is a
> mystery to me atm.
> 
> Cheers,
> 
> Mark
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dwarves" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
