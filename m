From: Arnaldo Carvalho de Melo <acme-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Subject: Re: new pahole packet structure
Date: Tue, 25 Dec 2007 18:12:26 -0200
Message-ID: <20071225201226.GA28007@ghostprotocols.net>
References: <20071224224156.GB24470@c3po.0xdef.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20071224224156.GB24470-RTrJC4xep8EqiUe4PmP5+w@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hagen Paul Pfeifer <hagen-GvnIQ6b/HdU@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Mon, Dec 24, 2007 at 11:41:57PM +0100, Hagen Paul Pfeifer escreveu:
> 
> First one! ;-)
> 
> I re-structured the packet layout, droped cmake support with a lightweight
> ./configure replacement and fix some new occurred compiler warnings.
> 
> Hello Arnaldo, I replaced the current build system with a more common
> configure && make && make install tuple. I drooped the cmake dependencies
> completely - now a hand-crafted configure script replace the functionality.
> There are some tiny issues for further releases: e.g. check for a valid
> elfutils package (version > elfutils-0.128), sqlite checks, etc.
> 
> The current version doesn't utilize any auto-helltools, but the fundamental
> structure is prepared. So if there is a demand in the future: no problem! ;)
> 
> I doesn't touched any functionality - no code is altered (expect some compiler
> warnings, due to additional compiler flags. But there are some additional
> warnings!).
> 
> The whole tarball is a packed git archive (master branch). The last commit was
> b4d6de9b6f6. You can pull (and merge) it therefore locally. ;)
> 
> 
> http://jauu.net/var/misc/exchange/pahole-new.tar.bz2

Doesn't work in my workstation:

[acme@doppio pahole]$ ./configure
*** configure-ng ***
checking for compiler...  /usr/lib64/ccache/gcc
checking for rm... /bin/rm
checking for ar... /usr/bin/ar
checking for ranlib... /usr/bin/ranlib
checking for ldconfig... which: no ldconfig in
(/usr/kerberos/bin:/usr/lib64/ccache:/usr/local/bin:/usr/bin:/bin:/usr/X11R6/bin:/home/acme/bin)
can't find ldconfig(1)!
[acme@doppio pahole]$

[acme@doppio pahole]$ ldconfig
bash: ldconfig: command not found
[acme@doppio pahole]$ l /sbin/ldconfig
-rwxr-xr-x 1 root root 694760 2007-10-18 06:31 /sbin/ldconfig*
[acme@doppio pahole]$

- Arnaldo
-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
