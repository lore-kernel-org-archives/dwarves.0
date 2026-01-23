Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C298A2E62D1;
	Fri, 23 Jan 2026 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769189227; cv=none; b=GWo/h8vS/fekyawar9NYoXdykRrSAybS6gmHUnSuAq7jupBQkrUGz6FpZbOxl/w2mEOXkfx2fKgBkZu26thKpkDuaqXGuoZ6bPTc0/lNC2QKp45kgD70hxXOLufd0hSqaUmAh+2OOxr7AbUyPgrSDv8Y6Xtu88+xnbSHZ8atXOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769189227; c=relaxed/simple;
	bh=PwWDGx2Vev3It0V3+YCscw6jD22e92gUgv3l/9nz8DI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HicQQORbTvXb+tR3jpihCTzQf2nxHvPKFg0YDCnwEu4v6mGVWG7DORBOjGisH1QYFwUG/dW516KEiQDm+pptdOZgj0ucJ50uxKTZgfoVtpx6kfRLbhtYMHcJPPuKD7bgMVZyXdtcmfx8qAHPyVbKaUdnZg2cVJyed67qn9vy/1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MMHRi6AY; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MMHRi6AY"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NEH9p61631837;
	Fri, 23 Jan 2026 17:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=lvjPn
	6oasHP8SSFGsXCDq00WViT+7ybt5a3emQYBds8=; b=MMHRi6AYJ0ZnWyW9zOQ46
	DLVDp0sPpjZWW8jFEg/MI4p6Jix3GwKY1NTr7mmbGKpV+sG+gwvdhxuYptxDlTVI
	APv5WXixWXJu8xBEo7yr9A5Q4MCfJLLMmbQ/iSZ/WrDYBmauoN/RGpNQbvQyJ7lF
	/In5whyhVFOGZ9+1Z31+PI1jW42TH1B+orTWPoTjrx7jGgfTA42iRmmimb0XDR9B
	e6qOMfks8b7AgpXTGrF3zUApBm2ch73q6S2U1oSpm6YvNmBJRKBnuurbgwHdTV8F
	yxQyF58IrZs54JzDNnEozWkbYsxgWoNXLHF4UPsFa5ctfnEN8ZKWZrKDqvBy/Fdr
	A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2yq2py7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 17:26:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60NGwZwa024971;
	Fri, 23 Jan 2026 17:26:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bujd1q8rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 17:26:56 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60NHH3mP020337;
	Fri, 23 Jan 2026 17:26:56 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-82.vpn.oracle.com [10.154.50.82])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4bujd1q8n1-3;
	Fri, 23 Jan 2026 17:26:56 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: yonghong.song@linux.dev, mattbobrowski@google.com
Cc: ihor.solodrai@linux.dev, eddyz87@gmail.com, jolsa@kernel.org,
        andrii@kernel.org, ast@kernel.org, david.faust@oracle.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 2/5] btf_encoder: Add true_signature feature support for "."-suffixed functions
Date: Fri, 23 Jan 2026 17:26:47 +0000
Message-ID: <20260123172650.4062362-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260123172650.4062362-1-alan.maguire@oracle.com>
References: <20260123172650.4062362-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601230131
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDEzMSBTYWx0ZWRfX7g7J54QPkPyr
 qKMyPfit3J89ctZZoR/R1rzDNr2a50OZJGrQq9Bl9dgsSD/OvC5QquSju8mlUcLtMlDexSPi1w1
 J4Y03YOXSSa77SXs3L4wEV1uX4qBjxb9BsGuq8hBS2dARUBctr8bUn0GbP91NwJzKnfQPM2+suD
 FyTlesHEBFQ4ck8wUMO80Jw56IwNSo9PpmKcoz1qw6HJO7ZLHGcnwCZt2DRvzjTDmfWnTnq2/7b
 rftiiBxttpzfl0+GaBy+4rUSgaEoRQH0mVESfASmDs3VTttiYAYr3JcE5mpavO76hHxsUFvP2O3
 ZrXXOwLUtghcPIV061eqvnU/S9QYgncmf8AAO90Acx2EabW5+ap77WHyofF1NBaodj0SoEyuXvN
 3LuBc06wb77tDC8VjcOIPZN8ZrEIhq6hukRowvsFTiTwsqCFlyrUrsw6VGPMGighh0gD6kH8R+Q
 MW+8ejw3XgovrUtX6N1h/m+msUQk+IJFhZTbpglc=
X-Authority-Analysis: v=2.4 cv=de6NHHXe c=1 sm=1 tr=0 ts=6973af62 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=MlS92rz-Hz0MdIvy2HwA:9 cc=ntf awl=host:12104
X-Proofpoint-ORIG-GUID: cFxlfijNT9wAuMPAARrBCfBD5Iyl4sro
X-Proofpoint-GUID: cFxlfijNT9wAuMPAARrBCfBD5Iyl4sro

Currently we collate function information by name and add functions
provided there are no inconsistencies across various representations.

For true_signature support - where we wish to add the real signature
of a function even if it differs from source level - we need to do
a few things:

1. For "."-suffixed functions, we need to match from DWARF->ELF;
   we can do this via the address associated with the function.
   In doing this, we can then be confident that the debug info
   for foo.isra.0 is the right info for the function at that
   address.

2. When adding saved functions we need to look for such cases
   and provided they do not violate other constraints around BTF
   representation - unexpected reg usage for function, uncertain
   parameter location or ambiguous address - we add them with
   their "."-suffixed name.  The latter can be used as a signal
   that the function is transformed from the original.

Doing this adds 500 functions to BTF.  These are traceable with
their "."-suffix names and because we have excluded ambiguous
address cases we know exactly which function address they refer
to.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++-----
 dwarves.h     |  1 +
 pahole.c      |  1 +
 3 files changed, 71 insertions(+), 7 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 9a567e4..c1002c3 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -77,9 +77,16 @@ struct btf_encoder_func_annot {
 	int16_t component_idx;
 };
 
+struct elf_function_sym {
+	const char *name;
+	uint64_t addr;
+};
+
 /* state used to do later encoding of saved functions */
 struct btf_encoder_func_state {
 	struct elf_function *elf;
+	struct elf_function_sym *sym;
+	uint64_t addr;
 	uint32_t type_id_off;
 	uint16_t nr_parms;
 	uint16_t nr_annots;
@@ -94,11 +101,6 @@ struct btf_encoder_func_state {
 	struct btf_encoder_func_annot *annots;
 };
 
-struct elf_function_sym {
-	const char *name;
-	uint64_t addr;
-};
-
 struct elf_function {
 	char		*name;
 	struct elf_function_sym *syms;
@@ -145,7 +147,8 @@ struct btf_encoder {
 			  skip_encoding_decl_tag,
 			  tag_kfuncs,
 			  gen_distilled_base,
-			  encode_attributes;
+			  encode_attributes,
+			  true_signature;
 	uint32_t	  array_index_id;
 	struct elf_secinfo *secinfo;
 	size_t             seccnt;
@@ -1270,14 +1273,36 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 			goto out;
 		}
 	}
+	if (encoder->true_signature && fn->lexblock.ip.addr) {
+		int i;
+
+		for (i = 0; i < func->sym_cnt; i++) {
+			if (fn->lexblock.ip.addr != func->syms[i].addr)
+				continue;
+			/* Only need to record address for '.'-suffixed
+			 * functions, since we only currently need true
+			 * signatures for them.
+			 */
+			if (!strchr(func->syms[i].name, '.'))
+				continue;
+			state->sym = &func->syms[i];
+			break;
+		}
+	}
 	state->inconsistent_proto = ftype->inconsistent_proto;
 	state->unexpected_reg = ftype->unexpected_reg;
 	state->optimized_parms = ftype->optimized_parms;
 	state->uncertain_parm_loc = ftype->uncertain_parm_loc;
 	state->reordered_parm = ftype->reordered_parm;
 	ftype__for_each_parameter(ftype, param) {
-		const char *name = parameter__name(param) ?: "";
+		const char *name;
 
+		/* No location info/optimized + reordered means optimized out. */
+		if (ftype->reordered_parm && (!param->has_loc || param->optimized)) {
+			state->nr_parms--;
+			continue;
+		}
+		name = parameter__name(param) ?: "";
 		str_off = btf__add_str(btf, name);
 		if (str_off < 0) {
 			err = str_off;
@@ -1366,6 +1391,9 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
 
 	btf_fnproto_id = btf_encoder__add_func_proto_for_state(encoder, state);
 	name = func->name;
+	if (encoder->true_signature && state->sym)
+		name = state->sym->name;
+
 	if (btf_fnproto_id >= 0)
 		btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id,
 						      name, false);
@@ -1508,6 +1536,39 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
 		while (j < nr_saved_fns && saved_functions_combine(encoder, &saved_fns[i], &saved_fns[j]) == 0)
 			j++;
 
+		/* Add true signatures for case where we have an exact
+		 * symbol match by address from DWARF->ELF and have a
+		 * "." suffixed name.
+		 */
+		if (encoder->true_signature) {
+			bool true_added = false;
+			int k;
+
+			for (k = i; k < nr_saved_fns; k++) {
+				struct btf_encoder_func_state *true_state = &saved_fns[k];
+
+				if (state->elf != true_state->elf)
+					break;
+				if (!true_state->sym)
+					continue;
+				/* Unexpected reg, uncertain parm loc and
+				 * ambiguous address mean we cannot trust fentry.
+				 */
+				if (true_state->unexpected_reg ||
+				    true_state->uncertain_parm_loc ||
+				    true_state->ambiguous_addr)
+					continue;
+				err = btf_encoder__add_func(encoder, true_state);
+				if (err < 0)
+					goto out;
+				true_added = true;
+				break;
+			}
+			/* If true symbol was added, skip the below. */
+			if (true_added)
+				continue;
+		}
+
 		/* do not exclude functions with optimized-out parameters; they
 		 * may still be _called_ with the right parameter values, they
 		 * just do not _use_ them.  Only exclude functions with
@@ -2584,6 +2645,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
 		encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
 		encoder->encode_attributes = conf_load->btf_attributes;
+		encoder->true_signature = conf_load->true_signature;
 		encoder->verbose	 = verbose;
 		encoder->has_index_type  = false;
 		encoder->need_index_type = false;
diff --git a/dwarves.h b/dwarves.h
index 78bedf5..d7c6474 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -101,6 +101,7 @@ struct conf_load {
 	bool			btf_decl_tag_kfuncs;
 	bool			btf_gen_distilled_base;
 	bool			btf_attributes;
+	bool			true_signature;
 	uint8_t			hashtable_bits;
 	uint8_t			max_hashtable_bits;
 	uint16_t		kabi_prefix_len;
diff --git a/pahole.c b/pahole.c
index ef01e58..02a0d19 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1234,6 +1234,7 @@ struct btf_feature {
 	BTF_NON_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
 	BTF_NON_DEFAULT_FEATURE_CHECK(attributes, btf_attributes, false,
 				      attributes_check),
+	BTF_NON_DEFAULT_FEATURE(true_signature, true_signature, false),
 };
 
 #define BTF_MAX_FEATURE_STR	1024
-- 
2.43.5

