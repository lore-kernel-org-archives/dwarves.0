Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA8B38CFFB
	for <dwarves@vger.kernel.org>; Thu, 26 Mar 2026 01:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774488749; cv=none; b=CUmEFrL3KrDKpNTwoizPK9R+3kBLfKjiPBvDiXiOxKkgPfHhTDA64JjMj6hSna8d3Mr45bcs3NKGOBBsc7bG3Y5zP2Cxrd1r4/rSRppqzcqQwv28jHEJ+N6iuqNe6M6McOAJ8iuGL1WJVaZCj/wZ4JyE0doYvTihoQX5nke5vUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774488749; c=relaxed/simple;
	bh=xxBCq/YnkvyXpPEMrKjc2XXQkVvZDUuPv2t5ap+Q1Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsKkdojAi6gSQ1Duu98izoClalSV7Cnxp5xKSJawHBj5R79FsXUlwfLrnNbxmzZKzcsD3xz/d4SpjdpHJEqB1kB2Yedgj8UEf9eVXPZoRLi8B8riu6jP7RPk9Tm68YhJ33UiJPzD1sEKkUDdHoFK/YjjZDlnClOt7ZZGWY0xvHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 78DA02E281020; Wed, 25 Mar 2026 18:32:25 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v4 08/11] dwarf_loader: Check whether two-reg parameter actually use two regs or not
Date: Wed, 25 Mar 2026 18:32:25 -0700
Message-ID: <20260326013225.2907570-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260326013144.2901265-1-yonghong.song@linux.dev>
References: <20260326013144.2901265-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For a parameter whose type occuplies two registers, for x86_64 and aarch6=
4,
the parameter will actually use two registers. S390 is different
as it allocates on stack and pass a pointer to the function.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 11 +++++++++++
 dwarves.h      |  1 +
 2 files changed, 12 insertions(+)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index ed2f384..d538e97 100644
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
@@ -3557,6 +3567,7 @@ static int cu__set_common(struct cu *cu, struct con=
f_load *conf,
=20
 	cu->little_endian =3D ehdr.e_ident[EI_DATA] =3D=3D ELFDATA2LSB;
 	cu->nr_register_params =3D arch__nr_register_params(&ehdr);
+	cu->agg_use_two_regs =3D arch__agg_use_two_regs(&ehdr);
 	arch__set_register_params(&ehdr, cu);
 	return 0;
 }
diff --git a/dwarves.h b/dwarves.h
index 4cabab0..164bd3b 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -303,6 +303,7 @@ struct cu {
 	uint8_t		 uses_global_strings:1;
 	uint8_t		 little_endian:1;
 	uint8_t		 producer_clang:1;
+	uint8_t		 agg_use_two_regs:1;	/* An aggregate like {long a; long b;} */
 	uint8_t		 nr_register_params;
 	int		 register_params[ARCH_MAX_REGISTER_PARAMS];
 	int		 functions_saved;
--=20
2.52.0

