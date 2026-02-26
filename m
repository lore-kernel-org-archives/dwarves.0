Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304EA38F23D;
	Thu, 26 Feb 2026 08:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772096233; cv=none; b=Yn/LKiQ5bNcRh80fZDlGyZU6ROMWUZUve5j7aU+Xa3+bmLikQjxZ/czierFKjBxLljKYdJA9MOtmP/svdVM66FjhMMqc2sinl9GY811MislhIX94a+yLuERztoyIn8ExQCBjD9gr9kdDQ0GeqRHS0n/lY1Y2qboI9iUkKmxoNis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772096233; c=relaxed/simple;
	bh=95eBYhdI1iUuL3bfr9PXxNExpQqK7pYBVX9utmEMf1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLsQv+0MePAjj4978J64dwxnMamPqwBH9MC4od5ZB0IjtGm/wnebc64k91pTfeN7OZPrHhTeA9tKIaATXVUPiYOKfwnY6WADmPrUthB+EMPIAdpg9DBeK/dveyw35CRNQqobBlWnkLnn3fjvvrtjdl8CFIL0Ogg1gk231uFmz1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F/lPRxVS; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F/lPRxVS"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PNv8f33709376;
	Thu, 26 Feb 2026 08:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=rYg8p
	qutlOAwAiw0E7J5QGFIgTaS2vZ8X0W2382Z9kc=; b=F/lPRxVSjdBDlTjj7ezoG
	8TvzOWvZcmk2d9CBl3mjzZ9NPKAzuTKOzuZn/5DybFC0dhejyn0ZFFNhg5E37TwK
	0ep6GGGDCA90QO6yxAzidnkiItdkRNRJrZy8r/ck96HnYFQ9gU5zh6EGMItYAgAk
	660pgtnxqecd9hSxAs5oQT0thwbMKdo5crOdG/bIKpiEKVwBu9B9Qlpa5nGR8kcj
	cH2JH/vnAN7kUPCXq3CHaUy9JTlRDBNvd6D3xG40t5vMoC3uAn/4n2Ez0FoW0wFy
	5KxR+W+Se5sXMhmISB9s1F35/2YZ8ULK08I+u63R/qOdK6tQ8nYPPgqaTjyJMCkM
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4arfty3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 08:56:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61Q6a7Jm028678;
	Thu, 26 Feb 2026 08:56:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35c75e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 08:56:46 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61Q8uYaW038952;
	Thu, 26 Feb 2026 08:56:45 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-58-146.vpn.oracle.com [10.154.58.146])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cf35c759a-4;
	Thu, 26 Feb 2026 08:56:45 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v9 bpf-next 03/10] libbpf: use layout to compute an unknown kind size
Date: Thu, 26 Feb 2026 08:56:17 +0000
Message-ID: <20260226085624.1909682-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260226085624.1909682-1-alan.maguire@oracle.com>
References: <20260226085624.1909682-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602260079
X-Authority-Analysis: v=2.4 cv=La0xKzfi c=1 sm=1 tr=0 ts=69a00acf cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=wH1gtUtLgMC2xzGwrjYA:9
X-Proofpoint-ORIG-GUID: 1ZLtdIMI0FXmzA2RFlqlk97rL7LDvukr
X-Proofpoint-GUID: 1ZLtdIMI0FXmzA2RFlqlk97rL7LDvukr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA3OSBTYWx0ZWRfX8uXd2lUFL1Jy
 aCgM27ofSnyubHtAvSS1Q9Irm2bSwxnMVimiTTFFmzqUaeA8HtwHk028/Ux9IrVKEPgnIxfxoyS
 75WURIawDQlqPsorXobLwErpKGQ8jewmzQV9UP9juWfgkDMiZM0+tWEtbI8IlOdJQcRIiNrH+fx
 7FK2ve2hojwZLY2XvRNLr0satrlcnYsz+krJ+rH4OYkxEsgsUKDgrLUuG+eZYnNwKnuzuCVZuym
 U7RI9tFbwYtfttpx7b2HMZAJRpPb5vD+yT5WyeUXHOEiUvT6X5FmQnDwMXxY0Mja9qbTghN5CQi
 LBl3KqCLh6wMn331/yripvf2z57dPJmIOBP7gg0p3jflP4psdXG0jdvarB8kqPsZxhEW61X57h8
 wv7phIhPpQep/NzQmZV/nRyqG7DevHiftbX+cdUH3kbaa2rXjUalE1CwoSIcZ/J4A6R0c1+Q50R
 WHxy4+J7Blim/bsSldQ==

This allows BTF parsing to proceed even if we do not know the
kind.  Fall back to base BTF layout if layout information is
not in split BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 46 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 3438cc15bb7a..c0603a8f8533 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -355,7 +355,36 @@ static int btf_parse_layout_sec(struct btf *btf)
 	return 0;
 }
 
-static int btf_type_size(const struct btf_type *t)
+/* for unknown kinds, consult kind layout. */
+static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t)
+{
+	__u32 layout_kinds = btf->hdr.layout_len / sizeof(struct btf_layout);
+	int size = sizeof(struct btf_type);
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
+	size += l[kind].info_sz;
+	size += vlen * l[kind].elem_sz;
+
+	return size;
+}
+
+static int btf_type_size(const struct btf *btf, const struct btf_type *t)
 {
 	const int base_size = sizeof(struct btf_type);
 	__u16 vlen = btf_vlen(t);
@@ -391,8 +420,7 @@ static int btf_type_size(const struct btf_type *t)
 	case BTF_KIND_DECL_TAG:
 		return base_size + sizeof(struct btf_decl_tag);
 	default:
-		pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
-		return -EINVAL;
+		return btf_type_size_unknown(btf, t);
 	}
 }
 
@@ -490,7 +518,7 @@ static int btf_parse_type_sec(struct btf *btf)
 		if (btf->swapped_endian)
 			btf_bswap_type_base(next_type);
 
-		type_size = btf_type_size(next_type);
+		type_size = btf_type_size(btf, next_type);
 		if (type_size < 0)
 			return type_size;
 		if (next_type + type_size > end_type) {
@@ -2056,7 +2084,7 @@ static int btf_add_type(struct btf_pipe *p, const struct btf_type *src_type)
 	__u32 *str_off;
 	int sz, err;
 
-	sz = btf_type_size(src_type);
+	sz = btf_type_size(p->src, src_type);
 	if (sz < 0)
 		return libbpf_err(sz);
 
@@ -2138,7 +2166,7 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
 		struct btf_field_iter it;
 		__u32 *type_id, *str_off;
 
-		sz = btf_type_size(t);
+		sz = btf_type_size(src_btf, t);
 		if (sz < 0) {
 			/* unlikely, has to be corrupted src_btf */
 			err = sz;
@@ -5473,7 +5501,7 @@ static int btf_dedup_compact_types(struct btf_dedup *d)
 			continue;
 
 		t = btf__type_by_id(d->btf, id);
-		len = btf_type_size(t);
+		len = btf_type_size(d->btf, t);
 		if (len < 0)
 			return len;
 
@@ -6136,7 +6164,7 @@ int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map_cnt,
 
 		id = order_map[i];
 		t = btf__type_by_id(btf, id);
-		type_size = btf_type_size(t);
+		type_size = btf_type_size(btf, t);
 		memcpy(nt, t, type_size);
 
 		/* fix up referenced IDs for BTF */
@@ -6162,7 +6190,7 @@ int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map_cnt,
 
 	for (nt = new_types, i = 0; i < id_map_cnt - start_offs; i++) {
 		btf->type_offs[i] = nt - new_types;
-		nt += btf_type_size(nt);
+		nt += btf_type_size(btf, nt);
 	}
 
 	free(order_map);
-- 
2.39.3

