From: Arnaldo Carvalho de Melo <acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: pahole and parsing data: --skip
Date: Wed, 1 Jul 2020 08:44:21 -0300
Message-ID: <20200701114421.GR29008@kernel.org>
References: <e52cf45d-311f-85c7-d358-5592d3666092@redhat.com>
 <20200624173038.GC20203@kernel.org>
 <20200624185748.GA16165@redhat.com>
 <20200624190716.GA4139@redhat.com>
 <a5238972-e36e-3abe-aa14-5dcca58c46fb@redhat.com>
 <20200625113816.GA29008@kernel.org>
 <20200625114129.GB29008@kernel.org>
 <20200625160326.GA10325@kernel.org>
 <0eae329c-d448-4d04-c240-0850a93278a5@redhat.com>
 <20200701112534.GQ29008@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200701112534.GQ29008-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Joe Lawrence <joe.lawrence-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jiri Olsa <jolsa-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Namhyung Kim <namhyung-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: dwarves@vger.kernel.org

Em Wed, Jul 01, 2020 at 08:25:34AM -0300, Arnaldo Carvalho de Melo escreveu:
> 	The latest changeset shows what this is about, see its example
> below, please help testing and suggesting whatever needs you have
> regarding pretty printing.
> 
> 	Now to implement --skip.

Now to implement --seek, this time in bytes, so that we can, for
instance, pretty print perf.data records, looking at 'perf report -D'
and getting the offset of the start of a series of 'struct
perf_event_attr' or 'struct perf_event_header'.

- Arnaldo

commit 44af7c02b5d0a7f2b93fab9fda45907cd6fe0827
Author: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Date:   Wed Jul 1 08:36:28 2020 -0300

    pahole: Implement --skip, just like dd
    
      $ objcopy -O binary --only-section=__versions drivers/scsi/sg.ko versions
      $ pahole -C modversion_info drivers/scsi/sg.ko
      struct modversion_info {
            long unsigned int          crc;                  /*     0     8 */
            char                       name[56];             /*     8    56 */
    
            /* size: 64, cachelines: 1, members: 2 */
      };
      $ pahole --count 3 -C modversion_info drivers/scsi/sg.ko < versions
      {
            .crc = 0x8dabd84,
            .name = "module_layout",
      },
      {
            .crc = 0x45e4617b,
            .name = "no_llseek",
      },
      {
            .crc = 0xa23fae8c,
            .name = "param_ops_int",
      },
      $ pahole --skip 1 --count 2 -C modversion_info drivers/scsi/sg.ko < versions
      {
            .crc = 0x45e4617b,
            .name = "no_llseek",
      },
      {
            .crc = 0xa23fae8c,
            .name = "param_ops_int",
      },
      $
    
    Signed-off-by: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

diff --git a/dwarves.h b/dwarves.h
index f224d05b28c3..24f9c7c37843 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -55,6 +55,7 @@ struct conf_load {
 /** struct conf_fprintf - hints to the __fprintf routines
  *
  * @count - Just like 'dd', stop pretty printing input after 'count' records
+ * @skip - Just like 'dd', skip 'count' records when pretty printing input
  * @flat_arrays - a->foo[10][2] becomes a->foo[20]
  * @classes_as_structs - class f becomes struct f, CTF doesn't have a "class"
  * @cachelinep - pointer to current cacheline, so that when expanding types we keep track of it,
@@ -71,6 +72,7 @@ struct conf_fprintf {
 	uint32_t   base_offset;
 	uint32_t   count;
 	uint32_t   *cachelinep;
+	uint32_t   skip;
 	uint8_t	   indent;
 	uint8_t	   expand_types:1;
 	uint8_t	   expand_pointers:1;
diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 7e8207756432..db820cca323f 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -78,6 +78,10 @@ Set cacheline size to SIZE bytes.
 .B \-\-count=COUNT
 Pretty print the first COUNT records from input.
 
+.TP
+.B \-\-skip=COUNT
+Skip COUNT input records.
+
 .TP
 .B \-E, \-\-expand_types
 Expand class members. Useful to find in what member of inner structs where an
@@ -502,6 +506,16 @@ $ pahole --count 3 -C modversion_info drivers/scsi/sg.ko < versions
       .name = "param_ops_int",
 },
 $
+$ pahole --skip 1 --count 2 -C modversion_info drivers/scsi/sg.ko < versions
+{
+      .crc = 0x45e4617b,
+      .name = "no_llseek",
+},
+{
+      .crc = 0xa23fae8c,
+      .name = "param_ops_int",
+},
+$
 .fi
 .P
 
diff --git a/pahole.c b/pahole.c
index 1b84f5c2fa4a..7d8431c64423 100644
--- a/pahole.c
+++ b/pahole.c
@@ -803,6 +803,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARGP_just_unions	   309
 #define ARGP_just_structs	   310
 #define ARGP_count		   311
+#define ARGP_skip		   312
 
 static const struct argp_option pahole__options[] = {
 	{
@@ -829,6 +830,12 @@ static const struct argp_option pahole__options[] = {
 		.arg  = "COUNT",
 		.doc  = "Print only COUNT input records"
 	},
+	{
+		.name = "skip",
+		.key  = ARGP_skip,
+		.arg  = "COUNT",
+		.doc  = "Skip COUNT input records"
+	},
 	{
 		.name = "find_pointers_to",
 		.key  = 'f',
@@ -1154,6 +1161,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		just_structs = true;			break;
 	case ARGP_count:
 		conf.count = atoi(arg);			break;
+	case ARGP_skip:
+		conf.skip = atoi(arg);			break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -1325,11 +1334,17 @@ static int tag__stdio_fprintf_value(struct tag *type, struct cu *cu, FILE *fp)
 	int _sizeof = tag__size(type, cu), printed = 0;
 	void *instance = malloc(_sizeof);
 	uint32_t count = 0;
+	uint32_t skip = conf.skip;
 
 	if (instance == NULL)
 		return -ENOMEM;
 
 	while (fread(instance, _sizeof, 1, stdin) == 1) {
+		if (skip) {
+			--skip;
+			continue;
+		}
+
 		printed += tag__fprintf_value(type, cu, instance, _sizeof, fp);
 		printed += fprintf(fp, ",\n");
 
