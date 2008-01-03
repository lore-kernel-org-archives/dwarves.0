From: "=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen-pxSi+dnQzZMxHbG02/KK1g@public.gmane.org>
Subject: Re: codiff misses changes if inline -> not inlined?
Date: Thu, 3 Jan 2008 18:45:32 +0200 (EET)
Message-ID: <Pine.LNX.4.64.0801031728330.14949@kivilampi-30.cs.helsinki.fi>
References: <Pine.LNX.4.64.0801031528400.14949@kivilampi-30.cs.helsinki.fi>
 <20080103151044.GD29523@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; boundary="-696243703-150640081-1199376902=:14949"
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080103151044.GD29523-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Content-ID: <Pine.LNX.4.64.0801031815410.14949-Y/UOj9v5BLQhZigby9b+C6cUovnZ0M2TMR2xtNvyitY@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---696243703-150640081-1199376902=:14949
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0801031815411.14949-Y/UOj9v5BLQhZigby9b+C6cUovnZ0M2TMR2xtNvyitY@public.gmane.org>

On Thu, 3 Jan 2008, Arnaldo Carvalho de Melo wrote:

> CCing dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org so that people know about this fix.
> 
> Em Thu, Jan 03, 2008 at 03:40:16PM +0200, Ilpo Järvinen escreveu:
> > Hi,
> > 
> > I've had a problem with codiff when playing around with inlines. It seems 
> > to miss completely the resizement of inlined function from zero to 
> > something. Here's one example (relevant patch attached):
> > 
> > $ codiff tcp_input.o.old tcp_input.o
> > net/ipv4/tcp_input.c:
> >   tcp_dsack_extend |  -73
> >   tcp_data_queue   |  -17
> >  2 functions changed, 90 bytes removed
> > 
> > $ pfunct -s tcp_input.o.old | grep "tcp_sack_extend"
> > $ pfunct -s tcp_input.o | grep "tcp_sack_extend"
> > tcp_sack_extend: 66
> > 
> > Isn't that tcp_sack_extend | +66 missing from codiff's output???
> > 
> > 
> > There's nothing special in the tcp_sack_extend(), any inline (at least in 
> > .c files) will do.
> 
> Fixed:
> 
> [acme@doppio pahole]$ codiff /tmp/tcp_input.o.before /tmp/tcp_input.o.after
> /home/acme/git/net-2.6.25/net/ipv4/tcp_input.c:
>   tcp_dsack_extend |  -29
>   tcp_data_queue   |  -49
>  2 functions changed, 78 bytes removed
> 
> /home/acme/git/net-2.6.25/net/ipv4/tcp_input.c:
>   tcp_sack_extend |  +34
>  1 function changed, 34 bytes added
> 
> /tmp/tcp_input.o.after:
>  3 functions changed, 34 bytes added, 78 bytes removed, diff: -44
> [acme@doppio pahole]$
> 
> And if you use --verbose it'll tell you that in fact it was
> "(uninlined)":
> 
> [acme@doppio pahole]$ codiff -V /tmp/tcp_input.o.before /tmp/tcp_input.o.after
> /home/acme/git/net-2.6.25/net/ipv4/tcp_input.c:
>   tcp_dsack_extend |  -29 # 55 -> 26, # inlines: 1 -> 0, size inlines: 34 -> 0
>   tcp_data_queue   |  -49 # 2892 -> 2843, size inlines: 1247 -> 1240
>  2 functions changed, 78 bytes removed
> 
> /home/acme/git/net-2.6.25/net/ipv4/tcp_input.c:
>   tcp_sack_extend |  +34 (uninlined)
>  1 function changed, 34 bytes added
> 
> /tmp/tcp_input.o.after:
>  3 functions changed, 34 bytes added, 78 bytes removed, diff: -44
> [acme@doppio pahole]$

Thanks...

Now that I automated it for inlines per file, one thing that annoys me a 
bit is that it does not keep identical formatting on the last line (it's 
fixable of course by some simple sed trickery):

static inline int tcp_may_raise_cwnd(const struct sock *sk, const int 
flag)
net/ipv4/tcp_input.c:
  tcp_prune_queue |  -16
 1 function changed, 16 bytes removed

...versus...

static inline int tcp_may_update_window(const struct tcp_sock *tp,
net/ipv4/tcp_input.c:
  tcp_disordered_ack |  -18
  tcp_ack            |  -76
 2 functions changed, 94 bytes removed

net/ipv4/tcp_input.c:
  tcp_may_update_window |  +56
 1 function changed, 56 bytes added

net/ipv4/tcp_input.o:
 3 functions changed, 56 bytes added, 94 bytes removed, diff: -38


diff: xx is not always present.


-- 
 i.
---696243703-150640081-1199376902=:14949--
-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
