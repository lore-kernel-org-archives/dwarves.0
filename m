From: Hagen Paul Pfeifer <hagen-GvnIQ6b/HdU@public.gmane.org>
Subject: Re: new pahole packet structure
Date: Thu, 27 Dec 2007 19:53:50 +0100
Message-ID: <20071227185350.GA28211@c3po.0xdef.net>
References: <20071224224156.GB24470@c3po.0xdef.net> <20071225201226.GA28007@ghostprotocols.net> <20071226171437.GA16456@c3po.0xdef.net> <20071226174928.GC28007@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20071226174928.GC28007-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

* Arnaldo Carvalho de Melo | 2007-12-26 15:49:28 [-0200]:

>checking for libdw... no

Strange! This should only be happens if libwd.so isn't in the standard search
path!

The configure script probe for libdw via:

gcc -ldw -o /dev/null dwtest.c

gcc -print-search-dirs | grep /usr/lib64/ should[tm] match! I tested the
configure script on Debian and Arch linux - NULL problems there. Anyway: I
will install fedora and test it one more time.


HAGEN


-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
