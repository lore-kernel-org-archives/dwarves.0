From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Can't persuade pahole to see through forward declarations
Date: Thu, 18 Jun 2009 15:36:34 -0300
Message-ID: <20090618183634.GE21530@ghostprotocols.net>
References: <20090615172409.6f0f322b@mozilla.com> <20090617170217.GB21530@ghostprotocols.net> <20090617102506.34aaf8e2@mozilla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090617102506.34aaf8e2-4eJtQOnFJqFBDgjK7y7TUQ@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zack Weinberg <zweinberg-4eJtQOnFJqFBDgjK7y7TUQ@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Wed, Jun 17, 2009 at 10:25:06AM -0700, Zack Weinberg escreveu:
> Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > Em Mon, Jun 15, 2009 at 05:24:09PM -0700, Zack Weinberg escreveu:
> > > I've been experimenting with your 'pahole' utility to analyze some
> > > of the data structures in Mozilla.  I've run into trouble because
> > > pahole seems to give up when it hits a forward declaration (a type
> > > DIE with DW_AT_declaration=1).  For instance, this is what -E -M
> > > mode prints for one of the classes of interest:
> > > 
> > > class nsFrame : public nsBox, public nsIFrameDebug {
> > > public:
> > > 	/* class nsBox {
> > > 	} <ancestor>; */              /*     0     0 */
> > > 
> > > 	/* XXX 64 bytes hole, try to pack */
> > > 
> > > 	/* --- cacheline 1 boundary (64 bytes) --- */
> > > 	/* class nsIFrameDebug {
> > > 		int ()(void) * *_vptr.nsIFrameDebug; 
> > > 			/*	64     8 */ 
> > > 	} <ancestor>; */ /*    64     8 */
> > > 
> > > 	/* size: 72, cachelines: 2, members: 2 */
> > > 	/* sum members: 8, holes: 1, sum holes: 64 */
> > > 	/* last cacheline: 8 bytes */
> > > };
> > > 
> > > As you can see, because it only sees the forward declaration for
> > > class nsBox, it thinks there's a gigantic hole in this class.  This
> > > makes it very hard to look for real problems.
> > > 
> > > I tried to patch pahole to look through forward declarations
> > > whenever possible (using cus__find_struct_by_name) but could not
> > > get it to work, even after switching the main loop from a load
> > > stealer to an iteration over all CUs after they're all loaded.  I
> > > get gibberish:
> > > 
> > > class nsFrame : public nsBox, public nsIFrameDebug {
> > > public:
> > > 	/* class nsBox : public M-0M-^I^D {
> > > 	public:
> > > 		/* PLDHashNumber      (<ancestor>)(PLDHashTable *,
> > > 		const void  *); */    /*     0     0 */
> > > 	} <ancestor>; */ /*     0     0 */
> > > 	/* XXX 64 bytes hole, try to pack */
> > > ...
> > > 
> > > I'm attaching the code changes I made.  Any advice you could give me
> > > would be greatly appreciated.  Note that there are two other changes
> > > in there -- I had to take out the cmake test for libebl, whatever
> > > that is (nothing fails to link without it), and I also changed -M
> > > mode to not print vtables.
> > 
> > I'm trying to figure this out, but the xulrunner debuginfo file I have
> > doesn't have the nsIFrameDebug class as an ancestor for nsFrame:
> 
> This is probably because it was configured out.  I am working with a 
> development build, which has all sorts of extra debugging mechanisms
> configured in.

OK, can you please send me a multi-cu file that has the above
definitions so that I can use it as the test case for this new feature?
 
> > Anyway, it shows nsBox as a zero sized class, which it isn't. Problem
> > is that if we process _just_ this CU we will never know what is the
> > size for nsBox... but should be doable for multi-CU files where we
> > can try to find another CU with the missing definition.
> 
> Right, that's what I figured was the problem.
> 
> > This will require a bit more coding, so that we can first go on
> > discarding CUs till we find class nsFrame, then if we find forward
> > decls in it, we must steal the CU and set it aside, then continue to
> > the other CUs, till we find the one with the class nsBox definition,
> > then process the first CU with nsFrame and when not finding
> > definitions for some of its ancestors, look on the other CU where we
> > found the nsBox definition.
> 
> What if the CU that has the nsBox definition has already gone past when
> we hit the one with nsFrame?  It seems to me that this would only work
> for some link orders.

Yeah, probably requires a two pass strategy, i.e. but perhaps I'm trying
to optimize this a bit too much, we'll see when I try.

> > Look below for a coment explaining the bug in your code.
> 
> Thanks!  That makes sense.  Meantime I've written code to post-process
> the incomplete output and fill in the missing classes, though.
> 
> 
> Tangentially, I would really like to be able to pass a *list* of
> structure/class names to -C (or have a separate option that reads a
> list from a file).  The full analysis I'm doing needs to look at 200 or
> so of the thousands of classes in xulrunner; currently I need to run
> pahole once for each, which is really slow.

Look at the last commit :-)

http://git.kernel.org/?p=linux/kernel/git/acme/pahole.git;a=commitdiff;h=519d1d3d9691ca94f458853c4710d501fb33720f
 
> Also, I wonder if you could see your way clear to adding an alternative
> output format that is easily machine-parseable?
> Approximation-to-C-source format is nice for humans but I've spent the
> past day and a bit writing a sed script to turn it into something that
> I can do programmed analysis on and it was no fun.

How would it look like?

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
