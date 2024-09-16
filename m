Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83891553BB
	for <dwarves@vger.kernel.org>; Mon, 16 Sep 2024 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726494603; cv=none; b=FxK1rPod5i4XROc9Z0m4IixFBRENvMynhvql88aW4mSBpaju8thlHhB5hxis42/bU+JUxHTrAe1nilJ8ur3kne0rpDgkGAlhTNzX5VK3wMtdgxcE18n35ytV1uj84L1jMQosq1qvlUX3U7/3rKypH0Qiwb7wC0PrZDiAR1exuk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726494603; c=relaxed/simple;
	bh=vT7QwPOJQRMgHTrqslD7uXrGU6uIbMu6KXjwWozHRcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbmjCIDLi13bcu6/CbDYSYCGvfetysx24f1vj62bADZTqg51e4gRLb7c1swDKm4m9rDu9oAYdbpixSLISn9/Uyp/M/T62yClBFxtMD2SLLxSYdX1AIK/S+fgC2KieMQK8Lp86d7bKpFZIkUBnWGnBwJ7/g8Kb+jyTvfdzXr4B7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EFWeKqyn; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EFWeKqyn"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GCBxMh003213;
	Mon, 16 Sep 2024 13:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=X
	bspAVMUWMI81/kSlh9TeAgSpMj+W7mHz3goyhi7UXo=; b=EFWeKqyn61BNMmWSA
	6s7Wfb9QYoHaazwyjJv/xmFi5m8E3DUOw9U+6lYvSiBDqMMlCYRNO+3+7WgDuUgV
	lqeMsi4K2sd7HAEQCiERdjsZLxZ64zeruRJgG57Pa1NSo2YckEFN2pMrFBgrBIcC
	EVpqT3N5HSuzONT/9G+jjxOoeuCptE0FR5K3QzAWT6kwO2CJZ8NowSGqSTPZpJom
	Yh1nNFDsMF7I+Hsl94sc8An3MnMqD0Mpq61/Nd/ymyjYaR8W0Dr2L3R7SQPld8yo
	JhPILPbk5tm1AaMmVKiE0WmuX5Y8rhvdprg0da/e+ZZXB7RwQUmKgh8pj9Z1o89C
	jNqig==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3nfkbmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 13:49:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48GDcroY017777;
	Mon, 16 Sep 2024 13:49:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nycvcbgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 13:49:53 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48GDlw0q019465;
	Mon, 16 Sep 2024 13:49:53 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-208-154.vpn.oracle.com [10.175.208.154])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41nycvcbbr-2;
	Mon, 16 Sep 2024 13:49:52 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, eddyz87@gmail.com, olsajiri@gmail.com,
        shung-hsi.yu@suse.com, jirislaby@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 1/3] btf_encoder: record BTF-centric function state instead of DWARF-centric
Date: Mon, 16 Sep 2024 14:49:44 +0100
Message-ID: <20240916134946.3893204-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240916134946.3893204-1-alan.maguire@oracle.com>
References: <20240916134946.3893204-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_10,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409160088
X-Proofpoint-GUID: 1BldZdbdWLk4-CBx4phrpkyWL682TeIE
X-Proofpoint-ORIG-GUID: 1BldZdbdWLk4-CBx4phrpkyWL682TeIE

When recording function information for later comparison (as we
do when skipping inconsistent function descriptions), we utilize
DWARF-based representations because we do not want to jump the
gun and add BTF representations for functions that have inconsistent
representations across CUs (and across encoders in parallel mode).

So to handle this, we save info about functions, and we can then add
them later once we have ensured their various representations are
in fact consistent.  However to ensure that the function info
is still valid, we need to specify LSK__KEEPIT for CUs, which
bloats memory usage (in some cases to ~4Gb).  This is not a good
approach, mea culpa.

Instead, store a BTF-centric representation where we

- store the number of parameters
- store the BTF ids of return type and parameters
- store the name of the parameters where present
- store any LLVM annotation values, component idxs if present

So in summary, store everything we need to add the BTF_KIND_FUNC
and BTF_KIND_FUNC_PROTO and any associated annotations.  This will
allow us to free CUs as we go but make it possible to add functions
later.

For name storage we can take advantage of the fact that
BTF will avoid re-adding a name string so we btf__add_str()
to add the parameter name and store the string offset instead;
this prevents duplicate name storage while ensuring the parameter
name is in BTF.

When we cross-compare functions for consistency, do a shallow
analysis akin to what was done with DWARF prototype comparisons;
compare base types by name, reference types by target type,
match loosely between fwds, structs and unions etc.

When this is done, memory consumption peaks at 1Gb rather than
~4Gb for vmlinux generation.  Time taken appears to be approximately
the same for -j1, but slightly faster for multiple threads;
for example:

Baseline

$ time pahole -J vmlinux -j1 --btf_features=default

real	0m17.268s
user	0m15.808s
sys	0m1.415s

$ time pahole -J vmlinux -j8 --btf_features=default

real	0m10.768s
user	0m30.793s
sys	0m4.199s

With these changes:

$ time pahole -J vmlinux -j1 --btf_features=default

real	0m16.564s
user	0m16.029s
sys	0m0.492s

$ time pahole -J vmlinux -j8 --btf_features=default

real	0m8.332s
user	0m30.627s
sys	0m0.714s

In terms of functions encoded, 360 fewer functions make it into
BTF due to the different approach in consistency checking, but after
examining these cases, they do appear to be legitimately inconsistent
functions where the optimized versions have parameter mismatches
with the non-optimized expectations.

Mileage may vary of course, and any testing folks could do would
be greatly appreciated!

More future work would involve sharing the ELF representation
across encoders; this is the logical next step and judging by
single-threaded performance should get us down to ~500Mb peak memory
utilization; however it is better to approach this by taking
smaller steps (we would also need to think about handling synchronous
read/writes from multiple threads of function state).

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 543 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 401 insertions(+), 142 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 8a2d92e..d535b90 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -33,13 +33,18 @@
 #include <search.h> /* for tsearch(), tfind() and tdestroy() */
 #include <pthread.h>
 
-#define BTF_ENCODER_MAX_PROTO	512
 #define BTF_IDS_SECTION		".BTF_ids"
 #define BTF_ID_FUNC_PFX		"__BTF_ID__func__"
 #define BTF_ID_SET8_PFX		"__BTF_ID__set8__"
 #define BTF_SET8_KFUNCS		(1 << 0)
 #define BTF_KFUNC_TYPE_TAG	"bpf_kfunc"
 
+/*
+ * This corresponds to the same macro defined in
+ * include/linux/kallsyms.h
+ */
+#define KSYM_NAME_LEN 128
+
 /* Adapted from include/linux/btf_ids.h */
 struct btf_id_set8 {
         uint32_t cnt;
@@ -50,19 +55,37 @@ struct btf_id_set8 {
         } pairs[];
 };
 
+struct btf_encoder_func_parm {
+	int name_off;
+	uint32_t type_id;
+};
+
+struct btf_encoder_func_annot {
+	int value;
+	int16_t component_idx;
+};
+
 /* state used to do later encoding of saved functions */
-struct btf_encoder_state {
+struct btf_encoder_func_state {
 	uint32_t type_id_off;
-	bool got_proto;
-	char proto[BTF_ENCODER_MAX_PROTO];
+	uint16_t nr_parms;
+	uint16_t nr_annots;
+	uint8_t initialized:1;
+	uint8_t optimized_parms:1;
+	uint8_t unexpected_reg:1;
+	uint8_t inconsistent_proto:1;
+	uint8_t processed:1;
+	int ret_type_id;
+	struct btf_encoder_func_parm *parms;
+	struct btf_encoder_func_annot *annots;
 };
 
 struct elf_function {
 	const char	*name;
+	char		*alias;
 	bool		 generated;
 	size_t		prefixlen;
-	struct function	*function;
-	struct btf_encoder_state state;
+	struct btf_encoder_func_state state;
 };
 
 struct var_info {
@@ -125,7 +148,7 @@ struct btf_kfunc_set_range {
 static LIST_HEAD(encoders);
 static pthread_mutex_t encoders__lock = PTHREAD_MUTEX_INITIALIZER;
 
-static void btf_encoder__add_saved_funcs(struct btf_encoder *encoder);
+static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder);
 
 /* mutex only needed for add/delete, as this can happen in multiple encoding
  * threads.  Traversal of the list is currently confined to thread collection.
@@ -669,18 +692,25 @@ static int32_t btf_encoder__tag_type(struct btf_encoder *encoder, uint32_t tag_t
 	return encoder->type_id_off + tag_type;
 }
 
-static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct ftype *ftype)
+static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct ftype *ftype, struct elf_function *func)
 {
 	struct btf *btf = encoder->btf;
 	const struct btf_type *t;
 	struct parameter *param;
 	uint16_t nr_params, param_idx;
 	int32_t id, type_id;
+	char tmp_name[KSYM_NAME_LEN];
+	const char *name;
+	struct btf_encoder_func_state *state = &func->state;
 
 	/* add btf_type for func_proto */
-	nr_params = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
-	type_id = btf_encoder__tag_type(encoder, ftype->tag.type);
-
+	if (ftype) {
+		nr_params = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
+		type_id = btf_encoder__tag_type(encoder, ftype->tag.type);
+	} else {
+		nr_params = state->nr_parms;
+		type_id = state->ret_type_id;
+	}
 	id = btf__add_func_proto(btf, type_id);
 	if (id > 0) {
 		t = btf__type_by_id(btf, id);
@@ -694,20 +724,34 @@ static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct f
 
 	/* add parameters */
 	param_idx = 0;
-	ftype__for_each_parameter(ftype, param) {
-		const char *name = parameter__name(param);
+	if (ftype) {
+		ftype__for_each_parameter(ftype, param) {
+			const char *name = parameter__name(param);
+
+			type_id = param->tag.type == 0 ? 0 : encoder->type_id_off + param->tag.type;
+			++param_idx;
+			if (btf_encoder__add_func_param(encoder, name, type_id, param_idx == nr_params))
+				return -1;
+		}
 
-		type_id = param->tag.type == 0 ? 0 : encoder->type_id_off + param->tag.type;
 		++param_idx;
-		if (btf_encoder__add_func_param(encoder, name, type_id, param_idx == nr_params))
-			return -1;
-	}
+		if (ftype->unspec_parms)
+			if (btf_encoder__add_func_param(encoder, NULL, 0, param_idx == nr_params))
+				return -1;
+	} else {
+		for (param_idx = 0; param_idx < nr_params; param_idx++) {
+			struct btf_encoder_func_parm *p = &state->parms[param_idx];
+			name = btf__name_by_offset(btf, p->name_off);
 
-	++param_idx;
-	if (ftype->unspec_parms)
-		if (btf_encoder__add_func_param(encoder, NULL, 0, param_idx == nr_params))
-			return -1;
+			/* adding BTF data may result in a move of the
+			 * name string memory, so make a temporary copy.
+			 */
+			strncpy(tmp_name, name, sizeof(tmp_name));
 
+			if (btf_encoder__add_func_param(encoder, tmp_name, p->type_id, param_idx == nr_params))
+				return -1;
+		}
+	}
 	return id;
 }
 
@@ -831,53 +875,170 @@ static int32_t btf_encoder__add_decl_tag(struct btf_encoder *encoder, const char
 	return id;
 }
 
-static bool proto__get(struct function *func, char *proto, size_t len)
+static void btf_encoder__log_func_skip(struct btf_encoder *encoder, struct elf_function *func,
+				       const char *fmt, ...)
 {
-	const struct conf_fprintf conf = {
-						.name_spacing = 23,
-						.type_spacing = 26,
-						.emit_stats = 0,
-						.no_parm_names = 1,
-						.skip_emitting_errors = 1,
-						.skip_emitting_modifier = 1,
-					};
+	va_list ap;
 
-	return function__prototype_conf(func, func->priv, &conf, proto, len) != NULL;
+	if (!encoder->verbose)
+		return;
+	printf("%s (%s): skipping BTF encoding of function due to ",
+	       func->alias ?: func->name, func->name);
+	va_start(ap, fmt);
+	vprintf(fmt, ap);
+	va_end(ap);
 }
 
-static bool funcs__match(struct btf_encoder *encoder, struct elf_function *func, struct function *f2)
+static bool names__match(struct btf *btf1, const struct btf_type *t1,
+			struct btf *btf2, const struct btf_type *t2)
 {
-	char proto[BTF_ENCODER_MAX_PROTO];
-	struct function *f1 = func->function;
-	const char *name;
+	const char *str1;
+	const char *str2;
 
-	if (!f1)
-		return false;
+	if ((btf1 == btf2) && (t1->name_off == t2->name_off))
+		return true;
 
-	name = function__name(f1);
+	str1 = btf__name_by_offset(btf1, t1->name_off);
+	str2 = btf__name_by_offset(btf2, t2->name_off);
 
-	if (f1->proto.nr_parms != f2->proto.nr_parms) {
-		if (encoder->verbose)
-			printf("function mismatch for '%s'(%s): %d params != %d params\n",
-			       name, f1->alias ?: name,
-			       f1->proto.nr_parms, f2->proto.nr_parms);
-		return false;
-	}
-	if (f1->proto.nr_parms == 0)
-		return true;
+	return strcmp(str1, str2) == 0;
+}
+
+static int fwd__kind(const struct btf_type *t)
+{
+	if (btf_kind(t) == BTF_KIND_FWD)
+		return btf_kflag(t) ? BTF_KIND_UNION : BTF_KIND_STRUCT;
+	return btf_kind(t);
+}
+
+static bool types__match(struct btf_encoder *encoder,
+			 struct btf *btf1, int type_id1,
+			 struct btf *btf2, int type_id2)
+{
+	uint32_t id1 = type_id1;
+	uint32_t id2 = type_id2;
+
+	do {
+		const struct btf_type *t1;
+		const struct btf_type *t2;
+		int k1;
+		int k2;
+
+		if ((btf1 == btf2) && (id1 == id2))
+			return true;
+		if (!id1 || !id2)
+			return id1 == id2;
+
+		t1 = btf__type_by_id(btf1, id1);
+		t2 = btf__type_by_id(btf2, id2);
+
+		k1 = fwd__kind(t1);
+		k2 = fwd__kind(t2);
 
-	if (f1->proto.tag.type == f2->proto.tag.type)
+		if (k1 != k2) {
+			/* loose matching allows us to match const/non-const
+			 * parameters.
+			 */
+			if (k1 == BTF_KIND_CONST) {
+				id1 = t1->type;
+				continue;
+			}
+			if (k2 == BTF_KIND_CONST) {
+				id2 = t2->type;
+				continue;
+			}
+			return false;
+		}
+
+		switch (btf_kind(t1)) {
+		case BTF_KIND_INT:
+		case BTF_KIND_FLOAT:
+		case BTF_KIND_FWD:
+		case BTF_KIND_TYPEDEF:
+		case BTF_KIND_STRUCT:
+		case BTF_KIND_UNION:
+		case BTF_KIND_ENUM:
+		case BTF_KIND_ENUM64:
+			return names__match(btf1, t1, btf2, t2);
+		case BTF_KIND_PTR:
+		case BTF_KIND_VOLATILE:
+		case BTF_KIND_CONST:
+		case BTF_KIND_RESTRICT:
+		case BTF_KIND_TYPE_TAG:
+			id1 = t1->type;
+			id2 = t2->type;
+			break;
+		case BTF_KIND_ARRAY: {
+			const struct btf_array *a1 = btf_array(t1);
+			const struct btf_array *a2 = btf_array(t2);
+
+			if (a1->nelems != a2->nelems)
+				return false;
+			id1 = a1->type;
+			id2 = a2->type;
+			break;
+		}
+		case BTF_KIND_FUNC_PROTO: {
+			const struct btf_param *p1 = btf_params(t1);
+			const struct btf_param *p2 = btf_params(t2);
+			int i, vlen = btf_vlen(t1);
+
+			if (vlen != btf_vlen(t2))
+				return false;
+			if (!types__match(encoder, btf1, t1->type,
+					  btf2, t2->type))
+				return false;
+			for (i = 0; i < vlen; i++, p1++, p2++) {
+				if (!types__match(encoder, btf1, t1->type,
+						  btf2, t2->type))
+					return false;
+			}
+			return true;
+		}
+		default:
+			return false;
+		}
+	} while (1);
+
+	return false;
+}
+
+static bool funcs__match(struct btf_encoder *encoder, struct elf_function *func,
+			 struct btf *btf1, struct btf_encoder_func_state *s1,
+			 struct btf *btf2, struct btf_encoder_func_state *s2)
+{
+	uint8_t i;
+
+	if (!s1->initialized || !s2->initialized)
 		return true;
 
-	if (!func->state.got_proto)
-		func->state.got_proto = proto__get(f1, func->state.proto, sizeof(func->state.proto));
+	if (s1->nr_parms != s2->nr_parms) {
+		btf_encoder__log_func_skip(encoder, func,
+					   "param count mismatch; %d params != %d params\n",
+					   s1->nr_parms, s2->nr_parms);
+		return false;
+	}
+	if (!types__match(encoder, btf1, s1->ret_type_id, btf2, s2->ret_type_id)) {
+		btf_encoder__log_func_skip(encoder, func, "return type mismatch\n");
+		return false;
+	}
+	if (s1->nr_parms == 0)
+		return true;
 
-	if (proto__get(f2, proto, sizeof(proto))) {
-		if (strcmp(func->state.proto, proto) != 0) {
-			if (encoder->verbose)
-				printf("function mismatch for '%s'('%s'): '%s' != '%s'\n",
-				       name, f1->alias ?: name,
-				       func->state.proto, proto);
+	for (i = 0; i < s1->nr_parms; i++) {
+		if (!types__match(encoder, btf1, s1->parms[i].type_id,
+				  btf2, s2->parms[i].type_id)) {
+			if (encoder->verbose) {
+				const char *p1 = btf__name_by_offset(btf1, s1->parms[i].name_off);
+				const char *p2 = btf__name_by_offset(btf2, s2->parms[i].name_off);
+
+				btf_encoder__log_func_skip(encoder, func,
+							   "param type mismatch for param#%d %s %s %s\n",
+							   i + 1,
+							   p1 ?: "",
+							   p1 && p2 ? "!=" : "",
+							   p2 ?: "");
+			}
 			return false;
 		}
 	}
@@ -886,119 +1047,212 @@ static bool funcs__match(struct btf_encoder *encoder, struct elf_function *func,
 
 static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn, struct elf_function *func)
 {
-	fn->priv = encoder->cu;
-	if (func->function) {
-		struct function *existing = func->function;
-
-		/* If saving and we find an existing entry, we want to merge
-		 * observations across both functions, checking that the
-		 * "seen optimized parameters", "inconsistent prototype"
-		 * and "unexpected register" status is reflected in the
-		 * the func entry.
-		 * If the entry is new, record encoder state required
-		 * to add the local function later (encoder + type_id_off)
-		 * such that we can add the function later.
-		 */
-		existing->proto.optimized_parms |= fn->proto.optimized_parms;
-		existing->proto.unexpected_reg |= fn->proto.unexpected_reg;
-		if (!existing->proto.unexpected_reg && !existing->proto.inconsistent_proto &&
-		     !funcs__match(encoder, func, fn))
-			existing->proto.inconsistent_proto = 1;
-	} else {
-		func->state.type_id_off = encoder->type_id_off;
-		func->function = fn;
-		encoder->cu->functions_saved++;
+	struct btf_encoder_func_state *existing = &func->state;
+	struct btf_encoder_func_state state = { 0 };
+	struct ftype *ftype = &fn->proto;
+	struct btf *btf = encoder->btf;
+	struct llvm_annotation *annot;
+	struct parameter *param;
+	uint8_t param_idx = 0;
+	int str_off, err = 0;
+
+	/* if already skipping this function, no need to proceed. */
+	if (existing->unexpected_reg || existing->inconsistent_proto)
+		return 0;
+
+	state.nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
+	state.ret_type_id = ftype->tag.type == 0 ? 0 : encoder->type_id_off + ftype->tag.type;
+	if (state.nr_parms > 0) {
+		state.parms = zalloc(state.nr_parms * sizeof(*state.parms));
+		if (!state.parms) {
+			err = -ENOMEM;
+			goto out;
+		}
 	}
-	return 0;
+	state.inconsistent_proto = ftype->inconsistent_proto;
+	state.unexpected_reg = ftype->unexpected_reg;
+	state.optimized_parms = ftype->optimized_parms;
+	ftype__for_each_parameter(ftype, param) {
+		const char *name = parameter__name(param) ?: "";
+
+		str_off = btf__add_str(btf, name);
+		if (str_off < 0) {
+			err = str_off;
+			goto out;
+		}
+		state.parms[param_idx].name_off = str_off;
+		state.parms[param_idx].type_id = param->tag.type == 0 ? 0 : encoder->type_id_off + param->tag.type;
+		param_idx++;
+	}
+	if (ftype->unspec_parms)
+		state.parms[param_idx].type_id = 0;
+
+	list_for_each_entry(annot, &fn->annots, node)
+		state.nr_annots++;
+	if (state.nr_annots) {
+		uint8_t idx = 0;
+
+		state.annots = zalloc(state.nr_annots * sizeof(*state.annots));
+		if (!state.annots) {
+			err = -ENOMEM;
+			goto out;
+		}
+		list_for_each_entry(annot, &fn->annots, node) {
+			str_off = btf__add_str(encoder->btf, annot->value);
+			if (str_off < 0) {
+				err = str_off;
+				goto out;
+			}
+			state.annots[idx].value = str_off;
+			state.annots[idx].component_idx = annot->component_idx;
+			idx++;
+		}
+	}
+	state.initialized = 1;
+
+	if (state.unexpected_reg)
+		btf_encoder__log_func_skip(encoder, func,
+					   "unexpected register used for parameter\n");
+	if (!existing->initialized) {
+		memcpy(existing, &state, sizeof(*existing));
+		return 0;
+	}
+
+	/* If saving and we find an existing entry, we want to merge
+	 * observations across both functions, checking that the
+	 * "seen optimized parameters", "inconsistent prototype"
+	 * and "unexpected register" status is reflected in the
+	 * func entry.
+	 * If the entry is new, record encoder state required
+	 * to add the local function later (encoder + type_id_off)
+	 * such that we can add the function later.
+	 */
+	existing->optimized_parms |= state.optimized_parms;
+	existing->unexpected_reg |= state.unexpected_reg;
+	if (!existing->unexpected_reg &&
+	    !funcs__match(encoder, func, encoder->btf, &state,
+			   encoder->btf, existing))
+		existing->inconsistent_proto = 1;
+out:
+	zfree(&state.annots);
+	zfree(&state.parms);
+	return err;
 }
 
-static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct function *fn)
+static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct function *fn, struct elf_function *func)
 {
-	int btf_fnproto_id, btf_fn_id, tag_type_id;
-	struct llvm_annotation *annot;
+	int btf_fnproto_id, btf_fn_id, tag_type_id = 0;
+	int16_t component_idx = -1;
 	const char *name;
+	const char *value;
+	char tmp_value[KSYM_NAME_LEN];
 
-	btf_fnproto_id = btf_encoder__add_func_proto(encoder, &fn->proto);
-	name = function__name(fn);
-	btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id, name, false);
+	btf_fnproto_id = btf_encoder__add_func_proto(encoder, fn ? &fn->proto : NULL, func);
+	name = func->alias ?: func->name;
+	if (btf_fnproto_id >= 0)
+		btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id, name, false);
 	if (btf_fnproto_id < 0 || btf_fn_id < 0) {
-		printf("error: failed to encode function '%s'\n", function__name(fn));
+		printf("error: failed to encode function '%s': invalid %s\n", name, btf_fnproto_id < 0 ? "proto" : "func");
 		return -1;
 	}
-	list_for_each_entry(annot, &fn->annots, node) {
-		tag_type_id = btf_encoder__add_decl_tag(encoder, annot->value, btf_fn_id,
-							annot->component_idx);
-		if (tag_type_id < 0) {
-			fprintf(stderr, "error: failed to encode tag '%s' to func %s with component_idx %d\n",
-				annot->value, name, annot->component_idx);
-			return -1;
+	if (!fn) {
+		struct btf_encoder_func_state *state = &func->state;
+		uint16_t idx;
+
+		if (!state || state->nr_annots == 0)
+			return 0;
+
+		for (idx = 0; idx < state->nr_annots; idx++) {
+			struct btf_encoder_func_annot *a = &state->annots[idx];
+
+			value = btf__str_by_offset(encoder->btf, a->value);
+			/* adding BTF data may result in a mode of the
+			 * value string memory, so make a temporary copy.
+			 */
+			strncpy(tmp_value, value, sizeof(tmp_value));
+			component_idx = a->component_idx;
+
+			tag_type_id = btf_encoder__add_decl_tag(encoder, tmp_value, btf_fn_id, component_idx);
+			if (tag_type_id < 0)
+				break;
+		}
+	} else {
+		struct llvm_annotation *annot;
+
+		list_for_each_entry(annot, &fn->annots, node) {
+			value = annot->value;
+			component_idx = annot->component_idx;
+
+			tag_type_id = btf_encoder__add_decl_tag(encoder, value, btf_fn_id,
+								component_idx);
+			if (tag_type_id < 0)
+				break;
 		}
 	}
+	if (tag_type_id < 0) {
+		fprintf(stderr, "error: failed to encode tag '%s' to func %s with component_idx %d\n",
+			value, name, component_idx);
+		return -1;
+	}
+
 	return 0;
 }
 
-static void btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
+static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
 {
 	int i;
 
 	for (i = 0; i < encoder->functions.cnt; i++) {
 		struct elf_function *func = &encoder->functions.entries[i];
-		struct function *fn = func->function;
-		struct btf_encoder *other_encoder;
+		struct btf_encoder_func_state *state = &func->state;
+		struct btf_encoder *other_encoder = NULL;
 
-		if (!fn || fn->proto.processed)
+		if (!state || !state->initialized || state->processed)
 			continue;
-
 		/* merge optimized-out status across encoders; since each
 		 * encoder has the same elf symbol table we can use the
 		 * same index to access the same elf symbol.
 		 */
 		btf_encoders__for_each_encoder(other_encoder) {
-			struct function *other_fn;
+			struct elf_function *other_func;
+			struct btf_encoder_func_state *other_state;
+			uint8_t optimized, unexpected, inconsistent;
 
 			if (other_encoder == encoder)
 				continue;
 
-			other_fn = other_encoder->functions.entries[i].function;
-			if (!other_fn)
+			other_func = &other_encoder->functions.entries[i];
+			other_state = &other_func->state;
+			if (!other_state)
 				continue;
-			fn->proto.optimized_parms |= other_fn->proto.optimized_parms;
-			fn->proto.unexpected_reg |= other_fn->proto.unexpected_reg;
-			if (other_fn->proto.inconsistent_proto)
-				fn->proto.inconsistent_proto = 1;
-			if (!fn->proto.unexpected_reg && !fn->proto.inconsistent_proto &&
-			    !funcs__match(encoder, func, other_fn))
-				fn->proto.inconsistent_proto = 1;
-			other_fn->proto.processed = 1;
+			optimized = state->optimized_parms | other_state->optimized_parms;
+			unexpected = state->unexpected_reg | other_state->unexpected_reg;
+			inconsistent = state->inconsistent_proto | other_state->inconsistent_proto;
+			if (!unexpected && !inconsistent &&
+			    !funcs__match(encoder, func,
+					  encoder->btf, state,
+					  other_encoder->btf, other_state))
+				inconsistent = 1;
+			state->optimized_parms = other_state->optimized_parms = optimized;
+			state->unexpected_reg = other_state->unexpected_reg = unexpected;
+			state->inconsistent_proto = other_state->inconsistent_proto = inconsistent;
+
+			other_state->processed = 1;
 		}
 		/* do not exclude functions with optimized-out parameters; they
 		 * may still be _called_ with the right parameter values, they
 		 * just do not _use_ them.  Only exclude functions with
 		 * unexpected register use or multiple inconsistent prototypes.
 		 */
-		if (fn->proto.unexpected_reg || fn->proto.inconsistent_proto) {
-			if (encoder->verbose) {
-				const char *name = function__name(fn);
-
-				printf("skipping addition of '%s'(%s) due to %s\n",
-				       name, fn->alias ?: name,
-				       fn->proto.unexpected_reg ? "unexpected register used for parameter" :
-								   "multiple inconsistent function prototypes");
-			}
-		} else {
-			encoder->type_id_off = func->state.type_id_off;
-			btf_encoder__add_func(encoder, fn);
+		if (!state->unexpected_reg && !state->inconsistent_proto) {
+			if (btf_encoder__add_func(encoder, NULL, func))
+				return -1;
 		}
-		fn->proto.processed = 1;
+		state->processed = 1;
 	}
+	return 0;
 }
 
-/*
- * This corresponds to the same macro defined in
- * include/linux/kallsyms.h
- */
-#define KSYM_NAME_LEN 128
-
 static int functions_cmp(const void *_a, const void *_b)
 {
 	const struct elf_function *a = _a;
@@ -1051,6 +1305,8 @@ static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf_Sym *
 		encoder->functions.entries = new;
 	}
 
+	memset(&encoder->functions.entries[encoder->functions.cnt], 0,
+	       sizeof(*new));
 	encoder->functions.entries[encoder->functions.cnt].name = name;
 	if (strchr(name, '.')) {
 		const char *suffix = strchr(name, '.');
@@ -1058,11 +1314,6 @@ static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf_Sym *
 		encoder->functions.suffix_cnt++;
 		encoder->functions.entries[encoder->functions.cnt].prefixlen = suffix - name;
 	}
-	encoder->functions.entries[encoder->functions.cnt].generated = false;
-	encoder->functions.entries[encoder->functions.cnt].function = NULL;
-	encoder->functions.entries[encoder->functions.cnt].state.got_proto = false;
-	encoder->functions.entries[encoder->functions.cnt].state.proto[0] = '\0';
-	encoder->functions.entries[encoder->functions.cnt].state.type_id_off = 0;
 	encoder->functions.cnt++;
 	return 0;
 }
@@ -1236,7 +1487,7 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
 	case DW_TAG_enumeration_type:
 		return btf_encoder__add_enum_type(encoder, tag, conf_load);
 	case DW_TAG_subroutine_type:
-		return btf_encoder__add_func_proto(encoder, tag__ftype(tag));
+		return btf_encoder__add_func_proto(encoder, tag__ftype(tag), NULL);
         case DW_TAG_unspecified_type:
 		/* Just don't encode this for now, converting anything with this type to void (0) instead.
 		 *
@@ -2128,8 +2379,17 @@ out_delete:
 	return NULL;
 }
 
+void btf_encoder__delete_func(struct elf_function *func)
+{
+	free(func->alias);
+	zfree(&func->state.annots);
+	zfree(&func->state.parms);
+}
+
 void btf_encoder__delete(struct btf_encoder *encoder)
 {
+	int i;
+
 	if (encoder == NULL)
 		return;
 
@@ -2141,6 +2401,8 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 	encoder->btf = NULL;
 	elf_symtab__delete(encoder->symtab);
 
+	for (i = 0; i < encoder->functions.cnt; i++)
+		btf_encoder__delete_func(&encoder->functions.entries[i]);
 	encoder->functions.allocated = encoder->functions.cnt = 0;
 	free(encoder->functions.entries);
 	encoder->functions.entries = NULL;
@@ -2281,20 +2543,20 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 						       ", has optimized-out parameters" :
 						       fn->proto.unexpected_reg ? ", has unexpected register use by params" :
 						       "");
-					fn->alias = func->name;
+					func->alias = strdup(name);
 				}
 			}
-			if (!func)
-				continue;
 		} else {
 			if (!fn->external)
 				continue;
 		}
+		if (!func)
+			continue;
 
 		if (save)
 			err = btf_encoder__save_func(encoder, fn, func);
 		else
-			err = btf_encoder__add_func(encoder, fn);
+			err = btf_encoder__add_func(encoder, fn, func);
 		if (err)
 			goto out;
 	}
@@ -2302,11 +2564,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 	if (!encoder->skip_encoding_vars)
 		err = btf_encoder__encode_cu_variables(encoder);
 
-	/* It is only safe to delete this CU if we have not stashed any static
-	 * functions for later addition.
-	 */
 	if (!err)
-		err = encoder->cu->functions_saved > 0 ? LSK__KEEPIT : LSK__DELETE;
+		err = LSK__DELETE;
 out:
 	encoder->cu = NULL;
 	return err;
-- 
2.43.5

