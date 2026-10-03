Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B72D386541
	for <dwarves@vger.kernel.org>; Sat,  3 Oct 2026 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791017052; cv=none; b=q02h6AfmWBKOX++JkiEJV3v6UWJHcS8c3Hwik/k+v1F+7YEp+KwILdY2c6pz8JFZ+ZL17fNS7LjdSzo6q5b5oH3ATUyns+FtYh5mYT5HODi/7sa1NhJMnyyGscxUsGIKzECrOHFZxcifTu4/3KDHl3L9HBH5e4cWDXbTN8IZMJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791017052; c=relaxed/simple;
	bh=oy1m2vLEeuSOOyf5jN4vP9s1FO1NeBajNBefb1uRm+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WWK4AIiIqOXIMUFiCVxr2uYxP0vWi558OEopYYss5WOS/lHpq1kRk0Y3kvExSsULDxWW523gt7u6Um2tO4hPdCPSn6VFGDQCiWJHm2yJlJzGY2/1/sD/5xH07Z+tVq4iegGJz+4MI2Nj4S0hjP7zQhAG0bksL0/MUrY7tmatbdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 7659E2ECE4A62E; Sat,  3 Oct 2026 01:43:57 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH dwarves] dwarf_loader: Limit parameter location analysis to x86_64 and arm64
Date: Sat,  3 Oct 2026 01:43:57 -0700
Message-ID: <20261003084357.4185491-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since commit e96290426e18 ("dwarf_loader: Analyze per-parameter
information for true signatures"), clang-built kernels on arm, powerpc
and riscv lose most of their functions from BTF, and resolve_btfids
emits thousands of warnings like:

  WARN: resolve_btfids: no BTF func for kfunc bpf_xdp_get_xfrm_state in x=
frm_state_kfunc_set
  WARN: resolve_btfids: unresolved symbol bpf_xdp_get_xfrm_state

For clang functions whose signature did not change, the new
function__match_clang_parameter_locations() checks that each parameter
lives in its expected ABI argument register. arch__nr_register_params()
returns a non-zero count for powerpc, riscv, mips, arc and sparc, but
arch__set_register_params() only fills in the register map for s390,
x86_64, arm and arm64, leaving the other entries at -1. Every parameter
held in a register then fails the match, the function is marked
unexpected_reg and is skipped. The previous per-parameter check in
parameter__new() ignored unknown expected registers, so this is a
regression. 32-bit arm has a register map, but it does not match
AAPCS32 (only r0-r3 carry arguments, and 64-bit arguments need an
even/odd register pair).

The parameter location matching and true signature reconstruction have
only been validated on x86_64 and arm64. Add cu->param_loc_supported and
set it only for those two architectures. On other architectures, skip
the clang register matching and do not do true signature analysis in
the DWARF loader or the BTF encoder, keeping the basic optimized-out
parameter detection that existed before.

With a riscv64 or powerpc64le object built by clang 22, functions such
as int f(int a, int b) are now encoded again instead of being skipped
with "unexpected register usage for parameter". x86_64 and arm64 output
is unchanged, with and without true_signature.

Fixes: e96290426e180703 ("dwarf_loader: Analyze per-parameter information=
 for true signatures")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org> # build
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 btf_encoder.c  |  2 +-
 dwarf_loader.c | 23 +++++++++++++++++++++--
 dwarves.h      |  1 +
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index d6b9be6..2f137ee 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2913,7 +2913,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu,=
 const char *detached_filenam
 		encoder->tag_kfuncs	 =3D conf_load->btf_decl_tag_kfuncs;
 		encoder->gen_distilled_base =3D conf_load->btf_gen_distilled_base;
 		encoder->encode_attributes =3D conf_load->btf_attributes;
-		encoder->true_signature =3D conf_load->true_signature;
+		encoder->true_signature =3D conf_load->true_signature && cu->param_loc=
_supported;
 		encoder->verbose	 =3D verbose;
 		encoder->has_index_type  =3D false;
 		encoder->need_index_type =3D false;
diff --git a/dwarf_loader.c b/dwarf_loader.c
index 1e5363a..9f9b9c9 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1518,6 +1518,22 @@ static bool arch__arg_align_two_regs(const GElf_Eh=
dr *ehdr)
 	}
 }
=20
+/*
+ * Architectures whose argument register mapping has been validated for
+ * matching clang parameter locations and reconstructing true signatures=
.
+ * Other architectures keep only the basic optimized-out detection.
+ */
+static bool arch__param_loc_supported(const GElf_Ehdr *ehdr)
+{
+	switch (ehdr->e_machine) {
+	case EM_X86_64:
+	case EM_AARCH64:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static struct template_type_param *template_type_param__new(Dwarf_Die *d=
ie, struct cu *cu, struct conf_load *conf)
 {
 	struct template_type_param *ttparm =3D tag__alloc(cu, sizeof(*ttparm));
@@ -3777,7 +3793,8 @@ static void function__analyze_parameter_locations(s=
truct function *fn, struct cu
 {
 	struct ftype *ftype =3D &fn->proto;
 	struct parameter *pos;
-	bool true_sig_enabled =3D conf->true_signature && ftype->signature_chan=
ged;
+	bool true_sig_enabled =3D cu->param_loc_supported && conf->true_signatu=
re &&
+				ftype->signature_changed;
 	bool check_locations =3D !cu->producer_clang || ftype->signature_change=
d;
 	int reg_idx =3D 0;
=20
@@ -3785,7 +3802,8 @@ static void function__analyze_parameter_locations(s=
truct function *fn, struct cu
 		/* Producer is clang and the signature was not changed: match
 		 * each parameter against its expected ABI argument register.
 		 */
-		function__match_clang_parameter_locations(ftype, cu);
+		if (cu->param_loc_supported)
+			function__match_clang_parameter_locations(ftype, cu);
 		return;
 	}
=20
@@ -4533,6 +4551,7 @@ static int cu__set_common(struct cu *cu, struct con=
f_load *conf,
 	cu->nr_register_params =3D arch__nr_register_params(&ehdr);
 	cu->agg_use_two_regs =3D arch__agg_use_two_regs(&ehdr);
 	cu->arg_align_two_regs =3D arch__arg_align_two_regs(&ehdr);
+	cu->param_loc_supported =3D arch__param_loc_supported(&ehdr);
 	arch__set_register_params(&ehdr, cu);
 	return 0;
 }
diff --git a/dwarves.h b/dwarves.h
index f3453ed..6b75ece 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -305,6 +305,7 @@ struct cu {
 	uint8_t		 producer_clang:1;
 	uint8_t		 agg_use_two_regs:1;	/* An aggregate like {long a; long b;} */
 	uint8_t		 arg_align_two_regs:1;	/* An over-aligned arg starts on an eve=
n register */
+	uint8_t		 param_loc_supported:1;	/* Parameter location analysis is vali=
dated for this arch */
 	uint8_t		 nr_register_params;
 	int		 register_params[ARCH_MAX_REGISTER_PARAMS];
 	int		 functions_saved;
--=20
2.53.0-Meta

