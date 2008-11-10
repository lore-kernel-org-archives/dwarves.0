From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: pfunct crash on libSDL
Date: Mon, 10 Nov 2008 14:12:15 -0200
Message-ID: <20081110161215.GC10009@ghostprotocols.net>
References: <m21vxkk8gm.fsf@gmail.com> <20081110150801.GA10009@ghostprotocols.net> <m2wsfbineo.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m2wsfbineo.fsf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Diego 'Flameeyes' =?iso-8859-1?Q?Petten=F2?= <flameeyes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Mon, Nov 10, 2008 at 04:57:51PM +0100, Diego 'Flameeyes' Petten=F2 e=
screveu:
> Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> writes:
>=20
> > Humm, I see, its the other file in this tarball, the one without
> > debugging info, that makes the CTF code crash in pfunct, I'll fix t=
hat,
> > but please use the file with .debug suffix for now, its there that =
the
> > DWARF info is anyway :-)
>=20
> Ah okay :) I'm used to just run on the main binary, hoping that the
> debug link is followed, I guess I'll have to change my process, but t=
hen
> I'll be feature-requesting for the debuglink to be followed :P

I thought that libdwfl would do that, lemme check... Yeah:

open("tmp/usr/lib64/libSDL-1.2.so.0.11.2", O_RDONLY) =3D 3
open("tmp/usr/lib64/libSDL-1.2.so.0.11.2.debug", O_RDONLY) =3D -1 ENOEN=
T (No such file or directory)
open("tmp/usr/lib64/.debug/libSDL-1.2.so.0.11.2.debug", O_RDONLY) =3D -=
1 ENOENT (No such file or directory)
open("/home/acme/git/pahole/tmp/usr/lib64/libSDL-1.2.so.0.11.2.debug", =
O_RDONLY) =3D -1 ENOENT (No such file or directory)
open("/home/acme/git/pahole/tmp/usr/lib64/.debug/libSDL-1.2.so.0.11.2.d=
ebug", O_RDONLY) =3D -1 ENOENT (No such file or directory)
open("/usr/lib/debug/home/acme/git/pahole/tmp/usr/lib64/libSDL-1.2.so.0=
=2E11.2.debug", O_RDONLY) =3D -1 ENOENT (No such file or directory)

So its just a matter of using one of the searched places :-)

To try this I just did a 'yum install SDL-debuginfo' and:

acme@doppio pahole]$ pfunct -TVIlf SDL_PauseAudio
/usr/lib64/libSDL-1.2.so.0
/* <1b92> src/audio/SDL_audio.c:589 */
void SDL_PauseAudio(int pause_on);
{ /* low_pc=3D0x88b0 */
	SDL_AudioDevice * audio;                                // 590
}/* size: 20, variables: 1 */
[acme@doppio pahole]$

So it works, but this time by using build id :-)

[acme@doppio pahole]$ strace -e trace=3Dopen pfunct -TVIlf SDL_PauseAud=
io /usr/lib64/libSDL-1.2.so.0 2>&1 | grep debug
open("/usr/lib/debug/.build-id/06/5ae7d6742b683430474e3415ae5081be5586a=
7.debug", O_RDONLY) =3D 3
[acme@doppio pahole]$

But...

[acme@doppio pahole]$ l
/usr/lib/debug/.build-id/06/5ae7d6742b683430474e3415ae5081be5586a7.debu=
g lrwxrwxrwx 1 root root 42 2008-11-10 14:08
/usr/lib/debug/.build-id/06/5ae7d6742b683430474e3415ae5081be5586a7.debu=
g -> ../../usr/lib64/libSDL-1.2.so.0.11.2.debug*
[acme@doppio pahole]$

Let us try removing this symlink... It still works, but this time:

[acme@doppio pahole]$ strace -e trace=3Dopen pfunct -TVIlf SDL_PauseAud=
io /usr/lib64/libSDL-1.2.so.0 2>&1 | grep debug
open("/usr/lib/debug/.build-id/06/5ae7d6742b683430474e3415ae5081be5586a=
7.debug", O_RDONLY) =3D -1 ENOENT (No such file or directory)
open("/usr/lib64/libSDL-1.2.so.0.11.2.debug", O_RDONLY) =3D -1 ENOENT (=
No such file or directory)
open("/usr/lib64/.debug/libSDL-1.2.so.0.11.2.debug", O_RDONLY) =3D -1 E=
NOENT (No such file or directory)
open("/usr/lib/debug/usr/lib64/libSDL-1.2.so.0.11.2.debug", O_RDONLY) =3D=
 3
[acme@doppio pahole]$

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
