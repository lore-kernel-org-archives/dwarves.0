From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: eat your own dog food?
Date: Thu, 10 Jan 2008 19:39:09 -0200
Message-ID: <20080110213909.GS22437@ghostprotocols.net>
References: <1199968968.4438.49.camel@localhost> <20080110133926.GF22437@ghostprotocols.net> <1199973341.4438.56.camel@localhost> <20080110140635.GG22437@ghostprotocols.net> <20080110163959.GJ22437@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080110163959.GJ22437-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jamal <hadi-fAAogVwAN2Kw5LPnMra/2Q@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Thu, Jan 10, 2008 at 02:39:59PM -0200, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Jan 10, 2008 at 12:06:35PM -0200, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Jan 10, 2008 at 08:55:41AM -0500, jamal escreveu:
> > > ok, cool - so i should be able say something like "--add_size 64-bit"
> > > and it will follow something like the MIPS EABI i posted earlier? [I
> > > think x86_64 will work the same way too if i am not mistaken].
> > 
> > Exactly, you will be able to change the addr_size, I think that there is
> > even code that can be right away used for that, lemme check.
> 
> First stab, doesn't handles unions shrinking because the largest member
> shrunk, and handles only binaries built for 64 bits (or bigger) having
> it addr_size (word_size) shrinking.

Working now on unions, etc, have you had the chance of testing this
patch?

- Arnaldo
-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
