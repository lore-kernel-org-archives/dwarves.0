From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: codiff misses changes if inline -> not inlined?
Date: Thu, 3 Jan 2008 23:39:36 -0200
Message-ID: <20080104013936.GS29523@ghostprotocols.net>
References: <Pine.LNX.4.64.0801031528400.14949@kivilampi-30.cs.helsinki.fi> <20080103143139.GC29523@ghostprotocols.net> <Pine.LNX.4.64.0801040111530.16761@kivilampi-30.cs.helsinki.fi> <20080104002746.GR29523@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080104002746.GR29523-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen-pxSi+dnQzZMxHbG02/KK1g@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Thu, Jan 03, 2008 at 10:27:46PM -0200, Arnaldo Carvalho de Melo escr=
eveu:
> Em Fri, Jan 04, 2008 at 01:24:02AM +0200, Ilpo J=E4rvinen escreveu:
> > On Thu, 3 Jan 2008, Arnaldo Carvalho de Melo wrote:
> >=20
> > > Em Thu, Jan 03, 2008 at 03:40:16PM +0200, Ilpo J=E4rvinen escreve=
u:
> > > > Hi,
> > > >=20
> > > > I've had a problem with codiff when playing around with inlines=
=2E It seems=20
> > > > to miss completely the resizement of inlined function from zero=
 to=20
> > > > something. Here's one example (relevant patch attached):
> > > >=20
> > > > $ codiff tcp_input.o.old tcp_input.o
> > > > net/ipv4/tcp_input.c:
> > > >   tcp_dsack_extend |  -73
> > > >   tcp_data_queue   |  -17
> > > >  2 functions changed, 90 bytes removed
> > > >=20
> > > > $ pfunct -s tcp_input.o.old | grep "tcp_sack_extend"
> > > > $ pfunct -s tcp_input.o | grep "tcp_sack_extend"
> > > > tcp_sack_extend: 66
> > > >=20
> > > > Isn't that tcp_sack_extend | +66 missing from codiff's output??=
?
> > > >=20
> > > >=20
> > > > There's nothing special in the tcp_sack_extend(), any inline (a=
t least in=20
> > > > .c files) will do.
> > >=20
> > > From codiff's point of view its a "new" function... I'm checking =
this right now, just a sec :)
> >=20
> > More very interesting cases found... :-/ The tool removed inline fr=
om=20
> > ip_ufo_append_data and got this result:
> >=20
> > $ codiff -V net/ipv4/ip_output.o.old net/ipv4/ip_output.o
> > net/ipv4/ip_output.c:
> >   dst_output        |  +11 (uninlined)
> >   ip_send_check     |  +69 (uninlined)
> >   ip_finish_output2 | +594 (uninlined)
> >  3 functions changed, 674 bytes added, diff: +674
> >=20
> > ...It may well be right due to some strange inlining heurestics=20
> > interaction but I'm a bit suspicious because of the large numbers a=
nd=20
> > pfunct -i tells a different story for at least ip_finish_output2 an=
d=20
> > ip_send_check (in both cases the sizes are constant 0 in -i output!=
?!).
>=20
> Before manually removing inline from the function:
>=20
> [acme@doppio net-2.6.25]$ pfunct -f ip_ufo_append_data /tmp/ip_output=
=2Eo.old
> inline int ip_ufo_append_data(struct sock * sk, int (*getfrag)(void *=
, char *, int, int, int, struct sk_buff *), void * from, int length, in=
t hh_len, int fragheaderlen, int transhdrlen, int mtu, unsigned int fla=
gs);
> [acme@doppio net-2.6.25]$
>=20
> And the compiler is not, at least in my kernel configuration, trying =
to
> do (un)inlining differently from what is in the source code:
>=20
> [acme@doppio net-2.6.25]$ pfunct --cc_uninlined /tmp/ip_output.o.old
> [acme@doppio net-2.6.25]$ pfunct --cc_inlined /tmp/ip_output.o.old
> [acme@doppio net-2.6.25]$
>=20
> [acme@doppio net-2.6.25]$ grep INLIN ../build/net-2.6.25/doppio/.conf=
ig
> # CONFIG_FORCED_INLINING is not set
>=20
> [acme@doppio net-2.6.25]$ pfunct -T -f ip_append_data /tmp/ip_output.=
o.old
>=20
> Shows that ip_ufo_append_data is being inlined in ip_append_data, tak=
ing
> 336 bytes in my config (x86_64).
>=20
> Then I remove the inline and...
>=20
> [acme@doppio net-2.6.25]$ codiff /tmp/ip_output.o.old
> /tmp/ip_output.o.new
> /home/acme/git/net-2.6.25/net/ipv4/ip_output.c:
>   dst_output        |  +14
>   ip_send_check     |  +65
>   ip_finish_output2 | +499
>  3 functions changed, 578 bytes added, diff: +578
> [acme@doppio net-2.6.25]$
>=20
> Which should have shown ip_ufo_append_data as being uninlined... ah!
>=20
> [acme@doppio pahole]$ pfunct --cc_inlined /tmp/ip_output.o.new
> ip_ufo_append_data
>=20
> The compiler decided that even if we remove the 'inline' keyword the
> function is only called from ip_append_data, so it inlines it anyway.
>=20
> But why we end up using 578 bytes more? Lemme see...
>=20
> It is a bug:
>=20
> [acme@doppio pahole]$ size /tmp/ip_output.o.old /tmp/ip_output.o.new
>    text    data     bss     dec     hex filename
>   12262       4       0   12266    2fea /tmp/ip_output.o.old
>   12262       4       0   12266    2fea /tmp/ip_output.o.new
> [acme@doppio pahole]$
>=20
> Investigating...

=46ixed, it is yet another DWARF detail: DW_TAG_subprogram entries with
DW_AT_abstract_origin, that point to another DW_TAG_subprogram where we
have the DW_AT_inline attribute, we're interested in codiff just in the
DW_TAG_subprogram entries that have a DW_AT_name, and those are the one=
s
without DW_TAG_abstract_origin.

Now the output is:

[acme@doppio pahole]$ codiff /tmp/ip_output.o.old /tmp/ip_output.o.new
[acme@doppio pahole]$

That matches 'size', i.e. no changes, in the resulting binary, with the
only difference being in the DWARF info, the first has
DW_AT_declared_inlined (declared inline, inlined), and the second has
DW_AT_inlined (NOT declared inline, _inlined_ by the compiler).

Probably its a good idea to show this in the codiff output, as it is
confusing, will do that tomorrow.

- Arnaldo
-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
