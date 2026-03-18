Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B25533C18B;
	Wed, 18 Mar 2026 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773840620; cv=none; b=BkedXqpgmcKgZpYJ2G2EHNFlj3n9RQKrvIOEcwdypNs8rZ9n14+qYvr3SlQl9keD2xiY4lvDNWFF9yqw1Pbp3JN0jO+qiGcnO4otrY1T+8QCO3tarvdLDmi0vnB1OWK3K4UB6TaCGJnQlX6MjV2PGRTn2zAIjd7ja8RK7GiKNAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773840620; c=relaxed/simple;
	bh=HsPj69j/vargdJWjKWMYticcmGnlaSYW5eQGXgfW8oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7lm+JOKcdK6crSsaIcU5kcRlYdZott3G4X570HihNudLQHlWwtgCNyJXy65/Mj4bXze5QHh7jlinKZdSiyKa2pm6v3OIrHjWbDb2UnQ/RAtKi9TdGIqq8WE/sd6uaglZdqgRUcJdqGc6ijz+jLscyN+vJ6YO/lZqlOUp8NG0JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jGCKbq8P; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jGCKbq8P"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I2PiMZ1780839;
	Wed, 18 Mar 2026 13:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=6XAVk
	s+QE5aGH3QGw391SdLlxmCLd7GmG151O7ctAYs=; b=jGCKbq8P9/SJ3HGNoIt3e
	CMGXHd36I58DOmTFbcbhJBvBziG2H0sk9gZdi1koGP1Enx+xDdr1uLOpjOS/sNX4
	AZYYOpEoA7lwTgFU77kJ9RGTOzAD4LlHn+VvYtgb0Llzwz+IrRlELYiTnr+3C4Dv
	9FSI9YLRzn84XPBl7jTLHwKScxY5CAuCOnDODgtJYc6s+voGqJnz2raIB+oUoRBg
	92wEzd1HCBClMLHgkN+59ne5202gWZmEdvWP7dULRjlDbzxagqC9PNQNkJq7/W3n
	diHMAN91ZgDZvRSlICocY+tQ8kbLwLtSqQL1yTSYad6BxD3KimNBQ/kbglPRWQ1d
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxk8e41u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 13:29:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62ICeL4w030802;
	Wed, 18 Mar 2026 13:29:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4bmt5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 13:29:52 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62IDTVfI009174;
	Wed, 18 Mar 2026 13:29:51 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-75.vpn.oracle.com [10.154.52.75])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cvx4bmsqg-6;
	Wed, 18 Mar 2026 13:29:51 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v14 bpf-next 05/10] libbpf: BTF validation can use layout for unknown kinds
Date: Wed, 18 Mar 2026 13:29:22 +0000
Message-ID: <20260318132927.1142388-6-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDExNCBTYWx0ZWRfX/6JYymtm5tsD
 wRWVTog/rRQJ0uAg2NKshDOaSu6PfkK9KSWZ0asuoHWT+kQBCZZSFrd7OWQtPbWLNgZynEGyoX6
 AzpjsiMVnF7yHJMEvO9uiVccMAYfNhyolKoYRbJObFFKi4QyX1XvD+JQofItlSrHmlK1iCUsaLu
 Hz7cpJC8kQfRZkeCScqFq8k5PYMttce9YHbWa9gpj+K3pVQ/r49KgL/mzenZwNHwqCPjpH/aDQd
 rY4Ifi+Uu0CqQx4hfi9MZkgtgMIjhiGrZsMypqQ7QMv4bCOOI8wYS7XrlfpgEFp0Ie5/narOFNo
 wWWvBQAS+itmVBnOSS2/JoVL8II40Jh4XHzylmz7rp/bWWQkNHP8grQhCRzrHzynuUtTwy2MjQU
 Vfpv1DKTLFMojw2WIjJQlFLiWJZfA/Oq3gQhYw7BIgMLTqkfwK9CioEQqZUZMGtWZRby7XBxqoD
 n8OH4Mr0cecR+hqZtQw==
X-Authority-Analysis: v=2.4 cv=AI0/m/Lt c=1 sm=1 tr=0 ts=69baa8d0 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=ew25JDPet5J0AOAYVN8A:9
X-Proofpoint-GUID: UV8dz7BvKppcSlymemFLImhvrpgZCCcv
X-Proofpoint-ORIG-GUID: UV8dz7BvKppcSlymemFLImhvrpgZCCcv

BTF parsing can use layout to navigate unknown kinds, so
btf_validate_type() should take layout information into
account to avoid failure when an unrecognized kind is met.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index c033190f2ca4..128c49dc1750 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -410,7 +410,7 @@ static int btf_parse_layout_sec(struct btf *btf)
 /* for unknown kinds, consult kind layout. */
 static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t)
 {
-	__u32 layout_kinds = btf->hdr.layout_len / sizeof(struct btf_layout);
+	__u32 l_cnt = btf->hdr.layout_len / sizeof(struct btf_layout);
 	struct btf_layout *l = btf->layout;
 	__u16 vlen = btf_vlen(t);
 	__u32 kind = btf_kind(t);
@@ -421,10 +421,10 @@ static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t
 
 		if (base_btf) {
 			l = base_btf->layout;
-			layout_kinds = base_btf->hdr.layout_len / sizeof(struct btf_layout);
+			l_cnt = base_btf->hdr.layout_len / sizeof(struct btf_layout);
 		}
 	}
-	if (!l || kind >= layout_kinds) {
+	if (!l || kind >= l_cnt) {
 		pr_debug("Unsupported BTF_KIND: %u\n", btf_kind(t));
 		return -EINVAL;
 	}
@@ -727,8 +727,12 @@ static int btf_validate_type(const struct btf *btf, const struct btf_type *t, __
 		break;
 	}
 	default:
-		pr_warn("btf: type [%u]: unrecognized kind %u\n", id, kind);
-		return -EINVAL;
+		/* Kind may be represented in kind layout information. */
+		if (btf_type_size_unknown(btf, t) < 0) {
+			pr_warn("btf: type [%u]: unrecognized kind %u\n", id, kind);
+			return -EINVAL;
+		}
+		break;
 	}
 	return 0;
 }
-- 
2.39.3

