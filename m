Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195191FB3
	for <dwarves@vger.kernel.org>; Wed, 16 Oct 2024 00:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729037462; cv=none; b=Mths7lTF7KOfwEWojDltMgn15BIPf40Q19bSZTNuBDTv1+4JXfl99tZxLPSNaCn7xwznSRUpxhzBnHy6NA/GkYA3EoltWb9wgTqU7Hm6Rm8pN4bQq1nNhGDZayRGZipJn5ABk+ll1HLcvZXYPrVuqzWRyebE3BYUEYcs9L4IK2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729037462; c=relaxed/simple;
	bh=qXVhoUO5KksGYrlqxdSrnSFnjBrLNv5vxuXl0xEMGeo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LM2g+p/VZ+jhf6Twu7rR3E5IJqd8z+pgygTyTlRcAP8+wIVqy8HvRBES5eFINA31d9Pzvv4hzWG84R/XcL6ebOVjCQQbsMNFyPKjWA6Vt87Wdw9pyBZt8Km/bDM4WlpgBscpoo/ea1wNtXmJ7swDZH4UKxX9FA/hZylznl6thEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=qOtVQ/eS; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="qOtVQ/eS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1729037458; x=1729296658;
	bh=3bSU1uRe6oD3ecJJKzdiXe2YYTKGpNIoee+riyzP59I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=qOtVQ/eS9sPBi0wxUWzIcgMCjRzAqYDIqQEMFJfrxIBlthcb/S7QsQ2PeGgsQ3ms3
	 w4MFLnsN01g2zMJYM4IvEk/NYyKDvWksk303Su7LpiQP6fjeJY9OG14g+wDci24gxZ
	 MtOeL93VErQqoaYuomwSP+vmSM19dRO/VJfVzDk0UTSBBRxi3pC5BnKN1KujiWZNRP
	 XhwquBfFmsnyd/Q4fq8iXRIhh/OFLCiOrSV7gbrR+xWie4NiW95brNjqvpTnfhwXz5
	 SeGoW4K0NJqDjOm/WRmFaUU2SIvoYpI3gZgI0u/iOZR3aQbPN4vcWLlNwHzKGOKDZs
	 +IlE4XyA8Peyg==
Date: Wed, 16 Oct 2024 00:10:53 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org, eddyz87@gmail.com
Subject: [PATCH v3 dwarves 5/5] btf_encoder: switch to shared elf_functions table
Message-ID: <20241016001025.857970-6-ihor.solodrai@pm.me>
In-Reply-To: <20241016001025.857970-1-ihor.solodrai@pm.me>
References: <20241016001025.857970-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 9d191dca372509c7d51aeaec0af84ff6f9e3398d
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

Change the algorithm of btf_encoder__add_saved_funcs().  Traverse
elf_functions table once and for each function do the following:
* check function states of each elf_function in a list to determine if
  it should be added to BTF
* if yes, add the function to the BTF of the owner of the first
  elf_function in the list

Do not call btf_encoder__add_saved_funcs() on every
btf_encoder__add_encoder(). Instead, for non-reproducible
multi-threaded case do that in pahole_threads_collect(), and for
single-threaded or reproducible_build do that right before
btf_encoder__encode().

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c | 113 +++++++++++++++++++++++---------------------------
 btf_encoder.h |   1 +
 pahole.c      |   9 +++-
 3 files changed, 61 insertions(+), 62 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 002358c..1ec39fe 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -80,7 +80,6 @@ struct btf_encoder_func_state {
 =09uint8_t optimized_parms:1;
 =09uint8_t unexpected_reg:1;
 =09uint8_t inconsistent_proto:1;
-=09uint8_t processed:1;
 =09int ret_type_id;
 =09struct btf_encoder_func_parm *parms;
 =09struct btf_encoder_func_annot *annots;
@@ -141,7 +140,7 @@ struct btf_encoder {
 =09struct elf_secinfo *secinfo;
 =09size_t             seccnt;
 =09int                encode_vars;
-=09struct elf_functions functions;
+=09struct elf_functions *functions;
 };
=20
 struct btf_func {
@@ -163,6 +162,19 @@ struct btf_kfunc_set_range {
  */
 static LIST_HEAD(elf_functions_list);
=20
+static struct elf_functions *elf_functions__get(Elf *elf)
+{
+=09struct list_head *pos;
+
+=09list_for_each(pos, &elf_functions_list) {
+=09=09struct elf_functions *funcs =3D list_entry(pos, struct elf_functions=
, node);
+
+=09=09if (funcs->elf =3D=3D elf)
+=09=09=09return funcs;
+=09}
+=09return NULL;
+}
+
 static void __elf_functions__delete(struct elf_functions *funcs)
 {
 =09struct elf_function *func, *next;
@@ -238,8 +250,6 @@ out_delete:
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
@@ -891,8 +901,6 @@ int32_t btf_encoder__add_encoder(struct btf_encoder *en=
coder, struct btf_encoder
 =09if (encoder =3D=3D other)
 =09=09return 0;
=20
-=09btf_encoder__add_saved_funcs(other);
-
 =09for (shndx =3D 1; shndx < other->seccnt; shndx++) {
 =09=09struct gobuffer *var_secinfo_buf =3D &other->secinfo[shndx].secinfo;
 =09=09size_t sz =3D gobuffer__size(var_secinfo_buf);
@@ -1335,61 +1343,52 @@ static inline struct elf_function *find_elf_functio=
n(struct elf_function *list_h
 =09return NULL;
 }
=20
-static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
-{
-=09int i;
=20
-=09for (i =3D 0; i < encoder->functions.cnt; i++) {
-=09=09struct elf_function *func =3D find_elf_function(&encoder->functions.=
entries[i], encoder);
-
-=09=09if (!func)
-=09=09=09continue;
+/* Each element of elf_functions->entries is a list of a variable
+ * number of elf_function structs, because not all encoders saved a
+ * particular function.  However each function saved by at least one
+ * encoder needs to be added to BTF _somewhere_. Here we traverse the
+ * entire elf_functions table, and for each list of elf_function
+ * structs a function is added to the BTF of the encoder of the first
+ * elf_function in the list.
+ */
+int btf_encoder__add_saved_funcs(struct btf_encoder *base_encoder)
+{
+=09struct elf_functions *functions =3D base_encoder->functions;
=20
-=09=09struct btf_encoder_func_state *state =3D &func->state;
-=09=09struct btf_encoder *other_encoder =3D NULL;
+=09for (int i =3D 0; i < functions->cnt; i++) {
+=09=09struct elf_function *list_head =3D &functions->entries[i];
+=09=09struct btf_encoder_func_state *state, *other_state;
+=09=09struct elf_function *func;
+=09=09bool skip_func =3D false;
=20
-=09=09if (!state->initialized || state->processed)
-=09=09=09continue;
-=09=09/* merge optimized-out status across encoders; since each
-=09=09 * encoder has the same elf symbol table we can use the
-=09=09 * same index to access the same elf symbol.
+=09=09/* list_head without an encoder means no encoder has
+=09=09 * saved a function with this name
 =09=09 */
-=09=09btf_encoders__for_each_encoder(other_encoder) {
-=09=09=09struct elf_function *other_func;
-=09=09=09struct btf_encoder_func_state *other_state;
-=09=09=09uint8_t optimized, unexpected, inconsistent;
-=09=09=09other_func =3D find_elf_function(&other_encoder->functions.entrie=
s[i], other_encoder);
-
-=09=09=09if (other_encoder =3D=3D encoder || !other_func)
-=09=09=09=09continue;
+=09=09if (!list_head->encoder)
+=09=09=09continue;
=20
+=09=09func =3D list_head;
+=09=09state =3D &func->state;
+=09=09for_each_elf_function(other_func, list_head) {
 =09=09=09other_state =3D &other_func->state;
-=09=09=09if (!other_state->initialized)
-=09=09=09=09continue;
-=09=09=09optimized =3D state->optimized_parms | other_state->optimized_par=
ms;
-=09=09=09unexpected =3D state->unexpected_reg | other_state->unexpected_re=
g;
-=09=09=09inconsistent =3D state->inconsistent_proto | other_state->inconsi=
stent_proto;
-=09=09=09if (!unexpected && !inconsistent &&
-=09=09=09    !funcs__match(encoder, func,
-=09=09=09=09=09  encoder->btf, state,
-=09=09=09=09=09  other_encoder->btf, other_state))
-=09=09=09=09inconsistent =3D 1;
-=09=09=09state->optimized_parms =3D other_state->optimized_parms =3D optim=
ized;
-=09=09=09state->unexpected_reg =3D other_state->unexpected_reg =3D unexpec=
ted;
-=09=09=09state->inconsistent_proto =3D other_state->inconsistent_proto =3D=
 inconsistent;
-
-=09=09=09other_state->processed =3D 1;
+=09=09=09skip_func |=3D other_state->inconsistent_proto;
+=09=09=09skip_func |=3D other_state->unexpected_reg;
+=09=09=09skip_func |=3D !funcs__match(func->encoder, func,
+=09=09=09=09=09=09   func->encoder->btf, state,
+=09=09=09=09=09=09   other_func->encoder->btf, other_state);
+=09=09=09if (skip_func)
+=09=09=09=09break;
 =09=09}
 =09=09/* do not exclude functions with optimized-out parameters; they
 =09=09 * may still be _called_ with the right parameter values, they
 =09=09 * just do not _use_ them.  Only exclude functions with
 =09=09 * unexpected register use or multiple inconsistent prototypes.
 =09=09 */
-=09=09if (!state->unexpected_reg && !state->inconsistent_proto) {
-=09=09=09if (btf_encoder__add_func(encoder, NULL, func))
+=09=09if (!skip_func) {
+=09=09=09if (btf_encoder__add_func(func->encoder, NULL, func))
 =09=09=09=09return -1;
 =09=09}
-=09=09state->processed =3D 1;
 =09}
 =09return 0;
 }
@@ -1440,8 +1439,8 @@ static struct elf_function *btf_encoder__find_functio=
n(struct btf_encoder *encod
 =09struct elf_function *func, *head, *tmp;
=20
 =09head =3D bsearch(&key,
-=09=09       encoder->functions.entries,
-=09=09       encoder->functions.cnt,
+=09=09       encoder->functions->entries,
+=09=09       encoder->functions->cnt,
 =09=09       sizeof(key),
 =09=09       functions_cmp);
=20
@@ -2166,9 +2165,6 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 =09int err;
 =09size_t shndx;
=20
-=09/* for single-threaded case, saved funcs are added here */
-=09btf_encoder__add_saved_funcs(encoder);
-
 =09for (shndx =3D 1; shndx < encoder->seccnt; shndx++)
 =09=09if (gobuffer__size(&encoder->secinfo[shndx].secinfo))
 =09=09=09btf_encoder__add_datasec(encoder, shndx);
@@ -2535,8 +2531,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
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
@@ -2575,9 +2570,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
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
@@ -2603,8 +2595,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 =09zfree(&encoder->source_filename);
 =09btf__free(encoder->btf);
 =09encoder->btf =3D NULL;
-
-=09__elf_functions__delete(&encoder->functions);
+=09elf_symtab__delete(encoder->symtab);
=20
 =09free(encoder);
 }
@@ -2703,7 +2694,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encode=
r, struct cu *cu, struct co
 =09=09=09continue;
 =09=09if (!ftype__has_arg_names(&fn->proto))
 =09=09=09continue;
-=09=09if (encoder->functions.cnt) {
+=09=09if (encoder->functions->cnt) {
 =09=09=09const char *name;
=20
 =09=09=09name =3D function__name(fn);
@@ -2719,7 +2710,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encode=
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
index 7debd67..29f652a 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -33,6 +33,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, s=
truct cu *cu, struct co
 struct btf *btf_encoder__btf(struct btf_encoder *encoder);
=20
 int btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encod=
er *other);
+int btf_encoder__add_saved_funcs(struct btf_encoder *base_encoder);
=20
 int btf_encoder__pre_load_module(Dwfl_Module *mod, Elf *elf);
=20
diff --git a/pahole.c b/pahole.c
index 891af3a..6f83636 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3262,12 +3262,16 @@ static int pahole_threads_collect(struct conf_load =
*conf, int nr_threads, void *
 =09if (error)
 =09=09goto out;
=20
+=09err =3D btf_encoder__add_saved_funcs(btf_encoder);
+=09if (err < 0)
+=09=09goto out;
+
 =09for (i =3D 0; i < nr_threads; i++) {
 =09=09/*
 =09=09 * Merge content of the btf instances of worker threads to the btf
 =09=09 * instance of the primary btf_encoder.
                 */
-=09=09if (!threads[i]->btf)
+=09=09if (!threads[i]->encoder || !threads[i]->btf)
 =09=09=09continue;
 =09=09err =3D btf_encoder__add_encoder(btf_encoder, threads[i]->encoder);
 =09=09if (err < 0)
@@ -3915,6 +3919,9 @@ try_sole_arg_as_class_names:
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


