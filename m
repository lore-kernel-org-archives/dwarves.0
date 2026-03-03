Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448353B8BCE;
	Tue,  3 Mar 2026 18:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772562122; cv=none; b=mIkRF9bzWxIbe/Yk+WvCOTsUCQJefsrDAxdeyL4nT59+MbIiCckBVS4HOj5sQgzkgovD/AkzHKKsmuGnQN1j/7r/U64b+2nxzbnT4dlW7GKc4vCfMZicoNsAt2QLbRenNCstmr0nwgvfQK2LuaXh7J7TRg15BQAMVqFrZS+W0Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772562122; c=relaxed/simple;
	bh=LX9otucclhj4r5PMXsK54vORtsnyHeJbLaBj22vTMDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGZO2tqeTPECNodr10/aVFiwKXOVzxhFVLxF/j+QxgcPqSc0aaCOeYXntheGsxv9R0DgPCb8DJdNsS7+247YASoLASoL2C/cToSqGTb64yjnZhWWly+AFZPjmYCciwUbBsKocPLsu+Ldphi+6/mYxa4zjKAa0TaNGTVty5qUAOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BClYeAbK; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BClYeAbK"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623IHCqr868138;
	Tue, 3 Mar 2026 18:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=CE9Sd
	S/nbEF9YJNIEgxKbklEKP8amjl4saQWyJDXHbk=; b=BClYeAbKFUVcDeIr17yEG
	TZhMDq69jBKfur6GG+ReCrjlTHfpwhjQj6ESDymj6yodjO+WviV0u4+ZwTxwYSEj
	umtS1lIDfqvTT2xSbDLxMI4dkNDsE7T4IhgIjzzc3TV2hUMXw+5tWguMQ2/xB02U
	mKf3P6PCoJ6HPjK9byhCOxKPV9WvzcaZINvT58K0yhL/ypb0Ak8QqLdvkeobgYVz
	LXFcTJ74J89JEtiWeLTC9sEelqcETaghxf9lXAQEVWeU6tnIEps0aYrJ1VtOVT4K
	if6/5QpTqLfZJxinJSYJSbbgeN1M0sY9zEXAoB2jlCZKAoUkS8bK3IxXkfTSLa0A
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cp4sr006a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 18:20:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 623HYBGX037701;
	Tue, 3 Mar 2026 18:20:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpteyyg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 18:20:21 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 623IK7oD029269;
	Tue, 3 Mar 2026 18:20:21 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-62-133.vpn.oracle.com [10.154.62.133])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ckpteyxu6-6;
	Tue, 03 Mar 2026 18:20:20 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v12 bpf-next 5/8] libbpf: BTF validation can use layout for unknown kinds
Date: Tue,  3 Mar 2026 18:20:00 +0000
Message-ID: <20260303182003.117483-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260303182003.117483-1-alan.maguire@oracle.com>
References: <20260303182003.117483-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603030148
X-Proofpoint-GUID: E10JSP6Xm7P-TlkYICfJOM0Zv08sm6jq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE0NyBTYWx0ZWRfX3d3CI7IhXHgw
 9GS15bljpl91hR2qPssuoOYvReOkpxHM2pVRPR6lYqKkSuOFweRf/q80tbwYfwvcgQV0lxTna+F
 1H3BkiI6XjB1I7Ef+RU14aw6TJpt4e26aoeSUWLCqLl8/TlgQuoNR1mIYo3mUqEOUP7UXSwGZgc
 JohoXv/3t1BL00CpLDpYc0IZjbD0eZ+93odrnxurPiPDU38oh00Ynf4muvNSat+T+nBMBEE/+SJ
 N0r0MrgOw6EkffqUYhSjsIZlb2O0NmW9FTqjV99XGSa0i9x9UCESLooj2emO829tQ0c1zSFmvXS
 hxOf5pwMVwlbu/X1bXKc2UeEdg3OSqEo0+9kIdI32HKDli/bXx+8LEWi1tcA47kPhzg+nWRW+Hm
 cnT/4p4HWPFAT2yT3V0pLou022I/58zvPTeWuzOFe70E99t+KsMG4xhAzQHopK/ybkZ++OWJiG9
 VTaDT1WpVUYEDjK0KE+SIp+l29RChkB+CvzIjyCU=
X-Authority-Analysis: v=2.4 cv=bp9BxUai c=1 sm=1 tr=0 ts=69a72666 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=aoasKMbPG5nyLhygJAEA:9
 a=zgiPjhLxNE0A:10 a=zZCYzV9kfG8A:10 cc=ntf awl=host:13812
X-Proofpoint-ORIG-GUID: E10JSP6Xm7P-TlkYICfJOM0Zv08sm6jq

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

