Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D321E7C12
	for <dwarves@vger.kernel.org>; Fri, 10 Apr 2026 14:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830006; cv=none; b=Jl/AkiOtY0sI+93WL6kisiwFzU2/KlfAqfs5qgOzZqulGfCuDEijY3Npt90RxAO3wZ+00taIm4o2OGWXEoub8rxuFLmTWNRxVJWROd7XRDg7NpvT504Y2Ahs54wkL1UaO7OFbd/CgMbJzw1mfTfk7VkGv16Apg12fJCnk2LEs6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830006; c=relaxed/simple;
	bh=mXaPVkTMXxV+WCZmuHprvi6ofhBU8MF8u5es8d5+/1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fpqEANbmm4/JtPkWPvZPX7S0cicjpnrRtmoIEWiCReV6N1a8k/+VyIfiORQiK0RojYtOIUHAnAB/Xmwj48NPjQqAQEXJyCPGhZGYuluO41sMo+sjpKjHUEArt/bzWlbRjtKVFL9I5k8xuiYIff6xNJNJcHHdjaN4YnfDkOZz8aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EjG2yLPO; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EjG2yLPO"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A8tXtY1163338
	for <dwarves@vger.kernel.org>; Fri, 10 Apr 2026 14:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=MlfH/H77sIjJDg2/q7eBlDbOHvUDH
	ihkuReCYvHHozU=; b=EjG2yLPO2M97fnLoag5HpJ6iFclZmF+EVgOmQoQP4HPfB
	4rvMctQKcnkIhDmcAwnhTiME2DptOsxH4hgJuo36g4AHDjuJUCIOQMmJp2BFZuSF
	tt2V0gkEoUWqcXLmZO/ig/pGZXQScVISLm2EluEW5MS+r59DDzWVhBYVD0eq7fjF
	nvRUrWmtTHE0lvxrs9hfXvYCrGU53fRiwbODvKlbbG4DskRYHIgkzdgVIUlN6e0x
	fDKX0bDnndYYPHjAc6YCKGJtfYdsXi1K5KW9sQ69XmZsMi5V5sq8S55aoH7NQTkW
	uTnJq6SGR43QV3ehz5IVe3urFHGyMB6eiXOpoW6uw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqehe35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Fri, 10 Apr 2026 14:06:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 63AClKlZ011609
	for <dwarves@vger.kernel.org>; Fri, 10 Apr 2026 14:06:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dcmnu9j7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Fri, 10 Apr 2026 14:06:43 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 63AE6hUb018808
	for <dwarves@vger.kernel.org>; Fri, 10 Apr 2026 14:06:43 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-49-240.vpn.oracle.com [10.154.49.240])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4dcmnu9j63-1;
	Fri, 10 Apr 2026 14:06:42 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves] dwarves: libbpf sync with 1.8
Date: Fri, 10 Apr 2026 15:06:40 +0100
Message-ID: <20260410140640.1599570-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=919 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2604010000
 definitions=main-2604100132
X-Authority-Analysis: v=2.4 cv=MtJiLWae c=1 sm=1 tr=0 ts=69d903f4 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=Jh7lIwcvCw-u6HYHoa0A:9
X-Proofpoint-GUID: MVxnvAqA8e_c2l-tGEbdXZDCjRhOGocx
X-Proofpoint-ORIG-GUID: MVxnvAqA8e_c2l-tGEbdXZDCjRhOGocx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDEzMiBTYWx0ZWRfX8OOA1dVCVDj1
 7KxSo7Nxd09QAZTAoC94OX9ILQKaF+nIqATj8f/JZIJlj6FOG5gXvcqnNuvSh3H15+jMaIXJVos
 XmQmQl343hcNhdZ3P19TTeyf3N4y381G/xDueVM1NwkdKLCKGAHWGt7oqm8KS3/5sct1zqmVPMs
 G4bz4t/0e9vluoZmIpFuzGLfbSu/OPj1E7kp6lnAoA9mIsUgovjhu0CzuPvR5NyDJwYImFBcGlV
 3mSzw2EORPh7OtwZTqtDpA/s3hZbu/m3AOH6IkUk5E01gbsvEhrsiVNqOtV5eVAeMw0FZ9F9llH
 xB1GrOHzVu3BC0io9QjCII1mqu91ZNHNg+Wbkfj7Ydhs39/6o2kBFG2vh+loRxgZ8N8xKK8wntX
 nOTuIxlS2yDk+6yI0pmsLMMe0IrxNiFEyisOuMZH4TRJ6fogyc2epwCbeeflfc2ubWGMLO8kDHA
 G8V+2Ujh6echvHBsOQw==

This will enable support for the layout btf_feature.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 lib/bpf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf b/lib/bpf
index 374f780..3d451d9 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit 374f7807e197ff35b5c234478e89fddd03e6d0ef
+Subproject commit 3d451d916f833afed06bfc74026a3650de8dd649
-- 
2.43.5

