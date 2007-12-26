From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: new pahole packet structure
Date: Wed, 26 Dec 2007 15:49:28 -0200
Message-ID: <20071226174928.GC28007@ghostprotocols.net>
References: <20071224224156.GB24470@c3po.0xdef.net> <20071225201226.GA28007@ghostprotocols.net> <20071226171437.GA16456@c3po.0xdef.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20071226171437.GA16456-RTrJC4xep8EqiUe4PmP5+w@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hagen Paul Pfeifer <hagen-GvnIQ6b/HdU@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Wed, Dec 26, 2007 at 06:14:38PM +0100, Hagen Paul Pfeifer escreveu:
> * Arnaldo Carvalho de Melo | 2007-12-25 18:12:26 [-0200]:
> 
> 
> >[acme@doppio pahole]$ ldconfig
> 
> Fixed!
> 
> http://jauu.net/var/misc/exchange/pahole-new.tar.bz2
> 
> 
> The fix isn't yet git commited - I want a clean history. So Arnaldo, check
> the new structure and post some comment! ;-)

Next problem:

[acme@doppio pahole]$ ./configure
*** configure-ng ***
checking for compiler...  /usr/lib64/ccache/gcc
checking for rm... /bin/rm
checking for ar... /usr/bin/ar
checking for ranlib... /usr/bin/ranlib
checking for mkdir... /bin/mkdir
checking for install... /usr/bin/install
checking for alloca... yes
checking for posix_memalign support... yes
checking for libdw... no
 Configure doesn't found libdw. Libdw is an essential package
 for this package! If this library (or header files) are not
 installed in a common directory you can specify it via
 --libdir=/PATH/TO/LIBRARY and/or --inludedir=/PATH/TO/HEADER
 Tip: libdw is bundled with elfutils
 URL: ftp://sources.redhat.com/pub/systemtap/elfutils/
rmdir: /tmp/tmp.cGoUy28831: Directory not empty
[acme@doppio pahole]$

On a Fedora 8 system:

[acme@doppio pahole]$ rpm -ql elfutils-devel
/usr/include/dwarf.h
/usr/include/elfutils
/usr/include/elfutils/elf-knowledge.h
/usr/include/elfutils/libdw.h
/usr/include/elfutils/libdwfl.h
/usr/include/elfutils/libebl.h
/usr/lib64/libdw.so
/usr/lib64/libebl.a
[acme@doppio pahole]$ rpm -ql elfutils-libelf-devel
/usr/include/gelf.h
/usr/include/libelf.h
/usr/include/nlist.h
/usr/lib64/libelf.so
[acme@doppio pahole]$

- Arnaldo
-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
