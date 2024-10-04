Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6726552F76
	for <dwarves@vger.kernel.org>; Fri,  4 Oct 2024 05:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728018850; cv=none; b=c+MeG6vUudYHtQ6p7UQDPBHk2E8+ZkhxLBaqbEJZdfv/xYlAXwYghZeRcmhPCZIiEWCqyoeimLqqtLldKwwLD7Xc7noVXOKBvd531qoaCQa7LTg0JrtT0QQ6kyqeymB5mGAsSYqkIniO0TS1LlfHdOusOr+O0tTj6LFI6p6ijNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728018850; c=relaxed/simple;
	bh=kB1Yxhzvhlty0q3SwDIadVICeEMouT3Rv0sLIWQdn7E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kIrbu0/ftyENJCff45RcWrbqwY9UcsnxkXmN9XxOK1DQXUab08DRyOSOvwxPbMjMTN+QuyQqZrJLXeoGJVtgl5hG0+bY4YmMdnOkI0XBXsxiT3Phg9xg20uMnUUel/fDLz/ICngITCeldaix6B3zl9ic0btqSQ5M+C8G4qgGMlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=J8khgHbe; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="J8khgHbe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728018840; x=1728278040;
	bh=A/p8iSRH0htfqN2UqFBpiFMryF0JfGKhAirvPyaXQr4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=J8khgHbeF0G9L1UjcYjUOZdje1RAV6VVlyoyCPKmILYxaZnfs6Vq6cxoriy0Jp/WA
	 m7ALkp5ebzEubZDSGFl6t2qVAzDfOKUsw4BjwXT1ij88Sm0I88+gVBDlBO74WpXtvI
	 V6+9wixYVJgOeaCiKH8ON2GY8YzFA87T8KM30fQGEZGiPU+Cg3i4cEpIzC7xKtIhj4
	 cJXy8styfNvXf8Bn+6Ilp7zYnA2TIreUGrS5g28lCv709gSDE1OLBjXQ9v7oofY4A4
	 DL/zkAYY0QhfKnsTn695nHzJI8VEBCn4IbgAe4wsAsh+Z4Jacf469BXZrj96+hlyfP
	 2BhmOB/ioqFPA==
Date: Fri, 04 Oct 2024 05:13:57 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org, eddyz87@gmail.com
Subject: [PATCH dwarves 2/6] btf_encoder: split btf_encoder__collect_symbols()
Message-ID: <20241004051347.41143-3-ihor.solodrai@pm.me>
In-Reply-To: <20241004051347.41143-1-ihor.solodrai@pm.me>
References: <20241004051347.41143-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 9dd039e7aab82f744a9c0853a6c4914f32ccf781
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

btf_encoder__collect_symbols() collects information on percpu
variables and functions from ELF symbols. Factor out these steps into
separate functions.

This makes sense for subsequent changes making functions table not
btf_encoder-specific. Also percpu vars will not be collected after
global variables support is merged [1].

[1]: https://lore.kernel.org/dwarves/df3c21d4-9f42-4681-b7bb-78134f430f1c@o=
racle.com/T/#mf945ef7ecefe3915930c78358c03918ba28f0a05

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 btf_encoder.c | 52 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 51cd7bf..6e7d2e7 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2178,7 +2178,7 @@ static int btf_encoder__collect_percpu_var(struct btf=
_encoder *encoder, GElf_Sym
 =09return 0;
 }
=20
-static int btf_encoder__collect_symbols(struct btf_encoder *encoder, bool =
collect_percpu_vars)
+static int btf_encoder__collect_percpu_vars(struct btf_encoder *encoder)
 {
 =09Elf32_Word sym_sec_idx;
 =09uint32_t core_id;
@@ -2189,22 +2189,37 @@ static int btf_encoder__collect_symbols(struct btf_=
encoder *encoder, bool collec
=20
 =09/* search within symtab for percpu variables */
 =09elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_se=
c_idx) {
-=09=09if (collect_percpu_vars && btf_encoder__collect_percpu_var(encoder, =
&sym, sym_sec_idx))
-=09=09=09return -1;
-=09=09if (btf_encoder__collect_function(encoder, &sym))
+=09=09if (btf_encoder__collect_percpu_var(encoder, &sym, sym_sec_idx))
 =09=09=09return -1;
 =09}
=20
-=09if (collect_percpu_vars) {
-=09=09if (encoder->percpu.var_cnt)
-=09=09=09qsort(encoder->percpu.vars, encoder->percpu.var_cnt, sizeof(encod=
er->percpu.vars[0]), percpu_var_cmp);
+=09if (encoder->percpu.var_cnt)
+=09=09qsort(encoder->percpu.vars,
+=09=09      encoder->percpu.var_cnt,
+=09=09      sizeof(encoder->percpu.vars[0]),
+=09=09      percpu_var_cmp);
=20
-=09=09if (encoder->verbose)
-=09=09=09printf("Found %d per-CPU variables!\n", encoder->percpu.var_cnt);
+=09if (encoder->verbose)
+=09=09printf("Found %d per-CPU variables!\n", encoder->percpu.var_cnt);
+
+=09return 0;
+}
+
+static int btf_encoder__collect_functions(struct btf_encoder *encoder)
+{
+=09Elf32_Word sym_sec_idx;
+=09uint32_t core_id;
+=09GElf_Sym sym;
+
+=09elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_se=
c_idx) {;
+=09=09if (btf_encoder__collect_function(encoder, &sym))
+=09=09=09return -1;
 =09}
=20
 =09if (encoder->functions.cnt) {
-=09=09qsort(encoder->functions.entries, encoder->functions.cnt, sizeof(enc=
oder->functions.entries[0]),
+=09=09qsort(encoder->functions.entries,
+=09=09      encoder->functions.cnt,
+=09=09      sizeof(encoder->functions.entries[0]),
 =09=09      functions_cmp);
 =09=09if (encoder->verbose)
 =09=09=09printf("Found %d functions!\n", encoder->functions.cnt);
@@ -2213,6 +2228,23 @@ static int btf_encoder__collect_symbols(struct btf_e=
ncoder *encoder, bool collec
 =09return 0;
 }
=20
+static int btf_encoder__collect_symbols(struct btf_encoder *encoder, bool =
collect_percpu_vars)
+{
+=09int err;
+
+=09err =3D btf_encoder__collect_functions(encoder);
+=09if (err)
+=09=09return err;
+
+=09if (collect_percpu_vars) {
+=09=09err =3D btf_encoder__collect_percpu_vars(encoder);
+=09=09if (err)
+=09=09=09return err;
+=09}
+
+=09return 0;
+}
+
 static bool ftype__has_arg_names(const struct ftype *ftype)
 {
 =09struct parameter *param;
--=20
2.34.1


