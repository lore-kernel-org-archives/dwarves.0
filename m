From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: speedup in tag lookup using hash tables
Date: Tue, 12 Feb 2008 10:50:37 -0200
Message-ID: <20080212125037.GE4157@ghostprotocols.net>
References: <20080212000310.GB4157@ghostprotocols.net> <Pine.LNX.4.64.0802121301180.31652@kivilampi-30.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0802121301180.31652-Y/UOj9v5BLQhZigby9b+C6cUovnZ0M2TMR2xtNvyitY@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen-pxSi+dnQzZMxHbG02/KK1g@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Tue, Feb 12, 2008 at 01:24:44PM +0200, Ilpo J=E4rvinen escreveu:
> On Mon, 11 Feb 2008, Arnaldo Carvalho de Melo wrote:
>=20
> > 	Today I optimized the dwarves a bit by using a per object file
> > hash table for tag lookup, it yelded almost 50% speedup on pahole w=
hen
> > running on a vmlinux file :-)
> >
> > 	codiff doesn't makes that much tag lookups, so we didn't got
> > much improvements there,
>=20
> Because I had to do these file by file anyway, I ended up using modif=
ied=20
> timestamps in my scripts to avoid loading .o files altogether when on=
e=20
> wasn't recompiled. It helped some.

This reminds me that I have to add support comparing build trees, so
that we can use 'make O=3Dold' to build a baseline and then 'make O=3Dn=
ew',
using ccache to reuse the old (or simply copying old to new) and then
process file after file, combining the results for tree wide
comparisions/statistics.
=20
> > but I'm doing experiments on dead tag elimination
> > that probably will help a lot there, but for that I have first to g=
rok
> > Ulrich Drepper's libdisasm to find out what are the tags that are r=
eally
> > used by looking at accesses to register indexed memory areas that u=
se as
> > a base pointer what is in local/global variables and function
> > parameters.
> >
> > 	This also will provide the basis for detecting access patterns
> > that will ultimatelly allow libdwarves_reorganize to do struct
> > reorganizations to improve locality of reference, etc.
>=20
> This sounds nice, I was thinking something similar earlier but would =
have=20
> tried to do that with some kind of source analysis.

That is possible too, and indeed I did experiments in the past with
sparse, the library used by the kernel checker (make C=3D[12]), but I
think that tapping into the readily available debuginfo packages, not
just for the kernel, looking at the end, object file, result is better.
=20
> > 	Please take a look at v1.6 that I pushed today and tell me your
> > impressions.
>=20
> Thanks, I'll check that later on. My bruteforce inline remover run ov=
er=20
> all include/ stuff just finished yesterday after ~1.5 days (ie. ~5800=
=20
> inlines compile tested on ~90 slaves, next time I'll have to plug cca=
che=20
> into that site-specific distribute thing I use to speed it up a lot :=
-)),=20
> I'll post the results later on to lkml+netdev with some patches and=20
> thoughts, the winner seems to be this beauty :-) :
>    -110805  869 funcs, 198 +, 111003 -, diff: -110805 --- skb_put
> ...And 22 other are in 10000+ category and 235 1kB+ (some overlap=20
> exists due to __-funcs). What still remains to do are the non-include=
/=20
> headers which might reveal some candies too.

Excellent! Some people at some point noted that while the dwarves are
useful for showing the problems, people actually had to follow up with
patches to solve the problems, I'm very happy that you are doing just
that, thanks a lot for that.

- Arnaldo
