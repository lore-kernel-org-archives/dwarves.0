From: flameeyes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org (Diego 'Flameeyes' =?utf-8?Q?Petten=C3=B2?=)
Subject: Another strange codiff output
Date: Wed, 21 May 2008 14:04:26 +0200
Message-ID: <m2k5hnkgmt.fsf@gmail.com>
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


While cleaning up xine-lib's code I found another interesting thing:

send_ogg_buf         |  +24 # 3671 -> 3695, # inlines: 0 -> 1, size inlines=
: 0 -> 859
send_header          | -116 # 7812 -> 7696, # inlines: 13 -> 1, size inline=
s: 6765 -> 418

I'm not sure if this is correct, but if the size of inlines increases so
much and decreases so much, I'd expect the size of the function to
follow suit..

The ELF files causing this are at
http://www.flameeyes.eu/tmp/dwarves-notsure.tbz2 .

HTH,
=2D-=20
Diego "Flameeyes" Petten=C3=B2
http://blog.flameeyes.eu/


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkg0D8oACgkQe2h1+2mHVWNXegCeOXVfXOAp6OPKHKFfJl/dNG0Y
2w4Ani5Ls43b3xRaMzm/xeUUTp0KcUaB
=bf5p
-----END PGP SIGNATURE-----
--=-=-=--

--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
