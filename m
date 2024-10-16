Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999611FB3
	for <dwarves@vger.kernel.org>; Wed, 16 Oct 2024 00:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729037451; cv=none; b=FCAd2HQXrhuHxa9+O6PWgZco8FNtnaoh+2uqJvnsrNjSQMGLSvD+O8VM/9CFwZeUwCYI+SXEYCYd7LEIyt9LMJb7v3Ij7nnpaw8I/vh4n7b9dUiArllxiW3HVcdoVxQ4VFt4L+AOLr8VR2OHNd2Ee5kpH4BBnoBTF509OFx+g10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729037451; c=relaxed/simple;
	bh=n4HXQGha7YoGJ1KBoqanxHH86HpGp84YF3XNk3NhjKE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rz87As7bkcrDlmv9PoZkbpDYjF4HPXqerX+bdie5PKVv6qtE42VUM+1h7NzrFhHyAbaWkPs64zGVMPb2tv2DObt7+a5LPY3msgQgLAW+gx5B3O7CXFiM2bnscR2Ax/EAXjUp4946kU4Wh3CW3WD0bbeO4HKoePy0BgO7mjAHRr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=NSWFMmbO; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="NSWFMmbO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1729037447; x=1729296647;
	bh=CQ5RAHUrIq3qbqrh2XNWLfiyiWcOr9/lkg9yNKwpGEo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NSWFMmbOfZ+Z4pmnV8fVEK2wPw1EBIvzXEEfIvO2gCPczxDJj391PcI2HP+tUTW/o
	 L1F+Y/D0uf0B2GtiBKa38SRrjGAQKVyHRWVzlKFggWV2pFDG8XcdZVf4lrKyOwPUJu
	 AQFCHTxW4qnrlNXPFeDtfkrwJDPcqN1rtvE9ZafG+3h4+OHdF5q1dCwqyfJpkoeE0a
	 QUrs3HaatwY5r1R6JpUxcB1lSBsyTUzPHCJ8svM9ANmAGTyVPyQLIrKm1rTblucPEr
	 8IHMk6UJIDCKAR9eATH9Zcx589EmM4W165e5QcZk2R4+qta0pzZE4UklgtoGi9fUO8
	 XwH7YgQnRatLg==
Date: Wed, 16 Oct 2024 00:10:44 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org, eddyz87@gmail.com
Subject: [PATCH v3 dwarves 3/5] btf_encoder: collect elf_functions in btf_encoder__pre_load_module
Message-ID: <20241016001025.857970-4-ihor.solodrai@pm.me>
In-Reply-To: <20241016001025.857970-1-ihor.solodrai@pm.me>
References: <20241016001025.857970-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: d8825788566c1aa556330ee10a5503c853a7cd62
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Introduce a global elf_functions_list variable in btf_encoder.c that
contains an elf_functions per ELF.

An elf_functions structure is allocated and filled out by
btf_encoder__pre_load_module() hook, and the list is cleared after
btf_encoder__encode() is done.

At this point btf_encoders don't use shared elf_functions yet (each
maintains their own copy as before), but it is built before encoders
are initialized.

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
 btf_encoder.h |  2 ++
 pahole.c      |  3 +++
 3 files changed, 71 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index 9c840fa..8e8fd05 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -103,6 +103,8 @@ struct elf_secinfo {
 };
=20
 struct elf_functions {
+=09struct list_head node; /* for elf_functions_list */
+=09Elf *elf; /* source ELF */
 =09struct elf_symtab *symtab;
 =09struct elf_function *entries;
 =09int cnt;
@@ -147,6 +149,67 @@ struct btf_kfunc_set_range {
 =09uint64_t end;
 };
=20
+
+/* In principle, multiple ELFs can be processed in one pahole run,
+ * so we have to store elf_functions table per ELF.
+ * An element is added to the list on btf_encoder__pre_load_module,
+ * and removed after btf_encoder__encode is done.
+ */
+static LIST_HEAD(elf_functions_list);
+
+static inline void elf_functions__delete(struct elf_functions *funcs)
+{
+=09free(funcs->entries);
+=09elf_symtab__delete(funcs->symtab);
+=09list_del(&funcs->node);
+=09free(funcs);
+}
+
+static inline void elf_functions__delete_all(void)
+{
+=09struct list_head *pos, *tmp;
+
+=09list_for_each_safe(pos, tmp, &elf_functions_list) {
+=09=09struct elf_functions *funcs =3D list_entry(pos, struct elf_functions=
, node);
+
+=09=09elf_functions__delete(funcs);
+=09}
+}
+
+static int elf_functions__collect(struct elf_functions *functions);
+
+int btf_encoder__pre_load_module(Dwfl_Module *mod, Elf *elf)
+{
+=09struct elf_functions *funcs;
+=09int err;
+
+=09funcs =3D calloc(1, sizeof(*funcs));
+=09if (!funcs) {
+=09=09err =3D -ENOMEM;
+=09=09goto out_delete;
+=09}
+
+=09funcs->symtab =3D elf_symtab__new(NULL, elf);
+=09if (!funcs->symtab) {
+=09=09err =3D -1;
+=09=09goto out_delete;
+=09}
+
+=09funcs->elf =3D elf;
+=09err =3D elf_functions__collect(funcs);
+=09if (err)
+=09=09goto out_delete;
+
+=09list_add_tail(&funcs->node, &elf_functions_list);
+
+=09return 0;
+
+out_delete:
+=09elf_functions__delete(funcs);
+=09return err;
+}
+
+
 static LIST_HEAD(encoders);
 static pthread_mutex_t encoders__lock =3D PTHREAD_MUTEX_INITIALIZER;
=20
@@ -2071,6 +2134,8 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 #endif
 =09=09err =3D btf_encoder__write_elf(encoder, encoder->btf, BTF_ELF_SEC);
 =09}
+
+=09elf_functions__delete_all();
 =09return err;
 }
=20
@@ -2387,6 +2452,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
onst char *detached_filenam
 =09=09=09goto out;
 =09=09}
 =09=09encoder->functions.symtab =3D encoder->symtab;
+=09=09encoder->functions.elf =3D cu->elf;
=20
 =09=09/* index the ELF sections for later lookup */
=20
diff --git a/btf_encoder.h b/btf_encoder.h
index 824963b..7debd67 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -34,4 +34,6 @@ struct btf *btf_encoder__btf(struct btf_encoder *encoder)=
;
=20
 int btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encod=
er *other);
=20
+int btf_encoder__pre_load_module(Dwfl_Module *mod, Elf *elf);
+
 #endif /* _BTF_ENCODER_H_ */
diff --git a/pahole.c b/pahole.c
index b9e97ef..891af3a 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3814,6 +3814,9 @@ int main(int argc, char *argv[])
 =09=09conf_load.threads_collect =3D pahole_threads_collect;
 =09}
=20
+=09if (btf_encode)
+=09=09conf_load.pre_load_module =3D btf_encoder__pre_load_module;
+
 =09// Make 'pahole --header type < file' a shorter form of 'pahole -C type=
 --count 1 < file'
 =09if (conf.header_type && !class_name && prettify_input) {
 =09=09conf.count =3D 1;
--=20
2.43.0


