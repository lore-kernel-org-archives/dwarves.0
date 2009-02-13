From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: ANNOUNCE: dwarves 1.7
Date: Fri, 13 Feb 2009 12:01:48 -0200
Message-ID: <20090213140148.GF5348@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Hi,

	After a year working only on the git repository at:

git://git.kernel.org/pub/scm/linux/kernel/git/acme/pahole

	I'm proud to announce dwarves 1.7, and without much ado, here
goes a list of changes:

- A CTF decoder based on work done by David S. Miller
	CTF stands for Compact C Type Format, a more compact debugging
	information found in the Solaris world.

- Handle DW_TAG_class_type, that is basically the same as
  DW_TAG_structure_type.

- Add support for showing classes with a prefix: --prefix_filter/-y
	Contributed by Dave Rigby

- Add support to DW_TAG_ptr_to_member_type, e.g.:

   - class QSize findSize(const classQGridLayoutPriv *, <ERROR>,
   + class QSize findSize(const classQGridLayoutPriv *, int QLayoutStruct::*, 
	
- Handle typedef definitions in functions

- Print the number of members in a struct/class

- Handle the empty base optimization trick (Zero sized C++ class)
	- Thanks to Dennis Lubert for mentioning this construct, now
	  lots of "BRAIN FART ALERT!" are gone

- codiff detect changes in the prototype even when function size doesn't change
    
    [acme@doppio pahole]$ codiff -V examples/tag-v6 examples/tag
    tag.c:
       | +0 # 42 -> 42, prototype: int (struct tag *self, int bar) ->
                                   unsigned int (struct tag *self, int bar)
     1 function changed, diff: +0

- pfunct: Implement --expand_types
    
    So that one can get an skeleton from where a function can be
    reimplemented, or a probe can be written to attach to a tracepoint.
    
    Right now it will only expand the types for
    struct/union/typedef/enumeration types, but it is a good start.
    
    $ pfunct --expand_types --function inet6_ioctl ipv6.ko > a.c
    $ echo "int main(void) { return 0; }" >> a.c
    $ gcc -Wall -g a.c -o a
    $ grep ^#include a.c
    $
    
    No errors, no includes.

- Reduce memory consumption by using a strings table that avoids duplication in
  multi object files such as vmlinux

- Speed up struct search by name

- Several minor bug fixes and infrastructure improvements.

- Initial man page for pahole

	The tarball is at http://fedorapeople.org/~acme/dwarves/.

	Please report problems to this list.

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
