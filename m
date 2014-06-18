From: Masatake YAMATO <yamato-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] Use obstack_zalloc when allocating tag
Date: Wed, 18 Jun 2014 18:55:31 +0900
Message-ID: <1403085331-31764-1-git-send-email-yamato@redhat.com>
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: yamato-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: dwarves@vger.kernel.org

obstack_alloc was used in __tag__alloc to allocate tag
object. As the result some fields of the tag object are not
initialized.

Signed-off-by: Masatake YAMATO <yamato-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 dwarf_loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index d7709a0..bc04b62 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -369,7 +369,7 @@ static void *__tag__alloc(struct dwarf_cu *dcu, size_t size, bool spec)
 	if (dtag == NULL)
 		return NULL;
 
-	struct tag *tag = obstack_alloc(&dcu->cu->obstack, size);
+	struct tag *tag = obstack_zalloc(&dcu->cu->obstack, size);
 
 	if (tag == NULL)
 		return NULL;
-- 
1.9.0

--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
