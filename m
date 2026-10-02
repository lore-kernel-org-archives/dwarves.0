Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ECF42BC5E;
	Fri,  2 Oct 2026 17:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962890; cv=none; b=tubfeGpQdfS144cJPg9R5fw21N1CKw0LXvFwxLI9kAX61HGdkxJRLq4e3UOxsuqZrtpPsKb2xZml2irHvMb1bqVWWtSpMejYbajB9RN/99QU50Q+ZUZ6YcVqEfR99rPUgKlzIfeGnacakvR/94TSEMg4mf25puqxAx5j8wvQ0iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962890; c=relaxed/simple;
	bh=O/RbTeD7IVwYi0RMaEMVO/kOK8CiVf6E61aDuI+7JSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJjqX58wB9SIUHm7SR0/ZyvdGBllEIUXkmD30GmhDOa8ZhQeWKRmJbOX5BmJUhPhKxuOPJuHcqB2EOaTx3GaUJfNH53qPS7zJ5dgvMNL3xfHjlUwZzdEBeAAXLzjwd11tfP9szGXSKM+9qqCsYqIxnE2NIbU5oMo4eKbidvYyVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MLXYr4r8; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MLXYr4r8"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692Ebf0A3287852;
	Fri, 2 Oct 2026 17:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=bMVmA
	axYvN1e9V25/jekZuTLKFGtceappJjQIZ+bQYc=; b=MLXYr4r8DsapYajYfZ9mg
	TLUVWZbKVFitIcQp2S3T0+AoujAfrmoranrTXUieM5sR9fH65FJipdW87fAm4oKl
	yjESyeHGus98JtRoMJwo6Zrl5U8WITp1VeQs/WavPb7cvvYIwKyS6xJb9TYawZjb
	RORXHXzrj1WTrwNYfiW+q5H6C4ichMlKLXZFnXmYyw0M9CPH2mRdTRbVlFK0RQzn
	Ej1KGIbM5eLD+4Mf1yNpYMaSQVjm1REKVyILb2YIQAsFx+lsuumm3kM0Ip/Cdynh
	4aMJzeZYDAAFfGfBl4Ad8nlHwuvpYEVFHuKCcsIFVAN7Zd0cJD8Q951zRwR+iPyW
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx5ns4bxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Oct 2026 17:40:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 692HZUWB014568;
	Fri, 2 Oct 2026 17:40:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gtqtq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Oct 2026 17:40:52 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 692HekeR030471;
	Fri, 2 Oct 2026 17:40:52 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-83-232.vpn.oracle.com [10.154.83.232])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gx4gtqtes-3;
	Fri, 02 Oct 2026 17:40:52 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        jolsa@kernel.org, qmo@kernel.org
Cc: dwarves@vger.kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 dwarves 02/10] dwarf_loader: Recode inline expansion parameter types
Date: Fri,  2 Oct 2026 18:40:30 +0100
Message-ID: <20261002174043.3823987-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20261002174043.3823987-1-alan.maguire@oracle.com>
References: <20261002174043.3823987-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_05,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610020070
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA3MCBTYWx0ZWRfX8e3966mx3PaI
 uLt6wKS535XBGQDDaWBOFpX0tsDopgH8MZVhAFJ4RG9HHeUle3j4sYx94kuOlUhIp8vOv+KihMB
 CJsbVhEEmH3j84BQi0tp/2pX/lljug6sy4rOML4vDUIdw+pKQWNtZtd9i3FG5v1eZlL6Tey2e24
 2ZbPGgYzL1IhSltgCD4T8PJpFyQ4IJpR/+iyTKRYx+qlXx3vdTiuUXQvPVl1G9m5uRG6JE5Evah
 0Mo4/GNn0WQ1um7HE0anW+FQh2BwGTgfhzDoA3hd67iwiFhlfGLCiM1M7IszbkfDOzTKsBkvCJk
 qij3IqRP2KzKuyphanzkBgq9jnnhnQVs0Kye+2EHvR3yBpOeAsA+H7V0qp4cC1SIhBEMEyGEDry
 dDDgAm1pCmWF7Nu6GS0VnwJUapLZmtoe3YiXpu4ziLRv7rrRSMbyNGjnl0eu004nI8tTCy+NrUL
 8XIoc5qM4mS/80df5xltNGzND8kvgYdQyq/f6upc=
X-Proofpoint-GUID: dhQwhIqGiaaYr59_rKly1110VSOgwOcg
X-Authority-Analysis: v=2.4 cv=T8QZ3PKQ c=1 sm=1 tr=0 ts=6abfeca5 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=yPCof4ZbAAAA:8
 a=8L3yy0N4ggwNkzCJqoMA:9 a=gKebqoRLp9LExxC7YDUY:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13537
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA3MCBTYWx0ZWRfX32H/YRwB8K+W
 qE3by1wgPegiRt1+DEAwSFCMlMcOK97S9qr5ekH+2czpRxsyQyKRkDpU++TRHQmGEEQeYUmqDws
 2JvfO7g6XhyrktaYa8ut6hbIf/TuQhPSDi501nYtk4ZslQUe93uv
X-Proofpoint-ORIG-GUID: dhQwhIqGiaaYr59_rKly1110VSOgwOcg

Factor parameter DWARF type recoding out of function prototype
recoding, and apply it to parameters stored on inline expansions.

An inline expansion can omit parameter DIEs. When resolving a remaining
parameter through its abstract origin, use the origin parameter index
rather than its position in the compacted inline parameter list. This
keeps location data associated with the correct function argument.

Also centralize inline-expansion type recoding for lexical-block and
top-level traversal.

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Thierry Treyer <ttreyer@meta.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 dwarf_loader.c | 180 ++++++++++++++++++++++++++-----------------------
 1 file changed, 95 insertions(+), 85 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index c08d2ab..0e74d2b 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3568,75 +3568,107 @@ static void __tag__print_abstract_origin_not_found(struct tag *tag,
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
+					 struct ftype *ftype)
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
+		if (ftype != NULL) {
+			if (parm->idx != oparm->idx)
+				ftype->reordered_parm = 1;
+		} else {
+			parm->idx = oparm->idx;
+		}
+		parm->tag.type = dtag__tag(dtype)->type;
+		if (ftype != NULL)
+			parameter__share_state_with_abstract_origin(parm, oparm);
+		return;
 	}
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
+	}
+
+	ftype__recode_dwarf_types(dtag__tag(dtype), cu);
+	list_for_each_entry(pos, &tag__inline_expansion(tag)->parms, node)
+		parameter__recode_dwarf_type(tag__parameter(pos), cu, NULL);
+	tag->type = dtype->small_id;
 }
 
 static struct parameter *ftype__next_parameter(struct ftype *ftype, struct parameter *parm)
@@ -3891,23 +3923,7 @@ static void lexblock__recode_dwarf_types(struct lexblock *tag, struct cu *cu)
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
@@ -4087,15 +4103,9 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
 
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
-- 
2.43.5

