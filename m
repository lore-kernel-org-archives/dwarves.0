Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63075364040;
	Fri,  6 Mar 2026 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772797029; cv=none; b=cWvaFJ+YN8nwhlv3QqmsHORw0+xf7C25CyYrx55dlAiyraGl9s/qXy4e5MEOxeU2bIMGdBzIearktCvy2MReGNoSLITo4qWZ4Ogx7EiY+KmLvhB+ZZ7swyVUH316r4slfrPFCowXOYcBXAaTDmhLgGMfheFWzZOrzm/GRIFbhKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772797029; c=relaxed/simple;
	bh=gyikH1m3XhwY5kWLFU0ca6ZLXCa/JsT5wc5tV2rURFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2VfYulw15LnUvQR6WQ68t7IQzdPblbUECzQ/TsthTRAP5Df+EYD9KQN2aIEU0y1HmSkPUBlH8HRlGepGovvDq9lshNcROJodYg3TYPbuZU8hbnd05JgKxCBYi7JkLcseqamGH0gN8TDT1xYLZ8ds9KGuccPsRYFYi94e0dzKQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BT6q6Deq; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BT6q6Deq"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626B1ZNl2941187;
	Fri, 6 Mar 2026 11:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=NnRXP
	ypiGjCaNeWvVEONU/MN6vd1LIlJ3gHCEv4/etc=; b=BT6q6Deq9tLEBPzxgzsGc
	Fw5xLjD+PRaaSYB4Tzten7FPoLK8Qf6K/elHYh8yr2XuqIWOydGA/3Qlv72FHQIj
	UtNr2qi5Zhk5x1JzKgGVK1qqn2LnE202rXm+nEYhymaLjvHMDJKHjVKTD+UzBZ9g
	ImCGwkIn0N6IOZv3H4X8vp5u/SCLROBnfZxNrH6kfhfk6hr+L6CCrGXKFGxhYhfZ
	Blq+kOLRjfU6ZGY+1HzFQI+BuSKLmIp3uPsqF0RC7w3zgQKxlYSlZJe0uQ0IzxB0
	g73Ks6F45onnoiLXFWtv/y9tkkfi6q6V3WbK8TGIk7bwIHLeiYM+TGc0z/blHNas
	g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cqwph0154-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 11:36:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6269eIfq023095;
	Fri, 6 Mar 2026 11:36:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptjtmsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 11:36:42 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 626BaXEv025727;
	Fri, 6 Mar 2026 11:36:41 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-62-192.vpn.oracle.com [10.154.62.192])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ckptjtmhd-4;
	Fri, 06 Mar 2026 11:36:41 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v13 bpf-next 3/8] libbpf: use layout to compute an unknown kind size
Date: Fri,  6 Mar 2026 11:36:25 +0000
Message-ID: <20260306113630.1281527-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260306113630.1281527-1-alan.maguire@oracle.com>
References: <20260306113630.1281527-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603060110
X-Proofpoint-ORIG-GUID: l7VyK90PK2Z7fGPMiLBUmQKC9OxONsXC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDExMCBTYWx0ZWRfX9SMbWuEn1pRM
 bzL9S8w0wCh1Bg2OrXKjtgZJtdYHfnSHXXhzYdOHkMDB/IRC3J4WVKR6GTvNxI9zXLeIIIIcqS9
 bfZ/6QtSybtMrbYI9eGOgQsietblGz+ofqVDrrHufnk+/28M5qniHpmPXVbhkXAJq2NsSn62175
 pfQNJfPw06306+7AQ4qVotnpf4EVP2/ueMsTncKuRt1k9Q0yYo5KxdpFkF7yQSLkIwYgV/pJzWb
 PwPstra73xq1q1oyYMt4/WFTbUNnt+emIn/gwPdCxhkEitjANND/unrUGzI0uXoomX+FZqJQl/c
 QHZiZQhlgWZku/Iz6t7B+zcTiPvPx8RBlsYBhRSCK76rU7xhT5/Kcg6bpnq6oIUvtgNZzc0Bd/E
 jMa/A8ui7/Sh/D6xb0a5imXtPJtZQ4V3jVAUFegUER7umHfqLLNqdKk1/how+SeUoaBX+B5aZk8
 ASnZocRS/jMTLLm5BSJ+DiXE0bHNZNEQbzfcZMJQ=
X-Authority-Analysis: v=2.4 cv=MvxfKmae c=1 sm=1 tr=0 ts=69aabc4b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=wH1gtUtLgMC2xzGwrjYA:9 cc=ntf
 awl=host:12267
X-Proofpoint-GUID: l7VyK90PK2Z7fGPMiLBUmQKC9OxONsXC

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

