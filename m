Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0260443BDDA;
	Fri, 25 Sep 2026 18:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362378; cv=none; b=WGxE/Z7/HG25nooetmg8iUoTfzZp1wSMAIX33jkbBAcc1ZDvI+3ALj/t1JPxFbudEfHY0agnrhY2g2+DmInoA+5IWEUJI+pzOuJVs0FCIisMCBQK9lp0D3USEElDqrE7EFJ2RB3RdFiEKvsWnG0ZuEYECyj4VKFzjwjpuP365YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362378; c=relaxed/simple;
	bh=qC4hXZskC3mFckrNDCfpsOgI18zqOm++nRZffD+6OmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iXif7FWBhqAPd9PDkLOmJEoHnLO6Ya5jEsEwpnVIsqI6LGQtOWipYz7X3jh6vuSSIL4IRHhShqu5em2mDmjzL/GQFZcV2g/yxM7nmfJTixWbcAZ2BBtoT+GXnpoxpGKP7ahqyqMrBA3ZoPB4qcsxCznrySX7rDaa18I3iU0OMUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AycHC4Lo; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AycHC4Lo"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PEBpXh3193010;
	Fri, 25 Sep 2026 18:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QEWrvaet4ywhoe6ofXk4UQMoJ0gbypixLVk8fHLWpd0=; b=
	AycHC4LockiwwC/wqXNvC7h+ncvgg/kZxEj6SODYhmcDY6S5u7hvaVjM+NgLRjrn
	04fWSHl+2ote351Wm6ltY3Wo2ns6ol9guDSOKKYsO+sFc/giEfWSwuGVjolWJxRD
	F2whowRMTRths4qEGgPtAvqKsP47GePq6C6k65hVFpkrBqkDyHeaK/IVb0TjjJtf
	1eGCFVw3FflZvZXg4B4s7L8rsvKvjMoLJf1sGjM9MNk2Zs+kcZCh4qCZxrEl8uRS
	qQvN3LKPcZ/yqgBx4B/dv4b5KcTHcLGl5mqIc48YcGhHWeiGJ7Dq89HAATBp4EjR
	3norbYfKvMM2XBRYjaNUiw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk2d9u6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:52:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68PIqBhj038578;
	Fri, 25 Sep 2026 18:52:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gteptht8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:52:31 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68PIqQog040536;
	Fri, 25 Sep 2026 18:52:31 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-81-122.vpn.oracle.com [10.154.81.122])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gtepthsyc-2;
	Fri, 25 Sep 2026 18:52:30 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        qmo@kernel.org
Cc: dwarves@vger.kernel.org, jolsa@kernel.org, daniel@iogearbox.net,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
        bpf@vger.kernel.org, nsc@kernel.org, puranjay@kernel.org,
        yatsenko@meta.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 1/9] dwarf_loader: Add parameter list to inlined expansions
Date: Fri, 25 Sep 2026 19:51:50 +0100
Message-ID: <20260925185200.1318067-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260925185200.1318067-1-alan.maguire@oracle.com>
References: <20260925185200.1318067-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609250075
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NSBTYWx0ZWRfX15wy/wHCp9Yy
 9IgjxmtfiV9QdhXc9auW5EZdvUoogxkZGogeYiSi92N7YDukNKgmbFCY4+XOhD51Nbl3ieAWWNN
 ivLc6esbhtcTY9E8lVCBYVUbD8IenK41n5s40Qgx6nQtj2k3XIQg3ae411k8Mh3iVZbw5kJx5Yq
 HZs+INiTekKL4DQhg9cCy8GXsqoPtT9ZyUzguMH73dLyFiARTgzpdbyIzrAaHneWnBauenwDsog
 hlN6y6o8zyfQCXN1Qiwmqvw69h5wPlcNILKkbJAs3/fWvdGPVB99Oln15zbtIHi8Me5GYVZQMMl
 T1/z8hSqnxZmqjO12WVy34l5yxxLm7eaWYrXnWeX1rISoA6ymtn+ga8brTnFnKzFH7scPcDfOZD
 4y6k/uU6jlHCudUj7qe1iMHmDNqBwQho0pJ5e2xGFFkS4kADByzzKvSkJNzbClfWCx+Vr+KBVTr
 KHQm7WJozveKKMRKql/RbblrOhMjdsGwJ75bO/RI=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NSBTYWx0ZWRfX4eYl3RsJ5LgP
 biz+SdvDDjLkkP/7c1lsdTNv4pGgY+SdUyK4LG9Er14khBZUcVg5tGjS17BseMpO29YR26JHJGQ
 if6BZ6NOhjocdVHL7ZRlQGzB21vQeFtJZCGXuDQuyacUZmMKLAEx
X-Proofpoint-ORIG-GUID: z5PEAoA1yTGOlCjLa4BNjJakjKNoQ_Xx
X-Authority-Analysis: v=2.4 cv=f+Ddl+yM c=1 sm=1 tr=0 ts=6ab6c2f1 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=VabnemYjAAAA:8
 a=yPCof4ZbAAAA:8 a=bYZpwwQ-aSMTa5BTlKQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=gKebqoRLp9LExxC7YDUY:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13532
X-Proofpoint-GUID: z5PEAoA1yTGOlCjLa4BNjJakjKNoQ_Xx

DW_TAG_formal_parameter children of DW_TAG_inlined_subroutine are
currently skipped, so callers cannot iterate parameters that belong to a
specific inline expansion. Store those parameters directly on struct
inline_expansion instead of leaving them in the surrounding lexical block.

Add an inline_expansion parameter list, populate it while processing
inline-subroutine children, and include it in tag cleanup and
cu__for_all_tags() traversal. Recode inline-expansion parameter types via
the same parameter recoding path used for function prototypes.

Signed-off-by: Thierry Treyer <ttreyer@meta.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 dwarf_loader.c | 211 ++++++++++++++++++++++++++-----------------------
 dwarves.c      |  34 ++++++++
 dwarves.h      |   6 ++
 3 files changed, 153 insertions(+), 98 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 1e5363a..2165621 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2022,6 +2022,8 @@ static struct inline_expansion *inline_expansion__new(Dwarf_Die *die, struct cu
 		dwarf_tag__set_attr_type(dtag, DWARF_TAG__REF_TYPE, die, DW_AT_abstract_origin, cu);
 		exp->ip.addr = 0;
 		exp->high_pc = 0;
+		exp->nr_parms = 0;
+		INIT_LIST_HEAD(&exp->parms);
 
 		if (!cu->has_addr_info)
 			goto out;
@@ -2559,6 +2561,7 @@ static struct tag *die__create_new_string_type(Dwarf_Die *die, struct cu *cu)
 static struct tag *die__create_new_parameter(Dwarf_Die *die,
 					     struct ftype *ftype,
 					     struct lexblock *lexblock,
+					     struct inline_expansion *exp,
 					     struct cu *cu, struct conf_load *conf,
 					     int param_idx)
 {
@@ -2575,7 +2578,7 @@ static struct tag *die__create_new_parameter(Dwarf_Die *die,
 			if (add_gnu_annotation_chain(die, param_idx, conf, &(tag__function(&ftype->tag)->annots)))
 				return NULL;
 		}
-	} else {
+	} else if (exp == NULL) {
 		/*
 		 * DW_TAG_formal_parameters on a non DW_TAG_subprogram nor
 		 * DW_TAG_subroutine_type tag happens sometimes, likely due to
@@ -2587,6 +2590,7 @@ static struct tag *die__create_new_parameter(Dwarf_Die *die,
 		*/
 		lexblock__add_tag(lexblock, &parm->tag);
 	}
+	/* Inline-expansion parameters are linked after CU-table registration. */
 
 	return &parm->tag;
 }
@@ -2656,7 +2660,7 @@ static struct tag *die__create_new_subroutine_type(Dwarf_Die *die,
 			tag__print_not_supported(die);
 			continue;
 		case DW_TAG_formal_parameter:
-			tag = die__create_new_parameter(die, ftype, NULL, cu, conf, -1);
+			tag = die__create_new_parameter(die, ftype, NULL, NULL, cu, conf, -1);
 			break;
 		case DW_TAG_unspecified_parameters:
 			ftype->unspec_parms = 1;
@@ -2946,10 +2950,14 @@ static struct tag *die__create_new_inline_expansion(Dwarf_Die *die,
 						    struct lexblock *lexblock,
 						    struct cu *cu, struct conf_load *conf);
 
-static int die__process_inline_expansion(Dwarf_Die *die, struct lexblock *lexblock, struct cu *cu, struct conf_load *conf)
+static int die__process_inline_expansion(Dwarf_Die *die,
+					 struct inline_expansion *exp,
+					 struct lexblock *lexblock,
+					 struct cu *cu, struct conf_load *conf)
 {
 	Dwarf_Die child;
 	struct tag *tag;
+	int parm_idx = 0;
 
 	if (!dwarf_haschildren(die) || dwarf_child(die, &child) != 0)
 		return 0;
@@ -2957,6 +2965,7 @@ static int die__process_inline_expansion(Dwarf_Die *die, struct lexblock *lexblo
 	die = &child;
 	do {
 		uint32_t id;
+		bool add_to_inline_expansion = false;
 
 		switch (dwarf_tag(die)) {
 		case DW_TAG_call_site:
@@ -2975,13 +2984,10 @@ static int die__process_inline_expansion(Dwarf_Die *die, struct lexblock *lexblo
 				goto out_enomem;
 			continue;
 		case DW_TAG_formal_parameter:
-			/*
-			 * Inline expansions can have their own formal
-			 * parameter children duplicating the abstract
-			 * origin's parameters.  These are not needed
-			 * for type reconstruction — skip them.
-			 */
-			continue;
+			tag = die__create_new_parameter(die, NULL, lexblock, exp,
+							cu, conf, parm_idx++);
+			add_to_inline_expansion = true;
+			break;
 		case DW_TAG_inlined_subroutine:
 			tag = die__create_new_inline_expansion(die, lexblock, cu, conf);
 			break;
@@ -3010,6 +3016,8 @@ static int die__process_inline_expansion(Dwarf_Die *die, struct lexblock *lexblo
 
 		if (cu__table_add_tag(cu, tag, &id) < 0)
 			goto out_delete_tag;
+		if (add_to_inline_expansion)
+			inline_expansion__add_parameter(exp, tag__parameter(tag));
 hash:
 		cu__hash(cu, tag);
 		struct dwarf_tag *dtag = tag__dwarf(tag);
@@ -3032,8 +3040,8 @@ static struct tag *die__create_new_inline_expansion(Dwarf_Die *die,
 	if (exp == NULL)
 		return NULL;
 
-	if (die__process_inline_expansion(die, lexblock, cu, conf) != 0) {
-		tag__free(&exp->ip.tag, cu);
+	if (die__process_inline_expansion(die, exp, lexblock, cu, conf) != 0) {
+		tag__delete(&exp->ip.tag, cu);
 		return NULL;
 	}
 
@@ -3115,7 +3123,8 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
 			continue;
 		}
 		case DW_TAG_formal_parameter:
-			tag = die__create_new_parameter(die, ftype, lexblock, cu, conf, param_idx++);
+			tag = die__create_new_parameter(die, ftype, lexblock, NULL,
+							cu, conf, param_idx++);
 			break;
 		case DW_TAG_variable:
 			tag = die__create_new_variable(die, cu, conf, 0);
@@ -3562,75 +3571,103 @@ static void __tag__print_abstract_origin_not_found(struct tag *tag,
 #define tag__print_abstract_origin_not_found(tag) \
 	__tag__print_abstract_origin_not_found(tag, __func__, __LINE__)
 
-static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu)
+static void parameter__share_state_with_abstract_origin(struct parameter *parm,
+							struct parameter *oparm)
+{
+	if (parm->has_loc)
+		oparm->has_loc = parm->has_loc;
+	if (parm->has_const_value)
+		oparm->has_const_value = parm->has_const_value;
+	if (parm->loc_const_value)
+		oparm->loc_const_value = parm->loc_const_value;
+	if (parm->loc_stack)
+		oparm->loc_stack = parm->loc_stack;
+	if (parm->loc_reg != PARAMETER_UNKNOWN_REG)
+		oparm->loc_reg = parm->loc_reg;
+	if (parm->type_byte_size != 0)
+		oparm->type_byte_size = parm->type_byte_size;
+	if (parm->passed_in_memory)
+		oparm->passed_in_memory = parm->passed_in_memory;
+	oparm->first_reg_fields |= parm->first_reg_fields;
+	oparm->second_reg_fields |= parm->second_reg_fields;
+	if (parm->true_sig_member_name && !oparm->true_sig_member_name) {
+		oparm->true_sig_member_name = parm->true_sig_member_name;
+		oparm->true_sig_type = parm->true_sig_type;
+		oparm->true_sig_type_from_types = parm->true_sig_type_from_types;
+	}
+	if (parm->optimized)
+		oparm->optimized = parm->optimized;
+	if (parm->unexpected_reg)
+		oparm->unexpected_reg = parm->unexpected_reg;
+}
+
+static void parameter__recode_dwarf_type(struct parameter *parm, struct cu *cu,
+						 struct ftype *ftype)
 {
-	struct parameter *pos;
 	struct dwarf_cu *dcu = cu->priv;
-	struct ftype *type = tag__ftype(tag);
-
-	ftype__for_each_parameter(type, pos) {
-		struct dwarf_tag *dpos = tag__dwarf(&pos->tag);
-		struct parameter *opos;
-		struct dwarf_tag *dtype;
+	struct dwarf_tag *dparm = tag__dwarf(&parm->tag);
+	struct dwarf_tag *dtype;
 
-		if (dpos->type == 0) {
-			if (dpos->abstract_origin == 0) {
-				/* Function without parameters */
-				pos->tag.type = 0;
-				continue;
-			}
-			dtype = dwarf_cu__find_tag_by_ref(dcu, dpos, abstract_origin);
-			if (dtype == NULL) {
-				tag__print_abstract_origin_not_found(&pos->tag);
-				continue;
-			}
-			opos = tag__parameter(dtag__tag(dtype));
-			pos->name = opos->name;
-			if (pos->idx != opos->idx)
-				type->reordered_parm = 1;
-			pos->tag.type = dtag__tag(dtype)->type;
-			/* share location information between parameter and
-			 * abstract origin; if neither have location, we will
-			 * mark the parameter as optimized out.  Also share
-			 * info regarding unexpected register use for
-			 * parameters.
-			 */
-			if (pos->has_loc)
-				opos->has_loc = pos->has_loc;
-			if (pos->has_const_value)
-				opos->has_const_value = pos->has_const_value;
-			if (pos->loc_const_value)
-				opos->loc_const_value = pos->loc_const_value;
-			if (pos->loc_stack)
-				opos->loc_stack = pos->loc_stack;
-			if (pos->loc_reg != PARAMETER_UNKNOWN_REG)
-				opos->loc_reg = pos->loc_reg;
-			if (pos->type_byte_size != 0)
-				opos->type_byte_size = pos->type_byte_size;
-			if (pos->passed_in_memory)
-				opos->passed_in_memory = pos->passed_in_memory;
-			opos->first_reg_fields |= pos->first_reg_fields;
-			opos->second_reg_fields |= pos->second_reg_fields;
-			if (pos->true_sig_member_name && !opos->true_sig_member_name) {
-				opos->true_sig_member_name = pos->true_sig_member_name;
-				opos->true_sig_type = pos->true_sig_type;
-				opos->true_sig_type_from_types = pos->true_sig_type_from_types;
-			}
+	if (dparm->type == 0) {
+		struct parameter *oparm;
 
-			if (pos->optimized)
-				opos->optimized = pos->optimized;
-			if (pos->unexpected_reg)
-				opos->unexpected_reg = pos->unexpected_reg;
-			continue;
+		if (dparm->abstract_origin == 0) {
+			parm->tag.type = 0;
+			return;
 		}
 
-		dtype = dwarf_cu__find_type_by_ref(dcu, dpos, type);
+		dtype = dwarf_cu__find_tag_by_ref(dcu, dparm, abstract_origin);
 		if (dtype == NULL) {
-			tag__print_type_not_found(&pos->tag);
-			continue;
+			tag__print_abstract_origin_not_found(&parm->tag);
+			return;
 		}
-		pos->tag.type = dtype->small_id;
+
+		oparm = tag__parameter(dtag__tag(dtype));
+		parm->name = oparm->name;
+		if (ftype != NULL && parm->idx != oparm->idx)
+			ftype->reordered_parm = 1;
+		parm->tag.type = dtag__tag(dtype)->type;
+		if (ftype != NULL)
+			parameter__share_state_with_abstract_origin(parm, oparm);
+		return;
+	}
+
+	dtype = dwarf_cu__find_type_by_ref(dcu, dparm, type);
+	if (dtype == NULL) {
+		tag__print_type_not_found(&parm->tag);
+		return;
+	}
+	parm->tag.type = dtype->small_id;
+}
+
+static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu)
+{
+	struct ftype *type = tag__ftype(tag);
+	struct parameter *pos;
+
+	ftype__for_each_parameter(type, pos)
+		parameter__recode_dwarf_type(pos, cu, type);
+}
+
+static void inline_expansion__recode_dwarf_types(struct tag *tag, struct cu *cu)
+{
+	struct dwarf_cu *dcu = cu->priv;
+	struct dwarf_tag *dtag = tag__dwarf(tag);
+	struct dwarf_tag *dtype;
+	struct tag *pos;
+
+	/* The inline expansion's abstract origin is stored as its type ref. */
+	dtype = dwarf_cu__find_tag_by_ref(dcu, dtag, type);
+	if (dtype == NULL) {
+		tag__print_type_not_found(tag);
+		tag__check_pruned_alt_ref(dcu, dtag->type, dtag->from_alt.type);
+		return;
 	}
+
+	ftype__recode_dwarf_types(dtag__tag(dtype), cu);
+	list_for_each_entry(pos, &tag__inline_expansion(tag)->parms, node)
+		parameter__recode_dwarf_type(tag__parameter(pos), cu, NULL);
+	tag->type = dtype->small_id;
 }
 
 static struct parameter *ftype__next_parameter(struct ftype *ftype, struct parameter *parm)
@@ -3885,23 +3922,7 @@ static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu)
 			lexblock__recode_dwarf_types(tag__lexblock(pos), cu);
 			continue;
 		case DW_TAG_inlined_subroutine:
-			if (dpos->type != 0)
-				dtype = dwarf_cu__find_tag_by_ref(dcu, dpos, type);
-			else
-				dtype = dwarf_cu__find_tag_by_ref(dcu, dpos, abstract_origin);
-			if (dtype == NULL) {
-				if (dpos->type != 0) {
-					tag__print_type_not_found(pos);
-					tag__check_pruned_alt_ref(dcu, dpos->type,
-								  dpos->from_alt.type);
-				} else {
-					tag__print_abstract_origin_not_found(pos);
-					tag__check_pruned_alt_ref(dcu, dpos->abstract_origin,
-								  dpos->from_alt.abstract_origin);
-				}
-				continue;
-			}
-			ftype__recode_dwarf_types(dtag__tag(dtype), cu);
+			inline_expansion__recode_dwarf_types(pos, cu);
 			continue;
 
 		case DW_TAG_formal_parameter:
@@ -4081,15 +4102,9 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
 
 	case DW_TAG_namespace:
 		return namespace__recode_dwarf_types(tag, cu);
-	/*
-	 * DW_TAG_inlined_subroutine uses DW_AT_abstract_origin to
-	 * reference the out-of-line subprogram.  inline_expansion__new()
-	 * stores this in dtag->type (not dtag->abstract_origin) via
-	 * dwarf_tag__set_attr_type() with DW_AT_abstract_origin.
-	 * For dwz binaries, the target subprogram lives in the alt file,
-	 * so dtag->from_alt.type drives the lookup to dcu->alt->hash_tags.
-	 */
 	case DW_TAG_inlined_subroutine:
+		inline_expansion__recode_dwarf_types(tag, cu);
+		return 0;
 	case DW_TAG_imported_module:
 		dtype = dwarf_cu__find_tag_by_ref(cu->priv, dtag, type);
 		goto check_type;
diff --git a/dwarves.c b/dwarves.c
index 2164030..2bb5c18 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -203,6 +203,27 @@ void formal_parameter_pack__delete(struct formal_parameter_pack *pack, struct cu
 	cu__tag_free(cu, &pack->tag);
 }
 
+static void inline_expansion__delete_tags(struct inline_expansion *exp,
+					  struct cu *cu)
+{
+	struct tag *pos, *n;
+
+	list_for_each_entry_safe_reverse(pos, n, &exp->parms, node) {
+		list_del_init(&pos->node);
+		tag__delete(pos, cu);
+	}
+}
+
+static void inline_expansion__delete(struct inline_expansion *exp,
+				     struct cu *cu)
+{
+	if (exp == NULL)
+		return;
+
+	inline_expansion__delete_tags(exp, cu);
+	cu__tag_free(cu, &exp->ip.tag);
+}
+
 void tag__delete(struct tag *tag, struct cu *cu)
 {
 	if (tag == NULL)
@@ -225,6 +246,8 @@ void tag__delete(struct tag *tag, struct cu *cu)
 		ftype__delete(tag__ftype(tag), cu);		break;
 	case DW_TAG_subprogram:
 		function__delete(tag__function(tag), cu); break;
+	case DW_TAG_inlined_subroutine:
+		inline_expansion__delete(tag__inline_expansion(tag), cu); break;
 	case DW_TAG_lexical_block:
 		lexblock__delete(tag__lexblock(tag), cu); break;
 	case DW_TAG_GNU_template_parameter_pack:
@@ -1476,6 +1499,13 @@ void lexblock__add_tag(struct lexblock *block, struct tag *tag)
 	list_add_tail(&tag->node, &block->tags);
 }
 
+void inline_expansion__add_parameter(struct inline_expansion *exp,
+				     struct parameter *parm)
+{
+	++exp->nr_parms;
+	list_add_tail(&parm->tag.node, &exp->parms);
+}
+
 void lexblock__add_inline_expansion(struct lexblock *block,
 				    struct inline_expansion *exp)
 {
@@ -2059,6 +2089,10 @@ static int list__for_all_tags(struct list_head *list, struct cu *cu,
 			if (list__for_all_tags(&tag__lexblock(pos)->tags,
 					       cu, iterator, cookie))
 				return 1;
+		} else if (pos->tag == DW_TAG_inlined_subroutine) {
+			if (list__for_all_tags(&tag__inline_expansion(pos)->parms,
+					       cu, iterator, cookie))
+				return 1;
 		}
 
 		if (iterator(pos, cu, cookie))
diff --git a/dwarves.h b/dwarves.h
index f3453ed..f620db8 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -825,6 +825,8 @@ struct inline_expansion {
 	struct ip_tag	 ip;
 	size_t		 size;
 	uint64_t	 high_pc;
+	struct list_head parms;
+	uint16_t	 nr_parms;
 };
 
 static inline struct inline_expansion *
@@ -833,6 +835,10 @@ static inline struct inline_expansion *
 	return (struct inline_expansion *)tag;
 }
 
+struct parameter;
+void inline_expansion__add_parameter(struct inline_expansion *exp,
+				     struct parameter *parm);
+
 struct label {
 	struct ip_tag	 ip;
 	const char	 *name;
-- 
2.43.5

