Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B1B1FB3
	for <dwarves@vger.kernel.org>; Wed, 16 Oct 2024 00:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729037458; cv=none; b=XGGvuQ6n8UPxi5rUj/PZznSnFdcGonIBbsyddlZcKcQd/vc9nUSF2vvImkD1Z2C4+xF2lSBvQFxCz8d7szFppK0IX8n+oG9S1kXG/D+pQ1Gq8J1+ddbg5Ih6KwtUMgG2XJshkpOgCKKI17l3YwK8YKAkxaXgTUjztNekA+qX6/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729037458; c=relaxed/simple;
	bh=ba+ySVK9d1LsYM02M1qeUqynaUJQugCFs9FYQGVMnW8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ewnrQrNQ8GJKvrZCPetoimI3pKISauBHEUuLv3Hf3G6WrW2wZd0hjU1lzgbHKIovnJVTpB8fihPLjnflj9EhKW44e9CEcNFxEM0Fk428UUtyKq/aKfKUMaBtlpcAQArYyHOM2L1617mNLWDBQ1XHlraa9XmIpBrc5ngdQnQqsaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=ccREztu7; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="ccREztu7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1729037454; x=1729296654;
	bh=zcN7KUO2upDhM56S6Au2azOg5YwCVjVzOq2ZSSqeMDw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ccREztu7xzeugFStFhvMfQ1Ko99y/d9xja/lOSM1MBD/SiO0AT0sFjtp40pQmFJDw
	 mcwBT6hlSCwdXXSK54KbV5R7WRcMcuMBA8kVrOg/0/z2bE0DvWit1WLDTE6Ozk+GLH
	 IuvVEhgu5AqGHkOO+5Axxz/6Hz5RBixlOjdRAvPgh2CNpwRSKiDxw/F2birbtmYNLz
	 ogiPn1BJoGj/yrven5eRsj/LGjOv/VCexze7JP0LS37b+sByRBOJxNSpuf0dJSl87q
	 vcdSS+ip7mVaasi4KSfrLRmNlVKiMFfhD8kD1iINg7M7QfkkMrunFtaSKXiNgycrOk
	 J97bZ//aviFXA==
Date: Wed, 16 Oct 2024 00:10:48 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org, eddyz87@gmail.com
Subject: [PATCH v3 dwarves 4/5] btf_encoder: store a list of elf_function per function name
Message-ID: <20241016001025.857970-5-ihor.solodrai@pm.me>
In-Reply-To: <20241016001025.857970-1-ihor.solodrai@pm.me>
References: <20241016001025.857970-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 87d51ee8f290149ea6f114a526804be2bcd24faf
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

btf_encoder__save_func() accumulates observations of DWARF functions,
maintaining an elf_function per function name.

Part of this routine is a funcs_match() call, which requires access to
BTF implicitly referenced by btf_encoder_func_state.  In case when
elf_functions table is maintained by each btf_encoder this is not an
issue, because every btf_encoder_func_state available to this encoder
can only reference its own BTF. However if elf_functions table becomes
shared then existing elf_function/btf_encoder_function_state structs
can be produced by other encoders referring to their own BTFs. In this
case funcs_match() can not be called unless BTFs are available and
writes to them are synchronized in some manner (which is not
desirable).

Accumulated states are later merged between encoders in
btf_encoder__add_saved_funcs(). To enable sharing of the elf_functions
table between encoders, two members are introduced to struct
elf_function:
  - elf_function *next - to enable linked-list
  - btf_encoder *encoder - to find elf_function corresponding to a
    particular encoder in a list

Each element of elf_functions->entries is a head of a list that stores
elf_function structs, one for each encoder that searched for this
function name at least once.

btf_encoder__find_function() is modified to perform the search on
shared elf_functions table, and atomically update a corresponding list
as necessary.

At this point each btf_encoder is still maintaining it's own
elf_functions table, but the updated implementation is used.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c | 122 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 96 insertions(+), 26 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 8e8fd05..002358c 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -30,6 +30,7 @@
=20
 #include <assert.h>
 #include <errno.h>
+#include <stdatomic.h>
 #include <stdint.h>
 #include <search.h> /* for tsearch(), tfind() and tdestroy() */
 #include <pthread.h>
@@ -86,10 +87,15 @@ struct btf_encoder_func_state {
 };
=20
 struct elf_function {
+=09/* bsearch key */
 =09const char=09*name;
-=09char=09=09*alias;
-=09bool=09=09 generated;
-=09size_t=09=09prefixlen;
+=09size_t=09=09 prefixlen;
+=09/* for list search */
+=09_Atomic(struct elf_function *) next;
+=09_Atomic(struct btf_encoder *) encoder;
+=09/* encoder-specific state */
+=09char *alias;
+=09bool generated;
 =09struct btf_encoder_func_state state;
 };
=20
@@ -106,7 +112,7 @@ struct elf_functions {
 =09struct list_head node; /* for elf_functions_list */
 =09Elf *elf; /* source ELF */
 =09struct elf_symtab *symtab;
-=09struct elf_function *entries;
+=09struct elf_function *entries; /* an array, each element is a head of a =
list */
 =09int cnt;
 =09int suffix_cnt; /* number of .isra, .part etc */
 };
@@ -157,10 +163,29 @@ struct btf_kfunc_set_range {
  */
 static LIST_HEAD(elf_functions_list);
=20
-static inline void elf_functions__delete(struct elf_functions *funcs)
+static void __elf_functions__delete(struct elf_functions *funcs)
 {
+=09struct elf_function *func, *next;
+
+=09for (int i =3D 0; i < funcs->cnt; i++) {
+=09=09/* free all list elements except the head */
+=09=09func =3D funcs->entries[i].next;
+=09=09while (func) {
+=09=09=09next =3D func->next;
+=09=09=09free(func->alias);
+=09=09=09zfree(&func->state.annots);
+=09=09=09zfree(&func->state.parms);
+=09=09=09free(func);
+=09=09=09func =3D next;
+=09=09}
+=09}
 =09free(funcs->entries);
 =09elf_symtab__delete(funcs->symtab);
+}
+
+static inline void elf_functions__delete(struct elf_functions *funcs)
+{
+=09__elf_functions__delete(funcs);
 =09list_del(&funcs->node);
 =09free(funcs);
 }
@@ -1296,12 +1321,30 @@ static int32_t btf_encoder__add_func(struct btf_enc=
oder *encoder, struct functio
 =09return 0;
 }
=20
+#define for_each_elf_function(func, head) \
+=09for (struct elf_function *func =3D head; func; func =3D func->next)
+
+static inline struct elf_function *find_elf_function(struct elf_function *=
list_head,
+=09=09=09=09=09=09     const struct btf_encoder *encoder)
+{
+=09for_each_elf_function(f, list_head) {
+=09=09if (f->encoder =3D=3D encoder)
+=09=09=09return f;
+=09}
+
+=09return NULL;
+}
+
 static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
 {
 =09int i;
=20
 =09for (i =3D 0; i < encoder->functions.cnt; i++) {
-=09=09struct elf_function *func =3D &encoder->functions.entries[i];
+=09=09struct elf_function *func =3D find_elf_function(&encoder->functions.=
entries[i], encoder);
+
+=09=09if (!func)
+=09=09=09continue;
+
 =09=09struct btf_encoder_func_state *state =3D &func->state;
 =09=09struct btf_encoder *other_encoder =3D NULL;
=20
@@ -1315,11 +1358,11 @@ static int btf_encoder__add_saved_funcs(struct btf_=
encoder *encoder)
 =09=09=09struct elf_function *other_func;
 =09=09=09struct btf_encoder_func_state *other_state;
 =09=09=09uint8_t optimized, unexpected, inconsistent;
+=09=09=09other_func =3D find_elf_function(&other_encoder->functions.entrie=
s[i], other_encoder);
=20
-=09=09=09if (other_encoder =3D=3D encoder)
+=09=09=09if (other_encoder =3D=3D encoder || !other_func)
 =09=09=09=09continue;
=20
-=09=09=09other_func =3D &other_encoder->functions.entries[i];
 =09=09=09other_state =3D &other_func->state;
 =09=09=09if (!other_state->initialized)
 =09=09=09=09continue;
@@ -1389,12 +1432,53 @@ static int elf_functions__collect_function(struct e=
lf_functions *functions, GElf
 =09return 0;
 }
=20
-static struct elf_function *btf_encoder__find_function(const struct btf_en=
coder *encoder,
-=09=09=09=09=09=09       const char *name, size_t prefixlen)
+static struct elf_function *btf_encoder__find_function(struct btf_encoder =
*encoder,
+=09=09=09=09=09=09       const char *name,
+=09=09=09=09=09=09       size_t prefixlen)
 {
 =09struct elf_function key =3D { .name =3D name, .prefixlen =3D prefixlen =
};
+=09struct elf_function *func, *head, *tmp;
+
+=09head =3D bsearch(&key,
+=09=09       encoder->functions.entries,
+=09=09       encoder->functions.cnt,
+=09=09       sizeof(key),
+=09=09       functions_cmp);
+
+=09/* If head is NULL, then there was no such function name in Elf */
+=09if (!head)
+=09=09return NULL;
=20
-=09return bsearch(&key, encoder->functions.entries, encoder->functions.cnt=
, sizeof(key), functions_cmp);
+=09/* If head->encoder is NULL, then calling btf_encoder is the
+=09 * first one to encounter this function name.  In this case
+=09 * try to claim the head.
+=09 */
+=09tmp =3D NULL;
+=09if (atomic_compare_exchange_strong(&head->encoder, &tmp, encoder))
+=09=09return head;
+
+=09/* If the head is already claimed (or if current claim attempt
+=09 * failed), search through the list, and add new elf_function
+=09 * for this encoder if not found.
+=09 */
+=09func =3D find_elf_function(head, encoder);
+=09if (!func) {
+=09=09func =3D zalloc(sizeof(*func));
+=09=09func->name =3D head->name;
+=09=09func->prefixlen =3D head->prefixlen;
+=09=09/* Whenever btf_encoder allocates a new elf_function, it sets
+=09=09 * itself as its encoder. So if the first search through the list
+=09=09 * didn't find an elf_function, we can be sure no other
+=09=09 * encoder would add it.  Therefore we only have to ensure
+=09=09 * that the head->next is updated atomically.
+=09=09 */
+=09=09func->encoder =3D encoder;
+=09=09do {
+=09=09=09func->next =3D head->next;
+=09=09} while (!atomic_compare_exchange_weak(&head->next, &func->next, fun=
c));
+=09}
+
+=09return func;
 }
=20
 static bool btf_name_char_ok(char c, bool first)
@@ -2506,18 +2590,9 @@ out_delete:
 =09return NULL;
 }
=20
-void btf_encoder__delete_func(struct elf_function *func)
-{
-=09free(func->alias);
-=09zfree(&func->state.annots);
-=09zfree(&func->state.parms);
-}
-
 void btf_encoder__delete(struct btf_encoder *encoder)
 {
-=09int i;
 =09size_t shndx;
-
 =09if (encoder =3D=3D NULL)
 =09=09return;
=20
@@ -2528,13 +2603,8 @@ void btf_encoder__delete(struct btf_encoder *encoder=
)
 =09zfree(&encoder->source_filename);
 =09btf__free(encoder->btf);
 =09encoder->btf =3D NULL;
-=09elf_symtab__delete(encoder->symtab);
=20
-=09for (i =3D 0; i < encoder->functions.cnt; i++)
-=09=09btf_encoder__delete_func(&encoder->functions.entries[i]);
-=09encoder->functions.cnt =3D 0;
-=09free(encoder->functions.entries);
-=09encoder->functions.entries =3D NULL;
+=09__elf_functions__delete(&encoder->functions);
=20
 =09free(encoder);
 }
--=20
2.43.0


