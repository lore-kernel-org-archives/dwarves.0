Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2E23C4B87
	for <dwarves@vger.kernel.org>; Tue, 23 Jun 2026 22:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782253750; cv=none; b=W9or2Rn+RAa97hXNLz/7OZRVnOuG6hXF/WTLYfE4aGAsV/CH9ndx+Gl5eQocatkxEevABX38ViYnPlZ/9NYDk9ESclnw+TRD1JVWK+epb4KeJCYvomQihieyR86myVxMkvRq58JOf/FQWK4ww0F3+yq2PT3YNps562ytxGIocro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782253750; c=relaxed/simple;
	bh=1O/B9aP16YtM2LdNLiAMZzCiKEKBcP1+FH/HQtBHryU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZoP9m8H1kxdNrTeYYieV2okzTVfQsB6Ebko2duU8eUZf11CSU31lEo6Isglea8Uto4f1jVPY0iDsCgVDi4wusQ8XIogKhrGeAz4kyd3xsjsXrffWPXH72OWPv4yp9cyDB7Zjz+PK9QjLzkk3zl9bdY0UPS4DGSKBwVne0Gpm60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id BD67C1973B5CBA; Tue, 23 Jun 2026 15:28:55 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v8 1/5] dwarf_loader: Detect aggregate ABI register usage and clang compiler
Date: Tue, 23 Jun 2026 15:28:55 -0700
Message-ID: <20260623222855.3291337-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623222850.3290612-1-yonghong.song@linux.dev>
References: <20260623222850.3290612-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Aggregate ABI register usage applies for both clang and gcc.
Detect clang compiler for occasional clang specific cases.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 24 ++++++++++++++++++++++++
 dwarves.h      |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 8ce34cb..11a2377 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1137,6 +1137,16 @@ static void arch__set_register_params(const GElf_E=
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
@@ -3154,6 +3164,17 @@ static unsigned long long dwarf_tag__orig_id(const=
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
@@ -3191,6 +3212,7 @@ static int die__process(Dwarf_Die *die, struct cu *=
cu, struct conf_load *conf)
 	}
=20
 	cu->language =3D attr_numeric(die, DW_AT_language);
+	cu->producer_clang =3D attr_producer_clang(die);
=20
 	if (conf->early_cu_filter)
 		cu =3D conf->early_cu_filter(cu);
@@ -3409,6 +3431,7 @@ static int cu__set_common(struct cu *cu, struct con=
f_load *conf,
=20
 	cu->little_endian =3D ehdr.e_ident[EI_DATA] =3D=3D ELFDATA2LSB;
 	cu->nr_register_params =3D arch__nr_register_params(&ehdr);
+	cu->agg_use_two_regs =3D arch__agg_use_two_regs(&ehdr);
 	arch__set_register_params(&ehdr, cu);
 	return 0;
 }
@@ -3950,6 +3973,7 @@ static int cus__merge_and_process_cu(struct cus *cu=
s, struct conf_load *conf,
 			cu->priv =3D dcu;
 			cu->dfops =3D &dwarf__ops;
 			cu->language =3D attr_numeric(cu_die, DW_AT_language);
+			cu->producer_clang =3D attr_producer_clang(cu_die);
 			cus__add(cus, cu);
 		}
=20
diff --git a/dwarves.h b/dwarves.h
index 75c311a..c0d7f5c 100644
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
--=20
2.53.0-Meta

