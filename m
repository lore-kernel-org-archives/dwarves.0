From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: eat your own dog food?
Date: Thu, 10 Jan 2008 19:44:38 -0200
Message-ID: <20080110214438.GT22437@ghostprotocols.net>
References: <1199968968.4438.49.camel@localhost> <20080110133926.GF22437@ghostprotocols.net> <1199973341.4438.56.camel@localhost> <20080110140635.GG22437@ghostprotocols.net> <20080110163959.GJ22437@ghostprotocols.net> <1200001034.4443.35.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1200001034.4443.35.camel@localhost>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jamal <hadi-fAAogVwAN2Kw5LPnMra/2Q@public.gmane.org>
Cc: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Thu, Jan 10, 2008 at 04:37:14PM -0500, jamal escreveu:
> On Thu, 2008-10-01 at 14:39 -0200, Arnaldo Carvalho de Melo wrote:
> 
> > First stab, doesn't handles unions shrinking because the largest member
> > shrunk, and handles only binaries built for 64 bits (or bigger) having
> > it addr_size (word_size) shrinking.
> > 
> 
> Only for 64-bit machines? 
> My laptop is still 32-bit - from the patch i cant see anything that'll
> stop me from testing for 64 bit from a 32-bit compilation.

for 32 bit binaries we'll need to add to the offsets after pointers and
long ints that will be 64 bits when the compiler marked them as 32.

good data point from you, that your laptop is 32 bits, I'll implement
the small -> big transition now.
 
- Arnaldo
-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
