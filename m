Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE7E30C34E;
	Fri, 23 Jan 2026 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769189288; cv=none; b=bUgMGBlRibeKwZW6HoYIhGpP2Hy7tdEQ2ZKz7cdtluTMbWvRYle60YlmKvyjcAXZZuqJWCHv0HG1pA8A/KwJQ+lYEntMAtzhHDY3uEqQhwqtc+qHwdpv2opRrQPpOm7fPuvJdERKb7y/Qqojt46zU/JNN3vZNXCB7msjUIeym3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769189288; c=relaxed/simple;
	bh=TU6sRYPoHgGjzrqzbRKQIrwuG7urqwqEIwFJjt9zR2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNyoUqm3DkPDB7nkVWQAeGb6q3NErJUt2o/gH0sP+qn257Myagrk43WLy9628pSJXPEw+GgIdTaFzLqHi5HNusNc7ZxCWGrdzJYlLAfXSdWmVesfStmVa0KnrhhfEwZvST9aXKIOnp/0NYatQneFX2OiwYo4prNy7PhLJmTpOW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R5/abQlv; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R5/abQlv"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N6wPlq1884207;
	Fri, 23 Jan 2026 17:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=rDhEx
	zGshBw2ngru0pw01pE3DBAFaeTgAThX+npZqxw=; b=R5/abQlvxr6oVwzanqNyo
	hnNzhZ2Ys7ZzlsOh7FgRcBRm2zu/6pwatVV5EdunG2wQCG682AzdakLEEkYmxGBB
	AzmI7kvwZ+tpgcabkwiPSyOfXNxEV49kAvU8eJT6Cn7cNxwk4jPppmorpIP7gS68
	vuSvksLLerr6lgfsW6vMNX5Gti4qOMrVAuSpio4WFR6Z2vBa0B4YbOh5I7adLUui
	30NwbhNHpdmtUf/FQGj5bjGKTgp+6BWIMX8252yBSSZu3YIaRQt/LUY7lncAqh7P
	68eqici3ozeqnYO0sHfZe5KLluJM7SdJvwK1F0HxZ3YVw/LFoAOHSWmikXGiFtDs
	A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br1b8jt1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 17:27:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60NG4PEb024911;
	Fri, 23 Jan 2026 17:27:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bujd1q8tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 17:27:00 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60NHH3mT020337;
	Fri, 23 Jan 2026 17:26:59 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-82.vpn.oracle.com [10.154.50.82])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4bujd1q8n1-5;
	Fri, 23 Jan 2026 17:26:59 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: yonghong.song@linux.dev, mattbobrowski@google.com
Cc: ihor.solodrai@linux.dev, eddyz87@gmail.com, jolsa@kernel.org,
        andrii@kernel.org, ast@kernel.org, david.faust@oracle.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 4/5] man-pages: document true_signature btf_feature
Date: Fri, 23 Jan 2026 17:26:49 +0000
Message-ID: <20260123172650.4062362-5-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260123172650.4062362-1-alan.maguire@oracle.com>
References: <20260123172650.4062362-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601230131
X-Authority-Analysis: v=2.4 cv=WbcBqkhX c=1 sm=1 tr=0 ts=6973af65 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=Fhdyw7i6NZ3cPtxtyjAA:9 cc=ntf awl=host:12104
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDEzMSBTYWx0ZWRfX65y+whcn3Vg1
 DNN0hAP4Eeewgml2QNvj6N1Imfbzo3wqvgtJyVHiQV2txKp4z5xAP1+fnXodgIobkRc09zwlq91
 v9NbD4OeiWQP6YHh56VmGlyL9+q7eXaLQx9itUjp/rbqT2c8JcqtUfW81wCLSGV0O3DR0dRy2M2
 11IXnOx9N6w16VUBooz4Tg/rUJKTrFuu1q9u4r7Q/SZOGq3BqeRqa3YUdZxZNvFHgGWo/ANI4P+
 +YqjbS0KhC6OUNvaXJDmG/csBvuH983te9kEwUxhhw8C4PyhgAHoSwz4N+isvZELG91MjrttpA9
 6GcrQu/8aQvUTB0CE4iGzAPx7X0VSmrlF7BYL9R9c3VUmmbA0mKrNZXbaArk2S02DeTPZncAU8F
 vrpAB+flY1061Pyzl/so7KaQW27sTWGlRkfnvu3YzA8x1yw9RmsPQx67IrUo95EkjzIESi9ivef
 0q5lyXfJur92q2iiA59NOj2RBS0RkE4lomXFFnYo=
X-Proofpoint-ORIG-GUID: UDMTIBWVOkUAL6dklxqwQOE-cqOICkEq
X-Proofpoint-GUID: UDMTIBWVOkUAL6dklxqwQOE-cqOICkEq

Ensure non-default "true_signature" feature is documented in
the manual page.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 man-pages/pahole.1 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 3125de3..90a8f45 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -337,6 +337,11 @@ Supported non-standard features (not enabled for 'default')
 	                   of split BTF with a possibly changed base, storing
 	                   it in a .BTF.base ELF section.
 	global_var         Encode all global variables using BTF_KIND_VAR in BTF.
+	true_signature     Encode functions ensuring that binary-level
+	                   (rather than source-level) signatures are used;
+                           for gcc these are ".isra.0" and ".costprop.0"
+                           optimized functions
+
 .fi
 
 So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF encoding that (as well as encoding basic BTF information) will contain variables and enum64 values.
-- 
2.43.5

