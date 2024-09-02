Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFB419F105
	for <dwarves@vger.kernel.org>; Mon,  2 Sep 2024 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286257; cv=none; b=n7kfddvUVns/XZUqItpCHX80dFsQCMHwAAePHeThYxoVzbWEOm+xMhmZ0Adqa5K9owFStLvNCjNXG0rBAiTleXUDUgutEvYl13zR+IdJS2ZRVVOfbVJdYWe6e+/MjWK8euUlowJTNn3k1CS1owt/34+0CrJfceeG0qI6EAnlJKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286257; c=relaxed/simple;
	bh=5YAqI5qlnFc44BG62S+bvG875AYJ7kwTaW7pafpgn8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VrvzYWxDtTCHtf9JmO4ZHK4H4yXPJKSkOqbvird9ruhZ5IKR/yfalcZyiqB7WDe8oAfsJ5oLt4cnAunHfJHhFls30fWfZgvEYCJFZQThTuavgJ9e9Uxa7Sn/7FuH8TKtqwPXSVhiuclV7TD/XnyNDc7+HM8KOq/qJKnrsAUHAV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NLnHGv8l; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NLnHGv8l"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 482DhA4a014224;
	Mon, 2 Sep 2024 14:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=OQihRXqYnEiWH3
	lhdXQgSByE8xW8+huiPu08Iz913jQ=; b=NLnHGv8lR2YUQo5S6fPHukvLB1hjdw
	Zvbz8NPCcfLCnWqtRUzinf/RfdnFJH2A5K3Ivv2NB5nbWCvYStEZW3ZE8mFkTRBb
	IGdIZ4klPgyHgYKajQuiVRkJhILBIgZdQbS1e+PKRrLX0Q04y2sL27bEOYZHtJ/p
	lPlP2ZLtsPAA3rU9M5fqRpB8uSeG5cIRDmYwROce4EFeC15qOgLV06DveUDtdflN
	XsaaVJcO3lU4O4sej6xMfyi0rLbFMxxGYDxxweEp4JBgWlj4eRXgSXxWnw5Bgf5I
	R1C14RLUXXI1ykzN0p+F2kxtKjpQKaaUP9oO86gMRAtSng5ViKgYg1xQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41deg5g1xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Sep 2024 14:10:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 482Dq3gM016448;
	Mon, 2 Sep 2024 14:10:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmdqwad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Sep 2024 14:10:47 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 482EAlQb030686;
	Mon, 2 Sep 2024 14:10:47 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-190-140.vpn.oracle.com [10.175.190.140])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41bsmdqw8g-1;
	Mon, 02 Sep 2024 14:10:47 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: jolsa@kernel.org, andrii@kernel.org, ast@kernel.org, eddyz87@gmail.com,
        dwarves@vger.kernel.org, songliubraving@meta.com, martin.lau@linux.dev,
        tony.ambardar@gmail.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves] pahole: Sync with latest in-progress libbpf-1.5
Date: Mon,  2 Sep 2024 15:10:43 +0100
Message-ID: <20240902141043.177815-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_04,2024-09-02_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=955 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2409020112
X-Proofpoint-ORIG-GUID: fnZhnKDWXz-Ay83b5F-vD6oA6plHl3zP
X-Proofpoint-GUID: fnZhnKDWXz-Ay83b5F-vD6oA6plHl3zP

This will pull in fixes to BTF support for distilled base BTF.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 lib/bpf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf b/lib/bpf
index 686f600..caa17bd 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit 686f600bca59e107af4040d0838ca2b02c14ff50
+Subproject commit caa17bdcbfc58e68eaf4d017c058e6577606bf56
-- 
2.43.5

