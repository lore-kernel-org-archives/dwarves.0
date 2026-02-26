Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E24538F23D;
	Thu, 26 Feb 2026 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772096243; cv=none; b=c1hwZ661e9j+g6E+kIiyUp94la+QKCKuCwZ+WgofPNxM1QER6w9UW3YVXf+y1mwCjz2Jh8x5K6P6FpXfNGLvSi3T0heYPp7X/ngJCjwbLzDw4BY8fhJF2dQvb1nVxx/vOnbbKl1bEZO2YfpzOH70JyC8TvSZI9uoGKZe9cGuUG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772096243; c=relaxed/simple;
	bh=YpdNiXmtWEk1lBUO83hWdQTMtK1vh09YzA6EVgM56Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwXexA14cuq2rCIPBci8T0BFJO7duF+mTU1jmIDs1CFoFRCTdBLVE9r3k9M1mGVwdUgHOrofIeAIODWYJxm/zCh8Bp+8d03MUrytIhILt86lJ3Pfd3ruTnCuMguJy3fFiOa4Qg601zlF3xI7RWvtuMayxW+kQ8Jz4KgVL13KyLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PwgFKC1r; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PwgFKC1r"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PNv8f43709376;
	Thu, 26 Feb 2026 08:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=khLBZ
	yKZdyLD+Uy/9SrYiiKOm5w0l5CUSgl9rKjSv6A=; b=PwgFKC1r2OXkXY2eOYPhm
	or+PzWTf6xnapYRF7EIbCcSpWxrnguOdHmPWyPjOmCxI5ip9Dm5lTnhLukO85GYP
	RkmEKUmuCZNXjCtKO+Ddo/6FbJvkZlbUQDUKcLGpbbpw9BEOeoWVsFX+CN8b5Tqs
	uQpk5vCYEkpOj4ukt7I1aKzxpS5Y8dvyuXhQGSVd8amDlidMpzytPUL1fNgek//z
	NE/HEjnlIyC+PLlJzwkes2EnOBBRI4bi7Ccwe0/kCnjm0Du9eyLysB4enh1U0AyY
	cravdADSkrKQXadnWmh0RrrQ20/EOpFwQq0u60CcZ3eBbi3osy0CI/DH3w+YSzlW
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4arftyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 08:56:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61Q80uUQ028627;
	Thu, 26 Feb 2026 08:56:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35c75fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 08:56:53 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61Q8uYaa038952;
	Thu, 26 Feb 2026 08:56:53 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-58-146.vpn.oracle.com [10.154.58.146])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cf35c759a-6;
	Thu, 26 Feb 2026 08:56:52 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v9 bpf-next 05/10] libbpf: BTF validation can use layout for unknown kinds
Date: Thu, 26 Feb 2026 08:56:19 +0000
Message-ID: <20260226085624.1909682-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260226085624.1909682-1-alan.maguire@oracle.com>
References: <20260226085624.1909682-1-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602260079
X-Authority-Analysis: v=2.4 cv=La0xKzfi c=1 sm=1 tr=0 ts=69a00ad7 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=aoasKMbPG5nyLhygJAEA:9
 a=zgiPjhLxNE0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: DDx_rNRWtD5S3Bhy7BxEqNw3JLwPNKQk
X-Proofpoint-GUID: DDx_rNRWtD5S3Bhy7BxEqNw3JLwPNKQk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA3OSBTYWx0ZWRfXwijOuyIuIDtX
 oa/wFtpUf2PaulW/h5VBzXTaG1n0Ywee8wRVIdEw7FCcVkV9GAyyZThDSQ2cRUkVP9OUJ975C0d
 mjwld0FKDUl+5noipun4P8Pc34g5+sZhsZKUGkbWZWASfvDacPYoXqV9995QAxdVopf31oftWPV
 P5rto3lqqn0FyxTIMPBJJj+7kKm9ioC+qxiVModKAxppmTrddMoKIu+RqeywFrKF4BFOlxsLvcS
 xXplkSXEHACxbyP+Jh0MMjjJy4sPlRDEo42DWaVwKLVwZ+AxUwCq/rUp77chi2/zgpJjBJybJnK
 4AuMK9MnSZc1nwn4Ii1pawIq5Efyzp/X7abo5IlTRvpJj6Cb9BgjCaVPiPEXwi4+l9nQg5+0qQH
 TWPOqnj1nxLFcS+VvOWQjlu6IXp/7DPcNupad61UGSJzuC0kPbEiRVupLRPZbipj9a4naqM3ejo
 LBOsRAImbH0RaLLkAxA==

BTF parsing can use layout to navigate unknown kinds, so
btf_validate_type() should take layout information into
account to avoid failure when an unrecognized kind is met.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 348dd5047556..b98785967fc9 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -708,8 +708,12 @@ static int btf_validate_type(const struct btf *btf, const struct btf_type *t, __
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

