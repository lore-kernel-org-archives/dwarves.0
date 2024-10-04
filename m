Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8219952F76
	for <dwarves@vger.kernel.org>; Fri,  4 Oct 2024 05:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728018845; cv=none; b=VPR7XN+iFtUzAhT+MfyrsdnZtACgDVY2zk7tLp2fVOlo0COCc7BbbSC+yC5FGOf8/cgyRSnxLIrDzepiSIPGtJGJxFs/2KAVgZnmqwNHg3SfsocXU4bLJ+zj/A7nFHK9lqyKRB0uT58PaO0LCoDNkg0FrrKdYhgrmn5kaDf1FcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728018845; c=relaxed/simple;
	bh=/9acKDaYlExGAJ6Q96gNg9HcCISIhEIinEDd7PuZ46k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qOcxZPolNvmHClanFZNrIFT9SdoAQaLJktAb+aWIaWH7yTl2lq9XYTvtQTFE/58L6YlI43iurSY5OPfZhv0urEPTen1JAek42WpXMLwBmlQFIoss+yM9Q2iSwJWvbr057q4UHt2y80gyI/XyjeB2nExwfCSJ0xKSKxA3rlrTSc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=d6MR+2DO; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="d6MR+2DO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728018836; x=1728278036;
	bh=w5ITwI8YhRykwjlojvLiIisRZ4WMvg5RcKFfS6sMl/Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=d6MR+2DOAt5Vrqx3TR4dzriV0EUxhJLixSZfEoZtVQ/NumAieMTm6saRLp/YAJw/d
	 UmEXfuu1+XWGa2O4XnI8FIYaVH3C5teFvQ/6LWrpdDDXgRQ8LlYW2xUgIIVnM6nWm0
	 G/YcFSFCgug/JDlgarNwCH+xYkGBjYyNVBtGm0FeZ66Shd5pNsd9YCQ4hnYkMtBd23
	 cahdtAmlw+kweKVqEbh+FuwwQ/WaMDOLJAuoYLoF9qCrEbpERUCBxhP9kBdQ5rlWFX
	 nLSdGVPE+/UOhPmHkhiTI/rYDehNQh39jncscMdbSRC79dKyLVcKFH0oUifnpaFydq
	 YFkAc/JXHONgw==
Date: Fri, 04 Oct 2024 05:13:54 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org, eddyz87@gmail.com
Subject: [PATCH dwarves 1/6] dwarf_loader: introduce pre/post cus__load_module hooks to conf_load
Message-ID: <20241004051347.41143-2-ihor.solodrai@pm.me>
In-Reply-To: <20241004051347.41143-1-ihor.solodrai@pm.me>
References: <20241004051347.41143-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 379c6e0df25a252c095e7c9d169c6a5510aba5b6
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
index f58e1d0..1b16f0c 100644
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
@@ -105,6 +113,14 @@ struct conf_load {
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
@@ -166,8 +182,6 @@ struct conf_fprintf {
 =09uint8_t    skip_emitting_modifier:1;
 };
=20
-struct cus;
-
 struct cus *cus__new(void);
 void cus__delete(struct cus *cus);
=20
--=20
2.34.1


