Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80E81859
	for <dwarves@vger.kernel.org>; Wed, 16 Oct 2024 00:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729037449; cv=none; b=eqXtWfJCrGcyiC3HSJsZbvGY116crwnFvXJlw+sr6SbD04xllc6ybHViOQWbm+UBODxYieiSZJI+lXlTadQvgnW1W6vd24cGrcd0i/CXJAc3aYW0sXXcZBLXqucC6rp8IEH0Ftf7d65rbLCYpBvEr1QR6LbU6ZV960ZUdZ96Lbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729037449; c=relaxed/simple;
	bh=UVEVsj8QEPnxO/NfFtlEsFMwsdu5vUnoMPJoecMEJaQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4WxlABXNIyUn8pGN+PiS0Y3Ofsa80GwqSPimNoKg49Msr0Bw02FDsA05cx61crSvDaI4TPvgp4N1NlX/ReerXxms7QSkmfK42d/F9+R8UEJp9KRZQVKoHiHytevTLSzPYUyMyKEeRm+vnbPTEc7NzfcDjq1VV2pagdbzRSYRD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=lDSqKNUi; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="lDSqKNUi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1729037439; x=1729296639;
	bh=yYIJw/fmgmiH88UTi1jhYuPNiPTB1ZuwIAvoh+r4ab4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lDSqKNUiIT/rVl7SUkVUrNK3B1NEBlXQa9ZUpMzx5u7oYoqWb1U3ZXFyDzdV76qu5
	 Xxcc2/wH8TWAbTg7VKY55epD8apintrq86XeIqZgDZOdGL2tE2e0lzMq3ugwhvdKKx
	 5M4drAsVAl8QSiKx7H60ISbuXVOSEndKDKgGvmC2uWDWaTJxnTVYmH6LppbTli88ek
	 cBxJ5Pe7ZKHgUEt0iD60/EPCKxQJcoLv56xwMO2dhwchj4KuJ5xEDp9p7Q148M79c0
	 THNOY8EbSWEpgj/DdRsHH2yPHQkxOpiRq2zYw3xe9/r7xVYGQPz0XPMypG0416FAv1
	 u/fqSdP9pAbww==
Date: Wed, 16 Oct 2024 00:10:33 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org, eddyz87@gmail.com
Subject: [PATCH v3 dwarves 1/5] dwarf_loader: introduce pre_load_module hook to conf_load
Message-ID: <20241016001025.857970-2-ihor.solodrai@pm.me>
In-Reply-To: <20241016001025.857970-1-ihor.solodrai@pm.me>
References: <20241016001025.857970-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 3d19f40ce323d5ea62c209820a4fba17e69ebe4f
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add a function pointer to conf_load, which is called immediately after
Elf is extracted from Dwfl_Module in cus__proces_dwflmod.

This is a preparation for making elf_functions table shared between
encoders. Shared table can be built as soon as the relevant Elf is
available.

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 dwarf_loader.c | 14 +++++++-------
 dwarves.h      | 11 +++++++++--
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index e54a16c..83a7f54 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3723,13 +3723,6 @@ static int cus__load_module(struct cus *cus, struct =
conf_load *conf,
 =09return DWARF_CB_OK;
 }
=20
-struct process_dwflmod_parms {
-=09struct cus=09 *cus;
-=09struct conf_load *conf;
-=09const char=09 *filename;
-=09uint32_t=09 nr_dwarf_sections_found;
-};
-
 static int cus__process_dwflmod(Dwfl_Module *dwflmod,
 =09=09=09=09void **userdata __maybe_unused,
 =09=09=09=09const char *name __maybe_unused,
@@ -3753,11 +3746,18 @@ static int cus__process_dwflmod(Dwfl_Module *dwflmo=
d,
 =09Dwarf *dw =3D dwfl_module_getdwarf(dwflmod, &dwbias);
=20
 =09int err =3D DWARF_CB_OK;
+=09if (parms->conf->pre_load_module) {
+=09=09err =3D parms->conf->pre_load_module(dwflmod, elf);
+=09=09if (err)
+=09=09=09return DWARF_CB_ABORT;
+=09}
+
 =09if (dw !=3D NULL) {
 =09=09++parms->nr_dwarf_sections_found;
 =09=09err =3D cus__load_module(cus, parms->conf, dwflmod, dw, elf,
 =09=09=09=09       parms->filename);
 =09}
+
 =09/*
 =09 * XXX We will fall back to try finding other debugging
 =09 * formats (CTF), so no point in telling this to the user
diff --git a/dwarves.h b/dwarves.h
index f147b2b..eb3be6e 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -36,6 +36,7 @@
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(=
arr))
=20
 struct cu;
+struct cus;
=20
 enum load_steal_kind {
 =09LSK__KEEPIT,
@@ -58,6 +59,13 @@ typedef uint32_t type_id_t;
 struct btf;
 struct conf_fprintf;
=20
+struct process_dwflmod_parms {
+=09struct cus=09 *cus;
+=09struct conf_load *conf;
+=09const char=09 *filename;
+=09uint32_t=09 nr_dwarf_sections_found;
+};
+
 /** struct conf_load - load configuration
  * @thread_exit - called at the end of a thread, 1st user: BTF encoder ded=
up
  * @extra_dbg_info - keep original debugging format extra info
@@ -106,6 +114,7 @@ struct conf_load {
 =09struct conf_fprintf=09*conf_fprintf;
 =09int=09=09=09(*threads_prepare)(struct conf_load *conf, int nr_threads, =
void **thr_data);
 =09int=09=09=09(*threads_collect)(struct conf_load *conf, int nr_threads, =
void **thr_data, int error);
+=09int=09=09=09(*pre_load_module)(Dwfl_Module *mod, Elf *elf);
 };
=20
 /** struct conf_fprintf - hints to the __fprintf routines
@@ -167,8 +176,6 @@ struct conf_fprintf {
 =09uint8_t    skip_emitting_modifier:1;
 };
=20
-struct cus;
-
 struct cus *cus__new(void);
 void cus__delete(struct cus *cus);
=20
--=20
2.43.0


