Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899971779A9
	for <dwarves@vger.kernel.org>; Mon, 30 Sep 2024 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727684293; cv=none; b=P65jAIyURGez28NP4jFiU5kcbadJi01UnXD78NN5O7r0MTpFpjsOZegZrdGd/MGW5OfPSn/++kNoSAJNQ46R0fh8ZtC1iLQ4vDDZel4sa/OA50a8hZh2WtfK4th3FnR3/JMGgOI67isbNgIrM94vK9iijJJFvtLjWy+bfw7l5oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727684293; c=relaxed/simple;
	bh=CM7UgBTe/vTempblGFTiUuw5bm4tO8q9BjvjZWkParU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZbkwHp7Pz6RvcUpYG4Lnka4G8XuDigwVV4flsrTHsj4/waCswOERpttcbz9bsdxH+HImFZxXFHZcRnngSfGcVJ+JgEueaS8KgwELqXiEZqV3r/nrKMwakdm1xfI6jkaCYOclR7WDVaz358I2wUdcb0NnPx5ehVaLzSHmQHxRbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=USpAE86z; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="USpAE86z"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U2tunK023839;
	Mon, 30 Sep 2024 08:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=S
	c4nKIv+fbEx9ih7aL7sQKc3+5ZelNRzCN4rqXDD05o=; b=USpAE86zktXPOIXjd
	IgNPV74N8Nn1KXX8fGKtnYYr/34jC4moOphNhw2OMNeXO/ffHet/ZgPi/Fu9aKoc
	401gGsalpYOmb3mBJ6Zaar51UWq3Il9gTnwD4Jsk89fY6gj+9+4eBbZm230k4Kdj
	DapuxsSwx9UinmFfbnzLxbzeSie084A9L7wxmMrNNBLHkLw2flD/oS0WSQOkUUtS
	35tMJ4OkELc/YZDBtbPrO+STZLcjbHyHiQ/qPzwu3mSoijQ3b0hSCUAwoq7H81bQ
	ASx0nMOxA0WwwsspovdiwmUo6M9EjhiR6YVqh4qMRyo2T1w6M+tO00ZPjFsroOio
	Yp2EA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41xabtjkn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 08:17:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48U7whix040487;
	Mon, 30 Sep 2024 08:17:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x885qhg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 08:17:31 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48U8HSoC017104;
	Mon, 30 Sep 2024 08:17:30 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-219-134.vpn.oracle.com [10.175.219.134])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41x885qheg-2;
	Mon, 30 Sep 2024 08:17:30 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, eddyz87@gmail.com, olsajiri@gmail.com,
        shung-hsi.yu@suse.com, jirislaby@kernel.org, sedat.dilek@gmail.com,
        w@1wt.eu, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 dwarves 1/2] btf_encoder: fix strncpy issues, other issues identified in code review
Date: Mon, 30 Sep 2024 09:17:24 +0100
Message-ID: <20240930081725.2465825-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240930081725.2465825-1-alan.maguire@oracle.com>
References: <20240930081725.2465825-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-30_07,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409300059
X-Proofpoint-ORIG-GUID: 2YeD6QQK5uQuoxfIjOGIQs0tX7jJ0y-h
X-Proofpoint-GUID: 2YeD6QQK5uQuoxfIjOGIQs0tX7jJ0y-h

- fixed checks of func->state since it is always non-NULL and removed
  now-unneeded fields from dwarves.h; added assertions that either
  ELF or DWARF data is present for func encoding (Jiri)
- fixed strncpy() issues, improved equality comparions between types
  (Eduard)

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 68 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 22 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index d535b90..92dc5c4 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -28,6 +28,7 @@
 
 #include <unistd.h>
 
+#include <assert.h>
 #include <errno.h>
 #include <stdint.h>
 #include <search.h> /* for tsearch(), tfind() and tdestroy() */
@@ -692,7 +693,8 @@ static int32_t btf_encoder__tag_type(struct btf_encoder *encoder, uint32_t tag_t
 	return encoder->type_id_off + tag_type;
 }
 
-static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct ftype *ftype, struct elf_function *func)
+static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct ftype *ftype,
+					   struct elf_function *func)
 {
 	struct btf *btf = encoder->btf;
 	const struct btf_type *t;
@@ -701,16 +703,22 @@ static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct f
 	int32_t id, type_id;
 	char tmp_name[KSYM_NAME_LEN];
 	const char *name;
-	struct btf_encoder_func_state *state = &func->state;
+	struct btf_encoder_func_state *state;
+
+	assert(ftype != NULL || func != NULL);
 
 	/* add btf_type for func_proto */
 	if (ftype) {
 		nr_params = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
 		type_id = btf_encoder__tag_type(encoder, ftype->tag.type);
-	} else {
+	} else if (func) {
+		state = &func->state;
 		nr_params = state->nr_parms;
 		type_id = state->ret_type_id;
+	} else {
+		return 0;
 	}
+
 	id = btf__add_func_proto(btf, type_id);
 	if (id > 0) {
 		t = btf__type_by_id(btf, id);
@@ -730,25 +738,29 @@ static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct f
 
 			type_id = param->tag.type == 0 ? 0 : encoder->type_id_off + param->tag.type;
 			++param_idx;
-			if (btf_encoder__add_func_param(encoder, name, type_id, param_idx == nr_params))
+			if (btf_encoder__add_func_param(encoder, name, type_id,
+							param_idx == nr_params))
 				return -1;
 		}
 
 		++param_idx;
 		if (ftype->unspec_parms)
-			if (btf_encoder__add_func_param(encoder, NULL, 0, param_idx == nr_params))
+			if (btf_encoder__add_func_param(encoder, NULL, 0,
+							param_idx == nr_params))
 				return -1;
 	} else {
 		for (param_idx = 0; param_idx < nr_params; param_idx++) {
 			struct btf_encoder_func_parm *p = &state->parms[param_idx];
+
 			name = btf__name_by_offset(btf, p->name_off);
 
 			/* adding BTF data may result in a move of the
 			 * name string memory, so make a temporary copy.
 			 */
-			strncpy(tmp_name, name, sizeof(tmp_name));
+			strncpy(tmp_name, name, sizeof(tmp_name) - 1);
 
-			if (btf_encoder__add_func_param(encoder, tmp_name, p->type_id, param_idx == nr_params))
+			if (btf_encoder__add_func_param(encoder, tmp_name, p->type_id,
+							param_idx == nr_params))
 				return -1;
 		}
 	}
@@ -950,10 +962,17 @@ static bool types__match(struct btf_encoder *encoder,
 			return false;
 		}
 
-		switch (btf_kind(t1)) {
+		switch (k1) {
 		case BTF_KIND_INT:
+			if (t1->size != t2->size)
+				return false;
+			if (*(__u32 *)(t1 + 1) != *(__u32 *)(t2 + 1))
+				return false;
+			return names__match(btf1, t1, btf2, t2);
 		case BTF_KIND_FLOAT:
-		case BTF_KIND_FWD:
+			if (t1->size != t2->size)
+				return false;
+			return names__match(btf1, t1, btf2, t2);
 		case BTF_KIND_TYPEDEF:
 		case BTF_KIND_STRUCT:
 		case BTF_KIND_UNION:
@@ -1009,9 +1028,6 @@ static bool funcs__match(struct btf_encoder *encoder, struct elf_function *func,
 {
 	uint8_t i;
 
-	if (!s1->initialized || !s2->initialized)
-		return true;
-
 	if (s1->nr_parms != s2->nr_parms) {
 		btf_encoder__log_func_skip(encoder, func,
 					   "param count mismatch; %d params != %d params\n",
@@ -1081,7 +1097,8 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 			goto out;
 		}
 		state.parms[param_idx].name_off = str_off;
-		state.parms[param_idx].type_id = param->tag.type == 0 ? 0 : encoder->type_id_off + param->tag.type;
+		state.parms[param_idx].type_id = param->tag.type == 0 ? 0 :
+						encoder->type_id_off + param->tag.type;
 		param_idx++;
 	}
 	if (ftype->unspec_parms)
@@ -1139,7 +1156,8 @@ out:
 	return err;
 }
 
-static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct function *fn, struct elf_function *func)
+static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct function *fn,
+				     struct elf_function *func)
 {
 	int btf_fnproto_id, btf_fn_id, tag_type_id = 0;
 	int16_t component_idx = -1;
@@ -1147,19 +1165,23 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct functio
 	const char *value;
 	char tmp_value[KSYM_NAME_LEN];
 
+	assert(fn != NULL || func != NULL);
+
 	btf_fnproto_id = btf_encoder__add_func_proto(encoder, fn ? &fn->proto : NULL, func);
 	name = func->alias ?: func->name;
 	if (btf_fnproto_id >= 0)
-		btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id, name, false);
+		btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id,
+						      name, false);
 	if (btf_fnproto_id < 0 || btf_fn_id < 0) {
-		printf("error: failed to encode function '%s': invalid %s\n", name, btf_fnproto_id < 0 ? "proto" : "func");
+		printf("error: failed to encode function '%s': invalid %s\n",
+		       name, btf_fnproto_id < 0 ? "proto" : "func");
 		return -1;
 	}
 	if (!fn) {
 		struct btf_encoder_func_state *state = &func->state;
 		uint16_t idx;
 
-		if (!state || state->nr_annots == 0)
+		if (state->nr_annots == 0)
 			return 0;
 
 		for (idx = 0; idx < state->nr_annots; idx++) {
@@ -1169,10 +1191,11 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct functio
 			/* adding BTF data may result in a mode of the
 			 * value string memory, so make a temporary copy.
 			 */
-			strncpy(tmp_value, value, sizeof(tmp_value));
+			strncpy(tmp_value, value, sizeof(tmp_value) - 1);
 			component_idx = a->component_idx;
 
-			tag_type_id = btf_encoder__add_decl_tag(encoder, tmp_value, btf_fn_id, component_idx);
+			tag_type_id = btf_encoder__add_decl_tag(encoder, tmp_value,
+								btf_fn_id, component_idx);
 			if (tag_type_id < 0)
 				break;
 		}
@@ -1190,7 +1213,8 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct functio
 		}
 	}
 	if (tag_type_id < 0) {
-		fprintf(stderr, "error: failed to encode tag '%s' to func %s with component_idx %d\n",
+		fprintf(stderr,
+			"error: failed to encode tag '%s' to func %s with component_idx %d\n",
 			value, name, component_idx);
 		return -1;
 	}
@@ -1207,7 +1231,7 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
 		struct btf_encoder_func_state *state = &func->state;
 		struct btf_encoder *other_encoder = NULL;
 
-		if (!state || !state->initialized || state->processed)
+		if (!state->initialized || state->processed)
 			continue;
 		/* merge optimized-out status across encoders; since each
 		 * encoder has the same elf symbol table we can use the
@@ -1223,7 +1247,7 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder)
 
 			other_func = &other_encoder->functions.entries[i];
 			other_state = &other_func->state;
-			if (!other_state)
+			if (!other_state->initialized)
 				continue;
 			optimized = state->optimized_parms | other_state->optimized_parms;
 			unexpected = state->unexpected_reg | other_state->unexpected_reg;
-- 
2.43.5

