From: Dave Rigby <davidr-1LojSYAwM1QXQ3Lr6voeyA@public.gmane.org>
Subject: [PATCH] Add support for filtering classes based on name
Date: Mon, 21 Apr 2008 14:22:14 +0000 (UTC)
Message-ID: <loom.20080421T141540-204@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

i,

While pahole allows you to exclude classes with a specified prefix (using
--exclude), it doesn't appear to be able to do the opposite - only show
classes with a specific prefix. I found I needed this for my own use of it,
so here is a patch to add this functionality. It seems like it could be
useful for others:

Thanks

Dave Rigby


diff --git a/pahole.c b/pahole.c
index 7053471..e16ac2d 100644
--- a/pahole.c
+++ b/pahole.c
@@ -26,6 +26,9 @@ static uint8_t word_size, original_word_size;
 static char *class__exclude_prefix;
 static size_t class__exclude_prefix_len;
 
+static char *class__include_prefix;
+static size_t class__include_prefix_len;
+
 static char *cu__exclude_prefix;
 static size_t cu__exclude_prefix_len;
 
@@ -350,6 +353,20 @@ static struct tag *tag__filter(struct tag *tag, 
struct cu *cu,
 			return NULL;
 	}
 
+	if (class__include_prefix != NULL) {
+		if (name == NULL) {
+			const struct tag *tdef =
+				cu__find_first_typedef_of_type(cu, tag->id);
+			if (tdef != NULL)
+				name = class__name(tag__class(tdef), cu);
+		}
+
+		if (name != NULL && strncmp(class__include_prefix, name,
+					    class__include_prefix_len) != 0)
+			return NULL;
+	}
+
+
 	if (decl_exclude_prefix != NULL &&
 	    (tag->decl_file == NULL ||
 	     strncmp(decl_exclude_prefix, tag->decl_file,
@@ -820,6 +837,12 @@ static const struct argp_option pahole__options[] = {
 		.doc  = "exclude PREFIXed classes",
 	},
 	{
+		.name = "prefix_filter",
+		.key  = 'y',
+		.arg  = "PREFIX",
+		.doc  = "include PREFIXed classes",
+	},
+	{
 		.name = "cu_exclude",
 		.key  = 'X',
 		.arg  = "PREFIX",
@@ -910,6 +933,9 @@ static error_t pahole__options_parser(int key, char *arg,
 	case 'x': class__exclude_prefix = arg;
 		  class__exclude_prefix_len = strlen(class__exclude_prefix);
 							break;
+        case 'y': class__include_prefix = arg;
+                  class__include_prefix_len = strlen(class__include_prefix);
+                                                        break;
 	case 'z':
 		hole_size_ge = atoi(arg);
 		if (!global_verbose)







--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
