Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DF72701B6
	for <dwarves@vger.kernel.org>; Thu, 18 Jun 2026 01:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781745257; cv=none; b=eJJgEB6ww20BtD5pV0JnxD6Xn2RA/vycbV3olA67gFeOoUX57pf/MVzk+7WXNk9M44PrQiuMB2z8kvfatmE54CwhSXAZ2bWLgt4UHtTevH5+HluyuFpHou0h9rmKDiAY6i9YwwQApcfLIJd8IiUQqUW2zS1sIehKTbR94HGWgQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781745257; c=relaxed/simple;
	bh=qTQEcl8RqIr9vfRZCndyCjSz+dXx6hfHkJfHdln8EzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rm/B4Ax51WEnj9N9t4TRP9HwpX3DQwA2UH7KmDTn+iWjfxgS3KBOrw5qVJfeRlk0XiFti9Cws1kfOZQYatbFsv7yEe4UiWCWkY9Pr3CbPGMVA66n9cYXv05UbHxXcD5lbHLksfaekPJ+nPhDCVLAhQzMKwXxI1+pDlefZSfYges=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 8DB3D176E3B848; Wed, 17 Jun 2026 18:14:03 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v6 1/5] dwarf_loader: Detect aggregate ABI register usage and signature changes
Date: Wed, 17 Jun 2026 18:14:03 -0700
Message-ID: <20260618011403.633992-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618011358.632394-1-yonghong.song@linux.dev>
References: <20260618011358.632394-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Aggregate ABI register usage applies for both clang and gcc.
The signature change detection is clang only.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++----
 dwarves.h      |  3 +++
 2 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 16fb7be..ad1dc94 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1100,6 +1100,16 @@ static void arch__set_register_params(const GElf_E=
hdr *ehdr, struct cu *cu)
 	}
 }
=20
+static bool arch__agg_use_two_regs(const GElf_Ehdr *ehdr)
+{
+	switch (ehdr->e_machine) {
+	case EM_S390:
+		return false;
+	default:
+		return true;
+	}
+}
+
 static struct template_type_param *template_type_param__new(Dwarf_Die *d=
ie, struct cu *cu, struct conf_load *conf)
 {
 	struct template_type_param *ttparm =3D tag__alloc(cu, sizeof(*ttparm));
@@ -1502,6 +1512,29 @@ static struct ftype *ftype__new(Dwarf_Die *die, st=
ruct cu *cu)
 	return ftype;
 }
=20
+static bool function__signature_changed(struct function *func, Dwarf_Die=
 *die)
+{
+	/* The inlined DW_TAG_subprogram typically has the original source type=
 for
+	 * abstract origin of a concrete function with address range, inlined s=
ubroutine,
+	 * or call site.
+	 */
+	if (func->inlined)
+		return false;
+
+	if (!func->abstract_origin)
+		return attr_numeric(die, DW_AT_calling_convention) =3D=3D DW_CC_nocall=
;
+
+	Dwarf_Attribute attr;
+	if (dwarf_attr(die, DW_AT_abstract_origin, &attr)) {
+		Dwarf_Die origin;
+		if (dwarf_formref_die(&attr, &origin))
+			return attr_numeric(&origin, DW_AT_calling_convention) =3D=3D DW_CC_n=
ocall;
+	}
+
+	/* This should not happen */
+	return false;
+}
+
 static struct function *function__new(Dwarf_Die *die, struct cu *cu, str=
uct conf_load *conf)
 {
 	struct function *func =3D tag__alloc(cu, sizeof(*func));
@@ -2392,10 +2425,17 @@ static struct tag *die__create_new_function(Dwarf=
_Die *die, struct cu *cu, struc
 {
 	struct function *function =3D function__new(die, cu, conf);
=20
-	if (function !=3D NULL &&
-	    die__process_function(die, &function->proto, &function->lexblock, c=
u, conf) !=3D 0) {
-		function__delete(function, cu);
-		function =3D NULL;
+	if (function !=3D NULL) {
+		/* For clang, we determine if function signature changes via DW_AT_cal=
ling_convention
+		 * set to DW_CC_nocall.
+		 */
+		if (cu->producer_clang)
+			function->proto.signature_changed =3D function__signature_changed(fun=
ction, die);
+
+		if (die__process_function(die, &function->proto, &function->lexblock, =
cu, conf) !=3D 0) {
+			function__delete(function, cu);
+			function =3D NULL;
+		}
 	}
=20
 	return function ? &function->proto.tag : NULL;
@@ -3045,6 +3085,17 @@ static unsigned long long dwarf_tag__orig_id(const=
 struct tag *tag,
 	return cu->extra_dbg_info ? dtag->id : 0;
 }
=20
+static bool attr_producer_clang(Dwarf_Die *die)
+{
+	const char *producer;
+
+	producer =3D attr_string(die, DW_AT_producer, NULL);
+	if (!producer)
+		return false;
+
+	return !!strstr(producer, "clang");
+}
+
 struct debug_fmt_ops dwarf__ops;
=20
 static int die__process(Dwarf_Die *die, struct cu *cu, struct conf_load =
*conf)
@@ -3082,6 +3133,7 @@ static int die__process(Dwarf_Die *die, struct cu *=
cu, struct conf_load *conf)
 	}
=20
 	cu->language =3D attr_numeric(die, DW_AT_language);
+	cu->producer_clang =3D attr_producer_clang(die);
=20
 	if (conf->early_cu_filter)
 		cu =3D conf->early_cu_filter(cu);
@@ -3300,6 +3352,7 @@ static int cu__set_common(struct cu *cu, struct con=
f_load *conf,
=20
 	cu->little_endian =3D ehdr.e_ident[EI_DATA] =3D=3D ELFDATA2LSB;
 	cu->nr_register_params =3D arch__nr_register_params(&ehdr);
+	cu->agg_use_two_regs =3D arch__agg_use_two_regs(&ehdr);
 	arch__set_register_params(&ehdr, cu);
 	return 0;
 }
@@ -3841,6 +3894,7 @@ static int cus__merge_and_process_cu(struct cus *cu=
s, struct conf_load *conf,
 			cu->priv =3D dcu;
 			cu->dfops =3D &dwarf__ops;
 			cu->language =3D attr_numeric(cu_die, DW_AT_language);
+			cu->producer_clang =3D attr_producer_clang(cu_die);
 			cus__add(cus, cu);
 		}
=20
diff --git a/dwarves.h b/dwarves.h
index 5ec16e7..fcc3976 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -306,6 +306,8 @@ struct cu {
 	uint8_t		 has_addr_info:1;
 	uint8_t		 uses_global_strings:1;
 	uint8_t		 little_endian:1;
+	uint8_t		 producer_clang:1;
+	uint8_t		 agg_use_two_regs:1;	/* An aggregate like {long a; long b;} */
 	uint8_t		 nr_register_params;
 	int		 register_params[ARCH_MAX_REGISTER_PARAMS];
 	int		 functions_saved;
@@ -1030,6 +1032,7 @@ struct ftype {
 	uint8_t		 inconsistent_proto:1;
 	uint8_t		 uncertain_parm_loc:1;
 	uint8_t		 reordered_parm:1;
+	uint8_t		 signature_changed:1;
 	struct list_head template_type_params;
 	struct list_head template_value_params;
 	struct template_parameter_pack *template_parameter_pack;
--=20
2.53.0-Meta

