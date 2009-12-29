From: Rakesh Pandit <rakesh.pandit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: replaces deprecated elf_getshstrndx with elf_getshdrstrndx
Date: Tue, 29 Dec 2009 10:10:38 +0530
Message-ID: <b401d2530912282040y1e967a4egd827cc9626da3f7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Removes irritating warning while compilation.
-- 
Rakesh Pandit
https://fedoraproject.org/wiki/User:Rakesh
freedom, friends, features, first

From 704b1b6710e3b9edfaa754ebfab1e5bc68d8781b Mon Sep 17 00:00:00 2001
From: Rakesh Pandit <rakesh-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>
Date: Tue, 29 Dec 2009 09:55:24 +0530
Subject: [PATCH] libctf: Replaces deprecated elf_getshstrndx with
elf_getshdrstrndx

Signed-off-by: Rakesh Pandit <rakesh-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>
---
 libctf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/libctf.c b/libctf.c
index 09b6fe2..447b7db 100644
--- a/libctf.c
+++ b/libctf.c
@@ -657,7 +657,7 @@ int ctf__encode(struct ctf *self, uint8_t flags)
 	GElf_Shdr *shdr;
 	Elf_Scn *scn = NULL;

-	elf_getshstrndx(elf, &strndx);
+	elf_getshdrstrndx(elf, &strndx);

 	while ((scn = elf_nextscn(elf, scn)) != NULL) {
 		shdr = gelf_getshdr(scn, &shdr_mem);
-- 
1.6.5.2
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
