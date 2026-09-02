Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8EB47605E;
	Wed,  2 Sep 2026 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349149; cv=none; b=tO1N5l6fztHiFxjD9UCuKa1nFSv8+5EWituNwuV8bP3XlTlxOHSWheYqUndABouExWkMQzavgRRYyTjWo6lM/hrM6uTs1itCyZTXcHFx76LmXj7IMS84sJ1dmtc6NJnm4qqToEZVEouWns75X2cpdwz3UeMPdoFaHDDFDvkt2Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349149; c=relaxed/simple;
	bh=qKdQtP6+pbCdf3GvqN0uNaZwhi2O68TRRMi/VhzOoxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z3UEwao0O/fWx0MpKqLyLxeaXUPH1IgPWzcppNHqQ51Xeju/+9NKMVqLrGLe6Sb6D+5VEPUdAYLg5Iuc35ulf8hL2T6LcWuZCPOoY/GYKQagaUsrpPOEfSAri5RmLem3iZ+nxAedsTBUNPd8FJqRkkCHOw1WmH7IOqL54JwYXRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z85IAMpC; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z85IAMpC"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681KlpDm4036321;
	Wed, 2 Sep 2026 11:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yPWl+nw4pZ+CLYz7pZudnsTWSJFXBG2j11k0TDz6LYw=; b=
	Z85IAMpCDji67pa2ti8SY15d+UUn/OP8T0tugJxmd46q0MMBbn2ISIkC5vgkWMAD
	GVTuQRt5O62Mk44/tMaNtVsnzdBFouMyGwuqsIZQYCH78iyfNsOG5w1T2dj+HlMX
	QZaTa0vOzYjWod74hsz5TVMvRwBxyLlrRlXHOBIehmYuQHcvNEOIs+6lf9nctMLb
	XktygDBurN5y5x0ABbtPEc7KBXtAxXMPXUY18Cjl0Fbulrpopp3XmI6FaJu/NOL8
	stnopiJRFjRlYfjoMGj6rgd9uhIPSh8ZTW+a9jsFDNxrWyv3dLIiBHoTxfpW9257
	7Ic68yIY+vDmp1zG5t7RBA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbp0xxmrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Sep 2026 11:38:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 682BaXCs029328;
	Wed, 2 Sep 2026 11:38:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvrnt59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Sep 2026 11:38:37 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 682BcYma038508;
	Wed, 2 Sep 2026 11:38:36 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-253.vpn.oracle.com [10.154.52.253])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gbnvrnt37-2;
	Wed, 02 Sep 2026 11:38:36 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, eddyz87@gmail.com, jolsa@kernel.org,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, bpf@vger.kernel.org, dwarves@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 1/6] dwarf_loader: Add parameter list to inlined expansions
Date: Wed,  2 Sep 2026 12:38:21 +0100
Message-ID: <20260902113829.1285407-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260902113829.1285407-1-alan.maguire@oracle.com>
References: <20260902113829.1285407-1-alan.maguire@oracle.com>
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
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2609020103
X-Proofpoint-ORIG-GUID: 4Y_XcDLTE-3Z0u1XmFGyay-Eq8fGWjJY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEwMyBTYWx0ZWRfXwf8thbe2g5DQ
 XSiq+Gtk6wzABvPuhi55ZeoP/LuKMcCe7TbP4+ScAAA4xWuBUCzVZlUNpNeTgcaXALZEIwzX7eV
 BaOlGi2I3b7oIPic51uPrYwrYh1L1ZHYkpm/AXf2HbtieS88ibWf9hiMfQw0mNVM33XYr4Y5lwk
 LlhoiFHPxSkBhSKRt6C3MlX3Nu7hUWCGYeKaBMp0YJBkMbmyLNHRDne7BwXDJbgQpPIo2vIogmv
 xLGcPAOCjhoH+tWQj5OfNc5NtZalJ6iJf20w/cyzZkQg8QPE1xTfv8sXjth6sj4+kdoi/vndK8R
 WoClgayccq1xNWnbK+LhUEPDwlVVMgvwMgIsXgGi0dfEZPu36agjB1ejMuma+OTpmIrOnLiHP3t
 eaSYoEpYbzdqtFKNPMvfnKOquJRKd7TYRlEFr0qeIxXavtifHl3KVQBcdgERuXjhkE3Fb5qyXea
 RIDdvR96LNpsljmcllPiRbT4MeeHVu+kmwcczF/k=
X-Authority-Analysis: v=2.4 cv=Ebb4hvmC c=1 sm=1 tr=0 ts=6a980abe b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=VabnemYjAAAA:8
 a=yPCof4ZbAAAA:8 a=bYZpwwQ-aSMTa5BTlKQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=gKebqoRLp9LExxC7YDUY:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12102
X-Proofpoint-GUID: 4Y_XcDLTE-3Z0u1XmFGyay-Eq8fGWjJY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEwMyBTYWx0ZWRfX2PXXhg6upby4
 mUbcxNLndE3UNy3W3EOFsuPzZJ5jBJxBDM+pb7e1v34cRqY8MOYFD+fmr94BzJJj86rzJrqglVK
 cBO6Z9DHKT/wp3t03G7HOJzM/QdZKH3W0dezwcaiOO8A0pvvTwP6

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
 dwarf_loader.c | 210 ++++++++++++++++++++++++++-----------------------
 dwarves.c      |  34 ++++++++
 dwarves.h      |   6 ++
 3 files changed, 152 insertions(+), 98 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 61ef52f..6805305 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2005,6 +2005,8 @@ static struct inline_expansion *inline_expansion__new(Dwarf_Die *die, struct cu
 		dwarf_tag__set_attr_type(dtag, DWARF_TAG__REF_TYPE, die, DW_AT_abstract_origin, cu);
 		exp->ip.addr = 0;
 		exp->high_pc = 0;
+		exp->nr_parms = 0;
+		INIT_LIST_HEAD(&exp->parms);
 
 		if (!cu->has_addr_info)
 			goto out;
@@ -2542,6 +2544,7 @@ static struct tag *die__create_new_string_type(Dwarf_Die *die, struct cu *cu)
 static struct tag *die__create_new_parameter(Dwarf_Die *die,
 					     struct ftype *ftype,
 					     struct lexblock *lexblock,
+					     struct inline_expansion *exp,
 					     struct cu *cu, struct conf_load *conf,
 					     int param_idx)
 {
@@ -2558,7 +2561,7 @@ static struct tag *die__create_new_parameter(Dwarf_Die *die,
 			if (add_gnu_annotation_chain(die, param_idx, conf, &(tag__function(&ftype->tag)->annots)))
 				return NULL;
 		}
-	} else {
+	} else if (exp == NULL) {
 		/*
 		 * DW_TAG_formal_parameters on a non DW_TAG_subprogram nor
 		 * DW_TAG_subroutine_type tag happens sometimes, likely due to
@@ -2570,6 +2573,7 @@ static struct tag *die__create_new_parameter(Dwarf_Die *die,
 		*/
 		lexblock__add_tag(lexblock, &parm->tag);
 	}
+	/* Inline-expansion parameters are linked after CU-table registration. */
 
 	return &parm->tag;
 }
@@ -2639,7 +2643,7 @@ static struct tag *die__create_new_subroutine_type(Dwarf_Die *die,
 			tag__print_not_supported(die);
 			continue;
 		case DW_TAG_formal_parameter:
-			tag = die__create_new_parameter(die, ftype, NULL, cu, conf, -1);
+			tag = die__create_new_parameter(die, ftype, NULL, NULL, cu, conf, -1);
 			break;
 		case DW_TAG_unspecified_parameters:
 			ftype->unspec_parms = 1;
@@ -2929,10 +2933,14 @@ static struct tag *die__create_new_inline_expansion(Dwarf_Die *die,
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
@@ -2940,6 +2948,7 @@ static int die__process_inline_expansion(Dwarf_Die *die, struct lexblock *lexblo
 	die = &child;
 	do {
 		uint32_t id;
+		bool add_to_inline_expansion = false;
 
 		switch (dwarf_tag(die)) {
 		case DW_TAG_call_site:
@@ -2958,13 +2967,10 @@ static int die__process_inline_expansion(Dwarf_Die *die, struct lexblock *lexblo
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
@@ -2993,6 +2999,8 @@ static int die__process_inline_expansion(Dwarf_Die *die, struct lexblock *lexblo
 
 		if (cu__table_add_tag(cu, tag, &id) < 0)
 			goto out_delete_tag;
+		if (add_to_inline_expansion)
+			inline_expansion__add_parameter(exp, tag__parameter(tag));
 hash:
 		cu__hash(cu, tag);
 		struct dwarf_tag *dtag = tag__dwarf(tag);
@@ -3015,8 +3023,8 @@ static struct tag *die__create_new_inline_expansion(Dwarf_Die *die,
 	if (exp == NULL)
 		return NULL;
 
-	if (die__process_inline_expansion(die, lexblock, cu, conf) != 0) {
-		tag__free(&exp->ip.tag, cu);
+	if (die__process_inline_expansion(die, exp, lexblock, cu, conf) != 0) {
+		tag__delete(&exp->ip.tag, cu);
 		return NULL;
 	}
 
@@ -3098,7 +3106,7 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
 			continue;
 		}
 		case DW_TAG_formal_parameter:
-			tag = die__create_new_parameter(die, ftype, lexblock, cu, conf, param_idx++);
+			tag = die__create_new_parameter(die, ftype, lexblock, NULL, cu, conf, param_idx++);
 			break;
 		case DW_TAG_variable:
 			tag = die__create_new_variable(die, cu, conf, 0);
@@ -3545,75 +3553,103 @@ static void __tag__print_abstract_origin_not_found(struct tag *tag,
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
@@ -3820,23 +3856,7 @@ static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu)
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
@@ -4016,15 +4036,9 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
 
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
index df77f1e..b25ec76 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -824,6 +824,8 @@ struct inline_expansion {
 	struct ip_tag	 ip;
 	size_t		 size;
 	uint64_t	 high_pc;
+	struct list_head parms;
+	uint16_t	 nr_parms;
 };
 
 static inline struct inline_expansion *
@@ -832,6 +834,10 @@ static inline struct inline_expansion *
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

