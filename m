Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9D8374D1
	for <dwarves@vger.kernel.org>; Fri,  4 Oct 2024 05:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728018871; cv=none; b=aT7OHwy0d81Qb2nmBlRUO+ZpBBaAhjrpYGOKiNmZ8+UgX180EHj1kBDSQWOs7rdQ1DjBo2BaLz3ed9C9aQYskaXNYO64drMra+MLampy8v6OojUfVmO1s1EjxzsFkZHIfCxlPKVRVHh9RPGHwyQ0xm2yPR5NDNSTZmtto1eGz0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728018871; c=relaxed/simple;
	bh=pOTskaRsubM42q5aP4Hck1zvbmuL27jjrWeoU5kUY3U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ShZMbgN/bDdw6YGYdDeTfExPwN4OcwA9QcrO2kw3gioWtzlvw0qoCgOzfYxLcNVdLQGDN/Y13phj6LczfDOOsgsWpTAolZ5fFGa9rDZwG3PZOR6laR4fJD1mHLb5vEJEfOUnNT1MBLfFSz8Qz/2THDpbj6tT2YTrKQbVRIbES4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=DvjInRxu; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="DvjInRxu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728018867; x=1728278067;
	bh=slBqEhpaWDeybHCMrw7ea8g8AzEfexzj4N7HZkfjI5I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DvjInRxuqE/M1N0LySBnjpodMDO1H3HABFNRaDfLARgY4iLLvOEktq07xygral2QF
	 D4nSaJFjNRKyAiuPPOx72ZzNDtTPPZ7+TwntF4v1KYMPaQMsMicgiXJeKeb3i8g9Tp
	 PMwiTXvRjqFpLtVz4sFwHl6UG74dsXx24NSj0cUetgsZ8BK2qTW+GbQKAu44Iw+AeQ
	 dBCMdwVhuE2h2rCscQ8/nA2v1X/djl5BlTsFxBDUMDVqN0m+uzMF7Szc5rPY6bZ4+G
	 EcK3hJgmmq/z9Uy3X3mtfZkhFLwajdouj+i3cgQQ9yYHoi3KdhQmok8B3oeOoKOKKW
	 BzN172J92wlkQ==
Date: Fri, 04 Oct 2024 05:14:21 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org, eddyz87@gmail.com
Subject: [PATCH dwarves 6/6] btf_encoder: switch to shared elf_functions table
Message-ID: <20241004051347.41143-7-ihor.solodrai@pm.me>
In-Reply-To: <20241004051347.41143-1-ihor.solodrai@pm.me>
References: <20241004051347.41143-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 1faca731eedaf7979ab30054679c3738b9e2de33
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

Add a mutex to elf_functions_entry for synchronization between
encoders. This way one encoder will wait for another only in an
unlikely situation when both process the same function name.

Change the algorithm of btf_encoder__add_saved_funcs(): traverse
elf_functions table once, merge function state for each
elf_functions_entry, and add each function to the BTF of the owner of
the first elf_function in this entry.

Do not call btf_encoder__add_saved_funcs() on every
btf_encoder__add_encoder(). Instead, introduce
btf_encoder__merge_encoders() function that does that.

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c | 132 ++++++++++++++++++++++++--------------------------
 btf_encoder.h |   3 +-
 pahole.c      |  25 +++++-----
 3 files changed, 80 insertions(+), 80 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 33cd9eb..b230aee 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -111,6 +111,7 @@ struct elf_functions_entry {
 =09const char *name;
 =09size_t prefixlen;
 =09struct elf_function *funcs; // list of elf_function
+=09pthread_mutex_t mutex;
 };
=20
 struct elf_functions {
@@ -155,7 +156,7 @@ struct btf_encoder {
 =09=09int=09=09allocated;
 =09=09uint32_t=09shndx;
 =09} percpu;
-=09struct elf_functions functions;
+=09struct elf_functions *functions;
 };
=20
 struct btf_func {
@@ -259,8 +260,6 @@ int btf_encoder__pre_cus__load_module(struct process_dw=
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
@@ -906,7 +905,7 @@ static int32_t btf_encoder__add_var_secinfo(struct btf_=
encoder *encoder, uint32_
 =09return gobuffer__add(&encoder->percpu_secinfo, &si, sizeof(si));
 }
=20
-int32_t btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_e=
ncoder *other)
+static int32_t btf_encoder__add_encoder(struct btf_encoder *encoder, struc=
t btf_encoder *other)
 {
 =09struct gobuffer *var_secinfo_buf =3D &other->percpu_secinfo;
 =09size_t sz =3D gobuffer__size(var_secinfo_buf);
@@ -919,8 +918,6 @@ int32_t btf_encoder__add_encoder(struct btf_encoder *en=
coder, struct btf_encoder
 =09if (encoder =3D=3D other)
 =09=09return 0;
=20
-=09btf_encoder__add_saved_funcs(other);
-
 =09for (i =3D 0; i < nr_var_secinfo; i++) {
 =09=09vsi =3D (struct btf_var_secinfo *)var_secinfo_buf->entries + i;
 =09=09type_id =3D next_type_id + vsi->type - 1; /* Type ID starts from 1 *=
/
@@ -932,6 +929,25 @@ int32_t btf_encoder__add_encoder(struct btf_encoder *e=
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
 static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, const=
 char *section_name)
 {
 =09struct gobuffer *var_secinfo_buf =3D &encoder->percpu_secinfo;
@@ -997,7 +1013,7 @@ static int32_t btf_encoder__add_decl_tag(struct btf_en=
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
@@ -1033,7 +1049,7 @@ static int fwd__kind(const struct btf_type *t)
 =09return btf_kind(t);
 }
=20
-static bool types__match(struct btf_encoder *encoder,
+static bool types__match(const struct btf_encoder *encoder,
 =09=09=09 struct btf *btf1, int type_id1,
 =09=09=09 struct btf *btf2, int type_id2)
 {
@@ -1132,7 +1148,7 @@ static bool types__match(struct btf_encoder *encoder,
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
@@ -1346,44 +1362,46 @@ static inline struct elf_function *find_elf_functio=
n_in_entry(struct elf_functio
 =09return NULL;
 }
=20
-static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
+
+// Each elf_functions_entry contains a variable number of elf_function
+// structs, because not all encoders encountered a particular
+// function.  However each function encountered at least once needs to be
+// added to BTF _somewhere_. Here we traverse the entire elf_functions
+// table, and for each array of elf_function structs the function is
+// added to the BTF of the encoder of the first elf_function in the array.
+int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
 {
-=09int i;
+=09struct elf_functions *functions =3D encoder->functions;
=20
-=09for (i =3D 0; i < encoder->functions.cnt; i++) {
-=09=09struct elf_function *func =3D find_elf_function_in_entry(&encoder->f=
unctions.entries[i], encoder);
+=09for (int i =3D 0; i < functions->cnt; i++) {
+=09=09struct elf_functions_entry *entry =3D &functions->entries[i];
=20
-=09=09if (!func)
+=09=09if (!entry->funcs)
 =09=09=09continue;
=20
+=09=09struct elf_function *func =3D entry->funcs;
 =09=09struct btf_encoder_func_state *state =3D &func->state;
-=09=09struct btf_encoder *other_encoder =3D NULL;
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
-=09=09=09other_func =3D find_elf_function_in_entry(&other_encoder->functio=
ns.entries[i], other_encoder);
=20
-=09=09=09if (other_encoder =3D=3D encoder || !other_func)
+=09=09for_each_elf_function(other_func, entry) {
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
@@ -1397,7 +1415,7 @@ static int btf_encoder__add_saved_funcs(struct btf_en=
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
@@ -1466,6 +1484,7 @@ static int elf_functions__collect_function(struct elf=
_functions *functions, GElf
 =09=09functions->suffix_cnt++;
 =09=09entry->prefixlen =3D suffix - name;
 =09}
+=09pthread_mutex_init(&entry->mutex, NULL);
 =09functions->cnt++;
=20
 =09return 0;
@@ -1477,11 +1496,12 @@ static struct elf_function *btf_encoder__find_funct=
ion(const struct btf_encoder
 =09struct elf_function *func =3D NULL;
 =09struct elf_functions_entry key =3D { .name =3D name, .prefixlen =3D pre=
fixlen };
 =09struct elf_functions_entry *entry =3D bsearch(&key,
-=09=09=09=09=09=09    encoder->functions.entries,
-=09=09=09=09=09=09    encoder->functions.cnt,
+=09=09=09=09=09=09    encoder->functions->entries,
+=09=09=09=09=09=09    encoder->functions->cnt,
 =09=09=09=09=09=09    sizeof(key),
 =09=09=09=09=09=09    functions_cmp);
 =09if (entry) {
+=09=09pthread_mutex_lock(&entry->mutex);
 =09=09// If entry is found then there is a name match.
 =09=09func =3D find_elf_function_in_entry(entry, encoder);
 =09=09// However if there is no elf_function for this encoder in the entry=
,
@@ -1495,6 +1515,7 @@ static struct elf_function *btf_encoder__find_functio=
n(const struct btf_encoder
 =09=09=09func->next =3D entry->funcs;
 =09=09=09entry->funcs =3D func;
 =09=09}
+=09=09pthread_mutex_unlock(&entry->mutex);
 =09}
=20
 =09return func;
@@ -2184,9 +2205,6 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 =09bool should_tag_kfuncs;
 =09int err;
=20
-=09/* for single-threaded case, saved funcs are added here */
-=09btf_encoder__add_saved_funcs(encoder);
-
 =09if (gobuffer__size(&encoder->percpu_secinfo) !=3D 0)
 =09=09btf_encoder__add_datasec(encoder, PERCPU_SECTION);
=20
@@ -2236,11 +2254,8 @@ int btf_encoder__encode(struct btf_encoder *encoder)
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
@@ -2372,25 +2387,6 @@ static int elf_functions__collect(struct elf_functio=
ns *functions)
 =09return 0;
 }
=20
-static int btf_encoder__collect_symbols(struct btf_encoder *encoder, bool =
collect_percpu_vars)
-{
-=09int err;
-
-=09err =3D elf_functions__collect(&encoder->functions);
-=09if (err)
-=09=09return err;
-=09if (encoder->verbose)
-=09=09printf("Found %d functions!\n", encoder->functions.cnt);
-
-=09if (collect_percpu_vars) {
-=09=09err =3D btf_encoder__collect_percpu_vars(encoder);
-=09=09if (err)
-=09=09=09return err;
-=09}
-
-=09return 0;
-}
-
 static bool ftype__has_arg_names(const struct ftype *ftype)
 {
 =09struct parameter *param;
@@ -2584,8 +2580,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
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
@@ -2616,8 +2611,10 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, =
const char *detached_filenam
 =09=09if (!encoder->percpu.shndx && encoder->verbose)
 =09=09=09printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->file=
name, PERCPU_SECTION);
=20
-=09=09if (btf_encoder__collect_symbols(encoder, !encoder->skip_encoding_va=
rs))
-=09=09=09goto out_delete;
+=09=09if (!encoder->skip_encoding_vars) {
+=09=09=09if (btf_encoder__collect_percpu_vars(encoder))
+=09=09=09=09goto out_delete;
+=09=09}
=20
 =09=09if (encoder->verbose)
 =09=09=09printf("File %s:\n", cu->filename);
@@ -2642,8 +2639,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 =09zfree(&encoder->source_filename);
 =09btf__free(encoder->btf);
 =09encoder->btf =3D NULL;
-
-=09__elf_functions__delete(&encoder->functions);
+=09elf_symtab__delete(encoder->symtab);
=20
 =09encoder->percpu.allocated =3D encoder->percpu.var_cnt =3D 0;
 =09free(encoder->percpu.vars);
@@ -2746,7 +2742,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encode=
r, struct cu *cu, struct co
 =09=09=09continue;
 =09=09if (!ftype__has_arg_names(&fn->proto))
 =09=09=09continue;
-=09=09if (encoder->functions.cnt) {
+=09=09if (encoder->functions->cnt) {
 =09=09=09const char *name;
=20
 =09=09=09name =3D function__name(fn);
@@ -2762,7 +2758,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encode=
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
index ee91444..859779f 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -25,7 +25,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, s=
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
index 239eb13..3251a5b 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3265,23 +3265,23 @@ static int pahole_threads_collect(struct conf_load =
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
@@ -3924,6 +3924,9 @@ try_sole_arg_as_class_names:
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
2.34.1


