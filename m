Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD553074A4
	for <dwarves@vger.kernel.org>; Tue, 24 Jun 2025 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750779673; cv=none; b=O0P7+Gva6UfGhj5GKvQ35tU4EfnaILeIBZch9kpF4LJbHV8YEM+ueNLswAHjvF96Mu4p6TRbrVt6eq0k8zp6CSabSImrYjz/5FeQ6YO2cGu1dno1i5EzQmu5gpIWlbeisniQQQ/JrtxCn3OK9vt/CeF0KuHxv34S1PaDI2PtxYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750779673; c=relaxed/simple;
	bh=dfDueC1JutO7+dkAECl2+TcQ50bpok097okKx2Oe8Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQbC4220s8LaykyJftg/ef4Xbfq8WgwsuPniGxlwH9PkNdWW3PCU0LbkEEx6xc/A6SeWAvO8/xy8T1Ev5YpQ5aupYycICk147SzJKtD0yr/2ARMvRsYCSQ8O77QPzDViR7KwYZ2pss/MrEra489qhM9ziAGece8G1YwDdRBCFbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xu2p9UHa; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xu2p9UHa"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OFMlOm004061
	for <dwarves@vger.kernel.org>; Tue, 24 Jun 2025 15:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=FhJT5
	Dx/9IduVjFiaazJ1k34FO2nJywez5n6/1Jcux4=; b=Xu2p9UHaEIvg1yMpwxbBH
	gt73tDcTTeuPycJTXkunFSwY6Eoy50sBUaVC9xZHQR0nGNAOVd4xDeLydTS4AAS9
	aKVmBSmxsdZ9rEjcVGhzMfpwE821cfGYZCoG8UnQNg3rE9DPumBZad7SX4hYDLCf
	JKjktKau+WHZtTl3g0mQ4Nc5/W2w+NfKLiKtnT9wl8exu7y9OSqNx8QphZooVlH1
	MwACifzkxrjgN6HuVNFtPmyYZYTWjFUoe0L+7TbXbSA6aRe4C4MTMQqAhhmdg5xG
	qrsfa8kaFp3ksqVvrZZXaCAtsxhlWnrphA+6yH9bLjOu4W/gHDOmI8IiIfLdtTu4
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt7caxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Tue, 24 Jun 2025 15:41:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55OF0XsI031313
	for <dwarves@vger.kernel.org>; Tue, 24 Jun 2025 15:41:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehpq9yt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Tue, 24 Jun 2025 15:41:08 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55OFf6Lm029846
	for <dwarves@vger.kernel.org>; Tue, 24 Jun 2025 15:41:07 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-59-22.vpn.oracle.com [10.154.59.22])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47ehpq9yqs-2;
	Tue, 24 Jun 2025 15:41:07 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 1/2] github CI: Build pahole "next" branch as well as latest changes
Date: Tue, 24 Jun 2025 16:41:00 +0100
Message-ID: <20250624154101.163662-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250624154101.163662-1-alan.maguire@oracle.com>
References: <20250624154101.163662-1-alan.maguire@oracle.com>
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
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=895
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506240131
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDEzMiBTYWx0ZWRfX/UB82lOzSoUu 2c48tXbJmZ+JvlSpry9wKitN4/VdUq41BX3ko6CX3ceZcAEcM2rNqYqANamjqW4cHxEQA+kTqUm lcBAubmn3/T/FLHtMZvou2wbXr0Mb4EcltUfrYPWLFUbt3MOP36jaFi6B4tY7xRy4vq8GAj8TBK
 x1l161xSG9HI0aLVJHVDZ+sKc4xtEF4TvYBwWZQJlS6b9mZHp/Y3aCHmnKzWxk8XQdehyWzsae1 mufoqvdRSDJdjeY+zRMIzIbTKsG4ajMCywYgyQU5bRa7u4GLDhwRdxxBnA3E/lvrQnqb845367u M8mKNpHnlGN2j01xVBVcG5IbPEsy+OTUNs4E3DvayYdJAU4gXbhQagxArdpjO00oqjs8881P62k
 7E3DXjq2LgVbz0VQaRd3/MtVMa6oUze87YPk2OfTyOzaaa3dl+9Gy0V1FdGWYT+iSXYu3188
X-Proofpoint-GUID: NksYySHNbS4D4g3b25tE3vSL1CEiF-HK
X-Authority-Analysis: v=2.4 cv=QNpoRhLL c=1 sm=1 tr=0 ts=685ac715 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=nu1Gbx4GvDcpwsD1sbAA:9
X-Proofpoint-ORIG-GUID: NksYySHNbS4D4g3b25tE3vSL1CEiF-HK

In order to support compare/contrast of BTF generation with
changes, build next branch of pahole for comparison purposes.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .github/workflows/test.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/test.yml b/.github/workflows/test.yml
index f11ebfe..99c179a 100644
--- a/.github/workflows/test.yml
+++ b/.github/workflows/test.yml
@@ -20,12 +20,12 @@ jobs:
             runs_on: 'ubuntu-24.04'
             arch: 'x86_64'
             llvm-version: '18'
-            pahole: 'master'
+            pahole: 'next'
           - kernel: 'LATEST'
             runs_on: 'ubuntu-24.04-arm'
             arch: 'aarch64'
             llvm-version: '18'
-            pahole: 'tmp.master'
+            pahole: 'next'
     name: Linux ${{ matrix.kernel }}
     uses: ./.github/workflows/vmtest.yml
     with:
-- 
2.43.5

