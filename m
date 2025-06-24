Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AE3307480
	for <dwarves@vger.kernel.org>; Tue, 24 Jun 2025 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750779672; cv=none; b=n8CfJiDm/elLUVcaj/QuB3cXehszEDuYFbDAlFLwhcceGbJkPOGbW51kfbqmXRnVlFv1bB4hyq15gmlS/piqqkGW4zhU+YM3rFPC2Y5j0ouT4w77itmfqi5wbbx8G9so/dRlLGc1+pl7wM1KLRgxewM2qqAl0BZ390dJ6h/AcIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750779672; c=relaxed/simple;
	bh=4uwZOiZdLz03kJloHVbUgF456YAkV8pa8xGedvAD/jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NBm6Lj0oeIjw8iBJkVyjqQtc0KYa221JqwJT2dw3yrqqDYl1jhmRTqOetbcpw+0j2FBxj+8aH4Rzn9vY1B4HkNfTRkDeUR4g3/ChVCLm0X061whoLyOnmZ2j2glN7P4MHwNP2YmzwlO16v3v+aQgPuuK5S6ZzCj7zTCTXaxXjHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EkGPMSbi; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EkGPMSbi"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OFMlI0002102
	for <dwarves@vger.kernel.org>; Tue, 24 Jun 2025 15:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=xmfinB5A7DuMf9EOjnnVKHo5ETtyN
	XJQplGS/73xamo=; b=EkGPMSbiWXkFX/9KJcSZLPK0aK6b/YirSB6gR2GESH+xR
	rR5ErGao3WlTGh+FP+EXxiPgmwihuSEt/rsVPqsb2VV6IDvrQCxQoFTuzjNo1FVk
	THqtd5hcHaj8nC2LXdfixtSUV+ihVuKiQ0PmeYBknqaWN9LKcYuOS+CGxO+xdomc
	3Dv6RHrIszTDOUWsBZPifNq+Epj39FTlzRGt5kWCEgeqCr5I9nSfyzF68XoTeoym
	+LxFp890pg2WxUqtWiWS76f2riIXUNpefu+SIPI5WiPzV1vHD1Yxgyj2qaZrSt/I
	W73VGUKNICU05kEJOcpZNEo4/PhzzEI+hNKtGeLTg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt5mbyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Tue, 24 Jun 2025 15:41:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55OEIbYU028818
	for <dwarves@vger.kernel.org>; Tue, 24 Jun 2025 15:41:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehpq9ys6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Tue, 24 Jun 2025 15:41:07 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55OFf6Lk029846
	for <dwarves@vger.kernel.org>; Tue, 24 Jun 2025 15:41:06 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-59-22.vpn.oracle.com [10.154.59.22])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47ehpq9yqs-1;
	Tue, 24 Jun 2025 15:41:06 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 0/2] Add function list comparison to github CI
Date: Tue, 24 Jun 2025 16:40:59 +0100
Message-ID: <20250624154101.163662-1-alan.maguire@oracle.com>
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
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506240131
X-Proofpoint-GUID: Ykx-AGmXrtGDKN2jCZAWyxNvht2P733K
X-Authority-Analysis: v=2.4 cv=PMYP+eqC c=1 sm=1 tr=0 ts=685ac715 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6IFa9wvqVegA:10 a=NEAV23lmAAAA:8 a=ZE2qRX5QTIPR1dZO59QA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDEzMiBTYWx0ZWRfX4BYqw4Hkz0Gy JZVKUXbcU/3ta7mIVoYdfRR5MfK1dOs0lMybz0Ns0Xi0o77MqgToQwD0EFTIA7Hgxn+ezyO08sd SB2TeZ6pELml4tBDZneEoezO7Q+ChBbx603CBbOPPpBrFYbI007JGOOEXB6qw5hNNQTBhY8Jqyx
 vJ6FyQEDuLfxTUH6MWmP4IwOTgkeQvoGuJjYRvwN4hJkuXGJAUrA8IJeDCfsUlCGiyySYQwdcl2 g6SYiac01vCvLvepERsfYYqgn1zFXA57/Vi7RtHbukfmDqLumjK3ciiP4mtbssRfoeY7GKE3RY2 kzxiUxNe1k25Yxa3t6OaPzNoFsnPaGcxu6r00HoLERtCNRS8H2bhcpBBw8OtZR1a03E0zmHxCvW
 uJnLvWNj5k/Cw/rLxg9B3lHEEBCQ35oRnr1d7PqCpEu73sEL7uTvbXoCScIEjV9wiUMC4IBs
X-Proofpoint-ORIG-GUID: Ykx-AGmXrtGDKN2jCZAWyxNvht2P733K

As changes to pahole can generate different sets of functions for
vmlinux BTF, automate comparison between next branch and the series
CI is testing.  We already build default pahole so use it to baseline
function generation in BTF and use pfunct to generate function lists.
Example job here [1].

Patch 1 ensures that the baseline pahole builds the "next" branch
version; patch 2 adds the compare-functions.sh job to the dwarves-ci
pipeline.

[1] https://github.com/alan-maguire/dwarves/actions/runs/15854137212

Alan Maguire (2):
  github CI: Build pahole "next" branch as well as latest changes
  github CI: Add comparison of generated BTF functions between baseline,
    change

 .github/scripts/compare-functions.sh | 29 ++++++++++++++++++++++++++++
 .github/workflows/test.yml           |  4 ++--
 .github/workflows/vmtest.yml         |  4 ++++
 3 files changed, 35 insertions(+), 2 deletions(-)
 create mode 100755 .github/scripts/compare-functions.sh

-- 
2.43.5

