From: Florin Iucha <florin-zX39fKdjKLBeoWH0uzbU5w@public.gmane.org>
Subject: Re: building pahole on Ubuntu 8.04 AMD64
Date: Thu, 20 Mar 2008 16:48:29 -0500
Message-ID: <20080320214829.GV3247@iris.iucha.org>
References: <20080320200244.GS3247@iris.iucha.org> <20080320205109.GE4034@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HzF7SkdB/P3PbQgK"
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080320205109.GE4034-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org


--HzF7SkdB/P3PbQgK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2008 at 05:51:09PM -0300, Arnaldo Carvalho de Melo wrote:
> > I'm trying to build the pahole tools on Ubuntu 8.04 AMD64 and I'm
> > getting a build error:
> >=20
> > $ make
> > [  5%] Building C object CMakeFiles/dwarves.dir/dwarves.o
> > [ 11%] Building C object CMakeFiles/dwarves.dir/ctf_loader.o
> > [ 17%] Building C object CMakeFiles/dwarves.dir/libctf.o
> > [ 23%] Building C object CMakeFiles/dwarves.dir/dwarf_loader.o
> > Linking C shared library libdwarves.so
> > /usr/bin/ld:
> > /usr/lib/gcc/x86_64-linux-gnu/4.2.3/../../../../lib64/libdw.a(dwarf_beg=
in.o):
> > relocation R_X86_64_32 against `a local symbol' can not be used when
> > making a shared object; recompile with -fPIC
> > /usr/lib/gcc/x86_64-linux-gnu/4.2.3/../../../../lib64/libdw.a: could
> > not read symbols: Bad value
> > collect2: ld returned 1 exit status
> > make[2]: *** [libdwarves.so.1.0.0] Error 1
> > make[1]: *** [CMakeFiles/dwarves.dir/all] Error 2
> > make: *** [all] Error 2
> >=20
> > I grepped for -fPIC and it seems to be passed on the command line for
> > many of the sources.  I'm using libdw-dev version 0.131-3 and binutils
> > 2.18.1~cvs20080103-0uubuntu1 as packaged by Ubuntu.
>=20
> Strange, looks like you have libdw-dev 32bits installed? can you check
> that? I.e. that cmake is not mixing somehow libraries?
>=20
> Also I'm adding dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org to the CC list, you don't have to
> subscribe, but it would be a good idea, there are more people there that
> I know have built this code on ubuntu/debian and that could be of more
> help than me, that use debian rarely :-\

$ ar x /usr/lib/libdw.a
$ ls | head -10
$ file dwarf_addrdie.o
dwarf_addrdie.o: ELF 64-bit LSB relocatable, x86-64, version 1 (SYSV), not =
stripped

As I said in the other e-mail (private to Arnaldo), I could build
pahole & friends by compiling the individual files, then feeding them
together with the static libraries to the linker.  So that would indicate
the libraries and toolchain are fine, but maybe they don't provide all
the things that the build system expects.

Cheers,
florin

--=20
Bruce Schneier expects the Spanish Inquisition.
      http://geekz.co.uk/schneierfacts/fact/163

--HzF7SkdB/P3PbQgK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFH4tutND0rFCN2b1sRAqC1AJ4sv9zSDL+N1ZQlTPbbxnKI6cG4IwCdHzxN
TeneMm1h22KHTRlKCkKAe9I=
=8XlP
-----END PGP SIGNATURE-----

--HzF7SkdB/P3PbQgK--
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
