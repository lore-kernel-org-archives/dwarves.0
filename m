Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747DB27A131
	for <dwarves@vger.kernel.org>; Thu, 10 Jul 2025 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164207; cv=none; b=BHSGg4mQ4e8c7OVdSlJg2ulSBYi2C31SUb8xHqmhk+o5/RMJDoihnzITsFr7pjLPw2hW1LipM3y4hGU6mmCLa9PjtQH3LZDnw5LWpzAJZcp+p7VXWg3tgqRjUWvT0HvdNCHzlxpuEJxu3ZvzK+IU0/DmfMFQR4qAN/ePsdUv3bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164207; c=relaxed/simple;
	bh=R8CuRMQRnLcJ6vpZaYeIEDNAriDDWrnH944buN8aLvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aY/lAj/0kV0zzm5zHKPQQlt1+S2W19Cdpi4jhm92lKQavbq3odpGsMmIRAv3+KisNADp31aME7pQmAf3vycJVTlwtJf2/UbQ96q7i1aBQ57iYwTkU1t5DlRZlsBjOs3EA9pdCeNX8EjvScv7NRoRMHTf1E85SiFtzRYah8x/wb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lpBPCPoC; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lpBPCPoC"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AFbDuu007191;
	Thu, 10 Jul 2025 16:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=omgWRfwSS5IgQokaTJVGYXFLsIj7C
	QJgIfQfL5NKqEk=; b=lpBPCPoCM8C5dIYLNT4BC2U5DD2/JD89xn1ifdDbbrPq8
	x4ySu/qsfMj9nMmgQFyD1kyS9tGReCScvQdmuv5Rfzr20S21zUGH9wqcNWNNsm77
	i8mqV3rEIq+/jtGD6hE1qyJ5wYduKvUb7C6igUkorwSnow+bW1AmsBm1890YLLn1
	gRaJfxI3fZuh8HbF7OiLpXWk6gdLVx1yOqupv1G0bLjvRfH1MUJKNBjmTHpWpd05
	9uQa+cwEt0FbOoJYXNZNawjYdY76ZhcCilniRNl05cOdhK0PsxOPLcLXOgZWN6gF
	w77EyF5kvuLQHNFff0xsGj7yoA03ZPHG7QTg8VCyw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tgajr385-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:16:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AFjBAV014277;
	Thu, 10 Jul 2025 16:16:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgd90xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:16:34 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56AGGY8a015053;
	Thu, 10 Jul 2025 16:16:34 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-49-129.vpn.oracle.com [10.154.49.129])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ptgd90wr-1;
	Thu, 10 Jul 2025 16:16:33 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: ihor.solodrai@linux.dev, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 0/2] Add function list comparison to github CI
Date: Thu, 10 Jul 2025 17:16:30 +0100
Message-ID: <20250710161632.191304-1-alan.maguire@oracle.com>
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
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100138
X-Proofpoint-GUID: dhRFZ-MapW23wdg1eLE2uVyxf5oH8uE3
X-Proofpoint-ORIG-GUID: dhRFZ-MapW23wdg1eLE2uVyxf5oH8uE3
X-Authority-Analysis: v=2.4 cv=SZT3duRu c=1 sm=1 tr=0 ts=686fe764 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8 a=2vYKqUTlqp3nOZGL6eYA:9 cc=ntf awl=host:13600
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzOSBTYWx0ZWRfXxDM8NDPnqnBO frKy6pw/CYFjMCaAWLN+/CjNQo35VoD898Olfy72U1gvi7Mols+QqzCEB7Bh6GtUtNu9Sqi8x98 25y84oCx9MczUpQcoT8XZyJ0cWJALx3Vkv87ZzYx/OqAmaP1Q2bO9ndMehpmUGvPqeXtEvOGKv4
 JeXecHalhlhDh8QooJaitCx4nwYbjOCDKx+VjUbrzzuG2wibudlExj6kCXHvj7ZFzVWelV6JomN +yT3Mo84YbCuWV7FYi7KbocI/nFh/bDdalqVvktVw9X9jvtnOwaBXLukG8/tVOf9FqyCgb5B4W+ TIcPaNcY+XZzxrYpEn/oZ8itRn4eHzIMXg06oXAg6xGbPfA2cv4WK/UwOFj7dEaC+CaqUqKsINB
 9NvWVyi0ou0dx+2yp/XUCNPWHHdcKPMvWb9uNpUS/PSmIhrqPc01M5FK32YuJ/TxgQFhPncN

As changes to pahole can generate different sets of functions for
vmlinux BTF, automate comparison between next branch and the series
CI is testing.  Build baseline (default 'next' branch) as part of
build-pahole.sh and build kernel with both test and baseline pahole,
using pfunct to generate function lists for comparison.
Example job here [1].

Patch 1 ensures that the baseline pahole is not built as part of
setup; patch 2 adds the baseline build and compare-functions job to
the dwarves-ci pipeline.

Changes since v2:

- altered patch 1 to not build pahole (pahole: 'none') during setup
  (Ihor, patch 1)
- do baseline build when building pahole via script, add compare
  functions to summary (Ihor, patch 2)

Changes since v1:

- fix rebuild to actually rebuild with baseline pahole (patch 2)

[1] https://github.com/alan-maguire/dwarves/actions/runs/16192185959

Alan Maguire (2):
  github CI: Do not build pahole as part of dwarves-ci setup
  github CI: Add comparison of generated BTF functions between baseline,
    change

 .github/scripts/build-pahole.sh      | 23 +++++++++++++++++++++
 .github/scripts/compare-functions.sh | 30 ++++++++++++++++++++++++++++
 .github/workflows/test.yml           |  4 ++--
 .github/workflows/vmtest.yml         |  4 ++++
 4 files changed, 59 insertions(+), 2 deletions(-)
 create mode 100755 .github/scripts/compare-functions.sh

-- 
2.43.5

