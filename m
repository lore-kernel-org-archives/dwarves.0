Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AE836308C;
	Mon,  2 Mar 2026 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772451697; cv=none; b=sDsSsH2fvSFzaqESSgoo3UP70/UbsczxBt2yxNvDQ+fxNSc18FyVwu/5gsdRXGPxVk1j0EPy7htgO46UdtSOCS/oD1bhuCFRwdkuTdfTlkj2TpcA985DC1pOZq2n/XeZk1o4aCQ8WaQsE4hqg7U5Ia+0kSEevABFq9yyJyitnkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772451697; c=relaxed/simple;
	bh=gyikH1m3XhwY5kWLFU0ca6ZLXCa/JsT5wc5tV2rURFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNs+F5nm295U75+/2xZkT8mddHnJc8o8wVwC9IvfN6/qYvzk9zbQty/HN0DVp3UvY7m8wnrXm3wPOnCt+Tr7f0uG2AblMWjhp0TMCCqVYQds1MqV1IpD4PJuYVT2Tul4kbwt0t21+L73ZjkhxX85fvmcUljEdKQJqLbXKnD9avw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NfleFuvR; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NfleFuvR"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622B3r3f3253125;
	Mon, 2 Mar 2026 11:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=NnRXP
	ypiGjCaNeWvVEONU/MN6vd1LIlJ3gHCEv4/etc=; b=NfleFuvRY2aVDXNZlnzzo
	CmPzycypGSrfk9JfdGfogue92YucZ4GxY6hBvg2IqfV7X7tKGx5GAowYOYhHrFtD
	8bTAA2mNVuG42JnJXYD7m9wJNSJAQeskEsEGGgmr98l5RYbhWtii7rQSKUIH24aO
	SzHqs6lYm8i693mkU/ms4quR6bBd6zb9aCkBRka6VUUXFoMmo/vQFTMq2wyM6B+7
	deSH0fNFV+V6/3QAYwXOmxsDG8/JOuSF8kF8UOspVr8SlGc3YizjApS/DGvv/r7T
	XHijToAP/XiFuYvLbBAsmsydnZx1OYhf+MTU3tBduH7+6df0CiiesHZgfF0wlM2d
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cn9bc01tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Mar 2026 11:41:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 622BJN6J037028;
	Mon, 2 Mar 2026 11:41:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpt8jct1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Mar 2026 11:41:17 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 622BZCYj012507;
	Mon, 2 Mar 2026 11:41:16 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-59-97.vpn.oracle.com [10.154.59.97])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ckpt8jcgy-4;
	Mon, 02 Mar 2026 11:41:16 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v11 bpf-next 3/8] libbpf: use layout to compute an unknown kind size
Date: Mon,  2 Mar 2026 11:40:54 +0000
Message-ID: <20260302114059.3697879-4-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA5NyBTYWx0ZWRfX9wht++3yqo0s
 KhsVY6oYhA6AGYNiQdKJO6DedbQp//HdIoTlUNYKp+A4nFdr9P1HrmPZoMq6TSGTmBnPq22arPe
 pAu+DWIwA8tpkNcmbSTGpBGvCgN4PRr7lKs3hNcjuGqGWPIzLVxj97J4+FB4gyJKhOWhG6nPYNo
 NVHEJ7nvBgBUIXK6n3QzC2NE6IG4DpNmk654MMbhU/fd76x6AbMSC91jxpFXU1jUxQy8e2O5t+R
 2LrISriYnOaWlhojBrsiC/ilWwqRfqz7Yjq/P4m28qFR+hhDFXuUv5mazC24I9yN35O337Pl23W
 4YEBOB460V8be95qYQJvn9fxiZEVXkF8TsJRh5gm5UYOT8Max8ueeOul+Scf9SBkGOnu5rZz1xc
 iOMF3W7KY9QxAsMYBOlTpwJPZcUhBuT8b0nh1GTc7HP3Ydcup+g0WI9Fb26FBLPfZy8oAkU3kzx
 5njY7X6k+GNerKpaIkA==
X-Authority-Analysis: v=2.4 cv=bNQb4f+Z c=1 sm=1 tr=0 ts=69a5775e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=wH1gtUtLgMC2xzGwrjYA:9
X-Proofpoint-GUID: F1DSDX2AjLiWo7mIy_fW6-LLW0asvVcp
X-Proofpoint-ORIG-GUID: F1DSDX2AjLiWo7mIy_fW6-LLW0asvVcp

This allows BTF parsing to proceed even if we do not know the
kind.  Fall back to base BTF layout if layout information is
not in split BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index ae13f9f4df08..9f4d1bd73b4d 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -356,7 +356,32 @@ static int btf_parse_layout_sec(struct btf *btf)
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
@@ -392,8 +417,7 @@ static int btf_type_size(const struct btf_type *t)
 	case BTF_KIND_DECL_TAG:
 		return base_size + sizeof(struct btf_decl_tag);
 	default:
-		pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
-		return -EINVAL;
+		return btf_type_size_unknown(btf, t);
 	}
 }
 
@@ -491,7 +515,7 @@ static int btf_parse_type_sec(struct btf *btf)
 		if (btf->swapped_endian)
 			btf_bswap_type_base(next_type);
 
-		type_size = btf_type_size(next_type);
+		type_size = btf_type_size(btf, next_type);
 		if (type_size < 0)
 			return type_size;
 		if (next_type + type_size > end_type) {
@@ -2057,7 +2081,7 @@ static int btf_add_type(struct btf_pipe *p, const struct btf_type *src_type)
 	__u32 *str_off;
 	int sz, err;
 
-	sz = btf_type_size(src_type);
+	sz = btf_type_size(p->src, src_type);
 	if (sz < 0)
 		return libbpf_err(sz);
 
@@ -2139,7 +2163,7 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
 		struct btf_field_iter it;
 		__u32 *type_id, *str_off;
 
-		sz = btf_type_size(t);
+		sz = btf_type_size(src_btf, t);
 		if (sz < 0) {
 			/* unlikely, has to be corrupted src_btf */
 			err = sz;
@@ -5474,7 +5498,7 @@ static int btf_dedup_compact_types(struct btf_dedup *d)
 			continue;
 
 		t = btf__type_by_id(d->btf, id);
-		len = btf_type_size(t);
+		len = btf_type_size(d->btf, t);
 		if (len < 0)
 			return len;
 
@@ -6137,7 +6161,7 @@ int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map_cnt,
 
 		id = order_map[i];
 		t = btf__type_by_id(btf, id);
-		type_size = btf_type_size(t);
+		type_size = btf_type_size(btf, t);
 		memcpy(nt, t, type_size);
 
 		/* fix up referenced IDs for BTF */
@@ -6163,7 +6187,7 @@ int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map_cnt,
 
 	for (nt = new_types, i = 0; i < id_map_cnt - start_offs; i++) {
 		btf->type_offs[i] = nt - new_types;
-		nt += btf_type_size(nt);
+		nt += btf_type_size(btf, nt);
 	}
 
 	free(order_map);
-- 
2.39.3

