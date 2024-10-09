Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDA51E132D
	for <dwarves@vger.kernel.org>; Wed,  9 Oct 2024 23:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728516943; cv=none; b=YMShR53Em2aK+a5hDF/G9iVyLPQ7rQ9DacqJ4l2IloOGocfO8W4h+ZIPIcvXXp8S1DVzGhLFJIJmKWdk78jKWanRuG7fvLhPnuCl+bg6MrgOe3Dl3S9jnt+dPJTRDMr/1SjqsDy4AgS636nsFMrgWzPRPWQVioE+OjjNf7LpriU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728516943; c=relaxed/simple;
	bh=HfHza9xANUJidZ3g4MMwAs0yF6u8et18KHpHeVNUR/Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUu8J6v1Neb9L9YrxDmgqvrVeKG+Th4uyK5lF4f/RS0zf5ETFAhuKCQVt14zgp00eCFpvmU8qec7Tu/H5y/1wIJf282eacLww0PzbFHfygftlib61ju1QCyUhfr1cgNiPrUw5QnwuMskBhND+EQg/gHUci94AmVdPj1hhrEesFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=fpIMdeLp; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="fpIMdeLp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728516938; x=1728776138;
	bh=6V+BG9AfE40XBx8B6nMpz4CZYquyx5M/f3sChW5mIzU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=fpIMdeLp3MeyWxeG+pjFzvtKDKJuDkEdLTO/2gOiI4NXC5V0NNRXwkoUgIfYAutHF
	 Zr0+iIiue/ngKcwc0gRSJN6w9Kd5lkAdaYBAWtjzPD+27IGasFh9K2DoV6lp9ZznNs
	 MD6whRfjj9OdPGNaC4lSiL12+090IwsFFXcWEUbmfghg1VW6SZOGxtRJmN5FicjRBt
	 dlNTFptuD/w9+ekSgLo3POMM/r14Y3CYFckTcjAXRngTT4zIakewA428wd5WEbVERF
	 48efMm/DYyo5KdCJvaEqYkQmZ3vpDskCxEzUYKGk+e6SkzfuVnkW4/GLHFo8zC/Rjz
	 a2I4Dg8P+Zzpw==
Date: Wed, 09 Oct 2024 23:35:34 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org, eddyz87@gmail.com
Subject: [PATCH v2 dwarves 3/5] btf_encoder: collect elf_functions in pre_cus__load_module
Message-ID: <20241009233520.989453-4-ihor.solodrai@pm.me>
In-Reply-To: <20241009233520.989453-1-ihor.solodrai@pm.me>
References: <20241009233520.989453-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 7ab71895327d1910cdb6070142e6ac1158426e6f
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
index 8abca7f..9e05b56 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -103,6 +103,8 @@ struct elf_secinfo {
 };
=20
 struct elf_functions {
+=09struct list_head node; // for elf_functions_list
+=09Elf *elf; // source ELF
 =09struct elf_symtab *symtab;
 =09struct elf_function *entries;
 =09int cnt;
@@ -147,6 +149,72 @@ struct btf_kfunc_set_range {
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
@@ -2071,6 +2139,13 @@ int btf_encoder__encode(struct btf_encoder *encoder)
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
@@ -2369,6 +2444,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, c=
onst char *detached_filenam
 =09=09=09goto out;
 =09=09}
 =09=09encoder->functions.symtab =3D encoder->symtab;
+=09=09encoder->functions.elf =3D cu->elf;
=20
 =09=09/* index the ELF sections for later lookup */
=20
diff --git a/btf_encoder.h b/btf_encoder.h
index 824963b..7bfc994 100644
--- a/btf_encoder.h
+++ b/btf_encoder.h
@@ -34,4 +34,6 @@ struct btf *btf_encoder__btf(struct btf_encoder *encoder)=
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
index b9e97ef..0ff6bc2 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3814,6 +3814,9 @@ int main(int argc, char *argv[])
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
2.43.0


