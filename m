From: Arnaldo Carvalho de Melo <acme-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: Brain fart alert
Date: Mon, 20 Aug 2012 15:28:10 -0300
Message-ID: <20120820182810.GF3046@infradead.org>
References: <CACHCVZ6oDyFwGbC4EwF_wsR9tCkoych5N6buLhRRLcyaL6iifw@mail.gmail.com>
 <20120820180216.GE3046@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120820180216.GE3046-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas <nikos42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Mon, Aug 20, 2012 at 03:02:16PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Sat, Jul 21, 2012 at 08:22:33PM +0200, Nicolas escreveu:
> > I tried using pahole, but I get a brain fart alert with the file
> > attached (which is an extract from stdio.h). I'm running dwarves 1.10,
> > libdw1 0.152 and g++ 4.6.1, on i386.
> > 
> > Here is what I get:
> > 
> > $ g++ -Wall -g -c brainfart.cpp -o brainfart.o && pahole brainfart.o
> > class ios_base {
> > 	enum _Ios_Openmodeconst    in;                   /*     0     4 */
> > 	typedef enum _Ios_Fmtflags fmtflags;
> > 
> > 	/* size: 1, cachelines: 1, members: 1 */
> > 	/* padding: 65533 */
> > 	/* last cacheline: 1 bytes */
> > 
> > 	/* BRAIN FART ALERT! 1 != 4 + 0(holes), diff = -3 */
> 
> Can you please clone my git tree and try it from there?
> 
> git clone git://git.kernel.org/pub/scm/devel/pahole/pahole
> cd pahole
> mkdir build
> cd build
> cmake ..
> cd ..
> make -C build
> build/pahole brainfart.o
> 
> Now I'm getting:
> 
> [acme@sandy pahole]$ build/pahole brainfart.o 
> class ios_base {
> 	static enum _Ios_Openmodeconst    in = 8;        /*     0     0 */
> 	typedef enum _Ios_Fmtflags fmtflags;
> 
> 
> 	/* size: 1, cachelines: 0, members: 0, static members: 1 */
> 	/* last cacheline: 1 bytes */
> };
> [acme@sandy pahole]$
> 
> I still need to get the 'const' there, from the fact that it has a
> DW_AT_const_value, that is already captured, just forgot to add the
> 'const' there, will do after some errands here.
> 
> Also I'll check that the member type is an enum, will lookup the
> enumerator entry that has the DW_AT_const_value and replace that '8'
> with it.

I also noticed that there is a problem when the static member is not the
first, related to bitfield hole detection, will fix it too.

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
