From: Rakesh Pandit <rakesh.pandit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: dwarf_loader.c: Fixed leaked bogon
Date: Wed, 6 Jan 2010 20:54:59 +0530
Message-ID: <b401d2531001060724r4a06401fx9cc8a5dbf24518d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

While checking one of big shared objects I found kernel getting
unhappy and sending SIGKILL. File was 282M libwebkit-1.0.so.2.8.1 from
webkit project. (Can be obtained from
http://kojipkgs.fedoraproject.org/packages/webkitgtk/1.1.12/2.fc12/x86_64/webkitgtk-debuginfo-1.1.12-2.fc12.x86_64.rpm
and extracted via rpm2cpio, file is libwebkit-1.0.so.2.8.1.debug)

URL: http://rakesh.fedorapeople.org/misc/0001-dwarf_loader.c-Fixed-leaked-bogon.patch

-- 
Rakesh Pandit
https://fedoraproject.org/wiki/User:Rakesh
freedom, friends, features, first

From 897af23e9c66a74a27fc7a4b60567bc92163d066 Mon Sep 17 00:00:00 2001
From: Rakesh Pandit <rakesh-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>
Date: Wed, 6 Jan 2010 20:34:03 +0530
Subject: [PATCH] dwarf_loader.c: Fixed leaked bogon

Freed chunks of memory left by obstack. It went beyond kernels
expectation for libwebkit-1.0.so.2.debug (from
libwebkit-1.0.so.2.8.1.debug) file and so that it had to send SIGKILL.

Signed-off-by: Rakesh Pandit <rakesh-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>
---
 dwarf_loader.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 3b58ecb..ce1e4d8 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2052,9 +2052,7 @@ static int cus__load_module(struct cus *self,
struct conf_load *conf,
 			}
 		}

-		if (!cu->extra_dbg_info)
-			obstack_free(&dcu.obstack, NULL);
