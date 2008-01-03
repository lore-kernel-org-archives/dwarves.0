From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: codiff misses changes if inline -> not inlined?
Date: Thu, 3 Jan 2008 13:10:44 -0200
Message-ID: <20080103151044.GD29523@ghostprotocols.net>
References: <Pine.LNX.4.64.0801031528400.14949@kivilampi-30.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0801031528400.14949-Y/UOj9v5BLQhZigby9b+C6cUovnZ0M2TMR2xtNvyitY@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen-pxSi+dnQzZMxHbG02/KK1g@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

CCing dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org so that people know about this fix.

Em Thu, Jan 03, 2008 at 03:40:16PM +0200, Ilpo J=E4rvinen escreveu:
> Hi,
>=20
> I've had a problem with codiff when playing around with inlines. It s=
eems=20
> to miss completely the resizement of inlined function from zero to=20
> something. Here's one example (relevant patch attached):
>=20
> $ codiff tcp_input.o.old tcp_input.o
> net/ipv4/tcp_input.c:
>   tcp_dsack_extend |  -73
>   tcp_data_queue   |  -17
>  2 functions changed, 90 bytes removed
>=20
> $ pfunct -s tcp_input.o.old | grep "tcp_sack_extend"
> $ pfunct -s tcp_input.o | grep "tcp_sack_extend"
> tcp_sack_extend: 66
>=20
> Isn't that tcp_sack_extend | +66 missing from codiff's output???
>=20
>=20
> There's nothing special in the tcp_sack_extend(), any inline (at leas=
t in=20
> .c files) will do.

=46ixed:

[acme@doppio pahole]$ codiff /tmp/tcp_input.o.before /tmp/tcp_input.o.a=
fter
/home/acme/git/net-2.6.25/net/ipv4/tcp_input.c:
  tcp_dsack_extend |  -29
  tcp_data_queue   |  -49
 2 functions changed, 78 bytes removed

/home/acme/git/net-2.6.25/net/ipv4/tcp_input.c:
  tcp_sack_extend |  +34
 1 function changed, 34 bytes added

/tmp/tcp_input.o.after:
 3 functions changed, 34 bytes added, 78 bytes removed, diff: -44
[acme@doppio pahole]$

And if you use --verbose it'll tell you that in fact it was
"(uninlined)":

[acme@doppio pahole]$ codiff -V /tmp/tcp_input.o.before /tmp/tcp_input.=
o.after
/home/acme/git/net-2.6.25/net/ipv4/tcp_input.c:
  tcp_dsack_extend |  -29 # 55 -> 26, # inlines: 1 -> 0, size inlines: =
34 -> 0
  tcp_data_queue   |  -49 # 2892 -> 2843, size inlines: 1247 -> 1240
 2 functions changed, 78 bytes removed

/home/acme/git/net-2.6.25/net/ipv4/tcp_input.c:
  tcp_sack_extend |  +34 (uninlined)
 1 function changed, 34 bytes added

/tmp/tcp_input.o.after:
 3 functions changed, 34 bytes added, 78 bytes removed, diff: -44
[acme@doppio pahole]$

> From d9cd8eb51562d2d3e36fb61765b24401f97e76be Mon Sep 17 00:00:00 200=
1
> From: =3D?ISO-8859-1?q?Ilpo_J=3DE4rvinen?=3D <ilpo.jarvinen@helsinki.=
fi>
> Date: Sat, 29 Dec 2007 13:51:54 +0200
> Subject: [PATCH] [TCP]: Remove inline from tcp_sack_extend()
> Content-Type: text/plain; charset=3DISO-8859-1
> Content-Transfer-Encoding: 8bit
>=20
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen-pxSi+dnQzZMxHbG02/KK1g@public.gmane.org>
> ---
> net/ipv4/tcp_input.c |    3 +--
> 1 files changed, 1 insertions(+), 2 deletions(-)
>
>diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>index d5b6adf..48f52cb 100644
>--- a/net/ipv4/tcp_input.c
>+++ b/net/ipv4/tcp_input.c
>@@ -3581,8 +3581,7 @@ static void tcp_fin(struct sk_buff *skb, struct =
sock *sk, struct tcphdr *th)
> 	}
> }
>=20
>-static inline int tcp_sack_extend(struct tcp_sack_block *sp, u32 seq,
>-				  u32 end_seq)
>+static int tcp_sack_extend(struct tcp_sack_block *sp, u32 seq, u32 en=
d_seq)
> {
> 	if (!after(seq, sp->end_seq) && !after(sp->start_seq, end_seq)) {
> 		if (before(seq, sp->start_seq))
>--=20

- Arnaldo
-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
