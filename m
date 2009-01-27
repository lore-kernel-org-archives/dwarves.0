From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: extracting data access from functions
Date: Tue, 27 Jan 2009 13:27:24 -0200
Message-ID: <20090127152724.GB27308@ghostprotocols.net>
References: <20090127151124.GA18307@jukie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090127151124.GA18307-LIbhotJ4rFdeoWH0uzbU5w@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bart Trojanowski <bart-LIbhotJ4rFdeoWH0uzbU5w@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Tue, Jan 27, 2009 at 10:11:25AM -0500, Bart Trojanowski escreveu:
> I am trying to do some data mining on a large code base.  I would like
> to generate a list of structure members accessed by certain functions.
> 
> After studying the examples in the pahole.git tree, I am able to walk
> the dwarves structures down to the right tags.  However, I am not sure
> how to make the next step.
> 
> For example, given
> 
> void foo(struct s *s)
> {
>         ... s->var ...
> }
> 
> I would like to have a tool that reports foo accessing s->var.
> 
> Is that possible with the DWARF debug tags?  Maybe using elftools?  I am
> trying to avoid the temptation of parsing the C code in perl :)
> 
> Thanks in advance.

With DWARF you can:

1. find out struct layout
2. find which functions have parameters of the type you want
3. find which functions have variables of the type you want
4. Know where such variables and parameters are on memory
   using DWARF location expressions (google for loc2c)

And that is it.

Then... you would need to use libdisasm, that is part of elfutils but is
still a bit rough, being designed mostly for what you get from the
binutils utilities disassembly options.

Combinining the above you will be able to do what you want.

And I really, really want to have that, but have no time at the moment.

I want to look at usage patterns to figure out what are the member
working sets to pass that to my struct member reorganizing routines, run
with performance counters before/after, all automated, and reap the
profits 8)

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
