Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A872264C0;
	Fri,  6 Mar 2026 11:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772797176; cv=none; b=odVXGOOWP57wxC+4d3YH0n/k/Xqw6Osew61hiNBFQxBCuMYITE+G0S7CXwijckUnXUfdMhvKwm7WUwZQYiTu+d65S5SMVnJRLsFlCy/56rv+1n9Yl0qkkO1S4wF+NrTvb33Bijw9emHiqQYefF6zsCFV7im/eH/iywdhj3+7ghM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772797176; c=relaxed/simple;
	bh=Vl8d+1lloIOpJRAoS12Cp0A3vK8mnBKYu4DEwbR+X4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Avo/3AJPeMmegkEC5jATV3HS2ltkCkRPk06LalLW3afqDiXOVX+fi1RLQIlYiN6MUaUeXMLZ/hVQSEvczNlVvgsY3bzIIZD0Dw84R7q9A1CfehYFqBiKiPWWiYoNKxq1Vacq2hPq8zEx1DzO478mQy+cZaSr6d0uNbCytXDxk0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m+RZbZB+; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m+RZbZB+"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626BNKPO3148233;
	Fri, 6 Mar 2026 11:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=xrbpE
	90Tswxkx7Bq0apvQT9aEigEF/KUczrfJPjSyfs=; b=m+RZbZB+rw2WRhudtKJPP
	AZXCklGR/f0z+50rxR4g3t5tPaLDPJrZJBvxb1xY+u0Q93JwIkIBg3FagVyOvU4k
	1p8u7A42UJjGiub833/db90VuQd+uQtHN5fU3vMDOlaGaz1tWH53JM/1gYlmC5Ry
	HfOyWEVvQJ+LeEsz0iChVJ0sPjLBSxyxuFCY6KswdO1SXxotGgT4QhYWxM0uJJLT
	rS8Lt26wUZo2qybPuuNpReu/W59qWjoIER4hUJYXyYxtcztNi0cBuNQwmMqqV7uc
	DTiCAHNN1nzEkmIvt/UixcPNbVYxXUUgu4TM1rSsnTMGrjSrG6r1eTZsBBn090Z2
	A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cqx0r80gb-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 11:39:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 626A98kW023170;
	Fri, 6 Mar 2026 11:36:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptjtmxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 11:36:55 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 626BaXF7025727;
	Fri, 6 Mar 2026 11:36:55 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-62-192.vpn.oracle.com [10.154.62.192])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ckptjtmhd-9;
	Fri, 06 Mar 2026 11:36:55 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v13 bpf-next 8/8] kbuild, bpf: Specify "layout" optional feature
Date: Fri,  6 Mar 2026 11:36:30 +0000
Message-ID: <20260306113630.1281527-9-alan.maguire@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=K6Mv3iWI c=1 sm=1 tr=0 ts=69aabcdd b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=J4qZCyyk7QvxA2XVlwcA:9 cc=ntf
 awl=host:12267
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDExMCBTYWx0ZWRfX7iRz0Q0lWFz+
 lllwg2k8e9x2uN6qBfho48zpyRNDSMjeeUh/Q3qjoo6kYHvOcLrBbgkNoqp27J9ZCWXUlHGQYOz
 QXItCg6qUZe6Ih9F4ACxYa2cj8TRTLi/KK3Xhj4swOoEn/+qqbUD3MAG4bUoWWHiO41DMoj4wdm
 Cz/3hbw9LGR5F6GEqUyBXE7NPX0kQZh80yMBuySJ29YMch+IbTuGeJpNVzaO++UcMs6R48QBgS+
 k5BCu3bvfjGtWVC9HIv60dn2jjeccuJTWl3y/atS+UBsdGmgvpPlzcqTxQA3H3uxH0b/ShhFNdo
 Gw2hEwBdxFdBnc1kE56NXFQPI63J9u/FHKpKSJy+Cdv8GuiyYUsaESDvvtM7l2Ols8OsRZTn16M
 uRqAXramIO77PkJK7rIzu8ujbVkPAAzS/We6y5WlRPI6gC23z6zpQ9WpCynjyMuKS5f4pfKW3Im
 X3Norbra/iVdmlCnx8WeXPdMxbPd5iw2WESifFDs=
X-Proofpoint-GUID: uXZNZGn7bLyM5BS-I_-oodZBe4-LSJon
X-Proofpoint-ORIG-GUID: uXZNZGn7bLyM5BS-I_-oodZBe4-LSJon

The "layout" feature will add metadata about BTF kinds to the
generated BTF; its absence in pahole will not trigger an error so it
is safe to add unconditionally as it will simply be ignored if pahole
does not support it.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 scripts/Makefile.btf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index 562a04b40e06..e66e13e79653 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -18,6 +18,8 @@ pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j$(JOBS) --btf_features=enc
 
 pahole-flags-$(call test-ge, $(pahole-ver), 130) += --btf_features=attributes
 
+pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=layout
+
 endif
 
 pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
-- 
2.39.3

