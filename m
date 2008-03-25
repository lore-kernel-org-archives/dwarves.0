From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: "File has no CTF section."
Date: Tue, 25 Mar 2008 14:57:49 -0300
Message-ID: <20080325175749.GE22421@ghostprotocols.net>
References: <20080325152403.GK3247@iris.iucha.org> <20080325164103.GC22421@ghostprotocols.net> <20080325172413.GN3247@iris.iucha.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080325172413.GN3247-8+3tsXFunua1C7ntjtBYng@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florin Iucha <florin-zX39fKdjKLBeoWH0uzbU5w@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Tue, Mar 25, 2008 at 12:24:14PM -0500, Florin Iucha escreveu:
> Arnaldo,
> 
> Thanks for the quick reply!
> 
> On Tue, Mar 25, 2008 at 01:41:03PM -0300, Arnaldo Carvalho de Melo wrote:
> > > I have three object files: one is 'dwarves.o' from the pahole
> > > distribution, compiled with 'gcc -g'.  Another is 'foobar.o' from my
> > > own embedded application, compiled with the same compiler, on the same
> > > box [1].  The third object file is 'foobar.o' compiled with some
> > > version of compiler (Metrowerks?) for the embedded platform that we use.
> > > 
> > > If I use 'objdump -W' on all three files, I get heaps of information,
> > > including the structure definitions and other stuff.  Good.
> > 
> > can you try with:
> > 
> > # binutils
> > readelf -w i build/pahole
> > 
> > # elfutils
> > eu-readelf -w i build/pahole
> 
> Yup.  I get the same (or very similar) information.
> 
> > > The most puzzling thing is that two object files, compiled with the
> > > same compiler on the same machine have different enough DWARF data
> > > that one works with pahole and one doesn't.
> > > 
> > > What can I do to follow through with this?  Contact the elfutils
> > > maintainers?
> > 
> > Possibly, but can you make these two object files available somewhere?
> > I'd like to take a look...
> 
> See the attached file.  If you just compile it with 'gcc -g -c hello.c',
> pahole works fine on the resulting object file.  If at line 17 you change
> '#if 0' to '#if 1', pahole will complain about the lack of CTF (sorry,
> I didn't have time to pull your updates).

ACK, reproduced here, will investigate, strange indeed.

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
