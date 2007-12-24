From: Hagen Paul Pfeifer <hagen-GvnIQ6b/HdU@public.gmane.org>
Subject: new pahole packet structure
Date: Mon, 24 Dec 2007 23:41:57 +0100
Message-ID: <20071224224156.GB24470@c3po.0xdef.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org


First one! ;-)

I re-structured the packet layout, droped cmake support with a lightweight
./configure replacement and fix some new occurred compiler warnings.

Hello Arnaldo, I replaced the current build system with a more common
configure && make && make install tuple. I drooped the cmake dependencies
completely - now a hand-crafted configure script replace the functionality.
There are some tiny issues for further releases: e.g. check for a valid
elfutils package (version > elfutils-0.128), sqlite checks, etc.

The current version doesn't utilize any auto-helltools, but the fundamental
structure is prepared. So if there is a demand in the future: no problem! ;)

I doesn't touched any functionality - no code is altered (expect some compiler
warnings, due to additional compiler flags. But there are some additional
warnings!).

The whole tarball is a packed git archive (master branch). The last commit was
b4d6de9b6f6. You can pull (and merge) it therefore locally. ;)


http://jauu.net/var/misc/exchange/pahole-new.tar.bz2


Hagen

-- 
Hagen Paul Pfeifer <hagen-GvnIQ6b/HdU@public.gmane.org>  ||  http://jauu.net/
Telephone: +49 174 5455209           ||  Key Id: 0x98350C22
Key Fingerprint: 490F 557B 6C48 6D7E 5706 2EA2 4A22 8D45 9835 0C22
Always in motion, the future is. 
-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
