Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6064F5FB
	for <dwarves@vger.kernel.org>; Fri,  4 Oct 2024 05:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728018855; cv=none; b=E4SZkNUaPjhrPRBTR7DYqZw2DptVK7GFMMBiRtMOnPwF+qvxlsDXntRiIzejBejapb2gj9nqq/trEVMeJE+tJyxwhCGkTu9D7LiksRAzOC7SOotUoRDXPIjd+8uqGL+zxyko7rhzfkv285TSLCzGISPuHTNOS8tdkwbXZk78dds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728018855; c=relaxed/simple;
	bh=fabLr06zVVm3evcaxu9kc6miBEwLcVQvUT+muPVqhJI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSNWwSOraO4gd7gtwEtF9sza2EsMjg6oTy1IVUDgDemq3A0fM57sfQO7yEDMGq3EKuMmh/UrjrOPd5PJMJVjmdn7Tbap/GoDKSc96qHof0GP02Ty0Hwkab7LtvyUE3ollHTzDHEFdAN2YtqvwmAioC4oyCvgdi8ALPsPjDgUixk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=g+X6VdsB; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="g+X6VdsB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728018851; x=1728278051;
	bh=WP1W2hxdGlii5F3A4Pe5XF8FxrmF8R4ipk5bNx2GFSY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=g+X6VdsB6lmFgfcOqe9xQqWJAwnJ+q9pd5ppPlfCdBCsRqzC4MIEn8bWICnzmsuKU
	 5eeLlwgvRanM0ME5So9SUcMyRbY9A+n5E+ghn54sz7waZAlcjx9eobXY/a6pGfqlvB
	 igZfTXKFubr2aFMZjD44VCV2Q8kK5SEeeJhaWzgdpC3T9hDuCbzKXflVug8rDd3oVn
	 3tGyfoXOIb+Quq5QVl++y3GRlBDjCalpZjYmW4NSg+G7F9j9iwmp4T4W0LXUgLoXPJ
	 Rj39qvff6vJxDQKG2UMGV7QFj5lq4fpTy06ogvxtfmk5ANsizmgB6RmHATGZYNk6wY
	 Rk5IglizyFPZw==
Date: Fri, 04 Oct 2024 05:14:06 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org, eddyz87@gmail.com
Subject: [PATCH dwarves 4/6] btf_encoder: collect elf_functions in pre_cus__load_module
Message-ID: <20241004051347.41143-5-ihor.solodrai@pm.me>
In-Reply-To: <20241004051347.41143-1-ihor.solodrai@pm.me>
References: <20241004051347.41143-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 2e3ea9cebc7149a95267fb027ab4db8ea31563a4
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
btf_encoder__pre_cus__load_module hook, and disposed after
btf_encoder__encode is done.

At this point btf_encoders don't use shared elf_functions yet, but it
is built before encoders are initialized.

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++
 btf_encoder.h |  2 ++
 pahole.c      |  3 ++
 3 files changed, 81 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index ec523a1..0d4a4fe 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -106,6 +106,8 @@ struct elf_secinfo {
 };
=20
 struct elf_functions {
+=09struct list_head node; // for elf_functions_list
+=09Elf *elf; // source ELF
 =09struct elf_symtab *symtab;
 =09struct elf_function *entries;
 =09int allocated;
@@ -159,6 +161,72 @@ struct btf_kfunc_set_range {
 =09uint64_t end;
 };
=20
+
+// In principle, multiple ELFs can be processed in one pahole run,
+// so we have to store elf_functions table per ELF.
+// An element is added to the list on btf_encoder__pre_cus__load_module,
+// and removed after btf_encoder__encode is done.
+static LIST_HEAD(elf_functions_list);
+
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
+static inline void elf_functions__delete(struct elf_functions *funcs)
+{
+=09free(funcs->entries);
+=09elf_symtab__delete(funcs->symtab);
+=09list_del(&funcs->node);
+=09free(funcs);
+}
+
+static int elf_functions__collect(struct elf_functions *functions);
+
+static struct elf_functions *elf_functions__new(Elf *elf)
+{
+=09struct elf_functions *funcs =3D calloc(1, sizeof(*funcs));
+
+=09if (!funcs)
+=09=09return NULL;
+=09funcs->elf =3D elf;
+
+=09funcs->symtab =3D elf_symtab__new(NULL, elf);
+=09if (!funcs->symtab)
+=09=09goto out_error;
+
+=09int err =3D elf_functions__collect(funcs);
+
+=09if (err)
+=09=09goto out_error;
+
+=09list_add_tail(&funcs->node, &elf_functions_list);
+=09return funcs;
+
+out_error:
+=09elf_functions__delete(funcs);
+=09return NULL;
+}
+
+int btf_encoder__pre_cus__load_module(struct process_dwflmod_parms *parms,=
 Dwfl_Module *mod, Dwarf *dw, Elf *elf)
+{
+=09struct elf_functions *funcs =3D elf_functions__new(elf);
+
+=09if (!funcs)
+=09=09return -1;
+
+=09return 0;
+}
+
+
 static LIST_HEAD(encoders);
 static pthread_mutex_t encoders__lock =3D PTHREAD_MUTEX_INITIALIZER;
=20
@@ -2099,6 +2167,13 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 #endif
 =09=09err =3D btf_encoder__write_elf(encoder, encoder->btf, BTF_ELF_SEC);
 =09}
+
+=09// TODO: after moving encoders to shared elf_functions,
+=09// replace elf_functions__get(encoder->functions.elf) here
+=09// with encoder->functions
+=09// The pointer to shared elf_functions will be set in btf_encoder__new
+=09elf_functions__delete(elf_functions__get(encoder->functions.elf));
+
 =09return err;
 }
=20
@@ -2442,6 +2517,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
onst char *detached_filenam
 =09=09=09goto out;
 =09=09}
 =09=09encoder->functions.symtab =3D encoder->symtab;
+=09=09encoder->functions.elf =3D cu->elf;
=20
 =09=09/* index the ELF sections for later lookup */
=20
diff --git a/btf_encoder.h b/btf_encoder.h
index f54c95a..ee91444 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -27,4 +27,6 @@ struct btf *btf_encoder__btf(struct btf_encoder *encoder)=
;
=20
 int btf_encoder__add_encoder(struct btf_encoder *encoder, struct btf_encod=
er *other);
=20
+int btf_encoder__pre_cus__load_module(struct process_dwflmod_parms *parms,=
 Dwfl_Module *mod, Dwarf *dw, Elf *elf);
+
 #endif /* _BTF_ENCODER_H_ */
diff --git a/pahole.c b/pahole.c
index 7e7a82e..239eb13 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3823,6 +3823,9 @@ int main(int argc, char *argv[])
 =09=09conf_load.threads_collect =3D pahole_threads_collect;
 =09}
=20
+=09if (btf_encode)
+=09=09conf_load.pre_cus__load_module =3D btf_encoder__pre_cus__load_module=
;
+
 =09// Make 'pahole --header type < file' a shorter form of 'pahole -C type=
 --count 1 < file'
 =09if (conf.header_type && !class_name && prettify_input) {
 =09=09conf.count =3D 1;
--=20
2.34.1


