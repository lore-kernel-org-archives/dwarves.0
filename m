Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D386D3D6CDC;
	Wed, 18 Mar 2026 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773840629; cv=none; b=sqW6fVHVxcNDz7IvJz53JhgFIY0VHsdo3v8ocdEnfeL5q1e8/Y+RW6JbkjKqgyAuzYw73mW7YtcjTdS8Pbz96UcPRFQ0188o1QWgMBEd45CnDX7H8OJdMPWB9Emm2FdSlu/v/3sBNasfjVnCAxCtQNk7lEJcA9DKUf6f2K0q5Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773840629; c=relaxed/simple;
	bh=B0flY+YVl4xXmDrUSfMVlDKI4ufSk1c/VuaD0g4n4NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5TdQRBRCHbn8rlmg0pMr3Hek5Q/THqAKIWCfDN73Qel5OQmblrvVNsNXUSCjmw0iM46XF5gemd9TOOV21yZen83rrc8eiNUJFYX8yz5muBEki8ng4eKmQ9ZCIFa2C4Ec7fE8gimdYoEaWl/DjxFV+hDnlo9Q3LxXhb3uOmQS1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f/GtlaQK; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f/GtlaQK"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I2MsJY3797262;
	Wed, 18 Mar 2026 13:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=IsUHM
	su1GsFM+eVfyRTbrvtM70dzuf4SLrxzoboCUbE=; b=f/GtlaQKIJ9Ua/ZVFBC15
	Hw8uy091J53/ixBF+YPlqCRn6dXODXUSPt10MPdBmb72ggWma9VxGo5dQZax9nu8
	agrVSZAAswINIbsP7g7W0RiVIYaiJUkixmxgAkyjZl9t814sJQ4HcOuk2NAtCl36
	S0mVQU1U1+3ozmRkNESVctgITyFd98vlktkHH0OobVOYeI28iY/17QB28CXMSz+d
	pVUKTFGVohU6HlivXhMe2c+VgUkKD8w3Ee4fjESRargasGB1egBw368yw8ZlydXb
	sV2e0XdoJt0ZiyPLVsQiquG9HbvvxNSS97lZ0k4wAXjwQsEOkEu5mulIem1Pvq+Y
	Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvyqbx0es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 13:30:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62IB77vY030554;
	Wed, 18 Mar 2026 13:30:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4bmth9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 13:30:07 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62IDTVfQ009174;
	Wed, 18 Mar 2026 13:30:06 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-75.vpn.oracle.com [10.154.52.75])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cvx4bmsqg-10;
	Wed, 18 Mar 2026 13:30:06 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v14 bpf-next 09/10] selftests/bpf: Add feature test for FEAT_BTF_LAYOUT
Date: Wed, 18 Mar 2026 13:29:26 +0000
Message-ID: <20260318132927.1142388-10-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260318132927.1142388-1-alan.maguire@oracle.com>
References: <20260318132927.1142388-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603180114
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDExNCBTYWx0ZWRfX+LLv06uBoaSh
 GFyZ6rRgr5BTK8gXq98SA87DFoX4Y6Ma+J/Vd/ELrAWrJsIL6oYvUBSV7atJp7AxZZLhy5HT3si
 vI2o9nHTBADjChCfg6zVByCSlTrcF5XE1vTOhdYLyPrP4GtmeZhdyzSh0Uo4iP8oJwk3iSd3Gln
 7h7qvndm13V/blQWBwn4cCdm4alf2BW5GUifov+oWHYfTv6Eqjcxw33iq6CIOLU4ThTBcU0vYmj
 Me0ntn6XoqK8VKQkEO2zyqo7rB48aVBcvImfOcXX74qk2tXWakyj9WMgYwNicpBE8Vmp1n3AMcu
 3a3Q3wBGppbnX8qcoM6h+k4I8eWLDPs4uC8g41J3oXULYu7DrR4r6YEK5YDFHMCcakzzQLGlRD6
 rZfJ3BXQopBhWsaT59O2Ziqiq8O9xU7o1cvEUKJjRwU/x3Lh4ln2DfKqqnJu/KGQfhq3ozUnrdX
 2MJzLjxXNyhi1U+VIIQ==
X-Authority-Analysis: v=2.4 cv=J8WnLQnS c=1 sm=1 tr=0 ts=69baa8e0 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=ncYw_Z_PcXh43CoHODsA:9
X-Proofpoint-GUID: tSgGYggWQpTEW-WtfoX9ovTNVivpXRE3
X-Proofpoint-ORIG-GUID: tSgGYggWQpTEW-WtfoX9ovTNVivpXRE3

It should return true for the current kernel.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .../selftests/bpf/prog_tests/bpf_features.c    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_features.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_features.c b/tools/testing/selftests/bpf/prog_tests/bpf_features.c
new file mode 100644
index 000000000000..cf20e17624a5
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_features.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026, Oracle and/or its affiliates. */
+#include <test_progs.h>
+#include <linux/btf.h>
+#include <bpf/libbpf_internal.h>
+
+#include "kfree_skb.skel.h"
+
+void test_btf_layout_feature(void)
+{
+	struct kfree_skb *skel = kfree_skb__open_and_load();
+
+	if (ASSERT_OK_PTR(skel, "kfree_skb_skel")) {
+		ASSERT_TRUE(kernel_supports(skel->obj, FEAT_BTF_LAYOUT),
+		    "btf_layout_supported");
+	}
+	kfree_skb__destroy(skel);
+}
-- 
2.39.3

