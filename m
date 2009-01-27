From: Bart Trojanowski <bart-LIbhotJ4rFdeoWH0uzbU5w@public.gmane.org>
Subject: Re: extracting data access from functions
Date: Tue, 27 Jan 2009 11:26:34 -0500
Message-ID: <20090127162633.GF18307@jukie.net>
References: <20090127151124.GA18307@jukie.net> <20090127152724.GB27308@ghostprotocols.net> <20090127155221.GD18307@jukie.net> <20090127160133.GB15877@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090127160133.GB15877-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

* Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> [090127 11:01]:
> > > Then... you would need to use libdisasm, that is part of elfutils but is
> > > still a bit rough, being designed mostly for what you get from the
> > > binutils utilities disassembly options.
> > >
> > > Combinining the above you will be able to do what you want.
> > 
> > That sounds interesting, but unfortunately the man pages notes that...
> > >> The x86-64 architecture is not supported..LP
> > ... being ia32-only makes it a no go for me.
> 
> Forget about the man page, this is very fluid, look at the latest
> released version, 0.139, on fedorahosted, lemme dig the URL
> 
> https://fedorahosted.org/elfutils/
> 
> There is now a git tree, check it and, again, forget about the man page
> :)

Man page has been forgotten :)

Now, on the topic of elfutils.  I had already upgraded to elfutils 0.138
from git.  I was unable to get 0.139 (or HEAD) to build on debian/lenny.

automake emits the following warnings:

libdwfl/Makefile.am:78: ZLIB does not appear in AM_CONDITIONAL
libdwfl/Makefile.am:81: BZLIB does not appear in AM_CONDITIONAL

configure fails for me with the following error:

checking for special C compiler options needed for large files... no
checking for _FILE_OFFSET_BITS value needed for large files... no
./configure: line 4538: syntax error near unexpected token `z,Z,z,gzdirect,gzip'
./configure: line 4538: `eu_ZIPLIB(z,Z,z,gzdirect,gzip)'

I don't grok what autoconf is trying to tell me here.  Do I need a more
recent gzip libs or just new autotools?

-Bart

-- 
				WebSig: http://www.jukie.net/~bart/sig/
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
