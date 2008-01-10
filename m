From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: eat your own dog food?
Date: Thu, 10 Jan 2008 11:39:26 -0200
Message-ID: <20080110133926.GF22437@ghostprotocols.net>
References: <1199968968.4438.49.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1199968968.4438.49.camel@localhost>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jamal <hadi-fAAogVwAN2Kw5LPnMra/2Q@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Thu, Jan 10, 2008 at 07:42:48AM -0500, jamal escreveu:
> 
> Hey Arnaldo,
> 
> You ever tasted what you are cooking?;->
> 
> ---
> hadi@lilsol:~/git-trees/arnaldo/jamal/build$ pahole ./pahole| grep XXX
>         /* XXX last struct has 1 byte of padding */
>         /* XXX 1 bit hole, try to pack */
>         /* XXX 1 byte hole, try to pack */
>         /* XXX 2 bytes hole, try to pack */
>         /* XXX 2 bits hole, try to pack */
>         /* XXX 1 byte hole, try to pack */
>         /* XXX last struct has 2 bytes of padding */
>         /* XXX 1 byte hole, try to pack */
> hadi@lilsol:~/git-trees/arnaldo/jamal/build$
> ---

:-) I'll check that later :-P But some holes are inevitable, the best
thing is to try:

[acme@doppio pahole]$ pahole --packable build/pahole
argp_child      32      24      8
argp_option     48      40      8
_IO_FILE        216     208     8
[acme@doppio pahole]$

Which is kinda interesting, huh? Only glibc stuff :-)

--packable means: run --reorganize in all structs and compare the result
with the original struct, if we have savings, tell us (original size,
reorganized size, savings).

> On a serious note, feature request:
> 
> I am trying to put words to what i am looking for and it's a little hard
> without providing a lot of boring context. For brevity, lets say i have
> an inherited 500K lines of code. Assume i compiled a program for 32-bit
> target and now i have to move it to a 128-bit playstation 3 with
> whatever strange alignment rules. 
> I want to do achieve 2 and a half things:
> 
> a) 
> i) check the structure for holes for X-bit access alignment where X is
> 16 (old 680xx), 64, 128. I want to do this without compiling the program
> for any of those targets i.e i want to do this on my x86 32-bit
> laptop ;-> i.e call this cross-pahole
> 
> ii) If i can do the above; i should then be able to say "optimize" (what
> you call --reorganize) for X-bit
> 
> b) I want to do a multiple of these example "optimize for 32-bit and
> 64-bit" or "check if it is safe for 128-bit and 16-bit alignemnt"
> 
> Note, clearly if i can make it read config files with rules for
> something like the MIPS EABI in the first part of this email:
>  http://sourceware.org/ml/binutils/2003-06/msg00436.html
> then i can say "check if it safe for mips 32 bit and x86_64" ;->
> And i can make sure my apps will run on that new cpu i dont have access
> to.
> 
> I could ask for more, but let me start/stop here incase you are going to
> lynch me;->

No need for lynching this time. What we have to do is:

. make the addr_size configurable and when the user specifies an
addr_size that is different than the one in the DWARF info being
processed, fixup it in all the data structures. The --reorganize code
already does many kinds of fixups, it would be one more.

. moreover, specify alignment rules, that way the reorganization code
would process all the structs, applying this rule.

IOW: its possible, should be fairly easy to implement the addr_size and
from that the alignment rules.

I'll try to work on the addr_size first, perhaps this weekend as I've
been promising to do way too many things in many fronts :-\

- Arnaldo
-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
