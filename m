From: "=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen-pxSi+dnQzZMxHbG02/KK1g@public.gmane.org>
Subject: Re: codiff misses changes if inline -> not inlined?
Date: Fri, 4 Jan 2008 01:24:02 +0200 (EET)
Message-ID: <Pine.LNX.4.64.0801040111530.16761@kivilampi-30.cs.helsinki.fi>
References: <Pine.LNX.4.64.0801031528400.14949@kivilampi-30.cs.helsinki.fi>
 <20080103143139.GC29523@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-696243703-1933831325-1199402642=:16761"
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080103143139.GC29523-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---696243703-1933831325-1199402642=:16761
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 3 Jan 2008, Arnaldo Carvalho de Melo wrote:

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
> From codiff's point of view its a "new" function... I'm checking this right now, just a sec :)

More very interesting cases found... :-/ The tool removed inline from 
ip_ufo_append_data and got this result:

$ codiff -V net/ipv4/ip_output.o.old net/ipv4/ip_output.o
net/ipv4/ip_output.c:
  dst_output        |  +11 (uninlined)
  ip_send_check     |  +69 (uninlined)
  ip_finish_output2 | +594 (uninlined)
 3 functions changed, 674 bytes added, diff: +674

...It may well be right due to some strange inlining heurestics 
interaction but I'm a bit suspicious because of the large numbers and 
pfunct -i tells a different story for at least ip_finish_output2 and 
ip_send_check (in both cases the sizes are constant 0 in -i output!?!).


-- 
 i.
---696243703-1933831325-1199402642=:16761--
-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
