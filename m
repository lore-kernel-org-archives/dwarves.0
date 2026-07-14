Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717D6207DF7;
	Tue, 14 Jul 2026 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037048; cv=none; b=j3dFYKM6UxDeJNQGI1BKDtRXRRzkrG2CoeBDWCXBFQgaJxlysSKxknHrWDfyJM0rC1ccUeqW7mmhEAgYoH2tdk/QboR29VG2ZBXo0GaZovPYGe43jNDnqfgw8sYnCUAFPvpA8cjnUGaNVUv482oyhrB9cpBQRzR21KKN47FH04o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037048; c=relaxed/simple;
	bh=eb7Wg99SqP1/Uj7f+PQPKr5nKmnahVoc+rU1osGLDZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PG3+l3s51kyMFgpGC1DKGA6GgdeDG9Onj2RtnCWXyXiozaKkF0xr17b0OdteoBpkPLes/1oYn6xwIiWh7IsJqdaIdrslKiRNZWmWKgz1SqeNvFozUUwbBdV7vAyn27MBXEngYkCE0qxAEKXPCwkicMhFNvPZsMb3VNn+4QtHc94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=msvetfZZ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="msvetfZZ"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBnWgV1376579;
	Tue, 14 Jul 2026 13:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=PREiQ
	5WktrqOelL6zLhfK8jb5Egsp3dhvHrd02REZKA=; b=msvetfZZoTepcAsPy0XIh
	OG74ToUWQeOQ8DFAn0XJA+LerQhuieuEfpl9ge7pNuzOMYPWvDs5aDqXKVFrm0hy
	rYM46jC+0GhpzCr1iDxpK39nteALmU7pEdNj/PO1RcGQpy12jSKD6Yq74NYJ3pzG
	bnqxM2Q8sWFN9YyBRpzBFf+ZLVKyDzW4nCS7vE9mWX4JqvPZV7jbQ02exL7CnkqK
	Un2ME36/QNjFziArgIz7qPZoK0/JMFpGC2bgQbpwwFTQdbIjoH7WM+GD/4pujxg+
	8k5A+wwvg81izRBwsznqQHNIWK11I0McNNGl7MLgacjkOFQqNZpT1V1jYnhX+uYN
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbeedm6n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 13:50:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66EDm8LU032350;
	Tue, 14 Jul 2026 13:50:39 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-49.vpn.oracle.com [10.154.50.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4fbc9dtr8p-2;
	Tue, 14 Jul 2026 13:50:39 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: yonghong.song@linux.dev, olsajiri@gmail.com
Cc: arnaldo.melo@gmail.com, bpf@vger.kernel.org, dwarves@vger.kernel.org
Subject: [PATCH dwarves 1/2] btf_encoder: Only skip optimized parms when ABI changed
Date: Tue, 14 Jul 2026 14:50:34 +0100
Message-ID: <20260714135035.814273-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260714135035.814273-1-alan.maguire@oracle.com>
References: <20260714135035.814273-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607140144
X-Authority-Analysis: v=2.4 cv=d+bFDxjE c=1 sm=1 tr=0 ts=6a563eb0 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=JilMT0JfPp54oRQC3lIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE0MyBTYWx0ZWRfX2s6Pqesv6nXe
 8mrwklwwOiIepFwfg5B3uUUmhe2NarSz2zC7Bcm3rzu5bydAU/ADPhB2RtawORCYWG8mylEM5D5
 ibpDBrLetKQflMdgeJKcLUvjR5sE4EK9w40WubKg4CAka1oR8ikdkshzXMfUyeSLQk8X3u24K/Q
 LXBGRTDAG0YFJpO0jFXiqPKAUb3KD303VTTvCHOIpnyPywfDoSaK6ZUM05ymu+0tnSwAY2pJYtn
 6W5zYfmSdWvEcj1CCscxuIzkBn4LRrn6PvZVC7HICc3nSrkI4ty44aHVA1QvtLt+/0rfvMGHshy
 +wAyhMKPYVFFdR3ltQZHvuKwZ4I1IDoO4do+heaSgq9UJDBUX2Yi9BUSPdVCWiqzUr6ssdhBKWz
 y/9uWG6+7ToX+J0CxYZaKOCsJkaj3REBfBQ2udP9pdEDlUTtfQLAxk2nS4hWAnihhT1Xl/TA2rp
 46yfdn269Jjtkh+SG6g==
X-Proofpoint-GUID: UgUXiZbK5Sp3lwUZDnjjUad1W9RP3b0S
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE0MyBTYWx0ZWRfX6p88KqjVdOT1
 jMR/YUpZ3pBE6S+B8EugwlRNYaDcDT36V8brMd2DRzF+HNvty1mP9544+FHp+n88TY0ijiwYX3S
 vABa6go9yIuHpoWqEaoOGwGvsUrSuO4ZglzgvtazRZcpT33ZNeWs
X-Proofpoint-ORIG-GUID: UgUXiZbK5Sp3lwUZDnjjUad1W9RP3b0S

The true-signature series made optimized-parameter state more visible to
the BTF encoder.  Skipping every function with optimized parameters is too
broad, though: an unused parameter can still be part of the real calling
ABI, so default BTF should continue to encode that function.

Limit the optimized-parameter skip to cases where default BTF cannot
represent the concrete ABI safely:
 - clang functions marked as signature-changed via DW_CC_nocall
 - GCC optimized clones with ELF suffixes such as .isra or .constprop

When multiple saved states share the same base ELF function, prefer a
canonical state that does not require this optimized-parameter skip, so a
usable concrete instance is not dropped just because another optimized clone
exists.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 97 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 73 insertions(+), 24 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 38455a4..2e6eab0 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -95,6 +95,8 @@ struct btf_encoder_func_state {
 	uint8_t inconsistent_proto:1;
 	uint8_t uncertain_parm_loc:1;
 	uint8_t reordered_parm:1;
+	uint8_t signature_changed:1;
+	uint8_t optimized_symbol:1;
 	uint8_t ambiguous_addr:1;
 	int ret_type_id;
 	struct btf_encoder_func_parm *parms;
@@ -1209,27 +1211,44 @@ static struct btf_encoder_func_state *btf_encoder__alloc_func_state(struct btf_e
 	return state;
 }
 
-/* some "." suffixes do not correspond to real functions;
- * - .part for partial inline
- * - .cold for rarely-used codepath extracted for better code locality
- */
-static bool str_contains_non_fn_suffix(const char *str) {
-	static const char *skip[] = {
-		".cold",
-		".part"
-	};
+static bool str_contains_suffix(const char *str, const char * const *suffixes, int nr_suffixes)
+{
 	const char *suffix = strchr(str, '.');
 	int i;
 
 	if (!suffix)
 		return false;
-	for (i = 0; i < ARRAY_SIZE(skip); i++) {
-		if (strstr(suffix, skip[i]))
+	for (i = 0; i < nr_suffixes; i++) {
+		if (strstr(suffix, suffixes[i]))
 			return true;
 	}
 	return false;
 }
 
+/* some "." suffixes do not correspond to real functions;
+ * - .part for partial inline
+ * - .cold for rarely-used codepath extracted for better code locality
+ */
+static bool str_contains_non_fn_suffix(const char *str)
+{
+	static const char * const skip[] = {
+		".cold",
+		".part"
+	};
+
+	return str_contains_suffix(str, skip, ARRAY_SIZE(skip));
+}
+
+static bool str_contains_optimized_fn_suffix(const char *str)
+{
+	static const char * const suffixes[] = {
+		".constprop",
+		".isra",
+	};
+
+	return str_contains_suffix(str, suffixes, ARRAY_SIZE(suffixes));
+}
+
 static bool elf_function__has_ambiguous_address(struct elf_function *func)
 {
 	struct elf_function_sym *sym;
@@ -1295,6 +1314,17 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 	state->optimized_parms = ftype->optimized_parms;
 	state->uncertain_parm_loc = ftype->uncertain_parm_loc;
 	state->reordered_parm = ftype->reordered_parm;
+	state->signature_changed = ftype->signature_changed;
+	if (state->addr) {
+		for (int i = 0; i < func->sym_cnt; i++) {
+			if (state->addr != func->syms[i].addr)
+				continue;
+			if (str_contains_optimized_fn_suffix(func->syms[i].name)) {
+				state->optimized_symbol = 1;
+				break;
+			}
+		}
+	}
 	ftype__for_each_parameter(ftype, param) {
 		const char *name;
 		char *final_name = NULL;
@@ -1497,19 +1527,17 @@ static int saved_functions_combine(struct btf_encoder *encoder,
 				   struct btf_encoder_func_state *a,
 				   struct btf_encoder_func_state *b)
 {
-	uint8_t optimized, unexpected, inconsistent, uncertain_parm_loc, reordered_parm;
+	uint8_t unexpected, inconsistent, uncertain_parm_loc, reordered_parm;
 
 	if (a->elf != b->elf)
 		return 1;
 
-	optimized = a->optimized_parms | b->optimized_parms;
 	unexpected = a->unexpected_reg | b->unexpected_reg;
 	inconsistent = a->inconsistent_proto | b->inconsistent_proto;
 	uncertain_parm_loc = a->uncertain_parm_loc | b->uncertain_parm_loc;
 	reordered_parm = a->reordered_parm | b->reordered_parm;
 	if (!unexpected && !inconsistent && !reordered_parm && !funcs__match(encoder, a, b))
 		inconsistent = 1;
-	a->optimized_parms = b->optimized_parms = optimized;
 	a->unexpected_reg = b->unexpected_reg = unexpected;
 	a->inconsistent_proto = b->inconsistent_proto = inconsistent;
 	a->uncertain_parm_loc = b->uncertain_parm_loc = uncertain_parm_loc;
@@ -1574,7 +1602,16 @@ static int btf_encoder__add_true_signature(struct btf_encoder *encoder,
 	return 0;
 }
 
-static struct btf_encoder_func_state *btf_encoder__select_canonical_state(struct btf_encoder_func_state *combined_states,
+static bool btf_encoder_func_state__skip_optimized_parms(struct btf_encoder *encoder,
+							 struct btf_encoder_func_state *state)
+{
+	return !encoder->true_signature &&
+	       state->optimized_parms &&
+	       (state->signature_changed || state->optimized_symbol);
+}
+
+static struct btf_encoder_func_state *btf_encoder__select_canonical_state(struct btf_encoder *encoder,
+									  struct btf_encoder_func_state *combined_states,
 									  int combined_cnt)
 {
 	int i, j;
@@ -1584,17 +1621,22 @@ static struct btf_encoder_func_state *btf_encoder__select_canonical_state(struct
 	 * as per saved_functions_combine().
 	 */
 	struct elf_function *elf = combined_states[0].elf;
+	struct btf_encoder_func_state *first = NULL;
 
 	for (i = 0; i < combined_cnt; i++) {
 		struct btf_encoder_func_state *state = &combined_states[i];
 
 		for (j = 0; j < elf->sym_cnt; j++) {
-			if (state->addr == elf->syms[j].addr)
+			if (state->addr != elf->syms[j].addr)
+				continue;
+			if (!first)
+				first = state;
+			if (!btf_encoder_func_state__skip_optimized_parms(encoder, state))
 				return state;
 		}
 	}
 
-	return &combined_states[0];
+	return first ?: &combined_states[0];
 }
 
 static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_encoding_inconsistent_proto)
@@ -1613,6 +1655,7 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
 
 	for (i = 0; i < nr_saved_fns; i = j) {
 		struct btf_encoder_func_state *state = &saved_fns[i];
+		struct btf_encoder_func_state *canonical_state;
 		char *skip_reason = NULL;
 
 		/* Compare across sorted functions that match by name/prefix;
@@ -1640,11 +1683,16 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
 			}
 		}
 
-		/* do not exclude functions with optimized-out parameters; they
-		 * may still be _called_ with the right parameter values, they
-		 * just do not _use_ them.  Only exclude functions with
-		 * unexpected register use, multiple inconsistent prototypes or
-		 * uncertain parameters location
+		canonical_state = j - i > 1 ?
+			btf_encoder__select_canonical_state(encoder, state, j - i) : state;
+
+		/* Do not exclude functions with optimized-out parameters by
+		 * default; they may still be called with the right parameter
+		 * values, and just not use them.  Exclude optimized parameters
+		 * only when default BTF cannot represent a changed ABI
+		 * signature; true_signature can rewrite those signatures.
+		 * Also exclude functions with unexpected register use, multiple
+		 * inconsistent prototypes or uncertain parameter locations.
 		 */
 		if (state->unexpected_reg)
 			skip_reason = "unexpected register usage for parameter\n";
@@ -1654,6 +1702,8 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
 			skip_reason = "uncertain parameter location\n";
 		if (state->reordered_parm)
 			skip_reason = "reordered parameters\n";
+		if (btf_encoder_func_state__skip_optimized_parms(encoder, canonical_state))
+			skip_reason = "optimized parameters\n";
 		if (state->elf->ambiguous_addr)
 			skip_reason = "ambiguous address\n";
 
@@ -1669,8 +1719,7 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
 			 * select and emit BTF for the most canonical
 			 * function definition.
 			 */
-			if (j - i > 1)
-				state = btf_encoder__select_canonical_state(state, j - i);
+			state = canonical_state;
 			if (is_kfunc_state(state))
 				err = btf_encoder__add_bpf_kfunc(encoder, state);
 			else
-- 
2.43.5

