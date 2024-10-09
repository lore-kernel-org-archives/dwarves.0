Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5BF18FC80
	for <dwarves@vger.kernel.org>; Wed,  9 Oct 2024 23:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728516939; cv=none; b=IuoEcUXMXu/F0PvpRX/Hb67OAH4bg4CTwXiuE0Ab/6UYEoM5kXkykZAI+7IMhSH2oUrMhJdSv1JpeLIWNogRuFKRXNS5ejRDtk0Z3366qolTaNw0D6/aMyuO18P8capjsBmpq+9uqA3axvZLCAlZbJc2/KetXZ3A8/zVKReG6XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728516939; c=relaxed/simple;
	bh=DSaLSOVx3bxAyVhLCCf2o5mpFXSSWKD4JEIsP/QRUBI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oL5Tny8UmpKSLpdzKjSDTL8xTJD8Z2RejRoU4ochSzHjHweDoUti3/KI8zB4YqzQHO/d4vacWWPe2jf8MqqRL+83SQ1Qy5K1W1fvxRrnQ85xeH4nfGEH7q35x0TkC5jNvvLWhFw6e1vtrFMB1+meKHD/9+ME6xsGXjkZs82tdd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=MZu2rILJ; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="MZu2rILJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728516930; x=1728776130;
	bh=IvUFNtsQZiinBPkeUUK07YkHn8CZwnNKw2NrVcqfA0I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MZu2rILJ9mgGOTe0MM4quI8YT5Cb8tRX9//IPb9CTZnWR6SC3HC2PTmOG7IbA78+m
	 p6++3AiT9fXlDsQz7tqoED/4R76m/ZDZa0MFn3aQ3c5Htp1eE6E3tn43sKmcA6NVeP
	 aB/MDbCbAyyBgAzq6MoyPgFsvtcScq8/CPvAQNd53d5UdgqeMnq7NTa29jLo1erOuk
	 AG0UrxMTMaDXupg1sHTPQk4xaYA6VjK/2TUfknwjOEGVLkHn1yafBuzFzia/dbBUhj
	 82AJRvG+DXFy3fwsgXt3USZ/Qfnk/B3+Ue8W5HZFxdcQbiAcMC7OaG5dOweNI/4Qxj
	 aXqsdy90m6k4Q==
Date: Wed, 09 Oct 2024 23:35:26 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org, eddyz87@gmail.com
Subject: [PATCH v2 dwarves 1/5] dwarf_loader: introduce pre/post cus__load_module hooks to conf_load
Message-ID: <20241009233520.989453-2-ihor.solodrai@pm.me>
In-Reply-To: <20241009233520.989453-1-ihor.solodrai@pm.me>
References: <20241009233520.989453-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: faf78215a50c5eff7d72be158988c6250eec7433
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Preparation for making btf_encoder.functions table shared between
encoders.

Shared table can be built as soon as Elf struct is extracted from
Dwfl_Module, which happens in cus__proces_dwflmod.

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 dwarf_loader.c | 21 ++++++++++++++-------
 dwarves.h      | 18 ++++++++++++++++--
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index e54a16c..fb42eb5 100644
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
@@ -3753,10 +3746,24 @@ static int cus__process_dwflmod(Dwfl_Module *dwflmo=
d,
 =09Dwarf *dw =3D dwfl_module_getdwarf(dwflmod, &dwbias);
=20
 =09int err =3D DWARF_CB_OK;
+=09if (parms->conf->pre_cus__load_module) {
+=09=09err =3D parms->conf->pre_cus__load_module(parms, dwflmod, dw, elf);
+=09=09if (err)
+=09=09=09return DWARF_CB_ABORT;
+=09}
+
 =09if (dw !=3D NULL) {
 =09=09++parms->nr_dwarf_sections_found;
 =09=09err =3D cus__load_module(cus, parms->conf, dwflmod, dw, elf,
 =09=09=09=09       parms->filename);
+=09=09if (err)
+=09=09=09return err;
+=09}
+
+=09if (parms->conf->post_cus__load_module) {
+=09=09err =3D parms->conf->post_cus__load_module(parms, dwflmod, dw, elf);
+=09=09if (err)
+=09=09=09return DWARF_CB_ABORT;
 =09}
 =09/*
 =09 * XXX We will fall back to try finding other debugging
diff --git a/dwarves.h b/dwarves.h
index f147b2b..3b346c7 100644
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
@@ -106,6 +114,14 @@ struct conf_load {
 =09struct conf_fprintf=09*conf_fprintf;
 =09int=09=09=09(*threads_prepare)(struct conf_load *conf, int nr_threads, =
void **thr_data);
 =09int=09=09=09(*threads_collect)(struct conf_load *conf, int nr_threads, =
void **thr_data, int error);
+=09int=09=09=09(*pre_cus__load_module)(struct process_dwflmod_parms *parms=
,
+=09=09=09=09=09=09=09Dwfl_Module *mod,
+=09=09=09=09=09=09=09Dwarf *dw,
+=09=09=09=09=09=09=09Elf *elf);
+=09int=09=09=09(*post_cus__load_module)(struct process_dwflmod_parms *parm=
s,
+=09=09=09=09=09=09=09 Dwfl_Module *mod,
+=09=09=09=09=09=09=09 Dwarf *dw,
+=09=09=09=09=09=09=09 Elf *elf);
 };
=20
 /** struct conf_fprintf - hints to the __fprintf routines
@@ -167,8 +183,6 @@ struct conf_fprintf {
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


