Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18BC3C197D
	for <dwarves@vger.kernel.org>; Mon,  9 Mar 2026 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070354; cv=none; b=FsKwlmEh1Gyw3Lgn8i+gqd0BhsZ0PN2HYHY+//vf/h+ylRSpcsiI05luXanSbdYZ4Dpf14Ghwr0utNEx4qf9fuZwDWBkQdXUTGfLis75QD1AcwprtYuZGU2t/7oQYXxrSsJr6u+OYl9E0JNkVZcOWYuRzZ+145yOoP1Yb1oABiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070354; c=relaxed/simple;
	bh=CVXfiivsjsstRz7yXGvqnTsQiXZ+I1WkdrhQL32gpF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkDoT3uCTEpmqcq13wQ9F+Ef8NZ8Xe00dqLHPlg59VGv28filgHm+RXLSBzJYBwzvgoeM3MYQ86rU6pUcE6GXzjaJKol5b7O+M5R7cKTCCh+GFd6k7Qi/cwCfunNZnsk3zQYiuG0c3UX7wTrQA+j9FYlEqk9gVZmPkqp5GZ83LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id B9AE5249442C3; Mon,  9 Mar 2026 08:32:20 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v2 1/9] dwarf_loader: Reduce parameter checking with clang DW_AT_calling_convention attr
Date: Mon,  9 Mar 2026 08:32:20 -0700
Message-ID: <20260309153220.1917194-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260309153215.1917033-1-yonghong.song@linux.dev>
References: <20260309153215.1917033-1-yonghong.song@linux.dev>
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
                  DW_AT_decl_line       (1027)

Some analysis for the above dwarf can conclude that the 'ark' and 'flag'
may be related to RSI and RDX, considering the last one is RCX. Basically=
 this
requires all parameters are available to collectively decide whether the
true signature can be found or not. In such case, DW_CC_nocall can make t=
hings
easier as parameter can be checked one after another.

For a clang built bpf-next kernel, in non-LTO setup, the number of kernel=
 functions
is 69103 and the number of signature changed functions is 875, based on
      DW_AT_calling_convention        (DW_CC_nocall)
indication.

Among 875 signature changed functions, after this patch, 495 functions
can have proper true signatures, mostly due to simple dead argument
elimination. The number of remaining functions, which cannot get the
true signature, is 379. They will be addressed in the subsequent commits.

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
 dwarf_loader.c | 71 +++++++++++++++++++++++++++++++++++++++++++-------
 dwarves.h      |  2 ++
 2 files changed, 63 insertions(+), 10 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 16fb7be..610b69e 100644
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
@@ -1265,6 +1270,8 @@ static struct parameter *parameter__new(Dwarf_Die *=
die, struct cu *cu,
 		parm->idx =3D param_idx;
 		if (param_idx >=3D cu->nr_register_params || param_idx < 0)
 			return parm;
+		if (cu->producer_clang && !info->signature_changed)
+			return parm;
 		/* Parameters which use DW_AT_abstract_origin to point at
 		 * the original parameter definition (with no name in the DIE)
 		 * are the result of later DWARF generation during compilation
@@ -1337,7 +1344,7 @@ static int formal_parameter_pack__load_params(struc=
t formal_parameter_pack *pack
 			continue;
 		}
=20
-		struct parameter *param =3D parameter__new(die, cu, conf, -1);
+		struct parameter *param =3D parameter__new(die, cu, conf, -1, NULL);
=20
 		if (param =3D=3D NULL)
 			return -1;
@@ -1502,6 +1509,29 @@ static struct ftype *ftype__new(Dwarf_Die *die, st=
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
@@ -1527,6 +1557,7 @@ static struct function *function__new(Dwarf_Die *di=
e, struct cu *cu, struct conf
 		func->cu_total_size_inline_expansions =3D 0;
 		func->cu_total_nr_inline_expansions =3D 0;
 		func->priv =3D NULL;
+		func->signature_changed =3D function__signature_changed(func, die);
 	}
=20
 	return func;
@@ -1800,9 +1831,9 @@ static struct tag *die__create_new_parameter(Dwarf_=
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
@@ -1889,7 +1920,7 @@ static struct tag *die__create_new_subroutine_type(=
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
@@ -2118,7 +2149,8 @@ out_enomem:
 }
=20
 static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
-				  struct lexblock *lexblock, struct cu *cu, struct conf_load *conf);
+				 struct lexblock *lexblock, struct cu *cu, struct conf_load *conf,
+				 struct func_info *info);
=20
 static int die__create_new_lexblock(Dwarf_Die *die,
 				    struct cu *cu, struct lexblock *father, struct conf_load *conf)
@@ -2126,7 +2158,7 @@ static int die__create_new_lexblock(Dwarf_Die *die,
 	struct lexblock *lexblock =3D lexblock__new(die, cu);
=20
 	if (lexblock !=3D NULL) {
-		if (die__process_function(die, NULL, lexblock, cu, conf) !=3D 0)
+		if (die__process_function(die, NULL, lexblock, cu, conf, NULL) !=3D 0)
 			goto out_delete;
 	}
 	if (father !=3D NULL)
@@ -2246,7 +2278,8 @@ static struct tag *die__create_new_inline_expansion=
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
@@ -2320,7 +2353,7 @@ static int die__process_function(Dwarf_Die *die, st=
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
@@ -2391,9 +2424,10 @@ out_enomem:
 static struct tag *die__create_new_function(Dwarf_Die *die, struct cu *c=
u, struct conf_load *conf)
 {
 	struct function *function =3D function__new(die, cu, conf);
+	struct func_info info =3D { function->signature_changed };
=20
 	if (function !=3D NULL &&
-	    die__process_function(die, &function->proto, &function->lexblock, c=
u, conf) !=3D 0) {
+	    die__process_function(die, &function->proto, &function->lexblock, c=
u, conf, &info) !=3D 0) {
 		function__delete(function, cu);
 		function =3D NULL;
 	}
@@ -3045,6 +3079,21 @@ static unsigned long long dwarf_tag__orig_id(const=
 struct tag *tag,
 	return cu->extra_dbg_info ? dtag->id : 0;
 }
=20
+static bool attr_producer_clang(Dwarf_Die *die)
+{
+	Dwarf_Attribute attr;
+	const char *producer;
+
+	if (dwarf_attr(die, DW_AT_producer, &attr) =3D=3D NULL)
+		return false;
+
+	producer =3D dwarf_formstring(&attr);
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
@@ -3082,6 +3131,7 @@ static int die__process(Dwarf_Die *die, struct cu *=
cu, struct conf_load *conf)
 	}
=20
 	cu->language =3D attr_numeric(die, DW_AT_language);
+	cu->producer_clang =3D attr_producer_clang(die);
=20
 	if (conf->early_cu_filter)
 		cu =3D conf->early_cu_filter(cu);
@@ -3841,6 +3891,7 @@ static int cus__merge_and_process_cu(struct cus *cu=
s, struct conf_load *conf,
 			cu->priv =3D dcu;
 			cu->dfops =3D &dwarf__ops;
 			cu->language =3D attr_numeric(cu_die, DW_AT_language);
+			cu->producer_clang =3D attr_producer_clang(cu_die);
 			cus__add(cus, cu);
 		}
=20
diff --git a/dwarves.h b/dwarves.h
index d7c6474..ad33828 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -302,6 +302,7 @@ struct cu {
 	uint8_t		 has_addr_info:1;
 	uint8_t		 uses_global_strings:1;
 	uint8_t		 little_endian:1;
+	uint8_t		 producer_clang:1;
 	uint8_t		 nr_register_params;
 	int		 register_params[ARCH_MAX_REGISTER_PARAMS];
 	int		 functions_saved;
@@ -1095,6 +1096,7 @@ struct function {
 	uint8_t		 virtuality:2; /* DW_VIRTUALITY_{none,virtual,pure_virtual} */
 	uint8_t		 declaration:1;
 	uint8_t		 btf:1;
+	uint8_t		 signature_changed:1;
 	int32_t		 vtable_entry;
 	struct list_head vtable_node;
 	struct list_head annots;
--=20
2.47.3

