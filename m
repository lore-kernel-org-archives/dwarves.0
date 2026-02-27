Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48DA3D3D18;
	Fri, 27 Feb 2026 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186720; cv=none; b=u9xiWVLFNdQJqaWXi4Bdi3OjsPlVB5OH7l6j03jkmGQ6e+Cvp7L8auZKmPf9iJeYTd+/WS82bcWsdvo9YsL0hZxt5b6ezQqYOTgmvUAXrc5Uf2eO5DO4uMNuZglUHBXI1yiLahXS8tG/dPvbVI2VqNlOcA7sSWg4t3zU/gH0Yo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186720; c=relaxed/simple;
	bh=Yj2nam6g0p65km1es8xseofDNhfYJ6jgzP5NIdf0/tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfZSYr6ymV4iA7vyeipFr2oh5lVkppiF/QVAYb+pQ7Z0eygkloZqfRDKGdb/8mEEnE+CYqD1MmSdicsaE6kXzz+zTQ2jYqVI0T0okkjiWsEc3wso0Ffy0tLUAACwp+mublck+GStAZHm3SGrcyyKCDRI+wxZortema1H9HX+S3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Dz4b9D/X; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Dz4b9D/X"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R9vRJt2821061;
	Fri, 27 Feb 2026 10:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=GFako
	qEicrLPw/cOC2mkt5GufhK8AwFydfVjpi03B4U=; b=Dz4b9D/XGDMIF5iMfSNdM
	uMhq05+JcHhaFTU/G2/wITGXsimK/fAmEjoD/YXHcelrLxavQN8DM0gA+ComCd2o
	7qazJ1XayECIj+bpka7glFiGghPh1JKvVPbMvlJHH4sVRQfPn8HCdBBB4EkfJpfo
	Z9n07EdaRbIZb5+uUpbZDWXXwSUqpHozv+O5vX2ZyMym5bB9zfDciglArDYYDPsy
	4QCP/iSWtvfbbSV4WdUTHDIXwjokqj0fPMD2anjIUjTER65QiXCii9HozPcACzeC
	cNNyhKJzxFvqBCb5+L/EpSIJwdiOp65XEC9lwe15AJpFE/ENeQeOOHgnHSURdUyw
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4k61vfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 10:04:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61R80wZf027800;
	Fri, 27 Feb 2026 10:04:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35dmxdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 10:04:51 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61RA4Vxg036185;
	Fri, 27 Feb 2026 10:04:50 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-60-228.vpn.oracle.com [10.154.60.228])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cf35dmx3p-6;
	Fri, 27 Feb 2026 10:04:50 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v10 bpf-next 05/10] libbpf: BTF validation can use layout for unknown kinds
Date: Fri, 27 Feb 2026 10:04:21 +0000
Message-ID: <20260227100426.2585191-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260227100426.2585191-1-alan.maguire@oracle.com>
References: <20260227100426.2585191-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602270086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA4NiBTYWx0ZWRfX3rR3e25nk8sq
 AqtAJwZJy9P5vX0nLjTebI/LdGNMakSZbCyq1B1+sSq0XWET/MIUUVlYcwrjc6oJR+/L6/unpHK
 obj6YTwwXry6gnJMib6dMJX5+MPC80t4PMGheRuGyxAEzgl1aCRnXdmqm6v1ZliALLHGFEd3GoC
 PPZTe8pdCRT//9omNfHXa9034dv+QV34tryFKawG3bDxYUTIS6uPDIAoOH5XZjIkDyN54hBXttW
 29Ib+3c29GvjNlVj/QYNvlXyEOBu5Y26Gqzun3qyjllW9GBIF2qrzF37wa306XZoNUUXZrjmDhd
 dyE/+NjWeemjJog+3wibJsBtgDdR/EbJ3wHrblkvQEwENu9cXIQ17K2scCZH8iRSHtTn48kZzaF
 9bQgJeAn6nQKzi8iiisfVWb8TgiKIqWQqNV+ZhFpchLgKB6WxicnwPqS4htfdvNdereVGCl+h+n
 ZEgtI/nUobJXnYYyzyg==
X-Proofpoint-GUID: Ag8tt9Bp6j_ZELtGe_ZDh7a0comWyfGS
X-Authority-Analysis: v=2.4 cv=b9C/I9Gx c=1 sm=1 tr=0 ts=69a16c44 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=aoasKMbPG5nyLhygJAEA:9
 a=zgiPjhLxNE0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: Ag8tt9Bp6j_ZELtGe_ZDh7a0comWyfGS

BTF parsing can use layout to navigate unknown kinds, so
btf_validate_type() should take layout information into
account to avoid failure when an unrecognized kind is met.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 0c7fc0b49f20..d33208fdbbfd 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -704,8 +704,12 @@ static int btf_validate_type(const struct btf *btf, const struct btf_type *t, __
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

