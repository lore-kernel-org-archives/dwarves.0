From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Errors during a pfunct scan for amarokcollectionscanner and
	inkscape
Date: Mon, 16 Jun 2008 15:14:18 -0300
Message-ID: <20080616181418.GA4471@ghostprotocols.net>
References: <m2lk18qrlb.fsf@gmail.com> <20080615171327.GC4597@ghostprotocols.net> <20080615180233.GD4597@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080615180233.GD4597-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Diego 'Flameeyes' =?iso-8859-1?Q?Petten=F2?= <flameeyes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Sun, Jun 15, 2008 at 03:02:33PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> Em Sun, Jun 15, 2008 at 02:13:27PM -0300, Arnaldo Carvalho de Melo es=
creveu:
> > Em Sat, Jun 14, 2008 at 11:43:44AM +0200, Diego 'Flameeyes' Petten=F2=
 escreveu:
> > >=20
> > > Hi :)
> > >=20
> > > On http://www.flameeyes.eu/tmp/dwarves-again.tbz2 you can find th=
e
> > > executables amarokcollectionscanner and inkscape from my workstat=
ion
> > > (Gentoo Linux AMD64), they report these errors when scaning them =
with
> > > pfunct:
> > >=20
> > > flame@enterprise ~ % pfunct /usr/bin/amarokcollectionscanner
> > > dwarf_expr: unhandled 0x12 DW_OP_ operation
> > > dwarf_expr: unhandled 0x12 DW_OP_ operation
> > >=20
> > > as for inkscape:
> > >=20
> > > die__create_new_subroutine_type: DW_TAG_typedef @ <0x6efd> not ha=
ndled!
>=20
> Really strange case:
>=20
>  <1><6d90>: Abbrev Number: 5 (DW_TAG_subroutine_type)
>     <6d91>   DW_AT_sibling     : <0x6dba>      =20
>  <2><6d95>: Abbrev Number: 6 (DW_TAG_formal_parameter)
>     <6d96>   DW_AT_type        : <0x50>=20
>  <2><6d9a>: Abbrev Number: 6 (DW_TAG_formal_parameter)
>     <6d9b>   DW_AT_type        : <0x6d9f>      =20
>  <2><6d9f>: Abbrev Number: 11 (DW_TAG_typedef)
>     <6da0>   DW_AT_name        : (indirect string, offset: 0x1a977): =
CleanupFunc       =20
>     <6da4>   DW_AT_decl_file   : 18    =20
>     <6da5>   DW_AT_decl_line   : 46    =20
>     <6da6>   DW_AT_type        : <0x6a71>      =20
>  <2><6daa>: Abbrev Number: 6 (DW_TAG_formal_parameter)
>     <6dab>   DW_AT_type        : <0x50>=20
>  <2><6daf>: Abbrev Number: 6 (DW_TAG_formal_parameter)
>     <6db0>   DW_AT_type        : <0x6dba>      =20
>  <2><6db4>: Abbrev Number: 6 (DW_TAG_formal_parameter)
>     <6db5>   DW_AT_type        : <0x66c6>
>=20
> This maps to something like this:
>=20
> typedef void (*CleanupFunc)(void *mem, void *data);
>=20
> struct Ops {
>     void (*do_init)();
>     void *(*malloc)(std::size_t size);
>     void *(*malloc_atomic)(std::size_t size);
>     void *(*malloc_uncollectable)(std::size_t size);
>     void *(*malloc_atomic_uncollectable)(std::size_t size);
>     void *(*base)(void *ptr);
>     void (*register_finalizer_ignore_self)(void *base,
>                                            CleanupFunc func, void *da=
ta,
>                                            CleanupFunc *old_func,
>                                            void **old_data);
>=20
> Meaning that the typedef was not encoded right away, but postponed ti=
ll
> just after its first use, i.e. in the parameter list of
> register_finalizer_ignore_self, as if it was local to this function.
> Later on it is again referenced, so its not local, as expected, I'll =
fix
> it, have just to check where to insert this typedef.

=46ixed, I'm now adding the DW_TAG_typedef entries to the compile unit
where the DW_TAG_subroutine_type is defined.

This:

dwarf_expr: unhandled 0x12 DW_OP_ operation

is probably related to pure virtual base classes, this will require a
bit more work but its something its in my TODO list for quite a while,
so I may well implement support for location expressions.

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
