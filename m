Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A443A6EED;
	Tue,  3 Mar 2026 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772562063; cv=none; b=I50bAbCnyB2ar9vHYYWfaQjpm6Tj7ORgcqAmJNhXtigSPpzfIyLLWkC0wd/Ke7taA3Dgv8/9oA7AnvMfbSCIuWFtnXmqeJf7ZBYBMU7ozrYK8o5kKOOgKlgCc+zpF1D4veYl/TtmnaDTSiOabJvodTwUSA9sgc0ohCQ/2fMcqwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772562063; c=relaxed/simple;
	bh=Jl36eCr4PSRnnbT4Jailn/wnr0O0uKdbmRxHziwJeyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pv9YETh4XlN7Es9SuTBp+7GUtKnDhwVmBxvAiEW0+o+Hg/gnlByjmYzLbqO/5QalYowymLMW8EWodproS6qmzIXIi/kUN3Oli/VsicbuBX8HeXjOyJIC/OksyStNHMLr1r3dObv90LIFt3xGvEo5Qo2ap2SrDPI9uHiOPWFo+MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b6shUoCm; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b6shUoCm"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623I2agZ492569;
	Tue, 3 Mar 2026 18:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=AadLD
	oJN/VFJNPNzWg8DaYPMhGii0JMXYtkKusA428A=; b=b6shUoCmA5gkUcU8MOKq0
	ZB554z4TrilJKHeV5+A0dpH1/mddnZAss03kW6awntaCstIcozaD9LgpK42Cg9os
	HUE5sHtsxSCXin18/OuCWwLvC9ROFd1pqi/65eaC3s1xFmPVx4+AIOi6tmshUVd4
	OZ7bLLTfIvKXeXHas2CjGsDeKe/V6WK8S82l2iP2+SxIFqNsnBoVOl4esBB+A2eI
	G4igj2SUH4K2gCVz71AYyGEZMryAY32gK1AaMIU3erb6VIt5bk4A5DlFScNGrGYp
	0kKq6PZUGX3dNtrjjzLkE5DneThSCKmGbWa+w8AOn6m7v0UBf4zEFN/SrMvtqXlp
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cp4jv00vn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 18:20:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 623HU3qg037704;
	Tue, 3 Mar 2026 18:20:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpteyyhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 18:20:24 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 623IK7oF029269;
	Tue, 3 Mar 2026 18:20:23 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-62-133.vpn.oracle.com [10.154.62.133])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ckpteyxu6-7;
	Tue, 03 Mar 2026 18:20:23 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v12 bpf-next 6/8] btf: support kernel parsing of BTF with layout info
Date: Tue,  3 Mar 2026 18:20:01 +0000
Message-ID: <20260303182003.117483-7-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260303182003.117483-1-alan.maguire@oracle.com>
References: <20260303182003.117483-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603030148
X-Authority-Analysis: v=2.4 cv=RLS+3oi+ c=1 sm=1 tr=0 ts=69a72669 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=Jjk60jIoATpmH5dsjOcA:9 cc=ntf
 awl=host:13812
X-Proofpoint-ORIG-GUID: vjsJ9eZYqvcTKT9wBi5P_MO74pdBG8Rw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE0OCBTYWx0ZWRfXxq1Rl/dzRpRA
 0FIPsNsa6MNYqb91EzdXUUZJj+LNVu35IeLA//BpQyGxgevFPOPmZn2ofKpHhv8R3qOMwwFl7Hd
 sDl8lVNf8NKMcxb3G6U8blp1AE01hOh6I41uIl1rA/Sfo5CWlzXbgBkaSjhVbN1byVHSsraRvjz
 LPxCRfTymDmBtZTgXHJEc0aBbwsgyjxSFP78tWU3z2A9e20IGsFZQtBYuhNRgW01hsZA7Vbl4jn
 v7+5NOOBL9X+3s1jNJqnI+d/iyO0crYrs1b5iFY34rScqiv6KK5uhwKsWwGLEujbfJhrtgj7nCq
 Ed4fPEco/fqk8959Wn11IxJVMkHPKgirt1wvwaEuZ3+D747qDJnZ80zT7CPgPXHlwG2uvj27WIy
 VUPQQ6nIZF+SqGBruknTxsQMuNs3qhHat3/f4YrQuju4JIjNYzE5emR1Yf1MpxCQ5p8/3nPf6oi
 PVeYX1U/YTtpFQDEPxtMd4+ndxRg9yWTJn0keCp0=
X-Proofpoint-GUID: vjsJ9eZYqvcTKT9wBi5P_MO74pdBG8Rw

Validate layout if present, but because the kernel must be
strict in what it accepts, reject BTF with unsupported kinds,
even if they are in the layout information.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/bpf/btf.c | 55 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4872d2a6c42d..98d8d92799e5 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -270,6 +270,7 @@ struct btf {
 	struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
 	struct btf_struct_metas *struct_meta_tab;
 	struct btf_struct_ops_tab *struct_ops_tab;
+	struct btf_layout *layout;
 
 	/* split BTF support */
 	struct btf *base_btf;
@@ -5517,7 +5518,8 @@ static int btf_parse_str_sec(struct btf_verifier_env *env)
 	start = btf->nohdr_data + hdr->str_off;
 	end = start + hdr->str_len;
 
-	if (end != btf->data + btf->data_size) {
+	if (hdr->hdr_len < sizeof(struct btf_header) &&
+	    end != btf->data + btf->data_size) {
 		btf_verifier_log(env, "String section is not at the end");
 		return -EINVAL;
 	}
@@ -5538,9 +5540,46 @@ static int btf_parse_str_sec(struct btf_verifier_env *env)
 	return 0;
 }
 
+static int btf_parse_layout_sec(struct btf_verifier_env *env)
+{
+	const struct btf_header *hdr = &env->btf->hdr;
+	struct btf *btf = env->btf;
+	void *start, *end;
+
+	if (hdr->hdr_len < sizeof(struct btf_header) ||
+	    hdr->layout_len == 0)
+		return 0;
+
+	/* Layout section must align to 4 bytes */
+	if (hdr->layout_off & (sizeof(u32) - 1)) {
+		btf_verifier_log(env, "Unaligned layout_off");
+		return -EINVAL;
+	}
+	start = btf->nohdr_data + hdr->layout_off;
+	end = start + hdr->layout_len;
+
+	if (hdr->layout_len < sizeof(struct btf_layout)) {
+		btf_verifier_log(env, "Layout section is too small");
+		return -EINVAL;
+	}
+	if (hdr->layout_len % sizeof(struct btf_layout) != 0) {
+		btf_verifier_log(env, "layout_len is not multiple of %zu",
+				 sizeof(struct btf_layout));
+		return -EINVAL;
+	}
+	if (end > btf->data + btf->data_size) {
+		btf_verifier_log(env, "Layout section is too big");
+		return -EINVAL;
+	}
+	btf->layout = start;
+
+	return 0;
+}
+
 static const size_t btf_sec_info_offset[] = {
 	offsetof(struct btf_header, type_off),
 	offsetof(struct btf_header, str_off),
+	offsetof(struct btf_header, layout_off)
 };
 
 static int btf_sec_info_cmp(const void *a, const void *b)
@@ -5556,24 +5595,28 @@ static int btf_check_sec_info(struct btf_verifier_env *env,
 {
 	struct btf_sec_info secs[ARRAY_SIZE(btf_sec_info_offset)];
 	u32 total, expected_total, i;
+	u32 nr_secs = ARRAY_SIZE(btf_sec_info_offset);
 	const struct btf_header *hdr;
 	const struct btf *btf;
 
 	btf = env->btf;
 	hdr = &btf->hdr;
 
+	if (hdr->hdr_len < sizeof(struct btf_header) || hdr->layout_len == 0)
+		nr_secs--;
+
 	/* Populate the secs from hdr */
-	for (i = 0; i < ARRAY_SIZE(btf_sec_info_offset); i++)
+	for (i = 0; i < nr_secs; i++)
 		secs[i] = *(struct btf_sec_info *)((void *)hdr +
 						   btf_sec_info_offset[i]);
 
-	sort(secs, ARRAY_SIZE(btf_sec_info_offset),
+	sort(secs, nr_secs,
 	     sizeof(struct btf_sec_info), btf_sec_info_cmp, NULL);
 
 	/* Check for gaps and overlap among sections */
 	total = 0;
 	expected_total = btf_data_size - hdr->hdr_len;
-	for (i = 0; i < ARRAY_SIZE(btf_sec_info_offset); i++) {
+	for (i = 0; i < nr_secs; i++) {
 		if (expected_total < secs[i].off) {
 			btf_verifier_log(env, "Invalid section offset");
 			return -EINVAL;
@@ -5929,6 +5972,10 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 	if (err)
 		goto errout;
 
+	err = btf_parse_layout_sec(env);
+	if (err)
+		goto errout;
+
 	err = btf_parse_type_sec(env);
 	if (err)
 		goto errout;
-- 
2.39.3

