From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: codiff misses changes if inline -> not inlined?
Date: Thu, 3 Jan 2008 14:56:05 -0200
Message-ID: <20080103165605.GF29523@ghostprotocols.net>
References: <Pine.LNX.4.64.0801031528400.14949@kivilampi-30.cs.helsinki.fi> <20080103151044.GD29523@ghostprotocols.net> <Pine.LNX.4.64.0801031728330.14949@kivilampi-30.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0801031728330.14949-Y/UOj9v5BLQhZigby9b+C6cUovnZ0M2TMR2xtNvyitY@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen-pxSi+dnQzZMxHbG02/KK1g@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Thu, Jan 03, 2008 at 06:45:32PM +0200, Ilpo J=E4rvinen escreveu:
> On Thu, 3 Jan 2008, Arnaldo Carvalho de Melo wrote:
>=20
> Now that I automated it for inlines per file, one thing that annoys m=
e a=20
> bit is that it does not keep identical formatting on the last line (i=
t's=20
> fixable of course by some simple sed trickery):
>=20
> static inline int tcp_may_raise_cwnd(const struct sock *sk, const int=
=20
> flag)
> net/ipv4/tcp_input.c:
>   tcp_prune_queue |  -16
>  1 function changed, 16 bytes removed
>=20
> ...versus...
>=20
> static inline int tcp_may_update_window(const struct tcp_sock *tp,
> net/ipv4/tcp_input.c:
>   tcp_disordered_ack |  -18
>   tcp_ack            |  -76
>  2 functions changed, 94 bytes removed
>=20
> net/ipv4/tcp_input.c:
>   tcp_may_update_window |  +56
>  1 function changed, 56 bytes added
>=20
> net/ipv4/tcp_input.o:
>  3 functions changed, 56 bytes added, 94 bytes removed, diff: -38
>=20
>=20
> diff: xx is not always present.

=46ixed, please do a git-pull.

- Arnaldo
-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
