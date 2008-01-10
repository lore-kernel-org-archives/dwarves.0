From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: eat your own dog food?
Date: Thu, 10 Jan 2008 14:39:59 -0200
Message-ID: <20080110163959.GJ22437@ghostprotocols.net>
References: <1199968968.4438.49.camel@localhost> <20080110133926.GF22437@ghostprotocols.net> <1199973341.4438.56.camel@localhost> <20080110140635.GG22437@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080110140635.GG22437-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jamal <hadi-fAAogVwAN2Kw5LPnMra/2Q@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Em Thu, Jan 10, 2008 at 12:06:35PM -0200, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Jan 10, 2008 at 08:55:41AM -0500, jamal escreveu:
> > ok, cool - so i should be able say something like "--add_size 64-bit"
> > and it will follow something like the MIPS EABI i posted earlier? [I
> > think x86_64 will work the same way too if i am not mistaken].
> 
> Exactly, you will be able to change the addr_size, I think that there is
> even code that can be right away used for that, lemme check.

First stab, doesn't handles unions shrinking because the largest member
shrunk, and handles only binaries built for 64 bits (or bigger) having
it addr_size (word_size) shrinking.

So:

[acme@doppio pahole]$ file build/pahole
build/pahole: ELF 64-bit LSB executable, x86-64, version 1 (SYSV),
dynamically linked (uses shared libs), for GNU/Linux 2.6.9, not stripped

A 64 bit app:

[acme@doppio pahole]$ build/pahole -C structure build/pahole
struct structure {
        struct list_head  node;                 /*     0    16 */
        struct class *    class;                /*    16     8 */
        const struct cu  *cu;                   /*    24     8 */
        uint32_t          nr_files;             /*    32     4 */
        uint32_t          nr_methods;           /*    36     4 */

        /* size: 40, cachelines: 1 */
        /* last cacheline: 40 bytes */
};
[acme@doppio pahole]$

Lets change the word_size from 8 to 4 (64 bits -> 32 bits)

[acme@doppio pahole]$ build/pahole -w 4 -C structure build/pahole
struct structure {
	struct list_head  node;                 /*     0     8 */
	struct class *    class;                /*     8     4 */
	const struct cu  *cu;                   /*    12     4 */
	uint32_t          nr_files;             /*    16     4 */
	uint32_t          nr_methods;           /*    20     4 */

	/* size: 24, cachelines: 1 */
	/* last cacheline: 24 bytes */
};

See that it recursively notices structs shrinking, because...

[acme@doppio pahole]$ build/pahole -C list_head build/pahole
struct list_head {
	struct list_head *next;                 /*     0     8 */
	struct list_head *prev;                 /*     8     8 */

	/* size: 16, cachelines: 1 */
	/* last cacheline: 16 bytes */
};

When using a 4 bytes word_size:

[acme@doppio pahole]$ build/pahole -w 4 -C list_head build/pahole
struct list_head {
	struct list_head *next;                 /*     0     4 */
	struct list_head *prev;                 /*     4     4 */

	/* size: 8, cachelines: 1 */
	/* last cacheline: 8 bytes */
};

Lets go all the way back to the 8088:

[acme@doppio pahole]$ build/pahole -w 1 -C structure build/pahole
struct structure {
	struct list_head           node;                 /*     0     2 */
	struct class *             class;                /*     2     1 */
	const struct cu  *         cu;                   /*     3     1 */
	uint32_t                   nr_files;             /*     4     4 */
	uint32_t                   nr_methods;           /*     8     4 */

	/* size: 12, cachelines: 1 */
	/* last cacheline: 12 bytes */
};

Not really because we're only change 'long' from the original word size
to the one specified.

Please test and find the missing bits for me :-)

- Arnaldo

diff --git a/dwarves.h b/dwarves.h
index f5edb65..526335f 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -107,6 +107,7 @@ struct type {
 	struct list_head node;
 	Dwarf_Off	 specification;
 	size_t		 size;
+	size_t		 size_diff; /* use when changing cu->addr_size */
 	uint16_t	 nr_members;
 	uint8_t		 declaration; /* only one bit used */
 	uint8_t		 definition_emitted:1;
diff --git a/pahole.c b/pahole.c
index 4de68f4..c4f0c12 100644
--- a/pahole.c
+++ b/pahole.c
@@ -21,6 +21,7 @@
 
 static uint8_t class__include_anonymous;
 static uint8_t class__include_nested_anonymous;
+static uint8_t word_size, original_word_size;
 
 static char *class__exclude_prefix;
 static size_t class__exclude_prefix_len;
@@ -387,6 +388,83 @@ static int cu_unique_iterator(struct cu *cu, void *cookie)
 	return cu__for_each_tag(cu, unique_iterator, cookie, tag__filter);
 }
 
+void class__realign_LP(struct tag *tag, struct cu *cu)
+{
+	struct tag *tag_pos;
+	struct class *self = tag__class(tag);
+	size_t word_size_diff;
+	size_t orig_size = self->type.size;
+
+	if (original_word_size > word_size)
+		word_size_diff = original_word_size - word_size;
+	else
+		word_size_diff = word_size - original_word_size;
+
+	type__for_each_tag(tag__type(tag), tag_pos) {
+		struct tag *type;
+		size_t diff = 0;
+
+		/* we want only data members, i.e. with byte_offset attr */
+		if (tag_pos->tag != DW_TAG_member &&
+		    tag_pos->tag != DW_TAG_inheritance)
+		    	continue;
+
+		type = cu__find_tag_by_id(cu, tag_pos->type);
+		switch (type->tag) {
+		case DW_TAG_base_type: {
+			struct base_type *bt = tag__base_type(tag_pos);
+
+			if (strcmp(bt->name, "long int") != 0)
+				break;
+			/* fallthru */
+		}
+		case DW_TAG_pointer_type:
+			diff = word_size_diff;
+			break;
+		case DW_TAG_structure_type:
+			diff = tag__type(type)->size_diff;
+			break;
+		}
+
+		if (diff != 0 &&
+		    original_word_size > word_size) {
+			self->type.size -= diff;
+			class__subtract_offsets_from(self, cu,
+						     tag__class_member(tag_pos), diff);
+		}
+	}
+
+	if (original_word_size > word_size)
+		self->type.size_diff = orig_size - self->type.size;
+	else
+		self->type.size_diff = self->type.size - orig_size;
+}
+
+static int tag_fixup_word_size_iterator(struct tag *tag, struct cu *cu,
+					void *cookie __unused)
+{
+	switch (tag->tag) {
+	case DW_TAG_base_type: {
+		struct base_type *bt = tag__base_type(tag);
+
+		if (strcmp(bt->name, "long int") == 0)
+			bt->size = word_size;
+	}
+		break;
+	case DW_TAG_structure_type:
+		class__realign_LP(tag, cu);
+		break;
+	}
+	return 0;
+}
+
+static int cu_fixup_word_size_iterator(struct cu *cu, void *cookie)
+{
+	original_word_size = cu->addr_size;
+	cu->addr_size = word_size;
+	return cu__for_each_tag(cu, tag_fixup_word_size_iterator, cookie, NULL);
+}
+
 static struct tag *nr_methods__filter(struct tag *tag, struct cu *cu __unused,
 				      void *cookie __unused)
 {
@@ -652,6 +730,12 @@ static const struct argp_option pahole__options[] = {
 		.doc  = "be verbose",
 	},
 	{
+		.name = "word_size",
+		.key  = 'w',
+		.arg  = "WORD_SIZE",
+		.doc  = "change the arch word size to WORD_SIZE"
+	},
+	{
 		.name = NULL,
 	}
 };
@@ -696,6 +780,7 @@ static error_t pahole__options_parser(int key, char *arg,
 	case 'T': formatter = nr_definitions_formatter;	break;
 	case 't': separator = arg[0];			break;
 	case 'V': global_verbose = 1;			break;
+	case 'w': word_size = atoi(arg);		break;
 	case 'X': cu__exclude_prefix = arg;
 		  cu__exclude_prefix_len = strlen(cu__exclude_prefix);
 							break;
@@ -738,6 +823,9 @@ int main(int argc, char *argv[])
 
 	dwarves__init(cacheline_size);
 
+	if (word_size != 0)
+		cus__for_each_cu(cus, cu_fixup_word_size_iterator, NULL, NULL);
+
 	if (class_dwarf_offset != 0) {
 		struct cu *cu;
 		struct tag *tag = cus__find_tag_by_id(cus, &cu,
-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
