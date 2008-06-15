From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Errors during a pfunct scan for amarokcollectionscanner and
	inkscape
Date: Sun, 15 Jun 2008 14:13:27 -0300
Message-ID: <20080615171327.GC4597@ghostprotocols.net>
References: <m2lk18qrlb.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m2lk18qrlb.fsf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Diego 'Flameeyes' =?iso-8859-1?Q?Petten=F2?= <flameeyes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Sat, Jun 14, 2008 at 11:43:44AM +0200, Diego 'Flameeyes' Petten=F2 e=
screveu:
>=20
> Hi :)
>=20
> On http://www.flameeyes.eu/tmp/dwarves-again.tbz2 you can find the
> executables amarokcollectionscanner and inkscape from my workstation
> (Gentoo Linux AMD64), they report these errors when scaning them with
> pfunct:
>=20
> flame@enterprise ~ % pfunct /usr/bin/amarokcollectionscanner
> dwarf_expr: unhandled 0x12 DW_OP_ operation
> dwarf_expr: unhandled 0x12 DW_OP_ operation
>=20
> as for inkscape:
>=20
> die__create_new_subroutine_type: DW_TAG_typedef @ <0x6efd> not handle=
d!
> die__create_new_subroutine_type: DW_TAG_typedef @ <0x27f5c> not handl=
ed!
> die__create_new_subroutine_type: DW_TAG_typedef @ <0x5c595> not handl=
ed!
> die__create_new_subroutine_type: DW_TAG_typedef @ <0x6ff53> not handl=
ed!
> die__create_new_subroutine_type: DW_TAG_typedef @ <0x72aa8> not handl=
ed!
> die__create_new_subroutine_type: DW_TAG_typedef @ <0x9b03c> not handl=
ed!
> die__create_new_subroutine_type: DW_TAG_typedef @ <0xb1ed8> not handl=
ed!
> die__create_new_subroutine_type: DW_TAG_typedef @ <0xbd92a> not handl=
ed!
> die__create_new_subroutine_type: DW_TAG_typedef @ <0xc2695> not handl=
ed!
> die__create_new_subroutine_type: DW_TAG_typedef @ <0xc8a1d> not handl=
ed!
> die__create_new_subroutine_type: DW_TAG_typedef @ <0xe6963> not handl=
ed!
> die__create_new_subroutine_type: DW_TAG_typedef @ <0x102f92> not hand=
led!
> die__create_new_subroutine_type: DW_TAG_typedef @ <0x10aea1> not hand=
led!
> die__create_new_subroutine_type: DW_TAG_typedef @ <0x10f886> not hand=
led!
> die__create_new_subroutine_type: DW_TAG_typedef @ <0x11c1a9> not hand=
led!
> die__create_new_subroutine_type: DW_TAG_typedef @ <0x129f32> not hand=
led!
> die__create_new_subroutine_type: DW_TAG_typedef @ <0x14aa06> not hand=
led!
> dwarf_expr: unhandled 0x12 DW_OP_ operation
>=20
> and it continues for a long time.
>=20
> This is dwarves from GIT of a few days ago.

The files provided in the tarball contains no debugging information,
please check.

I'll try installing the debunginfo for those packages in fedora rawhide=
=2E

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
