From: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] scncopy: Fix minor problems with --usage.
Date: Tue, 12 Jan 2010 13:17:18 -0500
Message-ID: <1263320238-21124-1-git-send-email-pjones@redhat.com>
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: dwarves@vger.kernel.org

- "-s section 0" doesn't really read the same as "-s section0"
- "--help" is something we should allow
- usage should say "scncopy" not "pjoc"
---
 scncopy.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/scncopy.c b/scncopy.c
index 38aaa9a..9acc16d 100644
--- a/scncopy.c
+++ b/scncopy.c
@@ -65,8 +65,10 @@ int main(int argc, char *argv[])
 			n++;
 			outfile = argv[n];
 			continue;
-		} else if (!strcmp(argv[n], "-?") || !strcmp(argv[n],"--usage")) {
-			printf("usage: pjoc -s section 0 [[-s section1] ... -s sectionN] -o outfile infile\n");
+		} else if (!strcmp(argv[n], "-?") ||
+				!strcmp(argv[n], "--help") ||
+				!strcmp(argv[n], "--usage")) {
+			printf("usage: scncopy [-s section0 [[-s section1] ... -s sectionN] | -a ] -o outfile infile\n");
 			return 0;
 		} else if (n == argc-1) {
 			infile = argv[n];
-- 
1.6.5.2

--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
