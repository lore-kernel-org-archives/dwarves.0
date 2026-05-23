Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326FC31E839
	for <dwarves@vger.kernel.org>; Sat, 23 May 2026 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779555452; cv=none; b=XTA3aaa234zzQsbvq0rZ/iMRFv63I2oJxG0Y2dKUd+wA0LtvVPl6Bo/GNErNNBxZduaJDa8M1FE1q23VVGpZKY4BX83IPm1XlPTdJp5N0gR69e8fEGZAe2SGflsUGcmDmp6g1Q+GFdrageUN+su2F2yhdVtQnWa6KQjs4tuj2jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779555452; c=relaxed/simple;
	bh=ScTk/5IjiG1EUHRUDDLyfcFiu/ILuiXEz75UP9nRRRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLRyts2SpWvOfGjL4KDsdzn0h8dtpSzRKcALcZOVLIpHOD0X9oha2ekR4+7frz3AKgj+oNNVE6l1rNACfKTlJzY5WLSvujWVQL3jw1GJFQPyUPS1Aj7klhRvV/6msls592MQ49Zd7984Mzp8nAjRFKvMKX1i1MP3wq6gkFdbRRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id EC2FFEE8FB905; Sat, 23 May 2026 09:57:17 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v5 01/11] dwarf_loader: Reduce parameter checking with clang DW_AT_calling_convention attr
Date: Sat, 23 May 2026 09:57:17 -0700
Message-ID: <20260523165717.1225535-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260523165712.1225231-1-yonghong.song@linux.dev>
References: <20260523165712.1225231-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently every function is checked for its parameters to identify whethe=
r
the signature changed or not. If signature indeed changed, pahole may do
some adjustment for parameters for true signatures.

In clang, any function with the following attribute
      DW_AT_calling_convention        (DW_CC_nocall)
indicates this function having signature changed.
pahole can take advantage of this to avoid parameter checking if
DW_AT_calling_convention is not DW_CC_nocall.

But more importantly, DW_CC_nocall can identify signature-changed functio=
ns
and parameters can be checked one-after-another to create the true
signatures. Otherwise, it takes more effort to identify whether a
function has signature changed or not. For example, for funciton
  __bpf_kfunc static void bbr_main(struct sock *sk, u32 ack, int flag,
     const struct rate_sample *rs) { ... }
and bbr_main() is a callback function in
  .cong_control   =3D bbr_main
in 'struct tcp_congestion_ops tcp_bbr_cong_ops'.
In the above bbr_main(...), parameter 'ack' and 'flag' are not used.
The following are some details:

0x0a713b8d:     DW_TAG_formal_parameter
                  DW_AT_location        (indexed (0x28) loclist =3D 0x016=
6d452:
                     [0xffffffff83e77fd9, 0xffffffff83e78016): DW_OP_reg5=
 RDI
                     ...
                  DW_AT_name    ("sk")
                  DW_AT_type    (0x0a6f5b2b "sock *")
                  ...

0x0a713b98:     DW_TAG_formal_parameter
                  DW_AT_name    ("ack")
                  DW_AT_type    (0x0a6f58fd "u32")
                  ...

0x0a713ba2:     DW_TAG_formal_parameter
                  DW_AT_name    ("flag")
                  DW_AT_type    (0x0a6f57d1 "int")
                  ...

0x0a713bac:     DW_TAG_formal_parameter
                  DW_AT_location        (indexed (0x29) loclist =3D 0x016=
6d4a8:
                     [0xffffffff83e77fd9, 0xffffffff83e78016): DW_OP_reg2=
 RCX
                     ...
                  DW_AT_name    ("rs")
                  DW_AT_type    (0x0a710da5 "const rate_sample *")

Some analysis for the above dwarf can conclude that the 'ark' and 'flag'
may be related to RSI and RDX, considering the last one is RCX. Basically=
 this
requires all parameters are available to collectively decide whether the
true signature can be found or not. In such case, DW_CC_nocall can make t=
hings
easier as parameter can be checked one after another.

For a clang built bpf-next kernel with x86_64, in non-LTO setup,
the number of kernel functions is 69103 and the number of signature chang=
ed
functions is 875, based on
      DW_AT_calling_convention        (DW_CC_nocall)
indication.

Among 875 signature changed functions, after this patch, 343 functions
can have proper true signatures, mostly due to simple dead argument
elimination. The number of remaining functions, which cannot get the
true signature, is 532 due to dead or additional-checked parameters.

They will be addressed in the subsequent commits.

In llvm23, I implemented [1] which added DW_CC_nocall for ArgumentPromoti=
on pass.
This compiler pass can add additional DW_CC_nocall cases for the followin=
g
compilation:
      - Flag -O3 or FullLTO
So once llvm23 available, we may have more DW_CC_nocall cases, hence more
potential true signatures if the kernel is built with -O3 or
with FullLTO (CONFIG_LTO_CLANG_FULL).

  [1] https://github.com/llvm/llvm-project/pull/178973

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 86 ++++++++++++++++++++++++++++++++++++++++++--------
 dwarves.h      |  1 +
 2 files changed, 73 insertions(+), 14 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 16fb7be..0bc4fc4 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1190,6 +1190,10 @@ static ptrdiff_t __dwarf_getlocations(Dwarf_Attrib=
ute *attr,
 	return ret;
 }
=20
+struct func_info {
+	bool signature_changed;
+};
+
 /* For DW_AT_location 'attr':
  * - if first location is DW_OP_regXX with expected number, return the r=
egister;
  *   otherwise save the register for later return
@@ -1252,7 +1256,8 @@ out:
 }
=20
 static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
-					struct conf_load *conf, int param_idx)
+					struct conf_load *conf, int param_idx,
+					struct func_info *info)
 {
 	struct parameter *parm =3D tag__alloc(cu, sizeof(*parm));
=20
@@ -1263,8 +1268,15 @@ static struct parameter *parameter__new(Dwarf_Die =
*die, struct cu *cu,
 		tag__init(&parm->tag, cu, die);
 		parm->name =3D attr_string(die, DW_AT_name, conf);
 		parm->idx =3D param_idx;
-		if (param_idx >=3D cu->nr_register_params || param_idx < 0)
+		if (param_idx < 0)
 			return parm;
+		if (!info->signature_changed) {
+			if (cu->producer_clang || param_idx >=3D cu->nr_register_params)
+				return parm;
+		} else if (param_idx >=3D cu->nr_register_params) {
+			return parm;
+		}
+
 		/* Parameters which use DW_AT_abstract_origin to point at
 		 * the original parameter definition (with no name in the DIE)
 		 * are the result of later DWARF generation during compilation
@@ -1337,7 +1349,7 @@ static int formal_parameter_pack__load_params(struc=
t formal_parameter_pack *pack
 			continue;
 		}
=20
-		struct parameter *param =3D parameter__new(die, cu, conf, -1);
+		struct parameter *param =3D parameter__new(die, cu, conf, -1, NULL);
=20
 		if (param =3D=3D NULL)
 			return -1;
@@ -1502,6 +1514,29 @@ static struct ftype *ftype__new(Dwarf_Die *die, st=
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
@@ -1800,9 +1835,9 @@ static struct tag *die__create_new_parameter(Dwarf_=
Die *die,
 					     struct ftype *ftype,
 					     struct lexblock *lexblock,
 					     struct cu *cu, struct conf_load *conf,
-					     int param_idx)
+					     int param_idx, struct func_info *info)
 {
-	struct parameter *parm =3D parameter__new(die, cu, conf, param_idx);
+	struct parameter *parm =3D parameter__new(die, cu, conf, param_idx, inf=
o);
=20
 	if (parm =3D=3D NULL)
 		return NULL;
@@ -1889,7 +1924,7 @@ static struct tag *die__create_new_subroutine_type(=
Dwarf_Die *die,
 			tag__print_not_supported(die);
 			continue;
 		case DW_TAG_formal_parameter:
-			tag =3D die__create_new_parameter(die, ftype, NULL, cu, conf, -1);
+			tag =3D die__create_new_parameter(die, ftype, NULL, cu, conf, -1, NUL=
L);
 			break;
 		case DW_TAG_unspecified_parameters:
 			ftype->unspec_parms =3D 1;
@@ -2118,7 +2153,8 @@ out_enomem:
 }
=20
 static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
-				  struct lexblock *lexblock, struct cu *cu, struct conf_load *conf);
+				 struct lexblock *lexblock, struct cu *cu, struct conf_load *conf,
+				 struct func_info *info);
=20
 static int die__create_new_lexblock(Dwarf_Die *die,
 				    struct cu *cu, struct lexblock *father, struct conf_load *conf)
@@ -2126,7 +2162,7 @@ static int die__create_new_lexblock(Dwarf_Die *die,
 	struct lexblock *lexblock =3D lexblock__new(die, cu);
=20
 	if (lexblock !=3D NULL) {
-		if (die__process_function(die, NULL, lexblock, cu, conf) !=3D 0)
+		if (die__process_function(die, NULL, lexblock, cu, conf, NULL) !=3D 0)
 			goto out_delete;
 	}
 	if (father !=3D NULL)
@@ -2246,7 +2282,8 @@ static struct tag *die__create_new_inline_expansion=
(Dwarf_Die *die,
 }
=20
 static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
-				 struct lexblock *lexblock, struct cu *cu, struct conf_load *conf)
+				 struct lexblock *lexblock, struct cu *cu, struct conf_load *conf,
+				 struct func_info *info)
 {
 	int param_idx =3D 0;
 	Dwarf_Die child;
@@ -2320,7 +2357,7 @@ static int die__process_function(Dwarf_Die *die, st=
ruct ftype *ftype,
 			continue;
 		}
 		case DW_TAG_formal_parameter:
-			tag =3D die__create_new_parameter(die, ftype, lexblock, cu, conf, par=
am_idx++);
+			tag =3D die__create_new_parameter(die, ftype, lexblock, cu, conf, par=
am_idx++, info);
 			break;
 		case DW_TAG_variable:
 			tag =3D die__create_new_variable(die, cu, conf, 0);
@@ -2391,11 +2428,19 @@ out_enomem:
 static struct tag *die__create_new_function(Dwarf_Die *die, struct cu *c=
u, struct conf_load *conf)
 {
 	struct function *function =3D function__new(die, cu, conf);
+	struct func_info info =3D {};
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
+			info.signature_changed =3D function__signature_changed(function, die)=
;
+
+		if (die__process_function(die, &function->proto, &function->lexblock, =
cu, conf, &info) !=3D 0) {
+			function__delete(function, cu);
+			function =3D NULL;
+		}
 	}
=20
 	return function ? &function->proto.tag : NULL;
@@ -3045,6 +3090,17 @@ static unsigned long long dwarf_tag__orig_id(const=
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
@@ -3082,6 +3138,7 @@ static int die__process(Dwarf_Die *die, struct cu *=
cu, struct conf_load *conf)
 	}
=20
 	cu->language =3D attr_numeric(die, DW_AT_language);
+	cu->producer_clang =3D attr_producer_clang(die);
=20
 	if (conf->early_cu_filter)
 		cu =3D conf->early_cu_filter(cu);
@@ -3841,6 +3898,7 @@ static int cus__merge_and_process_cu(struct cus *cu=
s, struct conf_load *conf,
 			cu->priv =3D dcu;
 			cu->dfops =3D &dwarf__ops;
 			cu->language =3D attr_numeric(cu_die, DW_AT_language);
+			cu->producer_clang =3D attr_producer_clang(cu_die);
 			cus__add(cus, cu);
 		}
=20
diff --git a/dwarves.h b/dwarves.h
index 5ec16e7..b49e651 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -306,6 +306,7 @@ struct cu {
 	uint8_t		 has_addr_info:1;
 	uint8_t		 uses_global_strings:1;
 	uint8_t		 little_endian:1;
+	uint8_t		 producer_clang:1;
 	uint8_t		 nr_register_params;
 	int		 register_params[ARCH_MAX_REGISTER_PARAMS];
 	int		 functions_saved;
--=20
2.53.0-Meta

