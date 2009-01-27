From: Roland McGrath <roland-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: extracting data access from functions
Date: Tue, 27 Jan 2009 15:07:51 -0800 (PST)
Message-ID: <20090127230751.8443BFC3C8@magilla.sf.frob.com>
References: <20090127151124.GA18307@jukie.net>
	<20090127152724.GB27308@ghostprotocols.net>
	<20090127155221.GD18307@jukie.net>
	<20090127160133.GB15877@ghostprotocols.net>
	<20090127162633.GF18307@jukie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: Bart Trojanowski's message of  Tuesday, 27 January 2009 11:26:34 -0500 <20090127162633.GF18307-LIbhotJ4rFdeoWH0uzbU5w@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bart Trojanowski <bart-LIbhotJ4rFdeoWH0uzbU5w@public.gmane.org>
Cc: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

elfutils-devel-TuqUDEhatI7GMZAyRF5v151Ccm5ICvs9@public.gmane.org is the place to post about your
build issues.  You're just in luck that I happen to be on this list
too to have noticed.  You probably need a newer automake or something
and run "autoreconf -f -i"; I'm using 1.10.1 and autoconf-2.63.  (Or
you can just use the rpm/tarball instead of git, and not run auto*
yourself.)

For what you want I suspect that none of our stuff is the way to go
about it, really.  As acme pointed out, lots of that information is
lost in compilation and is not really accessible any more.  What we
can do (and not at all easily any time soon) is rediscover some of it.
But it's all there in the source, and I'm sure there are
source-parsing tools that do what you want around to be found (cscope
maybe? some IDE's features?).

On the (unwritten) list for the future is doing something quite like
what you asked about.  But it's a far ways off, and, again, it's
really almost certainly not the right way to skin your particular cat.

What it is I have in mind for the future is a combination of a "smart
disassembler" that generates DWARF location expressions describing
instruction operands, with lots of general smarts for hacking location
expressions.  Then you could disassemble, analyze the DWARF describing
the containing scope, and match up each instruction operand's location
expression with the locations of variables in scope.  One target use
for this is to identify the "hot variables" (or hot struct fields) by
identifying "hot spots" in the code via profiling etc., and then analyzing
the locations are used in that code to yield the source constructs that
correspond.

I think this will be a fabulous thing.  But it's a long ways off.
And, it's not at all the most sensible or straightforward approach for
addressing your case where plain source analysis would be much easier
and more informative.


Thanks,
Roland
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
