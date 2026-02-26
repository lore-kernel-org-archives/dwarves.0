Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F373311955;
	Thu, 26 Feb 2026 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772096032; cv=none; b=N11gSBU/vODA+bMrt//dNY9euoub04AKQ+Cydb0MMNwb1dY2ow4c+VKpi+LbYxIYzwUmBbN28nX+6iJDMPxDFKqmhiw0vJtVwRsduHp9ottysy9pEXvooG4gHferoe7Tdwry1BkGpsJWS+/COZozWPTmOBqCxWYh7PIsKgNSRKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772096032; c=relaxed/simple;
	bh=lq3551MYiBt0dP1HHA1MjfawJ7ztyO4KFVz5An/doK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQQiuFED92PpcoCXjK5TsvwEKJBWZmZXO9QdhJP3j8aIdjlmdOJWGmkqsKOFK1pVDVFbX8NG/NQR2lDcwM0FDCdBhSr+xnR0StZf3+DfRklnDDlLU/RcBAHdBNdVEfJu0QFDYIeXZUf9WSJop3Z5ib0UYxlDIZgmoaaCnMcQPQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T1Np5syX; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T1Np5syX"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PNvamS3277590;
	Thu, 26 Feb 2026 08:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=3XNcL
	yIPO0u71+aRZ5CQE9hxaxQPkBrfvayWjkt6lbQ=; b=T1Np5syXWtIYMJIuO14Hh
	Ir84BH66I2UFlfRBJKNtQ902yatPLEr/Yuz3aL7ridzJIPxhT0ly36VZyIcVdd7X
	u7+IZ4NBI2IdmQ3kSH9pGmnAt8oSQFYmyv99YFTV4JNHSRm8eafC6S88L5MTKP0M
	377KH8eebKuRO+Zqu9IzpYCRAB1AFoh/gCmkJ/7u/95bXlpvz2OhNM7wXlHqbI9x
	xM0gk+nGfxq3SVVUE3Ubfc5ZYQAP0V3CZyg3Go8pDKAYSpcQVp3bBBjIEx31kDvj
	1pR2KpPcq3uQ3cnuRiLZY/x6fwo1Eaus7LJC7+gv1UQr1aGHm410gXgniU1F00xG
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4k5ytbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 08:53:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61Q8QpVm012544;
	Thu, 26 Feb 2026 08:53:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35gfgh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 08:53:17 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61Q8r7gL014003;
	Thu, 26 Feb 2026 08:53:16 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-58-146.vpn.oracle.com [10.154.58.146])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4cf35gfg6e-3;
	Thu, 26 Feb 2026 08:53:16 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 2/2] man-pages: describe layout BTF feature
Date: Thu, 26 Feb 2026 08:52:40 +0000
Message-ID: <20260226085240.1908874-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260226085240.1908874-1-alan.maguire@oracle.com>
References: <20260226085240.1908874-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2602260079
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA3OSBTYWx0ZWRfX2wc/1F/uJbmY
 azpOfyzbpfW8Y9Tc4Os4jr9xrnmr8xdcWumRM6EEdqIeiym3PyaifcQIpsRTcyvVdSIVzcpScUf
 bbUFh75Ak/a0ONDYu7Lil+jqvZzI3Ht/ouKfm4adl/+zEv9LJfaNThM0r3PqKKItTcOIcdt2bhq
 UltWoly0bKQTfe6VTESlhckRYX8nciWOnkRt8cM4xxds2kplkT70aLPJKXMZO3TXzavL5BqJu1G
 rWgqy9mk9xTYkTqvLqnJ901XPAcw+SM0TXOBFKXtL+C8DD6PXg0SG5+BRfeD5V1tcyeH0e1gjHF
 ZXJ7MPOTP6cZraoGgFE23JvIpDfK/qTAZ4rbhU/SW0vyEra3+YSMiJ+v/hg6kQDJHn5+8bYR7uh
 C1O4gWXrW+zQUYnaCNjJrt4WGdltNtJe5QUlOMCge3tPYX+IEDY5DDSCdjA+FubH62IjsfN6TLu
 7k3DEw4XxF62ws9aLdihLHDmtwXLKImEcYLmhDj0=
X-Proofpoint-GUID: CvSWYBrVYhExr-kNONDV_CgqRQTlmpou
X-Authority-Analysis: v=2.4 cv=b9C/I9Gx c=1 sm=1 tr=0 ts=69a009fe b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=tfYQNom77gPQtgDtiRgA:9 cc=ntf
 awl=host:13810
X-Proofpoint-ORIG-GUID: CvSWYBrVYhExr-kNONDV_CgqRQTlmpou

Add this optional feature to btf_features description.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 man-pages/pahole.1 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index 90a8f45..5680447 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -341,6 +341,8 @@ Supported non-standard features (not enabled for 'default')
 	                   (rather than source-level) signatures are used;
                            for gcc these are ".isra.0" and ".costprop.0"
                            optimized functions
+	layout             Encode information about BTF kinds available at encoding     
+	                   time in layout section in BTF.
 
 .fi
 
-- 
2.39.3

