Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01141E7C16
	for <dwarves@vger.kernel.org>; Thu,  1 May 2025 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746111411; cv=none; b=ZmPHbMqHUIZD61YUJUOQ8hQc25D20WzJUZSHSN0wzckXbQ5zqV9lKY6LATNfLN/r3aKJ33n/sQtSnrQKD2JWXI7a0527wPsKJI83leVyS2QxkuT7lixK/8jCeRP5Auu99Ch0gTlyrCFgC+ZSSOxvenRKDh5MTBZH2KVUbkJQnoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746111411; c=relaxed/simple;
	bh=n/L8C0GKy6g5wlmu//LzN5lQ6qEXPVFT0RxwIFuU/LM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+mZ1JKReXnf8btjjWZq8YAN3OS9kHrYkaO2qaVWwJ6fZAryIbkyfkHAsLQRzbKqUn11Be0B/DzUHZNwyGZOBbaCZnsLMPI4CQTfgAL96os0yNKz6E3jiZNFoMoYB6TdDqEi25SXI0uSP+gZxZcTzSOCNSme4s2FWKS91sdQsMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BX9fzD29; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BX9fzD29"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541EtsEN027636
	for <dwarves@vger.kernel.org>; Thu, 1 May 2025 14:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=7lCV7
	dVqx+79xJF4Wgl34JpqVu3al7eJKC/JMk1VSCU=; b=BX9fzD29d3sZUWqCjVQbb
	8JdHvN+Bmtw9FMnpgVz6TSx/aKoH9kdtEhZ6SlnsbSqNJgTrmFqSBEqg6PQJqGdc
	FcYLwUx1DdA9yWd5i7ktSumOCUwq32ch9ptR2zdtnwDrfnd4Q+yxbAUogO5C+qQq
	4wrFNgkn3BEi8K7oTe6xS76l+ujkOEg75z+73meGRppjmCJHYtzDxzhFIwrwgIDy
	qxydJe0ABVIeFJm0to8sawdnUHJa3tcW6LXYGBfEeIGLxGCerzw/fYR5FP6xrupf
	tMIL75WG2XFYeEUKOau/3rFioxPVf4oVfQPaALzTswaSZ9n7DxpWLDlYhkqqOxrM
	w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uku73u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Thu, 01 May 2025 14:56:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541E1Dpi023886
	for <dwarves@vger.kernel.org>; Thu, 1 May 2025 14:56:48 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-61-155.vpn.oracle.com [10.154.61.155])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 468nxjv48n-3
	for <dwarves@vger.kernel.org>; Thu, 01 May 2025 14:56:47 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Subject: [RFC dwarves 2/3] dwarf_loader: make more effort to retrieve a function address
Date: Thu,  1 May 2025 15:56:44 +0100
Message-ID: <20250501145645.3317264-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250501145645.3317264-1-alan.maguire@oracle.com>
References: <20250501145645.3317264-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=803 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010112
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDExMyBTYWx0ZWRfX3JuCYUI8iDBb XUn/PLzQ/xTi2uPIIXTkj59VnQ8mLI8yOWNwM/l3OqEstEIRYDbuXZqx4/ik1ZutcQDkbqH3PTT E+xOot6I/eQths/puVHSD3eKJYF6DtoTTuygrw11Kfs1ufhFbwB1Uz8udmt5M+QEr7HurXhz3vK
 VMVk5VYLEZTGZsUI7xRE14Yrj2ZJ++C/XvDm92ZscFGCU+Tnz+BmjUNXiTzGmbRIh9sE6DWoWLO oWkQLKNx3q/uKWTFqn1weeYwUKMtrWUBJ+KAGJfsIn86KzCzDXs+9Efhpr+AFAUo8jM3xo16oCm bZ22AJtQSF+FyMjT6SmPQBm6P20WlAep6Wuu+Hd9sVFZLkLYWgPpeHDLDaL27I+fYDTVGUdQu/M
 RA9KAYbCy1vPKTCatGuwtohnTKKR1VRpKvqsdhWZZbQk2c6lKJQkEnOojVNqBEqyGSKoM+e8
X-Proofpoint-GUID: Wk_O1BEqtkcKrLAyp0yqoAxHrM4xrnlE
X-Authority-Analysis: v=2.4 cv=A5VsP7WG c=1 sm=1 tr=0 ts=68138bb0 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=Y1k84EBXKh9ucwFm3_QA:9 cc=ntf awl=host:13130
X-Proofpoint-ORIG-GUID: Wk_O1BEqtkcKrLAyp0yqoAxHrM4xrnlE

Many DW_AT_subroutine DIEs do not have address info associated
directly; some use DW_AT_ranges, and some have address info
stored with the associated abstract origin.  Use these information
sources to improve address retrieval for "struct function"
representations.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 dwarf_loader.c | 29 +++++++++++++++++++++++++----
 dwarves.h      |  3 ++-
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index e1ba7bc..d46e82a 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1519,6 +1519,17 @@ static struct function *function__new(Dwarf_Die *die, struct cu *cu, struct conf
 		func->vtable_entry    = -1;
 		if (dwarf_hasattr(die, DW_AT_vtable_elem_location))
 			func->vtable_entry = attr_offset(die, DW_AT_vtable_elem_location);
+		/* some functions will have entry address in the start address
+		 * in DW_AT_ranges.
+		 */
+		if (dwarf_hasattr(die, DW_AT_ranges)) {
+			Dwarf_Addr base, start, high_pc;
+			ptrdiff_t offset = 0;
+
+			dwarf_ranges(die, offset, &base, &start, &high_pc);
+			if (start)
+				func->addr = (uint64_t)start;
+		}
 		func->cu_total_size_inline_expansions = 0;
 		func->cu_total_nr_inline_expansions = 0;
 		func->priv = NULL;
@@ -2805,7 +2816,7 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
 	case DW_TAG_subprogram: {
 		struct function *fn = tag__function(tag);
 
-		if (fn->name == 0)  {
+		if (fn->name == 0 || function__addr(fn) == 0) {
 			if (dtag->abstract_origin == 0 &&
 			    dtag->specification == 0) {
 				/*
@@ -2818,9 +2829,19 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
 			dtype = dwarf_cu__find_tag_by_ref(cu->priv, dtag, abstract_origin);
 			if (dtype == NULL)
 				dtype = dwarf_cu__find_tag_by_ref(cu->priv, dtag, specification);
-			if (dtype != NULL)
-				fn->name = tag__function(dtag__tag(dtype))->name;
-			else {
+			if (dtype != NULL) {
+				struct function *dfn = tag__function(dtag__tag(dtype));
+				if (fn->name == 0)
+					fn->name = dfn->name;
+				/* share function address info between tag and
+				 * abstract origin.
+				 */
+				if (!function__addr(fn))
+					fn->addr = function__addr(dfn);
+				else if (!function__addr(dfn))
+					dfn->addr = function__addr(fn);
+			}
+			if (fn->name == 0) {
 				fprintf(stderr,
 					"%s: couldn't find name for "
 					"function %#llx, abstract_origin=%#llx,"
diff --git a/dwarves.h b/dwarves.h
index 36c6898..847e13d 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -1081,6 +1081,7 @@ struct function {
 	const char	 *name;
 	const char	 *linkage_name;
 	const char	 *alias;	/* name.isra.0 */
+	uint64_t	 addr;
 	uint32_t	 cu_total_size_inline_expansions;
 	uint16_t	 cu_total_nr_inline_expansions;
 	uint8_t		 inlined:2;
@@ -1146,7 +1147,7 @@ const char *function__prototype_conf(const struct function *func,
 
 static __pure inline uint64_t function__addr(const struct function *func)
 {
-	return func->lexblock.ip.addr;
+	return func->lexblock.ip.addr ?: func->addr;
 }
 
 static __pure inline uint32_t function__size(const struct function *func)
-- 
2.39.3

