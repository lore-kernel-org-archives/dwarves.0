Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C1240822F;
	Tue, 24 Mar 2026 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374328; cv=none; b=GJHSbJPUHM4GQYBBXkYMzEYlLyvC/tJMBiBJFwwqR5nYVObw9hNRHefj/BeBBDm6WQH6FiH6fGbgo2NmcZmcC2bZgcDXZc41Ne0rIVDZyBDDUsimsAynq8MXFclBZmj04cNE42pXa3sasX01CftXzRABWQGHdK28NCdlWwVuZ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374328; c=relaxed/simple;
	bh=eV4YhYgA8Pdm0udlfyFdajwNuqFoH8jFCW2rihu8CRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjjQHmN51QO/oXwRuPuy6LlSkoDsl0TY7rfiprjDE/QFVVqteo9Uj12E6XdUGWNWS+lJivnWOSg1UM+aLtoltJgSkzBBDJ6jPSLmCG4p1ITPA4hCAcRU20ACzZ8MJRsYBFSMafct8gzRB8N+aAninE/q+kWplH/qYBx9a/c7Zxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l6CjT6dH; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l6CjT6dH"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OCCBEf3886687;
	Tue, 24 Mar 2026 17:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=xebJ/
	YMkiAf8W7LFdX2MeKMPw/A5c6Nd7wvfJLjGHx0=; b=l6CjT6dHrzCKMshImlimK
	YXhmBhYakXmwTZfuIvJNpk23CfoziAdYmPIsNdDhDLtEhRb/d6RVLH5PfZUNS22C
	hOWT80A2Och/u+5FN0l1SZHFxvb6SKckKfQCd+jeoiLySu1gVtwdicnIowokInTm
	lZjt5Y1RdsxtT4f3IWGoY6Kpct8ZA/lrBjXcyxkcBDGuzSmLpiDicpykj1Z5N3wz
	OZEM7qFS84LDKMmngnt7/EhvBjlzZU2QR/jKVd+vT6MVsVc6T0uRLqOKSd3Vd+So
	OZKVJ7mb17u5D7XsxROLq/u+OgT+WcV3GCf6aOGg/0qTfyhgkxCH6jclMEFjnxQy
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kvnmqtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 17:45:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62OG8cdG038893;
	Tue, 24 Mar 2026 17:45:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsac75m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 17:45:00 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62OHirgo035539;
	Tue, 24 Mar 2026 17:44:59 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-54-179.vpn.oracle.com [10.154.54.179])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4d1hsac706-4;
	Tue, 24 Mar 2026 17:44:59 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
        qmo@kernel.org, ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v15 bpf-next 3/9] libbpf: Use layout to compute an unknown kind size
Date: Tue, 24 Mar 2026 17:44:44 +0000
Message-ID: <20260324174450.1570809-4-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzOCBTYWx0ZWRfX2rjU2KJxdPpC
 K5zRDcTEHIHwAmXj62CIBwJued2SLm5IAK2udXMTwfbzHc86PpFkrT+5ZSTrLuu10JMISAtEJ6E
 VY9lPrlUvRYuQz0nrIFS2f262zhq81Nn5KdFgawyoEbtdqEPvBwepjrSGtOtB2FU1FUMzaqywdT
 SxpgnOeE8CF+qZwYzHXV2Ji7peY7txGlDu1ThkMM6YsfDX1rwwbcl3PqEUQDWzNRSudUuylUZgo
 bDxA8vy8Nr1taByQbmBbW8P+Z+QqbUpNwdPsr/VaPumiG6HaqNLpVcqPy5h7liBWiYQCXTyo/3i
 Ewe/JFHO2hyUzSZUf96odVsdBV523tyd0SGvNzXUc4kky0yUa3lmja4NCb3qbXQR4eRGQDIafVU
 y+oq6ZFhn/OVnjKg/7H5AYgWz7q60yVFmweVHPDPpDOEAZnoYKGCmpFHycGXdpnLAXeQjItZnGD
 0CJIa+zbKqTPaMHgoGkraAiwVvEF/Nz5yFe8WReM=
X-Proofpoint-GUID: iupN7zCOKoiy3KhW36C2XP3Mc2QEvByC
X-Authority-Analysis: v=2.4 cv=GrtPO01C c=1 sm=1 tr=0 ts=69c2cd9d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=wH1gtUtLgMC2xzGwrjYA:9 cc=ntf
 awl=host:13824
X-Proofpoint-ORIG-GUID: iupN7zCOKoiy3KhW36C2XP3Mc2QEvByC

This allows BTF parsing to proceed even if we do not know the
kind.  Fall back to base BTF layout if layout information is
not in split BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 9e7991498708..f4e3785179dd 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -379,7 +379,32 @@ static int btf_parse_layout_sec(struct btf *btf)
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
@@ -415,8 +440,7 @@ static int btf_type_size(const struct btf_type *t)
 	case BTF_KIND_DECL_TAG:
 		return base_size + sizeof(struct btf_decl_tag);
 	default:
-		pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
-		return -EINVAL;
+		return btf_type_size_unknown(btf, t);
 	}
 }
 
@@ -514,7 +538,7 @@ static int btf_parse_type_sec(struct btf *btf)
 		if (btf->swapped_endian)
 			btf_bswap_type_base(next_type);
 
-		type_size = btf_type_size(next_type);
+		type_size = btf_type_size(btf, next_type);
 		if (type_size < 0)
 			return type_size;
 		if (next_type + type_size > end_type) {
@@ -2089,7 +2113,7 @@ static int btf_add_type(struct btf_pipe *p, const struct btf_type *src_type)
 	__u32 *str_off;
 	int sz, err;
 
-	sz = btf_type_size(src_type);
+	sz = btf_type_size(p->src, src_type);
 	if (sz < 0)
 		return libbpf_err(sz);
 
@@ -2179,7 +2203,7 @@ int btf__add_btf(struct btf *btf, const struct btf *src_btf)
 		struct btf_field_iter it;
 		__u32 *type_id, *str_off;
 
-		sz = btf_type_size(t);
+		sz = btf_type_size(src_btf, t);
 		if (sz < 0) {
 			/* unlikely, has to be corrupted src_btf */
 			err = sz;
@@ -5546,7 +5570,7 @@ static int btf_dedup_compact_types(struct btf_dedup *d)
 			continue;
 
 		t = btf__type_by_id(d->btf, id);
-		len = btf_type_size(t);
+		len = btf_type_size(d->btf, t);
 		if (len < 0)
 			return len;
 
@@ -6208,7 +6232,7 @@ int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map_cnt,
 
 		id = order_map[i];
 		t = btf__type_by_id(btf, id);
-		type_size = btf_type_size(t);
+		type_size = btf_type_size(btf, t);
 		memcpy(nt, t, type_size);
 
 		/* fix up referenced IDs for BTF */
@@ -6234,7 +6258,7 @@ int btf__permute(struct btf *btf, __u32 *id_map, __u32 id_map_cnt,
 
 	for (nt = new_types, i = 0; i < id_map_cnt - start_offs; i++) {
 		btf->type_offs[i] = nt - new_types;
-		nt += btf_type_size(nt);
+		nt += btf_type_size(btf, nt);
 	}
 
 	free(order_map);
-- 
2.39.3

