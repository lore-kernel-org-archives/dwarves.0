Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFDC52F76
	for <dwarves@vger.kernel.org>; Fri,  4 Oct 2024 05:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728018847; cv=none; b=E6joosec7kNpsufk6aDEY2JuADZguQDsCcs+Yrce/0OA9cBHt/Uql6BU0YFkl0NTskzg9oc/wUbN1FPnmnxnSL96zG78U3/nzT1X4okQZighSUfaxsBZ689o4HR3jqE1XRRNa75Y3bZudHG67kAzCUleaIXx/20WypadkRnrNoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728018847; c=relaxed/simple;
	bh=ddQyPzzjP6UNrJJoFY8bBRaHvLbkl3ePSmVNSUNXvNc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VsnlnnDpwtz5Eu2y+5V1E555+VOJI7GdSrL1lQITRrGG8ry+qhzjsSHnE6B2lf7SBB26wwpYbhWjQeyZna2n47dTcnsruwECuGxCjAidG1XbvHWUZ2yufmBYPjEi2RMZDWwsK2+VfxSo9p1MxWOh5ivsTmtJab/na/CTg8JXGPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=I0q3kF1p; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="I0q3kF1p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728018844; x=1728278044;
	bh=ugA2kxkZ6KiQgbkL1DFA7Dbl9lFNuC7u8XiOYv9DW/A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=I0q3kF1pQU2WO74mn4EBHz8uT7chcBQuqXbEk1gcEAO0/FhvXLJTgX6kEm/yRo2M4
	 S6QSafOKA8tJPqL2pPXIoj9T1Yym37voW01Be5GukSBbUxN3jhCr3sFyi6/Hb7I1QL
	 WsvviZEwTQ4eotfFsjPHS+EYa4A0PFgVV9i/hn/pZUlrDizu/1iH8gXf7x7MlqSph2
	 B1TIRCC2LGXNDgy70qJNGRFWgirnNfdr91rv3BNvxsTdNNTgZv3/HzSCFvsYGKpRrd
	 WjAlSxnCZIh6HLyeQXkLqqdsNG4VWVRiEgKiJovR7KuwdO/ryHZVlZSTB1a+1IZm0r
	 6rJoquf5gLRXg==
Date: Fri, 04 Oct 2024 05:14:01 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org, eddyz87@gmail.com
Subject: [PATCH dwarves 3/6] btf_encoder: introduce elf_functions struct type
Message-ID: <20241004051347.41143-4-ihor.solodrai@pm.me>
In-Reply-To: <20241004051347.41143-1-ihor.solodrai@pm.me>
References: <20241004051347.41143-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 7091d22ff0cd5efa6d773b2b80f262c92d741a09
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
elf_functions__collect_function(), and
btf_encoder__collect_functions() into elf_functions__collect()

Now these functions do not depend on btf_encoder being passed to them
as a parameter.

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c | 66 +++++++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 31 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 6e7d2e7..ec523a1 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -105,6 +105,14 @@ struct elf_secinfo {
 =09uint64_t    sz;
 };
=20
+struct elf_functions {
+=09struct elf_symtab *symtab;
+=09struct elf_function *entries;
+=09int allocated;
+=09int cnt;
+=09int suffix_cnt;
+};
+
 /*
  * cu: cu being processed.
  */
@@ -137,12 +145,7 @@ struct btf_encoder {
 =09=09int=09=09allocated;
 =09=09uint32_t=09shndx;
 =09} percpu;
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
@@ -1314,21 +1317,21 @@ static void *reallocarray_grow(void *ptr, int *nmem=
b, size_t size)
 =09return new;
 }
=20
-static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf=
_Sym *sym)
+static int elf_functions__collect_function(struct elf_functions *functions=
, GElf_Sym *sym)
 {
 =09struct elf_function *new;
 =09const char *name;
=20
 =09if (elf_sym__type(sym) !=3D STT_FUNC)
 =09=09return 0;
-=09name =3D elf_sym__name(sym, encoder->symtab);
+=09name =3D elf_sym__name(sym, functions->symtab);
 =09if (!name)
 =09=09return 0;
=20
-=09if (encoder->functions.cnt =3D=3D encoder->functions.allocated) {
-=09=09new =3D reallocarray_grow(encoder->functions.entries,
-=09=09=09=09=09&encoder->functions.allocated,
-=09=09=09=09=09sizeof(*encoder->functions.entries));
+=09if (functions->cnt =3D=3D functions->allocated) {
+=09=09new =3D reallocarray_grow(functions->entries,
+=09=09=09=09=09&functions->allocated,
+=09=09=09=09=09sizeof(*functions->entries));
 =09=09if (!new) {
 =09=09=09/*
 =09=09=09 * The cleanup - delete_functions is called
@@ -1336,19 +1339,20 @@ static int btf_encoder__collect_function(struct btf=
_encoder *encoder, GElf_Sym *
 =09=09=09 */
 =09=09=09return -1;
 =09=09}
-=09=09encoder->functions.entries =3D new;
+=09=09functions->entries =3D new;
 =09}
=20
-=09memset(&encoder->functions.entries[encoder->functions.cnt], 0,
-=09       sizeof(*new));
-=09encoder->functions.entries[encoder->functions.cnt].name =3D name;
+=09struct elf_function *func =3D &functions->entries[functions->cnt];
+
+=09memset(func, 0, sizeof(*func));
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
+=09functions->cnt++;
+
 =09return 0;
 }
=20
@@ -2205,25 +2209,22 @@ static int btf_encoder__collect_percpu_vars(struct =
btf_encoder *encoder)
 =09return 0;
 }
=20
-static int btf_encoder__collect_functions(struct btf_encoder *encoder)
+static int elf_functions__collect(struct elf_functions *functions)
 {
 =09Elf32_Word sym_sec_idx;
 =09uint32_t core_id;
 =09GElf_Sym sym;
=20
-=09elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_se=
c_idx) {;
-=09=09if (btf_encoder__collect_function(encoder, &sym))
+=09elf_symtab__for_each_symbol_index(functions->symtab, core_id, sym, sym_=
sec_idx) {;
+=09=09if (elf_functions__collect_function(functions, &sym))
 =09=09=09return -1;
 =09}
=20
-=09if (encoder->functions.cnt) {
-=09=09qsort(encoder->functions.entries,
-=09=09      encoder->functions.cnt,
-=09=09      sizeof(encoder->functions.entries[0]),
+=09if (functions->cnt)
+=09=09qsort(functions->entries,
+=09=09      functions->cnt,
+=09=09      sizeof(functions->entries[0]),
 =09=09      functions_cmp);
-=09=09if (encoder->verbose)
-=09=09=09printf("Found %d functions!\n", encoder->functions.cnt);
-=09}
=20
 =09return 0;
 }
@@ -2232,9 +2233,11 @@ static int btf_encoder__collect_symbols(struct btf_e=
ncoder *encoder, bool collec
 {
 =09int err;
=20
-=09err =3D btf_encoder__collect_functions(encoder);
+=09err =3D elf_functions__collect(&encoder->functions);
 =09if (err)
 =09=09return err;
+=09if (encoder->verbose)
+=09=09printf("Found %d functions!\n", encoder->functions.cnt);
=20
 =09if (collect_percpu_vars) {
 =09=09err =3D btf_encoder__collect_percpu_vars(encoder);
@@ -2438,6 +2441,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
onst char *detached_filenam
 =09=09=09=09printf("%s: '%s' doesn't have symtab.\n", __func__, cu->filena=
me);
 =09=09=09goto out;
 =09=09}
+=09=09encoder->functions.symtab =3D encoder->symtab;
=20
 =09=09/* index the ELF sections for later lookup */
=20
--=20
2.34.1


