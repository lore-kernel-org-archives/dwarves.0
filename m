Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41F5363083;
	Mon,  2 Mar 2026 11:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772451721; cv=none; b=ODm/Tka9ABPQBmPfzzZt0c3xslOH0hHb60dHNrzGDuxSy4oej3Wa7tYmiZTaCIHGEdl0y1s2apNlVqjxknK8SB5OVTys5ideG/1wEzymBE/mOfxA6O/vANJt6npNn1ovPAuZVGkgQwQaWw9YSlSBSU2YvfvzxUxCK6g9wz3Nr30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772451721; c=relaxed/simple;
	bh=Vl8d+1lloIOpJRAoS12Cp0A3vK8mnBKYu4DEwbR+X4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKYeB6yrLsKFGr3IqUduGkmOFcDPYREWr1ExZIO9AqlJ+NdTn8JFNSomgFkbvqnZ4gSQqIIxaDDNyeCJXg5tMLRpEdofXNaqqRHfW+iqOGjzboxll7+BicbJhzgA0rWPpTPk8EkiFgiMWIGJLVcIR6Mg/561oyGSJtd+qJAbbvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QEB14A6r; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QEB14A6r"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622B3a8F3252887;
	Mon, 2 Mar 2026 11:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=xrbpE
	90Tswxkx7Bq0apvQT9aEigEF/KUczrfJPjSyfs=; b=QEB14A6rHWB8CZ/ySH+NG
	JxuhBY00KRfUSUkg60Uoc6pm12tnxU0awPnxxKy1r6lhb8khFLOsqNaqFO+rxzya
	OJqv5iUYpICpMNyoSXgGIKCEPaHxMZwPUUFR4IlAVume5UsB/rltoueiNP9oH/G7
	ZILqbf3fp7/PdHer96Z3RLl8MwiY3gen0vixTe9USaaUQadUWhbHyhIY1BGCAOXL
	rd+9iM8VSwvZA8xPdt7EOX+HLFTKd6sxKBIy3WYEFUW+zNV50cBmO0mpTWyYlda4
	PktdJxZtiIwD85Q59gCFLt4Wmv9SKOMOzY4NOo/+G+HGOb9Kou1dA8VIIzLW6O2T
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cn9bc01ua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Mar 2026 11:41:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 622BE2HF037037;
	Mon, 2 Mar 2026 11:41:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpt8jd29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Mar 2026 11:41:36 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 622BZCYt012507;
	Mon, 2 Mar 2026 11:41:35 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-59-97.vpn.oracle.com [10.154.59.97])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ckpt8jcgy-9;
	Mon, 02 Mar 2026 11:41:35 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v11 bpf-next 8/8] kbuild, bpf: Specify "layout" optional feature
Date: Mon,  2 Mar 2026 11:40:59 +0000
Message-ID: <20260302114059.3697879-9-alan.maguire@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA5NyBTYWx0ZWRfX57d/nRiZBTYN
 abLTRGwcT4Xp8c4j5vLLTy+ldxkhwGK9id7pMBpCPLDfmPK0lLx+izENeXyWRJK6A2BM5TEjuAt
 nyPlLvq0uxBbYC+fR1cXqylK0COpOE80sxvcjntRUPTR548hvbGKQDOncGBiEJ/sX29Nuo/YQR0
 yRg2naiFeXcbH3Jj8tIt+MUFqiGnKb0BSSufVxSrwBmdGsLtVNttVbkTLXQPdmlIcs3gkHYQ9VG
 6SPgghAgKvGoemSf+FNhVdBksej/vaEXP97JFSnZSTw0KJqGna4yUVX5L5Ux9m8wGclt3EulFW5
 69kkaW0f6ruQZqxPZrqZX8BS8WaP/4Z7XSHSNufINnwz5csLz3xdHxvKAZpJ2/7WxZtTfT8XF5b
 SeY58YZ1yV8c4FylrMrVfyGy7SY86I0dCGmhj1HUTgc712xbk3xjLJEKpQNO3Z39FX3RMAOXopq
 7rgNrowEeCurx66KdTg==
X-Authority-Analysis: v=2.4 cv=bNQb4f+Z c=1 sm=1 tr=0 ts=69a57771 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=J4qZCyyk7QvxA2XVlwcA:9
X-Proofpoint-GUID: eHiMAyL0eq-N0p_DS-QB1mWEtZ37IScQ
X-Proofpoint-ORIG-GUID: eHiMAyL0eq-N0p_DS-QB1mWEtZ37IScQ

The "layout" feature will add metadata about BTF kinds to the
generated BTF; its absence in pahole will not trigger an error so it
is safe to add unconditionally as it will simply be ignored if pahole
does not support it.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 scripts/Makefile.btf | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index 562a04b40e06..e66e13e79653 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -18,6 +18,8 @@ pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j$(JOBS) --btf_features=enc
 
 pahole-flags-$(call test-ge, $(pahole-ver), 130) += --btf_features=attributes
 
+pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=layout
+
 endif
 
 pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
-- 
2.39.3

