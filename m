From: flameeyes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org (Diego 'Flameeyes' =?utf-8?Q?Petten=C3=B2?=)
Subject: Feature request: codiff only considering file basename
Date: Fri, 24 Oct 2008 15:12:58 +0200
Message-ID: <m27i7yxhk5.fsf@gmail.com>
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


I found myself today in the situation of using codiff on two binaries
built with the same sources, but reorganised around; since I noticed a
non-zero difference on codiff, I would have liked to know where the
difference would be, but since the source files' path has changed,
codiff is showing me too much noise and I can't figure out what changed.

Optionally considering the basename of the source files would be very
nice way to reduce the noise and only show the important data.

Thanks!

P.S.: is a new release to be expected? Or git is going to be the only
way?

=2D-=20
Diego "Flameeyes" Petten=C3=B2
http://blog.flameeyes.eu/


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkkBydoACgkQe2h1+2mHVWO1TQCfUvWgZhRTm/4Xzfl8Ro3mbOAa
uAMAoOe0+YJorQLDpj0ROlohrB+Llo8D
=i6Wy
-----END PGP SIGNATURE-----
--=-=-=--

--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
