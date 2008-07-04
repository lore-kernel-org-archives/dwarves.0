From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: pahole --contains explained
Date: Fri, 4 Jul 2008 17:00:16 -0300
Message-ID: <20080704200016.GC13396@ghostprotocols.net>
References: <1215098881.16861.29.camel@edge.interactivedata.com> <20080703170834.GA13056@ghostprotocols.net> <1215158052.16861.43.camel@edge.interactivedata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1215158052.16861.43.camel-udH60D+1cVSKf2Id4j40wZWRH6rljmCt@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dennis Lubert <plasmahh-hi6Y0CQ0nG0@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Fri, Jul 04, 2008 at 09:54:12AM +0200, Dennis Lubert escreveu:
> Am Donnerstag, den 03.07.2008, 14:08 -0300 schrieb Arnaldo Carvalho de Melo:
> > > - There could be some glob or regexp style substring match for types.
> > > >From the --help I thought that -i was for this, but I could not get it
> > > to match even on substrings... Am I maybe doing something wrong?

> > Regexps not supported yet, just prefixes:

> > [acme@doppio pahole]$ pahole --sizes --separator=, build/pahole | grep arg
> > argp_child,32,1
> > argp,56,0
> > argp_state,96,1
> > argp_option,48,2
> > [acme@doppio pahole]$ pahole --sizes --separator=, --exclude arg build/pahole | grep arg
> > [acme@doppio pahole]$

> Ah ok, just overlooked -y/-x ... but then I am a bit confused on what -i
> means. Giving it parts of the class, prefixes or even the whole name
> leads to no result here... 

-i == --contains

[acme@doppio pahole]$ pahole -i tag build/pahole 
parameter
ftype
lexblock
class_member
array_type
base_type
namespace
[acme@doppio pahole]$

Now lets look at some of these classes:

[acme@doppio pahole]$ pahole -C ftype build/pahole 
struct ftype {
	struct tag       tag;            /*     0    64 */

	/* --- cacheline 1 boundary (64 bytes) --- */

	struct list_head parms;          /*    64    16 */
	uint16_t         nr_parms;       /*    80     2 */
	uint8_t          unspec_parms;   /*    82     1 */

	/* size: 88, cachelines: 2, members: 4 */
	/* padding: 5 */
	/* last cacheline: 24 bytes */
};

[acme@doppio pahole]$ pahole -C class_member build/pahole
struct class_member {
	struct tag       tag;            /*     0    64 */

	/* --- cacheline 1 boundary (64 bytes) --- */

	char *           name;           /*    64     8 */
	uint32_t         offset;         /*    72     4 */
	uint8_t          bit_offset;     /*    76     1 */
	uint8_t          bit_size;       /*    77     1 */
	uint8_t          bit_hole;       /*    78     1 */
	uint8_t          bitfield_end:1; /*    79: 7  1 */
	uint8_t          visited:1;      /*    79: 6  1 */
	uint8_t          accessibility:2;/*    79: 4  1 */
	uint8_t          virtuality:2;   /*    79: 2  1 */

	/* XXX 2 bits hole, try to pack */

	uint16_t         hole;           /*    80     2 */

	/* size: 88, cachelines: 2, members: 11 */
	/* bit holes: 1, sum bit holes: 2 bits */
	/* padding: 6 */
	/* last cacheline: 24 bytes */
};

[acme@doppio pahole]$ pahole -C parameter build/pahole
struct parameter {
	struct tag       tag;            /*     0    64 */

	/* --- cacheline 1 boundary (64 bytes) --- */

	char *           name;           /*    64     8 */
	Dwarf_Off        abstract_origin;/*    72     8 */

	/* size: 80, cachelines: 2, members: 3 */
	/* last cacheline: 16 bytes */
};

See? All of these classes (structs) contains the specified class
(struct) "tag".

And if you specify --recursive together with -i/--contains you'll get
something more interesting:

[acme@doppio pahole]$ pahole --recursive --contains tag build/pahole 
parameter
ftype
  function
lexblock
  function
class_member
array_type
base_type
namespace
  type
    class
[acme@doppio pahole]$

See? 'class' is-a 'type' is-a 'namespace' is-a 'tag'.

To see it more clearly use --expand_types:

[acme@doppio pahole]$ pahole -C class --expand_types build/pahole
struct class {
	struct type {
		struct namespace {
			struct tag {
				struct list_head {
					struct list_head * next;                         /*     0     8 */
					struct list_head * prev;                         /*     8     8 */
				} node; /*     0    16 */
				struct list_head {
					struct list_head * next;                         /*    16     8 */
					struct list_head * prev;                         /*    24     8 */
				} hash_node; /*    16    16 */
				/* typedef Dwarf_Off -> GElf_Off -> Elf64_Off -> uint64_t */ long unsigned int type; /*    32     8 */
				/* typedef Dwarf_Off -> GElf_Off -> Elf64_Off -> uint64_t */ long unsigned int id; /*    40     8 */
				const char  * decl_file;                                 /*    48     8 */
				/* typedef uint16_t */ short unsigned int decl_line;     /*    56     2 */
				/* typedef uint16_t */ short unsigned int tag;           /*    58     2 */
				/* typedef uint16_t */ short unsigned int refcnt;        /*    60     2 */
				/* typedef uint16_t */ short unsigned int recursivity_level; /*    62     2 */
				/* --- cacheline 1 boundary (64 bytes) --- */
			} tag; /*     0    64 */
			/* --- cacheline 1 boundary (64 bytes) --- */
			const char  * name;                                              /*    64     8 */
			struct list_head {
				struct list_head * next;                                 /*    72     8 */
				struct list_head * prev;                                 /*    80     8 */
			} tags; /*    72    16 */
			/* typedef uint16_t */ short unsigned int nr_tags;               /*    88     2 */
		} namespace; /*     0    96 */

		/* XXX last struct has 6 bytes of padding */

		/* --- cacheline 1 boundary (64 bytes) was 32 bytes ago --- */
		struct list_head {
			struct list_head * next;                                         /*    96     8 */
			struct list_head * prev;                                         /*   104     8 */
		} node; /*    96    16 */
		/* typedef Dwarf_Off -> GElf_Off -> Elf64_Off -> uint64_t */ long unsigned int  specification; /*   112     8 */
		/* typedef size_t */ long unsigned int  size;                            /*   120     8 */
		/* --- cacheline 2 boundary (128 bytes) --- */
		/* typedef size_t */ long unsigned int  size_diff;                       /*   128     8 */
		/* typedef uint16_t */ short unsigned int nr_members;                    /*   136     2 */
		/* typedef uint8_t */ unsigned char      declaration;                    /*   138     1 */
		/* typedef uint8_t */ unsigned char      definition_emitted:1;           /*   139: 7  1 */
		/* typedef uint8_t */ unsigned char      fwd_decl_emitted:1;             /*   139: 6  1 */
		/* typedef uint8_t */ unsigned char      resized:1;                      /*   139: 5  1 */
	} type; /*     0   144 */

	/* XXX last struct has 4 bytes of padding */

	/* --- cacheline 2 boundary (128 bytes) was 16 bytes ago --- */
	struct list_head {
		struct list_head * next;                                                 /*   144     8 */
		struct list_head * prev;                                                 /*   152     8 */
	} vtable; /*   144    16 */
	/* typedef uint16_t */ short unsigned int         nr_vtable_entries;             /*   160     2 */
	/* typedef uint8_t */ unsigned char              nr_holes;                       /*   162     1 */
	/* typedef uint8_t */ unsigned char              nr_bit_holes;                   /*   163     1 */
	/* typedef uint16_t */ short unsigned int         padding;                       /*   164     2 */
	/* typedef uint8_t */ unsigned char              bit_padding;                    /*   166     1 */

	/* XXX 1 byte hole, try to pack */

	void *                     priv;                                                 /*   168     8 */

	/* size: 176, cachelines: 3, members: 8 */
	/* sum members: 175, holes: 1, sum holes: 1 */
	/* paddings: 1, sum paddings: 4 */
	/* last cacheline: 48 bytes */
};

Try --expand_pointers at home, say on struct task_struct on the Linux
kernel 8-)

For the lazy ones:

[acme@doppio pahole]$ pahole -C task_struct --expand_types --expand_pointers vmlinux >

http://oops.ghostprotocols.net/dwarves/pahole/vmlinux-expand_pointers-task_struct.txt
http://vger.kernel.org/~acme/vmlinux-expand_pointers-task_struct.txt

- Arnaldo
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
