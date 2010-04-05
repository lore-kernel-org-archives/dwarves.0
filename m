From: Rakesh Pandit <rakesh.pandit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] pfunct: Introduced --all/-A
Date: Mon, 5 Apr 2010 13:01:58 +0530
Message-ID: <g2wb401d2531004050031q14f3fb12y39f4e7b0316526c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Hello,

I have a request for enhancement (new option in pfunct) via which I
want pfunct to print signatures for all symbols in one go. To add to
it and as expected I want source code information per symbol if -l
option is specified.

Use can for me was: I wanted signature for all symbols from an ELF
file. Repeatedly asking pfunct for all symbols using names had a cost
for me. It used to take substantial time per symbol for uploading ELF
file into memory and searching for sym name and printing required
information. This option will upload it once and print all information
for me.

Can this be considered for inclusion ? If yes, may inline patch be reviewed ?

Thanks,

-- 
Rakesh Pandit
https://fedoraproject.org/wiki/User:Rakesh
freedom, friends, features, first

From 0ee628a9152d24eb75107778784fc170ff03ec8d Mon Sep 17 00:00:00 2001
From: Rakesh Pandit <rakesh-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>
Date: Mon, 5 Apr 2010 12:43:47 +0530
Subject: [PATCH] pfunct: Introduced --all/-A

Prints all symbols along with signatures in one go. Depending on other
options e.g -l will also print source code info.

Signed-off-by: Rakesh Pandit <rakesh-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>
---
 pfunct.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/pfunct.c b/pfunct.c
index 20dd3bb..0e604b9 100644
--- a/pfunct.c
+++ b/pfunct.c
@@ -29,6 +29,7 @@ static int show_variables;
 static int show_externals;
 static int show_cc_inlined;
 static int show_cc_uninlined;
+static int show_all_functions;
 static char *symtab_name;
 static bool expand_types;
 static struct type_emissions emissions;
@@ -367,6 +368,22 @@ static int cu_function_iterator(struct cu *cu,
void *cookie)
 	return 0;
 }

+static void print_all_functions(struct cus *self)
+{
+	struct cu *pos;
+
+	list_for_each_entry(pos, &self->cus, node) {
+		struct cu *cu = pos;
+		struct function *function;
+		uint32_t id;
+		cu__for_each_function(cu, id, function) {
+			fprintf(stdout, "%s\n", function__name(function, cu));
+			function__show(function, cu);
+			putchar('\n');
+		}
+	}
+}
+
 int elf_symtab__show(char *filename)
 {
 	int fd = open(filename, O_RDONLY), err = -1;
@@ -478,6 +495,11 @@ static const struct argp_option pfunct__options[] = {
 		.doc  = "show just external functions",
 	},
 	{
+		.key  = 'A',
+		.name = "all",
+		.doc  = "show all functions with source code info",
+	},
+	{
 		.key  = 'f',
 		.name = "function",
 		.arg  = "FUNCTION",
@@ -592,6 +614,7 @@ static error_t pfunct__options_parser(int key, char *arg,
 	case 'f': function_name = arg;			 break;
 	case 'F': conf_load.format_path = arg;		 break;
 	case 'E': show_externals = 1;			 break;
+	case 'A': show_all_functions = 1;		 break;
 	case 's': formatter = fn_stats_size_fmtr;
 		  conf_load.get_addr_info = true;	 break;
 	case 'S': formatter = fn_stats_variables_fmtr;	 break;
@@ -669,6 +692,8 @@ int main(int argc, char *argv[])
 			goto out_cus_delete;
 		}
 		function__show(f, cu);
+	} else if (show_all_functions) {
+		print_all_functions(cus);
 	} else if (show_total_inline_expansion_stats)
 		print_total_inline_stats();
 	else if (class_name != NULL)
-- 
1.6.6.1
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
