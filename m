Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1143FE34A;
	Thu, 26 Mar 2026 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536926; cv=none; b=ZNI6w7UNhlhBIzwgtxN3r7XBZSHfmbSygzQCwy7bYzRysTrNI6AdU4uvlY42DwHAn7V87UJBFi4i9M1k13Jf3Md31FBdlAmJfuMsXpygFjONmmeB/74zxzbA+2PHhF3xP1xmiaSkxd/w75p8uKrCjrqfimuSEh3sLTNE4n8JWrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536926; c=relaxed/simple;
	bh=Z/LYIKEyrt8lSB9l5o5g0FTmN+joL7bqHSm38GNYLc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/cbMGET8EZzCExatSnHRL2f71FS9eYvQeQOe6fBmjckQxELzaHb7I8x8mJm3nUNq+7a+1MSQQ/+7XAyA+R1vLJS18AN7EoC9VyzMQAbXIUj8Z7oo5r95CZTC508dSVWVMBE/qOXP70sn//RIhCl9foaRI7USHxK/QRscg/v2/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N7eEJBFj; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N7eEJBFj"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q2sT063943875;
	Thu, 26 Mar 2026 14:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=lYudl
	CT6Q+UviRITvTyYLH/a3oPk5ke4JMcbwJMlv6Y=; b=N7eEJBFjGMzdnhuQBD2f3
	dhxoa6Dwn3DfPAgZzLrhrxo02jG1UnABxPTTZoaa8dUDIKMKE0EMsYkNuhJUUxH0
	xVf68KgG3x5evQi/2CLzbkFqr/rSgImHBJNSc3So+6Sn3osqyRxr4/QBzzts0Zo8
	n22ujfhTuVPosJxvgZ664ywIxnRukYzdCxKttVNFoxTzFcSTyISiVIMyAqwO8J58
	n2/XdpKVhOauGFHmG0icXjH3WSmUbUt+V8Jw559PvL+UN33Eqx5tXuZOz41ZIQV9
	jg4irV1Llh2BKSYrliibwrS4JGmgmI40ch8LCftHB/yAPV1u2cxrMpbitfLuirj9
	w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kvnrcjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 14:55:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62QEd54V000759;
	Thu, 26 Mar 2026 14:55:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsd23mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 14:55:04 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62QEslTD015958;
	Thu, 26 Mar 2026 14:55:04 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-54-22.vpn.oracle.com [10.154.54.22])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4d1hsd235q-6;
	Thu, 26 Mar 2026 14:55:03 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
        qmo@kernel.org, ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v16 bpf-next 5/9] libbpf: BTF validation can use layout for unknown kinds
Date: Thu, 26 Mar 2026 14:54:40 +0000
Message-ID: <20260326145444.2076244-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260326145444.2076244-1-alan.maguire@oracle.com>
References: <20260326145444.2076244-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603260105
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEwNSBTYWx0ZWRfXz3GxrIJ+1bKz
 2SkVjv7bt5WXMpBqwGQ6Vp56B9aBr6KXjNTjrXBUo8d8brBoN1qVUS8C3hpKqsjPDh7hkTucXuX
 iO6J3+GoCWR008p3mc0TGL4vIvHuYsMU+nnNz39XNT/EJ+3Vp5Ifsxtgnx+mdfuL2OkEw1SsOZu
 vNWk9VB+Qxb8HB+65wssq2WRwAyV/MlGpjAhTlhBatR0vDfljOEGYQMN3gyLfoQGsWW2BnZEiIy
 +O8h3Ws5RB5Dm8DcMAa0cdWWu4lFcRZomPqHdcvtTfleSzI9I3NvE4fFgIbxeZ4PcMRAHE4RvtW
 9C9bLRwhsbH0Lp30Gs1xAnVy8COUk5qUT7caEVtSUrvvZ2kaNYDvnQgxfOZmjl5gxqDYRR/uMlj
 qBbgA4vJ9o2r8JVjqv3umCbT4qTWHNjaKvmISgufV88bnQKS8pkiuioKxqslmb6ERXJowBaMwR5
 FLgeYblJh9xMOV97enQ==
X-Proofpoint-GUID: qtZZjQZiZu8Y2UmGjdoSGELxdQJmZ7ro
X-Authority-Analysis: v=2.4 cv=GrtPO01C c=1 sm=1 tr=0 ts=69c548c9 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=aoasKMbPG5nyLhygJAEA:9
 a=zgiPjhLxNE0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: qtZZjQZiZu8Y2UmGjdoSGELxdQJmZ7ro

BTF parsing can use layout to navigate unknown kinds, so
btf_validate_type() should take layout information into
account to avoid failure when an unrecognized kind is met.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 35b7fb85e1bb..ceb57b46a878 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -746,8 +746,12 @@ static int btf_validate_type(const struct btf *btf, const struct btf_type *t, __
 		break;
 	}
 	default:
-		pr_warn("btf: type [%u]: unrecognized kind %u\n", id, kind);
-		return -EINVAL;
+		/* Kind may be represented in kind layout information. */
+		if (btf_type_size_unknown(btf, t) < 0) {
+			pr_warn("btf: type [%u]: unrecognized kind %u\n", id, kind);
+			return -EINVAL;
+		}
+		break;
 	}
 	return 0;
 }
-- 
2.39.3

