Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52A41A726B
	for <dwarves@vger.kernel.org>; Fri,  1 Nov 2024 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471632; cv=none; b=BxU2napquGu4LLOtMVE9NMKlUjzuqRSIlQHukZgtIuFbuMdnYqC/0WWYzVoGiiteJ1EWWvFZCWHt1r4WLTUEKXHI/R1OKYqssfbjqUpCqd3JgO5rdDoqWfSCJf03bt/TPe3lbURSl/vXjgGZrTrcLyoH43dzi0t51/9CuRn41JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471632; c=relaxed/simple;
	bh=kdicMl9bqit4NtaPcvzQH+DWvkxHYutlusIgqWUymZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DPF6b6ExrEklkPUjXSf/84jkvtlKEG43b45x/ZrcZShBnUWNLR33W6YJg80EtGSzFM8NlNrYOAbU7fqSSvE1ykAQLq0b4zNsh2QMB9lGHT+sr9IREOv7zkWo1GRnT9J4nLKriZjg7EGcnt6KTfvKQ9zceCpiwZ/z2M56P+TkcXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lsR5ckxV; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lsR5ckxV"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1DfeGv009306;
	Fri, 1 Nov 2024 14:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=iAiBaE12+ej6yNWZqy+sFa930t07l
	yiaPNVl4v8pMmI=; b=lsR5ckxVm2fibK4J53ZqwwEqw2HH7RpBSMM++85JvyIPM
	JzcXZMQ+Gm69MaQpC++uWzpm7hqIOs93iPUeTNr5/83fS0Mxi3W26i0X9nfTnogL
	ukjFDVTW9AGUTS3ntBXtLr8hCO+TMcr16HFy3jyxpSchCPTYocfvjxhvVYmHL3v8
	Hz4nxgCOFyZ/9sZRItPDalVtaRhLH2uLAMTLZss4cHm7x/LceEinaW3biP3mTJJ1
	/mwSuSPH1B2VtZ45wJBVaA7jAQ3JAmB0eeGcnmsFjIMIiKsRWD6STg2XC2Y46gRU
	YlsH3Yhs77JQSFygMjGzRXWx8ZUPRxYAXCVkQ8+/Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdpccny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 14:33:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1Dof7q012103;
	Fri, 1 Nov 2024 14:33:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnagm4s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 14:33:45 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4A1EXiKc038983;
	Fri, 1 Nov 2024 14:33:44 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-164-140.vpn.oracle.com [10.175.164.140])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42hnagm4r1-1;
	Fri, 01 Nov 2024 14:33:44 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves] pahole: Sync with released libbpf-1.5
Date: Fri,  1 Nov 2024 14:33:43 +0000
Message-ID: <20241101143343.1131182-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_09,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=870 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411010105
X-Proofpoint-ORIG-GUID: igBDyURsq-t30Gm9CbbyOooRdfzm05nc
X-Proofpoint-GUID: igBDyURsq-t30Gm9CbbyOooRdfzm05nc

Now that libbpf v1.5 is official, use that commit for syncing.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 lib/bpf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf b/lib/bpf
index 686f600..caa17bd 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit caa17bdcbfc58e68eaf4d017c058e6577606bf56
+Subproject commit 09b9e83102eb8ab9e540d36b4559c55f3bcdb95d
-- 
2.43.5

