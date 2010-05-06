From: Rakesh Pandit <rakesh.pandit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] pfunct: Introduce '-u'/'--all_units'
Date: Thu, 6 May 2010 15:57:29 +0530
Message-ID: <r2tb401d2531005060327hc5cb2acet28a72f429de54518@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Link: http://rakesh.fedorapeople.org/misc/0001-pfunct-Introduce-u-all_units.patch

Reason I am not reusing cus__for_each_cu which in turn uses
cu_function_iterator is because it would have in my view been more
unclean way of doing it. To keep things simple and clean I am rather
using a static function print_all_matches.

May this be reviewed ?

Regards,

-- 
Rakesh Pandit
https://fedoraproject.org/wiki/User:Rakesh
freedom, friends, features, first


From 0d09eb9a521a28cdb184d3b1a2ec440abe7127fb Mon Sep 17 00:00:00 2001
From: Rakesh Pandit <rakesh-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>
Date: Thu, 6 May 2010 15:40:27 +0530
Subject: [PATCH] pfunct: Introduce '-u'/'--all_units'

Continue printing all function name matches.

Signed-off-by: Rakesh Pandit <rakesh-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>
---
 pfunct.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/pfunct.c b/pfunct.c
index 5664ed2..9a65749 100644
--- a/pfunct.c
+++ b/pfunct.c
@@ -31,6 +31,7 @@ static int show_cc_inlined;
 static int show_cc_uninlined;
 static char *symtab_name;
 static bool show_prototypes;
+static bool all_units;
 static bool expand_types;
 static struct type_emissions emissions;
 static uint64_t addr;
@@ -356,6 +357,22 @@ static void function__show(struct function *self,
struct cu *cu)
 		function__fprintf_stats(tag, cu, &conf, stdout);
 }

+static void print_all_matches(struct cus *self, const char *function_name)
+{
+	struct cu *pos;
+
+	list_for_each_entry(pos, &self->cus, node) {
+		struct cu *cu = pos;
+		struct function *function;
+		uint32_t id;
+		cu__for_each_function(cu, id, function) {
+			if (strcmp(function__name(function, cu), function_name) != 0)
+				continue;
+			function__show(function, cu);
+		}
+	}
+}
+
 static int cu_function_iterator(struct cu *cu, void *cookie)
 {
 	struct function *function;
@@ -548,6 +565,11 @@ static const struct argp_option pfunct__options[] = {
 		.doc  = "show function prototypes",
 	},
 	{
+		.key  = 'u',
+		.name = "all_units",
+		.doc  = "show all matches",
+	},
+	{
 		.key  = 'S',
 		.name = "nr_variables",
 		.doc  = "show number of variables",
@@ -605,6 +627,7 @@ static error_t pfunct__options_parser(int key, char *arg,
 	case 'S': formatter = fn_stats_variables_fmtr;	 break;
 	case 'p': formatter = fn_stats_nr_parms_fmtr;	 break;
 	case 'P': show_prototypes = true;		 break;
+	case 'u': all_units = true;		 	 break;
 	case 'g': formatter = fn_stats_labels_fmtr;	 break;
 	case 'G': show_cc_uninlined = 1;		 break;
 	case 'H': show_cc_inlined = 1;			 break;
@@ -678,6 +701,8 @@ int main(int argc, char *argv[])
 			goto out_cus_delete;
 		}
 		function__show(f, cu);
+	} else if (all_units && function_name != NULL) {
+		print_all_matches(cus, function_name);
 	} else if (show_total_inline_expansion_stats)
 		print_total_inline_stats();
 	else if (class_name != NULL)
-- 
1.6.6.1
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
