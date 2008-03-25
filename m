From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: "File has no CTF section."
Date: Tue, 25 Mar 2008 13:41:03 -0300
Message-ID: <20080325164103.GC22421@ghostprotocols.net>
References: <20080325152403.GK3247@iris.iucha.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080325152403.GK3247-8+3tsXFunua1C7ntjtBYng@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florin Iucha <florin-zX39fKdjKLBeoWH0uzbU5w@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Tue, Mar 25, 2008 at 10:24:03AM -0500, Florin Iucha escreveu:
> I have manually built the pahole&co on Ubuntu 8.04 beta, and I'm
> trying to use it on a few source files that I have, and I keep getting
> the "File has no CTF section." error message.

Argh, I have to fix that, this just means that the file doesn't have
DWARF info _nor_ CTF info.
 
> I have three object files: one is 'dwarves.o' from the pahole
> distribution, compiled with 'gcc -g'.  Another is 'foobar.o' from my
> own embedded application, compiled with the same compiler, on the same
> box [1].  The third object file is 'foobar.o' compiled with some
> version of compiler (Metrowerks?) for the embedded platform that we use.
> 
> If I use 'objdump -W' on all three files, I get heaps of information,
> including the structure definitions and other stuff.  Good.

can you try with:

# binutils
readelf -w i build/pahole

# elfutils
eu-readelf -w i build/pahole
 
> If I use 'pahole' on all three files, I get the structure information
> for the first one, but 'File has no CTF section.' for the other two,
> even though the first and second object files are built with the same
> compiler!  And even though both 'foobar.o' file contain heaps of
> debugging information (objdump -W yields 14K lines for the gcc-4.2
> build and 43K lines for the native embedded build).
> 
> I grepped for 'File has no CTF section.' in the dwarves sources and it
> only occurs in the 'ctf_loader.c' file - it seems that the code is
> looking for a section named ".SUNW_ctf" (in function parse_elf which
> is only called from ctf__load which is only called from cus__loadfl,
> if the dwarf__load returns some empty list)
> 
> It seems that either 'dwfl_getdwarf/dwarf_nextcu' fails to find the
> data.  At any rate, the error message (about the missing CTF section)
> is quite misleading.  I'm not sure where the bug is (although my
> limited exploring seems to point to the 'elfutils' package.  Ubuntu
> distributes version 0.131, which seems to be the latest published version.

indeed, misleading it is, fixing now... done
 
> The most puzzling thing is that two object files, compiled with the
> same compiler on the same machine have different enough DWARF data
> that one works with pahole and one doesn't.
> 
> What can I do to follow through with this?  Contact the elfutils
> maintainers?

Possibly, but can you make these two object files available somewhere?
I'd like to take a look...
 
> Thanks,
> florin
> 
> 1: The compiler version is 'gcc version 4.2.3 (Ubuntu 4.2.3-2ubuntu6)'
> 
> -- 
> Bruce Schneier expects the Spanish Inquisition.
>       http://geekz.co.uk/schneierfacts/fact/163


--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
