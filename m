From: Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] scncopy: make "--help" a valid argument...
Date: Tue, 12 Jan 2010 11:40:35 -0500
Message-ID: <1263314435-17341-1-git-send-email-pjones@redhat.com>
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Peter Jones <pjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: dwarves@vger.kernel.org

---
 scncopy.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/scncopy.c b/scncopy.c
index 067662c..1c76742 100644
--- a/scncopy.c
+++ b/scncopy.c
@@ -65,7 +65,9 @@ int main(int argc, char *argv[])
 			n++;
 			outfile = argv[n];
 			continue;
-		} else if (!strcmp(argv[n], "-?") || !strcmp(argv[n],"--usage")) {
+		} else if (!strcmp(argv[n], "-?") ||
+				!strcmp(argv[n], "--help") ||
+				!strcmp(argv[n], "--usage")) {
 			printf("usage: pjoc [-s section0 [[-s section1] ... -s sectionN] | -a ] -o outfile infile\n");
 			return 0;
 		} else if (n == argc-1) {
-- 
1.6.5.2

--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
