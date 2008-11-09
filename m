From: flameeyes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org (Diego 'Flameeyes' =?utf-8?Q?Petten=C3=B2?=)
Subject: Re: Feature request: codiff only considering file basename
Date: Sun, 09 Nov 2008 20:17:05 +0100
Message-ID: <m263mwk8um.fsf@gmail.com>
References: <m27i7yxhk5.fsf@gmail.com>
	<20081024131925.GC15444@ghostprotocols.net>
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

Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
writes:

> Can you show an excerpt of the output you would like to see changed?

Sorry for the delay, very long days lately :(

flame@yamato mytmpfs % echo "int foo() { return 1; }" > foo.c
flame@yamato mytmpfs % gcc -ggdb -c foo.c=20
flame@yamato mytmpfs % gcc -ggdb -c ./foo.c -o foo2.o
flame@yamato mytmpfs % codiff foo.o foo2.o
foo.c:
  foo |  -11
 1 function changed, 11 bytes removed, diff: -11

./foo.c:
  foo |  +11
 1 function changed, 11 bytes added, diff: +11

foo2.o:
 2 functions changed, 11 bytes added, 11 bytes removed, diff: +0

This is what I mean as a problem, as a solution I'd check for just the
basename (so that foo.c and ./foo.c become the same file) or, much more
complicated but would really be nice, I'd check if all the symbols gone
From=20one file appeared on another, so that the output would then become:

flame@yamato mytmpfs % codiff foo.o foo2.o
 File renamed: was foo.c is ./foo.c

But that's going to be hard :P

=2D-=20
Diego "Flameeyes" Petten=C3=B2
http://blog.flameeyes.eu/

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkkXNzUACgkQe2h1+2mHVWMobQCgoIjzYfh8eaLbPp7QO1zAF2/W
iasAoNHDUM/jMIS//ZP+d6uj3R7CknRK
=+ubl
-----END PGP SIGNATURE-----
--=-=-=--

--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
