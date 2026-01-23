Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDFE2DECDE;
	Fri, 23 Jan 2026 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769189231; cv=none; b=phFpSfX5vyVhXBytaIZCQ3fSt63u55aHQSfwfExxwohN3Fl4Sqi0M4FLTzm4gyKMgmy1hvkZ0cINlRmYgBdU3d50g3qhisM9V8XOcrM0WT6t6eeLiF8794O02z58MKwfUBr/dY4+fs9djR+/dAhs7Cglr6yeRb+Ile6m6CFsCbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769189231; c=relaxed/simple;
	bh=r/BDTAD73nyaqZtXIkfl2Owz7tW3tnvuQFH/4Gejpz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFHr7o0WMtubrN0MtQrshqFDJd5RDgxAm8qgqLoLVXHpH0EJ8PpuLddlJ6phUkeQmZcFyK60lAxxLLjXAe9IQfp5pKIJZRGRhX1O0iVyh0eZ5X71r9SqHDWqrLK8NVNPwdqqc1EkQRAB34vTR3FraFpXh6jdMzJFkp/c+4F/qLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Dl9W1IyT; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Dl9W1IyT"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NFfWYi1631823;
	Fri, 23 Jan 2026 17:27:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=iKlcI
	Ifdvlp2betFL3SNQimIF22hwM3FGYoglrD/XUI=; b=Dl9W1IyT1BkYA0PyuBWs/
	f4mMaEzqBBW1tPp6EVdbO2FjjCxbZV/zpozG2KuzabkSM+P1Y2JM54QMsgqH96DT
	dNDHXtNfxwwnNdKrtAt48djgQva7U7sDVu/dECiHn8XKbfgeu6zeGRqFo8R5VUZC
	42ty1cm2YY7W4dxGinv98xgPjWCMPWgiRUQLz5ZdU2xWMI4l6q9A9PD09JJF0sto
	jwGCggxffwBENeg7STrnsQ1Cmr1LWaGik4pQt5g09BlT03a6fWVFXHpc6rkr7gIj
	4thO3r0tb1MdIvBWD/LhmZ+SRRj6Go+EPWkFLYoSPwWheK5hINX+pnEra2KQZ1GI
	w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2yq2pyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 17:27:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60NFmY07024905;
	Fri, 23 Jan 2026 17:27:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bujd1q8v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 17:27:02 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60NHH3mV020337;
	Fri, 23 Jan 2026 17:27:02 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-82.vpn.oracle.com [10.154.50.82])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4bujd1q8n1-6;
	Fri, 23 Jan 2026 17:27:01 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: yonghong.song@linux.dev, mattbobrowski@google.com
Cc: ihor.solodrai@linux.dev, eddyz87@gmail.com, jolsa@kernel.org,
        andrii@kernel.org, ast@kernel.org, david.faust@oracle.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH v2 dwarves 5/5] btf_encoder: Prefer strong function definitions for BTF generation
Date: Fri, 23 Jan 2026 17:26:50 +0000
Message-ID: <20260123172650.4062362-6-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDEzMSBTYWx0ZWRfX46WmD6SSFOwf
 VkbG7WBhQVFKhfFjGC2NG++1lzLJWcoT8aL05UT2wXeKmuNyDxB97pf+keeYm7jiWyRNf+Pf5CR
 kZ0yMWGOO4mXgXhE2szP74PfLenPwZzFpK0pdsfQ5gZpaUPtp2D6dn/lk3xLG07tBtn1umznpeA
 JlBWt37fafSKSukUqk2sfoO2xxZcQVeDDVZLhS3DllOc5+S88AIyt3rSRZpe5zqayqeaWLq5vdu
 MlkF8pY4EPqzbiL+wCefYAcdPa/iNDeewqL0M6YzJwbGrqPdd83DhYQA2a/JRpxzGYZpwI+20Qr
 k428mI2gQf0mNwMZ8XanRiE+u0xvVv6b9AaLQYZD0/9QG+geyrNggiV6yTRY7UsXVUGAobcsgdN
 scTF13xNx0RrvK/+hbQudivbd1rjVwCp5TXkypWRfwC2cNS8IX+45Hn93c+sKlnMpDdmA+EFHbi
 kTs2c5lIZ8rfJ4kfEIrsSFYnNX/RVzx9PF7Gx7Do=
X-Authority-Analysis: v=2.4 cv=de6NHHXe c=1 sm=1 tr=0 ts=6973af68 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=Rn5cwJFN9IqfuWfXOtwA:9 cc=ntf awl=host:12104
X-Proofpoint-ORIG-GUID: Lswhsm6PLeby0IrDpI76csK_FAXZdl_E
X-Proofpoint-GUID: Lswhsm6PLeby0IrDpI76csK_FAXZdl_E

From: Matt Bobrowski <mattbobrowski@google.com>

Currently, when a function has both a weak and a strong definition
across different compilation units (CUs), the BTF encoder arbitrarily
selects one to generate the BTF entry. This selection fundamentally is
dependent on the order in which pahole processes the CUs.

This indifference often leads to a mismatch where the generated BTF
reflects the weak definition's prototype, even though the linker
selected the strong definition for the final vmlinux binary.

A notable example described in [0] involving function
bpf_lsm_mmap_file(). Both weak and strong definitions exist,
distinguished only by parameter names (e.g., file vs
file__nullable). While the strong definition is linked into the
vmlinux object, the generated BTF contained the prototype for the weak
definition. This causes issues for BPF verifier (e.g., __nullable
annotation semantics), or tools relying on accurate type information.

To fix this, ensure the BTF encoder selects the function definition
corresponding to the actual code linked into the binary. This is
achieved by comparing the DWARF function address (DW_AT_low_pc) with
the ELF symbol address (st_value). Only the DWARF entry for the strong
definition will match the final resolved ELF symbol address.

[0] https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/

Link: https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/
Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 btf_encoder.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index c1002c3..4264f36 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1263,6 +1263,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 	if (!state)
 		return -ENOMEM;
 
+	state->addr = function__addr(fn);
 	state->elf = func;
 	state->nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
 	state->ret_type_id = ftype->tag.type == 0 ? 0 : encoder->type_id_off + ftype->tag.type;
@@ -1510,6 +1511,29 @@ static void btf_encoder__delete_saved_funcs(struct btf_encoder *encoder)
 	encoder->func_states.cap = 0;
 }
 
+static struct btf_encoder_func_state *btf_encoder__select_canonical_state(struct btf_encoder_func_state *combined_states,
+									  int combined_cnt)
+{
+	int i, j;
+
+	/*
+	 * The same elf_function is shared amongst combined functions,
+	 * as per saved_functions_combine().
+	 */
+	struct elf_function *elf = combined_states[0].elf;
+
+	for (i = 0; i < combined_cnt; i++) {
+		struct btf_encoder_func_state *state = &combined_states[i];
+
+		for (j = 0; j < elf->sym_cnt; j++) {
+			if (state->addr == elf->syms[j].addr)
+				return state;
+		}
+	}
+
+	return &combined_states[0];
+}
+
 static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_encoding_inconsistent_proto)
 {
 	struct btf_encoder_func_state *saved_fns = encoder->func_states.array;
@@ -1590,6 +1614,16 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
 			btf_encoder__log_func_skip(encoder, saved_fns[i].elf,
 						   skip_reason, 0, 0);
 		} else {
+			/*
+			 * We're to add the current function within
+			 * BTF. Although, from all functions that have
+			 * possibly been combined via
+			 * saved_functions_combine(), ensure to only
+			 * select and emit BTF for the most canonical
+			 * function definition.
+			 */
+			if (j - i > 1)
+				state = btf_encoder__select_canonical_state(state, j - i);
 			if (is_kfunc_state(state))
 				err = btf_encoder__add_bpf_kfunc(encoder, state);
 			else
-- 
2.43.5

