Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E52F39F188;
	Wed,  2 Sep 2026 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349151; cv=none; b=PKKA30c/8QDkd6hj6cf6w/4NIrdiz1yW/tnV4VNd4UjgVkbubVU+1MPhQXGOi3Y5tC0ttN2CQWEE1/iq/yv54SUac9BX7B2kGKnIGVRNmMK3Y2rV90OvNTlwXqThFkhzkbWvDpHNHRpXK5BJm/NV2dE+4MS+oVWCLCtE27J89KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349151; c=relaxed/simple;
	bh=ckZrty2zVwd518PvEsV+CsDDCngZ2JirFbp4eASxgb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/yps4ffXDerxaoT38+6I9XlLEVpY1/LfKtJ6uwXBkq4myRFM88YgVLoBntcnpyPNB8aCJ5QPnvqZYwWvdNBLLb8rT7Adhf9lpqzTffAEsPt3/jM+aj2MxiLb+g2Sk6dkgu6Mya4vvxbOap2t4hyjz1OAE0dPb3vavbu7lV6vx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OLHP+SZd; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OLHP+SZd"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6820TBKn1276853;
	Wed, 2 Sep 2026 11:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=+nAFl
	MuWUZe4hP5KKKDq3jVtG5iJ4if1+++IzJUT+Fc=; b=OLHP+SZd61ft0dPjE4zQ7
	jphvypUeI0ZxqZtkaZriqO9PvmAEqho4g8LDtLM9d2hSwJYuJthUZx0VQG8f3xCB
	CPvFkH4/i4njhm3Q5LgKhG9wfXLZD0CelU4JnsIVaK0xZOoRgaUxo55UlIPY6nEB
	JDPQx+kaN1FAIW4wXXNzZrxWNR9QyBNiCG/NDgXD/T2wooypRykNASpQGg5tZcgX
	JKsrbwFh2S2OPG8p6eHcbltfCY0eW3d6Szo+FJY3B1IJDtWS5IvoSdgo2tKLcr8B
	/eOTuUfdgTB4J+dlLeuuzGj5uxFHWqHLC5Qa6Wr+ddhpzNV3OTvOICZ2WdCMu103
	g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbqa7pk84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Sep 2026 11:38:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 682BaXAc029389;
	Wed, 2 Sep 2026 11:38:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvrnt7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Sep 2026 11:38:44 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 682BcYmg038508;
	Wed, 2 Sep 2026 11:38:43 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-253.vpn.oracle.com [10.154.52.253])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gbnvrnt37-5;
	Wed, 02 Sep 2026 11:38:43 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, eddyz87@gmail.com, jolsa@kernel.org,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, bpf@vger.kernel.org, dwarves@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 4/6] pahole: Support inline BTF location encoding
Date: Wed,  2 Sep 2026 12:38:24 +0100
Message-ID: <20260902113829.1285407-5-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260902113829.1285407-1-alan.maguire@oracle.com>
References: <20260902113829.1285407-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2609020103
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEwMyBTYWx0ZWRfX+G6gCVKtYaGl
 9TumHSbcQfnPn39Qk69u1ywkPPwze8bBE8C4LJvdCtXUsg/Ju2yd1XOQz7S/goJzBkg3zIA1LlW
 YqkdDD+5PnyhX25CRjjrC8FVJ/1mf/ltCfEvtz/YFs4FPGJ2Ap/0
X-Proofpoint-GUID: 0TAQXjW4JYvbhtv-iW0Sd2H5Wieuk4rK
X-Authority-Analysis: v=2.4 cv=DPu/JSNb c=1 sm=1 tr=0 ts=6a980ac5 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=7Ikd92YKOU0rq1bql8UA:9
 a=O8hF6Hzn-FEA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12102
X-Proofpoint-ORIG-GUID: 0TAQXjW4JYvbhtv-iW0Sd2H5Wieuk4rK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEwMyBTYWx0ZWRfXzyTIe3kZ28x2
 GkeUhsVpjsIoEtuqP6X9k6irGbAV3JLYCV/3ZdEme4zN+98EF3uAGggREqYi00zPG0AX3AA3Jux
 I1SGZTDxBHm+1sGFoqMn4sagiTdkK9fSqKCTa16CBuRQMfCv+yjgCrUhiz/kAinB9fQqsrbPF+B
 RIXQc9HgUJiX6qecnAs/gMFT/LEBytcGKH0BsO+LnPQZB2dnnNSJdxNzwH2druuV4GhTDwMzsMD
 L3oVO7gzwtWBiNtPWAYRUsII0fESDMiHWl1AoQ3Yfeb7R1+XefIYIsJTWNc49Wj4Wy/V21vspK9
 PnEpF/wILXXO+uv1me6vcZBGEHuxP/1XaLm1INAAx4UhtjBq0k8bHye5GMxI47u07ApnWRpTZEo
 Zaz2kZbmxP8eCVi5iTFxlUfoyt+mWNblqS059T+hZxTvZYTD7geA9nAY4WEhZyhJpUY6WjO02Ir
 zI2SBv87buxMwQnLkthChRwpp9oWIl5ZIrD0nu0o=

Add the inline BTF feature, preserving inline DWARF expansions and encoding
their parameter locations into LOC_PARAM, LOC_PROTO, and LOCSEC records.

Enable it with `--btf_features=+inline`. The feature is available only when
the linked libbpf provides the required location-record APIs; enabling it also
keeps inline DWARF expansions during CU loading.

Track inline function states separately from ordinary function BTF and emit
the inline location section after regular function encoding.

Inline info will be add to LOCSECs named for section, e.g. ".text".

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c  | 339 +++++++++++++++++++++++++++++++++++++++++--------
 dwarf_loader.c | 192 ++++++++++++++++++++++------
 dwarves.h      |  17 +++
 pahole.c       |  12 ++
 4 files changed, 467 insertions(+), 93 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index d6b9be6..f4e6298 100644
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
@@ -176,11 +208,8 @@ struct btf_encoder {
 	struct elf_secinfo *secinfo;
 	size_t             seccnt;
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
@@ -188,6 +217,8 @@ struct btf_encoder {
 	struct list_head elf_functions_list;
 };
 
+static int btf_encoder__add_locsec(struct btf_encoder *encoder);
+
 /* Half open interval representing range of addresses containing kfuncs */
 struct btf_kfunc_set_range {
 	uint64_t start;
@@ -324,6 +355,9 @@ static const char * const btf_kind_str[] = {
 	[BTF_KIND_DECL_TAG]     = "DECL_TAG",
 	[BTF_KIND_TYPE_TAG]     = "TYPE_TAG",
 	[BTF_KIND_ENUM64]	= "ENUM64",
+	[BTF_KIND_LOC_PARAM]	= "LOC_PARAM",
+	[BTF_KIND_LOC_PROTO]	= "LOC_PROTO",
+	[BTF_KIND_LOCSEC]	= "LOCSEC",
 };
 
 static const char *btf__printable_name(const struct btf *btf, uint32_t offset)
@@ -938,8 +972,10 @@ static int32_t btf_encoder__add_func_proto_for_state(struct btf_encoder *encoder
 		 * name string memory, so make a temporary copy.
 		 */
 		strncpy(tmp_name, name, sizeof(tmp_name) - 1);
+		tmp_name[sizeof(tmp_name) - 1] = '\0';
 
-		if (btf_encoder__add_func_param(encoder, tmp_name, p->type_id, is_last))
+		type_id = p->type_id;
+		if (btf_encoder__add_func_param(encoder, tmp_name, type_id, is_last))
 			return -1;
 	}
 
@@ -1216,31 +1252,57 @@ static bool funcs__match(struct btf_encoder *encoder,
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
@@ -1298,9 +1360,11 @@ static bool elf_function__has_ambiguous_address(struct elf_function *func)
 	return false;
 }
 
-static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn, struct elf_function *func)
+static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn,
+				      struct elf_function *func, struct loc *loc)
 {
-	struct btf_encoder_func_state *state = btf_encoder__alloc_func_state(encoder);
+	struct btf_encoder_func_states *func_states = loc ? &encoder->loc_states : &encoder->func_states;
+	struct btf_encoder_func_state *state = btf_encoder__alloc_func_state(func_states);
 	struct ftype *ftype = &fn->proto;
 	struct btf *btf = encoder->btf;
 	struct llvm_annotation *annot;
@@ -1313,6 +1377,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 
 	state->addr = function__addr(fn);
 	state->elf = func;
+	state->loc = loc;
 	state->nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
 	state->ret_type_id = btf_encoder__tag_type(encoder, ftype->tag.type);
 	if (state->nr_parms > 0) {
@@ -1322,7 +1387,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 			goto out;
 		}
 	}
-	if (encoder->true_signature && state->addr) {
+	if (encoder->true_signature && state->addr && func) {
 		int i;
 
 		for (i = 0; i < func->sym_cnt; i++) {
@@ -1344,7 +1409,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 	state->uncertain_parm_loc = ftype->uncertain_parm_loc;
 	state->reordered_parm = ftype->reordered_parm;
 	state->signature_changed = ftype->signature_changed;
-	if (state->addr) {
+	if (state->addr && func) {
 		for (int i = 0; i < func->sym_cnt; i++) {
 			if (state->addr != func->syms[i].addr)
 				continue;
@@ -1359,11 +1424,11 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 		char *final_name = NULL;
 
 		/* No location info/optimized + reordered means optimized out. */
-		if (ftype->reordered_parm && (!param->has_loc || param->optimized)) {
+		if (!loc && ftype->reordered_parm && (!param->has_loc || param->optimized)) {
 			state->nr_parms--;
 			continue;
 		}
-		if (encoder->true_signature && ftype->signature_changed && param->optimized) {
+		if (!loc && encoder->true_signature && ftype->signature_changed && param->optimized) {
 			state->nr_parms--;
 			continue;
 		}
@@ -1399,6 +1464,9 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 	if (ftype->unspec_parms)
 		state->parms[param_idx].type_id = 0;
 
+	if (loc)
+		return 0;
+
 	list_for_each_entry(annot, &fn->annots, node)
 		state->nr_annots++;
 	if (state->nr_annots) {
@@ -1422,21 +1490,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
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
 
@@ -1600,21 +1654,14 @@ static int saved_functions_combine(struct btf_encoder *encoder,
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
@@ -1784,7 +1831,7 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
 	}
 
 out:
-	btf_encoder__delete_saved_funcs(encoder);
+	btf_encoder__delete_func_states(&encoder->func_states);
 
 	return err;
 }
@@ -2466,6 +2513,11 @@ int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *conf)
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
@@ -2675,7 +2727,7 @@ static size_t get_elf_section(struct btf_encoder *encoder, uint64_t addr)
  * values. Prefixes should be added sparingly, and it should be objectively
  * obvious that they are not useful.
  */
-static bool filter_variable_name(const char *name)
+static bool filter_name(const char *name)
 {
 	static const struct { char *s; size_t len; } skip[] = {
 		#define X(str) {str, sizeof(str) - 1}
@@ -2783,7 +2835,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 		if (!name)
 			continue;
 
-		if (filter_variable_name(name))
+		if (filter_name(name))
 			continue;
 
 		/* A 0 address may be in a "discard" section; DWARF provides
@@ -2979,6 +3031,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 				goto out_delete;
 			encoder->secinfo[shndx].addr = shdr.sh_addr;
 			encoder->secinfo[shndx].sz = shdr.sh_size;
+			encoder->secinfo[shndx].flags = shdr.sh_flags;
 			encoder->secinfo[shndx].name = secname;
 			encoder->secinfo[shndx].type = shdr.sh_type;
 
@@ -3030,7 +3083,8 @@ void btf_encoder__delete(struct btf_encoder *encoder)
 
 	elf_functions_list__clear(&encoder->elf_functions_list);
 
-	btf_encoder__delete_saved_funcs(encoder);
+	btf_encoder__delete_func_states(&encoder->func_states);
+	btf_encoder__delete_func_states(&encoder->loc_states);
 
 	free(encoder);
 }
@@ -3067,6 +3121,175 @@ static bool ftype__has_uncertain_arg_loc(struct cu *cu, struct ftype *ftype)
 	return false;
 }
 
+#define BTF_LOC_PARAM_FBREG	(DW_OP_fbreg - DW_OP_breg0)
+
+static int btf_encoder__add_loc_param(struct parameter *param, uint64_t base,
+				      struct loc_param *lp)
+{
+	uint8_t size = param->loc_size ?: sizeof(uint64_t);
+	uint64_t value;
+
+	memset(lp, 0, sizeof(*lp));
+	if ((param->loc_const_value || param->has_const_value) && param->loc_size) {
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
+	if (param->loc_reg >= DW_OP_reg0) {
+		lp->size = size;
+		lp->flags = BTF_LOC_PARAM_REG;
+		if (param->loc_deref)
+			lp->flags |= BTF_LOC_PARAM_DEREF;
+		lp->values[lp->nvalues++] = param->loc_reg - DW_OP_reg0;
+		if (param->loc_offset) {
+			lp->flags |= BTF_LOC_PARAM_OFFSET;
+			lp->values[lp->nvalues++] = param->loc_offset;
+		}
+		return 1;
+	}
+	if (param->loc_stack) {
+		lp->size = size;
+		lp->flags = BTF_LOC_PARAM_REG | BTF_LOC_PARAM_DEREF;
+		lp->values[lp->nvalues++] = BTF_LOC_PARAM_FBREG;
+		if (param->loc_offset) {
+			lp->flags |= BTF_LOC_PARAM_OFFSET;
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
+	int err;
+
+	if (!ie->function || !ie->name || ie->section_idx == 0 ||
+	    ie->section_idx >= encoder->seccnt ||
+	    !(encoder->secinfo[ie->section_idx].flags & SHF_EXECINSTR) ||
+	    ie->section_offset > UINT32_MAX)
+		return 0;
+	ftype = &ie->function->proto;
+	loc = calloc(1, sizeof(*loc));
+	if (!loc)
+		return -ENOMEM;
+	loc->name = strdup(ie->name);
+	if (!loc->name) { err = -ENOMEM; goto out; }
+	loc->section_idx = ie->section_idx;
+	loc->section_offset = ie->section_offset;
+	loc->nparams = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
+	loc->params = calloc(loc->nparams ? loc->nparams : 1, sizeof(*loc->params));
+	if (!loc->params) { err = -ENOMEM; goto out; }
+	inline_expansion__for_each_parameter(ie, param) {
+		if (param->idx < loc->nparams)
+			btf_encoder__add_loc_param(param,
+				encoder->secinfo[ie->section_idx].addr,
+				&loc->params[param->idx]);
+	}
+	err = btf_encoder__save_func(encoder, ie->function, NULL, loc);
+	if (!err)
+		return 0;
+	loc = NULL;
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
+		if (proto < 0) { free(param_ids); return proto; }
+		loc->func_id = btf__add_func(encoder->btf, loc->name, BTF_FUNC_STATIC, proto);
+		if (loc->func_id < 0) { free(param_ids); return loc->func_id; }
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
+				if (err < 0) { free(param_ids); return err; }
+			}
+		}
+		loc->loc_proto_id = btf__add_loc_proto(encoder->btf);
+		if (loc->loc_proto_id < 0) { free(param_ids); return loc->loc_proto_id; }
+		for (uint16_t j = 0; j < loc->nparams; j++) {
+			err = btf__add_loc_proto_param(encoder->btf, param_ids[j]);
+			if (err < 0) { free(param_ids); return err; }
+		}
+		free(param_ids);
+	}
+	uint32_t section_idx = UINT32_MAX;
+	for (int i = 0; i < encoder->loc_states.cnt; i++) {
+		struct loc *loc = states[i].loc;
+
+		if (loc->section_idx != section_idx) {
+			section_idx = loc->section_idx;
+			id = btf__add_locsec(encoder->btf, encoder->secinfo[section_idx].name);
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
@@ -3144,6 +3367,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 	struct elf_functions *funcs;
 	uint32_t core_id;
 	struct function *fn;
+	struct inline_expansion *ie;
 	struct tag *pos;
 	int err = 0;
 
@@ -3310,6 +3534,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 		}
 	}
 
+	/* Inline BTF augments, rather than replaces, ordinary function BTF. */
 	cu__for_each_function(cu, core_id, fn) {
 		struct elf_function *func = NULL;
 
@@ -3349,11 +3574,21 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
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
 
diff --git a/dwarf_loader.c b/dwarf_loader.c
index d586b80..6c49a3e 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1701,7 +1701,31 @@ static Dwarf_Die *get_member_with_offset(Dwarf_Die *die, int offset, Dwarf_Die *
 
 static bool dwarf_op__is_reg(unsigned int atom)
 {
-	return atom >= DW_OP_reg0 && atom <= DW_OP_reg31;
+	return (atom >= DW_OP_reg0 && atom <= DW_OP_reg31) || atom == DW_OP_regx;
+}
+
+static int dwarf_op__regno(const Dwarf_Op *op)
+{
+	if (op->atom >= DW_OP_reg0 && op->atom <= DW_OP_reg31)
+		return op->atom - DW_OP_reg0;
+	if (op->atom == DW_OP_regx && op->number <= INT_MAX - DW_OP_reg0)
+		return op->number;
+	return -1;
+}
+
+static int dwarf_op__bregno(const Dwarf_Op *op)
+{
+	if (op->atom >= DW_OP_breg0 && op->atom <= DW_OP_breg31)
+		return op->atom - DW_OP_breg0;
+	if (op->atom == DW_OP_bregx && op->number <= INT_MAX - DW_OP_reg0)
+		return op->number;
+	return -1;
+}
+
+static int64_t dwarf_op__breg_offset(const Dwarf_Op *op)
+{
+	return op->atom == DW_OP_bregx ? (int64_t)(Dwarf_Sword)op->number2 :
+					 (int64_t)(Dwarf_Sword)op->number;
 }
 
 static bool dwarf_expr__has_stack_value(Dwarf_Op *expr, size_t exprlen)
@@ -1722,29 +1746,6 @@ static uint8_t parameter__loc_size(const struct parameter *parm, const struct cu
 	return size;
 }
 
-static uint8_t dwarf_op__const_size(unsigned int atom)
-{
-	switch (atom) {
-	case DW_OP_lit0 ... DW_OP_lit31:
-	case DW_OP_const1u:
-	case DW_OP_const1s:
-		return 1;
-	case DW_OP_const2u:
-	case DW_OP_const2s:
-		return 2;
-	case DW_OP_const4u:
-	case DW_OP_const4s:
-		return 4;
-	case DW_OP_const8u:
-	case DW_OP_const8s:
-	case DW_OP_constu:
-	case DW_OP_consts:
-		return 8;
-	default:
-		return 0;
-	}
-}
-
 static bool dwarf_op__const_signed(unsigned int atom)
 {
 	switch (atom) {
@@ -1781,6 +1782,9 @@ static void parameter__record_loc_reg(struct parameter *parm, int reg,
 				      int64_t offset, bool is_deref,
 				      uint8_t size)
 {
+	if (reg < DW_OP_reg0)
+		return;
+
 	parameter__set_loc_reg(parm, reg);
 
 	if (parm->loc_reg != reg)
@@ -1901,7 +1905,7 @@ static void parameter__multi_exprs(Dwarf_Op *expr, int loc_num, struct cu *cu,
 			else
 				value = dwarf_op__const_value(&expr[0]);
 			parameter__record_loc_const(parm, value,
-						    dwarf_op__const_size(expr[0].atom),
+						    parameter__loc_size(parm, cu),
 						    dwarf_op__const_signed(expr[0].atom), false);
 		}
 		return;
@@ -1913,14 +1917,22 @@ static void parameter__multi_exprs(Dwarf_Op *expr, int loc_num, struct cu *cu,
 
 		switch (expr[0].atom) {
 		case DW_OP_reg0 ... DW_OP_reg31:
-			if (loc_num == 0)
-				parameter__record_loc_reg(parm, expr[0].atom, 0, false, size);
+		case DW_OP_regx: {
+			int reg = dwarf_op__regno(&expr[0]);
+
+			if (loc_num == 0 && reg >= 0)
+				parameter__record_loc_reg(parm, DW_OP_reg0 + reg, 0, false, size);
 			return;
+		}
 		case DW_OP_breg0 ... DW_OP_breg31:
-			if (loc_num == 0 && had_stack_value)
-				parameter__record_loc_reg(parm, expr[0].atom - DW_OP_breg0 + DW_OP_reg0,
-							  dwarf_op__snumber(&expr[0]), false, size);
+		case DW_OP_bregx: {
+			int breg = dwarf_op__bregno(&expr[0]);
+
+			if (loc_num == 0 && had_stack_value && breg >= 0)
+				parameter__record_loc_reg(parm, DW_OP_reg0 + breg,
+							  dwarf_op__breg_offset(&expr[0]), false, size);
 			return;
+		}
 		default:
 			return;
 		}
@@ -1942,10 +1954,14 @@ static void parameter__multi_exprs(Dwarf_Op *expr, int loc_num, struct cu *cu,
 				parameter__set_field_bit(&parm->second_reg_fields, off - cu->addr_size);
 			off += num;
 		} else if (dwarf_op__is_reg(expr[i].atom)) {
+			int reg = dwarf_op__regno(&expr[i]);
+
+			if (reg < 0)
+				continue;
 			if (off < cu->addr_size || parm->loc_reg == PARAMETER_UNKNOWN_REG) {
 				uint8_t size = parameter__loc_size(parm, cu);
 
-				parameter__record_loc_reg(parm, expr[i].atom, 0, false, size);
+				parameter__record_loc_reg(parm, DW_OP_reg0 + reg, 0, false, size);
 			}
 		}
 	}
@@ -1972,10 +1988,56 @@ static void parameter__decode_location(Dwarf_Attribute *attr, struct conf_load *
 			continue;
 
 		had_stack_value = expr[exprlen - 1].atom == DW_OP_stack_value;
+
+		/*
+		 * These expressions describe a scalar value, not aggregate
+		 * pieces.  Recognize their complete forms before dropping a
+		 * trailing DW_OP_stack_value: doing that first would either lose
+		 * DW_OP_plus_uconst or make a dereference look like a plain reg.
+		 */
+		if (loc_num == 0 && exprlen >= 2) {
+			int breg = dwarf_op__bregno(&expr[0]);
+			int reg = dwarf_op__regno(&expr[0]);
+			int base_reg = breg >= 0 ? breg : reg;
+			int64_t reg_offset = breg >= 0 ? dwarf_op__breg_offset(&expr[0]) : 0;
+
+			if (base_reg >= 0 &&
+			    ((exprlen == 2 &&
+			      (expr[1].atom == DW_OP_deref || expr[1].atom == DW_OP_deref_size)) ||
+			     (exprlen == 3 && had_stack_value &&
+			      (expr[1].atom == DW_OP_deref || expr[1].atom == DW_OP_deref_size)))) {
+				/* DW_OP_deref_size must produce the parameter's full value. */
+				if (expr[1].atom == DW_OP_deref_size &&
+				    expr[1].number != parameter__loc_size(parm, cu))
+					continue;
+				parameter__record_loc_reg(parm, DW_OP_reg0 + base_reg,
+						  reg_offset, true, parameter__loc_size(parm, cu));
+				continue;
+			}
+			if (base_reg >= 0 && exprlen == 3 && had_stack_value &&
+			    expr[1].atom == DW_OP_plus_uconst) {
+				if (expr[1].number > INT64_MAX ||
+				    reg_offset > INT64_MAX - (int64_t)expr[1].number)
+					continue;
+				parameter__record_loc_reg(parm, DW_OP_reg0 + base_reg,
+						  reg_offset + (int64_t)expr[1].number,
+						  false, parameter__loc_size(parm, cu));
+				continue;
+			}
+		}
+
 		if (exprlen == 2 && had_stack_value)
 			exprlen--;
 
 		if (exprlen != 1) {
+			/* Pieces are handled below; other compound expressions are not. */
+			if (exprlen == 2 && (expr[1].atom == DW_OP_deref || expr[1].atom == DW_OP_deref_size)) {
+				/* Do not let parameter__multi_exprs misencode this as a register. */
+				continue;
+			}
+			if (exprlen == 2 && expr[1].atom == DW_OP_plus_uconst)
+				continue;
+
 			parameter__multi_exprs(expr, loc_num, cu, exprlen, parm);
 			continue;
 		}
@@ -1983,14 +2045,22 @@ static void parameter__decode_location(Dwarf_Attribute *attr, struct conf_load *
 		size = parameter__loc_size(parm, cu);
 		switch (expr->atom) {
 		case DW_OP_reg0 ... DW_OP_reg31:
-			if (loc_num == 0)
-				parameter__record_loc_reg(parm, expr->atom, 0, false, size);
+		case DW_OP_regx: {
+			int reg = dwarf_op__regno(expr);
+
+			if (loc_num == 0 && reg >= 0)
+				parameter__record_loc_reg(parm, DW_OP_reg0 + reg, 0, false, size);
 			break;
+		}
 		case DW_OP_breg0 ... DW_OP_breg31:
-			if (loc_num == 0 && had_stack_value)
-				parameter__record_loc_reg(parm, expr->atom - DW_OP_breg0 + DW_OP_reg0,
-							  dwarf_op__snumber(expr), false, size);
+		case DW_OP_bregx: {
+			int breg = dwarf_op__bregno(expr);
+
+			if (loc_num == 0 && had_stack_value && breg >= 0)
+				parameter__record_loc_reg(parm, DW_OP_reg0 + breg,
+						  dwarf_op__breg_offset(expr), false, size);
 			break;
+		}
 		case DW_OP_fbreg:
 			if (loc_num == 0) {
 				int64_t loc_offset = dwarf_op__snumber(expr);
@@ -2005,24 +2075,54 @@ static void parameter__decode_location(Dwarf_Attribute *attr, struct conf_load *
 		case DW_OP_lit0 ... DW_OP_lit31:
 			if (loc_num == 0)
 				parameter__record_loc_const(parm, expr->atom - DW_OP_lit0,
-							    dwarf_op__const_size(expr->atom), false, false);
+							    size, false, false);
 			break;
 		case DW_OP_const1u ... DW_OP_consts:
 			if (loc_num == 0)
 				parameter__record_loc_const(parm, dwarf_op__const_value(expr),
-							    dwarf_op__const_size(expr->atom),
+							    size,
 							    dwarf_op__const_signed(expr->atom), false);
 			break;
 		case DW_OP_addr:
 			if (loc_num == 0)
 				parameter__record_loc_const(parm, expr->number, cu->addr_size, false, true);
 			break;
+		case DW_OP_implicit_value: {
+			Dwarf_Block value;
+
+			if (loc_num == 0 && dwarf_getlocation_implicit_value(attr, expr, &value) == 0 &&
+			    value.length > 0 && value.length <= sizeof(uint64_t)) {
+				uint64_t scalar = 0;
+				const uint8_t *bytes = value.data;
+				size_t i;
+
+				for (i = 0; i < value.length; i++) {
+					unsigned int shift = cu->little_endian ? i : value.length - 1 - i;
+
+					scalar |= (uint64_t)bytes[i] << (shift * 8);
+				}
+				parameter__record_loc_const(parm, scalar, value.length, false, false);
+			}
+			break;
+		}
 		case DW_OP_entry_value:
 		case DW_OP_GNU_entry_value:
 			if (dwarf_getlocation_attr(attr, expr, &entry_attr) == 0 &&
-			    dwarf_getlocation(&entry_attr, &entry_ops, &entry_len) == 0 &&
-			    entry_len == 1 && dwarf_op__is_reg(entry_ops->atom))
-				parameter__record_loc_reg(parm, entry_ops->atom, 0, false, size);
+			    dwarf_getlocation(&entry_attr, &entry_ops, &entry_len) == 0) {
+				int entry_breg = entry_len ? dwarf_op__bregno(entry_ops) : -1;
+
+				if (entry_len == 1 && dwarf_op__is_reg(entry_ops->atom)) {
+					int entry_reg = dwarf_op__regno(entry_ops);
+
+					if (entry_reg >= 0)
+						parameter__record_loc_reg(parm, DW_OP_reg0 + entry_reg,
+								  0, false, size);
+				}
+				else if (entry_len == 2 && entry_breg >= 0 &&
+					 entry_ops[1].atom == DW_OP_stack_value)
+					parameter__record_loc_reg(parm, DW_OP_reg0 + entry_breg,
+							  dwarf_op__breg_offset(entry_ops), false, size);
+			}
 			break;
 		}
 	}
@@ -2189,6 +2289,16 @@ static struct inline_expansion *inline_expansion__new(Dwarf_Die *die, struct cu
 					exp->ip.addr = start;
 			}
 		}
+
+		/* DWFL accounts for ET_REL relocations and identifies the actual
+		 * executable section, unlike a raw DWARF address comparison.
+		 */
+		Dwarf_Addr section_addr = exp->ip.addr, bias;
+		Elf_Scn *section = dwfl_module_address_section(cu->dwfl, &section_addr, &bias);
+		if (section != NULL) {
+			exp->section_idx = elf_ndxscn(section);
+			exp->section_offset = section_addr;
+		}
 	}
 out:
 	return exp;
diff --git a/dwarves.h b/dwarves.h
index 1fc594f..8ab336f 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -46,6 +46,13 @@ enum load_steal_kind {
 	LSK__ABORT,
 };
 
+/* For older libbpf may need to define BTF loc data. */
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
@@ -846,8 +861,10 @@ struct inline_expansion {
 	const char	 *name;
 	size_t		 size;
 	uint64_t	 high_pc;
+	uint64_t	 section_offset;
 	struct list_head parms;
 	struct function	 *function;
+	uint32_t	 section_idx;
 	uint16_t	 nr_parms;
 };
 
diff --git a/pahole.c b/pahole.c
index a1b3d4a..f134da2 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1218,6 +1218,13 @@ static bool layout_check(void)
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
@@ -1245,6 +1252,7 @@ struct btf_feature {
 				      attributes_check),
 	BTF_NON_DEFAULT_FEATURE(true_signature, true_signature, false),
 	BTF_NON_DEFAULT_FEATURE_CHECK(layout, btf_gen_layout, false, layout_check),
+	BTF_NON_DEFAULT_FEATURE_CHECK(inline, btf_gen_inlines, false, location_check),
 	BTF_NON_DEFAULT_FEATURE(force_cu_merging, force_cu_merging, false),
 };
 
@@ -3750,6 +3758,10 @@ try_sole_arg_as_class_names:
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

