From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: pahole displays type incorrectly
Date: Thu, 10 Sep 2009 17:35:17 -0300
Message-ID: <20090910203517.GA2289@ghostprotocols.net>
References: <alpine.LSU.2.00.0908171610490.31821@fbirervta.pbzchgretzou.qr> <20090817154228.GI12303@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090817154228.GI12303-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jan Engelhardt <jengelh-nopoi9nDyk+ELgA04lAiVw@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Mon, Aug 17, 2009 at 12:42:28PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Aug 17, 2009 at 04:12:25PM +0200, Jan Engelhardt escreveu:
> > Hi,
> > 
> > 
> > given the following struct:
> > 
> >   struct x {
> >   	const char *const s;
> >   };
> > 
> > pahole will display it as:
> > 
> >   struct x {
> >         const const char *s; /* .. */
> >   };
> > 
> > And that is not quite right. The sparse(1) tool would say "how much more 
> > const do you want it to be?" :)
> > I used pahole.git commit f0435286c0b.
> 
> pahole is not properly handling that case at the moment, the DWARF chain
> is:
> 
> [acme@doppio pahole]$ readelf -wi object_samples/jengelh\@medozas.de/const_const
> <SNIP>
>  <1><2d>: Abbrev Number: 2 (DW_TAG_structure_type)
>     <2e>   DW_AT_name        : x        
>     <30>   DW_AT_byte_size   : 8        
>     <31>   DW_AT_decl_file   : 1        
>     <32>   DW_AT_decl_line   : 1        
>     <33>   DW_AT_sibling     : <0x44>   
>  <2><37>: Abbrev Number: 3 (DW_TAG_member)
>     <38>   DW_AT_name        : s        
>     <3a>   DW_AT_decl_file   : 1        
>     <3b>   DW_AT_decl_line   : 2        
>     <3c>   DW_AT_type        : <0x44>   
>     <40>   DW_AT_data_member_location: 2 byte block: 23 0
> (DW_OP_plus_uconst: 0)
>  <1><44>: Abbrev Number: 4 (DW_TAG_const_type)
>     <45>   DW_AT_type        : <0x49>   
>  <1><49>: Abbrev Number: 5 (DW_TAG_pointer_type)
>     <4a>   DW_AT_byte_size   : 8        
>     <4b>   DW_AT_type        : <0x4f>   
>  <1><4f>: Abbrev Number: 4 (DW_TAG_const_type)
>     <50>   DW_AT_type        : <0x54>   
>  <1><54>: Abbrev Number: 6 (DW_TAG_base_type)
>     <55>   DW_AT_byte_size   : 1        
>     <56>   DW_AT_encoding    : 6        (signed char)
>     <57>   DW_AT_name        : (indirect string, offset: 0x72): char    
> 
> <SNIP>
> 
> So if we find a const at the start of the chain, we must render it
> first, then the type, but if we find it inside the chain, it has to be
> rendered at the end of the chain... I'm reworking the code that
> recursively traverses the chain to fix this, but I'm being sidetracked
> with some other work, stay tuned and I'll get this fixed today
> 
> Thanks for the report!

Sorry for the delay, should be fixed by the latest commit, please give
it a try!

http://git.kernel.org/?p=linux/kernel/git/acme/pahole.git;a=commitdiff;h=846927a3f87f730e0ae201b5f0b3b46212a7bb8e

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
