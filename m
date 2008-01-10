From: jamal <hadi-fAAogVwAN2Kw5LPnMra/2Q@public.gmane.org>
Subject: Re: eat your own dog food?
Date: Thu, 10 Jan 2008 16:37:14 -0500
Message-ID: <1200001034.4443.35.camel@localhost>
References: <1199968968.4438.49.camel@localhost>
	 <20080110133926.GF22437@ghostprotocols.net>
	 <1199973341.4438.56.camel@localhost>
	 <20080110140635.GG22437@ghostprotocols.net>
	 <20080110163959.GJ22437@ghostprotocols.net>
Reply-To: hadi-fAAogVwAN2Kw5LPnMra/2Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080110163959.GJ22437-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

On Thu, 2008-10-01 at 14:39 -0200, Arnaldo Carvalho de Melo wrote:

> First stab, doesn't handles unions shrinking because the largest member
> shrunk, and handles only binaries built for 64 bits (or bigger) having
> it addr_size (word_size) shrinking.
> 

Only for 64-bit machines? 
My laptop is still 32-bit - from the patch i cant see anything that'll
stop me from testing for 64 bit from a 32-bit compilation.

[..]

> 
> Lets go all the way back to the 8088:
> 

;->

> [acme@doppio pahole]$ build/pahole -w 1 -C structure build/pahole
> struct structure {
> 	struct list_head           node;                 /*     0     2 */
> 	struct class *             class;                /*     2     1 */
> 	const struct cu  *         cu;                   /*     3     1 */
> 	uint32_t                   nr_files;             /*     4     4 */
> 	uint32_t                   nr_methods;           /*     8     4 */
> 
> 	/* size: 12, cachelines: 1 */
> 	/* last cacheline: 12 bytes */
> };
> 
> Not really because we're only change 'long' from the original word size
> to the one specified.
> 
> Please test and find the missing bits for me :-)


Will do later today.


cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
