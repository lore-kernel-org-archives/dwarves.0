Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270D21F8EEF
	for <dwarves@vger.kernel.org>; Thu,  1 May 2025 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746111412; cv=none; b=mKp0HKUG4q5zuuVspj1YgBc3j7gjhAluqdpCXT1V9m23U/d/aCho6HShMwx46zHyobO5HYtJYqeSPsWYbKC7LoDHst6ZccQok0WOBQsQY1DYIWTyXm+b03HYb5g2NTht9ItuECKvtX4bVZaqH7nsq9Wqr2dOo2ataJjCbKv+1eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746111412; c=relaxed/simple;
	bh=dkQizmCLOuC5JQB/VIGFfFoPzyykRh4wO8T+WhrM7L4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWV/mJ73b+MpH2kvMT8KsbzR121oNUEdITIk+F4xaQ7sx1Q04uRAKSR73nSbK8YX3cq57/LFiRhQstjZkIz+KTHLRbXI13Rx+ZLZ+uJSKHNtUQcqoitfflmqk3/XtYoj8rWQdsW4xhDBYOn79kcU9qxryx+OoyMUTQuHhPa7dlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QLD2keK6; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QLD2keK6"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541Etw8M013732
	for <dwarves@vger.kernel.org>; Thu, 1 May 2025 14:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=vE0Rm
	NBcMk5WccV9cjDf1zd8Cv2PVw4LygU1kN+jvo0=; b=QLD2keK6R1Mktudaovo/q
	Xu7JWTvyfK/kQjQsOaiVZNcyMQuF818Ye/JCbUCl48gyTsSkmYYM5Zz96Jx5N8NE
	K09JZ8w1h5Ax2bMj677mqCzXXzMUzrZ1UIT7CgXXXtyFvveCgPxXAEVmfDzS+GJI
	iKhueu7lzWXSqnLWbZx8cPYd0z4UqyMeo2OpTD2of1LAjAisyH1gEQluud2JKsK5
	KfO7lNJIHB7o5F9JKrZ/dTfPvdPf5aMoCg4cIm1auJ2tc7q9Wn8At6USVy+/Cs4E
	LCOWeIqoCv+o9p+e+3p2QGyiOQraRUHhxR7bEVGc7KpEfl3qFUR3OgoEn/lM/7i/
	A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uqk76h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Thu, 01 May 2025 14:56:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541E1Dpj023886
	for <dwarves@vger.kernel.org>; Thu, 1 May 2025 14:56:48 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-61-155.vpn.oracle.com [10.154.61.155])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 468nxjv48n-4
	for <dwarves@vger.kernel.org>; Thu, 01 May 2025 14:56:48 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Subject: [RFC dwarves 3/3] btf_encoder: use function address to match ELF -> DWARF
Date: Thu,  1 May 2025 15:56:45 +0100
Message-ID: <20250501145645.3317264-4-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010112
X-Proofpoint-ORIG-GUID: ZzYVrK4ThQvEaO9jDE6IuQflI2UehibI
X-Authority-Analysis: v=2.4 cv=Vq8jA/2n c=1 sm=1 tr=0 ts=68138bb2 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=tREYmHnD4dNlNo05J5MA:9 cc=ntf awl=host:13130
X-Proofpoint-GUID: ZzYVrK4ThQvEaO9jDE6IuQflI2UehibI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDExMyBTYWx0ZWRfX/j1yA7CNtMuJ SAE8vbTwEbw5H1QCK/14u7Hud689wZun5mLru1pqygS5zaECtkbVkRsCffG4WUC/ocdNT14a0vJ bJwyS5gvK30/+Pu/T4TNBbhgqzqQ0/YwmvjPBLH5ioGuAb1TyNYEiTeAQXOC2ylA0/hE3DwLnz0
 QnfDEN+obZoWUC3VMuZAzKAsiiwOfOjmQAFMi52jb2cPfxHu+A3vuqRTFG/CSAZiWFh2MGyoJqv 9xy2YDXxoXjTR+6+DXbP6c/jvABdNrB45Kxcr648mBVqPqsxGhTULy7ifR1EbqE7mtslALWSUuZ HLpIR9ZDeRSk6uUnvjoa/HvXMmSWzpJhz0UUORz7j4HImlrjTHvwdDfZZrK8nXBUAJA/BSmA/Sc
 vAi4WNVaXH5LUAuvAnKoyPHwCy5V+1tZnXnWmURjWWc2U9S28p3dYAsem3IZNuXmyca7cHRH

Currently we use function names (or prefixes in the case of
foo.isra.0) to match betwen ELF symtab entries and DWARF
representations.  This can lead to wrong matches, especially
where optimized function representations are concerned.  Instead
sort and search ELF functions by address, and use the retrieved
"struct function" address to carry out DWARF->ELF matches.

Note this is work-in-progress and many functions are missing as
many functions do not have - or at least we have not retrieved -
address info associated with their DWARF representations.

As things stand, there are exactly 1000 functions missing from
BTF encoded using the address-based approach, since we skip functions
for which we have no address info.  This approach actually adds
63 functions, so there are effectively 1063 missing functions.

485 of these missing functions are __probestub functions we do not need, i.e.

[66116] FUNC '__probestub_xhci_setup_device' type_id=61452 linkage=static
[61452] FUNC_PROTO '(anon)' ret_type_id=0 vlen=2
        '__data' type_id=108
        'vdev' type_id=44186

The real function is:

[147543] FUNC 'xhci_setup_device' type_id=147542 linkage=static
[147542] FUNC_PROTO '(anon)' ret_type_id=21 vlen=4
        'hcd' type_id=37057
        'udev' type_id=37029
        'setup' type_id=44209
        'timeout_ms' type_id=9

This leaves us with a mismatch of 578 functions.  These include
140 missing __bpf_trace_ functions, which are definitely needed.

So perhaps we can fix up our DWARF representation to find associated
addresses for some/all of these, but we may end up having to fall
back to name-based association for some cases.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 78 ++++++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 38 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index b1e64d1..f4fd937 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1344,12 +1344,7 @@ static int functions_cmp(const void *_a, const void *_b)
 	const struct elf_function *a = _a;
 	const struct elf_function *b = _b;
 
-	/* if search key allows prefix match, verify target has matching
-	 * prefix len and prefix matches.
-	 */
-	if (a->prefixlen && a->prefixlen == b->prefixlen)
-		return strncmp(a->name, b->name, b->prefixlen);
-	return strcmp(a->name, b->name);
+	return a->addr - b->addr;
 }
 
 #ifndef max
@@ -1358,10 +1353,15 @@ static int functions_cmp(const void *_a, const void *_b)
 
 static int saved_functions_cmp(const void *_a, const void *_b)
 {
-	const struct btf_encoder_func_state *a = _a;
-	const struct btf_encoder_func_state *b = _b;
+	const struct elf_function *a = ((const struct btf_encoder_func_state *)_a)->elf;
+	const struct elf_function *b = ((const struct btf_encoder_func_state *)_b)->elf;
 
-	return functions_cmp(a->elf, b->elf);
+	/* if search key allows prefix match, verify target has matching
+	 * prefix len and prefix matches.
+	 */
+	if (a->prefixlen && a->prefixlen == b->prefixlen)
+		return strncmp(a->name, b->name, b->prefixlen);
+	return strcmp(a->name, b->name);
 }
 
 static int saved_functions_combine(struct btf_encoder_func_state *a, struct btf_encoder_func_state *b)
@@ -1457,12 +1457,14 @@ static void elf_functions__collect_function(struct elf_functions *functions, GEl
 		return;
 
 	name = elf_sym__name(sym, functions->symtab);
-	if (!name)
+	if (!name || strstr(name, ".cold."))
 		return;
 
 	func = &functions->entries[functions->cnt];
-	func->name = name;
 	func->addr = elf_sym__value(sym);
+	if (!func->addr)
+		return;
+	func->name = name;
 	if (strchr(name, '.')) {
 		const char *suffix = strchr(name, '.');
 
@@ -1493,10 +1495,10 @@ static struct elf_functions *btf_encoder__elf_functions(struct btf_encoder *enco
 }
 
 static struct elf_function *btf_encoder__find_function(const struct btf_encoder *encoder,
-						       const char *name, size_t prefixlen)
+						       uint64_t addr) 
 {
 	struct elf_functions *funcs = elf_functions__find(encoder->cu->elf, &encoder->elf_functions_list);
-	struct elf_function key = { .name = name, .prefixlen = prefixlen };
+	struct elf_function key = { .addr = addr };
 
 	return bsearch(&key, funcs->entries, funcs->cnt, sizeof(key), functions_cmp);
 }
@@ -2019,6 +2021,7 @@ static int btf_encoder__collect_kfuncs(struct btf_encoder *encoder)
 		struct elf_function *elf_fn;
 		unsigned int ranges_cnt;
 		char *func, *name;
+		uint64_t addr;
 		ptrdiff_t off;
 		GElf_Sym sym;
 		bool found;
@@ -2036,6 +2039,9 @@ static int btf_encoder__collect_kfuncs(struct btf_encoder *encoder)
 		func = get_func_name(name);
 		if (!func)
 			continue;
+		addr = elf_sym__value(&sym);
+		if (!addr)
+			continue;
 
 		/* Check if function belongs to a kfunc set */
 		ranges = gobuffer__entries(&btf_kfunc_ranges);
@@ -2062,7 +2068,7 @@ static int btf_encoder__collect_kfuncs(struct btf_encoder *encoder)
 			continue;
 		}
 
-		elf_fn = btf_encoder__find_function(encoder, func, 0);
+		elf_fn = btf_encoder__find_function(encoder, addr);
 		if (elf_fn) {
 			elf_fn->kfunc = true;
 			elf_fn->kfunc_flags = pair->flags;
@@ -2658,35 +2664,31 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 			continue;
 		if (funcs->cnt) {
 			const char *name;
+			uint64_t addr;
 
 			name = function__name(fn);
 			if (!name)
 				continue;
+			addr = function__addr(fn);
+			if (encoder->verbose)
+				printf("function '%s' addr 0x%lx\n",
+				       name, addr);
+			if (!addr)
+				continue;
 
-			/* prefer exact function name match... */
-			func = btf_encoder__find_function(encoder, name, 0);
-			if (!func && funcs->suffix_cnt &&
-			    conf_load->btf_gen_optimized) {
-				/* falling back to name.isra.0 match if no exact
-				 * match is found; only bother if we found any
-				 * .suffix function names.  The function
-				 * will be saved and added once we ensure
-				 * it does not have optimized-out parameters
-				 * in any cu.
-				 */
-				func = btf_encoder__find_function(encoder, name,
-								  strlen(name));
-				if (func) {
-					if (encoder->verbose)
-						printf("matched function '%s' with '%s'%s\n",
-						       name, func->name,
-						       fn->proto.optimized_parms ?
-						       ", has optimized-out parameters" :
-						       fn->proto.unexpected_reg ? ", has unexpected register use by params" :
-						       "");
-					if (!func->alias)
-						func->alias = strdup(name);
-				}
+			func = btf_encoder__find_function(encoder, addr);
+			if (func && strchr(func->name, '.')) {
+				if (!conf_load->btf_gen_optimized) {
+					continue;
+				} else if (encoder->verbose)
+					printf("matched function '%s' with '%s'%s\n",
+					       name, func->name,
+					       fn->proto.optimized_parms ?
+					       ", has optimized-out parameters" :
+					       fn->proto.unexpected_reg ? ", has unexpected register use by params" :
+					       "");
+				if (!func->alias)
+					func->alias = strdup(name);
 			}
 		} else {
 			if (!fn->external)
-- 
2.39.3

