From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: dwarf_expr: unhandled 0x12 DW_OP_ operation
Date: Fri, 15 Feb 2008 11:11:36 -0200
Message-ID: <20080215131136.GC31602@ghostprotocols.net>
References: <m2wsp68jnl.fsf@gmail.com> <20080215130818.GB31602@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080215130818.GB31602-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Diego 'Flameeyes' =?iso-8859-1?Q?Petten=F2?= <flameeyes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Fri, Feb 15, 2008 at 11:08:18AM -0200, Arnaldo Carvalho de Melo escr=
eveu:
> Em Fri, Feb 15, 2008 at 01:54:22PM +0100, Diego 'Flameeyes' Petten=F2=
 escreveu:
> >=20
> > I'm trying to use pfunct to identify software that bundles internal
> > copies of common libraries (I've started with zlib's adler32 functi=
on
> > for now), and I've seen this message being repeated tons of times f=
or
> > kile, kxmleditor, VirtualBox and a lot more stuff.
> >=20
> > Has anybody an idea of what that means?
>=20
> virtual public classes :-\ Can you send me one of the object files? I=
'll
> try to work on supporting non-trivial DWARF expressions so that we
> properly support this.

No need for that, I have an object from the ATLAS project that has thes=
e
types of classes:

struct IL1JetTools : virtual public IAlgTool {
public:

        /* struct IAlgTool            <ancestor>; */     /* 4294967295 =
4 */

<SNIP>

See the offset?

- Arnaldo
