Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D631BFE00
	for <dwarves@vger.kernel.org>; Tue,  1 Oct 2024 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727783197; cv=none; b=hrWs2N6vUIpx41coq/jMCY/KBAhRrO3GSmudQX3CDMQUyUEKXJTwM6fE9t44vmO9Z2y6AzUQLrwJWS+7skPCYQ3/1WgpnGFws9jb7wplsiAP0aKsec0HKkjTHGZfL6ocZ09XyrilAj5w6jX8o3lTpbrOH0cI7lH/Qdb1SU2TBi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727783197; c=relaxed/simple;
	bh=gZn8SqELAdEszA9HEJZsX7cPrWbMnKWKSRCaBC5fAFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jEtkoK70n95gCcShL1WueCgdjLox1ITZf2O7znbr5sbUpeFIO5Jfc4HoQMtWaLboA6uj/QU/WoCmbgWRBshERpe5zNM60RCfr+RHd3R/Klg6mCZL1/5XbgrWqRN0jxoMz3RRoX0Q1eyvpPv1wdIuKhgYbukxnE9oS09fOhFY3XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JSgx5Dku; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JSgx5Dku"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4911tacx027873;
	Tue, 1 Oct 2024 11:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=Uy+QlXzeOshDd+
	piXnP6p7rZv8MuY0rLiKQJaCvEkZ0=; b=JSgx5DkuT2GpCaltwskzSWywWm+7Ij
	VeHxPplRmhaQZyGelkR8EMCkI8WGqwXljqJkdYeRKTh0TaBz9ZOgUgFYLrJ8YwDJ
	kbI8syUMPobU/+nL7TC/IFw9zRI62u5guzkFmQxIlssv88X5hMkhwBnhrC0zytpL
	d+p07ILMy3eyGJ68ciK1C65Bh6pf33XkKBCtXVnVoivf1q3Rx1YMMVY2yrFIvjD1
	HF/OXMwjAKcHeI6TlTDvqBIKaGnykUxeDgdatNyzdQA9BOJDFVMPRaktcyux7Kw/
	QRjrwrwt7bpM8nmHWSUtE73j5ydLdWcU/YSwM6PsbbfEfMYyzcIp/SmQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9dsx1cq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 11:46:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 491A4JsQ026270;
	Tue, 1 Oct 2024 11:46:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x887ee04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 11:46:31 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 491BkURv024830;
	Tue, 1 Oct 2024 11:46:30 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-217-229.vpn.oracle.com [10.175.217.229])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41x887edyu-1;
	Tue, 01 Oct 2024 11:46:30 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 0/4] tests: unify behaviour, pass through fail
Date: Tue,  1 Oct 2024 12:46:25 +0100
Message-ID: <20241001114629.3947401-1-alan.maguire@oracle.com>
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
 definitions=2024-10-01_07,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=730 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410010076
X-Proofpoint-GUID: g5NzqDFSvciEJUG9LIRTJB5nUcv-Vx3C
X-Proofpoint-ORIG-GUID: g5NzqDFSvciEJUG9LIRTJB5nUcv-Vx3C

The "tests" script has recently been added to support running tests;
unify behaviour across all tests to

1. return 2 for cases where the test has to be skipped (versus 1
   for an actual failure)
2. for tests that require vmlinux, allow it to be speficied via
   environment variable; this allows the tests script to be run
   with a specific vmlinux not discoverable via pahole

Patches 1-3 handle updating individual tests; patch 4 ensures that
if we hit a failure, the tests script will return 1 to indicate
that a test failed.

Alan Maguire (4):
  tests/reproducible_builds: support envvar-specified vmlinux
  tests/btf_functions: return 2 to indicate test had to be skipped
  tests/reproducible_build: return 2 (skipped) if no vmlinux available
  tests: distinguish between failed/skipped tests

 tests/btf_functions.sh      |  4 ++--
 tests/reproducible_build.sh |  6 +++---
 tests/tests                 | 13 +++++++++++++
 3 files changed, 18 insertions(+), 5 deletions(-)

-- 
2.43.5

