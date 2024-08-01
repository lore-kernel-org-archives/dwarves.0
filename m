Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE8416EBED
	for <dwarves@vger.kernel.org>; Thu,  1 Aug 2024 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505870; cv=none; b=ngHDrjGvtwiv4DdLvBiKqwDv2ddiJhmNm9Oh/jpggl2ZU8VET6kSjOsQxlkNudoSFZduW4TWlqXhqGDC8lu0L35Bw5UeyUIl5du8vEO2fEaAP8yfg8Kk5VmIPMdybjl5gIRT6jg8rwNSHuYKMVXi9YSYPVcfg7X/d+KxpnTJY+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505870; c=relaxed/simple;
	bh=Rt8as0EJe38nDaAkJuYaVqWHzViEuz6F9o8f/jfgQlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MaMXVf5VoqPBISEwg1fQ73dSidR+32C3VJ4OkebxkxFBP7KSTtwQDto9B2+0tg1C0J1X2RjdC8puNu3aKZJssygpXEGSoHhbxxDpYVdo67zL0TSy2iF65czcMj5ctHeTQUdTpKGeF+jUkZvEYHX5gJlxKPRoBdaIT9oTcnGa+rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KxuDvD/L; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KxuDvD/L"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4717tX8J014048;
	Thu, 1 Aug 2024 09:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=B/pHOUOsnjgyte
	99zppOeUcCzjlHU7669QMo6cQJHyc=; b=KxuDvD/LIfg00buRmrLsd0rM6Vd/ZD
	uxVh/DrfYcP13Rm5kELrAo5y9RjFeUUn5oCwF4hYV6UdPlj5oq4qv/0q2D5OFCZo
	NfB1xbRHgDL0uDr8Eb5Vx2Qrc3P+BHVKK2rhJw+Lj/ti2Gy+HoUNPcozrrdp8x2P
	JiTNUqvEuVOAP7J2IM7ZT92XFVT76D3hn2SRtOFdKNAIBOYdEvsmoPfX7vtZ79g8
	+cO/x5VOzSKO4r+PZmIFQ45YXSovYFkins0U559fHWU/arxCGMyZXW8pl6/LTL3z
	WevLm2NgcHcbd4wBbkT7me9mzqvzAwuV0nhjnsGsbHaUCWpQtZ3dxiAA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqtase78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 09:51:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47198rjn028949;
	Thu, 1 Aug 2024 09:51:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40qmpss7rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 09:51:00 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4719p0Tm036641;
	Thu, 1 Aug 2024 09:51:00 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-166-115.vpn.oracle.com [10.175.166.115])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40qmpss7r8-1;
	Thu, 01 Aug 2024 09:51:00 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves] pahole: only warn about multithreading in verbose mode
Date: Thu,  1 Aug 2024 10:50:58 +0100
Message-ID: <20240801095058.1946790-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_07,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=990 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408010061
X-Proofpoint-GUID: 86KVAwzRbaXsMWvCIcIrAEHEajWQfHIk
X-Proofpoint-ORIG-GUID: 86KVAwzRbaXsMWvCIcIrAEHEajWQfHIk

For kernel builds, pahole is called with -j to specify multithreading
as long as it is >= 1.22.  However, if elfutils are older than 0.178
at compile time, multithreading is not supported and we emit a
warning to stderr.  The problem is this message will be emitted each
time pahole is run, and this translates to thousands of times in a
kernel build (once for vmlinux and once for each module).  Often users
who are not familiar with BTF generation or pahole reasonably assume
this is an error, whereas it is actually fine; it just means that
pahole is a bit slower to generate BTF.

Move the message to verbose mode only, as in debugging cases it is
important to know if pahole is running in parallel.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 pahole.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/pahole.c b/pahole.c
index dd5002a..4db5107 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1889,7 +1889,8 @@ static error_t pahole__options_parser(int key, char *arg,
 		  conf_load.nr_jobs = arg ? atoi(arg) :
 					    sysconf(_SC_NPROCESSORS_ONLN) * 1.1;
 #else
-		  fputs("pahole: Multithreading requires elfutils >= 0.178. Continuing with a single thread...\n", stderr);
+		  if (global_verbose)
+			  fputs("pahole: Multithreading requires elfutils >= 0.178. Continuing with a single thread...\n", stderr);
 #endif
 							break;
 	case ARGP_btf_encode_detached:
-- 
2.43.5

