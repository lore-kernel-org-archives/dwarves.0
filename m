Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7929B364934;
	Fri, 27 Feb 2026 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186733; cv=none; b=LqR2GDBHx4519U5C1dXKaRZwoQfcDUtumJ4FccRZ1MNpTed1spAjb+Zzgsgz7cjjEBTg9Tgj6laRLi2M7hJ15dun+kOli4pEqIt2MM41PWZC8UFjckbFSoTqbLDnYxKCsdAgBmZxwsdHjjjRQQ3fHr6ZPfz2reDYw12kstx3bRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186733; c=relaxed/simple;
	bh=Vl8d+1lloIOpJRAoS12Cp0A3vK8mnBKYu4DEwbR+X4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCWys4D1vX1dZn9eb+OkL3wIZB3MXOJ8v9xt7i8+fYwq3XLKRKZshB/tHDGaX+6M5vRhwM345cSV5EciSXCsxyFVVpZuXzL5j4PfLsv1ponuWzcyhrxBYxYaBO76zVV/gNK59pOPdrE4mw8BUd2Sb7KCsTcJgicAEZcNeEu0XE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rfurXvSW; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rfurXvSW"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R9v3ec3312428;
	Fri, 27 Feb 2026 10:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=xrbpE
	90Tswxkx7Bq0apvQT9aEigEF/KUczrfJPjSyfs=; b=rfurXvSWbDUsHlEUrHQw5
	7AeswlhwY6kFS3Le2QFrQVKHTRtG0IWzCHu4RRcYohDGEJPq5y84lZRjkWmi/XWc
	RVJZiF3zpCP3GpbqcKCBNd+l6Ll2+hPM3bsS/Azn4C2gskKpCoUVlL/57gf3vVLQ
	wk85zEtkLor9EL5pw+VdW+wytuR4pESxpXTYbqgIfbL0SLZKnzk1iDp6YSGKEbcG
	elohAc3TxCYjanMGCnmeK/QJUgjpKwWX6IJUQhl1Tqs4FH+xiSAvdvp/IVosRLxD
	2//YQFIqHw207mDBqp/5IUIdRWfvDptROxrjrvdJuQtFLTKOfQW1qSEEQh271pfP
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4arhue4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 10:05:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61RA1U0m028503;
	Fri, 27 Feb 2026 10:05:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35dmxu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 10:05:10 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61RA4Vxq036185;
	Fri, 27 Feb 2026 10:05:09 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-60-228.vpn.oracle.com [10.154.60.228])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cf35dmx3p-11;
	Fri, 27 Feb 2026 10:05:09 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v10 bpf-next 10/10] kbuild, bpf: Specify "layout" optional feature
Date: Fri, 27 Feb 2026 10:04:26 +0000
Message-ID: <20260227100426.2585191-11-alan.maguire@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=La0xKzfi c=1 sm=1 tr=0 ts=69a16c57 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=J4qZCyyk7QvxA2XVlwcA:9
X-Proofpoint-ORIG-GUID: r11A_H3evenCQejGbkL4fje9EJpI-cFS
X-Proofpoint-GUID: r11A_H3evenCQejGbkL4fje9EJpI-cFS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA4NiBTYWx0ZWRfX9IOoeqpgeMMt
 YTV20mtu2I0AuLyH8fLFYSNUjnSH91rYo63M504HRsMiAzdzt/Lmm3eNmh1JeF/gK/uqjHjljaD
 SKoG2eaoBcs8I+GIHpcQF05N7FjmvxSMw2WAKQYgr5WsSYVhvCb69PJUXTPunzYXPUMFn8h59sI
 pblW9vlDI3PEBzqCO3ZUdySpxV60sq+V1OxmOBn2IYaVRfULMVwxsbfnj8hdgfgwOEvhTGMbBys
 KxkT4XJOvhPa3Ko3WaVMDwrZ0FU/3/mqAquNMxzxsaNvtrVI6dPLWS9TVO8VWPajSgTyfmcCD43
 GWr8MPkn+ea9wauPpFvuV3TOWLUpXVuik/R3AlziIlgQ2J8NUeJCzlCZIFo1EU3myCNnjOsxhmA
 azZHIeixbquNjGmhX3S/ou4fhzAzH6dcdKR8iGXcQtUO5Pij8BZ1CVFaQhuRuXP6REC3t4Ymwuz
 qppbTP9/uTWdT2rU80Q==

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

