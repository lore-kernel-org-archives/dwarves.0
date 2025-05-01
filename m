Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD49F1F9F7A
	for <dwarves@vger.kernel.org>; Thu,  1 May 2025 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746111410; cv=none; b=jfKkMC0/MTgbmHoyoHiD3xSzmPGQUbzZRutd1Z3r5VPOGMVNWE5pjxGYUkItz9hEPvveWeXKat1esrx8fTIsyIJbQZMV0n951ixMAy/fl5h3do7j5+634NLLS+3RtqdcOm5XVQ0l8hI/5tBsQ5NOm/vdyln4R2i7UCcxPdfYcGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746111410; c=relaxed/simple;
	bh=VV8L2UT+TaGHHVMa/FQlCmJnGH4vPJcDlRq/CRTWuVY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hH2FDjCFvF3vztVekBKZX07Q0MrpD7df2EB33toYfxvqF04zbtk6oy9qqs78F6cQD8Ip4v4be0Ua5ftJg443BE/RgRCFncfCwC3ehq4I2X31eyXxFD02ShjIi4jcxUxBHBfoQXJ5aRxLr+PdCP1g29cW9s1EkfXp7/1Gc2Y0/HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aYfi7qu6; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aYfi7qu6"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541Etwo8007120
	for <dwarves@vger.kernel.org>; Thu, 1 May 2025 14:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=VkdwYZWOXS9qwWDVWFNSQxbsYalrg
	x692SQFQSr2Q1Q=; b=aYfi7qu6oAL5X19NCJjdu8j299bCMQ3zrYvz4c7Fcy24i
	4gukxboW6sQ0caAxnh1zE5+7EqWSlFGfWjWfRKMK67ULwsHcmOrl87zvU9btSUuR
	4iLP3PI1R5XW9wCjk+Pdvj170jvkrQMCzeJlTrlgk9yhoQK/MyPTdC/7LRqQdL8e
	1dRumNjRlRjdc8tbDJ3rG1nd8NESNXc5hMscPBHrMbeFAV3IZJPTgpdUIkUxmfli
	dE71gWAwVt36xQJ1IG/mvmc2nVbRBzsz1puXvT+9z8Gf7wxHW7x5zHePH6MhHg0j
	iWuuOk5MIXQUjy7qJHzCXgYuAAs9psbolegqWptAw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uck5ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Thu, 01 May 2025 14:56:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541E1Dpg023886
	for <dwarves@vger.kernel.org>; Thu, 1 May 2025 14:56:46 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-61-155.vpn.oracle.com [10.154.61.155])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 468nxjv48n-1
	for <dwarves@vger.kernel.org>; Thu, 01 May 2025 14:56:46 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Subject: [RFC dwarves 0/3] Explore using address-based DWARF->ELF
Date: Thu,  1 May 2025 15:56:42 +0100
Message-ID: <20250501145645.3317264-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=726 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010112
X-Authority-Analysis: v=2.4 cv=ZsHtK87G c=1 sm=1 tr=0 ts=68138baf b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=dt9VzEwgFbYA:10 a=BM02i9vloc0mCPFLoRoA:9 cc=ntf awl=host:13130
X-Proofpoint-ORIG-GUID: eEAvtL2h1T6mTIApdpDBlCY8JQQl1YwO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDExMyBTYWx0ZWRfX1TyONkwDKCfK vMtjSGv5sj57Q+9FsUu8MTmPOGQC1RweNUhg6Bc1JdI/8u1nf8oztkNrKAWQi6jSSSeB3ZI0+vj /S4WBETomKlvm7ysz9dcnZ8oi05p1etQ+WxM1jX82M+hPHF33mWVIW1RI3oAmJrnIT7g25CWE51
 UxqPGZ7vvcLBmkJ8HujZ4Sm32w6R20t17/PJjDzk+eA/4qz8wGdx5hkmNLW3LepTkfNouN8Loxz TI2JaCvNaegKWT8ulJJtuVdf+AKo9JY2PrBYMBsIRoAMqnxetEth5/8PRlN9tq29rJOsqAz0ebr Zy346XKNcDZgHdPaw11HOcr2beXkufMRFNrwuJZonLf+WvQuaSFqUbsUvlsioxoTfiNPJjsoNRa
 yo91uZnaXniE92z3fx2u8FVgFV809PqGG+Kyn8NwauTedUzNRMy9DouiaH7kjgKRBl2zqExM
X-Proofpoint-GUID: eEAvtL2h1T6mTIApdpDBlCY8JQQl1YwO

This work-in-progress series is an initial exploration of using
function addresses to match between DWARF and ELF to improve matching
accuracy, and as a prelude to potentially representing address info
in BTF itself.

It is missing ~1000 functions in the resultant generated vmlinux BTF
where we currently cannot find an associated address in the DWARF;
there may be further enhancements needed in our DWARF function address
association, or we may ultimately need to use a hybrid address/name
scheme, falling back to names where DWARF addresses are not present.

When we come to encode addresses in BTF, they will be likely 32-bit
section relative.  This will allow for kernels that randomize the kernel
base address.  But that is not tackled yet; these initial changes are
focused on improving the BTF generated using address-based matching,
but not augmenting BTF with addresses yet.

Would be great if folks could see if there are any potential
improvements to make the matching process more complete, or just want
to try out the series and compare before/after BTF encoding to see what
is missing. Thanks!

Alan Maguire (3):
  btf_encoder: collect ELF function addresses
  dwarf_loader: make more effort to retrieve a function address
  btf_encoder: use function address to match ELF -> DWARF

 btf_encoder.c  | 78 ++++++++++++++++++++++++++------------------------
 dwarf_loader.c | 29 ++++++++++++++++---
 dwarves.h      |  3 +-
 3 files changed, 68 insertions(+), 42 deletions(-)

-- 
2.39.3

