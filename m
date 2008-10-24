From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Feature request: codiff only considering file basename
Date: Fri, 24 Oct 2008 11:19:25 -0200
Message-ID: <20081024131925.GC15444@ghostprotocols.net>
References: <m27i7yxhk5.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m27i7yxhk5.fsf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Diego 'Flameeyes' =?iso-8859-1?Q?Petten=F2?= <flameeyes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Fri, Oct 24, 2008 at 03:12:58PM +0200, Diego 'Flameeyes' Petten=F2 e=
screveu:
>=20
> I found myself today in the situation of using codiff on two binaries
> built with the same sources, but reorganised around; since I noticed =
a
> non-zero difference on codiff, I would have liked to know where the
> difference would be, but since the source files' path has changed,
> codiff is showing me too much noise and I can't figure out what chang=
ed.
>=20
> Optionally considering the basename of the source files would be very
> nice way to reduce the noise and only show the important data.

Can you show an excerpt of the output you would like to see changed?
=20
> Thanks!
>=20
> P.S.: is a new release to be expected? Or git is going to be the only
> way?

I was expecting to make a release with the CTF encoder, but will try an=
d
get one out RSN with what is in git.

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
