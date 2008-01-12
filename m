From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Changing the word-size was: Re: eat your own dog food?
Date: Sat, 12 Jan 2008 15:28:56 -0200
Message-ID: <20080112172856.GD23567@ghostprotocols.net>
References: <1199968968.4438.49.camel@localhost> <20080110133926.GF22437@ghostprotocols.net> <1199973341.4438.56.camel@localhost> <20080110140635.GG22437@ghostprotocols.net> <20080110163959.GJ22437@ghostprotocols.net> <20080110213909.GS22437@ghostprotocols.net> <1200001276.4443.40.camel@localhost> <20080112152109.GA23567@ghostprotocols.net> <20080112155404.GB23567@ghostprotocols.net> <20080112162808.GC23567@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080112162808.GC23567-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jamal <hadi-fAAogVwAN2Kw5LPnMra/2Q@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Sat, Jan 12, 2008 at 02:28:08PM -0200, Arnaldo Carvalho de Melo escreveu:
> Em Sat, Jan 12, 2008 at 01:54:04PM -0200, Arnaldo Carvalho de Melo escreveu:
> > Em Sat, Jan 12, 2008 at 01:21:09PM -0200, Arnaldo Carvalho de Melo escreveu:
> > > Em Thu, Jan 10, 2008 at 04:41:16PM -0500, jamal escreveu:
> > > > On Thu, 2008-10-01 at 19:39 -0200, Arnaldo Carvalho de Melo wrote:
> > > > 
> > > > 
> > > > > Working now on unions, etc, have you had the chance of testing this
> > > > > patch?
> > > > 
> > > > I should be able to test it in a couple of hours. If you have the unions
> > > > change before then, send me a unified patch - else an incremental
> > > > version.
> > > 
> > > Remove the non-commited patches and do a git-pull, basic work is done,
> > > reusing code I had in ctracer to do some simple alignment fixups.
> > > 
> > > Please let me know about any bugs you may find.
> > 
> > There are still some problems:
> > 
> > [acme@doppio pahole]$ build/pahole -C e1000_opt_list \
> > /usr/lib/debug/lib/modules/2.6.21-65.el5rt/kernel/drivers/net/e1000/e1000.ko.debug
> > 
> > struct e1000_opt_list {
> > 	int                        i;                    /*     0     4 */
> > 
> > 	/* XXX 4 bytes hole, try to pack */
> > 
> > 	char *                     str;                  /*     8     8 */
> > 
> > 	/* size: 16, cachelines: 1 */
> > 	/* sum members: 12, holes: 1, sum holes: 4 */
> > 	/* last cacheline: 16 bytes */
> > };
> > 
> > So on 64 bits we have a hole because pointers are aligned at word-size
> > boundaries, changing it to 4 bytes:
> > 
> > [acme@doppio pahole]$ build/pahole -w 4 -C e1000_opt_list \
> > /usr/lib/debug/lib/modules/2.6.21-65.el5rt/kernel/drivers/net/e1000/e1000.ko.debug
> > struct e1000_opt_list {
> > 	int                        i;                    /*     0     4 */
> > 
> > 	/* XXX 4 bytes hole, try to pack */
> > 
> > 	char *                     str;                  /*     8     4 */
> > 
> > 	/* size: 12, cachelines: 1 */
> > 	/* sum members: 8, holes: 1, sum holes: 4 */
> > 	/* last cacheline: 12 bytes */
> > };
> > 
> > The pointer size was correctly changed to 4 and the size reduced to 12,
> > but we should have subtracted 4 bytes from 'str' offset and the hole
> > would disappear and the size becomes 8.
> > 
> > Working on it.
> 
> Partially fixed, which says a lot about how bad class__fixup_alignment
> is :-\ Only holes after unions are not being fixed up, still scratching
> my head on why this is the case.

Problem wasn't in class__fixup_alignment, we have to check if the type
of members were already resized when resizing a struct/union.
Fixed'n'pushed.

Now what seems to be the last thing to do is to follow typedefs and find
unnamed structs, think about spinlock_t, socket_lock_t, etc.

- Arnaldo
-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
