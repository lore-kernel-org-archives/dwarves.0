Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF2418FDAB
	for <dwarves@vger.kernel.org>; Wed,  9 Oct 2024 23:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728516950; cv=none; b=F8WNuxe/Dt18piUXH8gTfDQH3EFs880ryK5e7fbKbLNyp8DaTVbBYByxlEsko7uzb3I+unwHsrS+JtQ8E82CmIMEG7RwBw8cCkRZ2PyHCss15Czv6UzguonlkcZBEi+5+lh6RUJB63YDeEq93yOefhh7EaFt6x/AmpF+kmb1fw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728516950; c=relaxed/simple;
	bh=6Wv1RqYHB7rZpDD61oJHKwTTX9iLKGo4JY1LXyvqOy8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KsqQIdnVZRYdPu9x2jVm/HhyggsKHYVmvSUgX2J71thfbzka90OsDbjedRW3PNmRvh5gG7e87DbXChA7ehUYj79MLaDVdgDPOH4SIpzu3woolscFaFzO5n+LqK0vgg1MZ7GdqRarWNl3EO3q3QH08tX9uRrS43qZhi3LmM6qUeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=BzdRN2Vb; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="BzdRN2Vb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728516946; x=1728776146;
	bh=9uoo33ZxCkuupW9PZTQs9XD1HDrtxeQrZphHccw0ul8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=BzdRN2Vbq4fir307Bfe6L+9vTg1gkfDyLEUfj89uVxeeLquxGiFcPXpBIRher/o3b
	 6c6E5XSTOqSTiUenD2AuZC9syYrW7ODED1aw3koIK6Nx6jn2M/XgVuvDUOqpV5Jh6L
	 0k9qwF2IXm+fzKLPyLE811J4IIYAslHpVp23WzNp2oFqiHMmBGxF1Kq71nOa1GxUvs
	 F9YwHN09iJ9uQtUwPW7z625XkY7+PiiMSJ2OfmU0iTTV0wRaamup2ebA0nj+K9Zp7y
	 RDBGDNmyV1iKD65WB6CPh/1itbAdxBnSLRMpVL0NwnQhc2jcPsvN5Z4dn8i/IlchZ/
	 3q+q3R0NHK87A==
Date: Wed, 09 Oct 2024 23:35:44 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org, eddyz87@gmail.com
Subject: [PATCH v2 dwarves 5/5] btf_encoder: switch to shared elf_functions table
Message-ID: <20241009233520.989453-6-ihor.solodrai@pm.me>
In-Reply-To: <20241009233520.989453-1-ihor.solodrai@pm.me>
References: <20241009233520.989453-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 8200212d70e951dfc699dd0faaea0810e7f312e6
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Do not collect functions from ELF for each new btf_encoder, and
instead set a pointer to a shared elf_functions table, built
beforehand by btf_encoder__pre_cus__load_module().

Change the algorithm of btf_encoder__add_saved_funcs(): traverse
elf_functions table once, merge function state for each list of
elf_function, and add each function to the BTF of the owner of the
first elf_function of the list.

Do not call btf_encoder__add_saved_funcs() on every
btf_encoder__add_encoder(). Instead, introduce
btf_encoder__merge_encoders() function that does that once.

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c | 113 +++++++++++++++++++++++++++-----------------------
 btf_encoder.h |   3 +-
 pahole.c      |  25 ++++++-----
 3 files changed, 78 insertions(+), 63 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index f88c2e1..07d2031 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -140,7 +140,7 @@ struct btf_encoder {
 =09struct elf_secinfo *secinfo;
 =09size_t             seccnt;
 =09int                encode_vars;
-=09struct elf_functions functions;
+=09struct elf_functions *functions;
 };
=20
 struct btf_func {
@@ -243,8 +243,6 @@ int btf_encoder__pre_cus__load_module(struct process_dw=
flmod_parms *parms, Dwfl_
 static LIST_HEAD(encoders);
 static pthread_mutex_t encoders__lock =3D PTHREAD_MUTEX_INITIALIZER;
=20
-static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder);
-
 /* mutex only needed for add/delete, as this can happen in multiple encodi=
ng
  * threads.  Traversal of the list is currently confined to thread collect=
ion.
  */
@@ -890,14 +888,12 @@ static int32_t btf_encoder__add_var_secinfo(struct bt=
f_encoder *encoder, size_t
 =09return gobuffer__add(&encoder->secinfo[shndx].secinfo, &si, sizeof(si))=
;
 }
=20
-int32_t btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_e=
ncoder *other)
+static int32_t btf_encoder__add_encoder(struct btf_encoder *encoder, struc=
t btf_encoder *other)
 {
 =09size_t shndx;
 =09if (encoder =3D=3D other)
 =09=09return 0;
=20
-=09btf_encoder__add_saved_funcs(other);
-
 =09for (shndx =3D 1; shndx < other->seccnt; shndx++) {
 =09=09struct gobuffer *var_secinfo_buf =3D &other->secinfo[shndx].secinfo;
 =09=09size_t sz =3D gobuffer__size(var_secinfo_buf);
@@ -925,6 +921,25 @@ int32_t btf_encoder__add_encoder(struct btf_encoder *e=
ncoder, struct btf_encoder
 =09return btf__add_btf(encoder->btf, other->btf);
 }
=20
+int btf_encoder__merge_encoders(struct btf_encoder *base_encoder, struct b=
tf_encoder **encoders, int nr_encoders)
+{
+=09int err;
+
+=09err =3D btf_encoder__add_saved_funcs(base_encoder);
+=09if (err < 0)
+=09=09return err;
+
+=09for (int i =3D 0; i < nr_encoders; i++) {
+=09=09if (base_encoder =3D=3D encoders[i])
+=09=09=09continue;
+=09=09err =3D btf_encoder__add_encoder(base_encoder, encoders[i]);
+=09=09if (err < 0)
+=09=09=09return err;
+=09}
+
+=09return 0;
+}
+
 static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, size_=
t shndx)
 {
 =09struct gobuffer *var_secinfo_buf =3D &encoder->secinfo[shndx].secinfo;
@@ -991,7 +1006,7 @@ static int32_t btf_encoder__add_decl_tag(struct btf_en=
coder *encoder, const char
 =09return id;
 }
=20
-static void btf_encoder__log_func_skip(struct btf_encoder *encoder, struct=
 elf_function *func,
+static void btf_encoder__log_func_skip(const struct btf_encoder *encoder, =
struct elf_function *func,
 =09=09=09=09       const char *fmt, ...)
 {
 =09va_list ap;
@@ -1027,7 +1042,7 @@ static int fwd__kind(const struct btf_type *t)
 =09return btf_kind(t);
 }
=20
-static bool types__match(struct btf_encoder *encoder,
+static bool types__match(const struct btf_encoder *encoder,
 =09=09=09 struct btf *btf1, int type_id1,
 =09=09=09 struct btf *btf2, int type_id2)
 {
@@ -1126,7 +1141,7 @@ static bool types__match(struct btf_encoder *encoder,
 =09return false;
 }
=20
-static bool funcs__match(struct btf_encoder *encoder, struct elf_function =
*func,
+static bool funcs__match(const struct btf_encoder *encoder, struct elf_fun=
ction *func,
 =09=09=09 struct btf *btf1, struct btf_encoder_func_state *s1,
 =09=09=09 struct btf *btf2, struct btf_encoder_func_state *s2)
 {
@@ -1340,44 +1355,51 @@ static inline struct elf_function *find_elf_functio=
n_in_list(struct elf_function
 =09return NULL;
 }
=20
-static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
+
+// Each element of elf_functions->entries is a list of a variable
+// number of elf_function structs, because not all encoders saved a
+// particular function.  However each function saved by at least one
+// encoder needs to be added to BTF _somewhere_. Here we traverse the
+// entire elf_functions table, and for each list of elf_function
+// structs a function is added to the BTF of the encoder of the first
+// elf_function in the list.
+int btf_encoder__add_saved_funcs(struct btf_encoder *base_encoder)
 {
-=09int i;
+=09struct elf_functions *functions =3D base_encoder->functions;
=20
-=09for (i =3D 0; i < encoder->functions.cnt; i++) {
-=09=09struct elf_function *func =3D find_elf_function_in_list(&encoder->fu=
nctions.entries[i], encoder);
+=09for (int i =3D 0; i < functions->cnt; i++) {
+=09=09struct elf_function *list_head =3D &functions->entries[i];
+=09=09struct btf_encoder_func_state *state;
+=09=09struct elf_function *func;
=20
-=09=09if (!func)
+=09=09// list_head without an owner means no encoder
+=09=09// has saved a function with this name
+=09=09if (!list_head->owner)
 =09=09=09continue;
=20
-=09=09struct btf_encoder_func_state *state =3D &func->state;
-=09=09struct btf_encoder *other_encoder =3D NULL;
+=09=09func =3D list_head;
+=09=09state =3D &func->state;
=20
 =09=09if (!state->initialized || state->processed)
 =09=09=09continue;
-=09=09/* merge optimized-out status across encoders; since each
-=09=09 * encoder has the same elf symbol table we can use the
-=09=09 * same index to access the same elf symbol.
-=09=09 */
-=09=09btf_encoders__for_each_encoder(other_encoder) {
-=09=09=09struct elf_function *other_func;
-=09=09=09struct btf_encoder_func_state *other_state;
-=09=09=09uint8_t optimized, unexpected, inconsistent;
-=09=09=09other_func =3D find_elf_function_in_list(&other_encoder->function=
s.entries[i], other_encoder);
=20
-=09=09=09if (other_encoder =3D=3D encoder || !other_func)
+=09=09for_each_elf_function(other_func, list_head) {
+=09=09=09if (func =3D=3D other_func)
 =09=09=09=09continue;
=20
-=09=09=09other_state =3D &other_func->state;
-=09=09=09if (!other_state->initialized)
+=09=09=09struct btf_encoder_func_state *other_state =3D &other_func->state=
;
+=09=09=09uint8_t optimized, unexpected, inconsistent;
+
+=09=09=09if (!other_func || !other_state->initialized || other_state->proc=
essed)
 =09=09=09=09continue;
+
 =09=09=09optimized =3D state->optimized_parms | other_state->optimized_par=
ms;
 =09=09=09unexpected =3D state->unexpected_reg | other_state->unexpected_re=
g;
 =09=09=09inconsistent =3D state->inconsistent_proto | other_state->inconsi=
stent_proto;
 =09=09=09if (!unexpected && !inconsistent &&
-=09=09=09    !funcs__match(encoder, func,
-=09=09=09=09=09  encoder->btf, state,
-=09=09=09=09=09  other_encoder->btf, other_state))
+=09=09=09    !funcs__match(func->owner, func,
+=09=09=09=09=09  func->owner->btf, state,
+=09=09=09=09=09  other_func->owner->btf, other_state))
 =09=09=09=09inconsistent =3D 1;
 =09=09=09state->optimized_parms =3D other_state->optimized_parms =3D optim=
ized;
 =09=09=09state->unexpected_reg =3D other_state->unexpected_reg =3D unexpec=
ted;
@@ -1391,7 +1413,7 @@ static int btf_encoder__add_saved_funcs(struct btf_en=
coder *encoder)
 =09=09 * unexpected register use or multiple inconsistent prototypes.
 =09=09 */
 =09=09if (!state->unexpected_reg && !state->inconsistent_proto) {
-=09=09=09if (btf_encoder__add_func(encoder, NULL, func))
+=09=09=09if (btf_encoder__add_func((struct btf_encoder *)func->owner, NULL=
, func))
 =09=09=09=09return -1;
 =09=09}
 =09=09state->processed =3D 1;
@@ -1442,8 +1464,8 @@ static struct elf_function *btf_encoder__find_functio=
n(const struct btf_encoder
 {
 =09struct elf_function key =3D { .name =3D name, .prefixlen =3D prefixlen =
};
 =09struct elf_function *head =3D bsearch(&key,
-=09=09=09=09=09    encoder->functions.entries,
-=09=09=09=09=09    encoder->functions.cnt,
+=09=09=09=09=09    encoder->functions->entries,
+=09=09=09=09=09    encoder->functions->cnt,
 =09=09=09=09=09    sizeof(key),
 =09=09=09=09=09    functions_cmp);
 =09struct elf_function *func =3D NULL;
@@ -2169,9 +2191,6 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 =09int err;
 =09size_t shndx;
=20
-=09/* for single-threaded case, saved funcs are added here */
-=09btf_encoder__add_saved_funcs(encoder);
-
 =09for (shndx =3D 1; shndx < encoder->seccnt; shndx++)
 =09=09if (gobuffer__size(&encoder->secinfo[shndx].secinfo))
 =09=09=09btf_encoder__add_datasec(encoder, shndx);
@@ -2222,11 +2241,8 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 =09=09err =3D btf_encoder__write_elf(encoder, encoder->btf, BTF_ELF_SEC);
 =09}
=20
-=09// TODO: after moving encoders to shared elf_functions,
-=09// replace elf_functions__get(encoder->functions.elf) here
-=09// with encoder->functions
-=09// The pointer to shared elf_functions will be set in btf_encoder__new
-=09elf_functions__delete(elf_functions__get(encoder->functions.elf));
+=09// Delete the shared elf_functions table, because we are done encoding
+=09elf_functions__delete(encoder->functions);
=20
 =09return err;
 }
@@ -2525,8 +2541,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
onst char *detached_filenam
 =09=09=09=09printf("%s: '%s' doesn't have symtab.\n", __func__, cu->filena=
me);
 =09=09=09goto out;
 =09=09}
-=09=09encoder->functions.symtab =3D encoder->symtab;
-=09=09encoder->functions.elf =3D cu->elf;
+=09=09encoder->functions =3D elf_functions__get(cu->elf);
=20
 =09=09/* index the ELF sections for later lookup */
=20
@@ -2565,9 +2580,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
onst char *detached_filenam
 =09=09if (!found_percpu && encoder->verbose)
 =09=09=09printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->file=
name, PERCPU_SECTION);
=20
-=09=09if (elf_functions__collect(&encoder->functions))
-=09=09=09goto out_delete;
-
 =09=09if (encoder->verbose)
 =09=09=09printf("File %s:\n", cu->filename);
 =09=09btf_encoders__add(encoder);
@@ -2593,8 +2605,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 =09zfree(&encoder->source_filename);
 =09btf__free(encoder->btf);
 =09encoder->btf =3D NULL;
-
-=09__elf_functions__delete(&encoder->functions);
+=09elf_symtab__delete(encoder->symtab);
=20
=20
 =09free(encoder);
@@ -2694,7 +2705,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encode=
r, struct cu *cu, struct co
 =09=09=09continue;
 =09=09if (!ftype__has_arg_names(&fn->proto))
 =09=09=09continue;
-=09=09if (encoder->functions.cnt) {
+=09=09if (encoder->functions->cnt) {
 =09=09=09const char *name;
=20
 =09=09=09name =3D function__name(fn);
@@ -2710,7 +2721,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encode=
r, struct cu *cu, struct co
 =09=09=09=09=09save =3D true;
 =09=09=09=09else
 =09=09=09=09=09func->generated =3D true;
-=09=09=09} else if (encoder->functions.suffix_cnt &&
+=09=09=09} else if (encoder->functions->suffix_cnt &&
 =09=09=09=09   conf_load->btf_gen_optimized) {
 =09=09=09=09/* falling back to name.isra.0 match if no exact
 =09=09=09=09 * match is found; only bother if we found any
diff --git a/btf_encoder.h b/btf_encoder.h
index 7bfc994..2fb4fc6 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -32,7 +32,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, s=
truct cu *cu, struct co
=20
 struct btf *btf_encoder__btf(struct btf_encoder *encoder);
=20
-int btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encod=
er *other);
+int btf_encoder__add_saved_funcs(struct btf_encoder *encoder);
+int btf_encoder__merge_encoders(struct btf_encoder *base_encoder, struct b=
tf_encoder **encoders, int nr_encoders);
=20
 int btf_encoder__pre_cus__load_module(struct process_dwflmod_parms *parms,=
 Dwfl_Module *mod, Dwarf *dw, Elf *elf);
=20
diff --git a/pahole.c b/pahole.c
index 0ff6bc2..a45aa7a 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3256,23 +3256,23 @@ static int pahole_threads_collect(struct conf_load =
*conf, int nr_threads, void *
 =09=09=09=09  int error)
 {
 =09struct thread_data **threads =3D (struct thread_data **)thr_data;
+=09struct btf_encoder *encoders[nr_threads];
 =09int i;
 =09int err =3D 0;
=20
 =09if (error)
 =09=09goto out;
=20
-=09for (i =3D 0; i < nr_threads; i++) {
-=09=09/*
-=09=09 * Merge content of the btf instances of worker threads to the btf
-=09=09 * instance of the primary btf_encoder.
-                */
-=09=09if (!threads[i]->btf)
-=09=09=09continue;
-=09=09err =3D btf_encoder__add_encoder(btf_encoder, threads[i]->encoder);
-=09=09if (err < 0)
-=09=09=09goto out;
-=09}
+=09for (i =3D 0; i < nr_threads; i++)
+=09=09encoders[i] =3D threads[i]->encoder;
+
+=09/*
+=09 * Merge content of the btf instances of worker threads to the btf
+=09 * instance of the primary btf_encoder.
+=09 */
+=09err =3D btf_encoder__merge_encoders(btf_encoder, encoders, nr_threads);
+=09if (err < 0)
+=09=09goto out;
 =09err =3D 0;
=20
 out:
@@ -3915,6 +3915,9 @@ try_sole_arg_as_class_names:
 =09=09=09exit(1);
 =09=09}
=20
+=09=09if (conf_load.nr_jobs <=3D 1 || conf_load.reproducible_build)
+=09=09=09btf_encoder__add_saved_funcs(btf_encoder);
+
 =09=09err =3D btf_encoder__encode(btf_encoder);
 =09=09if (err) {
 =09=09=09fputs("Failed to encode BTF\n", stderr);
--=20
2.43.0


