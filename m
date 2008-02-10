From: flameeyes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org (Diego 'Flameeyes' =?utf-8?Q?Petten=C3=B2?=)
Subject: libdwarves exports a generic memdup() symbol
Date: Sun, 10 Feb 2008 20:23:34 +0100
Message-ID: <m27ihcfweh.fsf@gmail.com>
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


And for what it's worth, it's not used by the dwarves tools.
It's actually in good company:

Symbol memdup@@ (64-bit UNIX System V ABI AMD x86-64 architecture) present =
7 times
  /usr/lib64/libnetsnmp.so.15.1.0
  /lib64/security/pam_smbpass.so
  /usr/lib64/samba/libmsrpc.so
  /usr/lib64/libsnmp.so.15.1.0
  /usr/lib64/libdwarves.so.1.0.0
  /usr/lib64/samba/security/pam_smbpass.so
  /usr/lib64/samba/libsmbclient.so

It should probably be hidden anyway.

=2D-=20
Diego "Flameeyes" Petten=C3=B2
http://farragut.flameeyes.is-a-geek.org/

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQFHr083e2h1+2mHVWMRAsQTAKDzKvfoVD/2RHZd3bYuHnC+Edq/VQCeJXcV
L2onTi+2tGuZFh1z7T0qndU=
=7NHY
-----END PGP SIGNATURE-----
--=-=-=--
