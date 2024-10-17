Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A4D1D7E2F
	for <dwarves@vger.kernel.org>; Thu, 17 Oct 2024 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729157087; cv=none; b=ZTH37MSeP8OQ85I4u3ujk36mhDGScqEP2SsvXh9mtu084cLKqr6+/TKvW+yJCQsOZuDZrHHEtZmPZTuDZRydgXNxDYcgaDU+yFa4a3MI5yNHt3oggVOdLO2aO3P4XgZ+EFoCJ2KCDwJS1Tets+yU8Hj1E1fRi9cRj8cmSbvZaas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729157087; c=relaxed/simple;
	bh=+6MFwog+c6I4HOwTMUiFqeGAL3uPSVX5QkOLzi06ioE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u2yrK6n7f8AiADsZKhRnkhOZ90BTF+1j+V8LTEcwvwfjeaHz+aFznhFFANtdgopwrb38OqY4BAEJG3qxJ9m9et/UMgeHi+bo4Oqj+j97sOmzvgwh/e02thp3tBrmBy5x9kMuPdjRjukI5MDrHZ6McPbz0ZlL+HQ0DD2+AHgT4MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jTYeRatm; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jTYeRatm"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H9MfaU011581;
	Thu, 17 Oct 2024 09:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=Qv6jzsZ609NAXq26d2BoV2RkhL27I
	EgPettwHoOQUfo=; b=jTYeRatmO492kSC3nkvLG7F22gf6OFRowqavpmc8hkraM
	Bhxf9zIzMmQzuokCrgdZsVNAFtF8bzY2LmunCuxEZ9l4At3je0EV3FYe+pg8EDXt
	mHoZrdmXqHQskE0Gvm0z6KqyD/ljXIf3SO/8XerVP4BbQFeE9T8Wjlx47KQ4YaQo
	kMpr/OjgFdJ5rtBPvJkXAbJe1wLT0Ug/QH7bG+fBWlMENIJrhYf4b0vy9KORYEiT
	ePGBo5Ssn/kfqX6w6r+03KwVvce0DsJQtUmlfEWbm7ZS0Lpvls9wkY5QrP9XzQXZ
	IWNqmPfy5mbdeIpUVgvifNDs6Xw6LRxpuf4dWIYYQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1anpt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 09:24:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49H8JSl8019471;
	Thu, 17 Oct 2024 09:24:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj9yd8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 09:24:36 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49H9OZFX013396;
	Thu, 17 Oct 2024 09:24:35 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-205-31.vpn.oracle.com [10.175.205.31])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 427fj9yd84-1;
	Thu, 17 Oct 2024 09:24:35 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, eddyz87@gmail.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 1/2] btf_loader: send warnings to stderr
Date: Thu, 17 Oct 2024 10:24:32 +0100
Message-ID: <20241017092433.690192-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_09,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170063
X-Proofpoint-GUID: OMOwMfFmFr6WvFlWfP4S_YrjtKB8bLgM
X-Proofpoint-ORIG-GUID: OMOwMfFmFr6WvFlWfP4S_YrjtKB8bLgM

Among other things, this helps simplify tests/btf_functions.sh.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_loader.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/btf_loader.c b/btf_loader.c
index c70b67f..4814f29 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -449,7 +449,7 @@ static int create_new_tag(struct cu *cu, int type, const struct btf_type *tp, ui
 	case BTF_KIND_TYPE_TAG:	tag->tag = DW_TAG_LLVM_annotation; break;
 	default:
 		free(tag);
-		printf("%s: Unknown type %d\n\n", __func__, type);
+		fprintf(stderr, "%s: Unknown type %d\n\n", __func__, type);
 		return 0;
 	}
 
@@ -470,7 +470,7 @@ static int process_decl_tag(struct cu *cu, const struct btf_type *tp)
 		tag = cu__tag(cu, tp->type);
 
 	if (tag == NULL) {
-		printf("WARNING: BTF_KIND_DECL_TAG for unknown BTF id %d\n", tp->type);
+		fprintf(stderr, "WARNING: BTF_KIND_DECL_TAG for unknown BTF id %d\n", tp->type);
 		return 0;
 	}
 
@@ -478,7 +478,8 @@ static int process_decl_tag(struct cu *cu, const struct btf_type *tp)
 
 	if (tag->attribute != NULL) {
 		char bf[128];
-		printf("WARNING: still unsuported BTF_KIND_DECL_TAG(%s) for %s already with attribute (%s), ignoring\n",
+
+		fprintf(stderr, "WARNING: still unsuported BTF_KIND_DECL_TAG(%s) for %s already with attribute (%s), ignoring\n",
 		       attribute, tag__name(tag, cu, bf, sizeof(bf), NULL), tag->attribute);
 	} else {
 		tag->attribute = attribute;
-- 
2.43.5

