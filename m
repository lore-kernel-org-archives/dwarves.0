From: Florin Iucha <florin-zX39fKdjKLBeoWH0uzbU5w@public.gmane.org>
Subject: Re: "File has no CTF section."
Date: Thu, 24 Apr 2008 10:25:11 -0500
Message-ID: <20080424152511.GB19740@iris.iucha.org>
References: <20080325152403.GK3247@iris.iucha.org> <20080325164103.GC22421@ghostprotocols.net> <20080325172413.GN3247@iris.iucha.org> <20080325175749.GE22421@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080325175749.GE22421-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2008 at 02:57:49PM -0300, Arnaldo Carvalho de Melo wrote:
> > See the attached file.  If you just compile it with 'gcc -g -c hello.c',
> > pahole works fine on the resulting object file.  If at line 17 you chan=
ge
> > '#if 0' to '#if 1', pahole will complain about the lack of CTF (sorry,
> > I didn't have time to pull your updates).
>=20
> ACK, reproduced here, will investigate, strange indeed.

Pinnnggg!

florin

--=20
Bruce Schneier expects the Spanish Inquisition.
      http://geekz.co.uk/schneierfacts/fact/163

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFIEKZXND0rFCN2b1sRAsiCAKCGPeQskkNiXCaHk7QgHIW7xeVtCwCeKkpP
F3UCdrrJqhpD7QlZnmLkbYw=
=iCBN
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
