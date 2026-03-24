Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58894408252;
	Tue, 24 Mar 2026 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374340; cv=none; b=iNdKQnOcOdxEbr/nUyoXTx6YClWzMSS2KCmED49aIwVntYN3U1SCpwk5Gbo5QSqhs/DE8VPRWDrEwxQCDrCTe/VatKqD0TP1BP2NU8O+CRrQveFHaX6HYpoThjGW8UC9/UzrKuJARrOxNRCAaJGdub4qaYliiV2MQdwtGTZhz6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374340; c=relaxed/simple;
	bh=Vl8d+1lloIOpJRAoS12Cp0A3vK8mnBKYu4DEwbR+X4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqX0r/3G6dmgvNdGoaKJB2YkNIn8RhPOEJbGETSjVQfmgSSLcIara+sx/REiQ1e2Z742eoNUfGpHop401tHe7Vm1HldaZ2J4UhzCoCqwgjKLDhxlsfavNX3vXAeggUo29KefSs8p9CvJhAhuYlNK31QK8DgHRWB6lvGU7QKZMkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ImCFsjQK; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ImCFsjQK"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OCBsG94016998;
	Tue, 24 Mar 2026 17:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=xrbpE
	90Tswxkx7Bq0apvQT9aEigEF/KUczrfJPjSyfs=; b=ImCFsjQKIt96vNTM4DVOE
	9IIevXoy0yY2M3lxzc7SF9PbgSNZLdq1Zgx/RNnmJNFOwnA+YcQ6hdUI/XMNzEIS
	ar7wfoPg+/QaZsyfDghX5DSsL+CGvxQFWr7ARu2LNKSv8T/kGKwpIK/q2mCWCmP2
	hxAGtbBzC4oW0xfcI6ldQI0YqKlrgkSX56nQmsqmq6xNcQvu08MfxqcxbSUSaroZ
	jGtNFh5/GqHoTJvEhm8Au7S7nUtlQLrqZJ4w/54WjS+db3KBp72tSS+nA2B5gieZ
	Mv7ho72nQNSEWRfmPLkMYRnCo0NOg7WVAIyW47oqpN8xAUYorKIE87pPT7R/fhvg
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kj2cr1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 17:45:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62OHgX0s038873;
	Tue, 24 Mar 2026 17:45:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsac7m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 17:45:14 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62OHirh2035539;
	Tue, 24 Mar 2026 17:45:13 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-54-179.vpn.oracle.com [10.154.54.179])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4d1hsac706-10;
	Tue, 24 Mar 2026 17:45:13 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
        qmo@kernel.org, ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v15 bpf-next 9/9] kbuild, bpf: Specify "layout" optional feature
Date: Tue, 24 Mar 2026 17:44:50 +0000
Message-ID: <20260324174450.1570809-10-alan.maguire@oracle.com>
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
X-Proofpoint-ORIG-GUID: KWi5vL0Q51o9B3Piswxr-GZR69seYQW-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzOCBTYWx0ZWRfX6HhuXlLXUQEl
 Dy3KDHt+CyBYJGL/ZznOlNYbSXP3qMBhT5AXsbNhYi0HtlTormbcg0RA0pcZV6ewy1Av1ckXKzB
 fg0dY7Za1xx0GPqc3Bpwchp5lSNx+3Iao/Yohl3PpdpCPg5ZzfZlWagHQ1OpynkjwwlJsPRnW8g
 7HcCQYC6rTk3q5f3IMhnnize1h6/HVLqYMTcQSuSRGd7DkJv9vFI/s/GrB1JxQxo6PTPW24SQ9N
 zgz+yr2Zotwcr2ZQ74sNkeENTMNhJxiZCUEkJCGdkxK5jwhO8+25aJtLdt/pub55ou7YpnILunT
 8kCLXG86b23ONVZdVeVPyR3nMRO5ez6mK6GdIYoRXPsUDxsseL3nZM/nT4NjwjL73VLSOBh1GPS
 wqKUd97ko3YkQnUBL8OUOwU10ZDXDptCV3DMiP9+adCr4KDQXmKM8tQy+zrN/jZ/gtKKca8NO5h
 pPs6KqPW2e1UQ6b7PILlCQf0oFUMW46IQliD5dyE=
X-Proofpoint-GUID: KWi5vL0Q51o9B3Piswxr-GZR69seYQW-
X-Authority-Analysis: v=2.4 cv=KtJAGGWN c=1 sm=1 tr=0 ts=69c2cdab b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=J4qZCyyk7QvxA2XVlwcA:9 cc=ntf
 awl=host:13824

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

