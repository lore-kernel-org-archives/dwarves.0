Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C0A2D060C;
	Wed, 18 Mar 2026 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773840639; cv=none; b=Kiwnxxhh9hzz/ep/IKN3NR05Z3Z4lRJ/eBPKU/krbYFccbAEkNUeuMFzapOBcnJcx6MtC4cLLMoIHTzqOc5/XZFmZrlGOxethf/qm+MM0c9ysLEk5PCB24PJSdFLV+xYNXQIlCGGimTZxL+14gEuUPmPFMCd+5gmt74xBO7iiQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773840639; c=relaxed/simple;
	bh=ko6i9wVp0oXZzoU3kZQBc+q4lex+RRNAupu/dFn3rfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgwmmTgNPOdzwSfcC+CdYzGcm80XIgpWxVbltPVgP4fLbmMaV8mBWXxpvkuLImgtM3hXY1FnXyMryjna6QV2BV9XsyCN5UR4mAcYP02DWI1bzpeur5gaU6OvCMy5iFYvrjRo9szl24QKJUZwOCInzmcwZ7fdNobyEyyq5P8xkEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fQwZ8o7U; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fQwZ8o7U"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I2NXEY975203;
	Wed, 18 Mar 2026 13:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=cAXFR
	p9s9M0f8thb59WTY5iOLg1S6y1hiQEe8mTbjfo=; b=fQwZ8o7UCpHkGRViOj16O
	LRP4BkSjZfiUFw0zM1NKD2QgQwGmhWiaKinvVNaCQA+sibiiWGFbwJlo5UZJHaUu
	Tr/c1tCN7Rh1dXHYmDk3BOtpTw2x/LzOjlhspm1uxVcLXVET7Z8vOESaoQ1T3QxM
	aboQVAkeh8DwlMRq+eBZvFeEL3bZE4bU8zYRtMUvhLPIgCFeijChBidZMR8Rsex5
	9XjMo6hCEH81acsXOicNr6sacULZ0s89NlxDViU1x0eqVCxDoXUR68SzjhN36eif
	88c96XGr1r17ExLWAyDOdgfLQ811VLMwod88QWzXltVcixgw3/BPCsga/I1+95rU
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cw07re3e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 13:30:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62ICmRAm030672;
	Wed, 18 Mar 2026 13:29:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4bmt98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 13:29:59 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62IDTVfM009174;
	Wed, 18 Mar 2026 13:29:59 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-75.vpn.oracle.com [10.154.52.75])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cvx4bmsqg-8;
	Wed, 18 Mar 2026 13:29:58 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v14 bpf-next 07/10] btf: support kernel parsing of BTF with layout info
Date: Wed, 18 Mar 2026 13:29:24 +0000
Message-ID: <20260318132927.1142388-8-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260318132927.1142388-1-alan.maguire@oracle.com>
References: <20260318132927.1142388-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603180114
X-Authority-Analysis: v=2.4 cv=HcsZjyE8 c=1 sm=1 tr=0 ts=69baa8d8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=0BF2J1FlyYghqvV610sA:9
X-Proofpoint-ORIG-GUID: u2ZVdcVzbDLOyPPTaRBNmbi2WCabCQ70
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDExNCBTYWx0ZWRfX72QjBIWwWRBK
 PRBx4AS8K8A/Yfyr1usBLJiCDX775f6g3Q7zdcU0Ein0h5x59oBZe1pn+lYXv1SMsf5SMok3vBq
 K/OS8lc6jGglK3bbGaggsZnS92gP9icr7VuQQIGjQWx6clZrdv8RY954fOmcHprVhawWcsEmi/C
 Jn9oqJP5GeNj+vL/LMdOUvnhZXp0JxQizgyjmpG8vrtMhXyuM3HEGK1lqK+C1bI/EpJ5nISrK3m
 CvB860s+PIkIEllY93y+QDpfEZDW5IJn7LvaenkYH9SGJ9zhUx7WBbVav0eGyC1We0L80oLYD9s
 493Ap7nNl76prR+iXFCQvVBKuy5hteibphVw5SPafRHBuqFP4nLrfgOgPn4rfMymUb+Ppr5xym+
 EDMIXJEbcENQDUFlCju+QNXW5PiX/JjOg8yhrFGpNdkrxGOLIJ4tXCjTrD8ZEjOQdcZpFJ46Dpr
 qaCrw5uIA9h+RUoGv8A==
X-Proofpoint-GUID: u2ZVdcVzbDLOyPPTaRBNmbi2WCabCQ70

Validate layout if present, but because the kernel must be
strict in what it accepts, reject BTF with unsupported kinds,
even if they are in the layout information.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/bpf/btf.c | 60 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 09fcbb125155..e6030627c3d4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -270,6 +270,7 @@ struct btf {
 	struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
 	struct btf_struct_metas *struct_meta_tab;
 	struct btf_struct_ops_tab *struct_ops_tab;
+	struct btf_layout *layout;
 
 	/* split BTF support */
 	struct btf *base_btf;
@@ -1707,6 +1708,11 @@ static void btf_verifier_log_hdr(struct btf_verifier_env *env,
 	__btf_verifier_log(log, "type_len: %u\n", hdr->type_len);
 	__btf_verifier_log(log, "str_off: %u\n", hdr->str_off);
 	__btf_verifier_log(log, "str_len: %u\n", hdr->str_len);
+	if (hdr->hdr_len >= sizeof(struct btf_header) &&
+	    btf_data_size >= hdr->hdr_len) {
+		__btf_verifier_log(log, "layout_off: %u\n", hdr->layout_off);
+		__btf_verifier_log(log, "layout_len: %u\n", hdr->layout_len);
+	}
 	__btf_verifier_log(log, "btf_total_size: %u\n", btf_data_size);
 }
 
@@ -5517,7 +5523,8 @@ static int btf_parse_str_sec(struct btf_verifier_env *env)
 	start = btf->nohdr_data + hdr->str_off;
 	end = start + hdr->str_len;
 
-	if (end != btf->data + btf->data_size) {
+	if (hdr->hdr_len < sizeof(struct btf_header) &&
+	    end != btf->data + btf->data_size) {
 		btf_verifier_log(env, "String section is not at the end");
 		return -EINVAL;
 	}
@@ -5538,9 +5545,46 @@ static int btf_parse_str_sec(struct btf_verifier_env *env)
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
@@ -5556,24 +5600,28 @@ static int btf_check_sec_info(struct btf_verifier_env *env,
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
@@ -5929,6 +5977,10 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
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

