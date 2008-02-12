From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: speedup in tag lookup using hash tables
Date: Mon, 11 Feb 2008 22:03:10 -0200
Message-ID: <20080212000310.GB4157@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen-pxSi+dnQzZMxHbG02/KK1g@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Hi Ilpo,

	Today I optimized the dwarves a bit by using a per object file
hash table for tag lookup, it yelded almost 50% speedup on pahole when
running on a vmlinux file :-)

	codiff doesn't makes that much tag lookups, so we didn't got
much improvements there, but I'm doing experiments on dead tag elimination
that probably will help a lot there, but for that I have first to grok
Ulrich Drepper's libdisasm to find out what are the tags that are really
used by looking at accesses to register indexed memory areas that use as
a base pointer what is in local/global variables and function
parameters.

	This also will provide the basis for detecting access patterns
that will ultimatelly allow libdwarves_reorganize to do struct
reorganizations to improve locality of reference, etc.

	Please take a look at v1.6 that I pushed today and tell me your
impressions.

Regards,

- Arnaldo
