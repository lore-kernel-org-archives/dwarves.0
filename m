Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA98230BD5;
	Tue, 27 Jan 2026 17:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769534833; cv=none; b=ADvDB+r7hiPEKsiuyzcYkCbZ5nj1LAB4f44pxxJR0RhtlrjyKr/kin8q/VrJZgUXkjgzmTL92S9JtuVZU7Uh7eW0k8OgzAbJe0i+yL9x0qDRTAyVQnwDlmZMh2r9AjkB6OzxWkJeIIrxkMZhNR7QIBAwGjfDEqx7sfDcrNibKfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769534833; c=relaxed/simple;
	bh=QI80Fp+3+rSO8L6bU79x2sxGvpxmL0N0MDnO1gC2doY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQVFkyUyXkfL6QpJzmHtLwDUfsOLzSJ70vInR2NdKZfii5jlaSZ7gnQjUxJLk3Tlw5CV20a40wCyFIQSpg+MfcisYK1lIDt0wbAvDSDzAACTAUWGyMzxDAEf3lnILECdD1u1f743W4XQXtaB9DPk8Z/2DNj9SHT0Cac9zt0rJa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EM7SITl7; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EM7SITl7"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBETBc455096;
	Tue, 27 Jan 2026 17:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=a2TIL
	2GzJ2iAQHxqk8vH7t7/JWdR2ZcH1nNUq+B3bM4=; b=EM7SITl7Q+yRPtLv+l0hO
	CR3ut1Vk1bxWJnUoGGPhE28o51Zn8LOTwD+2eO+NA/4kxsUOgjEtggYiewjx6VNK
	2LF1jJ8on8kdR6vUQRDt+Q4O9pvixpfowvjLfmUUJAzvSQPp91ftMo0yrsFzksMG
	74dmL+Edn3NGaTyGoCTfkKUGmwgLWJMtEvfOFH5dqn9PkovheiC1femIUBM/P913
	OAbERX14Wyb3HAze7VUDzSg0/DRpijbXtU5jxqMQh6pFVfAo+QKBoK/d1Nzdh/b0
	wUUMeIl/dLxp6t/eFE8jQjF7Zp9DuWHc0lC9gL92N/0EHYRSH4XAz2BXVmjbrJYK
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvp4bvfwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 17:20:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RGhmLQ032883;
	Tue, 27 Jan 2026 17:20:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh9q7w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 17:20:48 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60RHKjSh011183;
	Tue, 27 Jan 2026 17:20:47 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-55-133.vpn.oracle.com [10.154.55.133])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4bvmh9q7sn-2;
	Tue, 27 Jan 2026 17:20:47 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: yonghong.song@linux.dev, mattbobrowski@google.com
Cc: ihor.solodrai@linux.dev, eddyz87@gmail.com, jolsa@kernel.org,
        andrii@kernel.org, ast@kernel.org, david.faust@oracle.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 1/5] dwarf_loader/btf_encoder: Detect reordered parameters
Date: Tue, 27 Jan 2026 17:20:37 +0000
Message-ID: <20260127172041.1558244-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260127172041.1558244-1-alan.maguire@oracle.com>
References: <20260127172041.1558244-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601270141
X-Proofpoint-ORIG-GUID: znANOqS9_ptT7us8ZMVbuI8yEvSpPh1i
X-Authority-Analysis: v=2.4 cv=StidKfO0 c=1 sm=1 tr=0 ts=6978f3f1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=NEAV23lmAAAA:8 a=1XWaLZrsAAAA:8 a=FzWDRUcuJ9urqeeZCLwA:9
X-Proofpoint-GUID: znANOqS9_ptT7us8ZMVbuI8yEvSpPh1i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE0MSBTYWx0ZWRfX6sjX7jdgCcAV
 G95owFUpaPvOcwHbOXWm6MrzRAJ+y6kdAlXyn7QAMXPpwaR7GFRKIcDycdEEXp8vXD55J4go1X5
 U0kh5Wd4QO2f2D8hanhiy02hB+NfAtTLSD3BdMJY9+OCCn1bd4W/MP0DXOsCxHZSYCz1rv+hO9Y
 xdNA8tZvSppJQNnw753IzFCIDLH58FDTyi78k6HOZMI4lz5Ij9v6oUTzU6NBX1Bp0QVauiyzyuy
 MCsxUQFwUX+RAdSLZC4INtRZTpY2O+vvJY2vrSlGnSHf/dv5ZueY+k8UeSeQtkf2A6rCpMLKxsp
 frYC5hTJqTij6dQ7L++wl85FHrPNerH2l2WSbrQ/ZzOkMux8/WI5cnc7BUCb0FeeJmB6ZZThmfd
 JpIYsQYbSY2JI4XhP6DHOax39PCieWW0AnUe9QQfsh230xccE1qVvwQx+/1qpBxk2U+MTHnSkak
 Z8Qk2m6KBPc30Nei0Xw==

When encoding concrete instances of optimized functions it is possible
parameters get reordered, often due to a parameter being optimized out;
in such cases the order of abstract origin references to the abstract
function is different, and the parameters that are optimized out
usually appear after all the non-optimized parameters with no
DW_AT_location information [1].

As an example consider

static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu);

It has - as expected - an abstract representation as follows:

 <1><6392a2d>: Abbrev Number: 47 (DW_TAG_subprogram)
    <6392a2e>   DW_AT_name        : (indirect string, offset: 0x261e25): __blkcg_rstat_flush
    <6392a32>   DW_AT_decl_file   : 1
    <6392a33>   DW_AT_decl_line   : 1043
    <6392a35>   DW_AT_decl_column : 13
    <6392a36>   DW_AT_prototyped  : 1
    <6392a36>   DW_AT_inline      : 1   (inlined)
    <6392a37>   DW_AT_sibling     : <0x6392bac>
 <2><6392a3b>: Abbrev Number: 38 (DW_TAG_formal_parameter)
    <6392a3c>   DW_AT_name        : (indirect string, offset: 0xa7a9f): blkcg
    <6392a40>   DW_AT_decl_file   : 1
    <6392a41>   DW_AT_decl_line   : 1043
    <6392a43>   DW_AT_decl_column : 47
    <6392a44>   DW_AT_type        : <0x638b611>
 <2><6392a48>: Abbrev Number: 20 (DW_TAG_formal_parameter)
    <6392a49>   DW_AT_name        : cpu
    <6392a4d>   DW_AT_decl_file   : 1
    <6392a4e>   DW_AT_decl_line   : 1043
    <6392a50>   DW_AT_decl_column : 58
    <6392a51>   DW_AT_type        : <0x6377f8f>

However the concrete representation after optimization becomes:

ffffffff8186d180 t __blkcg_rstat_flush.isra.0

and has a concrete representation with parameter order switched:

<1><6399661>: Abbrev Number: 110 (DW_TAG_subprogram)
    <6399662>   DW_AT_abstract_origin: <0x6392a2d>
    <6399666>   DW_AT_low_pc      : 0xffffffff8186d180
    <639966e>   DW_AT_high_pc     : 0x169
    <6399676>   DW_AT_frame_base  : 1 byte block: 9c    (DW_OP_call_frame_cfa)
    <6399678>   DW_AT_GNU_all_call_sites: 1
    <6399678>   DW_AT_sibling     : <0x6399a8a>
 <2><639967c>: Abbrev Number: 4 (DW_TAG_formal_parameter)
    <639967d>   DW_AT_abstract_origin: <0x6392a48>
    <6399681>   DW_AT_location    : 0x1fe21fb (location list)
    <6399685>   DW_AT_GNU_locviews: 0x1fe21f5
 <2><63996e4>: Abbrev Number: 4 (DW_TAG_formal_parameter)
    <63996e5>   DW_AT_abstract_origin: <0x6392a3b>
    <63996e9>   DW_AT_location    : 0x1fe2387 (location list)
    <63996ed>   DW_AT_GNU_locviews: 0x1fe2385

In other words we end up with

static void __blkcg_rstat_flush.isra(int cpu, struct blkcg *blkcg);

We are not detecting cases like this in pahole, so we need to
catch it to exclude such cases since they could lead to incorrect
fentry attachment.

Future work around true function signatures will allow such functions
with their "." suffixes, but even for such cases it is good to
detect the reordering.

In practice we just end up excluding a few more .isra/.constprop
functions which we cannot fentry-attach by name anyway; see [2] for an
example list from CI.

[1] https://lore.kernel.org/bpf/101b74c9-949a-4bf4-a766-a5343b70bdd2@oracle.com/
[2] https://github.com/alan-maguire/dwarves/actions/runs/20031993822

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Matt Bobrowski <mattbobrowski@google.com>
---
 btf_encoder.c  | 29 ++++++++++++++++++++---------
 dwarf_loader.c |  5 +++--
 dwarves.h      |  2 ++
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index ec6933e..9a567e4 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -87,6 +87,7 @@ struct btf_encoder_func_state {
 	uint8_t unexpected_reg:1;
 	uint8_t inconsistent_proto:1;
 	uint8_t uncertain_parm_loc:1;
+	uint8_t reordered_parm:1;
 	uint8_t ambiguous_addr:1;
 	int ret_type_id;
 	struct btf_encoder_func_parm *parms;
@@ -1273,6 +1274,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 	state->unexpected_reg = ftype->unexpected_reg;
 	state->optimized_parms = ftype->optimized_parms;
 	state->uncertain_parm_loc = ftype->uncertain_parm_loc;
+	state->reordered_parm = ftype->reordered_parm;
 	ftype__for_each_parameter(ftype, param) {
 		const char *name = parameter__name(param) ?: "";
 
@@ -1442,7 +1444,7 @@ static int saved_functions_combine(struct btf_encoder *encoder,
 				   struct btf_encoder_func_state *a,
 				   struct btf_encoder_func_state *b)
 {
-	uint8_t optimized, unexpected, inconsistent, uncertain_parm_loc;
+	uint8_t optimized, unexpected, inconsistent, uncertain_parm_loc, reordered_parm;
 
 	if (a->elf != b->elf)
 		return 1;
@@ -1451,12 +1453,14 @@ static int saved_functions_combine(struct btf_encoder *encoder,
 	unexpected = a->unexpected_reg | b->unexpected_reg;
 	inconsistent = a->inconsistent_proto | b->inconsistent_proto;
 	uncertain_parm_loc = a->uncertain_parm_loc | b->uncertain_parm_loc;
-	if (!unexpected && !inconsistent && !funcs__match(encoder, a, b))
+	reordered_parm = a->reordered_parm | b->reordered_parm;
+	if (!unexpected && !inconsistent && !reordered_parm && !funcs__match(encoder, a, b))
 		inconsistent = 1;
 	a->optimized_parms = b->optimized_parms = optimized;
 	a->unexpected_reg = b->unexpected_reg = unexpected;
 	a->inconsistent_proto = b->inconsistent_proto = inconsistent;
 	a->uncertain_parm_loc = b->uncertain_parm_loc = uncertain_parm_loc;
+	a->reordered_parm = b->reordered_parm = reordered_parm;
 
 	return 0;
 }
@@ -1494,7 +1498,7 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
 
 	for (i = 0; i < nr_saved_fns; i = j) {
 		struct btf_encoder_func_state *state = &saved_fns[i];
-		bool add_to_btf = !skip_encoding_inconsistent_proto;
+		char *skip_reason = NULL;
 
 		/* Compare across sorted functions that match by name/prefix;
 		 * share inconsistent/unexpected reg state between them.
@@ -1510,14 +1514,21 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
 		 * unexpected register use, multiple inconsistent prototypes or
 		 * uncertain parameters location
 		 */
-		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto && !state->uncertain_parm_loc && !state->elf->ambiguous_addr;
-
+		if (state->unexpected_reg)
+			skip_reason = "unexpected register usage for parameter\n";
+		if (skip_encoding_inconsistent_proto && state->inconsistent_proto)
+			skip_reason = "inconsistet prototype\n";
 		if (state->uncertain_parm_loc)
-			btf_encoder__log_func_skip(encoder, saved_fns[i].elf,
-					"uncertain parameter location\n",
-					0, 0);
+			skip_reason = "uncertain parameter location\n";
+		if (state->reordered_parm)
+			skip_reason = "reordered parameters\n";
+		if (state->elf->ambiguous_addr)
+			skip_reason = "ambiguous address\n";
 
-		if (add_to_btf) {
+		if (skip_reason) {
+			btf_encoder__log_func_skip(encoder, saved_fns[i].elf,
+						   skip_reason, 0, 0);
+		} else {
 			if (is_kfunc_state(state))
 				err = btf_encoder__add_bpf_kfunc(encoder, state);
 			else
diff --git a/dwarf_loader.c b/dwarf_loader.c
index 77aab8a..16fb7be 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1262,7 +1262,7 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu,
 
 		tag__init(&parm->tag, cu, die);
 		parm->name = attr_string(die, DW_AT_name, conf);
-
+		parm->idx = param_idx;
 		if (param_idx >= cu->nr_register_params || param_idx < 0)
 			return parm;
 		/* Parameters which use DW_AT_abstract_origin to point at
@@ -2636,6 +2636,8 @@ static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu)
 			}
 			opos = tag__parameter(dtag__tag(dtype));
 			pos->name = opos->name;
+			if (pos->idx != opos->idx)
+				type->reordered_parm = 1;
 			pos->tag.type = dtag__tag(dtype)->type;
 			/* share location information between parameter and
 			 * abstract origin; if neither have location, we will
@@ -2838,7 +2840,6 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
 		lexblock__recode_dwarf_types(&fn->lexblock, cu);
 	}
 		/* Fall thru */
-
 	case DW_TAG_subroutine_type:
 		ftype__recode_dwarf_types(tag, cu);
 		/* Fall thru, for the function return type */
diff --git a/dwarves.h b/dwarves.h
index 21d4166..78bedf5 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -944,6 +944,7 @@ struct parameter {
 	uint8_t optimized:1;
 	uint8_t unexpected_reg:1;
 	uint8_t has_loc:1;
+	uint8_t idx;
 };
 
 static inline struct parameter *tag__parameter(const struct tag *tag)
@@ -1023,6 +1024,7 @@ struct ftype {
 	uint8_t		 processed:1;
 	uint8_t		 inconsistent_proto:1;
 	uint8_t		 uncertain_parm_loc:1;
+	uint8_t		 reordered_parm:1;
 	struct list_head template_type_params;
 	struct list_head template_value_params;
 	struct template_parameter_pack *template_parameter_pack;
-- 
2.43.5

