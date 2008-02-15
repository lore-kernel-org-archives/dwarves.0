From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dwarf_expr: unhandled 0x12 DW_OP_ operation
Date: Fri, 15 Feb 2008 11:36:20 -0200
Message-ID: <20080215133619.GD31602@ghostprotocols.net>
References: <m2wsp68jnl.fsf@gmail.com> <20080215130818.GB31602@ghostprotocols.net> <20080215131136.GC31602@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080215131136.GC31602-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Diego 'Flameeyes' =?iso-8859-1?Q?Petten=F2?= <flameeyes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Fri, Feb 15, 2008 at 11:11:36AM -0200, Arnaldo Carvalho de Melo escr=
eveu:
> Em Fri, Feb 15, 2008 at 11:08:18AM -0200, Arnaldo Carvalho de Melo es=
creveu:
> > Em Fri, Feb 15, 2008 at 01:54:22PM +0100, Diego 'Flameeyes' Petten=F2=
 escreveu:
> > >=20
> > > I'm trying to use pfunct to identify software that bundles intern=
al
> > > copies of common libraries (I've started with zlib's adler32 func=
tion
> > > for now), and I've seen this message being repeated tons of times=
 for
> > > kile, kxmleditor, VirtualBox and a lot more stuff.
> > >=20
> > > Has anybody an idea of what that means?
> >=20
> > virtual public classes :-\ Can you send me one of the object files?=
 I'll
> > try to work on supporting non-trivial DWARF expressions so that we
> > properly support this.
>=20
> No need for that, I have an object from the ATLAS project that has th=
ese
> types of classes:
>=20
> struct IL1JetTools : virtual public IAlgTool {
> public:
>=20
>         /* struct IAlgTool            <ancestor>; */     /* 429496729=
5 4 */
>=20
> <SNIP>
>=20
> See the offset?

dwarf_expr: unhandled DWARF expression: DW_OP_dup DW_OP_deref DW_OP_lit=
28 DW_OP_minus DW_OP_deref DW_OP_plus=20
dwarf_expr: unhandled DWARF expression: DW_OP_dup DW_OP_deref DW_OP_con=
st1u DW_OP_shl DW_OP_minus DW_OP_deref DW_OP_plus=20
dwarf_expr: unhandled DWARF expression: DW_OP_dup DW_OP_deref DW_OP_lit=
28 DW_OP_minus DW_OP_deref DW_OP_plus=20
dwarf_expr: unhandled DWARF expression: DW_OP_dup DW_OP_deref DW_OP_lit=
20 DW_OP_minus DW_OP_deref DW_OP_plus=20
dwarf_expr: unhandled DWARF expression: DW_OP_dup DW_OP_deref DW_OP_con=
st1u DW_OP_lit28 DW_OP_minus DW_OP_deref DW_OP_plus=20
dwarf_expr: unhandled DWARF expression: DW_OP_dup DW_OP_deref DW_OP_con=
st1u DW_OP_reg8 DW_OP_minus DW_OP_deref DW_OP_plus=20
dwarf_expr: unhandled DWARF expression: DW_OP_dup DW_OP_deref DW_OP_con=
st1u DW_OP_lit20 DW_OP_minus DW_OP_deref DW_OP_plus=20
dwarf_expr: unhandled DWARF expression: DW_OP_dup DW_OP_deref DW_OP_lit=
28 DW_OP_minus DW_OP_deref DW_OP_plus=20
dwarf_expr: unhandled DWARF expression: DW_OP_dup DW_OP_deref DW_OP_con=
st1u DW_OP_shl DW_OP_minus DW_OP_deref DW_OP_plus=20
dwarf_expr: unhandled DWARF expression: DW_OP_dup DW_OP_deref DW_OP_lit=
28 DW_OP_minus DW_OP_deref DW_OP_plus=20
dwarf_expr: unhandled DWARF expression: DW_OP_dup DW_OP_deref DW_OP_lit=
20 DW_OP_minus DW_OP_deref DW_OP_plus=20
dwarf_expr: unhandled DWARF expression: DW_OP_dup DW_OP_deref DW_OP_con=
st1u DW_OP_lit28 DW_OP_minus DW_OP_deref DW_OP_plus=20
dwarf_expr: unhandled DWARF expression: DW_OP_dup DW_OP_deref DW_OP_con=
st1u DW_OP_lit20 DW_OP_minus DW_OP_deref DW_OP_plus=20
dwarf_expr: unhandled DWARF expression: DW_OP_dup DW_OP_deref DW_OP_con=
st1u DW_OP_reg8 DW_OP_minus DW_OP_deref DW_OP_plus=20

So, for the first expression: it takes the value of some register,
duplicates it on the stack, dereference the top of the stack and put it
on the stack, puts lit28 on the stack, subtracts the two entries in the
stack and puts the result on the stack and then dereferences the top of
the stack and adds the two and puts the result on the stack, that shoul=
d
be the end result that will tell where the ancestor class instance is.

Now to understand what is DW_OP_lit28, perhaps just the value 28? But
why do we have also DW_OP_const28u? /me reads the DWARF docs...

- Arnaldo
