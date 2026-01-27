Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FA3302742;
	Tue, 27 Jan 2026 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769535058; cv=none; b=RwI09ylbJcWQ8ym0KoC4Ke3zsVTWFNKnobWubXRkr8XFQblEgmiKhTIG8oX369oXDzTLSlkWMEB+X3fN+f7iiYU7lFDZuiPlfty4rvszsvvEZQU5CXB3YB7QY2GG1rU6j/ikjnBCjekiRyhW2pJYsn1k3LuZpkr305HI6vv73eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769535058; c=relaxed/simple;
	bh=Fcy6yofKudIB5fx46UrXbAODCCO+WBJSdMGnUFFzEJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGSJr7THWBms7sE9nW/8NYzaLx9R9gwuQmyjgFczlYJ/1cE8ZQDFfY/JgztU5lseVfYCgkQi9z0mUI4YzIsla6CDDUKLuvszs0z3RFvXiQfr1RSo8LT2Fr379yVEM7N6nJSCI5oyDjMc+onAAHSji6QRxhwkOc3f82KlIULMXUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ai1ZlZh5; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ai1ZlZh5"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBETBe455096;
	Tue, 27 Jan 2026 17:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=01flK
	DtYEl6NeWlBXvspuUsjD+rdvdXx75a4oMaJ4rs=; b=ai1ZlZh58DoYyFrslX+qG
	9rEsgXsqTPoU7blszAcbAwMWfelnkxoT/9kutuQ/+ozi7iGI12C6TSEGNTt8oxQv
	RabrAjngibGGdWnLbu1mTpCOlH2rXwC7JFMO4yrdagM8sJn+sjO4QmTiOVMftlDS
	GOrCo/7E3EPU/J36z5GaesSw9gIFyzxVsnhgyGhJ6KaPi8UXY26mhWdOqXJSkcoV
	OI7bXb2Vw+nbi33JEmLmfb5pjSpNPycPA+G34ptj3E3DVTYtZ3i5LK3JDANjig4I
	kZttgqkbd6aTTEy9ayOu1S/URFx0SQUFYuGXDpEwTe2DPfEYKush6XYLJZiz92jK
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvp4bvfwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 17:20:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RGOIFc032964;
	Tue, 27 Jan 2026 17:20:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh9q7xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 17:20:50 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60RHKjSj011183;
	Tue, 27 Jan 2026 17:20:50 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-55-133.vpn.oracle.com [10.154.55.133])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4bvmh9q7sn-3;
	Tue, 27 Jan 2026 17:20:50 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: yonghong.song@linux.dev, mattbobrowski@google.com
Cc: ihor.solodrai@linux.dev, eddyz87@gmail.com, jolsa@kernel.org,
        andrii@kernel.org, ast@kernel.org, david.faust@oracle.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 2/5] btf_encoder: Add true_signature feature support for "."-suffixed functions
Date: Tue, 27 Jan 2026 17:20:38 +0000
Message-ID: <20260127172041.1558244-3-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: TkT7DeSLRrrsVktYJihwBAkOK2_rldWR
X-Authority-Analysis: v=2.4 cv=StidKfO0 c=1 sm=1 tr=0 ts=6978f3f3 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8
 a=QZd8usjeLodPuLZJB68A:9
X-Proofpoint-GUID: TkT7DeSLRrrsVktYJihwBAkOK2_rldWR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE0MSBTYWx0ZWRfXwdV64xLrAdvJ
 /RA0JSYDQAmtpYAqwy3RosT28M5+H6nre8uxtQUX4CvCrllGJmN2/Q/BxtGMIlKoUOQueccGMJY
 Le/lDIsqC4GdGVZtJmRYKSoCFDtQr2Tb9x1zKdtndDNy4kxQhJSA658XJ9ose/CQn8PiI04d0Zu
 LnuRHZ+JA3V7hokSUNTyNXrQ0U0ZDf5l7kSRziYwoKqxebOZEh8JD9nLsv192e0Up1FnzjlfFkc
 jzuEBpwT1xuohEb6Cs6iltL7KJ/Ehf0R82acrO6HcC65wh4U5hHAs6y1MtFUOhzDI6BcqjgpACv
 eKXlXEilj7pV8JVkXGrYDX5KK7i/XuHyRQQTmnFVz1j5AHdWNveoBVk/RjsVtTVaf8AElTDp2ev
 n4qZESdjkPAotaXOCKCD6n8S7KZKVvUfruaoQOHbhvrNhBXnODotEEw973RG4MF6Wo6JH0sejDL
 bCZvafDrpoDct8o5pww==

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
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Matt Bobrowski <mattbobrowski@google.com>
---
 btf_encoder.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++----
 dwarves.h     |   1 +
 pahole.c      |   1 +
 3 files changed, 95 insertions(+), 7 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 9a567e4..8f3c143 100644
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
@@ -1260,6 +1263,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 	if (!state)
 		return -ENOMEM;
 
+	state->addr = function__addr(fn);
 	state->elf = func;
 	state->nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
 	state->ret_type_id = ftype->tag.type == 0 ? 0 : encoder->type_id_off + ftype->tag.type;
@@ -1270,14 +1274,36 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 			goto out;
 		}
 	}
+	if (encoder->true_signature && state->addr) {
+		int i;
+
+		for (i = 0; i < func->sym_cnt; i++) {
+			if (state->addr != func->syms[i].addr)
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
@@ -1366,6 +1392,9 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
 
 	btf_fnproto_id = btf_encoder__add_func_proto_for_state(encoder, state);
 	name = func->name;
+	if (encoder->true_signature && state->sym)
+		name = state->sym->name;
+
 	if (btf_fnproto_id >= 0)
 		btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id,
 						      name, false);
@@ -1482,6 +1511,45 @@ static void btf_encoder__delete_saved_funcs(struct btf_encoder *encoder)
 	encoder->func_states.cap = 0;
 }
 
+/*
+ * Returns: 1 if true signature added, 0 if not and < 0 on error.
+ */
+static int btf_encoder__add_true_signature(struct btf_encoder *encoder,
+					   int idx)
+{
+	struct btf_encoder_func_state *saved_fns = encoder->func_states.array;
+	struct btf_encoder_func_state *state = &saved_fns[idx];
+	int nr_saved_fns = encoder->func_states.cnt;
+	int err, i;
+
+	/*
+	 * Add true signatures for case where we have an exact
+	 * symbol match by address from DWARF->ELF and have a
+	 * "." suffixed name.
+	 */
+	for (i = idx; i < nr_saved_fns; i++) {
+		struct btf_encoder_func_state *true_state = &saved_fns[i];
+
+		if (state->elf != true_state->elf)
+			return 0;
+		if (!true_state->sym)
+			continue;
+		/*
+		 * Unexpected reg, uncertain parm loc and
+		 * ambiguous address mean we cannot trust fentry.
+		 */
+		if (true_state->unexpected_reg ||
+		    true_state->uncertain_parm_loc ||
+		    true_state->ambiguous_addr)
+			continue;
+		err = btf_encoder__add_func(encoder, true_state);
+		if (err < 0)
+			return err;
+		return 1;
+	}
+	return 0;
+}
+
 static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_encoding_inconsistent_proto)
 {
 	struct btf_encoder_func_state *saved_fns = encoder->func_states.array;
@@ -1508,6 +1576,23 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
 		while (j < nr_saved_fns && saved_functions_combine(encoder, &saved_fns[i], &saved_fns[j]) == 0)
 			j++;
 
+		/* Add true signatures for case where we have an exact
+		 * symbol match by address from DWARF->ELF and have a
+		 * "." suffixed name.
+		 */
+		if (encoder->true_signature) {
+			err = btf_encoder__add_true_signature(encoder, i);
+			switch (err) {
+			case 0:
+				break;
+			case 1:
+				/* If true signature was added, skip below */
+				continue;
+			default:
+				goto out;
+			}
+		}
+
 		/* do not exclude functions with optimized-out parameters; they
 		 * may still be _called_ with the right parameter values, they
 		 * just do not _use_ them.  Only exclude functions with
@@ -2584,6 +2669,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
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

