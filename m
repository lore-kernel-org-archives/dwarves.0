Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67A63D8114;
	Wed, 18 Mar 2026 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773840648; cv=none; b=HMiUvdZv8lkHCrMDXBv7b1a5Enj7s80j43XKmjSo7Git7k5luq3kfaPFx+uGyhNMJ2vdt8WPeZ6lpBMT9NFUrTsn+hPtmVzQRmG0TfC6hBkCjXjwZ2f+qYr8PWNl5pYjAFOU0aRunOfDHiCww8vPMzoT2MRCYj5cuJnq1lik9tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773840648; c=relaxed/simple;
	bh=Vl8d+1lloIOpJRAoS12Cp0A3vK8mnBKYu4DEwbR+X4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+zUHDPz6KzN8OKzMYj8fIwVT0S3Nozm72MiKm6mCFacougN8ISALOzCoUVsSjRBIocfLofsfLAvJlKV+vzprJ7zokOBHH+SYzs9klOLj9+Lsvko6uQ8iY6x9QSVWoZynjsSYRlPXdtLgPTrxi/XbZJxeHTrVQQBQDSbKQ3qZB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=URh7bpjS; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="URh7bpjS"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I2Mv3r2167105;
	Wed, 18 Mar 2026 13:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=xrbpE
	90Tswxkx7Bq0apvQT9aEigEF/KUczrfJPjSyfs=; b=URh7bpjSio+kCup/Bg3q8
	ixaHJkqTMvLZCYkeWghUvN4tbyqjrk31vPXFjfEZTadSnVMyHvnK7QVVbO0dhVRD
	Caw9+KlTURjq3XzKMCBUM4U8vf8nwB9gpCQMWoRsVAQZjvnIJS3O3DbS4k2e99pA
	Xi/hBvL9gWgG9d8IjNtXvnRyw9c/fxvOjmjXM44aHNSR782bD5MKMsRS4P/xXJB9
	GwCpMBm6kAQkHCv5eF66dXChJnVFemA0dK90ZTFwKtdbg1hm4B/TqrAL8Ahjd+TM
	mqVVDyeuQNovGBk/GZmP9OSV3t/+8g1AZJy9bZqAtNn4MuNzV8oRU/p+rrULAwx4
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvx3b5xpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 13:30:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62ICewS2031300;
	Wed, 18 Mar 2026 13:30:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4bmtqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 13:30:12 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62IDTVfS009174;
	Wed, 18 Mar 2026 13:30:11 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-75.vpn.oracle.com [10.154.52.75])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cvx4bmsqg-11;
	Wed, 18 Mar 2026 13:30:11 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v14 bpf-next 10/10] kbuild, bpf: Specify "layout" optional feature
Date: Wed, 18 Mar 2026 13:29:27 +0000
Message-ID: <20260318132927.1142388-11-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: TgUulkartxZuZlikg2gpdrZAwinPbYk4
X-Proofpoint-ORIG-GUID: TgUulkartxZuZlikg2gpdrZAwinPbYk4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDExNCBTYWx0ZWRfXz0I82tpPFdGZ
 i+4wkCHSA3mGa67TGVPY9evHy7i2G1ugSiej8aZQLuxclCoDEZ69wYabqes96xgs+6T5H2869pe
 jKmURdVTFQdg6suBk60qQnNleSElgyjpL5SDlldyWBvMlOTXpupLEyf1vRYmWbv/+o8uW77j1WR
 uiewYFQ9cH/K189dgYYyG9bvLxje9HybiT2xI4ciK3ZKAHJqYW9OVoWwrtGNPfv730dL7zIhgOF
 UXPmTJfSZMDgVTSmFcZ+8tZtZnbqpXF3z+/K/wlQ1Cv82iqiYZUmUrLAi16mHBdClwLYYnothWl
 c+6pwviOO+0slx0R05vvRJsjlQpRmymY8zjLxfZkaYu+z0fQsV+KyE6QV2zbWdVgPxyXU1FDkrK
 8aNbFXjvX3F71qBYuFhFv91s+IE/SlKDxd+B3ZmPo4bXBRnxtR2d0FuFahIT3zoc9oHf91nEq+o
 RNqFBOLCvch8D+9VMqQ==
X-Authority-Analysis: v=2.4 cv=IN4PywvG c=1 sm=1 tr=0 ts=69baa8e5 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=J4qZCyyk7QvxA2XVlwcA:9

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

