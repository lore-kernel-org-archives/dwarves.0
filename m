Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A31C39901F;
	Thu, 26 Feb 2026 08:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772096260; cv=none; b=TL0b+ENxTAtTwoQ7RIkbmYxLAVtuxEYug27Rsxp31VAp1JUdkErYe7tSAdBKCSmEEgPrSEamd+bPfVrnDGLThTghNtSQseLUnY1vynRZsgHww6F494CDsjExG5wH6z3CZ17CFVw6qU1OhQm7Y6imUcdCi1EwXUSHl+DvfW0TNtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772096260; c=relaxed/simple;
	bh=Vl8d+1lloIOpJRAoS12Cp0A3vK8mnBKYu4DEwbR+X4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UL1A63JNgK+i2S9A/+C5PBUrdVjp6dwybl0V/HTQBJz9fUWUostPEwlMqiwpxka2q9gxnyYOXrWhM62FkukgBywpW1pz1hbbWYhjFOw6AQ9xv33zvfbdvXOlP2BmgPIUmlzJEPa2PXtrcAPpOFuZ7r59PlosD5BxCGAl+DoYR6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GPauwJuz; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GPauwJuz"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PNvLT53554676;
	Thu, 26 Feb 2026 08:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=xrbpE
	90Tswxkx7Bq0apvQT9aEigEF/KUczrfJPjSyfs=; b=GPauwJuzfTRn9owAnVELv
	wkgoF2RQzUIlQGAg2AM/UD/imvWJx7Q7u8Eyof/cZs0on4Bid86tKvS+ti1v+JNa
	pQHQzeD6a+96lkTETJ815K57gjS7TM3VjFixku/Tkim4MkO6K60KC6/a7SLB6f9B
	U3iYL0bisSL0K0VQOk2kvFsoy7jFxoDW82fFwUhkjTS48bIgdRz1UaZb5BF3ciDm
	Ue64A69Tn4Fwwd3SWTah8O4ZZ3VyAgXi3EhiXP3xMAFaiWVPiG0vzHVbuvWoDEfQ
	Hts400NNS/YdIVgqwQbxaAVaTLiWOL3B+JJquJNjOVihj2f5kG4Rij33dcwmh5pO
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf3m7yv5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 08:57:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61Q7pvTi028533;
	Thu, 26 Feb 2026 08:57:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35c75qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 08:57:12 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61Q8uYak038952;
	Thu, 26 Feb 2026 08:57:12 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-58-146.vpn.oracle.com [10.154.58.146])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cf35c759a-11;
	Thu, 26 Feb 2026 08:57:11 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v9 bpf-next 10/10] kbuild, bpf: Specify "layout" optional feature
Date: Thu, 26 Feb 2026 08:56:24 +0000
Message-ID: <20260226085624.1909682-11-alan.maguire@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=O5U0fR9W c=1 sm=1 tr=0 ts=69a00ae9 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=J4qZCyyk7QvxA2XVlwcA:9
X-Proofpoint-GUID: 1gQPuqGmcABnPxYMCKdayWBtKrIh6bee
X-Proofpoint-ORIG-GUID: 1gQPuqGmcABnPxYMCKdayWBtKrIh6bee
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA3OSBTYWx0ZWRfX/V0MkXNfu0PS
 qvuVu8tuabpryBhzLO+tq1y/m2c89QYnI8c52aZRVdSjWgaaJ8jHWE0HUZPtlbWUIIrYIlpnk4O
 UvZ8g4Q/lH/kThwC11PEjjEvmD6VMYEz1iG+Z2PvXCGOiNwAZvDuTn/UmrcSanSCVX4UiA5SBD3
 rVE26MsBbyJYk/j7pSEwT3h/lslvwjtOad2cO0lPl00DbNQc8sNnSfVyFAPvcVWbNr6HFt9w5fR
 g58WJYXpVW6lCKXeMu+9u2tY0kd4RgHYXYnHdD5LI6S/u/HPcsIW3ewTCpD0HAASexSMi4498pS
 bxCFPAwcI3DQfTKx4LN2oeK+UKlWvzpcUpakEdtvyjP5OibLU6tKGFJpdDsakcFz4yYhBg6kL0q
 gS3DAEBIqEefPHDrJf2/muI2Dvnz/uJqNmuoTvoeeTztlcNJQN8/COcyjP8WnfB3rBGQHUEWrjl
 19m4c6frK8Tq9PkF/ug==

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

