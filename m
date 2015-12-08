From: Jiri Olsa <jolsa-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/3] dwarves print: Keep global cacheline in struct conf_fprintf
Date: Tue,  8 Dec 2015 23:47:06 +0100
Message-ID: <1449614826-2278-4-git-send-email-jolsa@kernel.org>
References: <1449614826-2278-1-git-send-email-jolsa@kernel.org>
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449614826-2278-1-git-send-email-jolsa-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Joe Mario <jmario-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Together with adding cconf->base_offset to sums used
for cacheline computation, this ensures proper cacheline
number to be printed for nested struct. Note possitions
of 'cacheline' lines in following outputs.

Before:
  $ pahole -C task_struct -E ~/kernel/linux-perf-local/vmlinux
  struct task_struct {
        volatile long int          state;                                                /*     0     8 */

        --- First cacheline is ok

        struct task_struct *       last_wakee;                                           /*    56     8 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        int                        wake_cpu;                                             /*    64     4 */

        ...

        const struct sched_class  * sched_class;                                         /*    88     8 */
        struct sched_entity {
                struct load_weight {
                        long unsigned int weight;                                        /*    96     8 */
                        /* typedef u32 */ unsigned int inv_weight;                       /*   104     4 */
                } load; /*    96    16 */

                --- Second one is still in relative mode and gives wrong
                    alignment in wrt task_struct start

                unsigned int       on_rq;                                                /*   152     4 */
                /* --- cacheline 1 boundary (64 bytes) --- */
                /* typedef u64 */ long long unsigned int exec_start;                     /*   160     8 */
                /* typedef u64 */ long long unsigned int sum_exec_runtime;               /*   168     8 */
       ...

After:
  $ pahole -C task_struct -E ~/kernel/linux-perf-local/vmlinux

   struct task_struct {
        volatile long int          state;                                                /*     0     8 */

        --- First cacheline is ok

        struct task_struct *       last_wakee;                                           /*    56     8 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        int                        wake_cpu;                                             /*    64     4 */

        ...

        const struct sched_class  * sched_class;                                         /*    88     8 */
        struct sched_entity {
                struct load_weight {
                        long unsigned int weight;                                        /*    96     8 */
                        /* typedef u32 */ unsigned int inv_weight;                       /*   104     4 */
                } load; /*    96    16 */
                struct rb_node {
                        long unsigned int __rb_parent_color;                             /*   112     8 */
                        struct rb_node * rb_right;                                       /*   120     8 */
                        /* --- cacheline 2 boundary (128 bytes) --- */
                        struct rb_node * rb_left;                                        /*   128     8 */
                } run_node; /*   112    24 */

                --- Second one is still in relative mode and gives wrong
                    alignment in wrt task_struct start

                /* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
                struct list_head {
                        struct list_head * next;                                         /*   136     8 */
                        struct list_head * prev;                                         /*   144     8 */
                } group_node; /*   136    16 */
       ...

Signed-off-by: Jiri Olsa <jolsa-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dwarves.h         |  1 +
 dwarves_fprintf.c | 25 ++++++++++---------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/dwarves.h b/dwarves.h
index 73fec8ac614a..44ebf8384b9c 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -56,6 +56,7 @@ struct conf_fprintf {
 	int32_t	   type_spacing;
 	int32_t	   name_spacing;
 	uint32_t   base_offset;
+	uint32_t   base_cacheline;
 	uint8_t	   indent;
 	uint8_t	   expand_types:1;
 	uint8_t	   expand_pointers:1;
diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index 2d114210831a..72d8b08bf235 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -1118,22 +1118,21 @@ size_t function__fprintf_stats(const struct tag *tag, const struct cu *cu,
 	return printed + fprintf(fp, " */\n");
 }
 
-static size_t class__fprintf_cacheline_boundary(uint32_t last_cacheline,
-						size_t sum, size_t sum_holes,
+static size_t class__fprintf_cacheline_boundary(size_t sum, size_t sum_holes,
 						uint8_t *newline,
-						uint32_t *cacheline,
 						struct conf_fprintf *cconf,
 						FILE *fp)
 {
-	const size_t real_sum = sum + sum_holes;
+	const size_t real_sum = sum + sum_holes + cconf->base_offset;
 	size_t printed = 0;
+	uint32_t cacheline = real_sum / cacheline_size;
 
-	*cacheline = real_sum / cacheline_size;
-
-	if (*cacheline > last_cacheline) {
+	if (cacheline != cconf->base_cacheline) {
 		const uint32_t cacheline_pos = real_sum % cacheline_size;
 		const uint32_t cacheline_in_bytes = real_sum - cacheline_pos;
 
+		cconf->base_cacheline = cacheline;
+
 		if (*newline) {
 			fputc('\n', fp);
 			*newline = 0;
@@ -1144,12 +1143,12 @@ static size_t class__fprintf_cacheline_boundary(uint32_t last_cacheline,
 
 		if (cacheline_pos == 0)
 			printed += fprintf(fp, "/* --- cacheline %u boundary "
-					   "(%u bytes) --- */\n", *cacheline,
+					   "(%u bytes) --- */\n", cacheline,
 					   cacheline_in_bytes);
 		else
 			printed += fprintf(fp, "/* --- cacheline %u boundary "
 					   "(%u bytes) was %u bytes ago --- "
-					   "*/\n", *cacheline,
+					   "*/\n", cacheline,
 					   cacheline_in_bytes, cacheline_pos);
 	}
 	return printed;
@@ -1284,10 +1283,8 @@ size_t class__fprintf(struct class *class, const struct cu *cu,
 		    pos->byte_offset != last->byte_offset &&
 		    !cconf.suppress_comments)
 			printed +=
-			    class__fprintf_cacheline_boundary(last_cacheline,
-							      sum, sum_holes,
+			    class__fprintf_cacheline_boundary(sum, sum_holes,
 							      &newline,
-							      &last_cacheline,
 							      &cconf,
 							      fp);
 		/*
@@ -1474,10 +1471,8 @@ size_t class__fprintf(struct class *class, const struct cu *cu,
 	}
 
 	if (!cconf.suppress_comments)
-		printed += class__fprintf_cacheline_boundary(last_cacheline,
-							     sum, sum_holes,
+		printed += class__fprintf_cacheline_boundary(sum, sum_holes,
 							     &newline,
-							     &last_cacheline,
 							     &cconf, fp);
 	if (!cconf.show_only_data_members)
 		class__vtable_fprintf(class, cu, &cconf, fp);
-- 
2.4.3

--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
