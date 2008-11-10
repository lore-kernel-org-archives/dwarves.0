From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: pfunct crash on libSDL
Date: Mon, 10 Nov 2008 13:08:01 -0200
Message-ID: <20081110150801.GA10009@ghostprotocols.net>
References: <m21vxkk8gm.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m21vxkk8gm.fsf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Diego 'Flameeyes' =?iso-8859-1?Q?Petten=F2?= <flameeyes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Sun, Nov 09, 2008 at 08:25:29PM +0100, Diego 'Flameeyes' Petten=F2 e=
screveu:
>=20
> Hi,
>=20
> at http://www.flameeyes.eu/tmp/dwarves-crash-20081109.tar.bz2 I've
> uploaded a libSDL compiled on my system that crashes pfunct, both wit=
h
> -l and with -f some_function.
>=20
> The funny thing is that gdb is unable to provide me a backtrace ...
>=20
> This is with both an old git copy I had and the latest newest git I c=
an
> fetch today.

Strange:

[acme@doppio pahole]$ cat .git/refs/heads/master=20
bcf1c15d8bc8cfe2ce0977d249d49268dfcebaf1

acme@doppio pahole]$ pfunct -TVilf CheckMounts tmp/usr/lib/debug/usr/li=
b64/libSDL-1.2.so.0.11.2.debug=20
/* <91a61> ./src/cdrom/linux/SDL_syscdrom.c:188 */
void CheckMounts(const char  * mtab);
{ /* low_pc=3D0x49ae0 */
	FILE * mntfp;                                                 //   189
	struct mntent * mntent;                                       //   190
	struct stat stbuf;                                            //   191
	{
		char * tmp;                                           //   195
		char * mnt_type;                                      //   196
		size_t mnt_type_len;                                  //   197
		char * mnt_dev;                                       //   198
		size_t mnt_dev_len;                                   //   199
		{ /* CheckMounts+0xe1 */
			size_t __s1_len;                              //   218
			size_t __s2_len;                              //   218
		} /* lexblock size=3D15 */
		{
			size_t __s1_len;                              //   242
			size_t __s2_len;                              //   242
		} /* lexblock size=3D0 */
	} /* lexblock size=3D0 */
}/* size: 474, variables: 3 */

acme@doppio pahole]$ ldd `which pfunct`
	linux-vdso.so.1 =3D>  (0x00007fff741fe000)
	libdwarves.so.1 =3D> /home/acme/git/pahole/build/libdwarves.so.1 (0x00=
00000000110000)
	libdwarves_emit.so.1 =3D> /home/acme/git/pahole/build/libdwarves_emit.=
so.1 (0x0000000000604000)
	libz.so.1 =3D> /lib64/libz.so.1 (0x000000371d000000)
	libdw.so.1 =3D> /usr/lib64/libdw.so.1 (0x000000371c400000)
	libelf.so.1 =3D> /usr/lib64/libelf.so.1 (0x000000371d800000)
	libc.so.6 =3D> /lib64/libc.so.6 (0x000000371c000000)
	libdl.so.2 =3D> /lib64/libdl.so.2 (0x000000371c800000)
	/lib64/ld-linux-x86-64.so.2 (0x000000371bc00000)
[acme@doppio pahole]$

And I'm using elfutils 0.137 on this machine.

Humm, I see, its the other file in this tarball, the one without
debugging info, that makes the CTF code crash in pfunct, I'll fix that,
but please use the file with .debug suffix for now, its there that the
DWARF info is anyway :-)

Ahm and the backtrace is this:

(gdb) bt
#0  0x000000371c0f33a1 in ?? () from /lib64/libc.so.6
#1  0x000000371c0f38e4 in argp_parse () from /lib64/libc.so.6
#2  0x000000000011d5cf in ctf__load (self=3D0x604010, argp=3D0x603360, =
argc=3D4, argv=3D0x7fffffffe158) at /home/acme/git/pahole/ctf_loader.c:=
797
#3  0x000000000011b5b4 in cus__loadfl (self=3D0x604010, argp=3D0x603360=
, argc=3D4, argv=3D0x7fffffffe158) at /home/acme/git/pahole/dwarves.c:2=
584
#4  0x0000000000402044 in main (argc=3D4, argv=3D0x7fffffffe158) at /ho=
me/acme/git/pahole/pfunct.c:499

It tries to read the DWARF info, there is none, so it tries to find CTF
data, but then hits a bug.

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
