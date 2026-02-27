Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBC23BFE42;
	Fri, 27 Feb 2026 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186717; cv=none; b=VLX/Tb0nwRTqsmZxE3Kdj7DBuukubBjaiFQCRKF0yYsHtkN4Yk6jyIDaJfiu70dz5UOctuNh/fBqAc+HJ70q83YxoK/RQGWapRgrdMzmJGLPLZgMi9jxddJxvm3yxkEjkaTIH4/pANL5MBmEsFALp2YDa3g1ZwsU2R+Cb4tYU4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186717; c=relaxed/simple;
	bh=QcZFccHiqALf+EhO3d9QwTrFp32g10MDEn+bmex+5rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cNWGqkCprBluOzumPwibVf8URbrMn7sdi38vKVljDLZTT5JE//GZJ+TM3MDt4KJ7Eglu+HVoB9aEgtWrOZrVrWzs7/+SkBU252jf5jLce/nm1NsqLP3YYbG9H08szqKAc0qQaVEC3Uh8PPWb3qmTOeGYvNXHwNFKnaBeWH+KIR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y2el6tuk; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y2el6tuk"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R9utKY2720373;
	Fri, 27 Feb 2026 10:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=UnF9T
	h4gtGoGasaFRleUj+HBm3oDwWRNokRiWxCoOow=; b=Y2el6tukkI+uoiyJ8sKZr
	tESDBA5qqhvnJctiZtK943PfFrOSaxjzz42ZbK5N7nfkshwaY1gXw1vVf63/Po/j
	E0QZFbNDMthepKNo7KgeupccbBkZtV+gUYtRDWeqWysHf1r+w1rGrM7Q+pzB/FbV
	NjN60PZb57nSN0WDFyc04wbWXFOQElhzUq0sw5SyZcxde1aFuTXb3qxzXRoP/N2Q
	m4kO6nVeYyGUz2WccZOXlrsxYibfE1CUHOPdikr9FizBKMy1eGGS4GNjh8TpZuz6
	ReaP2FMoiLaLCOt1ALhvkecyLn/SXQhmvsy5Ra+Di7sjlzGpakGDTcR0L6ic7xfn
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf3m81xgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 10:04:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61RA0ntY028500;
	Fri, 27 Feb 2026 10:04:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35dmxbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 10:04:43 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61RA4Vxc036185;
	Fri, 27 Feb 2026 10:04:43 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-60-228.vpn.oracle.com [10.154.60.228])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cf35dmx3p-4;
	Fri, 27 Feb 2026 10:04:42 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v10 bpf-next 03/10] libbpf: use layout to compute an unknown kind size
Date: Fri, 27 Feb 2026 10:04:19 +0000
Message-ID: <20260227100426.2585191-4-alan.maguire@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=O5U0fR9W c=1 sm=1 tr=0 ts=69a16c3c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=wH1gtUtLgMC2xzGwrjYA:9
X-Proofpoint-GUID: eP8F9DoRlfdc1nbU7FXt41XstetnN6-h
X-Proofpoint-ORIG-GUID: eP8F9DoRlfdc1nbU7FXt41XstetnN6-h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA4NiBTYWx0ZWRfX3QwqKHDF/uPI
 TsLcTkv/wB/JY3gbsLHP8WsX3qbTKINckju5choxXXsWFB+GH+R+flaaluiLSjeG9Xk7FFZ5Cas
 VmhZeUsnxABd33Eufx5aQRtwqCEZ7NfZ0y0iHDL+U1WCS0HN/EsUEbCQwPvOxAb98zFFjjDQm6D
 xxCI9kfaOLhKLGs9X7xQRXd21ckxczwkcFS46Ge2oOA1wuIZ/cclkDmPJZ85nRcm3RBhxWS6ABM
 80b0k3Ao+MGTd5dM4uYVHrpfVggGonLoOMPGUG6rD4JXlRVsrBKGKnLtwE55L5zS8YpXFjdWjWZ
 d52PwP1IcLYrx8NQgUrJprqvVcUtqWtkc42ZfmFkszrcf2nMKR8RY+q8CzAgeAHPIFZSmRQKFSu
 eXsXxdYEaiCYloY3yOHJGyZ2sqRDMcSSmF3cCM5v0x7b5QVkUHnH/gIcqsZ8fMOMYUV//xElcrO
 2DxG3smP/REM+2Xfbzg==

This allows BTF parsing to proceed even if we do not know the
kind.  Fall back to base BTF layout if layout information is
not in split BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 7b58724a90a2..db13c15a0049 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -355,7 +355,32 @@ static int btf_parse_layout_sec(struct btf *btf)
 	return 0;
 }
 
-static int btf_type_size(const struct btf_type *t)
+/* for unknown kinds, consult kind layout. */
+static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t)
+{
+	__u32 layout_kinds = btf->hdr.layout_len / sizeof(struct btf_layout);
+	struct btf_layout *l = btf->layout;
+	__u16 vlen = btf_vlen(t);
+	__u32 kind = btf_kind(t);
+
+	/* Fall back to base BTF if needed as they share layout information */
+	if (!l) {
+		struct btf *base_btf = btf->base_btf;
+
+		if (base_btf) {
+			l = base_btf->layout;
+			layout_kinds = base_btf->hdr.layout_len / sizeof(struct btf_layout);
+		}
+	}
+	if (!l || kind >= layout_kinds) {
+		pr_debug("Unsupported BTF_KIND: %u\n", btf_kind(t));
+		return -EINVAL;
+	}
+
+	return sizeof(struct btf_type) + l[kind].info_sz + vlen * l[kind].elem_sz;
+}
+
+static int btf_type_size(const struct btf *btf, const struct btf_type *t)
 {
 	const int base_size = sizeof(struct btf_type);
 	__u16 vlen = btf_vlen(t);
@@ -391,8 +416,7 @@ static int btf_type_size(const struct btf_type *t)
 	case BTF_KIND_DECL_TAG:
 		return base_size + sizeof(struct btf_decl_tag);
 	default:
-		pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
-		return -EINVAL;
+		return btf_type_size_unknown(btf, t);
 	}
 }
 
@@ -490,7 +514,7 @@ static int btf_parse_type_sec(struct btf *btf)
 		if (btf->swapped_endian)
 			btf_bswap_type_base(next_type);
 
-		type_size = btf_type_size(next_type);
+		type_size = btf_type_size(btf, next_type);
 		if (type_size < 0)
 			return type_size;
 		if (next_type + type_size > end_type) {
@@ -2056,7 +2080,7 @@ static int btf_add_type(struct btf_pipe *p, const struct btf_type *src_type)
 	__u32 *str_off;
 	int sz, err;
 
-	sz = btf_type_size(src_type);
+	sz = btf_type_size(p->src, src_type);
 	if (sz < 0)
 		return libbpf_err(sz);
 
@@ -2138,7 +2162,7 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
 		struct btf_field_iter it;
 		__u32 *type_id, *str_off;
 
-		sz = btf_type_size(t);
+		sz = btf_type_size(src_btf, t);
 		if (sz < 0) {
 			/* unlikely, has to be corrupted src_btf */
 			err = sz;
@@ -5473,7 +5497,7 @@ static int btf_dedup_compact_types(struct btf_dedup *d)
 			continue;
 
 		t = btf__type_by_id(d->btf, id);
-		len = btf_type_size(t);
+		len = btf_type_size(d->btf, t);
 		if (len < 0)
 			return len;
 
@@ -6136,7 +6160,7 @@ int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map_cnt,
 
 		id = order_map[i];
 		t = btf__type_by_id(btf, id);
-		type_size = btf_type_size(t);
+		type_size = btf_type_size(btf, t);
 		memcpy(nt, t, type_size);
 
 		/* fix up referenced IDs for BTF */
@@ -6162,7 +6186,7 @@ int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map_cnt,
 
 	for (nt = new_types, i = 0; i < id_map_cnt - start_offs; i++) {
 		btf->type_offs[i] = nt - new_types;
-		nt += btf_type_size(nt);
+		nt += btf_type_size(btf, nt);
 	}
 
 	free(order_map);
-- 
2.39.3

