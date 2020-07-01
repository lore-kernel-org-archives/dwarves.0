From: Arnaldo Carvalho de Melo <acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: pahole and parsing data: --count
Date: Wed, 1 Jul 2020 08:25:34 -0300
Message-ID: <20200701112534.GQ29008@kernel.org>
References: <20200623165646.GA2251@redhat.com>
 <e52cf45d-311f-85c7-d358-5592d3666092@redhat.com>
 <20200624173038.GC20203@kernel.org>
 <20200624185748.GA16165@redhat.com>
 <20200624190716.GA4139@redhat.com>
 <a5238972-e36e-3abe-aa14-5dcca58c46fb@redhat.com>
 <20200625113816.GA29008@kernel.org>
 <20200625114129.GB29008@kernel.org>
 <20200625160326.GA10325@kernel.org>
 <0eae329c-d448-4d04-c240-0850a93278a5@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0eae329c-d448-4d04-c240-0850a93278a5-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Joe Lawrence <joe.lawrence-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: dwarves@vger.kernel.org

Hi,

	I've been implementing pretty printing in pahole:

[acme@quaco pahole]$ git log --oneline v1.17..
5631fdcea1bb (HEAD -> master, acme.korg/pretty, acme.korg/master) pahole: Introduce --count, just like dd's
272bc75024b4 man-pages: Add information about stdin raw data pretty printing
66835f9e190c pahole: Add support for base type arrays
1a67d6e70090 pahole: Factor out base_type__fprintf_value()
6fb98aa1209f pahole: Support char arrays when dumping from stdin
a231d00f8d08 pahole: Print comma at the end of field name + field value
1b2cdda38c0a dwarves: Introduce tag__is_array()
a83313fb2252 pahole: Pretty print base types in structs from stdin
cc65946e3068 dwarves: Adopt tag__is_base_type() from ctrace.c
d8079c6d373a pahole: Hex dump a type from stdio when it isn't a tty
38109ab45fe0 spec: Fix date
[acme@quaco pahole]$

	The latest changeset shows what this is about, see its example
below, please help testing and suggesting whatever needs you have
regarding pretty printing.

	Now to implement --skip.

Regards,

- Arnaldo

From 5631fdcea1bbe2bcb8c673ff0bb0fdc9fdc2875d Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date: Wed, 1 Jul 2020 08:14:58 -0300
Subject: [PATCH] pahole: Introduce --count, just like dd's

  $ objcopy -O binary --only-section=.altinstructions ~/git/build/v5.7-rc2+/vmlinux .altinstructions
  $ pahole --count 2 alt_instr  < .altinstructions
  {
  	.instr_offset = 0xffffffffffe0e690,
  	.repl_offset = 0x4873,
  	.cpuid = 0x70,
  	.instrlen = 0x5,
  	.replacementlen = 0x5,
  	.padlen = 0,
  },
  {
  	.instr_offset = 0xffffffffffe0e683,
  	.repl_offset = 0x486b,
  	.cpuid = 0x129,
  	.instrlen = 0x5,
  	.replacementlen = 0x5,
  	.padlen = 0,
  },
  $

Signed-off-by: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dwarves.h          |  2 ++
 man-pages/pahole.1 |  8 +++++++-
 pahole.c           | 13 +++++++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/dwarves.h b/dwarves.h
index 0170f251bcd4..f224d05b28c3 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -54,6 +54,7 @@ struct conf_load {
 
 /** struct conf_fprintf - hints to the __fprintf routines
  *
+ * @count - Just like 'dd', stop pretty printing input after 'count' records
  * @flat_arrays - a->foo[10][2] becomes a->foo[20]
  * @classes_as_structs - class f becomes struct f, CTF doesn't have a "class"
  * @cachelinep - pointer to current cacheline, so that when expanding types we keep track of it,
@@ -68,6 +69,7 @@ struct conf_fprintf {
 	int32_t	   type_spacing;
 	int32_t	   name_spacing;
 	uint32_t   base_offset;
+	uint32_t   count;
 	uint32_t   *cachelinep;
 	uint8_t	   indent;
 	uint8_t	   expand_types:1;
diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 26c14cb6fd2c..7e8207756432 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -60,6 +60,8 @@ See the EXAMPLES section for more usage suggestions.
 It also pretty prints whatever is fed to its standard input, according to the
 type specified, see the EXAMPLE session.
 
+Use --count to state how many records should be pretty printed.
+
 .SH OPTIONS
 pahole supports the following options.
 
@@ -72,6 +74,10 @@ or file URLs (e.g.: file://class_list.txt)
 .B \-c, \-\-cacheline_size=SIZE
 Set cacheline size to SIZE bytes.
 
+.TP
+.B \-\-count=COUNT
+Pretty print the first COUNT records from input.
+
 .TP
 .B \-E, \-\-expand_types
 Expand class members. Useful to find in what member of inner structs where an
@@ -482,7 +488,7 @@ $
 $ ls -la versions
 -rw-rw-r--. 1 acme acme 7616 Jun 25 11:33 versions
 $
-$ pahole -C modversion_info drivers/scsi/sg.ko < versions | head -12
+$ pahole --count 3 -C modversion_info drivers/scsi/sg.ko < versions
 {
       .crc = 0x8dabd84,
       .name = "module_layout",
diff --git a/pahole.c b/pahole.c
index 03909525bf15..1b84f5c2fa4a 100644
--- a/pahole.c
+++ b/pahole.c
@@ -802,6 +802,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_suppress_packed	   308
 #define ARGP_just_unions	   309
 #define ARGP_just_structs	   310
+#define ARGP_count		   311
 
 static const struct argp_option pahole__options[] = {
 	{
@@ -822,6 +823,12 @@ static const struct argp_option pahole__options[] = {
 		.arg  = "CLASS_NAME",
 		.doc  = "Show just this class"
 	},
+	{
+		.name = "count",
+		.key  = ARGP_count,
+		.arg  = "COUNT",
+		.doc  = "Print only COUNT input records"
+	},
 	{
 		.name = "find_pointers_to",
 		.key  = 'f',
@@ -1145,6 +1152,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		just_unions = true;			break;
 	case ARGP_just_structs:
 		just_structs = true;			break;
+	case ARGP_count:
+		conf.count = atoi(arg);			break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -1315,6 +1324,7 @@ static int tag__stdio_fprintf_value(struct tag *type, struct cu *cu, FILE *fp)
 {
 	int _sizeof = tag__size(type, cu), printed = 0;
 	void *instance = malloc(_sizeof);
+	uint32_t count = 0;
 
 	if (instance == NULL)
 		return -ENOMEM;
@@ -1322,6 +1332,9 @@ static int tag__stdio_fprintf_value(struct tag *type, struct cu *cu, FILE *fp)
 	while (fread(instance, _sizeof, 1, stdin) == 1) {
 		printed += tag__fprintf_value(type, cu, instance, _sizeof, fp);
 		printed += fprintf(fp, ",\n");
+
+		if (conf.count && ++count == conf.count)
+			break;
 	}
 
 	return printed;
-- 
2.21.3
