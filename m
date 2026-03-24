Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D79A40822A;
	Tue, 24 Mar 2026 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374332; cv=none; b=raTgUD1Zu5/NXRcFXnpafxOwFZoFsXa10XKhqqGqNC12xZMWfSG1dndii3hVmD+PdMC2csBKB2oMT5j4RnK7KJqN3UF/QeDew5usJPrFIzg99kuBjTb4YRJZNwRq9zHB9fAPMeTyvuyH8vEggVpKTXfpteZ/L62bKmQ2lKCMP6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374332; c=relaxed/simple;
	bh=fmF2dD7nOt2j0mnhK7j6fxNcHnpIedsvnhcuQoEck8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBOiunBqpGaiUi3TSfGMR7I951KnNTNvufu3jsfbN9xua2T2ValHU8fMVV0/LczGl3k4dbg9NXw4e8i9dW37gUNFDHPGS1GVt5a/Q3N5QtZhKAZDUCy4tXajjfMVbnRFHPqNHKTv1PmWQpvY7esFIgZ+XHmHVHHKRy9l/IKfvBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YAGw0RUr; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YAGw0RUr"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OCBsG54016998;
	Tue, 24 Mar 2026 17:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=D7Zeb
	AtLQW+WbWWVg4e9wCwEYqYE9tExhifF5YbVAZY=; b=YAGw0RUrVhMB+OVNpOAys
	q8pC9CeLmCeClEtG3yqug2q5PcK7C4fVi/uo/mKjRzKQTDbEPVc00Y5dZTe6XJqR
	3hCxuMyUH9W8L/HAwjPSGCZ9P2UcCAyMBoRpMMP3hFrFsQ2NaT/DAoIKECezWVgL
	jsmo1AYIMrQv7ucCaCMmJe3KGUYb9H3IFAmhdWDGJbj8WSx4G1cMBFjMg8UTjQdO
	+HRRcwQviskVgT9co8WfAFoJssJh7kBn1W95zA/yRa29JtWSRzx1142QCAu5020F
	0CAapsPVaHSKuqa7qyRy0fWhWkr9KjjLPq87FbZGbUGsTefrCFjK4rLWW2dvBWkn
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kj2cr12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 17:45:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62OGsM7l002661;
	Tue, 24 Mar 2026 17:45:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsac7b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 17:45:05 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62OHirgs035539;
	Tue, 24 Mar 2026 17:45:04 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-54-179.vpn.oracle.com [10.154.54.179])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4d1hsac706-6;
	Tue, 24 Mar 2026 17:45:04 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
        qmo@kernel.org, ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v15 bpf-next 5/9] libbpf: BTF validation can use layout for unknown kinds
Date: Tue, 24 Mar 2026 17:44:46 +0000
Message-ID: <20260324174450.1570809-6-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260324174450.1570809-1-alan.maguire@oracle.com>
References: <20260324174450.1570809-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603240137
X-Proofpoint-ORIG-GUID: FzI0Ow4_nteFlUlNXRK4MyyzUSrPRibT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzOCBTYWx0ZWRfXysw530cUzuRt
 B09r3cLKkYwB+0DB6jwqnIqIIJ1ld4oJ5fr8f0sjaxAhet4pgSpnuU74jAPwD3do6rApkjG42x/
 X7d+UdP2qI/V5asZ713lPPH+HObc7HF1dVxl/CrTaHHl+0H0OLd9NOXdP4RHq/SD0YxgbmN7fqr
 5Yj6x3jlXmr8L5xchHvKfgDGTcq1JoCy/IFIoD1JP43YtJNP85zPa90QM3LL73zO5Itf3MBEpUg
 3+opXIN03HooMmIiCk/D7ANx6MbwKNmUXamtra2mLeOZBqL9SBEIOxCTgEok2Z80Y8rOtFsPztG
 Os8dZKgHgpUPqWFKHPZZjmtWiW1HxbAkOz47nvyo0CrEjLRljh3Puja9idih0zk/PETRkGRdcNs
 Ti/EYnVhURxm9tqNhJlRMZ3Wain0HLxsG75V+pslU9HrigJAPNO0w/4tZP5hs3PPa6Wy0u2l+9U
 6dxCwjf+1UBRY73Rv4rj9ofv7aUFX1yQxBlrmNQo=
X-Proofpoint-GUID: FzI0Ow4_nteFlUlNXRK4MyyzUSrPRibT
X-Authority-Analysis: v=2.4 cv=KtJAGGWN c=1 sm=1 tr=0 ts=69c2cda2 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=ew25JDPet5J0AOAYVN8A:9 cc=ntf
 awl=host:13824

BTF parsing can use layout to navigate unknown kinds, so
btf_validate_type() should take layout information into
account to avoid failure when an unrecognized kind is met.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index ef4145652a08..7743ffaf4306 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -412,7 +412,7 @@ static int btf_parse_layout_sec(struct btf *btf)
 /* for unknown kinds, consult kind layout. */
 static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t)
 {
-	__u32 layout_kinds = btf->hdr.layout_len / sizeof(struct btf_layout);
+	__u32 l_cnt = btf->hdr.layout_len / sizeof(struct btf_layout);
 	struct btf_layout *l = btf->layout;
 	__u16 vlen = btf_vlen(t);
 	__u32 kind = btf_kind(t);
@@ -423,10 +423,10 @@ static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t
 
 		if (base_btf) {
 			l = base_btf->layout;
-			layout_kinds = base_btf->hdr.layout_len / sizeof(struct btf_layout);
+			l_cnt = base_btf->hdr.layout_len / sizeof(struct btf_layout);
 		}
 	}
-	if (!l || kind >= layout_kinds) {
+	if (!l || kind >= l_cnt) {
 		pr_debug("Unsupported BTF_KIND: %u\n", btf_kind(t));
 		return -EINVAL;
 	}
@@ -729,8 +729,12 @@ static int btf_validate_type(const struct btf *btf, const struct btf_type *t, __
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

