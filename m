Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07204446EE;
	Fri, 25 Sep 2026 18:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362387; cv=none; b=cOKc3sl016sjeV5mVI8pK00LbH+0vYtwuKiEj44MH5fKCjC+ABhaXU3v/MihoP41jsJ13vohnNItOE3MrJN++NWqiN43t4RM2YD74mLqyq046ssphrzdzu+RYdfVw0PhoIFHJAuZSbanC8oCYBemcEtZmKB0XhYOg2yQR9YO25o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362387; c=relaxed/simple;
	bh=ta1wgmBPRCtQfLkFwFQLBpAe1UJ8VWzma3ogvVMf4iE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3iGA+R/XmQXvV23CgFn9XzMUvHPntmIX2OKROCtEGudVdTggMXMQnjLDp+iW3qO3xh5SB64dcM/vEDaEXjdR9QeTbVpHWLmlJWfTvJEllg0vGLB0S/rNZ9daavSyxPQEI/wXeXRir7k+msd9LboYdcfCXoANlXsrVo+rLmG6jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BV4RGeA6; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BV4RGeA6"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PECFvK3838136;
	Fri, 25 Sep 2026 18:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=pwQFU
	wXLfJT55vQzoXb+3gjGpRU2Su6AWvCGJvkHL1g=; b=BV4RGeA6bM4/mh4SnbPAp
	2+Dup0etp0fchad3tGkb1lnNbkBODLl2QbYXle+v1wEf/XpEawPfTOBDsq1xwRXB
	SxFu2smKZ0mrUrU2ywQaNkJZ4QsBvyj6FYCZXsN/Y/Kx5o9PPq2pjnmleJVxUDT9
	8pT/XgbUO4WVSNrMmY0NJDHVLzw9AO4jWevGzcQE4CW5ZahsN8QWNnheI/yy8b1J
	ud4mfcBXEVhhtkhOrcrs6RTAcT5kUkrh30GqrKoyA9ekkLlkkpdhe646s6MoCaub
	iPXUbkgOjRe2bvu6RZ112jbTvhJfJ3lsUeA2kdf71KmXh2tQxAoT4gI3OOUlNPT8
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk1qhwyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:52:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68PIqCDF038625;
	Fri, 25 Sep 2026 18:52:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gtepthtbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:52:40 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68PIqQom040536;
	Fri, 25 Sep 2026 18:52:39 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-81-122.vpn.oracle.com [10.154.81.122])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gtepthsyc-5;
	Fri, 25 Sep 2026 18:52:39 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        qmo@kernel.org
Cc: dwarves@vger.kernel.org, jolsa@kernel.org, daniel@iogearbox.net,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
        bpf@vger.kernel.org, nsc@kernel.org, puranjay@kernel.org,
        yatsenko@meta.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 4/9] pahole: Support inline BTF location encoding
Date: Fri, 25 Sep 2026 19:51:53 +0100
Message-ID: <20260925185200.1318067-5-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260925185200.1318067-1-alan.maguire@oracle.com>
References: <20260925185200.1318067-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609250075
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NSBTYWx0ZWRfX4MXl7qoOFV7o
 GgbvD37xttwDtJPLpIyn4T5YUmE28V963711GfaFilKRV74hnps9NM2slDVMm4FqxM1JLSyCL7e
 vkYfBFrqFYmvgiHHJM/wVKnHMonp5rA1oR0ADzU9aJlVowroqNZO
X-Proofpoint-ORIG-GUID: zquUYWzFFVdnsdtZkwIJruriAgh0c14n
X-Proofpoint-GUID: zquUYWzFFVdnsdtZkwIJruriAgh0c14n
X-Authority-Analysis: v=2.4 cv=LIzz05W9 c=1 sm=1 tr=0 ts=6ab6c2f9 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=wgPChHteOyBy4vfOIGsA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13532
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NSBTYWx0ZWRfX7FOb79uGisuI
 H6/3b6QcRXyAtSxeKW49DT3lGzBwRPdNTU3SnGkZEMnxjrclI9c+ZgJl6YEejQ4p4atMiJLMGc9
 5ja8XHo8mZRDulcswSo2pvuWx66CEpuXndIKZ4ufinOtzoMEfodftyHMJOdue+I7lcUNIUukJcZ
 BrDWL0RLFe36PWfBAjsLAmDLi4+Um1Jnht5jQSJOqbl0tcSxaYUCOLAZCoK2LfnsnLgZ78JIf+3
 hbgwu8qN32xMTCdv/++7Fk+L1OgQW5NYVZkwxGUAfcO8QB6VEFPLu5pvEleAuWxjBQWW8h5igV7
 +DmBnvqdbZBBZ9g+ADGESdNEmd74j7kSrttg6Ce+evZv3f+vOqBaX2WLwTKwm1hZ52pKMD/LiAa
 cTXfOCYrQyS18cLP3kFNVeb0dbF8rzkgfDnll+q+ioGl27xTfF6Fwzd+EnLNse92rji+VT/sqb8
 ysLIP6Xs5gjQonV1jrFbwTvQE5UeOgnRxwS2ivKc=

Add support for emitting BTF location information for inline
expansions when --btf_features=inline is enabled.

Encode inline parameters as BTF_KIND_LOC_PARAM records, collect them
in BTF_KIND_LOC_PROTO records, and associate those with inline
functions through BTF_KIND_LOCSEC records named "inline<section>".

Support constant, register, frame-base-register, dereferenced
base-register, and two-register aggregate parameter locations.
Offsets are marked signed, and the frame-base register uses the
BTF_LOC_PARAM_FBREG sentinel value.  LOC_PARAMs that specify
an address have that address normalized to the base address of
the object (kernel or module).

Use DWFL to resolve an inline expansion address to its executable ELF
section and section-relative offset, including for ET_REL inputs.

Expose inline encoding as a non-default BTF feature and enable inline
DIE loading when it is selected.  Omit the feature support when
the linked libbpf does not provide the required location APIs.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 391 +++++++++++++++++++++++++++++++++++++++++++-------
 dwarves.h     |  15 ++
 pahole.c      |  12 ++
 3 files changed, 366 insertions(+), 52 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index d6b9be6..b4aa382 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -43,6 +43,13 @@
 #define BTF_FASTCALL_TAG       "bpf_fastcall"
 #define BPF_ARENA_ATTR         "address_space(1)"
 
+#define BTF_LOC_PARAM_SIGNED	0x1
+#define BTF_LOC_PARAM_CONST	0x2
+#define BTF_LOC_PARAM_ADDR	0x4
+#define BTF_LOC_PARAM_REG	0x8
+#define BTF_LOC_PARAM_DEREF	0x10
+#define BTF_LOC_PARAM_OFFSET	0x20
+
 /* kfunc flags, see include/linux/btf.h in the kernel source */
 #define KF_FASTCALL   (1 << 12)
 #define KF_ARENA_RET  (1 << 13)
@@ -77,6 +84,23 @@ struct btf_encoder_func_annot {
 	int16_t component_idx;
 };
 
+struct loc_param {
+	uint32_t flags;
+	uint32_t values[2];
+	uint8_t nvalues;
+	uint8_t size;
+};
+
+struct loc {
+	char *name;
+	struct loc_param *params;
+	uint16_t nparams;
+	int func_id;
+	int loc_proto_id;
+	uint32_t section_idx;
+	uint32_t section_offset;
+};
+
 struct elf_function_sym {
 	const char *name;
 	uint64_t addr;
@@ -86,6 +110,7 @@ struct elf_function_sym {
 struct btf_encoder_func_state {
 	struct elf_function *elf;
 	struct elf_function_sym *sym;
+	struct loc *loc;
 	uint64_t addr;
 	uint32_t type_id_off;
 	uint16_t nr_parms;
@@ -103,6 +128,12 @@ struct btf_encoder_func_state {
 	struct btf_encoder_func_annot *annots;
 };
 
+struct btf_encoder_func_states {
+	struct btf_encoder_func_state *array;
+	int cnt;
+	int cap;
+};
+
 struct elf_function {
 	char		*name;
 	struct elf_function_sym *syms;
@@ -116,6 +147,7 @@ struct elf_secinfo {
 	uint64_t    addr;
 	const char *name;
 	uint64_t    sz;
+	uint64_t    flags;
 	uint32_t    type;
 	bool        include;
 	struct gobuffer secinfo;
@@ -175,12 +207,10 @@ struct btf_encoder {
 	uint32_t	  btf_id_skipped;
 	struct elf_secinfo *secinfo;
 	size_t             seccnt;
+	uint64_t           addr_base;
 	int                encode_vars;
-	struct {
-		struct btf_encoder_func_state *array;
-		int cnt;
-		int cap;
-	} func_states;
+	struct btf_encoder_func_states func_states;
+	struct btf_encoder_func_states loc_states;
 	/* This is a list of elf_functions tables, one per ELF.
 	 * Multiple ELF modules can be processed in one pahole run,
 	 * so we have to store elf_functions tables per ELF.
@@ -188,6 +218,8 @@ struct btf_encoder {
 	struct list_head elf_functions_list;
 };
 
+static int btf_encoder__add_locsec(struct btf_encoder *encoder);
+
 /* Half open interval representing range of addresses containing kfuncs */
 struct btf_kfunc_set_range {
 	uint64_t start;
@@ -324,6 +356,9 @@ static const char * const btf_kind_str[] = {
 	[BTF_KIND_DECL_TAG]     = "DECL_TAG",
 	[BTF_KIND_TYPE_TAG]     = "TYPE_TAG",
 	[BTF_KIND_ENUM64]	= "ENUM64",
+	[BTF_KIND_LOC_PARAM]	= "LOC_PARAM",
+	[BTF_KIND_LOC_PROTO]	= "LOC_PROTO",
+	[BTF_KIND_LOCSEC]	= "LOCSEC",
 };
 
 static const char *btf__printable_name(const struct btf *btf, uint32_t offset)
@@ -938,8 +973,10 @@ static int32_t btf_encoder__add_func_proto_for_state(struct btf_encoder *encoder
 		 * name string memory, so make a temporary copy.
 		 */
 		strncpy(tmp_name, name, sizeof(tmp_name) - 1);
+		tmp_name[sizeof(tmp_name) - 1] = '\0';
 
-		if (btf_encoder__add_func_param(encoder, tmp_name, p->type_id, is_last))
+		type_id = p->type_id;
+		if (btf_encoder__add_func_param(encoder, tmp_name, type_id, is_last))
 			return -1;
 	}
 
@@ -1216,31 +1253,57 @@ static bool funcs__match(struct btf_encoder *encoder,
 	return true;
 }
 
-static struct btf_encoder_func_state *btf_encoder__alloc_func_state(struct btf_encoder *encoder)
+static struct btf_encoder_func_state *
+btf_encoder__alloc_func_state(struct btf_encoder_func_states *func_states)
 {
 	struct btf_encoder_func_state *state, *tmp;
 
-	if (encoder->func_states.cnt >= encoder->func_states.cap) {
+	if (func_states->cnt >= func_states->cap) {
 
 		/* We only need to grow to accommodate duplicate
 		 * function declarations across different CUs, so the
 		 * rate of the array growth shouldn't be high.
 		 */
-		encoder->func_states.cap += 64;
+		func_states->cap += 64;
 
-		tmp = realloc(encoder->func_states.array, sizeof(*tmp) * encoder->func_states.cap);
+		tmp = realloc(func_states->array, sizeof(*tmp) * func_states->cap);
 		if (!tmp)
 			return NULL;
 
-		encoder->func_states.array = tmp;
+		func_states->array = tmp;
 	}
 
-	state = &encoder->func_states.array[encoder->func_states.cnt++];
+	state = &func_states->array[func_states->cnt++];
 	memset(state, 0, sizeof(*state));
 
 	return state;
 }
 
+static void loc__delete(struct loc *loc)
+{
+	if (!loc)
+		return;
+	free(loc->name);
+	free(loc->params);
+	free(loc);
+}
+
+static void btf_encoder_func_state__clear(struct btf_encoder_func_state *state)
+{
+	free(state->parms);
+	free(state->annots);
+	loc__delete(state->loc);
+	memset(state, 0, sizeof(*state));
+}
+
+static void btf_encoder__drop_func_state(struct btf_encoder_func_states *func_states,
+					 struct btf_encoder_func_state *state)
+{
+	btf_encoder_func_state__clear(state);
+	if (func_states->cnt > 0 && state == &func_states->array[func_states->cnt - 1])
+		func_states->cnt--;
+}
+
 static bool str_contains_suffix(const char *str, const char * const *suffixes, size_t nr_suffixes)
 {
 	const char *suffix = strchr(str, '.');
@@ -1298,9 +1361,12 @@ static bool elf_function__has_ambiguous_address(struct elf_function *func)
 	return false;
 }
 
-static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn, struct elf_function *func)
+static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn,
+				      struct elf_function *func, struct loc *loc)
 {
-	struct btf_encoder_func_state *state = btf_encoder__alloc_func_state(encoder);
+	struct btf_encoder_func_states *func_states = loc ? &encoder->loc_states :
+							    &encoder->func_states;
+	struct btf_encoder_func_state *state = btf_encoder__alloc_func_state(func_states);
 	struct ftype *ftype = &fn->proto;
 	struct btf *btf = encoder->btf;
 	struct llvm_annotation *annot;
@@ -1313,6 +1379,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 
 	state->addr = function__addr(fn);
 	state->elf = func;
+	state->loc = loc;
 	state->nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
 	state->ret_type_id = btf_encoder__tag_type(encoder, ftype->tag.type);
 	if (state->nr_parms > 0) {
@@ -1322,7 +1389,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 			goto out;
 		}
 	}
-	if (encoder->true_signature && state->addr) {
+	if (encoder->true_signature && state->addr && func) {
 		int i;
 
 		for (i = 0; i < func->sym_cnt; i++) {
@@ -1344,7 +1411,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 	state->uncertain_parm_loc = ftype->uncertain_parm_loc;
 	state->reordered_parm = ftype->reordered_parm;
 	state->signature_changed = ftype->signature_changed;
-	if (state->addr) {
+	if (state->addr && func) {
 		for (int i = 0; i < func->sym_cnt; i++) {
 			if (state->addr != func->syms[i].addr)
 				continue;
@@ -1359,11 +1426,12 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 		char *final_name = NULL;
 
 		/* No location info/optimized + reordered means optimized out. */
-		if (ftype->reordered_parm && (!param->has_loc || param->optimized)) {
+		if (!loc && ftype->reordered_parm && (!param->has_loc || param->optimized)) {
 			state->nr_parms--;
 			continue;
 		}
-		if (encoder->true_signature && ftype->signature_changed && param->optimized) {
+		if (!loc && encoder->true_signature && ftype->signature_changed &&
+		    param->optimized) {
 			state->nr_parms--;
 			continue;
 		}
@@ -1399,6 +1467,9 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 	if (ftype->unspec_parms)
 		state->parms[param_idx].type_id = 0;
 
+	if (loc)
+		return 0;
+
 	list_for_each_entry(annot, &fn->annots, node)
 		state->nr_annots++;
 	if (state->nr_annots) {
@@ -1422,21 +1493,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 	}
 	return 0;
 out:
-	/*
-	 * state is an interior pointer into func_states.array (returned by
-	 * btf_encoder__alloc_func_state), not a standalone allocation.
-	 * Calling free(state) here was heap corruption.
-	 *
-	 * Since no further func_state allocations happen between the alloc
-	 * at the top of this function and this error path, state is always
-	 * the last element (index cnt-1), so decrementing cnt releases it.
-	 * If this invariant ever changes (e.g. nested alloc calls are added),
-	 * this cleanup must be revised.
-	 */
-	zfree(&state->annots);
-	zfree(&state->parms);
-	memset(state, 0, sizeof(*state));
-	encoder->func_states.cnt--;
+	btf_encoder__drop_func_state(func_states, state);
 	return err;
 }
 
@@ -1600,21 +1657,14 @@ static int saved_functions_combine(struct btf_encoder *encoder,
 	return 0;
 }
 
-static void btf_encoder__delete_saved_funcs(struct btf_encoder *encoder)
+static void btf_encoder__delete_func_states(struct btf_encoder_func_states *func_states)
 {
-	struct btf_encoder_func_state *state;
-
-	for (int i = 0; i < encoder->func_states.cnt; i++) {
-		state = &encoder->func_states.array[i];
-		free(state->parms);
-		free(state->annots);
-	}
-
-	free(encoder->func_states.array);
-
-	encoder->func_states.array = NULL;
-	encoder->func_states.cnt = 0;
-	encoder->func_states.cap = 0;
+	for (int i = 0; i < func_states->cnt; i++)
+		btf_encoder_func_state__clear(&func_states->array[i]);
+	free(func_states->array);
+	func_states->array = NULL;
+	func_states->cnt = 0;
+	func_states->cap = 0;
 }
 
 /*
@@ -1784,7 +1834,7 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
 	}
 
 out:
-	btf_encoder__delete_saved_funcs(encoder);
+	btf_encoder__delete_func_states(&encoder->func_states);
 
 	return err;
 }
@@ -2466,6 +2516,11 @@ int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *conf)
 	err = btf_encoder__add_saved_funcs(encoder, conf->skip_encoding_btf_inconsistent_proto);
 	if (err < 0)
 		return err;
+	if (encoder->loc_states.cnt) {
+		err = btf_encoder__add_locsec(encoder);
+		if (err)
+			return err;
+	}
 
 	for (shndx = 1; shndx < encoder->seccnt; shndx++)
 		if (gobuffer__size(&encoder->secinfo[shndx].secinfo))
@@ -2675,7 +2730,7 @@ static size_t get_elf_section(struct btf_encoder *encoder, uint64_t addr)
  * values. Prefixes should be added sparingly, and it should be objectively
  * obvious that they are not useful.
  */
-static bool filter_variable_name(const char *name)
+static bool filter_name(const char *name)
 {
 	static const struct { char *s; size_t len; } skip[] = {
 		#define X(str) {str, sizeof(str) - 1}
@@ -2783,7 +2838,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 		if (!name)
 			continue;
 
-		if (filter_variable_name(name))
+		if (filter_name(name))
 			continue;
 
 		/* A 0 address may be in a "discard" section; DWARF provides
@@ -2972,6 +3027,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		}
 
 		bool found_percpu = false;
+		uint64_t addr_base = UINT64_MAX;
 		for (shndx = 0; shndx < encoder->seccnt; shndx++) {
 			const char *secname = NULL;
 			Elf_Scn *sec = elf_section_by_idx(cu->elf, &shdr, shndx, &secname);
@@ -2979,8 +3035,11 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 				goto out_delete;
 			encoder->secinfo[shndx].addr = shdr.sh_addr;
 			encoder->secinfo[shndx].sz = shdr.sh_size;
+			encoder->secinfo[shndx].flags = shdr.sh_flags;
 			encoder->secinfo[shndx].name = secname;
 			encoder->secinfo[shndx].type = shdr.sh_type;
+			if ((shdr.sh_flags & SHF_ALLOC) && shdr.sh_addr < addr_base)
+				addr_base = shdr.sh_addr;
 
 			if (encoder->encode_vars & BTF_VAR_GLOBAL)
 				encoder->secinfo[shndx].include = true;
@@ -2992,6 +3051,8 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 			}
 		}
 
+		encoder->addr_base = addr_base == UINT64_MAX ? 0 : addr_base;
+
 		if (!found_percpu && encoder->verbose)
 			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
 
@@ -3030,7 +3091,8 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 
 	elf_functions_list__clear(&encoder->elf_functions_list);
 
-	btf_encoder__delete_saved_funcs(encoder);
+	btf_encoder__delete_func_states(&encoder->func_states);
+	btf_encoder__delete_func_states(&encoder->loc_states);
 
 	free(encoder);
 }
@@ -3067,6 +3129,220 @@ static bool ftype__has_uncertain_arg_loc(struct cu *cu, struct ftype *ftype)
 	return false;
 }
 
+#define BTF_LOC_PARAM_FBREG	0xffffffff
+
+static int btf_encoder__add_loc_param(struct parameter *param, uint64_t base,
+				      struct loc_param *lp)
+{
+	uint8_t size = param->loc_size ?: sizeof(uint64_t);
+	uint64_t value;
+
+	memset(lp, 0, sizeof(*lp));
+	if ((param->loc_const_value || param->has_const_value) && param->loc_size) {
+		/* The loader currently retains at most one 64-bit constant value. */
+		if (size > sizeof(value))
+			return 0;
+		value = param->loc_value;
+		lp->size = size;
+		lp->flags = BTF_LOC_PARAM_CONST;
+		if (param->loc_addr) {
+			lp->flags |= BTF_LOC_PARAM_ADDR;
+			if (value >= base)
+				value -= base;
+		}
+		if (param->loc_signed)
+			lp->flags |= BTF_LOC_PARAM_SIGNED;
+		lp->values[lp->nvalues++] = value;
+		if (lp->size > sizeof(uint32_t))
+			lp->values[lp->nvalues++] = value >> 32;
+		return 1;
+	}
+	if (param->loc_reg >= DW_OP_reg0 && param->loc_reg2 >= DW_OP_reg0) {
+		lp->size = size;
+		lp->flags = BTF_LOC_PARAM_REG;
+		lp->values[lp->nvalues++] = param->loc_reg - DW_OP_reg0;
+		lp->values[lp->nvalues++] = param->loc_reg2 - DW_OP_reg0;
+		return 1;
+	}
+	if (param->loc_reg >= DW_OP_reg0) {
+		lp->size = size;
+		lp->flags = BTF_LOC_PARAM_REG;
+		if (param->loc_deref)
+			lp->flags |= BTF_LOC_PARAM_DEREF;
+		lp->values[lp->nvalues++] = param->loc_reg - DW_OP_reg0;
+		if (param->loc_offset) {
+			lp->flags |= BTF_LOC_PARAM_OFFSET | BTF_LOC_PARAM_SIGNED;
+			lp->values[lp->nvalues++] = param->loc_offset;
+		}
+		return 1;
+	}
+	if (param->loc_stack) {
+		lp->size = size;
+		lp->flags = BTF_LOC_PARAM_REG;
+		if (param->loc_deref)
+			lp->flags |= BTF_LOC_PARAM_DEREF;
+		lp->values[lp->nvalues++] = BTF_LOC_PARAM_FBREG;
+		if (param->loc_offset) {
+			lp->flags |= BTF_LOC_PARAM_OFFSET | BTF_LOC_PARAM_SIGNED;
+			lp->values[lp->nvalues++] = param->loc_offset;
+		}
+		return 1;
+	}
+	return 0;
+}
+
+static int btf_encoder__add_inline_expansion(struct btf_encoder *encoder,
+					     struct inline_expansion *ie)
+{
+	struct ftype *ftype;
+	struct loc *loc;
+	struct parameter *param;
+	Dwarf_Addr section_offset, bias;
+	Elf_Scn *section;
+	size_t section_idx;
+	int err;
+
+	/* DWFL accounts for ET_REL relocations and identifies the actual
+	 * executable section, unlike a raw DWARF address comparison.
+	 */
+	section_offset = ie->ip.addr;
+	section = dwfl_module_address_section(encoder->cu->dwfl, &section_offset, &bias);
+	section_idx = section ? elf_ndxscn(section) : 0;
+	if (!ie->function || !ie->name || !section_idx || section_idx >= encoder->seccnt ||
+	    !(encoder->secinfo[section_idx].flags & SHF_EXECINSTR) ||
+	    section_offset > UINT32_MAX)
+		return 0;
+	ftype = &ie->function->proto;
+	loc = calloc(1, sizeof(*loc));
+	if (!loc)
+		return -ENOMEM;
+	loc->name = strdup(ie->name);
+	if (!loc->name) {
+		err = -ENOMEM;
+		goto out;
+	}
+	loc->section_idx = section_idx;
+	loc->section_offset = section_offset;
+	loc->nparams = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
+	loc->params = calloc(loc->nparams ? loc->nparams : 1, sizeof(*loc->params));
+	if (!loc->params) {
+		err = -ENOMEM;
+		goto out;
+	}
+	inline_expansion__for_each_parameter(ie, param) {
+		if (param->idx < loc->nparams)
+			btf_encoder__add_loc_param(param, encoder->addr_base,
+						   &loc->params[param->idx]);
+	}
+	err = btf_encoder__save_func(encoder, ie->function, NULL, loc);
+	loc = NULL; /* save_func owns loc after this point, including on error */
+	if (!err)
+		return 0;
+out:
+	loc__delete(loc);
+	return err;
+}
+
+static int btf_encoder__loc_state_cmp(const void *a, const void *b)
+{
+	const struct btf_encoder_func_state *sa = a;
+	const struct btf_encoder_func_state *sb = b;
+	const struct loc *la = sa->loc;
+	const struct loc *lb = sb->loc;
+
+	if (la->section_idx != lb->section_idx)
+		return la->section_idx < lb->section_idx ? -1 : 1;
+	if (la->section_offset != lb->section_offset)
+		return la->section_offset < lb->section_offset ? -1 : 1;
+	return 0;
+}
+
+static int btf_encoder__add_locsec(struct btf_encoder *encoder)
+{
+	struct btf_encoder_func_state *states = encoder->loc_states.array;
+	uint32_t section_idx = UINT32_MAX;
+	int err, id;
+
+	if (!encoder->loc_states.cnt)
+		return 0;
+	if (!btf__add_loc_param || !btf__add_loc_param_value || !btf__add_loc_proto ||
+	    !btf__add_loc_proto_param || !btf__add_locsec || !btf__add_locsec_loc)
+		return -ENOTSUP;
+	qsort(states, encoder->loc_states.cnt, sizeof(*states), btf_encoder__loc_state_cmp);
+	for (int i = 0; i < encoder->loc_states.cnt; i++) {
+		struct loc *loc = states[i].loc;
+		int *param_ids = calloc(loc->nparams ? loc->nparams : 1, sizeof(*param_ids));
+		int proto;
+
+		if (!param_ids)
+			return -ENOMEM;
+		proto = btf_encoder__add_func_proto_for_state(encoder, &states[i]);
+		if (proto < 0) {
+			free(param_ids);
+			return proto;
+		}
+		loc->func_id = btf__add_func(encoder->btf, loc->name, BTF_FUNC_STATIC, proto);
+		if (loc->func_id < 0) {
+			free(param_ids);
+			return loc->func_id;
+		}
+		for (uint16_t j = 0; j < loc->nparams; j++) {
+			struct loc_param *p = &loc->params[j];
+
+			/* A zero id in LOC_PROTO represents unavailable location data. */
+			if (!p->size)
+				continue;
+			param_ids[j] = btf__add_loc_param(encoder->btf, p->size, p->flags);
+			if (param_ids[j] < 0) {
+				err = param_ids[j];
+				free(param_ids);
+				return err;
+			}
+			for (uint8_t k = 0; k < p->nvalues; k++) {
+				err = btf__add_loc_param_value(encoder->btf, p->values[k]);
+				if (err < 0) {
+					free(param_ids);
+					return err;
+				}
+			}
+		}
+		loc->loc_proto_id = btf__add_loc_proto(encoder->btf);
+		if (loc->loc_proto_id < 0) {
+			free(param_ids);
+			return loc->loc_proto_id;
+		}
+		for (uint16_t j = 0; j < loc->nparams; j++) {
+			err = btf__add_loc_proto_param(encoder->btf, param_ids[j]);
+			if (err < 0) {
+				free(param_ids);
+				return err;
+			}
+		}
+		free(param_ids);
+	}
+	for (int i = 0; i < encoder->loc_states.cnt; i++) {
+		struct loc *loc = states[i].loc;
+
+		if (loc->section_idx != section_idx) {
+			char *name;
+
+			section_idx = loc->section_idx;
+			if (asprintf(&name, "inline%s", encoder->secinfo[section_idx].name) < 0)
+				return -ENOMEM;
+			id = btf__add_locsec(encoder->btf, name);
+			free(name);
+			if (id < 0)
+				return id;
+		}
+		err = btf__add_locsec_loc(encoder->btf, loc->func_id,
+					  loc->loc_proto_id, loc->section_offset);
+		if (err < 0)
+			return err;
+	}
+	btf_encoder__delete_func_states(&encoder->loc_states);
+	return 0;
+}
+
 /*
  * Pre-compute the actual BTF type id for every DWARF core_id.
  *
@@ -3144,6 +3420,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 	struct elf_functions *funcs;
 	uint32_t core_id;
 	struct function *fn;
+	struct inline_expansion *ie;
 	struct tag *pos;
 	int err = 0;
 
@@ -3349,11 +3626,21 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 		if (ftype__has_uncertain_arg_loc(cu, &fn->proto))
 			fn->proto.uncertain_parm_loc = 1;
 
-		err = btf_encoder__save_func(encoder, fn, func);
+		err = btf_encoder__save_func(encoder, fn, func, NULL);
 		if (err)
 			goto out;
 	}
 
+	if (conf_load->btf_gen_inlines) {
+		cu__for_each_inline_expansion(cu, core_id, ie) {
+			if (!ie->name || !ie->function || filter_name(ie->name))
+				continue;
+			err = btf_encoder__add_inline_expansion(encoder, ie);
+			if (err)
+				goto out;
+		}
+	}
+
 	if (encoder->encode_vars)
 		err = btf_encoder__encode_cu_variables(encoder);
 
diff --git a/dwarves.h b/dwarves.h
index b6ddb50..746f94e 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -46,6 +46,13 @@ enum load_steal_kind {
 	LSK__ABORT,
 };
 
+/* For older libbpf may need to define BTF location data kinds. */
+#ifndef BTF_KIND_LOC_PARAM
+#define BTF_KIND_LOC_PARAM	20
+#define BTF_KIND_LOC_PROTO	21
+#define BTF_KIND_LOCSEC		22
+#endif
+
 struct btf_new_opts;
 
 /*
@@ -58,6 +65,13 @@ __weak extern int btf__add_enum64_value(struct btf *btf, const char *name, __u64
 __weak extern int btf__add_type_attr(struct btf *btf, const char *value, int ref_type_id);
 __weak extern int btf__distill_base(const struct btf *src_btf, struct btf **new_base_btf, struct btf **new_split_btf);
 __weak extern struct btf *btf__new_empty_opts(struct btf_new_opts *opts);
+__weak extern int btf__add_loc_param(struct btf *btf, __u32 size, __u32 flags);
+__weak extern int btf__add_loc_param_value(struct btf *btf, __u32 value);
+__weak extern int btf__add_loc_proto(struct btf *btf);
+__weak extern int btf__add_loc_proto_param(struct btf *btf, __u32 id);
+__weak extern int btf__add_locsec(struct btf *btf, const char *name);
+__weak extern int btf__add_locsec_loc(struct btf *btf, __u32 func,
+				      __u32 loc_proto, __u32 offset);
 
 /*
  * BTF combines all the types into one big CU using btf_dedup(), so for something
@@ -104,6 +118,7 @@ struct conf_load {
 	bool			reproducible_build;
 	bool			btf_decl_tag_kfuncs;
 	bool			btf_gen_distilled_base;
+	bool			btf_gen_inlines;
 	bool			btf_attributes;
 	bool			true_signature;
 	uint8_t			hashtable_bits;
diff --git a/pahole.c b/pahole.c
index b2047c1..5c05b97 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1217,6 +1217,13 @@ static bool layout_check(void)
 	return btf__new_empty_opts != NULL;
 }
 
+static bool location_check(void)
+{
+	return btf__add_loc_param && btf__add_loc_param_value &&
+		btf__add_loc_proto && btf__add_loc_proto_param &&
+		btf__add_locsec && btf__add_locsec_loc;
+}
+
 struct btf_feature {
 	const char      *name;
 	const char      *option_alias;
@@ -1244,6 +1251,7 @@ struct btf_feature {
 				      attributes_check),
 	BTF_NON_DEFAULT_FEATURE(true_signature, true_signature, false),
 	BTF_NON_DEFAULT_FEATURE_CHECK(layout, btf_gen_layout, false, layout_check),
+	BTF_NON_DEFAULT_FEATURE_CHECK(inline, btf_gen_inlines, false, location_check),
 	BTF_NON_DEFAULT_FEATURE(force_cu_merging, force_cu_merging, false),
 };
 
@@ -3754,6 +3762,10 @@ try_sole_arg_as_class_names:
 		}
 	}
 
+	if (conf_load.btf_gen_inlines) {
+		/* BTF encoding normally omits inline DIEs; inline BTF needs them. */
+		conf_load.ignore_inline_expansions = false;
+	}
 	err = cus__load_files(cus, &conf_load, argv + remaining);
 	if (err != 0) {
 		if (class_name == NULL && !btf_encode && !ctf_encode) {
-- 
2.43.5

