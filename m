From: "Emmanuel Viaud" <emmanuel.viaud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Segfault in latest pahole
Date: Fri, 19 Dec 2008 15:21:51 +0100
Message-ID: <89f4d9ca0812190621g544ba0e6od54346617416339@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Hi.

I got a segfault using latest head of pahole. The problems comes from
the memcpy call in gobuffer_add function when the entry to add has a
size larger than GOBUFFER__BCHUNK (the entry was 16299 bytes long in
my example). In that case, the realloc (which only allocates
GOBUFFER_BCHUNK bytes) does not allocate enough memory.

The simple following patch solves my problem, but I don't know if it
is good enough:
diff --git a/gobuffer.c b/gobuffer.c
index 5797aa6..d3f4726 100644
--- a/gobuffer.c
+++ b/gobuffer.c
@@ -63,7 +63,7 @@ unsigned int gobuffer__add(struct gobuffer *self,
const void *s,
        const unsigned int index = self->index + len;
        char *copy;

-       if (index >= self->allocated_size) {
+    while (index >= self->allocated_size) {
                const unsigned int allocated_size = (self->allocated_size +
                                                     GOBUFFER__BCHUNK);
                char *entries = realloc(self->entries, allocated_size);

Thanks and best regards.
Emmanuel
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
