From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Formatting "drivers" was Re: Can't persuade pahole to see through
	forward declarations
Date: Thu, 18 Jun 2009 17:50:53 -0300
Message-ID: <20090618205053.GA4258@ghostprotocols.net>
References: <20090615172409.6f0f322b@mozilla.com> <20090617170217.GB21530@ghostprotocols.net> <20090617102506.34aaf8e2@mozilla.com> <20090618183634.GE21530@ghostprotocols.net> <20090618132820.2eb7371a@mozilla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090618132820.2eb7371a-4eJtQOnFJqFBDgjK7y7TUQ@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zack Weinberg <zweinberg-4eJtQOnFJqFBDgjK7y7TUQ@public.gmane.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen-pxSi+dnQzZMxHbG02/KK1g@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Thu, Jun 18, 2009 at 01:28:20PM -0700, Zack Weinberg escreveu:
> Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > > > I'm trying to figure this out, but the xulrunner debuginfo file I
> > > > have doesn't have the nsIFrameDebug class as an ancestor for
> > > > nsFrame:
> > > 
> > > This is probably because it was configured out.  I am working with
> > > a development build, which has all sorts of extra debugging
> > > mechanisms configured in.
> > 
> > OK, can you please send me a multi-cu file that has the above
> > definitions so that I can use it as the test case for this new
> > feature?
> 
> It's 42MB bzipped.  You can download it from
> http://www.owlfolio.org/libgklayout.so.bz2 but I'm going to delete it
> after a week.

I'm downloading it now
 
> > > Tangentially, I would really like to be able to pass a *list* of
> > > structure/class names to -C (or have a separate option that reads a
> > > list from a file).  The full analysis I'm doing needs to look at
> > > 200 or so of the thousands of classes in xulrunner; currently I
> > > need to run pahole once for each, which is really slow.
> > 
> > Look at the last commit :-)
> > 
> > http://git.kernel.org/?p=linux/kernel/git/acme/pahole.git;a=commitdiff;h=519d1d3d9691ca94f458853c4710d501fb33720f
> 
> Perfect, thanks.
> 
> > > Also, I wonder if you could see your way clear to adding an
> > > alternative output format that is easily machine-parseable?
> > > Approximation-to-C-source format is nice for humans but I've spent
> > > the past day and a bit writing a sed script to turn it into
> > > something that I can do programmed analysis on and it was no fun.
> > 
> > How would it look like?
> 
> For the analysis I'm doing, the ideal format would be very flat and
> line-oriented.  Consider this structure definition:
> 
> struct Foo {
>   union {
>     struct { int x; int y; } a;
>     struct { float z; short y; } b;
>     double c;
>     void* d;
>   } u;
>   char n[4];
>   void (*ptr)(int);
>   void (*ptrs[2])(int);
>   int bf:12;
>   short bg:3;
> };
> 
> I would like to get something like this (assuming LP64):
> 
> name|type|bytes|bits|byteoff|bitoff|cacheline
> Foo|struct Foo|48|0|0|0|0
> Foo.u|union|8|0|0|0|0
> Foo.u.a|struct|8|0|0|0|0
> Foo.u.a.x|int|4|0|0|0|0
> Foo.u.a.y|int|4|0|4|0|0
> Foo.u.b|struct|8|0|0|0|0
> Foo.u.b.z|float|4|0|0|0|0
> Foo.u.b.y|short int|2|0|4|0|0
> Foo.u.b.<pad>|pad|2|0|6|0|0
> Foo.u.c|double|8|0|0|0|0
> Foo.u.d|void *|8|0|0|0|0
> Foo.n|char[4]|4|0|8|0|0
> Foo.<hole1>|pad|4|0|12|0|0
> Foo.ptr|void(*)(int)|8|0|16|0|0
> Foo.ptrs|void(*[2])(int)|16|0|24|0|0
> Foo.bf|int|1|4|40|0|0
> Foo.bg|short int|0|3|41|4|0
> Foo.<pad>|pad|6|1|41|7|0
> 
> I suggest "|" for the field separator because I'm pretty sure it can't
> appear in a C/C++ "abstract declaration" (i.e. the "type" field).  Tabs
> are visually confusable with the spaces that you do occasionally need
> in an abstract declaration.
> 
> The key properties of this are:
> 
>  - There is only one kind of record to process.
>  - Each line can be examined in isolation, if you don't care about the
>    nesting structure.
>  - You do not have to process C declaration syntax to find the name of
>    each field.
>  - There is never missing data; in many cases pahole currently will
>    omit the offset in its annotation of a full nested structure,
>    for instance, which is fine for humans but really bad for machine
>    processing.

Annoying "simplification", I'll put the offset there explicitely, just
worried that Ilpo may be using it in his sed scripts... Ilpo?

>  - Padding at the end of a structure is explicit, always.  (The current
>    pahole output doesn't call it out at all for the 'b' struct inside
>    the union.)

This one is a bug, I'll fix it.

>  - Bitfields are not special: the structure is treated as a linear
>    array of bits, within which every field starts at bit
>    (byteoff*8+bitoff) and continues for (bytes*8+bits) bits.
>    The bitoff and bits columns are always in the range 0..7.
>    This saves some fiddly math.

Well, here the CTFication of the core will give a dividend :-) We
already treat everything as bit_offsets, see struct class_member.

My first reaction is that dwarf_fprintf would need a "fprintf_ops"
struct and that then the current set of functions called from
tag__fprintf would be the first formatter, and the second one that will
just do as you suggest.

I'll investigate that idea.

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
