From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: building pahole on Ubuntu 8.04 AMD64
Date: Thu, 20 Mar 2008 17:51:09 -0300
Message-ID: <20080320205109.GE4034@ghostprotocols.net>
References: <20080320200244.GS3247@iris.iucha.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080320200244.GS3247-8+3tsXFunua1C7ntjtBYng@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florin Iucha <florin-zX39fKdjKLBeoWH0uzbU5w@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Thu, Mar 20, 2008 at 03:02:44PM -0500, Florin Iucha escreveu:
> Hi Arnaldo,
> 
> I'm trying to build the pahole tools on Ubuntu 8.04 AMD64 and I'm
> getting a build error:
> 
> $ make
> [  5%] Building C object CMakeFiles/dwarves.dir/dwarves.o
> [ 11%] Building C object CMakeFiles/dwarves.dir/ctf_loader.o
> [ 17%] Building C object CMakeFiles/dwarves.dir/libctf.o
> [ 23%] Building C object CMakeFiles/dwarves.dir/dwarf_loader.o
> Linking C shared library libdwarves.so
> /usr/bin/ld:
> /usr/lib/gcc/x86_64-linux-gnu/4.2.3/../../../../lib64/libdw.a(dwarf_begin.o):
> relocation R_X86_64_32 against `a local symbol' can not be used when
> making a shared object; recompile with -fPIC
> /usr/lib/gcc/x86_64-linux-gnu/4.2.3/../../../../lib64/libdw.a: could
> not read symbols: Bad value
> collect2: ld returned 1 exit status
> make[2]: *** [libdwarves.so.1.0.0] Error 1
> make[1]: *** [CMakeFiles/dwarves.dir/all] Error 2
> make: *** [all] Error 2
> 
> I grepped for -fPIC and it seems to be passed on the command line for
> many of the sources.  I'm using libdw-dev version 0.131-3 and binutils
> 2.18.1~cvs20080103-0uubuntu1 as packaged by Ubuntu.

Strange, looks like you have libdw-dev 32bits installed? can you check
that? I.e. that cmake is not mixing somehow libraries?

Also I'm adding dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org to the CC list, you don't have to
subscribe, but it would be a good idea, there are more people there that
I know have built this code on ubuntu/debian and that could be of more
help than me, that use debian rarely :-\

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
