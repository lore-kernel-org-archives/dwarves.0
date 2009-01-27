From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: extracting data access from functions
Date: Tue, 27 Jan 2009 14:01:33 -0200
Message-ID: <20090127160133.GB15877@ghostprotocols.net>
References: <20090127151124.GA18307@jukie.net> <20090127152724.GB27308@ghostprotocols.net> <20090127155221.GD18307@jukie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090127155221.GD18307-LIbhotJ4rFdeoWH0uzbU5w@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bart Trojanowski <bart-LIbhotJ4rFdeoWH0uzbU5w@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Tue, Jan 27, 2009 at 10:52:22AM -0500, Bart Trojanowski escreveu:
> * Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> [090127 10:27]:
> > With DWARF you can:
> > 
> > 1. find out struct layout
> > 2. find which functions have parameters of the type you want
> > 3. find which functions have variables of the type you want
> > 4. Know where such variables and parameters are on memory
> >    using DWARF location expressions (google for loc2c)
> > 
> > And that is it.
> 
> Thanks for the quick reply and clarification.
> 
> > Then... you would need to use libdisasm, that is part of elfutils but is
> > still a bit rough, being designed mostly for what you get from the
> > binutils utilities disassembly options.
> >
> > Combinining the above you will be able to do what you want.
> 
> That sounds interesting, but unfortunately the man pages notes that...
> >> The x86-64 architecture is not supported..LP
> ... being ia32-only makes it a no go for me.

Forget about the man page, this is very fluid, look at the latest
released version, 0.139, on fedorahosted, lemme dig the URL

https://fedorahosted.org/elfutils/

There is now a git tree, check it and, again, forget about the man page
:)
 
> Is there another route you could think of that is not platform-specific?
> 
> I guess binutils/objdump doesn't actually understand what's happening it
> just links it back to the code.  Hmm... and things like gdb are aware of
> things because they are platform specific.
> 
> > I want to look at usage patterns to figure out what are the member
> > working sets to pass that to my struct member reorganizing routines, run
> > with performance counters before/after, all automated, and reap the
> > profits 8)
> 
> I hear ya. :)
> 
> Thanks again.

Gimme 5 minutes and I'll get that done! ;-)

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
