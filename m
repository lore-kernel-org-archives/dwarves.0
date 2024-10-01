Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EE51BFE0B
	for <dwarves@vger.kernel.org>; Tue,  1 Oct 2024 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727783198; cv=none; b=oTaeHpNJFQu5FC3q8l9hkt5yagSfsy/DAzKBGaTQTcH67Y7d5H/wSnLCEJIJRPm2Au+e7FUM9hjX8/KRjsa20iSPy6Myr2DbeOU8/zkY1uDrRjPJ8C6chF87SLaJZHpZ8FpybIg13lRMv6bs0cAcaGD8lWBl+O0wpyoL6d7BDDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727783198; c=relaxed/simple;
	bh=xGkyWhoMimNpogr4Lx5cosH8pUa9lBtMLRS4ULgll2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nlp6hxwors9Vip13vggSGrWQyB4It2QVyv/r+NjS429s4ClfMJS3DFusBdrI9hAh3pPWbfEzMeojd71U6kzbovkdk/VfP1486Rd4612STRWf3Mw1tCL/s7JyFFet6ClbYol/lgQmKgAaCeXPKnViMPrD6WskWzLWMSjk35qIal4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=osTYIcKr; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="osTYIcKr"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4911tbL5027878;
	Tue, 1 Oct 2024 11:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=2
	ncl6+lErGmXGZ+j8DB0x6dAh9VWLT+//ZPkjXGc4JY=; b=osTYIcKrznKqMuf27
	DODRlzBnzCaEpdZG4/7EtN9MrrdLXX618tTY+qJSgSjiV/IYX0cABtRqGAglVsUQ
	96Q+zg30puaHZw8VqrIh4fNr2CcuUczK9bbfnCcDMeoSQuHWn7ATLNT13vxc3GUP
	Wb/PrcqdhPqYLqqCgnM38uYirlqoG9NwxANp2BE7PIrGLxuxFb0ELeB6uiHTHGqO
	qsBbKEmxBiEvXstS6oGuaNZ7e8TMDaiBBvogYrJD1flUpnkXUqBa2ffrsaP+R70u
	YFEnQK/3O/zGJNk0Jj49MNrrGDaLnvR0IqzRadePovJMltDMOylbsI5p4zsCXe0u
	N8B7Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9dsx1cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 11:46:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 491B2hda026229;
	Tue, 1 Oct 2024 11:46:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x887ee0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 11:46:33 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 491BkUS1024830;
	Tue, 1 Oct 2024 11:46:32 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-217-229.vpn.oracle.com [10.175.217.229])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41x887edyu-3;
	Tue, 01 Oct 2024 11:46:32 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 2/4] tests/btf_functions: return 2 to indicate test had to be skipped
Date: Tue,  1 Oct 2024 12:46:27 +0100
Message-ID: <20241001114629.3947401-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241001114629.3947401-1-alan.maguire@oracle.com>
References: <20241001114629.3947401-1-alan.maguire@oracle.com>
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
 malwarescore=0 mlxlogscore=934 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410010076
X-Proofpoint-GUID: CCW3WcfXYxUS54gtMcN1IxMUIYd2f338
X-Proofpoint-ORIG-GUID: CCW3WcfXYxUS54gtMcN1IxMUIYd2f338

When vmlinux is not available, return 2 to indicate test is skipped.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tests/btf_functions.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
index b8645cc..fbe68f9 100755
--- a/tests/btf_functions.sh
+++ b/tests/btf_functions.sh
@@ -32,13 +32,13 @@ if [ -z "$vmlinux" ] ; then
 	vmlinux=$(pahole --running_kernel_vmlinux)
 	if [ -z "$vmlinux" ] ; then
 		echo "Please specify a vmlinux file to operate on"
-		exit 1
+		exit 2
 	fi
 fi
 
 if [ ! -f "$vmlinux" ] ; then
 	echo "$vmlinux file not available, please specify another"
-	exit 1
+	exit 2
 fi
 
 outdir=$(mktemp -d /tmp/btf_functions.sh.XXXXXX)
-- 
2.43.5

