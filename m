From: Yulia Kartseva <hex-b10kYP2dOMg@public.gmane.org>
Subject: [PATCH 1/2] pahole: fix compiler warning
Date: Thu, 16 Jan 2020 16:59:12 -0800
Message-ID: <d0b9a8c3bd459fb41f9b4dfb80d5a5972b5c2949.1579221668.git.hex@fb.com>
References: <cover.1579221668.git.hex@fb.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1579221668.git.hex-b10kYP2dOMg@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, hex-b10kYP2dOMg@public.gmane.org
List-Id: dwarves@vger.kernel.org

From: Julia Kartseva <hex-b10kYP2dOMg@public.gmane.org>

Signed-off-by: Julia Kartseva <hex-b10kYP2dOMg@public.gmane.org>
---
 pahole.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pahole.c b/pahole.c
index 829c9ab..7ac49c2 100644
--- a/pahole.c
+++ b/pahole.c
@@ -684,8 +684,8 @@ static void print_structs_with_pointer_to(struct cu *cu, uint32_t type)
 	uint32_t id;
 
 	cu__for_each_struct_or_union(cu, id, pos) {
+		struct structure *str = NULL;
 		bool looked = false;
-		struct structure *str;
 
 		if (pos->type.namespace.name == 0)
 			continue;
-- 
2.17.1
