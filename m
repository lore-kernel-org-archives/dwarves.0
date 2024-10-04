Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4C7374D1
	for <dwarves@vger.kernel.org>; Fri,  4 Oct 2024 05:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728018862; cv=none; b=LrXoHqBKjZ0IXfQ96cNN/eO6GUHJGXrUKBES3VKDOzZlp3BRSh6gOJtEN9ujAzhvyESxiLY1wLwEKOxTJwevGG5AHesQmVCPbm0RhcmmBg9U98nDGj/APOANGSvdFHebsQ2pL/52J/yx3ZwFxlrVaRAhOmqrpbwgTs8M17+JXno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728018862; c=relaxed/simple;
	bh=7RZa2M5YShALw69kIUsKt7WpzDi0q7kUOXqBTmvlqkI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDbZAeIjPpt6WCsY7TLE1xbU8oVC9TxTHnT/wGqfhAQOtotc4LVOS2bPKGpdiNr1xaZ/WeBDdJrb4ViKP79+Q9CKWz/BBvZdVLXQwBIKXPZD0jzCvyUKhSmcBbrcf8dvhJ5CqAtCI9up/UBFidyY3NW7oV+ePLf5JL9ACQFpT0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=mZOo0m8k; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="mZOo0m8k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728018858; x=1728278058;
	bh=H0odYl2OOA/BQhGgiAxgMpyVeVQmBxKOR44c+Y+ezaY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=mZOo0m8kYp8nFJjqqOH39IUcyUOC56j3/VopsaJbRdZaoXBdXtzQVCj7rYBVmgnaO
	 amH4a73DH7nAznCxBM2OgS6zuknb9GlqvWtr+7zZNG3zzznD0gjRUHG3Kg/LBejExL
	 WBXcWELM195Oep+LEtYCH2l+K0AQOEf2H3e/wj0RtS+ziLeJE1a98J60zwKxnp3C/j
	 /jR9wR6XZHXCX5WGF4tossu+Gf/djfoJLjQNUhnYU44jYChMsWrhQ3FWt04ptWzJMn
	 H6lKk2iVOVfYlhRIlKVXg46UT9ZE8bqFQOrJOuszayE1FHICCNXk39RAxLEyxaV/So
	 AHkRGWqLszseQ==
Date: Fri, 04 Oct 2024 05:14:13 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org, eddyz87@gmail.com
Subject: [PATCH dwarves 5/6] btf_encoder: introduce elf_functions_entry
Message-ID: <20241004051347.41143-6-ihor.solodrai@pm.me>
In-Reply-To: <20241004051347.41143-1-ihor.solodrai@pm.me>
References: <20241004051347.41143-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 676e13860faf21321eb745af45a0e70666968bf2
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
elf_functions table is maintained for each btf_encoder this is not an
issue, because every btf_encoder_func_state available to this encoder
can only reference its own BTF. However, if elf_functions becomes
shared, existing elf_function/btf_encoder_function_state structs can
be produced by other encoders with their own BTFs. In this case
funcs_match() can not be called unless BTFs are available and writes
to them are synchronized in some manner (which is not desirable).

Accumulated states are later merged between encoders in
btf_encoder__add_saved_funcs(). To enable sharing elf_functions table
between encoders it is changed from an array of elf_function structs
into an array of elf_function_entry. Each entry stores a linked listed
of elf_function structs, one for each encoder that searched for this
name at least once.

To be able to identify a btf_encoder owner of the elf_function, a
const pointer to btf_encoder field is added, as well as next pointer
to enable a list.

At this point each btf_encoder is still maintaining it's own
elf_functions table, but the updated implementation is used.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c | 113 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 84 insertions(+), 29 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 0d4a4fe..33cd9eb 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -91,6 +91,8 @@ struct elf_function {
 =09bool=09=09 generated;
 =09size_t=09=09prefixlen;
 =09struct btf_encoder_func_state state;
+=09const struct btf_encoder *owner;
+=09struct elf_function *next;
 };
=20
 struct var_info {
@@ -105,11 +107,17 @@ struct elf_secinfo {
 =09uint64_t    sz;
 };
=20
+struct elf_functions_entry {
+=09const char *name;
+=09size_t prefixlen;
+=09struct elf_function *funcs; // list of elf_function
+};
+
 struct elf_functions {
 =09struct list_head node; // for elf_functions_list
 =09Elf *elf; // source ELF
 =09struct elf_symtab *symtab;
-=09struct elf_function *entries;
+=09struct elf_functions_entry *entries;
 =09int allocated;
 =09int cnt;
 =09int suffix_cnt;
@@ -181,10 +189,30 @@ static struct elf_functions *elf_functions__get(Elf *=
elf)
 =09return NULL;
 }
=20
-static inline void elf_functions__delete(struct elf_functions *funcs)
+static void elf_functions_entry__delete(struct elf_functions_entry *entry)
+{
+=09struct elf_function *func =3D entry->funcs;
+=09while (func) {
+=09=09struct elf_function *next =3D func->next;
+=09=09free(func->alias);
+=09=09zfree(&func->state.annots);
+=09=09zfree(&func->state.parms);
+=09=09free(func);
+=09=09func =3D next;
+=09}
+}
+
+static inline void __elf_functions__delete(struct elf_functions *funcs)
 {
+=09for (int i =3D 0; i < funcs->cnt; i++)
+=09=09elf_functions_entry__delete(&funcs->entries[i]);
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
@@ -216,6 +244,7 @@ out_error:
 =09return NULL;
 }
=20
+
 int btf_encoder__pre_cus__load_module(struct process_dwflmod_parms *parms,=
 Dwfl_Module *mod, Dwarf *dw, Elf *elf)
 {
 =09struct elf_functions *funcs =3D elf_functions__new(elf);
@@ -1303,12 +1332,30 @@ static int32_t btf_encoder__add_func(struct btf_enc=
oder *encoder, struct functio
 =09return 0;
 }
=20
+#define for_each_elf_function(func, entry) \
+=09for (struct elf_function *func =3D entry->funcs; func; func =3D func->n=
ext)
+
+static inline struct elf_function *find_elf_function_in_entry(struct elf_f=
unctions_entry *entry,
+=09=09=09=09=09=09=09      const struct btf_encoder *encoder)
+{
+=09for_each_elf_function(f, entry) {
+=09=09if (f->owner =3D=3D encoder)
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
+=09=09struct elf_function *func =3D find_elf_function_in_entry(&encoder->f=
unctions.entries[i], encoder);
+
+=09=09if (!func)
+=09=09=09continue;
+
 =09=09struct btf_encoder_func_state *state =3D &func->state;
 =09=09struct btf_encoder *other_encoder =3D NULL;
=20
@@ -1322,11 +1369,11 @@ static int btf_encoder__add_saved_funcs(struct btf_=
encoder *encoder)
 =09=09=09struct elf_function *other_func;
 =09=09=09struct btf_encoder_func_state *other_state;
 =09=09=09uint8_t optimized, unexpected, inconsistent;
+=09=09=09other_func =3D find_elf_function_in_entry(&other_encoder->functio=
ns.entries[i], other_encoder);
=20
-=09=09=09if (other_encoder =3D=3D encoder)
+=09=09=09if (other_encoder =3D=3D encoder || !other_func)
 =09=09=09=09continue;
=20
-=09=09=09other_func =3D &other_encoder->functions.entries[i];
 =09=09=09other_state =3D &other_func->state;
 =09=09=09if (!other_state->initialized)
 =09=09=09=09continue;
@@ -1360,8 +1407,8 @@ static int btf_encoder__add_saved_funcs(struct btf_en=
coder *encoder)
=20
 static int functions_cmp(const void *_a, const void *_b)
 {
-=09const struct elf_function *a =3D _a;
-=09const struct elf_function *b =3D _b;
+=09const struct elf_functions_entry *a =3D _a;
+=09const struct elf_functions_entry *b =3D _b;
=20
 =09/* if search key allows prefix match, verify target has matching
 =09 * prefix len and prefix matches.
@@ -1387,7 +1434,7 @@ static void *reallocarray_grow(void *ptr, int *nmemb,=
 size_t size)
=20
 static int elf_functions__collect_function(struct elf_functions *functions=
, GElf_Sym *sym)
 {
-=09struct elf_function *new;
+=09struct elf_functions_entry *new;
 =09const char *name;
=20
 =09if (elf_sym__type(sym) !=3D STT_FUNC)
@@ -1410,14 +1457,14 @@ static int elf_functions__collect_function(struct e=
lf_functions *functions, GElf
 =09=09functions->entries =3D new;
 =09}
=20
-=09struct elf_function *func =3D &functions->entries[functions->cnt];
+=09struct elf_functions_entry *entry =3D &functions->entries[functions->cn=
t];
=20
-=09memset(func, 0, sizeof(*func));
-=09func->name =3D name;
+=09memset(entry, 0, sizeof(*entry));
+=09entry->name =3D name;
 =09if (strchr(name, '.')) {
 =09=09const char *suffix =3D strchr(name, '.');
 =09=09functions->suffix_cnt++;
-=09=09func->prefixlen =3D suffix - name;
+=09=09entry->prefixlen =3D suffix - name;
 =09}
 =09functions->cnt++;
=20
@@ -1427,9 +1474,30 @@ static int elf_functions__collect_function(struct el=
f_functions *functions, GElf
 static struct elf_function *btf_encoder__find_function(const struct btf_en=
coder *encoder,
 =09=09=09=09=09=09       const char *name, size_t prefixlen)
 {
-=09struct elf_function key =3D { .name =3D name, .prefixlen =3D prefixlen =
};
+=09struct elf_function *func =3D NULL;
+=09struct elf_functions_entry key =3D { .name =3D name, .prefixlen =3D pre=
fixlen };
+=09struct elf_functions_entry *entry =3D bsearch(&key,
+=09=09=09=09=09=09    encoder->functions.entries,
+=09=09=09=09=09=09    encoder->functions.cnt,
+=09=09=09=09=09=09    sizeof(key),
+=09=09=09=09=09=09    functions_cmp);
+=09if (entry) {
+=09=09// If entry is found then there is a name match.
+=09=09func =3D find_elf_function_in_entry(entry, encoder);
+=09=09// However if there is no elf_function for this encoder in the entry=
,
+=09=09// it means the encoder encountered this name for the first time.
+=09=09// In such case allocate space for new elf_function and add it to th=
e entry.
+=09=09if (!func) {
+=09=09=09func =3D zalloc(sizeof(*func));
+=09=09=09func->name =3D entry->name;
+=09=09=09func->prefixlen =3D entry->prefixlen;
+=09=09=09func->owner =3D encoder;
+=09=09=09func->next =3D entry->funcs;
+=09=09=09entry->funcs =3D func;
+=09=09}
+=09}
=20
-=09return bsearch(&key, encoder->functions.entries, encoder->functions.cnt=
, sizeof(key), functions_cmp);
+=09return func;
 }
=20
 static bool btf_name_char_ok(char c, bool first)
@@ -2563,17 +2631,8 @@ out_delete:
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
-
 =09if (encoder =3D=3D NULL)
 =09=09return;
=20
@@ -2583,13 +2642,9 @@ void btf_encoder__delete(struct btf_encoder *encoder=
)
 =09zfree(&encoder->source_filename);
 =09btf__free(encoder->btf);
 =09encoder->btf =3D NULL;
-=09elf_symtab__delete(encoder->symtab);
=20
-=09for (i =3D 0; i < encoder->functions.cnt; i++)
-=09=09btf_encoder__delete_func(&encoder->functions.entries[i]);
-=09encoder->functions.allocated =3D encoder->functions.cnt =3D 0;
-=09free(encoder->functions.entries);
-=09encoder->functions.entries =3D NULL;
+=09__elf_functions__delete(&encoder->functions);
+
 =09encoder->percpu.allocated =3D encoder->percpu.var_cnt =3D 0;
 =09free(encoder->percpu.vars);
 =09encoder->percpu.vars =3D NULL;
--=20
2.34.1


