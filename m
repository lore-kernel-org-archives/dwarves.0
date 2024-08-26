Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017391514F6
	for <dwarves@vger.kernel.org>; Mon, 26 Aug 2024 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724670115; cv=none; b=p9eHAdItbojVGOXl6azAnbecqnZvhV4iR8XWDpp9pb4Lde5bRn69DhQlnVqJRaSPO1ou2ZfMzXpv1xWXrNS32kXDR2w7+CNxhkQiRfz85td67H5g2xbAiUAkNr3o/25ZvQJ6awk18n5uSqw0XxMqgCtc+7TuWAP3Fud3RGP5rY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724670115; c=relaxed/simple;
	bh=qLi18YbVRWXoVMEP5UU19DsD91fltykA8Ed8oetIeFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OMH2J33F9UzELRKRO1K3KqGyZuLLtbJ8AH2YjqIk3radNAdFCBuD39GHxQO9Wq1bcJtRJPgGPPTE+3AHp5T7uV6X0GV0+QELijtb/CsbrJvAT38tBrSvlYJz3xd0rHFr/KqsdaJLLsIcdxa2Qa752ufSFn+ZgvhB3MrlPrzUYFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Nxjr1VAL; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nxjr1VAL"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47Q7fTIh001761
	for <dwarves@vger.kernel.org>; Mon, 26 Aug 2024 11:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=5VqoAQ2aSW5SIA
	OXA6piIPMd9HA738/ciFNz+33w7Rg=; b=Nxjr1VALxWAEaPWi6AEh6xe1op3NG0
	t51psFOTzK9QWIiIGkXg+h7cM4Pt0OwdB3nIXJDoNWSO373SNqeH3Vzwd3KH15Nc
	UTC1SH6I8Wa9C77poFq34ArgvyBx/Gs2JhV3pD0EoVlbCOtv8olSlX946m2VnxXU
	mrf4pk6nBTC7F/+vGZzmQLFCUAJeNVt/3fV3h1kzzOjNp62/6X+iD29jStiUCeXj
	U6H0ew9ZuJQQcjif7HQCyOZIpDcQl5ApUO3D+d+nI1mCe60d4hZ+NDubNxvKaQZ5
	Yo3fu5KeQq+DUSvXWW2vL99ZJEaFs8H/PY63zhgmXmuoclyEKAYn4KMg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177hwjtyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Mon, 26 Aug 2024 11:01:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47Q98xxG031739
	for <dwarves@vger.kernel.org>; Mon, 26 Aug 2024 11:01:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0sbewe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Mon, 26 Aug 2024 11:01:50 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47QB1opO031196
	for <dwarves@vger.kernel.org>; Mon, 26 Aug 2024 11:01:50 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-184-128.vpn.oracle.com [10.175.184.128])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 418a0sbevp-1;
	Mon, 26 Aug 2024 11:01:49 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves] pahole: reduce memory usage by smarter deleting of CUs
Date: Mon, 26 Aug 2024 12:01:48 +0100
Message-ID: <20240826110148.790124-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_08,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408260086
X-Proofpoint-GUID: VYbHVzWVHA-065QKnLrwTMGskwRlt9dR
X-Proofpoint-ORIG-GUID: VYbHVzWVHA-065QKnLrwTMGskwRlt9dR

pahole uses a lot of memory when doing DWARF->BTF encoding.
While some of this is inevitable there are some cases where
we can improve things.

When doing BTF encoding, we sometimes need to keep CUs around
to compare functions to spot optimized/inconsistent functions.
Currently we decide this on a per-encoder basis (saved_func_cnt)
where we count how many times we save a function, and if any
functions are saved for the _encoder_, we keep all CUs.

Instead we can have a per-CU count of saved functions, and if
none are saved for the _CU_ it is safe to delete it.

This leads to deleting ~90 CUs during parallel vmlinux BTF generation
versus deleting just 1 prior to this change.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 5 ++---
 dwarves.h     | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index adc38c3..dfaab70 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -83,7 +83,6 @@ struct btf_encoder {
 	const char	  *filename;
 	struct elf_symtab *symtab;
 	uint32_t	  type_id_off;
-	int		  saved_func_cnt;
 	bool		  has_index_type,
 			  need_index_type,
 			  skip_encoding_vars,
@@ -907,7 +906,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 	} else {
 		func->state.type_id_off = encoder->type_id_off;
 		func->function = fn;
-		encoder->saved_func_cnt++;
+		encoder->cu->functions_saved++;
 	}
 	return 0;
 }
@@ -2283,7 +2282,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 	 * functions for later addition.
 	 */
 	if (!err)
-		err = encoder->saved_func_cnt > 0 ? LSK__KEEPIT : LSK__DELETE;
+		err = encoder->cu->functions_saved > 0 ? LSK__KEEPIT : LSK__DELETE;
 out:
 	encoder->cu = NULL;
 	return err;
diff --git a/dwarves.h b/dwarves.h
index d562e42..060e6a8 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -303,6 +303,7 @@ struct cu {
 	uint8_t		 little_endian:1;
 	uint8_t		 nr_register_params;
 	int		 register_params[ARCH_MAX_REGISTER_PARAMS];
+	int		 functions_saved;
 	enum cu_state	 state;
 	uint16_t	 language;
 	unsigned long	 nr_inline_expansions;
-- 
2.43.5

