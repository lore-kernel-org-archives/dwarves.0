Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9B63B8D5C;
	Fri, 27 Feb 2026 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186717; cv=none; b=TrARJAsF3rAU38LORMbU3cZ0Z/9+5a3LeRJig/kQZUjpl7hdVtzGA31OTwwiCFElRO5aU5UhoFqTQ3Y76eqsTy4SGImD6GBYTbKkeTj09Y0omzfgC1HbUvBkYhOFo5N/+XK6ux7NZvynEEwbOOUphC8WJnl4NNLLgOXznoU/4RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186717; c=relaxed/simple;
	bh=hKWg1JyLMS9FMBA6rUFAihU29Y3AyPYSTBsymodBkUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ic5CaYu8yA7hCxh1Mkzj3vH76/ih+M1d3RI54ya0aCCBTuP63WJrlWe+aTyOqZ5aR1EJGZPlA+rdAxDsd77R4wFYnzPv0cdLTzyXezp7lmm/V/vJacHNxLpviXp2wtwbRrvMSEzic5rZ+1NacmnVth0GoxVbsEeBJ9eR+0BZV3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FxxrNFOr; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FxxrNFOr"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R9v2PW281289;
	Fri, 27 Feb 2026 10:04:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=6XoYP
	O3DLAu25kPOzIHQve6DYXvmGDZdfBMro7gtjfk=; b=FxxrNFOrkDzRdNdpZ5eIy
	3JPh4BK9VfwNUh98TtdUGmVvOFhKv1kuWK8oy4xAmORnoXpuM9Gx7BNd435TR32c
	xblHbpOfbZzGZ3E8rB0CZRT06qLZjgxVZP5seXgM2zB5G0t7JnWMywaLXzacNWS3
	KB43wk9SS5xmC0eeiFWEw/ehf4CbpOvmS8iZpHyXeV9Cn/k5vXAE37i0rvJGhnwt
	NB+UQm4JbD94sJ5T2RmEVp//6uLow2HyXTEC1N6tmjG7qq/31R+BXg8M7LIJ8xsA
	x8hXduENVRyQC1Cm5s1qWQWYemws8G3wUnC7w3kFXiPzYa3VGhUq/2CZOYT1YxL8
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cjgs027ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 10:04:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61R80wZg027800;
	Fri, 27 Feb 2026 10:04:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35dmxfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 10:04:55 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61RA4Vxi036185;
	Fri, 27 Feb 2026 10:04:54 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-60-228.vpn.oracle.com [10.154.60.228])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cf35dmx3p-7;
	Fri, 27 Feb 2026 10:04:54 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v10 bpf-next 06/10] btf: support kernel parsing of BTF with layout info
Date: Fri, 27 Feb 2026 10:04:22 +0000
Message-ID: <20260227100426.2585191-7-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260227100426.2585191-1-alan.maguire@oracle.com>
References: <20260227100426.2585191-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602270086
X-Authority-Analysis: v=2.4 cv=BKK+bVQG c=1 sm=1 tr=0 ts=69a16c48 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=Jjk60jIoATpmH5dsjOcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA4NiBTYWx0ZWRfX14MBcUMNqNA/
 YxDaVbiaxY9u2W9j1whCvqsxkp8TAHjBzjS2c0sFH7NKKqZ1+56oWMr92clXWsN8e94hhbcjFgw
 7lR/+rkYoHS93CfWKJ9YUDONwek3/LDDwfhdLeTBG1UF2LitlDZRrC6gPUVRiJ8L4PUr2HbcCJf
 TQ0b5EGbOzd+D1tlFMT9/FFysoErySZz9irRkbrYSCZxqIYMoH4bLss4k3hViz7nbr3KDDuxBVu
 QnU9nfTvOVCX7LnBhJPiKfqe56rtmuE/RBz15WzmvXw3jGyj2Y5rov9zFDHutEOEa5HzNmJXgGq
 lGDuzJ3xrVQXPOgL1Qs0QXGWitbqK2FkswEVPTO/RX3HmsrI0YnYcFzgrKkef6z7uSvYWBSSxQy
 80U5/FXMzrEeDygAX8lFTslzKMVn53ooMYFluzQlegIuOSfLUBQ62yXdtaqhvzUPM7t9jnEvXq+
 ohYKcbFUQIjSDePI9Rw==
X-Proofpoint-ORIG-GUID: M3jHBqlPKzCmf0W4G77dq2UNSCqfmLwy
X-Proofpoint-GUID: M3jHBqlPKzCmf0W4G77dq2UNSCqfmLwy

Validate layout if present, but because the kernel must be
strict in what it accepts, reject BTF with unsupported kinds,
even if they are in the layout information.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 kernel/bpf/btf.c | 50 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4872d2a6c42d..e5a9774907fe 100644
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
@@ -5538,9 +5540,41 @@ static int btf_parse_str_sec(struct btf_verifier_env *env)
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
+	/* Llayout section must align to 4 bytes */
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
@@ -5556,24 +5590,28 @@ static int btf_check_sec_info(struct btf_verifier_env *env,
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
@@ -5929,6 +5967,10 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
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

