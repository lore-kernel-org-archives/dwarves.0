From: jamal <hadi-fAAogVwAN2Kw5LPnMra/2Q@public.gmane.org>
Subject: Re: Changing the word-size was: Re: eat your own dog food?
Date: Sun, 13 Jan 2008 14:13:02 -0500
Message-ID: <1200251582.4427.15.camel@localhost>
References: <20080112155404.GB23567@ghostprotocols.net>
	 <20080112162808.GC23567@ghostprotocols.net>
	 <20080112172856.GD23567@ghostprotocols.net>
	 <1200161321.31540.10.camel@localhost>
	 <20080112184211.GA17675@ghostprotocols.net>
	 <1200184926.31540.13.camel@localhost> <1200186955.31540.26.camel@localhost>
	 <20080113163106.GE17675@ghostprotocols.net>
	 <20080113180730.GG17675@ghostprotocols.net>
	 <20080113181901.GH17675@ghostprotocols.net>
	 <20080113182657.GI17675@ghostprotocols.net>
Reply-To: hadi-fAAogVwAN2Kw5LPnMra/2Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080113182657.GI17675-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

On Sun, 2008-13-01 at 16:26 -0200, Arnaldo Carvalho de Melo wrote:

> > > > 
> > > > Working on that, implementing type__most_aligned_member(), that will
> > > > recursively find the member that is most aligned, but then how to deal
> > > > with packed structs?

packed structs _always_ have alignment = 1 afaik.


> Looks OK:

I updated tree and recompiled - retested and all looks ok to me ....

> [acme@doppio examples]$ file align


> [acme@doppio examples]$ ../build/pahole align
> struct foo {
> 	char                       l;                    /*     0     1 */
> 
> 	/* XXX 3 bytes hole, try to pack */
> 
> 	struct {
> 		unsigned int       b;                    /*     4     4 */
> 		struct {
> 			long unsigned int c;             /*     8     4 */
> 		};                                       /*     8     4 */
> 	};                                               /*     4     8 */
> 	char                       a;                    /*    12     1 */
> 
> 	/* size: 16, cachelines: 1 */
> 	/* sum members: 10, holes: 1, sum holes: 3 */
> 	/* padding: 3 */
> 	/* last cacheline: 16 bytes */
> };
> 
> [acme@doppio examples]$ ../build/pahole -w8 align
> struct foo {
> 	char                       l;                    /*     0     1 */
> 
> 	/* XXX 3 bytes hole, try to pack */
> 
> 	struct {
> 		unsigned int       b;                    /*     4     4 */
> 
> 		/* XXX 4 bytes hole, try to pack */
> 
> 		struct {
> 			long unsigned int c;             /*    12     8 */
> 		};                                       /*    12     8 */
> 	};                                               /*     4    16 */
> 
> 	/* Bitfield combined with next fields */
> 
> 	char                       a;                    /*    16     1 */
> 
> 	/* size: 24, cachelines: 1 */
> 	/* sum members: 14, holes: 1, sum holes: 3 */
> 	/* padding: 7 */
> 	/* last cacheline: 24 bytes */
> };
> 
> But not when going from 32-bit to 64-bit, sigh :-\
> And there is another bug, the bitfield combining code got confused,
> because the offset for 'a' is not at 20 as it should even when not
> correctly aligning the outernmost unnamed struct.

got same results here. Other than that annoyance the results look
correct.

Note: So far what you have seems to work well (sans the little bug
above) for say x86 32<->64. The bizare part imo is the alignment
difference with different archs (eg -w 4 for ppc vs ia32 would result in
different holes/paddings).
Q: Wouldnt it be better to just build arrays/tables of all the rules as
per eabi? i.e you have a sizeof and alignment rows and then you can do
table lookup of arch/type where key could infact be a dwarf tag. What
that would mean is to have cli interface for --arch ppc32 or --arch
mips64 etc. If you do that, then allow users to also add new archs for
you.

> Will fix.

Ok, let me know.

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
