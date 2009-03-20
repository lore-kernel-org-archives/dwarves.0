From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Status of Union
Date: Fri, 20 Mar 2009 17:22:50 -0300
Message-ID: <20090320202250.GR30407@ghostprotocols.net>
References: <20090315032138.GB22651@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090315032138.GB22651-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Hi Folks,

	Even if just to dump what I have to say, here it goes:

Converting all the object files in a Linux make allyesconfig build
leaves us with just these mismatches from what is in the DWARF info and
what is in the CTF info, for types, for the information gathered by the
dwarves tools:

[acme@emilia allyesconfig]$ l /tmp/ctfdwdiff_allyesconfig/*.diff
-rw-rw-r-- 1 acme acme  7154 Mar 20 15:18 /tmp/ctfdwdiff_allyesconfig/BusLogic.o.diff
-rw-rw-r-- 1 acme acme  1766 Mar 20 15:28 /tmp/ctfdwdiff_allyesconfig/callback.o.diff
-rw-rw-r-- 1 acme acme  1410 Mar 20 15:11 /tmp/ctfdwdiff_allyesconfig/config_roms.o.diff
-rw-rw-r-- 1 acme acme   959 Mar 20 15:17 /tmp/ctfdwdiff_allyesconfig/cxio_hal.o.diff
-rw-rw-r-- 1 acme acme 25555 Mar 20 15:13 /tmp/ctfdwdiff_allyesconfig/DAC960.o.diff
-rw-rw-r-- 1 acme acme  1412 Mar 20 15:16 /tmp/ctfdwdiff_allyesconfig/firedtv-1394.o.diff
-rw-rw-r-- 1 acme acme  1009 Mar 20 15:19 /tmp/ctfdwdiff_allyesconfig/libfcoe.o.diff
[acme@emilia allyesconfig]$

The cases can be subsumed to:

1. packed enums, be it in typedefs or directly in the struct member
declaration.

2. CTF doesn't seem to be expressive enough to carry the type of a
forward declaration, i.e. if its "union foo" or "struct foo" it couldn't
care less, as this wouldn't help whatever tools at all.

So I'll concentrate on #1 and then get to the merge stuff, then back to
work on the other sections besides the types section so cherished by
pahole :-)

As always, whatever reports you may have, I'll do my best to keep this
project kicking and helpful for people interested in what is here and in
what can be done once some legwork is in place.

Best Regards,

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
