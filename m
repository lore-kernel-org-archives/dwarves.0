From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: eat your own dog food?
Date: Thu, 10 Jan 2008 12:06:35 -0200
Message-ID: <20080110140635.GG22437@ghostprotocols.net>
References: <1199968968.4438.49.camel@localhost> <20080110133926.GF22437@ghostprotocols.net> <1199973341.4438.56.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1199973341.4438.56.camel@localhost>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jamal <hadi-fAAogVwAN2Kw5LPnMra/2Q@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Thu, Jan 10, 2008 at 08:55:41AM -0500, jamal escreveu:
> On Thu, 2008-10-01 at 11:39 -0200, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Jan 10, 2008 at 07:42:48AM -0500, jamal escreveu:
> 
> > :-) I'll check that later :-P But some holes are inevitable, the best
> > thing is to try:
> > 
> > [acme@doppio pahole]$ pahole --packable build/pahole
> > argp_child      32      24      8
> > argp_option     48      40      8
> > _IO_FILE        216     208     8
> > [acme@doppio pahole]$
> > 
> > Which is kinda interesting, huh? Only glibc stuff :-)
> 
> hehe;-> damn those dog-food cans.
> 
> > No need for lynching this time. 
> 
> ok;-> 
> 
> > What we have to do is:
> > 
> > . make the addr_size configurable and when the user specifies an
> > addr_size that is different than the one in the DWARF info being
> > processed, fixup it in all the data structures. The --reorganize code
> > already does many kinds of fixups, it would be one more.
> > 
> > . moreover, specify alignment rules, that way the reorganization code
> > would process all the structs, applying this rule.
> > 
> > IOW: its possible, should be fairly easy to implement the addr_size and
> > from that the alignment rules.
> > 
> > I'll try to work on the addr_size first, perhaps this weekend as I've
> > been promising to do way too many things in many fronts :-\
> 
> ok, cool - so i should be able say something like "--add_size 64-bit"
> and it will follow something like the MIPS EABI i posted earlier? [I
> think x86_64 will work the same way too if i am not mistaken].

Exactly, you will be able to change the addr_size, I think that there is
even code that can be right away used for that, lemme check.

- Arnaldo
-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
