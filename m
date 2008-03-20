From: Thomas Girard <thomas.g.girard-GANU6spQydw@public.gmane.org>
Subject: Re: building pahole on Ubuntu 8.04 AMD64
Date: Thu, 20 Mar 2008 22:03:48 +0100
Message-ID: <1206047028.4064.7.camel@micmac>
References: <20080320200244.GS3247@iris.iucha.org>
	 <20080320205109.GE4034@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080320205109.GE4034-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florin Iucha <florin-zX39fKdjKLBeoWH0uzbU5w@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Hello,

Le jeudi 20 mars 2008 =C3=A0 17:51 -0300, Arnaldo Carvalho de Melo a =C3=
=A9crit :
> Em Thu, Mar 20, 2008 at 03:02:44PM -0500, Florin Iucha escreveu:
> > Hi Arnaldo,
> >=20
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
> > /usr/lib/gcc/x86_64-linux-gnu/4.2.3/../../../../lib64/libdw.a(dwarf=
_begin.o):
> > relocation R_X86_64_32 against `a local symbol' can not be used whe=
n
> > making a shared object; recompile with -fPIC
> > /usr/lib/gcc/x86_64-linux-gnu/4.2.3/../../../../lib64/libdw.a: coul=
d
> > not read symbols: Bad value
> > collect2: ld returned 1 exit status
> > make[2]: *** [libdwarves.so.1.0.0] Error 1
> > make[1]: *** [CMakeFiles/dwarves.dir/all] Error 2
> > make: *** [all] Error 2
> >=20
> > I grepped for -fPIC and it seems to be passed on the command line f=
or
> > many of the sources.  I'm using libdw-dev version 0.131-3 and binut=
ils
> > 2.18.1~cvs20080103-0uubuntu1 as packaged by Ubuntu.
>=20
> Strange, looks like you have libdw-dev 32bits installed? can you chec=
k
> that? I.e. that cmake is not mixing somehow libraries?
>=20
> Also I'm adding dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org to the CC list, you don't hav=
e to
> subscribe, but it would be a good idea, there are more people there t=
hat
> I know have built this code on ubuntu/debian and that could be of mor=
e
> help than me, that use debian rarely :-\=20

elfutils in Debian does not provide libdw as a shared library, only as =
a
static one.

I'm on my way to update dwarves in Debian from 1.3 to 1.6. It would
probably be easier to ask for an Ubuntu merge after that.

Regards,

Thomas


--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
