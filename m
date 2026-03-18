Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DE93D7D74;
	Wed, 18 Mar 2026 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773840618; cv=none; b=eO2r8rndKg1HIgHpRtPEj8i57684BQ2OF32qHnIOZ/FzZnC8K60xApQxY4ALP5s9P7Iv46oA5OWkd/kTzcci9q5yHH1Pa0bOXViUfWR3QBa7Hdk2dUKllBpMJtPAlS+JTeJ9KHGiKxXwX0MBb6qUvXf0gpZ9xpPyhkgLXYXAT0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773840618; c=relaxed/simple;
	bh=GeiHisj73XnC9w/AaGkUo45LeQGZNUwWzNXVAKTtJQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZUA5OdoXJkjSh6Sd0aIrbgKnFHMt1GEYmlgQm1dyzq+rR1SSqtcUIze5LdSfE34I7y5HgRQPXX3ZAg/tYBFbgmzO5GDIdaz/ullhBEBEKssUlfAXP5sppqvMtliPayeJrgRMQmVJZct1tp0veo/EiTej0ZaA3Mzt99TMubQ6/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DUWpgryl; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DUWpgryl"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I2MqKl2706446;
	Wed, 18 Mar 2026 13:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=jjIlR
	oJH5lJ9N1/H9WFN9T9YEmjLp567G9+dlyJ3PUY=; b=DUWpgrylm06eUf10n+cG1
	2xW1M6z5Crf2BY3Ie9AnOwEEx20eCA/U5L7DXftD/SzkAu+M9wMWH02rA/ZL0/JA
	yHp4FRv5M8PzzmyYThaQ+9kw1hxrHLBxTY0Ggw+AggLWB8spIiYBjE6ZsfAIneB6
	1yx0iaCVDgiJyvFX1LLPjRNdwWbqHEwxNACHl+C8uV7qIu5rimHpqYPCzFD7lsGD
	rr0ne7UG1m0ePPJZZOoxWtjtxjd0l/YYRLCfp3rxrHSBm4GYTMLzFTsxn0LXFKII
	6Wrx90aaHJaLItTOspEnhjdZWzMQF+LLOnoSklXRJjszr7/1J5yhU/tAVMoq6ZfD
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxf45yve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 13:29:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62IBvY4w030734;
	Wed, 18 Mar 2026 13:29:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4bmt1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 13:29:44 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62IDTVfE009174;
	Wed, 18 Mar 2026 13:29:43 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-75.vpn.oracle.com [10.154.52.75])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cvx4bmsqg-4;
	Wed, 18 Mar 2026 13:29:43 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v14 bpf-next 03/10] libbpf: Use layout to compute an unknown kind size
Date: Wed, 18 Mar 2026 13:29:20 +0000
Message-ID: <20260318132927.1142388-4-alan.maguire@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=ftrRpV4f c=1 sm=1 tr=0 ts=69baa8c9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=wH1gtUtLgMC2xzGwrjYA:9
X-Proofpoint-GUID: uZVnRl4go2ExgDWtpR7rgYpr1TcMbo98
X-Proofpoint-ORIG-GUID: uZVnRl4go2ExgDWtpR7rgYpr1TcMbo98
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDExNCBTYWx0ZWRfX5XC0Fae2xHTZ
 ozBntafdUKoGUKqcc8oL6mVODtmbxT5Jw21nX7EtEjIHocno7yBO4crPIpFvQ7hSghcSZPQr8WD
 tHZ0IFACaWCaQQX2ukFES+VHgvRgZqhDNbzjJ8ILpMSVUWk7xrXXi46Ud7VfnBLU5cabM0cJqgM
 QoiylNJEKI+eCB+CjkU0YPM7tS2GDQ0w8I1KSBM9OwyGadE75dytrfoYsfWf9ETW/aohMrWSPm5
 KllgrHYmu16zppMX7sElyt6tKGPfooDWmt1D3mH3dBtqLKwkMs5bb9gAhRgy2nrGwNgbMgbTaSV
 /wMWauiDse4TysoepC1OtbjMDmosbj4oVXqaQVOq8LNQFLIMgMNUQjdJVwU3RGeh7m98dCd1IlU
 B81iPHGZkeogpTCbji/ddeoZD597EXrI1/1ESt3KykPObctSXfwe99gGVHFVhcRpMsm4CSCPocx
 OvHS3nPpPTIZYaWtujw==

This allows BTF parsing to proceed even if we do not know the
kind.  Fall back to base BTF layout if layout information is
not in split BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 37a3b317cb2f..dcc3c4a54006 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -377,7 +377,32 @@ static int btf_parse_layout_sec(struct btf *btf)
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
@@ -413,8 +438,7 @@ static int btf_type_size(const struct btf_type *t)
 	case BTF_KIND_DECL_TAG:
 		return base_size + sizeof(struct btf_decl_tag);
 	default:
-		pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
-		return -EINVAL;
+		return btf_type_size_unknown(btf, t);
 	}
 }
 
@@ -512,7 +536,7 @@ static int btf_parse_type_sec(struct btf *btf)
 		if (btf->swapped_endian)
 			btf_bswap_type_base(next_type);
 
-		type_size = btf_type_size(next_type);
+		type_size = btf_type_size(btf, next_type);
 		if (type_size < 0)
 			return type_size;
 		if (next_type + type_size > end_type) {
@@ -2087,7 +2111,7 @@ static int btf_add_type(struct btf_pipe *p, const struct btf_type *src_type)
 	__u32 *str_off;
 	int sz, err;
 
-	sz = btf_type_size(src_type);
+	sz = btf_type_size(p->src, src_type);
 	if (sz < 0)
 		return libbpf_err(sz);
 
@@ -2177,7 +2201,7 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
 		struct btf_field_iter it;
 		__u32 *type_id, *str_off;
 
-		sz = btf_type_size(t);
+		sz = btf_type_size(src_btf, t);
 		if (sz < 0) {
 			/* unlikely, has to be corrupted src_btf */
 			err = sz;
@@ -5544,7 +5568,7 @@ static int btf_dedup_compact_types(struct btf_dedup *d)
 			continue;
 
 		t = btf__type_by_id(d->btf, id);
-		len = btf_type_size(t);
+		len = btf_type_size(d->btf, t);
 		if (len < 0)
 			return len;
 
@@ -6206,7 +6230,7 @@ int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map_cnt,
 
 		id = order_map[i];
 		t = btf__type_by_id(btf, id);
-		type_size = btf_type_size(t);
+		type_size = btf_type_size(btf, t);
 		memcpy(nt, t, type_size);
 
 		/* fix up referenced IDs for BTF */
@@ -6232,7 +6256,7 @@ int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map_cnt,
 
 	for (nt = new_types, i = 0; i < id_map_cnt - start_offs; i++) {
 		btf->type_offs[i] = nt - new_types;
-		nt += btf_type_size(nt);
+		nt += btf_type_size(btf, nt);
 	}
 
 	free(order_map);
-- 
2.39.3

