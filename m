Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392481F8EEF
	for <dwarves@vger.kernel.org>; Thu,  1 May 2025 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746111410; cv=none; b=dzAwzgvDA3oKN4H70dufH/cU01wAWnlr86p9By/KW6GcISLfK4Smflms3EHUc3ai3i7oLBNu9JI0udzmIt0xSfUcRE1UDjva3mOSHD3HrhBZnal/dV7qcFoabZG1SAsUqYDAv+3PtS5nERX8soLbv214TluO/WgDOZHfO4F+yBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746111410; c=relaxed/simple;
	bh=xsmnGtpN4MWR8gGsy9FaQqx9YQa8n7dUz3n6CvvHl/E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqvFBhstjpM11/s3xUtGjaVM6085hZRYDiJ55a2D2ynumUOEZjGo2MOPs3PPUKf2b3dqqLeffUjw+3viQDygMu3Zj3CmpFy++8Ro1NWZZduP083Vp8eH0s5HD5x3sGeunuQB8ttKJdy7se2ddmdfJhM7g6vGec03ithvITHwRF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XsA4Dr5v; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XsA4Dr5v"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541EtrQY027596
	for <dwarves@vger.kernel.org>; Thu, 1 May 2025 14:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=ZiKfU
	mHNHnKhLFYv0zQDAnEPiZXcdwYNuJ6phydr4l4=; b=XsA4Dr5vusy9tCugE9aGl
	q6Iolx+BvAy6qYWvXF2cV4QB0DrEA2IfscV10kwcALg06eQSlKzz7CJDWD0tfEe9
	6/lTDL283FsldkBKmhd1qaY4TK5O8CfTcxXbp/iHZ9acoK1xBGhMBaKEsYpy8MrI
	Xxmf7+prTZ6UMaxdKtESEx2L+H7C8tR1S6NtpMro1Uqv9LBdR9yOcXgHW2AnBUDw
	wLH1dnKQrnlKrEKIMPeddqzngNxQ+nSc8zYihLJzCsKLxCobwqoLR30s5V5/9PSS
	yWzsDEDHGgkV3/BZEpwJQKDG4hMqZBC7xmNpgceZDeMJPmFTidrXFX3oxCas/cUK
	A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uku73t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Thu, 01 May 2025 14:56:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541E1Dph023886
	for <dwarves@vger.kernel.org>; Thu, 1 May 2025 14:56:47 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-61-155.vpn.oracle.com [10.154.61.155])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 468nxjv48n-2
	for <dwarves@vger.kernel.org>; Thu, 01 May 2025 14:56:47 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Subject: [RFC dwarves 1/3] btf_encoder: collect ELF function addresses
Date: Thu,  1 May 2025 15:56:43 +0100
Message-ID: <20250501145645.3317264-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250501145645.3317264-1-alan.maguire@oracle.com>
References: <20250501145645.3317264-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=970 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010112
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDExMyBTYWx0ZWRfX3e5blWRfm7Cp JWrfHeRF0D9V8NPOymQjUcG5T+084u4YoayY5cdvbsS+FYm62r9EhWkLkzsB1vRkilDjWZQ/wyV wHOE750SuvWN4KPo8iN5kSKB6XtiVIbzVeW+0BtDUQJot12jjcPrePyseYtCMpR+hcX/5OAFeKW
 s07AlQzkyyf41ma+NzkHxUyygm3L4rhpqTQfjXqQTxdys8rOERU4nqoKM+/QYwOgZ4gTyJ4vSbP ONRe0zZHNWWCjocYeU00lTEIrTQ2FMDVoZQ+VCsJU9o0KWRSMAkvYEkdAy3nnxy4/BaxmEx7DND hOLY2p8tUDTqlcHZ8KADzqWcEy9CciFFl/OrEwzRWx7RoFA6HQDiPU0QkUG9ULg/HAZ76y4DRtK
 zgje06vVWLvE4kmZkluQDk23+39sE2pSC6XsSvsmMqEszpWJV0wOhEV6fb6Gm4O8yEcOOeMs
X-Proofpoint-GUID: IeXv_QfkK4Zx9dDr9zam-_EXiw-3glS1
X-Authority-Analysis: v=2.4 cv=A5VsP7WG c=1 sm=1 tr=0 ts=68138baf b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=o5u7cY3h-2El4r25gkgA:9 cc=ntf awl=host:13130
X-Proofpoint-ORIG-GUID: IeXv_QfkK4Zx9dDr9zam-_EXiw-3glS1

When collecting immutable ELF function info, store addresses
of functions as these will be used for better DWARF/ELF correspondence
matching.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index 0bc2334..b1e64d1 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -98,6 +98,7 @@ struct elf_function {
 	size_t		prefixlen;
 	bool		kfunc;
 	uint32_t	kfunc_flags;
+	uint64_t	addr;
 };
 
 struct elf_secinfo {
@@ -1461,6 +1462,7 @@ static void elf_functions__collect_function(struct elf_functions *functions, GEl
 
 	func = &functions->entries[functions->cnt];
 	func->name = name;
+	func->addr = elf_sym__value(sym);
 	if (strchr(name, '.')) {
 		const char *suffix = strchr(name, '.');
 
-- 
2.39.3

