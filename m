From: flameeyes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org (Diego 'Flameeyes' =?utf-8?Q?Petten=C3=B2?=)
Subject: pfunct crash on libSDL
Date: Sun, 09 Nov 2008 20:25:29 +0100
Message-ID: <m21vxkk8gm.fsf@gmail.com>
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


Hi,

at http://www.flameeyes.eu/tmp/dwarves-crash-20081109.tar.bz2 I've
uploaded a libSDL compiled on my system that crashes pfunct, both with
=2Dl and with -f some_function.

The funny thing is that gdb is unable to provide me a backtrace ...

This is with both an old git copy I had and the latest newest git I can
fetch today.

=2D-=20
Diego "Flameeyes" Petten=C3=B2
http://blog.flameeyes.eu/


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkkXOSkACgkQe2h1+2mHVWPx+ACg3/RPBhKrs0JDriUhJ7qxFDbU
l3sAniwxA47D4mcAWVDuDLtouFiv3bam
=EFcR
-----END PGP SIGNATURE-----
--=-=-=--

--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
