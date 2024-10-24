Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049D41B85DB
	for <dwarves@vger.kernel.org>; Thu, 24 Oct 2024 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729769192; cv=none; b=XzkaKhfooHGQOfMbUW0JTOV6AU+ePjDc7clM+ROC7UCJF9hBCRpYnavtDqIUeXccxGdySa7joQhFfVn/UNE9DXgklKnvM+N+ef0bURwFGr1Otg7Ee4w/1Mrslor1mb9sEnSZkmxE4yRTAyaSky+Ccmc7Ad+ztub4XOnXvFu304g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729769192; c=relaxed/simple;
	bh=C2V3sQdCrYTgLbpCzCE2tHxN9RVfIHBn0nvhf7z3tes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FcpVD2TKk8hfh/NnZvkjZnfwW99drZOk8yqRo1MhlCY7qUESBVXMeYfvHC5FKjn4bDQVPKZl7ZcFC4ShD/FFHunMdK/aT0Hk0QwNdGZ7beMbvSDoc4AZpki2wMStXsHKlD6nj9OuSnPeYvJvM/j/BfVadIKRD9Ur2/3Acut5tr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Leli+4g/; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Leli+4g/"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49O2faBY007215;
	Thu, 24 Oct 2024 11:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=l977/SvJF5DHoyP9lJ2vrULvfbp2q
	F+70kODst+b0f0=; b=Leli+4g/wB/9Sjda09X+9CpwCK4u6e/KHo8bZzm8LAgG4
	G2Gsh2HQkP7v0vugPev0saYwBForsKmuNuUgZdzpTzf0kWaWQZhRaUUTX9TMg0Hv
	mQaI5v43sKt+NvRElWUuUa0JpJVxJILAcT2votDafja3/8XBh47Hv2cL0dl8Qd5U
	AvZY1MQcnme0U81TP4qSZ1rCRTVTcrxgjXTRR8gVzyGyiRV8duYAb7dfhzIgOi5R
	6GF/QCVIFVc6lKDbL5YOiZks7ozieZRv5hXXz82jXDpyeIqwb8XuJqCEjs7VAj/R
	aYP+kvQ2SPo4TcP1PBDB4RmrwagL//B/pD/sbRyjA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qjc77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 11:26:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49OAJt4v039404;
	Thu, 24 Oct 2024 11:26:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhcb9v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 11:26:16 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49OBMi2K005756;
	Thu, 24 Oct 2024 11:26:16 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-188-27.vpn.oracle.com [10.175.188.27])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42emhcb9un-1;
	Thu, 24 Oct 2024 11:26:16 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 0/2] flexible_arrays tests fixes
Date: Thu, 24 Oct 2024 12:26:13 +0100
Message-ID: <20241024112615.750704-1-alan.maguire@oracle.com>
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
 definitions=2024-10-24_11,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=645
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410240093
X-Proofpoint-ORIG-GUID: RECOZaxJ2ZUGbwzaFq8dvUqARaaWRFn8
X-Proofpoint-GUID: RECOZaxJ2ZUGbwzaFq8dvUqARaaWRFn8

Two small fixes for the flex arrays tests; redirect stderr
to avoid seeing warnings during tests (patch 1), and ensure
we are printing flex arrays from the same vmlinux (patch 2).

Alan Maguire (2):
  tests/flexible_arrays: redirect stderr to avoid warnings
  tests/flexible_arrays: print flex array struct from same vmlinux

 tests/flexible_arrays.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.43.5

