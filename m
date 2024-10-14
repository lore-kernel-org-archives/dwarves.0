Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B55515F3EF
	for <dwarves@vger.kernel.org>; Mon, 14 Oct 2024 10:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728901914; cv=none; b=QLYKslTcEQlElPPZeMEMkLyaZxjdHSlzfpEDLRdgyXaM9F+vNL10Tx8z0yHWoqv92HLRS2y4Xz+c0A8dbT85l94UhquCVl9k6W3BdapmPLv9iOLUv1X7t5Xky7mstRC4lzxC7UvVy8evxKmWpJX3BHeMMPYow/JdaodDWoT9mNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728901914; c=relaxed/simple;
	bh=UOVZ1z++5r838nAG+3jMLp60sABLsV2AALLPgTOkkzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HtZsDnG2OVWs7f0qKz4DZaTAO3fpntuZ9YlFgJSWN0EHntZEtzqh4IWwB5QJbrYatbl5AxOapnxCS6jB5tXmpC7iKh+NCqi6LOS0f9OI04sibwJEEp3s1RNdtCATwgwAkfvpbVFitRB6F8lXIhV6B+98ZKoa0AEfwTutlFm0NKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mShim1/c; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mShim1/c"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49E9uLKk015135;
	Mon, 14 Oct 2024 10:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=nfEbeMLbB0qNXXVOKEeZ40PKncwma
	Zqu8vLfZgQ3uZ4=; b=mShim1/cLQowIx4wQXTcXkNY6BwqZIZaSmE3eDOPsqmzh
	p1y5hmFBs3RHjtcPw7jkvJivyy1wyg1GKCQ8HK5LG5jrcq7GSupeGkOPRd2DKgUG
	9uWSzAWgTrJOSLdSDGoMqyFja+5nNf8VoXIgq6/dMvE9KL9gD5Ea9ykaJPYyktNh
	AywcOXeuAkyihwiHeCdZMyPalUQz0LJAK5Mr8R922yesh2Czgcu5ybM4rwD8MQVp
	4KHPM3yahwex6U1zrIG7AKEsP4A+ohqhgMxyD3pdiuN4Gd86/3gSsTb+RX4Wg0bx
	eTWzyX1lcepSCuh7KsSsgb7GdSoBo1JV7ohPVKDWA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hnt64sb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 10:31:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49E900eL036633;
	Mon, 14 Oct 2024 10:31:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjc5sw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 10:31:44 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49EAViCP039588;
	Mon, 14 Oct 2024 10:31:44 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-173-183.vpn.oracle.com [10.175.173.183])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 427fjc5svc-1;
	Mon, 14 Oct 2024 10:31:44 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: ihor.solodrai@pm.me, eddyz87@gmail.com, dwarves@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves] btf_encoder: use ELF_C_READ_MMAP
Date: Mon, 14 Oct 2024 11:31:42 +0100
Message-ID: <20241014103142.2280044-1-alan.maguire@oracle.com>
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
 definitions=2024-10-14_09,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=998 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410140076
X-Proofpoint-ORIG-GUID: QjIDK9jGLypQvGZE6A5EKrJ2N9PP4NBV
X-Proofpoint-GUID: QjIDK9jGLypQvGZE6A5EKrJ2N9PP4NBV

This reduces peak memory utilization during BTF vmlinux encoding,
replacing ELF section-sized malloc()s with mmap()s.

For -j1 peak memory resident set size drops from

        Maximum resident set size (kbytes): 1069220

...to:

        Maximum resident set size (kbytes): 701888

...with this patch.

For -j8, peak memory resident set size drops from

        Maximum resident set size (kbytes): 1121172

...to:

        Maximum resident set size (kbytes): 963516

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 5954238..9599faf 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1879,7 +1879,7 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
 		goto out;
 	}
 
-	elf = elf_begin(fd, ELF_C_READ, NULL);
+	elf = elf_begin(fd, ELF_C_READ_MMAP, NULL);
 	if (elf == NULL) {
 		elf_error("Cannot update ELF file");
 		goto out;
-- 
2.43.5

