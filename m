From: Florin Iucha <florin-zX39fKdjKLBeoWH0uzbU5w@public.gmane.org>
Subject: "File has no CTF section."
Date: Tue, 25 Mar 2008 10:24:03 -0500
Message-ID: <20080325152403.GK3247@iris.iucha.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YwIO0NqOPhSlhPyD"
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org


--YwIO0NqOPhSlhPyD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have manually built the pahole&co on Ubuntu 8.04 beta, and I'm
trying to use it on a few source files that I have, and I keep getting
the "File has no CTF section." error message.

I have three object files: one is 'dwarves.o' from the pahole
distribution, compiled with 'gcc -g'.  Another is 'foobar.o' from my
own embedded application, compiled with the same compiler, on the same
box [1].  The third object file is 'foobar.o' compiled with some
version of compiler (Metrowerks?) for the embedded platform that we use.

If I use 'objdump -W' on all three files, I get heaps of information,
including the structure definitions and other stuff.  Good.

If I use 'pahole' on all three files, I get the structure information
for the first one, but 'File has no CTF section.' for the other two,
even though the first and second object files are built with the same
compiler!  And even though both 'foobar.o' file contain heaps of
debugging information (objdump -W yields 14K lines for the gcc-4.2
build and 43K lines for the native embedded build).

I grepped for 'File has no CTF section.' in the dwarves sources and it
only occurs in the 'ctf_loader.c' file - it seems that the code is
looking for a section named ".SUNW_ctf" (in function parse_elf which
is only called from ctf__load which is only called from cus__loadfl,
if the dwarf__load returns some empty list)

It seems that either 'dwfl_getdwarf/dwarf_nextcu' fails to find the
data.  At any rate, the error message (about the missing CTF section)
is quite misleading.  I'm not sure where the bug is (although my
limited exploring seems to point to the 'elfutils' package.  Ubuntu
distributes version 0.131, which seems to be the latest published version.

The most puzzling thing is that two object files, compiled with the
same compiler on the same machine have different enough DWARF data
that one works with pahole and one doesn't.

What can I do to follow through with this?  Contact the elfutils
maintainers?

Thanks,
florin

1: The compiler version is 'gcc version 4.2.3 (Ubuntu 4.2.3-2ubuntu6)'

--=20
Bruce Schneier expects the Spanish Inquisition.
      http://geekz.co.uk/schneierfacts/fact/163

--YwIO0NqOPhSlhPyD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFH6RkSND0rFCN2b1sRAl0RAJ9ZPC32K2wCWMHDepPIbSHDSj+pEQCdE52j
PRQCUN/c50xl4dmBhAMKIII=
=K9jT
-----END PGP SIGNATURE-----

--YwIO0NqOPhSlhPyD--
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
