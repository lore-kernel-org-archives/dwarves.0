From: Zack Weinberg <zweinberg-4eJtQOnFJqFBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Formatting "drivers" was Re: Can't persuade pahole to see
 through forward declarations
Date: Tue, 23 Jun 2009 23:42:44 -0700
Message-ID: <20090623234244.03d0edb1@mozilla.com>
References: <20090615172409.6f0f322b@mozilla.com>
	<20090617170217.GB21530@ghostprotocols.net>
	<20090617102506.34aaf8e2@mozilla.com>
	<20090618183634.GE21530@ghostprotocols.net>
	<20090618132820.2eb7371a@mozilla.com>
	<20090618205053.GA4258@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090618205053.GA4258-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen-pxSi+dnQzZMxHbG02/KK1g@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Em Thu, Jun 18, 2009 at 01:28:20PM -0700, Zack Weinberg escreveu:
> >  - Padding at the end of a structure is explicit, always.  (The
> > current pahole output doesn't call it out at all for the 'b' struct
> > inside the union.)
> 
> This one is a bug, I'll fix it.

Cool.

> >  - Bitfields are not special: the structure is treated as a linear
> >    array of bits, within which every field starts at bit
> >    (byteoff*8+bitoff) and continues for (bytes*8+bits) bits.
> >    The bitoff and bits columns are always in the range 0..7.
> >    This saves some fiddly math.
> 
> Well, here the CTFication of the core will give a dividend :-) We
> already treat everything as bit_offsets, see struct class_member.

I don't know what CTF is, and -z doesn't seem to do anything... but
it's good to know the internal representation has no trouble here.

> My first reaction is that dwarf_fprintf would need a "fprintf_ops"
> struct and that then the current set of functions called from
> tag__fprintf would be the first formatter, and the second one that
> will just do as you suggest.

Yes, that sounds like a good strategy.

zw
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
