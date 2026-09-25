Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B289368950;
	Fri, 25 Sep 2026 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362384; cv=none; b=jR9fuXoAkoFxF0hSjyvKzl1QMsRl2nxVhmbCBg1QRTusNGzaNDqMH6Sy1vGc7RE4ZdIxGIn9GNZcsR5/oruZekvjfykxoCK6OjZ6hFaV/PGgW21VRFQCT9kFJfC3tYpqJKXB1g2kEvjPATldnwp6r3FMz3XTqpXofkPCHDLvBxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362384; c=relaxed/simple;
	bh=vuxeJowKl6wAqttkoeC0pmsd9S1jTZuUixXSG/K2IYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojPqv0tDeYq/awBdkhjmvFdWSQxeLvtuJjuha22ih/UTptPIey3GmoHBGpEvNO6CeCAaDubB4PD7gyTXhwyn2QWxZDICZIRQ58eOxAqTamVFXzO9KmrCqI1T00NegcOecdkhNzzfj8SM+q0jNdwYnlxGpsXoZxrNsT58xKIPh7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sKXdlt/I; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sKXdlt/I"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PEBo2G3837178;
	Fri, 25 Sep 2026 18:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=WMIbs
	TxxKZekg5ovnCseq8UcEiWfgz9auS6irRSMQWE=; b=sKXdlt/ImaaTDxUuIn1OG
	yrjcIcn+pAPUa7os/CcjvFgiWdtSh5sIabWUiHc/kexNcz6baIV0Uf8KolJ7sSt7
	MvWFQLvQ3GD2f6haH5b/kZ83gtVGRLM9SGFTgAkpxAcRImvHvl/aEk8u4ER5qGvf
	CWC2Eo8EBSvaJRZhevbiEGEFiU00XXfXY8AaFJFVff8gPzIYdyZgEGdiNicYsBkJ
	vDR3o98ibZoRPu+WivraIQxt7MncN4Z2K1ywmoNO3B3ZygbC86lEhpAe/ubEC5NZ
	Ddr24hHFKH3rjpPRp5jmRX5FsYFH07YkkrmpnhckNpBJ/iPfXS5hbcT5XqOh4DGw
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk1qhwyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:52:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68PIqE4P038672;
	Fri, 25 Sep 2026 18:52:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gtepthtar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:52:37 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68PIqQok040536;
	Fri, 25 Sep 2026 18:52:36 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-81-122.vpn.oracle.com [10.154.81.122])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gtepthsyc-4;
	Fri, 25 Sep 2026 18:52:36 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        qmo@kernel.org
Cc: dwarves@vger.kernel.org, jolsa@kernel.org, daniel@iogearbox.net,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
        bpf@vger.kernel.org, nsc@kernel.org, puranjay@kernel.org,
        yatsenko@meta.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 3/9] dwarf_loader: Collect inline expansion location data
Date: Fri, 25 Sep 2026 19:51:52 +0100
Message-ID: <20260925185200.1318067-4-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NSBTYWx0ZWRfXyEIoO/BOa5i5
 RB7DIh9rrCm+rXZiUcNI3vOnhlIGB/FsmVVKpTCEi+ohz0p4dfy1aiY9yjoIZbfvD6R+9dXHx1C
 fhjH0PC3uas+EYpuawgoJfY+wktZbtPNV+3TeAZ+hoGBqcHtT59r
X-Proofpoint-ORIG-GUID: viS8WhacYEA1Z_DQBhxAELEKL1S9k4JS
X-Proofpoint-GUID: viS8WhacYEA1Z_DQBhxAELEKL1S9k4JS
X-Authority-Analysis: v=2.4 cv=LIzz05W9 c=1 sm=1 tr=0 ts=6ab6c2f6 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=cP4wvxaNsk7pxYQXo6QA:9
 a=O8hF6Hzn-FEA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:13532
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NSBTYWx0ZWRfX6Xo7ZLNDzuJM
 /hXUtPWMxcFTW0OKIK4um0asI3JiKLCP4TPx/LwTOLbOd+9UqLjyuz8xPWvMtrhKACG/qyGtVpp
 vdoOCagsegozyFkwZN4FUt0QNh6lNi3OwhWXzMLNPx/L0zeNBEqj3qCDSd+0ucqSjLVRlVsQLcT
 An6/NriXzS9b8RBpDD+yvmtwLIX0UC5EYlbgS56epv8BER1AsWVG30g7z75wRuzZJo+NimasPXD
 5ibrl/sAznTjeKpUGLUHP4XvdouJe68u32HWo9qn3Ha8hoLxjKi1OLxzgr6T5FZaGCRlIUQE2k+
 xwU9miip6BdGqClogVMhDJJ0kI5dryGQFJ25Oa5duShzdw8bSywIVem21Esx5LRYc2zIRcRS0Fr
 QH4mxY67qQnBTGEecEqWj8I/97Uz5Tlt6DaUnn9ECaPjoKGrHJbApN5SfcAOMp+PTSNSCOdtOmd
 wjzEHpPZSi77OGPdQdbJWwRKk/8qqdceONt4ZQTA=

Prepare inline expansion BTF encoding by keeping the resolved origin
function on each inline expansion and by exposing inline expansions and
their parameters.

Reuse the existing true-signature parameter location decoding instead of
adding a separate per-site location model. Store the small amount of
extra location state needed by BTF inline location encoding directly on
struct parameter: constant/address values, offsets, size, signedness and
dereference flags. This lets the encoder derive LOC_PARAM data from the
same representation used for optimized-function signature analysis.

Also fix inline expansion high_pc collection to use dwarf_highpc(), and
avoid running concrete ABI register diagnostics on abstract inline
subprograms while still allowing their type recoding to proceed.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 dwarf_loader.c | 322 ++++++++++++++++++++++++++++++++++++++++---------
 dwarves.h      |  38 +++++-
 2 files changed, 303 insertions(+), 57 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 13c6464..49a88d5 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1730,12 +1730,123 @@ static bool dwarf_expr__has_stack_value(Dwarf_Op *expr, size_t exprlen)
 	return false;
 }
 
+static uint8_t parameter__loc_size(const struct parameter *parm, const struct cu *cu)
+{
+	uint16_t size = parm->type_byte_size ?: cu->addr_size;
+
+	/* BTF_LOC_PARAM can describe values up to 16 bytes. */
+	if (size == 0 || size > 16)
+		return 0;
+	return size;
+}
+
+static bool dwarf_op__const_signed(unsigned int atom)
+{
+	switch (atom) {
+	case DW_OP_const1s:
+	case DW_OP_const2s:
+	case DW_OP_const4s:
+	case DW_OP_const8s:
+	case DW_OP_consts:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int64_t dwarf_op__snumber(const Dwarf_Op *op)
+{
+	return (int64_t)(Dwarf_Sword)op->number;
+}
+
+static uint64_t dwarf_op__const_value(const Dwarf_Op *op)
+{
+	if (dwarf_op__const_signed(op->atom))
+		return (uint64_t)dwarf_op__snumber(op);
+	return op->number;
+}
+
 static void parameter__set_loc_reg(struct parameter *parm, int reg)
 {
 	if (parm->loc_reg == PARAMETER_UNKNOWN_REG)
 		parm->loc_reg = reg;
 }
 
+static void parameter__record_loc_reg(struct parameter *parm, int reg,
+				      int64_t offset, bool is_deref,
+				      uint8_t size)
+{
+	if (reg < DW_OP_reg0 || !size)
+		return;
+
+	parameter__set_loc_reg(parm, reg);
+
+	if (parm->loc_reg != reg)
+		return;
+	if (offset < INT32_MIN || offset > INT32_MAX)
+		return;
+
+	parm->loc_offset = offset;
+	parm->loc_deref = is_deref;
+	parm->loc_size = size;
+}
+
+static void parameter__record_loc_reg_pair(struct parameter *parm, int reg,
+					   int reg2)
+{
+	uint16_t size = parm->type_byte_size;
+
+	/* LOC_PARAM supports a complete two-register value of up to 16 bytes. */
+	if (reg < DW_OP_reg0 || reg2 < DW_OP_reg0 || !size || size > 16)
+		return;
+
+	parm->loc_reg = reg;
+	parm->loc_reg2 = reg2;
+	parm->loc_offset = 0;
+	parm->loc_deref = 0;
+	parm->loc_size = size;
+}
+
+static void parameter__record_loc_const(struct parameter *parm, uint64_t value,
+					uint8_t size, bool is_signed,
+					bool is_addr)
+{
+	if (!size)
+		return;
+
+	parm->loc_const_value = 1;
+	parm->loc_value = value;
+	parm->loc_size = size;
+	parm->loc_signed = is_signed;
+	parm->loc_addr = is_addr;
+}
+
+static bool parameter__record_attr_const_value(Dwarf_Attribute *attr,
+					       struct cu *cu,
+					       struct parameter *parm)
+{
+	Dwarf_Sword svalue;
+	Dwarf_Word uvalue;
+
+	if (dwarf_formudata(attr, &uvalue) == 0) {
+		parm->loc_value = uvalue;
+		parm->loc_size = parameter__loc_size(parm, cu);
+		parm->loc_signed = 0;
+		parm->loc_addr = 0;
+		return true;
+	}
+
+	if (dwarf_formsdata(attr, &svalue) == 0) {
+		parm->loc_value = (uint64_t)svalue;
+		parm->loc_size = parameter__loc_size(parm, cu);
+		parm->loc_signed = 1;
+		parm->loc_addr = 0;
+		return true;
+	}
+
+	return false;
+}
+
 static void parameter__set_field_bit(unsigned long *fields, int byte_offset)
 {
 	if (byte_offset >= 0 && byte_offset < (int)(sizeof(*fields) * 8))
@@ -1795,24 +1906,43 @@ static void parameter__finish_piece_decode(struct parameter *parm, Dwarf_Die *di
 static void parameter__multi_exprs(Dwarf_Op *expr, int loc_num, struct cu *cu,
 				   size_t exprlen, struct parameter *parm)
 {
+	int regs[2], nregs = 0;
+	uint64_t piece_size = 0;
+	bool reg_pieces = true;
+
 	switch (expr[0].atom) {
 	case DW_OP_lit0 ... DW_OP_lit31:
 	case DW_OP_constu:
 	case DW_OP_consts:
-		if (loc_num == 0)
-			parm->loc_const_value = 1;
+		if (loc_num == 0) {
+			uint64_t value = expr[0].atom;
+
+			if (expr[0].atom >= DW_OP_lit0 && expr[0].atom <= DW_OP_lit31)
+				value -= DW_OP_lit0;
+			else
+				value = dwarf_op__const_value(&expr[0]);
+			parameter__record_loc_const(parm, value,
+						    parameter__loc_size(parm, cu),
+						    dwarf_op__const_signed(expr[0].atom), false);
+		}
 		return;
 	}
 
 	if (parm->type_byte_size <= cu->addr_size || !cu->agg_use_two_regs) {
+		bool had_stack_value = dwarf_expr__has_stack_value(expr, exprlen);
+		uint8_t size = parameter__loc_size(parm, cu);
+
 		switch (expr[0].atom) {
 		case DW_OP_reg0 ... DW_OP_reg31:
 			if (loc_num == 0)
-				parameter__set_loc_reg(parm, expr[0].atom);
+				parameter__record_loc_reg(parm, expr[0].atom, 0, false, size);
 			return;
 		case DW_OP_breg0 ... DW_OP_breg31:
-			if (loc_num == 0 && dwarf_expr__has_stack_value(expr, exprlen))
-				parameter__set_loc_reg(parm, expr[0].atom - DW_OP_breg0 + DW_OP_reg0);
+			if (loc_num == 0)
+				parameter__record_loc_reg(parm,
+							  expr[0].atom - DW_OP_breg0 + DW_OP_reg0,
+							  dwarf_op__snumber(&expr[0]),
+							  !had_stack_value, size);
 			return;
 		default:
 			return;
@@ -1822,6 +1952,10 @@ static void parameter__multi_exprs(Dwarf_Op *expr, int loc_num, struct cu *cu,
 	int off = 0;
 	for (size_t i = 0; i < exprlen; i++) {
 		if (expr[i].atom == DW_OP_piece) {
+			if (i == 0 || !dwarf_op__is_reg(expr[i - 1].atom))
+				reg_pieces = false;
+			else
+				piece_size += expr[i].number;
 			int num = expr[i].number;
 
 			if (i == 0) {
@@ -1835,13 +1969,26 @@ static void parameter__multi_exprs(Dwarf_Op *expr, int loc_num, struct cu *cu,
 				parameter__set_field_bit(&parm->second_reg_fields, off - cu->addr_size);
 			off += num;
 		} else if (dwarf_op__is_reg(expr[i].atom)) {
-			if (off < cu->addr_size || parm->loc_reg == PARAMETER_UNKNOWN_REG)
-				parameter__set_loc_reg(parm, expr[i].atom);
+			int reg = expr[i].atom - DW_OP_reg0;
+
+			if (nregs < ARRAY_SIZE(regs))
+				regs[nregs++] = reg;
+			else
+				reg_pieces = false;
+			if (off < cu->addr_size || parm->loc_reg == PARAMETER_UNKNOWN_REG) {
+				uint8_t size = parameter__loc_size(parm, cu);
+
+				parameter__record_loc_reg(parm, expr[i].atom, 0, false, size);
+			}
+		} else {
+			reg_pieces = false;
 		}
-		/* FIXME: not handling DW_OP_bregX pieces yet since we do not
-		 * have a use case for it yet in the Linux kernel.
-		 */
 	}
+
+	if (loc_num == 0 && reg_pieces && nregs == ARRAY_SIZE(regs) &&
+	    piece_size == parm->type_byte_size)
+		parameter__record_loc_reg_pair(parm, DW_OP_reg0 + regs[0],
+					       DW_OP_reg0 + regs[1]);
 }
 
 static void parameter__decode_location(Dwarf_Attribute *attr, struct conf_load *conf,
@@ -1857,46 +2004,90 @@ static void parameter__decode_location(Dwarf_Attribute *attr, struct conf_load *
 
 	libdw__lock_lock();
 	while ((offset = __dwarf_getlocations(attr, offset, &base, &start, &end, &expr, &exprlen)) > 0) {
-		bool had_stack_value;
+		bool had_stack_value = false, had_deref = false;
+		uint8_t size = 0;
 
 		loc_num++;
 		if (exprlen == 0)
 			continue;
 
+		/*
+		 * Expressions can have form
+		 * DW_OP_fbreg -40, DW_OP_stack_value ; or
+		 * DW_OP_fbreg -40, DW_OP_deref[_size], DW_OP_stack_value
+		 *
+		 * In the absence of the stack value, breg/fbreg are
+		 * implicitly dereferences; with it they are non-dereference
+		 * calculations of register + offset.  So below we mark
+		 * dereferences as either explicit (from DW_OP_deref*)
+		 * or implicit (!had_stack_value for fbreg/breg).
+		 */
 		had_stack_value = expr[exprlen - 1].atom == DW_OP_stack_value;
-		if (exprlen == 2 && had_stack_value)
+		if (had_stack_value)
 			exprlen--;
+		if (exprlen > 0) {
+			had_deref = expr[exprlen - 1].atom == DW_OP_deref ||
+				    expr[exprlen - 1].atom == DW_OP_deref_size;
+			if (had_deref)
+				exprlen--;
+		}
+		if (exprlen == 0)
+			continue;
 
 		if (exprlen != 1) {
 			parameter__multi_exprs(expr, loc_num, cu, exprlen, parm);
 			continue;
 		}
 
+		size = parameter__loc_size(parm, cu);
+
 		switch (expr->atom) {
 		case DW_OP_reg0 ... DW_OP_reg31:
 			if (loc_num == 0)
-				parameter__set_loc_reg(parm, expr->atom);
+				parameter__record_loc_reg(parm, expr->atom, 0, false, size);
 			break;
 		case DW_OP_breg0 ... DW_OP_breg31:
-			if (loc_num == 0 && had_stack_value)
-				parameter__set_loc_reg(parm, expr->atom - DW_OP_breg0 + DW_OP_reg0);
+			if (loc_num == 0)
+				parameter__record_loc_reg(parm,
+							  expr->atom - DW_OP_breg0 + DW_OP_reg0,
+							  dwarf_op__snumber(expr),
+							  had_deref || !had_stack_value,
+							  size);
 			break;
 		case DW_OP_fbreg:
-			if (loc_num == 0)
+			if (loc_num == 0 && size) {
+				int64_t loc_offset = dwarf_op__snumber(expr);
+
 				parm->loc_stack = 1;
+				if (loc_offset >= INT32_MIN && loc_offset <= INT32_MAX)
+					parm->loc_offset = (int32_t)loc_offset;
+				parm->loc_size = size;
+				parm->loc_deref = had_deref || !had_stack_value;
+			}
 			break;
 		case DW_OP_lit0 ... DW_OP_lit31:
-		case DW_OP_constu:
-		case DW_OP_consts:
 			if (loc_num == 0)
-				parm->loc_const_value = 1;
+				parameter__record_loc_const(parm, expr->atom - DW_OP_lit0,
+							    size, false, false);
+			break;
+		case DW_OP_const1u ... DW_OP_consts:
+			if (loc_num == 0)
+				parameter__record_loc_const(parm, dwarf_op__const_value(expr),
+							    size,
+							    dwarf_op__const_signed(expr->atom),
+							    false);
+			break;
+		case DW_OP_addr:
+			if (loc_num == 0)
+				parameter__record_loc_const(parm, expr->number, cu->addr_size,
+							    false, true);
 			break;
 		case DW_OP_entry_value:
 		case DW_OP_GNU_entry_value:
 			if (dwarf_getlocation_attr(attr, expr, &entry_attr) == 0 &&
 			    dwarf_getlocation(&entry_attr, &entry_ops, &entry_len) == 0 &&
 			    entry_len == 1 && dwarf_op__is_reg(entry_ops->atom))
-				parameter__set_loc_reg(parm, entry_ops->atom);
+				parameter__record_loc_reg(parm, entry_ops->atom, 0, false, size);
 			break;
 		}
 	}
@@ -1906,7 +2097,8 @@ static void parameter__decode_location(Dwarf_Attribute *attr, struct conf_load *
 }
 
 static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf,
-					struct ftype *ftype, int param_idx)
+					struct ftype *ftype, int param_idx,
+					bool decode_location)
 {
 	struct parameter *parm = tag__alloc(cu, sizeof(*parm));
 
@@ -1917,7 +2109,8 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu, struct co
 		parm->name = attr_string(die, DW_AT_name, conf);
 		parm->idx = param_idx;
 		parm->loc_reg = PARAMETER_UNKNOWN_REG;
-		if (!ftype)
+		parm->loc_reg2 = PARAMETER_UNKNOWN_REG;
+		if (!decode_location)
 			return parm;
 
 		parm->type_byte_size = get_type_byte_size(die, cu);
@@ -1958,6 +2151,8 @@ static struct parameter *parameter__new(Dwarf_Die *die, struct cu *cu, struct co
 		 * ftype__recode_dwarf_types() below for how this is handled.
 		 */
 		parm->has_const_value = dwarf_attr(die, DW_AT_const_value, &attr) != NULL;
+		if (parm->has_const_value)
+			parameter__record_attr_const_value(&attr, cu, parm);
 		parm->has_loc = dwarf_attr(die, DW_AT_location, &attr) != NULL;
 		if (parm->has_loc)
 			parameter__decode_location(&attr, conf, cu, die, parm);
@@ -1980,7 +2175,7 @@ static int formal_parameter_pack__load_params(struct formal_parameter_pack *pack
 			continue;
 		}
 
-		struct parameter *param = parameter__new(die, cu, conf, NULL, -1);
+		struct parameter *param = parameter__new(die, cu, conf, NULL, -1, false);
 
 		if (param == NULL)
 			return -1;
@@ -2021,10 +2216,12 @@ static struct inline_expansion *inline_expansion__new(Dwarf_Die *die, struct cu
 		dtag->decl_file = attr_string(die, DW_AT_call_file, conf);
 		dtag->decl_line = attr_numeric(die, DW_AT_call_line);
 		dwarf_tag__set_attr_type(dtag, DWARF_TAG__REF_TYPE, die, DW_AT_abstract_origin, cu);
+		exp->name = NULL;
 		if (dwarf_attr(die, DW_AT_abstract_origin, &attr_orig)) {
 			Dwarf_Die die_orig;
 
-			if (dwarf_formref_die(&attr_orig, &die_orig))
+			if (dwarf_formref_die(&attr_orig, &die_orig) &&
+			    dwarf_tag(&die_orig) == DW_TAG_subprogram)
 				exp->name = attr_string(&die_orig, DW_AT_name, conf);
 		}
 
@@ -2038,7 +2235,7 @@ static struct inline_expansion *inline_expansion__new(Dwarf_Die *die, struct cu
 
 		if (dwarf_lowpc(die, &exp->ip.addr))
 			exp->ip.addr = 0;
-		if (dwarf_lowpc(die, &exp->high_pc))
+		if (dwarf_highpc(die, &exp->high_pc))
 			exp->high_pc = 0;
 
 		exp->size = exp->high_pc - exp->ip.addr;
@@ -2573,7 +2770,8 @@ static struct tag *die__create_new_parameter(Dwarf_Die *die,
 					     struct cu *cu, struct conf_load *conf,
 					     int param_idx)
 {
-	struct parameter *parm = parameter__new(die, cu, conf, ftype, param_idx);
+	struct parameter *parm = parameter__new(die, cu, conf, ftype, param_idx,
+					       ftype != NULL || exp != NULL);
 
 	if (parm == NULL)
 		return NULL;
@@ -3618,6 +3816,17 @@ static void parameter__share_state_with_abstract_origin(struct parameter *parm,
 		oparm->loc_stack = parm->loc_stack;
 	if (parm->loc_reg != PARAMETER_UNKNOWN_REG)
 		oparm->loc_reg = parm->loc_reg;
+	if (parm->loc_reg2 != PARAMETER_UNKNOWN_REG)
+		oparm->loc_reg2 = parm->loc_reg2;
+	if (parm->has_const_value || parm->loc_const_value || parm->loc_stack ||
+	    parm->loc_reg != PARAMETER_UNKNOWN_REG) {
+		oparm->loc_offset = parm->loc_offset;
+		oparm->loc_value = parm->loc_value;
+		oparm->loc_size = parm->loc_size;
+		oparm->loc_deref = parm->loc_deref;
+		oparm->loc_addr = parm->loc_addr;
+		oparm->loc_signed = parm->loc_signed;
+	}
 	if (parm->type_byte_size != 0)
 		oparm->type_byte_size = parm->type_byte_size;
 	if (parm->passed_in_memory)
@@ -3690,22 +3899,28 @@ static void inline_expansion__recode_dwarf_types(struct tag *tag, struct cu *cu)
 	struct dwarf_tag *dtype;
 	struct tag *origin;
 	struct tag *pos;
+	struct inline_expansion *exp = tag__inline_expansion(tag);
+
+	exp->function = NULL;
 
 	/* The inline expansion's abstract origin is stored as its type ref. */
 	dtype = dwarf_cu__find_tag_by_ref(dcu, dtag, type);
 	if (dtype == NULL) {
 		tag__print_type_not_found(tag);
 		tag__check_pruned_alt_ref(dcu, dtag->type, dtag->from_alt.type);
+		exp->name = NULL;
 		return;
 	}
 
 	origin = dtag__tag(dtype);
 	if (tag__is_function(origin)) {
 		function__recode_dwarf_name(origin, cu);
-		tag__inline_expansion(tag)->name = function__name(tag__function(origin));
-	}
+		exp->function = tag__function(origin);
+		exp->name = function__name(exp->function);
+	} else
+		exp->name = NULL;
 	ftype__recode_dwarf_types(origin, cu);
-	list_for_each_entry(pos, &tag__inline_expansion(tag)->parms, node)
+	list_for_each_entry(pos, &exp->parms, node)
 		parameter__recode_dwarf_type(tag__parameter(pos), cu, NULL);
 	tag->type = dtype->small_id;
 }
@@ -4214,37 +4429,32 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu, struct conf_load
 			continue;
 
 		fn = tag__function(tag);
-		function__analyze_parameter_locations(fn, cu, conf);
-
-		/* mark function as optimized if parameter is, or
-		 * if parameter does not have a location; at this
-		 * point location presence has been marked in
-		 * abstract origins for cases where a parameter
-		 * location is not stored in the original function
-		 * parameter tag.
-		 *
-		 * Also mark functions which, due to optimization,
-		 * use an unexpected register for a parameter.
-		 * Exception is functions which have a struct
-		 * as a parameter, as multiple registers may
-		 * be used to represent it, throwing off register
-		 * to parameter mapping.
+		/* Abstract inline subprograms describe source signatures; their
+		 * concrete locations belong to DW_TAG_inlined_subroutine children.
 		 */
-		ftype__for_each_parameter(&fn->proto, pos) {
-			if (pos->optimized || !pos->has_loc)
-				fn->proto.optimized_parms = 1;
+		if (!function__inlined(fn)) {
+			function__analyze_parameter_locations(fn, cu, conf);
 
-			if (pos->unexpected_reg)
-				has_unexpected_reg = true;
-		}
-		if (has_unexpected_reg) {
+			/* Mark functions with optimized or location-less parameters, and
+			 * flag unexpected registers unless a struct parameter explains
+			 * the multi-register ABI representation.
+			 */
 			ftype__for_each_parameter(&fn->proto, pos) {
-				has_struct_param = param__is_struct(cu, &pos->tag);
-				if (has_struct_param)
-					break;
+				if (pos->optimized || !pos->has_loc)
+					fn->proto.optimized_parms = 1;
+
+				if (pos->unexpected_reg)
+					has_unexpected_reg = true;
+			}
+			if (has_unexpected_reg) {
+				ftype__for_each_parameter(&fn->proto, pos) {
+					has_struct_param = param__is_struct(cu, &pos->tag);
+					if (has_struct_param)
+						break;
+				}
+				if (!has_struct_param)
+					fn->proto.unexpected_reg = 1;
 			}
-			if (!has_struct_param)
-				fn->proto.unexpected_reg = 1;
 		}
 
 		if (tag == NULL || tag->type != 0)
diff --git a/dwarves.h b/dwarves.h
index ddd4fd5..b6ddb50 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -472,6 +472,19 @@ bool languages__cu_filtered(struct languages *languages, struct cu *cu, bool ver
 			continue;			\
 		else
 
+/**
+ * cu__for_each_inline_expansion - iterate thru all inline expansions
+ * @cu: struct cu instance to iterate
+ * @id: uint32_t tag id
+ * @pos: struct inline_expansion iterator
+ */
+#define cu__for_each_inline_expansion(cu, id, pos)	\
+	for (id = 0; id < cu->tags_table.nr_entries; ++id) \
+		if (!tag__is_inline_expansion(cu->tags_table.entries[id]) || \
+		    !(pos = tag__inline_expansion(cu->tags_table.entries[id]))) \
+			continue;			\
+		else
+
 /**
  * cu__for_each_namespace - iterate thru all the global namespace tags
  * @cu: struct cu instance to iterate
@@ -602,6 +615,11 @@ static inline bool tag__is_constant(const struct tag *tag)
 	return tag->tag == DW_TAG_constant;
 }
 
+static inline bool tag__is_inline_expansion(const struct tag *tag)
+{
+	return tag && tag->tag == DW_TAG_inlined_subroutine;
+}
+
 static inline bool tag__is_volatile(const struct tag *tag)
 {
 	return tag->tag == DW_TAG_volatile_type;
@@ -821,12 +839,16 @@ struct ip_tag {
 	uint64_t   addr;
 };
 
+struct function;
+struct parameter;
+
 struct inline_expansion {
 	struct ip_tag	 ip;
 	const char	 *name;
 	size_t		 size;
 	uint64_t	 high_pc;
 	struct list_head parms;
+	struct function	 *function;
 	uint16_t	 nr_parms;
 };
 
@@ -836,10 +858,17 @@ static inline struct inline_expansion *
 	return (struct inline_expansion *)tag;
 }
 
-struct parameter;
 void inline_expansion__add_parameter(struct inline_expansion *exp,
 				     struct parameter *parm);
 
+/**
+ * inline_expansion__for_each_parameter - iterate thru all the parameters
+ * @ie: struct inline_expansion instance to iterate
+ * @pos: struct parameter iterator
+ */
+#define inline_expansion__for_each_parameter(ie, pos) \
+	list_for_each_entry(pos, &(ie)->parms, tag.node)
+
 struct label {
 	struct ip_tag	 ip;
 	const char	 *name;
@@ -955,12 +984,19 @@ struct parameter {
 	unsigned long first_reg_fields;
 	unsigned long second_reg_fields;
 	int loc_reg;
+	int loc_reg2;
+	int32_t loc_offset;
+	uint64_t loc_value;
 	uint16_t type_byte_size;
+	uint8_t loc_size;
 	uint8_t true_sig_type_from_types:1;
 	uint8_t true_sig_type_from_alt:1;
 	uint8_t has_const_value:1;
 	uint8_t loc_const_value:1;
 	uint8_t loc_stack:1;
+	uint8_t loc_deref:1;
+	uint8_t loc_addr:1;
+	uint8_t loc_signed:1;
 	uint8_t optimized:1;
 	uint8_t unexpected_reg:1;
 	uint8_t has_loc:1;
-- 
2.43.5

