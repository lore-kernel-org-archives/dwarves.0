Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C592F43
	for <dwarves@vger.kernel.org>; Wed,  2 Oct 2024 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727868827; cv=none; b=HQS99I1rTv7BUksVjpO3W6b3SnzmzuZIUGB5yh7MsgGJpi4pWGpXOngV+3fuxzl35qwITegrtDhWokZh6zGTFeIFyhKUC6DgZX3xd3mqaJ7AyplUn7amrD/lG1JunK9RJPl40E6GPRWW36TGDsB8oypE/Bb8B92HDoNOGHVCdwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727868827; c=relaxed/simple;
	bh=q74AsS7tq+moUJwJJqhVzMnA4gCkn5ORqgqqowTyd8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PKOs+NF+bazF6DK1xWmcI/WWk0dKxlljqRz2abgGJfVI7L1TyFIS74zaYsI3NckEXxzP4YESk68hg8gpYjMgaPp9+ybBd9DC38/jwObOMgIOBftRHqpI2yOlU61O2Vu8iDfEeV6xWa2/qt5xaoysOPgEUKniQexfiXAR2NMBjeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h6R767Ds; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h6R767Ds"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4927fWbo024441;
	Wed, 2 Oct 2024 11:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=NSdU6JRoGr4IhQ
	JWB06dMxM0m81E8wd4hqk7EVqOaBA=; b=h6R767DsJk4P4Fd8BHYOKSrzBBfvR5
	2lOdrxBlFetFSCcbUYxJEg3/Gegpk5+DwzU70zlHXswFwws7jiwj+xyExe7SoB6Y
	HdTlzPqn9CBD4neH4CoKtBsnwWOFxUfJjL0VYpZzdKwBPJP0B5Fx52R0CcfW8JXB
	356zXnvHtb1IHzKP+/Rr6JOId24FG9Pd8Wp67x8wdVVvnbZjaDln1YHFftGL7AwU
	PogUqucqtEX8SQSt6ihbY7cUXsV/f5N6n7I/KD6aZCn0DZRV1leohYLK9a/pu8Af
	bdgYTqjgEwgC1rd4pQGfdKmOs7q29z7enkIVD1WFsR2EWk1YMIZhEIag==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8k38x16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 11:33:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492B10NV028553;
	Wed, 2 Oct 2024 11:33:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x888ykwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 11:33:40 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 492BXeQn004496;
	Wed, 2 Oct 2024 11:33:40 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-184-213.vpn.oracle.com [10.175.184.213])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41x888yksp-1;
	Wed, 02 Oct 2024 11:33:40 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 0/2] tests: reproducible_build/btf_functions fix
Date: Wed,  2 Oct 2024 12:33:24 +0100
Message-ID: <20241002113326.792495-1-alan.maguire@oracle.com>
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
 definitions=2024-10-02_11,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=590 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020085
X-Proofpoint-GUID: VCM22jdBukntrLzM_BFEmuXlAVY-1Eke
X-Proofpoint-ORIG-GUID: VCM22jdBukntrLzM_BFEmuXlAVY-1Eke

Patch 1 fixes specification of vmlinux in the reproducible_build test
to support env var, command line parameter and pahole-based discovery.
Patch 2 reduces verbosity of btf_functions test.

Alan Maguire (2):
  tests/reproducible_build: fix vmlinux finding logic
  tests/btf_functions: reduce verbosity of test

 tests/btf_functions.sh      | 54 ++++++++++++++++++++-----------------
 tests/reproducible_build.sh |  4 +--
 2 files changed, 31 insertions(+), 27 deletions(-)

-- 
2.43.5

