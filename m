Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C610408252;
	Tue, 24 Mar 2026 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374357; cv=none; b=OMEpHUyr3efpo8bVxN6WbgwaqvpJ/rV5p5ULp4ej+3e8bUb7nQqjPfDsfFPkgzXrQ0SCUme7riFqc7jxU7VZf52zX6Wm3UpYwatepgHLRrK+jiuwMl+9S99Ug6Fhb7LtjXqbUwm5FOOYS7B9QhIzT3eH+GCEbMul8Jo+CN0cyq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374357; c=relaxed/simple;
	bh=ko6i9wVp0oXZzoU3kZQBc+q4lex+RRNAupu/dFn3rfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=boV0t+h+NclbCvN8ZImYb3vnRI+CkzkHaWaFlerzoeDu5861HE1WApPUp7IKikeyPj6cbe7hNIf+92SBgnUu/+fBiTr6JTLPcOFlqzLgikg8b9bDruqBCAFffaPMuPvDybXA+EFDzzM3oFaet2ddFFLNJ3mZkwCfEmYC4qcg3Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U8m+3GjB; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U8m+3GjB"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OCGNPO614488;
	Tue, 24 Mar 2026 17:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=cAXFR
	p9s9M0f8thb59WTY5iOLg1S6y1hiQEe8mTbjfo=; b=U8m+3GjB8aDBRm4nfl507
	2Lyx1D1ArYyDIEWwjw1DL/+n+Wvur6nVjfMk+63c6aWeTJOX+LF1UTlJ8M+B5eDK
	j1BU7V13GLARZ5Ou+DNUMCP2nxFReIBE69oGLc22+d8A+JZKHVXl7gS/7Q1cDL7t
	SxPfCOKjGevVSY7ThKXOfEHgr+WTy+5D/AT080VutZ8Ckc3DNlD1VZxsRzy8uDik
	zrv7Oofy+TwO1aJemH5mnep3aQDF70okhd6CKaNPrtRLSJwr6USrgwRGkufwDtFN
	u/RV7j8GJkTSz0araxBnlBT0sXaTRpdzpANSOnckHe4H7rQQoFD6nMDVMiPPLYRf
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1khf4rdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 17:45:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62OHcs9R038994;
	Tue, 24 Mar 2026 17:45:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsac7g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 17:45:10 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62OHirgw035539;
	Tue, 24 Mar 2026 17:45:09 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-54-179.vpn.oracle.com [10.154.54.179])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4d1hsac706-8;
	Tue, 24 Mar 2026 17:45:09 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
        qmo@kernel.org, ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v15 bpf-next 7/9] btf: support kernel parsing of BTF with layout info
Date: Tue, 24 Mar 2026 17:44:48 +0000
Message-ID: <20260324174450.1570809-8-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260324174450.1570809-1-alan.maguire@oracle.com>
References: <20260324174450.1570809-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603240137
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzOCBTYWx0ZWRfXxoQwFiLSnslb
 9YNTwABf9wSGp1YGUK6KgujdKI8WwHqXyPsF8hLz8iQiRi86zIsS7uCgwQHUP3Vhddh9TxFo4hX
 PvKbHSP9oVGL0AFUSUdb6FKe/TBGTg87NauHBvt2lkqwt1BpjIv9TzlW+CLSfbkPvSVxY0B2UiW
 G/DY2KeKkLoPyZmkpVa80FnM4QLdKr0p/oKfpjOCdvIRMpL3hrquNCLX5+06yrzU7oFd/xDLPpe
 5WOs7qJWtVuVzNJip0u7gtyTeRZ/iD7gs6tqG16SEOQV2MT7ls1TDRDb3q9lABHv7FEkGX9eOdV
 Z5aQ9x+pIlhRnfqGtdP9e+KQslXAcFTpepNfH+uryykiPaZOeQn+QJv+Rkg4qc9FLyWxJrz3Ywz
 rtg5nJgDVQhh/9Ca8tSbVz8x4YTBDiWAG3HoeZiKQ6HUxgr3N9dhYw39sV9FX4FjpBWo6gkOR18
 W3o82BBz4m5OmrpTnd94Eyd6YvWAtyWDzrcdUzSA=
X-Authority-Analysis: v=2.4 cv=AIvfpCdw c=1 sm=1 tr=0 ts=69c2cda7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=0BF2J1FlyYghqvV610sA:9 cc=ntf
 awl=host:13824
X-Proofpoint-ORIG-GUID: Meqq-KEEebQcri_19X3bRcbxKs8z4nwd
X-Proofpoint-GUID: Meqq-KEEebQcri_19X3bRcbxKs8z4nwd

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

