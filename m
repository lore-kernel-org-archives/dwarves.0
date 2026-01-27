Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3392C2DF14B;
	Tue, 27 Jan 2026 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769534477; cv=none; b=RaZ63zNT6zLMUfYTL86D9HhxqKyPxn+sDBAhw1U1DPAdR1tkx2U/8knJVflzG77PPnz0YGPaOtSyQAwyBSKppQUityCF+cTWOKXDpF6qD6wHFwsxt2JP5q7mPcHeolvu3Y47tl1I0LepDXj1znzVszNUJwynfDkZYdjF2VSvQvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769534477; c=relaxed/simple;
	bh=TokPKEnB8tovEXUY/BNwclMXnqROE98rgNnjWXWwZeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o787iK+o0g6BudSyuwUMusPkyXIPBtbmmPCN2InWnAsn1clMrRgXDzfovi2mWG3lbBufoW6Acn3KF+uNISvbFSCYEGFzsgPYxPKvGqcGys6gxF0XVwq2VHEMsKVy41bBLrSjGRORHFdGG8rUlViVDBhuXnep7GHWjlxKCtaeS1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=REyugJPt; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="REyugJPt"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBEfx04056597;
	Tue, 27 Jan 2026 17:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=9n3ZJ
	2JIG6YMhqbJT7oukQGHs6CrXq7Ke1y/zJzTbx4=; b=REyugJPtVF3YiVGqeLyQB
	8rAmNBpWclML/+/342XCZBO/Z/adL1WeIb4CrRMW6dyUCZciiGdSiu6ssoTOREmM
	bQljzjOffj+fmDHzjh2yRxBFazcynK80Rlfe4ysTiiT7YFShLPgWl/pQ6DUHfk/a
	SUPbTKo4oBX80m2pnSbjCX0uCIs8iK1jD2yQdeAxDp+APWcvHoJqkSCyuMzJPfNy
	DGgorejoV/u82hy5mRoK3FMifFoatmH1sc7wswp74YDTUaJ8S05KLcSU2fOEQYCf
	WxRYrUncoD1d0iXTal0XpNw4TUK+bIR0F/4LIDCfY+ceYVZ4ke5B6ZDDPEddoecr
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvnpscdy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 17:20:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RHBnBC035453;
	Tue, 27 Jan 2026 17:20:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh9q831-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 17:20:56 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60RHKjSn011183;
	Tue, 27 Jan 2026 17:20:56 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-55-133.vpn.oracle.com [10.154.55.133])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4bvmh9q7sn-5;
	Tue, 27 Jan 2026 17:20:56 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: yonghong.song@linux.dev, mattbobrowski@google.com
Cc: ihor.solodrai@linux.dev, eddyz87@gmail.com, jolsa@kernel.org,
        andrii@kernel.org, ast@kernel.org, david.faust@oracle.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 4/5] man-pages: document true_signature btf_feature
Date: Tue, 27 Jan 2026 17:20:40 +0000
Message-ID: <20260127172041.1558244-5-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260127172041.1558244-1-alan.maguire@oracle.com>
References: <20260127172041.1558244-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601270141
X-Authority-Analysis: v=2.4 cv=dY2NHHXe c=1 sm=1 tr=0 ts=6978f3f9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8
 a=6ty38rQOddPpi4xR-mIA:9
X-Proofpoint-GUID: fUqvaV3ibSUlpgsvf7aHTgLvO6vA_ehE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE0MSBTYWx0ZWRfX+r16GLwEvOfd
 s33H2Pd7EDo9M72x2dOXNjbkXCGIshlivuowDnjIca9ubl/O0ltqbCVP4CA9ZsoTz41WvSB2Elg
 zEtTEybc/cWRTmrRd5yXqxQdFyIlwad6rxR7aMyJgP9a6ZIIOP+ackKKMFg988Fh3JG0ht7pWYn
 hkxd+OzcrTfrn+8MQYZrWFVk7DT6Pkq8f2CuVOfqPcr2xxgJT4KbTUiubUzhq1C+eEhcFN/EJZf
 e5MYoRBjKzvV9XMZKgHmCm+ENwAG7JZpJ3BF54KY1WiGxBOAbhySIOwXXnA6bmEA8U5C6poDr1x
 GabVTRIRHA+lHxKQOzn9PG6TrAE6iFmyvauXS2kfTdhtEInd173GrNk5g2djm96Nnll+j6mQ3tN
 ZFrgcc8UOWa3vIAp5/JsF3LdAEd0PHB631HZtfGvkRH0rdCt4fQo8xqpOz9xGoZtY/LglTBugzm
 ArJT95VpthNHDPrvVRw==
X-Proofpoint-ORIG-GUID: fUqvaV3ibSUlpgsvf7aHTgLvO6vA_ehE

Ensure non-default "true_signature" feature is documented in
the manual page.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Matt Bobrowski <mattbobrowski@google.com>
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

