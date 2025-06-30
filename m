Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2622451C3
	for <dwarves@vger.kernel.org>; Mon, 30 Jun 2025 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751278543; cv=none; b=f+tCzD2PxbxtGuI2XZpaSAvXDLJ9zusHMXxhbVAk3Y6/6jAthgHaabon/kxl4Qq1xlhHDZraup/C9T+6CfaRg+0v1hwxzuJsMHKLnf47cD1lIpaRkpWpIRyIkhnZFmZkD8FBcleD812PWQ0p+MiWz2fw8LinXbcQ+MNQjI/gcn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751278543; c=relaxed/simple;
	bh=NOjUPPivNu4Ut3Y/KFZGkZ5bYouSgbGI8pq2ucHHXxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RyzTS8quQWh1YHs+INc2rp4Vg+WVoBdaQoWImM2G5gUeExfQ6COK4eGojcggCD0FtVsoeIrv63ayV1xohf4XhVmLoK2FQHpeYRZslMBHwEK/DpXfWAX4f6yPs7dikOtsahftBM/FrmsfSZrptI2eCZAJyH06WRwDDLKmYL0+Xh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TDTvUIUd; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TDTvUIUd"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U84ehn011293
	for <dwarves@vger.kernel.org>; Mon, 30 Jun 2025 10:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=zetGkohC5EUSzVImy9UgOPsw9VP2c
	hC2aNEPhkTfApI=; b=TDTvUIUd5G4C5b0XBSKehs5IAywlHnmlHp0Xk77Q4VDXD
	ymCKPQFVCiFLF8++ESwRN/+RDjmaXd2dW7cSqofJt0AulJuzYPBVBNFw/glYSQUl
	4mbEk77Ap6k8IF2AjMrlG5RcCQ/GNEwmKmGypNsncx18d7LGTePhClaWu+zb1cPP
	6/SO9I16Rpl/S7+g1Ba6n3sgELs6Rrv6tcIMDznpf0dkOW6iGHAbeZegg5BM2MQo
	90mVl3nTXuSvUJYbi2NnvPk5unGxmazw4RVQapcarWabtB1Tmp+W3jWN/X6XPJZk
	60RiO3BRMr7xuKAewNlovO4ADg2P+fqGj8DkmtMGw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j6tfa6rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Mon, 30 Jun 2025 10:15:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55U8HmWm017644
	for <dwarves@vger.kernel.org>; Mon, 30 Jun 2025 10:15:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u7wb5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Mon, 30 Jun 2025 10:15:39 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55UAFdgZ009159
	for <dwarves@vger.kernel.org>; Mon, 30 Jun 2025 10:15:39 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-61-18.vpn.oracle.com [10.154.61.18])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47j6u7wb4w-1;
	Mon, 30 Jun 2025 10:15:38 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 0/2] Add function list comparison to github CI
Date: Mon, 30 Jun 2025 11:15:35 +0100
Message-ID: <20250630101537.2680289-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506300085
X-Authority-Analysis: v=2.4 cv=CMMqXQrD c=1 sm=1 tr=0 ts=686263cc b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6IFa9wvqVegA:10 a=NEAV23lmAAAA:8 a=A9cyK_2uO2p4UPJg3ZIA:9
X-Proofpoint-GUID: ddphzkuOxLI2CKT89fAeSezeKgC0w0_V
X-Proofpoint-ORIG-GUID: ddphzkuOxLI2CKT89fAeSezeKgC0w0_V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA4NCBTYWx0ZWRfXwZwk/A2wL4QY J73xiTfLzLasBBE87Z/m0LoMB2JeCgN7hh/8iXAaRSeQ2kfBc/2eXl5IqYQ5DyIVuWJp0t7Qmrz pom+S3/MfyugFiqvVqFUxMBHjBZWFl+hAwBDYREu04l2aQxXyFdHmnYlyxRgnUcNanTDSigPKXo
 kzSvOdR2KxxQNICISgwhbv6hazqPbZOEnUrOofcBDDjI3O02kJWH/85EIqzqzmXtmgmHpyOpLRF Qu2M6u7IZGscql8dwYvYaQ2mY3gfYQMw+yrre7nLioTwAN6lLGyZHbbYZh064MN1gWr8RN/I1wV QcNMf3cXAHoijHGM9fOCa+gXTH6mANgmQbJLcsLDkhUS4VlBqfEV18kQqaQQOpsb+ub+qFse8J7
 DSjwz1jAihs3pRJ32jJxCZ7EJVz6xrwHfSG5o1vjlDip6IAhaj7T3Cjsylm6p9xqFCizeJcx

As changes to pahole can generate different sets of functions for
vmlinux BTF, automate comparison between next branch and the series
CI is testing.  We already build default pahole so use it to baseline
function generation in BTF and use pfunct to generate function lists.
Example job here [1].

Patch 1 ensures that the baseline pahole builds the "next" branch
version; patch 2 adds the compare-functions.sh job to the dwarves-ci
pipeline.

Changes since v1:

- fix rebuild to actually rebuild with baseline pahole (patch 2)

[1] https://github.com/alan-maguire/dwarves/actions/runs/15872520906

Alan Maguire (2):
  github CI: Build pahole "next" branch as well as latest changes
  github CI: Add comparison of generated BTF functions between baseline,
    change

 .github/scripts/compare-functions.sh | 30 ++++++++++++++++++++++++++++
 .github/workflows/test.yml           |  4 ++--
 .github/workflows/vmtest.yml         |  4 ++++
 3 files changed, 36 insertions(+), 2 deletions(-)
 create mode 100755 .github/scripts/compare-functions.sh

-- 
2.43.5

