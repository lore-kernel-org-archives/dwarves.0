From: flameeyes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org (Diego 'Flameeyes' =?utf-8?Q?Petten=C3=B2?=)
Subject: Re: pfunct crash on libSDL
Date: Mon, 10 Nov 2008 16:57:51 +0100
Message-ID: <m2wsfbineo.fsf@gmail.com>
References: <m21vxkk8gm.fsf@gmail.com>
	<20081110150801.GA10009@ghostprotocols.net>
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

> Humm, I see, its the other file in this tarball, the one without
> debugging info, that makes the CTF code crash in pfunct, I'll fix that,
> but please use the file with .debug suffix for now, its there that the
> DWARF info is anyway :-)

Ah okay :) I'm used to just run on the main binary, hoping that the
debug link is followed, I guess I'll have to change my process, but then
I'll be feature-requesting for the debuglink to be followed :P

=2D-=20
Diego "Flameeyes" Petten=C3=B2
http://blog.flameeyes.eu/

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkkYWf8ACgkQe2h1+2mHVWMZUACeNluldcJbMMGcLxrrhI+7GuhO
mFgAoMvuE4W73YtEG32kkGzVR91xYG2h
=rBMj
-----END PGP SIGNATURE-----
--=-=-=--

--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
