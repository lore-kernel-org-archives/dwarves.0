Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4F0196D90
	for <dwarves@vger.kernel.org>; Fri, 13 Dec 2024 22:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734129448; cv=none; b=KilHY+frGKNSpRBfjsjQPJ4/HZHN1QG+p52uaYURhlTIcDoQ4lXYxQleEPxqtldu2vRqgdutHIDgqUyndnxGoGizV4fMdhUOWldaaGDHqt6N/s88u1RneHc9galRShTqbXylrmfBRivbGIP3aNdfixawHrM0T2/b8Yt3TXmX6Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734129448; c=relaxed/simple;
	bh=VWXLqdGBHWXRXun/GGmkLRad4YIULYGxI0KxDyBj68w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULTy1Ft2E2htRFwJQ/RetzDLOQx1gkN7p2dzI3shb2UZ6LjkgPJpKFdEVAewQDrST+r8ckdri2XYVZAHWN/mYcmOCLz3QsEad+JmhR5guYsYVo7pv6ZROUwroms87NWmCk1YugUn5908pxOj3Vm2j3mP0/XmDIbIRaWhs0j5UXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=FLmUTAuJ; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="FLmUTAuJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734129437; x=1734388637;
	bh=VVcQgDsufWm2wDWF9+G95Bnp70tCHEFjv+/nDxxa8C4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=FLmUTAuJ9dxjkSjqViPfk2lj+3IFLJ1ZAxcLJkmB00WaVTZgDOIGeELLAy5GP4a3r
	 5esNO1KUdUnQfsxZZft/CZVkH5I5VEDUHc+fkbuLFuliITTVlhZoxcRI5qJmjEepsD
	 rLj6dGmRRAAp4bZT84t1aOmhRIZsDcKpvTubf1rL4V+df1wYsthqMK5tjUEgNyRFEb
	 6f0n8dU2w6tu322bPVwLSjJiOE02zGqRafbZ13on6dhQvPATZGA9dkqcbRvFhlBhzr
	 /4wajkd4zZKMafrw3B2a6d8ZeTCMJN/4VpQsaA2CwtIQ7XQ0fC/8vbhOb2A6LAfyDh
	 HceUNNX3e2IiA==
Date: Fri, 13 Dec 2024 22:37:13 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: [PATCH dwarves v2 06/10] btf_encoder: switch to shared elf_functions table
Message-ID: <20241213223641.564002-7-ihor.solodrai@pm.me>
In-Reply-To: <20241213223641.564002-1-ihor.solodrai@pm.me>
References: <20241213223641.564002-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 1259e99103b1e439f9e351b00ccd2609215f1900
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

Set btf_encoder's ELF symbol table to one associated with the
corresponding elf_functions, instead of maintaining a copy.

For a single-threaded case call btf_encoder__add_saved_funcs() right
before btf_encoder__encode(), and not within it.

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Link: https://lore.kernel.org/bpf/20241128012341.4081072-8-ihor.solodrai@pm=
.me/
---
 btf_encoder.c | 49 +++++++++++++++++++++++++------------------------
 pahole.c      | 10 ++++++++--
 2 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 88d2872..4a4f6c8 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -136,7 +136,7 @@ struct btf_encoder {
 =09size_t             seccnt;
 =09int                encode_vars;
 =09struct list_head   func_states;
-=09struct elf_functions functions;
+=09struct elf_functions *functions;
 };
=20
 struct btf_func {
@@ -158,8 +158,23 @@ struct btf_kfunc_set_range {
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
 static inline void elf_functions__delete(struct elf_functions *funcs)
 {
+=09for (int i =3D 0; i < funcs->cnt; i++)
+=09=09free(funcs->entries[i].alias);
 =09free(funcs->entries);
 =09elf_symtab__delete(funcs->symtab);
 =09list_del(&funcs->node);
@@ -168,11 +183,11 @@ static inline void elf_functions__delete(struct elf_f=
unctions *funcs)
=20
 static inline void elf_functions__delete_all(void)
 {
+=09struct elf_functions *funcs;
 =09struct list_head *pos, *tmp;
=20
 =09list_for_each_safe(pos, tmp, &elf_functions_list) {
-=09=09struct elf_functions *funcs =3D list_entry(pos, struct elf_functions=
, node);
-
+=09=09funcs =3D list_entry(pos, struct elf_functions, node);
 =09=09elf_functions__delete(funcs);
 =09}
 }
@@ -1316,9 +1331,6 @@ static void btf_encoder__delete_saved_funcs(struct bt=
f_encoder *encoder)
 =09=09free(pos->annots);
 =09=09free(pos);
 =09}
-
-=09for (int i =3D 0; i < encoder->functions.cnt; i++)
-=09=09free(encoder->functions.entries[i].alias);
 }
=20
 int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
@@ -1406,7 +1418,7 @@ static struct elf_function *btf_encoder__find_functio=
n(const struct btf_encoder
 {
 =09struct elf_function key =3D { .name =3D name, .prefixlen =3D prefixlen =
};
=20
-=09return bsearch(&key, encoder->functions.entries, encoder->functions.cnt=
, sizeof(key), functions_cmp);
+=09return bsearch(&key, encoder->functions->entries, encoder->functions->c=
nt, sizeof(key), functions_cmp);
 }
=20
 static bool btf_name_char_ok(char c, bool first)
@@ -2116,9 +2128,6 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 =09int err;
 =09size_t shndx;
=20
-=09/* for single-threaded case, saved funcs are added here */
-=09btf_encoder__add_saved_funcs(encoder);
-
 =09for (shndx =3D 1; shndx < encoder->seccnt; shndx++)
 =09=09if (gobuffer__size(&encoder->secinfo[shndx].secinfo))
 =09=09=09btf_encoder__add_datasec(encoder, shndx);
@@ -2477,14 +2486,13 @@ struct btf_encoder *btf_encoder__new(struct cu *cu,=
 const char *detached_filenam
 =09=09=09goto out_delete;
 =09=09}
=20
-=09=09encoder->symtab =3D elf_symtab__new(NULL, cu->elf);
+=09=09encoder->functions =3D elf_functions__get(cu->elf);
+=09=09encoder->symtab =3D encoder->functions->symtab;
 =09=09if (!encoder->symtab) {
 =09=09=09if (encoder->verbose)
 =09=09=09=09printf("%s: '%s' doesn't have symtab.\n", __func__, cu->filena=
me);
 =09=09=09goto out;
 =09=09}
-=09=09encoder->functions.symtab =3D encoder->symtab;
-=09=09encoder->functions.elf =3D cu->elf;
=20
 =09=09/* index the ELF sections for later lookup */
=20
@@ -2523,9 +2531,6 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
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
@@ -2553,12 +2558,8 @@ void btf_encoder__delete(struct btf_encoder *encoder=
)
 =09zfree(&encoder->source_filename);
 =09btf__free(encoder->btf);
 =09encoder->btf =3D NULL;
-=09elf_symtab__delete(encoder->symtab);
-
-=09encoder->functions.cnt =3D 0;
-=09free(encoder->functions.entries);
-=09encoder->functions.entries =3D NULL;
-
+=09encoder->symtab =3D NULL;
+=09encoder->functions =3D NULL;
 =09btf_encoder__delete_saved_funcs(encoder);
=20
 =09free(encoder);
@@ -2657,7 +2658,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encode=
r, struct cu *cu, struct co
 =09=09=09continue;
 =09=09if (!ftype__has_arg_names(&fn->proto))
 =09=09=09continue;
-=09=09if (encoder->functions.cnt) {
+=09=09if (encoder->functions->cnt) {
 =09=09=09const char *name;
=20
 =09=09=09name =3D function__name(fn);
@@ -2666,7 +2667,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encode=
r, struct cu *cu, struct co
=20
 =09=09=09/* prefer exact function name match... */
 =09=09=09func =3D btf_encoder__find_function(encoder, name, 0);
-=09=09=09if (!func && encoder->functions.suffix_cnt &&
+=09=09=09if (!func && encoder->functions->suffix_cnt &&
 =09=09=09    conf_load->btf_gen_optimized) {
 =09=09=09=09/* falling back to name.isra.0 match if no exact
 =09=09=09=09 * match is found; only bother if we found any
diff --git a/pahole.c b/pahole.c
index 17af0b4..eb2e71a 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3185,13 +3185,16 @@ static int pahole_threads_collect(struct conf_load =
*conf, int nr_threads, void *
 =09if (error)
 =09=09goto out;
=20
-=09btf_encoder__add_saved_funcs(btf_encoder);
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
@@ -3846,6 +3849,9 @@ try_sole_arg_as_class_names:
 =09=09=09exit(1);
 =09=09}
=20
+=09=09if (conf_load.nr_jobs <=3D 1 || conf_load.reproducible_build)
+=09=09=09btf_encoder__add_saved_funcs(btf_encoder);
+
 =09=09err =3D btf_encoder__encode(btf_encoder);
 =09=09btf_encoder__delete(btf_encoder);
 =09=09if (err) {
--=20
2.47.1


