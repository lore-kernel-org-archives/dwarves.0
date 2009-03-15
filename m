From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFT] Request for testing
Date: Sun, 15 Mar 2009 00:21:38 -0300
Message-ID: <20090315032138.GB22651@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Hi guys,

	I'm back working on these tools trying to get the in memory
representation to be closer to CTF than to DWARF, i.e.:

o  class_member instances will not have bit_size/bit_offset, that will
   have to be inferred from the base_type with a number of bits less than
   what it would be in DWARF land

o the strings for quite a while already are just indexes into a table
  that will then be compressed when encoding in CTF, and at some point
  will be loaded from CTF directly, without further processing

o The types are being recoded, i.e. cu->types_table, uint16_t entries
  instead of Dwarf_Off types that have to be looked up on a hash table,
  etc.

	Right now I'm trying to insert new base types for the bitfields,
after that we'll be almost there to just dump the in memory
representation into a CTF file. 

	I intend to use the buildid to name a file in a ~/.pahole/
ccache like hierarchy so that the next time we try to load a DWARF
section we instead short circuit to the buildid named file in the cache
to get much, much faster loading.

	Aside from that there are many more improvements, but as we all
know if we do too many changes in one go, as bold as we may feel, bugs
may creep in, so:

	Please, please try what is in the git repo right now, and report
to this list any regressions.

	I have some regression tests where I process with the previously
released version lots of CTF and DWARF encoded C and C++ object files
and then with the new version and finally a diff to see if anything
went bazoo, and all I can say is that right now all I can see is faster
processing, a helluva smaller memory footprint and more correct output :-)

	But if you can prove me wrong, I'll do my best to get that
fixed, and that I guess is a good deal, huh?

	If all goes well I'll tag 1.8 and then get back to getting the
dwarves CTFicated.

Thanks a lot guys,

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
