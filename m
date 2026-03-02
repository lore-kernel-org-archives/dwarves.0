Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A963624A5;
	Mon,  2 Mar 2026 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772451731; cv=none; b=TqdaWIfHDb+e/0AhihCkFeqBPzeDIbRHf8fzc3sD/NlEsQf3VbtwzWInahHAqVkoPpXMi3QXqn3hrfzNfk+t174x4cG1xfNO0gRtrZDYpN5kJEHDvi/4VRGMIYXsFvvM8O0jBHIsxomQeag5JjrYLEqhczuf2ZTq8Dtg3U+m3Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772451731; c=relaxed/simple;
	bh=HsRjcZX6YJ/7eJ/B9yp2IN11TEaSLV0uVParFrQpL6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDX6DuroFS4lHGGDEyEoSyfBloWHuMe/eXooEIpl+BqYWMlfaoORbxxGgn5bfrqzTMO0WO3oKmrG4pGo56tYmgXfy7liQpaBYhzpDs03ppay+0aEjeqQz6/ydAEYWA3FUM13acU4uv/ou8cDU8fNTGrqdC/mXafBQgCTD1RbHKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lBKtYW9H; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lBKtYW9H"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622AwMXL878717;
	Mon, 2 Mar 2026 11:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Rgv0t
	w6mRuAOfYOlVLgEzp6Jjpls3QLILxjVblDx98o=; b=lBKtYW9Hqj8I19LA+MeAc
	z6i7972PDGvY6g11+pWjDDYArdvmaJ/+HXxjhDFRgU7i+3nqsprZt7l+oHnmzOYa
	rLiXSCJCoYvAg5y56UHUsuQxQpSFIHwkUjDzLK+evoKMV/qF/ZQdms11xqMugoNs
	fo1LVBZitOtqelt8bM3HUBsgSvNei7UUGMj/HYc5myJOqf8i0RUnaoTaOvL/jZQ0
	qlILUL8D+gImGNZymxpeuVCM8PITh+iCBv1jzA6slXcWO0OT2HtEeijnSwAvleoS
	XfXzhp8qCUG9RTpL4QL2MIHA9yKQS5RsVYxPv2VntvZzKAJ5vU0APDQp7PGPe9gb
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cn98v81tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Mar 2026 11:41:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 622BSbPK036944;
	Mon, 2 Mar 2026 11:41:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpt8jcxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Mar 2026 11:41:28 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 622BZCYp012507;
	Mon, 2 Mar 2026 11:41:27 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-59-97.vpn.oracle.com [10.154.59.97])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ckpt8jcgy-7;
	Mon, 02 Mar 2026 11:41:27 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v11 bpf-next 6/8] btf: support kernel parsing of BTF with layout info
Date: Mon,  2 Mar 2026 11:40:57 +0000
Message-ID: <20260302114059.3697879-7-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260302114059.3697879-1-alan.maguire@oracle.com>
References: <20260302114059.3697879-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603020097
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA5NyBTYWx0ZWRfXzSEVZsnt6cD1
 51OIayBT8Vh9D9tKOFx+ctBTF+sFPHcStE0TJ9x7EJI30Cb8GhTgQ9MGjT/N2Qr24Cd/htqEx2j
 8NM+l6e/eY1YBTp5Ih/JK9WHCeoyXEv9rYhJ6ez4Ti/nJFdxWHJqppPjTnBe5y0UfQC8tPPFtnr
 aHs+JxOyRBWWGZ/l1GN4+OsaBFWqcpXPr225QzGUv0/s13MS7Mcjgxj8/skqME3Feqlag2TIb8D
 CiZnwVOZtlshdZCAdFJuESy3Aht0QWDAfqTEA72ysfngq1ZQRnXGEyJVwBYxJ6xmDGnLJavzw92
 bfzbLYf0kpbJvlq/jvApm8DSpUFTAQ3bfPnJQguomrofTz+Ze65aSwmy+y6yuiGnjOQEpgmKc8v
 Pdb7NbZnuSkzc9BEBejqH3XAkw8sqi+xKrZQv4xqxK3JuzpMnHiMro6J5yTMSq2MyYOalMSmjgr
 kV1POIAQX4XtQdKo6Sg==
X-Authority-Analysis: v=2.4 cv=TY+bdBQh c=1 sm=1 tr=0 ts=69a57768 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=Jjk60jIoATpmH5dsjOcA:9
X-Proofpoint-ORIG-GUID: 4FaS-fKbhEizLZk8Mnhyybcmlz9saAPL
X-Proofpoint-GUID: 4FaS-fKbhEizLZk8Mnhyybcmlz9saAPL

Validate layout if present, but because the kernel must be
strict in what it accepts, reject BTF with unsupported kinds,
even if they are in the layout information.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/bpf/btf.c | 55 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4872d2a6c42d..bda363a2592e 100644
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
+	if (hdr->layout_len % sizeof(struct btf_layout) != 0) {
+		btf_verifier_log(env, "layout_len is not multiple of %zu",
+				 sizeof(struct btf_layout));
+		return -EINVAL;
+	}
+	if (hdr->layout_len < sizeof(struct btf_layout)) {
+		btf_verifier_log(env, "Layout section is too small");
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

