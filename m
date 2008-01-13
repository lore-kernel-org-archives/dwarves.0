From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Changing the word-size was: Re: eat your own dog food?
Date: Sun, 13 Jan 2008 16:26:57 -0200
Message-ID: <20080113182657.GI17675@ghostprotocols.net>
References: <20080112155404.GB23567@ghostprotocols.net> <20080112162808.GC23567@ghostprotocols.net> <20080112172856.GD23567@ghostprotocols.net> <1200161321.31540.10.camel@localhost> <20080112184211.GA17675@ghostprotocols.net> <1200184926.31540.13.camel@localhost> <1200186955.31540.26.camel@localhost> <20080113163106.GE17675@ghostprotocols.net> <20080113180730.GG17675@ghostprotocols.net> <20080113181901.GH17675@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080113181901.GH17675-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jamal <hadi-fAAogVwAN2Kw5LPnMra/2Q@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Sun, Jan 13, 2008 at 04:19:01PM -0200, Arnaldo Carvalho de Melo escreveu:
> Em Sun, Jan 13, 2008 at 04:07:30PM -0200, Arnaldo Carvalho de Melo escreveu:
> > Em Sun, Jan 13, 2008 at 02:31:06PM -0200, Arnaldo Carvalho de Melo escreveu:
> > > Em Sat, Jan 12, 2008 at 08:15:55PM -0500, jamal escreveu:
> > > > On Sat, 2008-12-01 at 19:42 -0500, jamal wrote:
> > > > 
> > > > In this case the tail padding should be 7.
> > > > 
> > > > The rules say:
> > > > 1) aggregates have alignment equal to that of their most aligned
> > > >   member - which happens to be 8 above
> > > > 2) aggregates have sizes which are a multiple of their alignment
> > > >   This may result in tail padding - the tail contains a char.
> > > > 
> > > > So the padding above should be 7.
> > > 
> > > Working on that, implementing type__most_aligned_member(), that will
> > > recursively find the member that is most aligned, but then how to deal
> > > with packed structs?
> > 
> > Should be fixed now for non-packed structs, please ACK.
> 
> Oops, I concentrated on the tail padding, have to check how we're
> handling rule number 1, but now we infrastructure is there, should be
> easy.

Looks OK:

[acme@doppio examples]$ file align
align: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically
linked (uses shared libs), for GNU/Linux 2.6.9, not stripped
[acme@doppio examples]$ ../build/pahole align
struct foo {
	char                       l;                    /*     0     1 */

	/* XXX 7 bytes hole, try to pack */

	struct {
		unsigned int       b;                    /*     8     4 */
		struct {
			long unsigned int c;             /*    16     8 */
		};                                       /*    16     8 */
	};                                               /*     8    16 */
	char                       a;                    /*    24     1 */

	/* size: 32, cachelines: 1 */
	/* sum members: 18, holes: 1, sum holes: 7 */
	/* padding: 7 */
	/* last cacheline: 32 bytes */
};

[acme@doppio examples]$ ../build/pahole -w4 align
struct foo {
	char                       l;                    /*     0     1 */

	/* XXX 3 bytes hole, try to pack */

	struct {
		unsigned int       b;                    /*     4     4 */
		struct {
			long unsigned int c;             /*     8     4 */
		};                                       /*     8     4 */
	};                                               /*     4     8 */
	char                       a;                    /*    12     1 */

	/* size: 16, cachelines: 1 */
	/* sum members: 10, holes: 1, sum holes: 3 */
	/* padding: 3 */
	/* last cacheline: 16 bytes */
};

Looks ok when going from 32-bit to 64-bit

[acme@doppio examples]$ gcc -m32 -g align.c -o align
[acme@doppio examples]$ file align
align: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV),
dynamically linked (uses shared libs), for GNU/Linux 2.6.9, not stripped

[acme@doppio examples]$ ../build/pahole align
struct foo {
	char                       l;                    /*     0     1 */

	/* XXX 3 bytes hole, try to pack */

	struct {
		unsigned int       b;                    /*     4     4 */
		struct {
			long unsigned int c;             /*     8     4 */
		};                                       /*     8     4 */
	};                                               /*     4     8 */
	char                       a;                    /*    12     1 */

	/* size: 16, cachelines: 1 */
	/* sum members: 10, holes: 1, sum holes: 3 */
	/* padding: 3 */
	/* last cacheline: 16 bytes */
};

[acme@doppio examples]$ ../build/pahole -w8 align
struct foo {
	char                       l;                    /*     0     1 */

	/* XXX 3 bytes hole, try to pack */

	struct {
		unsigned int       b;                    /*     4     4 */

		/* XXX 4 bytes hole, try to pack */

		struct {
			long unsigned int c;             /*    12     8 */
		};                                       /*    12     8 */
	};                                               /*     4    16 */

	/* Bitfield combined with next fields */

	char                       a;                    /*    16     1 */

	/* size: 24, cachelines: 1 */
	/* sum members: 14, holes: 1, sum holes: 3 */
	/* padding: 7 */
	/* last cacheline: 24 bytes */
};

But not when going from 32-bit to 64-bit, sigh :-\

And there is another bug, the bitfield combining code got confused,
because the offset for 'a' is not at 20 as it should even when not
correctly aligning the outernmost unnamed struct.

Will fix.

- Arnaldo
-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
