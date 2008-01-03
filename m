From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: codiff misses changes if inline -> not inlined?
Date: Thu, 3 Jan 2008 21:35:33 -0200
Message-ID: <20080103233533.GQ29523@ghostprotocols.net>
References: <Pine.LNX.4.64.0801031528400.14949@kivilampi-30.cs.helsinki.fi> <20080103143139.GC29523@ghostprotocols.net> <Pine.LNX.4.64.0801040111530.16761@kivilampi-30.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0801040111530.16761-Y/UOj9v5BLQhZigby9b+C6cUovnZ0M2TMR2xtNvyitY@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen-pxSi+dnQzZMxHbG02/KK1g@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Fri, Jan 04, 2008 at 01:24:02AM +0200, Ilpo J=E4rvinen escreveu:
> On Thu, 3 Jan 2008, Arnaldo Carvalho de Melo wrote:
>=20
> > Em Thu, Jan 03, 2008 at 03:40:16PM +0200, Ilpo J=E4rvinen escreveu:
> > > Hi,
> > >=20
> > > I've had a problem with codiff when playing around with inlines. =
It seems=20
> > > to miss completely the resizement of inlined function from zero t=
o=20
> > > something. Here's one example (relevant patch attached):
> > >=20
> > > $ codiff tcp_input.o.old tcp_input.o
> > > net/ipv4/tcp_input.c:
> > >   tcp_dsack_extend |  -73
> > >   tcp_data_queue   |  -17
> > >  2 functions changed, 90 bytes removed
> > >=20
> > > $ pfunct -s tcp_input.o.old | grep "tcp_sack_extend"
> > > $ pfunct -s tcp_input.o | grep "tcp_sack_extend"
> > > tcp_sack_extend: 66
> > >=20
> > > Isn't that tcp_sack_extend | +66 missing from codiff's output???
> > >=20
> > >=20
> > > There's nothing special in the tcp_sack_extend(), any inline (at =
least in=20
> > > .c files) will do.
> >=20
> > From codiff's point of view its a "new" function... I'm checking th=
is right now, just a sec :)
>=20
> More very interesting cases found... :-/ The tool removed inline from=
=20
> ip_ufo_append_data and got this result:
>=20
> $ codiff -V net/ipv4/ip_output.o.old net/ipv4/ip_output.o
> net/ipv4/ip_output.c:
>   dst_output        |  +11 (uninlined)
>   ip_send_check     |  +69 (uninlined)
>   ip_finish_output2 | +594 (uninlined)
>  3 functions changed, 674 bytes added, diff: +674
>=20
> ...It may well be right due to some strange inlining heurestics=20
> interaction but I'm a bit suspicious because of the large numbers and=
=20
> pfunct -i tells a different story for at least ip_finish_output2 and=20
> ip_send_check (in both cases the sizes are constant 0 in -i output!?!=
).

I'll check that, perhaps the compiler decided to uninline the functions
because they were too big?

- Arnaldo
-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
