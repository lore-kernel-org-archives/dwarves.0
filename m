From: Arnaldo Carvalho de Melo <acme-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: ANOUNCE: pahole & the dwarves 1.8
Date: Sun, 6 Dec 2009 16:22:36 -0200
Message-ID: <20091206182236.GB4337@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Daniel Gollub <dgollub-l3A5Bk7waGM@public.gmane.org>, Diego 'Flameeyes' =?iso-8859-1?Q?Petten=F2?= <flameeyes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Zimmermann <tdz-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: dwarves@vger.kernel.org

After a long time without a new release because I was trying to get the CTF
support completed, and due to the very strong gravity force in the Linux kernel
perf tools, here it is 1.8, with lots of performance improvements, bug fixes
and changes to better use these tools in scripts.

For full details please take a look at the git changesets, repo available at:

http://git.kernel.org/?p=linux/kernel/git/acme/pahole.git

Tarball available at:

http://fedorapeople.org/~acme/dwarves/dwarves-1.8.tar.bz2

- Arnaldo

pahole:

. Allow list of structs to be passed to pahole.

	E.g.: 'pahole -C str_node,strings'

  Suggested by Zack Weinberg <zweinberg-4eJtQOnFJqFBDgjK7y7TUQ@public.gmane.org>, for scripting.

. Introduce --hex to print offsets and sizes in hexadecimal

codiff:

. Improve detection of removal and addition of members in structs

. Detect changes in padding and the number of holes/bit_holes

pfunct:

. --no_parm_names

    Because CTF doesn't encodes the names of the parameters and I want to
    test the upcoming CTF function section code in ctftwdiff.

. pfunct --addr

    Using an rbtree to find in which function the given addr is.

libdwarves:

. Greatly reduce the data structures footprint and lookup by recoding
  the IDs as short integers, that was done to facilitate support for CTF
  but benefited the core libraries greatly.

. Handle GCC support for vector instructions

    So now it recognizes, as printed by pdwtags:

    908 typedef int __m64 __attribute__ ((__vector_size__ (8))); size: 8
    909 int         array __attribute__ ((__vector_size__ (8))); size: 8
    910 int         array __attribute__ ((__vector_size__ (4))); size: 4
    911 short int   array __attribute__ ((__vector_size__ (2))); size: 2
    912 char        array __attribute__ ((__vector_size__ (1))); size: 1

. Destructors were added so that no leaks are left if this library is to
  be used in other tools that don't end the program when done using this lib.

. Allow the tools to pass a callback that is used after loading each object
  file (CU/Compile Unit), so that we can more quickly find tags and stop
  the processing sooner, or at least delete the CU if it doesn't have anything
  needed by the tool. This _greatly_ speeded up most of the tools.

. Tools now can pass a debug format "path", specifying the order it wants to
  try, so that if a file have both DWARF and CTF, specifying 'ctf,dwarf' will
  use the CTF info.

. Now the formatting routines are in a separate file, dwarves_fprintf.c. This
  was done for organizational purposes but also to pave the way for multiple
  formatting backends, so that we can print, for instance, in CSV the structs,
  for easier scripting like done by several folks out there.

. Handle volatile typedef bitfields, like:

    struct _GClosure {
            volatile guint ref_count:15;    /* 0:17  4 */
            volatile guint meta_marshal:1;  /* 0:16  4 */
            volatile guint n_guards:1;      /* 0:15  4 */

. Load java 'interfaces' as a struct/class.

. Fix buffer expansion bug, detected thanks to boost that provided things like:

        virtual int undefine(class grammar_helper<boost::spirit::grammar<boost::detail::graph::dot_skipper, boost::spirit::parser_context<boost::spirit::nil, class grammar<boost::detail::graph::dot_skipper, boost::spirit::parser_context<boost::spirit::nil_t> > *); /* linkage=_ZN5boost6spirit4impl14grammar_helperINS0_7grammarINS_6detail5graph11dot_skipperENS0_14parser_contextINS0_5nil_tEEEEES6_NS0_7scannerINS0_10multi_passISt16istream_i */

. Allow optional addr information loading, speeding up some apps that don't
  use such addresses (or in modes where addrs aren't used) such as pahole.

. Use a obstacks, speeding up apps as measured with the perf tools.

. Support zero sized arrays in the middle of a struct.

. Fix padding calculation in the reorganize routines.

. Fix bitfield demotion in the reorganize routines.

. Support "using" pointing to data members (C++).

. Properly support pointers to const, reported by Jan Engelhardt <jengelh-nopoi9nDyk+ELgA04lAiVw@public.gmane.org>:

. Support more compact DW_AT_data_member_location form, pointed out by Mark
  Wielaard <mjw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> and reported by Mike Snitzer <snitzer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Experimental CTF support:

libdwarves was reorganized so that it can support multiple debugging formats,
with the first one being supported being the Compact C Type Format that comes
from the OpenSolaris world.

David S. Miller contributed an initial CTF decoder and from there I wrote an
encoder.

To test this a regression testing harness (regtest in the sources) that will
take files with DWARF info and from there encode its contents in CTF in another
ELF section in the same file (.SUN_ctf).  Then it will decode both the DWARF
and CTF sections and compare the results for pahole running with some new
flags that cope with some subtleties in the way CTF encodes things.

  --flat_arrays

	We have just one dimension in CTF, with the total number of entries,
	in DWARF we can express this, but not in CTF:

	__u8            addr[0][6];    /*   4  0 */

	So --flat_arrays will show it as:

	__u8            addr[0];       /*   4  0 */

  --show_private_classes
  --fixup_silly_bitfields

	To cope with things like 'char foo:8' that since CTF has only the
	number of bits, can't be expressed as we don't know if it is a
	bitfield or just a char without the ':8' suffix.

  --first_obj_only

	Look only at the first object file in a file with multiple object
	files, like vmlinux. This is because the CTF support is not complete yet,
	needing the merging of types in multiple object files to be done.

  --classes_as_structs

	CTF has only a type for structs, not for classes like DWARF (DW_TAG_class_type
	is not present in CTF), so print them all as 'struct'.

Running with the above limitations produce just a few mismatches, related to
packed structs and enumerations bitfields.
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
