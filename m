From: Florin Iucha <florin-zX39fKdjKLBeoWH0uzbU5w@public.gmane.org>
Subject: Re: "File has no CTF section."
Date: Tue, 25 Mar 2008 12:24:14 -0500
Message-ID: <20080325172413.GN3247@iris.iucha.org>
References: <20080325152403.GK3247@iris.iucha.org> <20080325164103.GC22421@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I7X/wJdqR85B5KIV"
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080325164103.GC22421-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org


--I7X/wJdqR85B5KIV
Content-Type: multipart/mixed; boundary="SYQzjNw7/YqOQKSG"
Content-Disposition: inline


--SYQzjNw7/YqOQKSG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Arnaldo,

Thanks for the quick reply!

On Tue, Mar 25, 2008 at 01:41:03PM -0300, Arnaldo Carvalho de Melo wrote:
> > I have three object files: one is 'dwarves.o' from the pahole
> > distribution, compiled with 'gcc -g'.  Another is 'foobar.o' from my
> > own embedded application, compiled with the same compiler, on the same
> > box [1].  The third object file is 'foobar.o' compiled with some
> > version of compiler (Metrowerks?) for the embedded platform that we use.
> >=20
> > If I use 'objdump -W' on all three files, I get heaps of information,
> > including the structure definitions and other stuff.  Good.
>=20
> can you try with:
>=20
> # binutils
> readelf -w i build/pahole
>=20
> # elfutils
> eu-readelf -w i build/pahole

Yup.  I get the same (or very similar) information.

> > The most puzzling thing is that two object files, compiled with the
> > same compiler on the same machine have different enough DWARF data
> > that one works with pahole and one doesn't.
> >=20
> > What can I do to follow through with this?  Contact the elfutils
> > maintainers?
>=20
> Possibly, but can you make these two object files available somewhere?
> I'd like to take a look...

See the attached file.  If you just compile it with 'gcc -g -c hello.c',
pahole works fine on the resulting object file.  If at line 17 you change
'#if 0' to '#if 1', pahole will complain about the lack of CTF (sorry,
I didn't have time to pull your updates).

Cheers,
florin

--=20
Bruce Schneier expects the Spanish Inquisition.
      http://geekz.co.uk/schneierfacts/fact/163

--SYQzjNw7/YqOQKSG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hello.c"

#include <stdio.h>

struct foo
{
   int i;
   char c;
   float f;
};

struct bar
{
   struct foo f;
   char c;
   int i;
};

#if 0
#pragma BSS(".do_not_init")
struct foo f;
#pragma BSS(DEFAULT_SECTION_BSS)
#endif

int main(void)
{
   struct bar b;

   printf("Hello, struct bar(%u)!\n", sizeof(b));

   return 0;
}

--SYQzjNw7/YqOQKSG--

--I7X/wJdqR85B5KIV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFH6TU9ND0rFCN2b1sRAgUGAKCpuFoVAUbgbfTjFrWHYCb7MHTdzQCfe9OZ
aPc6BreF5evNwfOEk8bMZSI=
=uJrG
-----END PGP SIGNATURE-----

--I7X/wJdqR85B5KIV--
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
