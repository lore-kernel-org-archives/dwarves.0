Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0A817B4FE
	for <dwarves@vger.kernel.org>; Wed,  9 Oct 2024 23:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728516938; cv=none; b=Hs5bqwSAfgD6R4sidAij1W/YDcPgF5QrnWomKgj2IoTfbbTPZ0CKiSEPPfx++pFks0HxsAZ7hb3TGsPnFkT4iVY9nU3PvtnkrNRoWaOiS/KuIJPOkf4LrJ1IMoA8EM4c5vYenxrjOKS5p17Ey11M+V9dt2xd3rjXBSa7Ne6Q8XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728516938; c=relaxed/simple;
	bh=g73av2Yz5U4FNP4hLyyai1eEPhs3a9iQOE3h+S9GKq8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b65/mLjrZVSAQVQmrWaDDUsdsveF/z7JI+GQT5Z51TInVgu3ciKNjHKMdgPQ2qKgR8bs+TPP5pJBpgWyH8gnGFyVe1XD7x2LarEmtpYcE848i2UP+fR3qGxUt75b/0F+eOCm6VgH000aqoKfHbMG1T8SR6Tii6diFxid4O+RCtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=QT/K7Rh2; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="QT/K7Rh2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728516934; x=1728776134;
	bh=iz6AtXg4esLswfsmUphvJSYJVXkc0PzCeIpJmxwRqVM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QT/K7Rh2SKU0+4iWjY+ZRqMo6eueo3gZs5nCQoq+g8e0saNOzNoUxhUQVJE3eoWH/
	 uEHW5d0CIckvmVOLMCufoGBa+mBzccPWRuL5Diitv9NhjL4Xr/Dxn7sGcqh8qwBKIH
	 9i7bYR6Iy6lNR+2vbQ6pi6RMdhTi6uHSf5IiY0/2QEE/hz2oBIrJ0QJCRb6iS2cdyF
	 1xkiP4zIM0QxWQpFzCRFJGOCeANpqC/8RfP2qFJerx8fP6yNJS16WiYRTppYqmCsDX
	 GnWzK0f4wEsY/cZSdFSduSm0xHAVQs9Nub/GWiK3EL2nG5wNbXCvpQ61DqMHIz/sw3
	 zk5BdOufYqNgA==
Date: Wed, 09 Oct 2024 23:35:30 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org, eddyz87@gmail.com
Subject: [PATCH v2 dwarves 2/5] btf_encoder: introduce elf_functions struct type
Message-ID: <20241009233520.989453-3-ihor.solodrai@pm.me>
In-Reply-To: <20241009233520.989453-1-ihor.solodrai@pm.me>
References: <20241009233520.989453-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: d7b6f6f1869f91098b1b76bcf305c9d2ece8e439
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Extract elf_functions struct type from btf_encoder.

Rewrite btf_encoder__collect_function() into
elf_functions__collect_function(), and btf_encoder__collect_symbols()
into elf_functions__collect().

Now these functions do not depend on btf_encoder being passed to them
as a parameter.

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c | 100 +++++++++++++++++++++++---------------------------
 1 file changed, 46 insertions(+), 54 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 5954238..8abca7f 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -102,6 +102,13 @@ struct elf_secinfo {
 =09struct gobuffer secinfo;
 };
=20
+struct elf_functions {
+=09struct elf_symtab *symtab;
+=09struct elf_function *entries;
+=09int cnt;
+=09int suffix_cnt; /* number of .isra, .part etc */
+};
+
 /*
  * cu: cu being processed.
  */
@@ -126,12 +133,7 @@ struct btf_encoder {
 =09struct elf_secinfo *secinfo;
 =09size_t             seccnt;
 =09int                encode_vars;
-=09struct {
-=09=09struct elf_function *entries;
-=09=09int=09=09    allocated;
-=09=09int=09=09    cnt;
-=09=09int=09=09    suffix_cnt; /* number of .isra, .part etc */
-=09} functions;
+=09struct elf_functions functions;
 };
=20
 struct btf_func {
@@ -1299,55 +1301,28 @@ static int functions_cmp(const void *_a, const void=
 *_b)
 =09return strcmp(a->name, b->name);
 }
=20
-#ifndef max
-#define max(x, y) ((x) < (y) ? (y) : (x))
-#endif
-
-static void *reallocarray_grow(void *ptr, int *nmemb, size_t size)
+static int elf_functions__collect_function(struct elf_functions *functions=
, GElf_Sym *sym)
 {
-=09int new_nmemb =3D max(1000, *nmemb * 3 / 2);
-=09void *new =3D realloc(ptr, new_nmemb * size);
-
-=09if (new)
-=09=09*nmemb =3D new_nmemb;
-=09return new;
-}
-
-static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf=
_Sym *sym)
-{
-=09struct elf_function *new;
+=09struct elf_function *func;
 =09const char *name;
=20
 =09if (elf_sym__type(sym) !=3D STT_FUNC)
 =09=09return 0;
-=09name =3D elf_sym__name(sym, encoder->symtab);
+
+=09name =3D elf_sym__name(sym, functions->symtab);
 =09if (!name)
 =09=09return 0;
=20
-=09if (encoder->functions.cnt =3D=3D encoder->functions.allocated) {
-=09=09new =3D reallocarray_grow(encoder->functions.entries,
-=09=09=09=09=09&encoder->functions.allocated,
-=09=09=09=09=09sizeof(*encoder->functions.entries));
-=09=09if (!new) {
-=09=09=09/*
-=09=09=09 * The cleanup - delete_functions is called
-=09=09=09 * in btf_encoder__encode_cu error path.
-=09=09=09 */
-=09=09=09return -1;
-=09=09}
-=09=09encoder->functions.entries =3D new;
-=09}
-
-=09memset(&encoder->functions.entries[encoder->functions.cnt], 0,
-=09       sizeof(*new));
-=09encoder->functions.entries[encoder->functions.cnt].name =3D name;
+=09func =3D &functions->entries[functions->cnt];
+=09func->name =3D name;
 =09if (strchr(name, '.')) {
 =09=09const char *suffix =3D strchr(name, '.');
-
-=09=09encoder->functions.suffix_cnt++;
-=09=09encoder->functions.entries[encoder->functions.cnt].prefixlen =3D suf=
fix - name;
+=09=09functions->suffix_cnt++;
+=09=09func->prefixlen =3D suffix - name;
 =09}
-=09encoder->functions.cnt++;
+
+=09functions->cnt++;
+
 =09return 0;
 }
=20
@@ -2100,22 +2075,38 @@ int btf_encoder__encode(struct btf_encoder *encoder=
)
 }
=20
=20
-static int btf_encoder__collect_symbols(struct btf_encoder *encoder)
+static int elf_functions__collect(struct elf_functions *functions)
 {
-=09uint32_t sym_sec_idx;
+=09uint32_t nr_symbols =3D elf_symtab__nr_symbols(functions->symtab);
+=09Elf32_Word sym_sec_idx;
 =09uint32_t core_id;
 =09GElf_Sym sym;
=20
-=09elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_se=
c_idx) {
-=09=09if (btf_encoder__collect_function(encoder, &sym))
+=09// We know that number of functions is less than number of symbols,
+=09// so we can overallocate temporarily.
+=09functions->entries =3D calloc(nr_symbols, sizeof(struct elf_function));
+=09if (!functions->entries) {
+=09=09fprintf(stderr, "could not allocate memory for elf_functions table\n=
");
+=09=09return -ENOMEM;
+=09}
+
+=09functions->cnt =3D 0;
+=09elf_symtab__for_each_symbol_index(functions->symtab, core_id, sym, sym_=
sec_idx) {;
+=09=09if (elf_functions__collect_function(functions, &sym))
 =09=09=09return -1;
 =09}
=20
-=09if (encoder->functions.cnt) {
-=09=09qsort(encoder->functions.entries, encoder->functions.cnt, sizeof(enc=
oder->functions.entries[0]),
+=09if (functions->cnt)
+=09=09qsort(functions->entries,
+=09=09      functions->cnt,
+=09=09      sizeof(functions->entries[0]),
 =09=09      functions_cmp);
-=09=09if (encoder->verbose)
-=09=09=09printf("Found %d functions!\n", encoder->functions.cnt);
+
+=09// Reallocate to the exact size
+=09functions->entries =3D realloc(functions->entries, functions->cnt * siz=
eof(struct elf_function));
+=09if (!functions->entries) {
+=09=09fprintf(stderr, "could not reallocate memory for elf_functions table=
\n");
+=09=09return -ENOMEM;
 =09}
=20
 =09return 0;
@@ -2377,6 +2368,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
onst char *detached_filenam
 =09=09=09=09printf("%s: '%s' doesn't have symtab.\n", __func__, cu->filena=
me);
 =09=09=09goto out;
 =09=09}
+=09=09encoder->functions.symtab =3D encoder->symtab;
=20
 =09=09/* index the ELF sections for later lookup */
=20
@@ -2415,7 +2407,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
onst char *detached_filenam
 =09=09if (!found_percpu && encoder->verbose)
 =09=09=09printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->file=
name, PERCPU_SECTION);
=20
-=09=09if (btf_encoder__collect_symbols(encoder))
+=09=09if (elf_functions__collect(&encoder->functions))
 =09=09=09goto out_delete;
=20
 =09=09if (encoder->verbose)
@@ -2456,7 +2448,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
=20
 =09for (i =3D 0; i < encoder->functions.cnt; i++)
 =09=09btf_encoder__delete_func(&encoder->functions.entries[i]);
-=09encoder->functions.allocated =3D encoder->functions.cnt =3D 0;
+=09encoder->functions.cnt =3D 0;
 =09free(encoder->functions.entries);
 =09encoder->functions.entries =3D NULL;
=20
--=20
2.43.0


