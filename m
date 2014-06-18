From: Mark Wielaard <mjw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] dwarves_fprintf.c: DW_TAG_mutable_type doesn't exist.
Date: Wed, 18 Jun 2014 11:14:07 +0200
Message-ID: <1403082847-15424-1-git-send-email-mjw@redhat.com>
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Mark Wielaard <mjw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: dwarves@vger.kernel.org

DW_TAG_mutable_type was a mistake in an early DWARFv3 draft and was removed
in the final version. http://dwarfstd.org/ShowIssue.php?issue=050223.1

Signed-off-by: Mark Wielaard <mjw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dwarves_fprintf.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index 4d8e0f4..b746864 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -75,7 +75,6 @@ static const char *dwarf_tag_names[] = {
 	[DW_TAG_unspecified_type]	  = "unspecified_type",
 	[DW_TAG_partial_unit]		  = "partial_unit",
 	[DW_TAG_imported_unit]		  = "imported_unit",
-	[DW_TAG_mutable_type]		  = "mutable_type",
 	[DW_TAG_condition]		  = "condition",
 	[DW_TAG_shared_type]		  = "shared_type",
 #ifdef STB_GNU_UNIQUE
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
