From: Tavis Ormandy <taviso-1TlbntoI6+xF6kxbq+BtvQ@public.gmane.org>
Subject: libdwarves memory leaks in the stealer interface
Date: Thu, 14 Jul 2016 12:58:07 -0700
Message-ID: <CABD==127dOrixY6KaHKBnycQV_+h1aMXPgT8h67Tkfka6GboGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: dwarves-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dwarves-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: dwarves@vger.kernel.org

Hello, I have a fun project that I'm trying to use libdwarves with,
but had a couple of questions.

I'm using the "steal" callback interface to search for a specific cu.
If the cu matches the one I was looking for, I process it and then
return LSK__STOP_LOADING to abort processing this file. If it's not
the cu I wanted, I just return LSK__DELETE.

This seems to do what I want, but leaks memory.

1) LSK__DELETE doesn't seem to clean up the dwarf_cu obstack, I think
this wasn't intended.
2) If die__process_and_recode() fails in finalize_cu_immediately(),
the cu is leaked. This one is definitely a bug :)

I'm not 100% sure if I'm using LSK__STOP_LOADING correctly. It doesn't
cleanup the cu like LSK__DELETE does, and it doesn't call cus__add()
like LSK__KEEPIT does, so was the stealer supposed to clean it up?

If so, how do I clean up the dcu? I think I can pull it out of
cu->priv, but I think you didn't intend to expose that to callbacks?

The patch I'm using is below.

Thanks for libdwarves, it's a really great library!

Tavis.

diff --git a/src/struct/dwarf_loader.c b/src/struct/dwarf_loader.c
index 163cb51..ba715a9 100644
--- a/src/struct/dwarf_loader.c
+++ b/src/struct/dwarf_loader.c
@@ -2169,9 +2169,12 @@ static int finalize_cu_immediately(struct cus
*cus, struct cu *cu,
  int lsk = finalize_cu(cus, cu, dcu, conf);
  switch (lsk) {
  case LSK__DELETE:
+ obstack_free(&dcu->obstack, NULL);
  cu__delete(cu);
  break;
  case LSK__STOP_LOADING:
+ obstack_free(&dcu->obstack, NULL);
+ cu__delete(cu);
  break;
  case LSK__KEEPIT:
  if (!cu->extra_dbg_info)
@@ -2304,8 +2307,11 @@ static int cus__load_module(struct cus *cus,
struct conf_load *conf,
  cu->priv = &dcu;
  cu->dfops = &dwarf__ops;

- if (die__process_and_recode(cu_die, cu) != 0)
+ if (die__process_and_recode(cu_die, cu) != 0) {
+ obstack_free(&dcu.obstack, NULL);
+ cu__delete(cu);
  return DWARF_CB_ABORT;
+ }

  if (finalize_cu_immediately(cus, cu, &dcu, conf)
     == LSK__STOP_LOADING)
--
To unsubscribe from this list: send the line "unsubscribe dwarves" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
