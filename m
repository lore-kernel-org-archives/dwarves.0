Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACCF1E3DD5
	for <dwarves@vger.kernel.org>; Wed,  9 Oct 2024 23:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728516954; cv=none; b=fwan5wVcsRYlgy2AyNDNHlxucABF0vogCyode4uN3co9XnJG6ZiUOhLbF7UUyYf69xbO+qqjtOWUXrOdg3zTjKAx+FCBbwuCl82w1OF3gqMTu/uViL9b0TkGGpCm6Rt2VtLnOB4pi1LoryAjl5Jo7vTvy7Y9MKjxDuLcbBWAhPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728516954; c=relaxed/simple;
	bh=10/xldTk9caNj9rgHdyTFvhcR2L/BXLy3TN/AJOlmL8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZ1SY+KeTg9ilgdrk0cl8wE2JaOJtgxkpJwzTQ+kS9cbfYTOUShQZLn8BbMKQ0TVVhmgT/OoNY6qxeAcV8nJvFZcvMA9XrnillUQd1xNp06tiXApERhw4y2qr568VWtzt52yWH97Yi1o5wr69ytuQQDdokOzgL8j/+ZIvdVVdxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=pK72eAvn; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="pK72eAvn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728516944; x=1728776144;
	bh=JQ6l8WS7IhY6lk+IVp0KnPg7o+RFqVMr7CMcubW79O4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=pK72eAvnJSGft2ng3zyyuXfOP5mZG68mdPLyddvJOg6GEuEra4xuq29OsbjwN29VD
	 Qpo7UwHNA4TwKORRmEgqoE7+ob8eQHUjGJFS9TQcxSwgTtqzC6+0y31tfpZkO850za
	 hof+4UJ4qxGS3pSZECSacRtSVIf35m/tL1BGILgL8qreULptq9i3pMtDJh95AEzZ/6
	 A6rFtWSOoBOJdsF1TkxEfEejCTSEqETDHZWhb5l+d6ovNeG3DWVwq9kUM2VjjZ0utp
	 2s9WevVJ2onzx69Gg+6HG+tNczsyVWORDaF6aXc+jd2SL4qB8QvR+HPQbS9jF9h+Qs
	 +AFuu8DDjWeVA==
Date: Wed, 09 Oct 2024 23:35:39 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org, eddyz87@gmail.com
Subject: [PATCH v2 dwarves 4/5] btf_encoder: make elf_functions.entry an elf_function list
Message-ID: <20241009233520.989453-5-ihor.solodrai@pm.me>
In-Reply-To: <20241009233520.989453-1-ihor.solodrai@pm.me>
References: <20241009233520.989453-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 6801193370f0c1008773595fff8d93878d3fafe0
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
btf_encoder__add_saved_funcs(). To enable sharing of the elf_functions
table between encoders, two members are introduced to struct
elf_function:
  - elf_function *next - to enable linked-list
  - btf_encoder *owner - to find elf_function corresponding to a
    particular encoder in a list

Each element of elf_functions->entries is a head of a list that stores
elf_function structs one for each encoder that searched for this
function name at least once.

btf_encoder__find_function() is modified to perform the search on
shared elf_functions table, and atomically update a corresponding list
as necessary.

At this point each btf_encoder is still maintaining it's own
elf_functions table, but the updated implementation is used.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c | 117 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 93 insertions(+), 24 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 9e05b56..f88c2e1 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -86,10 +86,15 @@ struct btf_encoder_func_state {
 };
=20
 struct elf_function {
+=09// bsearch key
 =09const char=09*name;
-=09char=09=09*alias;
-=09bool=09=09 generated;
-=09size_t=09=09prefixlen;
+=09size_t=09=09 prefixlen;
+=09// for list search
+=09struct elf_function *next;
+=09const struct btf_encoder *owner;
+=09// encoder-specific state
+=09char *alias;
+=09bool generated;
 =09struct btf_encoder_func_state state;
 };
=20
@@ -106,7 +111,7 @@ struct elf_functions {
 =09struct list_head node; // for elf_functions_list
 =09Elf *elf; // source ELF
 =09struct elf_symtab *symtab;
-=09struct elf_function *entries;
+=09struct elf_function *entries; // an array, each element is a head of a =
list
 =09int cnt;
 =09int suffix_cnt; /* number of .isra, .part etc */
 };
@@ -169,10 +174,29 @@ static struct elf_functions *elf_functions__get(Elf *=
elf)
 =09return NULL;
 }
=20
-static inline void elf_functions__delete(struct elf_functions *funcs)
+static void __elf_functions__delete(struct elf_functions *funcs)
 {
+=09for (int i =3D 0; i < funcs->cnt; i++) {
+=09=09// free all list elements except the head
+=09=09struct elf_function *func =3D funcs->entries[i].next;
+
+=09=09while (func) {
+=09=09=09struct elf_function *next =3D func->next;
+
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
@@ -204,6 +228,7 @@ out_error:
 =09return NULL;
 }
=20
+
 int btf_encoder__pre_cus__load_module(struct process_dwflmod_parms *parms,=
 Dwfl_Module *mod, Dwarf *dw, Elf *elf)
 {
 =09struct elf_functions *funcs =3D elf_functions__new(elf);
@@ -1301,12 +1326,30 @@ static int32_t btf_encoder__add_func(struct btf_enc=
oder *encoder, struct functio
 =09return 0;
 }
=20
+#define for_each_elf_function(func, head) \
+=09for (struct elf_function *func =3D head; func; func =3D func->next)
+
+static inline struct elf_function *find_elf_function_in_list(struct elf_fu=
nction *list_head,
+=09=09=09=09=09=09=09     const struct btf_encoder *encoder)
+{
+=09for_each_elf_function(f, list_head) {
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
+=09=09struct elf_function *func =3D find_elf_function_in_list(&encoder->fu=
nctions.entries[i], encoder);
+
+=09=09if (!func)
+=09=09=09continue;
+
 =09=09struct btf_encoder_func_state *state =3D &func->state;
 =09=09struct btf_encoder *other_encoder =3D NULL;
=20
@@ -1320,11 +1363,11 @@ static int btf_encoder__add_saved_funcs(struct btf_=
encoder *encoder)
 =09=09=09struct elf_function *other_func;
 =09=09=09struct btf_encoder_func_state *other_state;
 =09=09=09uint8_t optimized, unexpected, inconsistent;
+=09=09=09other_func =3D find_elf_function_in_list(&other_encoder->function=
s.entries[i], other_encoder);
=20
-=09=09=09if (other_encoder =3D=3D encoder)
+=09=09=09if (other_encoder =3D=3D encoder || !other_func)
 =09=09=09=09continue;
=20
-=09=09=09other_func =3D &other_encoder->functions.entries[i];
 =09=09=09other_state =3D &other_func->state;
 =09=09=09if (!other_state->initialized)
 =09=09=09=09continue;
@@ -1398,8 +1441,47 @@ static struct elf_function *btf_encoder__find_functi=
on(const struct btf_encoder
 =09=09=09=09=09=09       const char *name, size_t prefixlen)
 {
 =09struct elf_function key =3D { .name =3D name, .prefixlen =3D prefixlen =
};
+=09struct elf_function *head =3D bsearch(&key,
+=09=09=09=09=09    encoder->functions.entries,
+=09=09=09=09=09    encoder->functions.cnt,
+=09=09=09=09=09    sizeof(key),
+=09=09=09=09=09    functions_cmp);
+=09struct elf_function *func =3D NULL;
+=09bool success =3D false;
+
+=09if (!head)
+=09=09return NULL;
+
+=09// If head->owner is NULL, then calling btf_encoder is the
+=09// first one to encounter this function name.  In this case
+=09// try to claim the head.
+=09if (head->owner =3D=3D NULL) {
+=09=09bool success =3D __sync_bool_compare_and_swap(&head->owner, NULL, en=
coder);
+
+=09=09if (success)
+=09=09=09return head;
+=09}
+
+=09// Otherwise (or if claim failed), search through the list,
+=09// and add new elf_function for this encoder if not found.
+=09func =3D find_elf_function_in_list(head, encoder);
+=09if (!func) {
+=09=09func =3D zalloc(sizeof(*func));
+=09=09func->name =3D head->name;
+=09=09func->prefixlen =3D head->prefixlen;
+=09=09// Whenever btf_encoder allocates a new elf_function, it sets
+=09=09// itself as owner. So if the first search through the list
+=09=09// didn't find an elf_function, we can be sure no other
+=09=09// encoder would add it.  Therefore we only have to ensure
+=09=09// that the head->next is updated atomically.
+=09=09func->owner =3D encoder;
+=09=09do {
+=09=09=09func->next =3D head->next;
+=09=09=09success =3D __sync_bool_compare_and_swap(&head->next, func->next,=
 func);
+=09=09} while (!success);
+=09}
=20
-=09return bsearch(&key, encoder->functions.entries, encoder->functions.cnt=
, sizeof(key), functions_cmp);
+=09return func;
 }
=20
 static bool btf_name_char_ok(char c, bool first)
@@ -2498,18 +2580,9 @@ out_delete:
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
@@ -2520,13 +2593,9 @@ void btf_encoder__delete(struct btf_encoder *encoder=
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
+
=20
 =09free(encoder);
 }
--=20
2.43.0


