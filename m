From: Hagen Paul Pfeifer <hagen-GvnIQ6b/HdU@public.gmane.org>
Subject: [PATCH 1/1] define memdup() static
Date: Sun, 10 Feb 2008 21:52:15 +0100
Message-ID: <20080210205209.GA2539@nuttenaction>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Diego 'Flameeyes' =?iso-8859-1?Q?Petten=F2?= <flameeyes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

memdup() is only referenced from dwarves.c. This patch defines them
static. Further symbol hiding can be accomplished via GCC attributes:

#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 4)
# define DWARVES_NO_EXPORT __attribute__((visibility("hidden")))
#else
# define DWARVES_NO_EXPORT
#endif

Signed-off-by: Hagen Paul Pfeifer <hagen-GvnIQ6b/HdU@public.gmane.org>
---
 dwarves.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dwarves.c b/dwarves.c
index 813c67b..aa9510e 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -114,7 +114,7 @@ static void *zalloc(const size_t size)
 	return s;
 }
 
-void *memdup(const void *src, size_t len)
+static void *memdup(const void *src, size_t len)
 {
 	void *s = malloc(len);
 	if (s != NULL)
-- 
1.5.3.8
