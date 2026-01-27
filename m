Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6722E11D2;
	Tue, 27 Jan 2026 17:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769534468; cv=none; b=Au/gbIaQAkNS3LKQDOPC3U74MYDhvbNGoVx1EFgzesXbZZwlmv2BAdgvsPSWz4jX6N2+0hsC8KZstIiOFIJlMzFo5Pxm0CsPkeOBoIerhVYDn9WmQopXQrsYjjiOD/9vrMmvBGTKwbVm7fJV1//iN0bhqaAiZP2xAIVjPTVO+CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769534468; c=relaxed/simple;
	bh=3Gm0cjkNiJcbnrb7PBF4RRDeHe9SDdneAd2E65OgBcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCD3kAG3AzGQe0T99TopsOTMSX+Ukt1kBGQcWyQF+8cO4ice7SbnQ3zFzvZ0cxswAmHDWMAz1dnKgKXDr3kEmmcvtWXKxQFzQNT46lgQmImkIDDol1u5ZqNaP9dLyIgtZ7JB3y8iyCvPJJJ6v/xyQeSCq32/oROqkhjgz2iFNik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=q3HgJTNk; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q3HgJTNk"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RD94m04016267;
	Tue, 27 Jan 2026 17:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=g0Tit
	sUqpcVofLemxxFWc94ZKtWyZS/aUWskg3bhG40=; b=q3HgJTNkrNAS9s6YaAOOB
	fqzVSTZ+FMPdg4h7pv6kuA4BKGr8LoyY4jQDb9i3oh4I+ZV0U5Vt57i9I3coHBic
	dqE68myPuO8CUSGxVXDkwaHMFbEeCIG4T1laLafj5uOCA0tDvVY1KmeNSPQhavXM
	4vgSFTOisD3mixIpXbYFh5lnMds6nTaBdryeX2l+GWITNR92+LZXQbzexW0Ah4vg
	tUbIuh6OwLL6ZIz28Ok1ZSRLt5kp9TJ7UCcPGad+pkWmsCh3BLZgaLLDt7mVzxqQ
	7vA/SfoHjEgGUCVtiGEQe7my5yy8a02cUdvS+1sPZ3gb9vCx2NERa6L5b3FVvMVf
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bxx09gfcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 17:21:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RFpHuk035147;
	Tue, 27 Jan 2026 17:20:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh9q853-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 17:20:59 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60RHKjSp011183;
	Tue, 27 Jan 2026 17:20:59 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-55-133.vpn.oracle.com [10.154.55.133])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4bvmh9q7sn-6;
	Tue, 27 Jan 2026 17:20:58 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: yonghong.song@linux.dev, mattbobrowski@google.com
Cc: ihor.solodrai@linux.dev, eddyz87@gmail.com, jolsa@kernel.org,
        andrii@kernel.org, ast@kernel.org, david.faust@oracle.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH v3 dwarves 5/5] btf_encoder: Prefer strong function definitions for BTF generation
Date: Tue, 27 Jan 2026 17:20:41 +0000
Message-ID: <20260127172041.1558244-6-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: ifBSQAza5T90qDqZkdVIbAnG1EvGq9jx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE0MSBTYWx0ZWRfXyonKwj2VogRv
 HqGcif+BrfPzXKESEDupIYwBSSeLPJwwlsTygv7XwvjSBNCWK3eVsMTghPKSFwvnTOA2IpRMs05
 e7p4d4G2lXHBO2q4PoeG0HRrBeGqu7mqINQOuHGTbXzlnVzcERtVDO+it0I3D+eJli3x3UwRabP
 4WD66UNayTz23EAM9pVWuADoKKzW0418SEhZ+pmZnybNCDMgcr7WmoDagjXezLV2Zs0Ld2HaGOr
 UxfpKg+a9ZEW8RZ46/EJD8qjDFpgt6FolyHIao/xVAIsgTHyGoefJaSU1zZZZd9ERZPu3IVdylX
 7ggQtow/hzqOrpz+UdWPFCBa+gePHszrSKr2IcycTzW17VliLmOi7/LqnlCqaTnFufToYM25zEs
 tj/j4Vmw7QnFuWUlL6atzm6i9FkQlNB53Xs5wtA+6yApOqllXsOFyC981bkelG/XvPQaFw1kXut
 3vyxCd8tlhtgykiME4w==
X-Authority-Analysis: v=2.4 cv=Qe5rf8bv c=1 sm=1 tr=0 ts=6978f3fc b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=Rn5cwJFN9IqfuWfXOtwA:9
X-Proofpoint-GUID: ifBSQAza5T90qDqZkdVIbAnG1EvGq9jx

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
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 btf_encoder.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index 8f3c143..aa7cd1c 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1550,6 +1550,29 @@ static int btf_encoder__add_true_signature(struct btf_encoder *encoder,
 	return 0;
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
@@ -1614,6 +1637,16 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
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

