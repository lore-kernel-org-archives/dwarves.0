From: "=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen-pxSi+dnQzZMxHbG02/KK1g@public.gmane.org>
Subject: Re: speedup in tag lookup using hash tables
Date: Tue, 12 Feb 2008 15:24:19 +0200 (EET)
Message-ID: <Pine.LNX.4.64.0802121456120.31652@kivilampi-30.cs.helsinki.fi>
References: <20080212000310.GB4157@ghostprotocols.net>
 <Pine.LNX.4.64.0802121301180.31652@kivilampi-30.cs.helsinki.fi>
 <20080212125037.GE4157@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-696243703-1399264866-1202822659=:31652"
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080212125037.GE4157-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---696243703-1399264866-1202822659=:31652
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 12 Feb 2008, Arnaldo Carvalho de Melo wrote:

> Em Tue, Feb 12, 2008 at 01:24:44PM +0200, Ilpo Järvinen escreveu:
> > On Mon, 11 Feb 2008, Arnaldo Carvalho de Melo wrote:
> > >
> > > 	codiff doesn't makes that much tag lookups, so we didn't got
> > > much improvements there,
> > 
> > Because I had to do these file by file anyway, I ended up using modified 
> > timestamps in my scripts to avoid loading .o files altogether when one 
> > wasn't recompiled. It helped some.
> 
> This reminds me that I have to add support comparing build trees, so
> that we can use 'make O=old' to build a baseline and then 'make O=new',
> using ccache to reuse the old (or simply copying old to new) and then
> process file after file, combining the results for tree wide
> comparisions/statistics.

Hmm, maybe I could use the copying too to cut the times down a bit more. 
That didn't occur to me before that, thanks for the tip. :-)

> > > but I'm doing experiments on dead tag elimination
> > > that probably will help a lot there, but for that I have first to grok
> > > Ulrich Drepper's libdisasm to find out what are the tags that are really
> > > used by looking at accesses to register indexed memory areas that use as
> > > a base pointer what is in local/global variables and function
> > > parameters.
> > >
> > > 	This also will provide the basis for detecting access patterns
> > > that will ultimatelly allow libdwarves_reorganize to do struct
> > > reorganizations to improve locality of reference, etc.
> > 
> > This sounds nice, I was thinking something similar earlier but would have 
> > tried to do that with some kind of source analysis.
> 
> That is possible too, and indeed I did experiments in the past with
> sparse, the library used by the kernel checker (make C=[12]), but I
> think that tapping into the readily available debuginfo packages, not
> just for the kernel, looking at the end, object file, result is better.

Also I briefly read some sparse code but never really got it
started... :-) Besides with source it easily gets nasty with all 
the complexity of c, machine code is much more straight-forward. Besides, 
in one respect it's much better to avoid using source code, the compiled 
form represents the end result of the thing we're trying to optimize, 
source code lacks the details added by the optimizations (mainly 
reordering & dead code elimination that is possible on some paths).

> Excellent! Some people at some point noted that while the dwarves are
> useful for showing the problems, people actually had to follow up with
> patches to solve the problems, I'm very happy that you are doing just
> that, thanks a lot for that.

I even wrote a simple shell script to automate the dirty work in a simple
static inline from .h -> .c move, in the long run it definately pays of 
when you don't need to open all of them into an editor and do it by 
hand but can just do git-diff an check that the result is what one 
expects... :-) Of course it's not always that trivial task, e.g., 
libification of jhash is not a pure fire-and-forget type move but 
has to be thought some and multiple options needs to be compared.


-- 
 i.
---696243703-1399264866-1202822659=:31652--
