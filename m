From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: diff vs codiff against empty
Date: Thu, 31 Jan 2008 10:08:01 -0200
Message-ID: <20080131120801.GI1819@ghostprotocols.net>
References: <Pine.LNX.4.64.0801302133380.5832@kivilampi-30.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0801302133380.5832-Y/UOj9v5BLQhZigby9b+C6cUovnZ0M2TMR2xtNvyitY@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen-pxSi+dnQzZMxHbG02/KK1g@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Wed, Jan 30, 2008 at 09:42:18PM +0200, Ilpo J=E4rvinen escreveu:
> Hi,
>=20
> Not a bad problem but makes some tricks I do harder than they would n=
eed=20
> to be:
>=20
> ijjarvin@kivilampi-30:~/work/src/submit$ diff /dev/null lib/jhash.o
> Binary files /dev/null and lib/jhash.o differ
> ijjarvin@kivilampi-30:~/work/src/submit$ codiff /dev/null lib/jhash.o
> codiff: /dev/null: not a valid ELF file

[acme@doppio examples]$ codiff /dev/null hello
hello.c:
  main |  +47
 1 function changed, 47 bytes added, diff: +47
[acme@doppio examples]$ codiff hello /dev/null
hello.c:
  main |  -47
 1 function changed, 47 bytes removed, diff: -47
[acme@doppio examples]$
=20
> I.e., I created new file jhash and just want to diff it against empty=
=2E I=20
> also tried codiff against echo "" | gcc -g -c -o lib/jhash.o.base -x =
c -=20
> but that wasn't any better. I can fix that with sed trick by using pf=
unct=20
> -s for it first though.
>=20
> Btw, codiffs help/usage printout is incorrect or uses unusual notatio=
n, it=20
> uses [] brackets around old_file and new_file even though they are no=
t=20
> optional arguments.

=46ixed in all the dwarves, thanks.

- Arnaldo
