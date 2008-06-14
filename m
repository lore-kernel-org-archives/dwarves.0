From: flameeyes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org (Diego 'Flameeyes' =?utf-8?Q?Petten=C3=B2?=)
Subject: Errors during a pfunct scan for amarokcollectionscanner and inkscape
Date: Sat, 14 Jun 2008 11:43:44 +0200
Message-ID: <m2lk18qrlb.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi :)

On http://www.flameeyes.eu/tmp/dwarves-again.tbz2 you can find the
executables amarokcollectionscanner and inkscape from my workstation
(Gentoo Linux AMD64), they report these errors when scaning them with
pfunct:

flame@enterprise ~ % pfunct /usr/bin/amarokcollectionscanner
dwarf_expr: unhandled 0x12 DW_OP_ operation
dwarf_expr: unhandled 0x12 DW_OP_ operation

as for inkscape:

die__create_new_subroutine_type: DW_TAG_typedef @ <0x6efd> not handled!
die__create_new_subroutine_type: DW_TAG_typedef @ <0x27f5c> not handled!
die__create_new_subroutine_type: DW_TAG_typedef @ <0x5c595> not handled!
die__create_new_subroutine_type: DW_TAG_typedef @ <0x6ff53> not handled!
die__create_new_subroutine_type: DW_TAG_typedef @ <0x72aa8> not handled!
die__create_new_subroutine_type: DW_TAG_typedef @ <0x9b03c> not handled!
die__create_new_subroutine_type: DW_TAG_typedef @ <0xb1ed8> not handled!
die__create_new_subroutine_type: DW_TAG_typedef @ <0xbd92a> not handled!
die__create_new_subroutine_type: DW_TAG_typedef @ <0xc2695> not handled!
die__create_new_subroutine_type: DW_TAG_typedef @ <0xc8a1d> not handled!
die__create_new_subroutine_type: DW_TAG_typedef @ <0xe6963> not handled!
die__create_new_subroutine_type: DW_TAG_typedef @ <0x102f92> not handled!
die__create_new_subroutine_type: DW_TAG_typedef @ <0x10aea1> not handled!
die__create_new_subroutine_type: DW_TAG_typedef @ <0x10f886> not handled!
die__create_new_subroutine_type: DW_TAG_typedef @ <0x11c1a9> not handled!
die__create_new_subroutine_type: DW_TAG_typedef @ <0x129f32> not handled!
die__create_new_subroutine_type: DW_TAG_typedef @ <0x14aa06> not handled!
dwarf_expr: unhandled 0x12 DW_OP_ operation

and it continues for a long time.

This is dwarves from GIT of a few days ago.

HTH,
=2D-=20
Diego "Flameeyes" Petten=C3=B2
http://blog.flameeyes.eu/


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkhTktAACgkQe2h1+2mHVWPmjQCgvX/338EwBdUOwB/SgZ4jZGFN
YpIAoOCU9Llh0vqVQFmrouzx0Hl4c1Bx
=+b7Y
-----END PGP SIGNATURE-----
--=-=-=--

--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
