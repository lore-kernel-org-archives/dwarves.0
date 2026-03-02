Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353CF3624A5;
	Mon,  2 Mar 2026 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772451705; cv=none; b=awJIuGB8YT+q95YfyvZthK9xqgWen9Uboa6NYg5oV1UZtvlMoirpdgpMSoEzuykScdxdm+sSvP1XjQzC/l3yc5PXYqByi0hwuYarJAAtfUw7Qgt+7sS9Pml2H6k9ZNsc/5JNJVfSZSz7QNHHIHS9qM3H1C0zMZbIBwOeulhW5fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772451705; c=relaxed/simple;
	bh=bG+RaI9XWMFpWED1uOq9i079O1P4SIR+3L1F93lV710=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KkcQKJCyy4JGuaLz6UT5huxdEaHdn1wMELZXZmLVQCPxYdLj14U71TceKszn70wbeujjxvyh7Z4m0Am/JsFMeP2sPAy1IFLuPpsCbd/NNOMrFxylyOJYqScK15/rfuBbf1nKCe0Vi8tsSwusNkUcRK79k9yn1/3gxj1RUbOC/pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JlRQ+37T; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JlRQ+37T"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622BGVEU2067160;
	Mon, 2 Mar 2026 11:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=4+kb/
	DmTIG7sfux7DJaLV4u3ZglCopZz/JCNvGWuSuI=; b=JlRQ+37TyzgHzqdQUNIZt
	pr+n4CQCGwh5NighL+QC4pdPB2eWJzAJRCJyuwM0p8yXhXTuAtHsJsd7bG8bMhdf
	l5SqcALLwVtGCRyoz/N6A7Bs0Nr7jx0LvDpAzmqLfRPf607z6VuqfAIv/GNr2PWd
	svGEZOS+jeIbmltPiDCnfi2bHo4u3+f4LcexrwS5+mtH+miHmaLF4f6lyczMN+od
	HoY2insNCoAxyCRHRxmy4261Lb/x2uIb3PY5oZ2UsHUkeLtHTfp8tN6wmbGL9EK+
	k0IPN49CJZ7HlLuqIkKZEnniVLBFhdzy4pjdiTYXmSOZgSKoH3xbY4f3tqwRTitX
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cn9hhg12n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Mar 2026 11:41:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 622BUp4i037136;
	Mon, 2 Mar 2026 11:41:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpt8jcvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Mar 2026 11:41:24 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 622BZCYn012507;
	Mon, 2 Mar 2026 11:41:23 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-59-97.vpn.oracle.com [10.154.59.97])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ckpt8jcgy-6;
	Mon, 02 Mar 2026 11:41:23 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v11 bpf-next 5/8] libbpf: BTF validation can use layout for unknown kinds
Date: Mon,  2 Mar 2026 11:40:56 +0000
Message-ID: <20260302114059.3697879-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260302114059.3697879-1-alan.maguire@oracle.com>
References: <20260302114059.3697879-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603020097
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA5NyBTYWx0ZWRfX+lP/wcej2NU4
 +IkrYpMIVZf1s/T96I0vP9sDMzp43M6mXdkuCWL7L6/r8/Dk8JD/+BHAmWixSOftcwms4FTZ/gY
 fO0Ta2nJ0y3JtIfQjl7K9LLB5Q7yraMzJfmMWX783scXwV9haxQXab/8oHmiy8IH0p/ODbV7SV7
 /s1ODb+iAP0R755UMrJCHhTJE3nr6RJ5fnDIMuKYzryIxyyn/71gEdMmnBSSEydkC8FFN234nl+
 tPjciFB8veI9GG2nZbLQ6+IGeVekqdSJ0qLstGefvizsgaVOoCyVnBmoyJdETIrBQTnreE0HDaY
 a7Zga/IAQSnn9It5vF46WUS6vOTkVf6nur3+Tgnuee1yj2WXoqulOJJyunoXDejX3sFZiiuBIf4
 C7aqQSXycNSWta7UpJNuwzdoM8UsmlXrydxKetzBXHVgA6UHccuhJ2FQYUyZBQgH5ruFXknKWKA
 ZomIY5F5u3Ebq7sSEhg==
X-Proofpoint-ORIG-GUID: axCOf07Fi3GvX0VScvfcsgC2EK4Gb9DR
X-Proofpoint-GUID: axCOf07Fi3GvX0VScvfcsgC2EK4Gb9DR
X-Authority-Analysis: v=2.4 cv=C53kCAP+ c=1 sm=1 tr=0 ts=69a57765 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=aoasKMbPG5nyLhygJAEA:9
 a=zgiPjhLxNE0A:10 a=zZCYzV9kfG8A:10

BTF parsing can use layout to navigate unknown kinds, so
btf_validate_type() should take layout information into
account to avoid failure when an unrecognized kind is met.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index e87003711543..d4850b58957d 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -706,8 +706,12 @@ static int btf_validate_type(const struct btf *btf, const struct btf_type *t, __
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

