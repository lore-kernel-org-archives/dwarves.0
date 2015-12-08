From: Jiri Olsa <jolsa-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [RFC/PATCH 0/3] dwarves print: Cacheline accounting fixes
Date: Tue,  8 Dec 2015 23:47:03 +0100
Message-ID: <1449614826-2278-1-git-send-email-jolsa@kernel.org>
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaldo Carvalho de Melo <acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Joe Mario <jmario-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

hi,
hit 2 issues when used pahole
 - sometimes it did not account the hole between variables
 - when using -E to extract inner struct, cacheline boundaries were wrong

with this patchset I was able to get it work on structs
that I was investigating, but I'm not sure I covered all
parts or fixed it in proper way.

thanks,
jirka


---
Jiri Olsa (3):
      dwarves print: Fix holes accounting
      dwarves print: Pass into struct conf_fprintf class__fprintf_cacheline_boundary
      dwarves print: Keep global cacheline in struct conf_fprintf

 dwarves.h         |  1 +
 dwarves_fprintf.c | 45 ++++++++++++++++++++++++++-------------------
 2 files changed, 27 insertions(+), 19 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
