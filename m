Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985E647A66
	for <dwarves@vger.kernel.org>; Mon, 13 Apr 2026 09:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776072430; cv=none; b=M4Un8kDVEZhNVuStIlyNig+PUKcnS9jM81sqSHrvflANZu38/1JyQoutUkHfmh/aIuA6FaQDWNVC6zgREOOiWIBubZPMK3FvwhFhKPOAy4RA+xQ3X7e0EUeT0wtfJsDsV1ECWErQpjDfooy8lw7e+T5k5DitvOnIoB62hKJ65U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776072430; c=relaxed/simple;
	bh=uqhUionKP+iV2E93tXb31u1n4QIFWHrkHGaqxerNZyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JAM89AoFVK299iP38zHF6ZhZHFIjYSBCnRsd4doiU7WLuVpBP/uhheiHIGroAWA/PqPVQlQxZj9n7JGVw4OKuZTRxmFHeBEtL5ryk6yosVfL/KrUD8FYYiRVmqmm0hW9hcPdQMFt22DGf75402nhjcIXwESRIRdWaunOBbf62zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R+e16/MD; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R+e16/MD"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D0KJxG1652543
	for <dwarves@vger.kernel.org>; Mon, 13 Apr 2026 08:58:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=YTky6FJ0maSELF1HA+vGQljrOB5cj
	VoWfyo3gzPbgws=; b=R+e16/MD3sTrJfYjg7uNihrYAWTfEN+85DjOu5895rT4p
	Vrp1aykCiaNsUz8UbSQL+Dq5dy/+u697MIu2orI7oPL5byqzmJzeT2T8wJ7mPuWq
	R+Qpf4+/zgX1lY1drLTpFlY2TRVEqFgb+5AdXd5lRE98yIgpH33AqtJp41qVEYJp
	6ecGl+owAn+xsyG/MZIPpCHgOr4Wipnax9TL27iR7TefDhQEtgUwSDD9dlkcZX5b
	irDgBIORvKSWbsxutoP3VHVBOH+7SHC3ZpfzqViM5+ScIIK7pz1hA47sPDdOyiqe
	dEUp9/vEFhmtzToLIMB0m33i8AKHDcCiw61ckPfQA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dfeustnj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Mon, 13 Apr 2026 08:58:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63D8sMRj005074
	for <dwarves@vger.kernel.org>; Mon, 13 Apr 2026 08:58:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dgbfyyswx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Mon, 13 Apr 2026 08:58:38 +0000 (GMT)
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63D8pKiw037092
	for <dwarves@vger.kernel.org>; Mon, 13 Apr 2026 08:58:35 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-89-66.vpn.oracle.com [10.154.89.66])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4dgbfyysvv-1;
	Mon, 13 Apr 2026 08:58:35 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves] dwarves: libbpf sync with 1.8
Date: Mon, 13 Apr 2026 09:58:34 +0100
Message-ID: <20260413085834.152464-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=880
 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 suspectscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604010000 definitions=main-2604130086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA4NSBTYWx0ZWRfX6SBBbjMXcR/l
 W8tmZnu+4LyHI4PrEFmE7SnFf5ziWOxLEDxqI+GuuZQMG7ghHgaBLsEH7OXupgtza4+ix9HaX2Z
 GNBAEvUEIQ5CxgrGVcflIHM4lf1YYpdlnlS/YtyAMbj+We7F07MUdLIvweubvQP/jfUE64mNghK
 1/bC9347s+qlsIVLl3qKQBbXZ9AS/Nwdu/ewZ/K0LWoQuffoHiKAsn3TPcy5+7J4LqvVemQzZNL
 ZXym0+yHezp0mcnbbPo9e1wsAmZ7q58904BN7Q4p14oIJuJ9cIaNXfuqSSUH1DLUnuYc0I5ohKe
 BftmykS/FdN4FaCl9nRk/rQ8hPM6ZnLVcwt4/dqE0/gfeWXE8rOgywCYrAyILA3hrWsmbnwEzbv
 x841OSClAps7M36aPQk/5AsyIH/M9L62IuACb7SYK+gZrFP2Vv/qd15KBIwkQ/NEUxxdfEv0cXx
 y3RKwOjcHzSiZATa92g==
X-Authority-Analysis: v=2.4 cv=PpmjqQM3 c=1 sm=1 tr=0 ts=69dcb03e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=NEAV23lmAAAA:8 a=yPCof4ZbAAAA:8
 a=WPfqd54fenyeUHfFuCoA:9
X-Proofpoint-ORIG-GUID: yas1lpgHgOQy55FXf5RyvzpOVRgJkKrS
X-Proofpoint-GUID: yas1lpgHgOQy55FXf5RyvzpOVRgJkKrS

Sync with libbpf v1.8 [1].

This will enable support for the layout btf_feature.

[1] https://github.com/libbpf/libbpf/commit/dd92bef7f6c7a00bb0312554119b6d9cf38e4f32

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 lib/bpf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf b/lib/bpf
index 374f780..3d451d9 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit 374f7807e197ff35b5c234478e89fddd03e6d0ef
+Subproject commit dd92bef7f6c7a00bb0312554119b6d9cf38e4f32
-- 
2.43.5

