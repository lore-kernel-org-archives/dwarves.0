Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59FE35BDB9;
	Fri,  6 Mar 2026 11:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772797183; cv=none; b=W6H2/XQo8He8lbfX9cBt8S89CIfrTW5dDhty0kBCe5lV3HV4XAZEV4vFYY/r70J3t+GnOhLaPiSVpcmUq1Ge0s877Zqi55dI2YVLaTKoT1kyTSohSLR8tIgBcZwulHCLKeifBC1A+fm0Jgr1Tq/4VYmhgvaEzj+nCCVQkInfiso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772797183; c=relaxed/simple;
	bh=LX9otucclhj4r5PMXsK54vORtsnyHeJbLaBj22vTMDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eFh4afnCoIj5325Sq1b0nIziTCwol/+LIh7VQXiikuln/FQ/BjByecfrgVR7agcKqz+Lqf53VgVg+RnGEVqyc7xiYfAGPoVg0K07mYYamy11xntMEGSFYaQNrmNjU7U1+gb2jClWDO5upSke1PoXIDbmAkmBgyL74SrQoJQ9v4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=q/v6aiQY; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q/v6aiQY"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626BIP9T3124062;
	Fri, 6 Mar 2026 11:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=CE9Sd
	S/nbEF9YJNIEgxKbklEKP8amjl4saQWyJDXHbk=; b=q/v6aiQYZoCVayNo4PehG
	toQXvBXoTuEtKkDp68kIEotPDM9OlxqRBFZ9NMNRPR0hxEnxkpGg3Bt5lG+LR2/6
	ZZ+NwbqD74heKe7saIGKqhTx7LOqyFXB8jz7HWkFgoxmvUjff/rfS4rnDsuL9ZWn
	yrzzjlUjXj3nHIkxlqGIoMSYuH8IY2zQLFtz0yis+rGT2DmRK+o3can7eJyL4Br2
	FvggsmSVKUq2zwdZz2hlNw1S4jjZwQ2O2gCuOrdBlWvQDJQMeFr/UMsY4kb3utfM
	j/qlHSmSPJ8s08DedMlMhRPP8dTsE+BpLgjGHBDNZ5YgHXR7qNYHyMZQ/ac3WILg
	A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cqwx8r0kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 11:39:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 626AehMV023214;
	Fri, 6 Mar 2026 11:36:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptjtmur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 11:36:47 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 626BaXF1025727;
	Fri, 6 Mar 2026 11:36:47 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-62-192.vpn.oracle.com [10.154.62.192])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ckptjtmhd-6;
	Fri, 06 Mar 2026 11:36:47 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v13 bpf-next 5/8] libbpf: BTF validation can use layout for unknown kinds
Date: Fri,  6 Mar 2026 11:36:27 +0000
Message-ID: <20260306113630.1281527-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260306113630.1281527-1-alan.maguire@oracle.com>
References: <20260306113630.1281527-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603060110
X-Proofpoint-GUID: rV7Q7itMUStStVIh92_-dgRUfbGRRHLV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDExMCBTYWx0ZWRfX+ArbBBTm7EvK
 l2fzK9B1U9H08q3Uo2LQMir9kzwwB1KWzpnQv6BK/zyZy51YqRWC0r9DpqfvkdgfeSZTlP+ct6x
 bd1rfpWLd9efdNt3apyznsrpdn7fe6+zhkq3/lE0OxYAaKccRqr+blNf4Tqm3vpO1wcF4ov7frL
 R2kCptrKCIaWkJMOaSAXJKqx11NCtffZ5oue+wfvOzLu2nyo4Ylw+evsgpAut94ChcPc0tM3oz6
 hYOwkFSDUC2euwnFf0hQMC1hsm1cmy/Du+3fmvsmerBTRsrLOUSZLOtcXlFNwpINaJQg3hzHf4W
 ayrPzChJN1pE5a/2AJfAL/Wnu6DrpqVXjZw48zPwj7RAQjHfADicGRxjPz3Zp9r2AynvpXsPh6A
 zWGLs201A3cZmHajizW1zv5IXQ2xAgBQOO2ivl7Dw3iHdBmGep/K0cub3JXvsBJYmuDx3c0TSgX
 HQhI4fHHQyZawOKlfj/7pxKcGB9dSvTDfh8qB6Ms=
X-Authority-Analysis: v=2.4 cv=PNACOPqC c=1 sm=1 tr=0 ts=69aabcde b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=aoasKMbPG5nyLhygJAEA:9
 a=zgiPjhLxNE0A:10 a=zZCYzV9kfG8A:10 cc=ntf awl=host:12267
X-Proofpoint-ORIG-GUID: rV7Q7itMUStStVIh92_-dgRUfbGRRHLV

BTF parsing can use layout to navigate unknown kinds, so
btf_validate_type() should take layout information into
account to avoid failure when an unrecognized kind is met.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index eba0cae65bb4..0f7532f3862b 100644
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

