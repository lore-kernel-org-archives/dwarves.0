From: "=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen-pxSi+dnQzZMxHbG02/KK1g@public.gmane.org>
Subject: Re: codiff misses changes if inline -> not inlined?
Date: Fri, 4 Jan 2008 00:41:40 +0200 (EET)
Message-ID: <Pine.LNX.4.64.0801040038510.20866@kivilampi-30.cs.helsinki.fi>
References: <Pine.LNX.4.64.0801031528400.14949@kivilampi-30.cs.helsinki.fi>
 <20080103151044.GD29523@ghostprotocols.net>
 <Pine.LNX.4.64.0801031728330.14949@kivilampi-30.cs.helsinki.fi>
 <20080103165605.GF29523@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-696243703-1883087771-1199400100=:20866"
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080103165605.GF29523-f8uhVLnGfZaxAyOMLChx1axOck334EZe@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---696243703-1883087771-1199400100=:20866
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 3 Jan 2008, Arnaldo Carvalho de Melo wrote:

> Em Thu, Jan 03, 2008 at 06:45:32PM +0200, Ilpo Järvinen escreveu:
> > On Thu, 3 Jan 2008, Arnaldo Carvalho de Melo wrote:
> > 
> > Now that I automated it for inlines per file, one thing that annoys me a 
> > bit is that it does not keep identical formatting on the last line (it's 
> > fixable of course by some simple sed trickery):
> > 
> > static inline int tcp_may_raise_cwnd(const struct sock *sk, const int 
> > flag)
> > net/ipv4/tcp_input.c:
> >   tcp_prune_queue |  -16
> >  1 function changed, 16 bytes removed
> > 
> > ...versus...
> > 
> > static inline int tcp_may_update_window(const struct tcp_sock *tp,
> > net/ipv4/tcp_input.c:
> >   tcp_disordered_ack |  -18
> >   tcp_ack            |  -76
> >  2 functions changed, 94 bytes removed
> > 
> > net/ipv4/tcp_input.c:
> >   tcp_may_update_window |  +56
> >  1 function changed, 56 bytes added
> > 
> > net/ipv4/tcp_input.o:
> >  3 functions changed, 56 bytes added, 94 bytes removed, diff: -38
> > 
> > 
> > diff: xx is not always present.
> 
> Fixed, please do a git-pull.

...much better with piped sort now (only added lines seemed to show up 
still without diff and they're not that interesting after all :-)), but
I think this is needed as well to complete the change...

-- 
 i.

--
[PATCH] [CODIFF]: Be even more consistent on the summary lines

Forgotten change similar to the previous patch.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen-pxSi+dnQzZMxHbG02/KK1g@public.gmane.org>
---
 codiff.c |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/codiff.c b/codiff.c
index 0eada19..3e59e95 100644
--- a/codiff.c
+++ b/codiff.c
@@ -568,27 +568,20 @@ static int cu_show_diffs_iterator(struct cu *cu, void *cookie)
 
 static void print_total_function_diff(const char *filename)
 {
-	int kind = 0;
-
 	printf("\n%s:\n", filename);
 
 	printf(" %u function%s changed", total_nr_functions_changed,
 	       total_nr_functions_changed > 1 ? "s" : "");
 
-	if (total_function_bytes_added != 0) {
-		++kind;
+	if (total_function_bytes_added != 0)
 		printf(", %u bytes added", total_function_bytes_added);
-	}
 
-	if (total_function_bytes_removed != 0) {
-		++kind;
+	if (total_function_bytes_removed != 0)
 		printf(", %u bytes removed", total_function_bytes_removed);
-	}
   
-	if (kind == 2)
-		printf(", diff: %+d",
-		       (total_function_bytes_added -
-		        total_function_bytes_removed));
+	printf(", diff: %+d",
+	       (total_function_bytes_added -
+	        total_function_bytes_removed));
 	putchar('\n');
 }
 
-- 
1.5.0.6

---696243703-1883087771-1199400100=:20866--
-
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
