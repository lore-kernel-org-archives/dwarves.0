Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DB525F963
	for <dwarves@vger.kernel.org>; Tue, 29 Apr 2025 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956554; cv=none; b=JjU4v29v4dQ1hMxkmEhuknVYOR3NtF/2ui/ixZkVqy0Y6bGZyi64ieQ0XpxqWuyvEOGfMrbcvdWg4ybZKXEhSqlgxDEG1JWrzbfX0KziLI+jfdQeN6phLM9iS+xnyn6fVsyAAMXvP1aXVRxk+AHNnJLWq4Bi16+L/OHdrDoZysE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956554; c=relaxed/simple;
	bh=Fc/t64XtTmmVl8Z7kCH0pPrwFcnljt6NuwaMj08NlIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YxaWFIPYMD5m1sHl42jEmv5TS6OXWtODz9WhozeA8S9pPrEuojpsVDdRdDWnCl5f/PyJ/+sBgUnShloW9WRG2FZeAJXwP5WXGsz/Adb9It3bkV4yzO+f9rMIIT8nE8dMJk0ygRo0VTEMeYSVoUpGyyhEQ/KbKZ3ooI22y6VrqKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VYO6T9fK; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VYO6T9fK"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TIWBJS022352;
	Tue, 29 Apr 2025 19:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=D68fchtuKX6lb8wXWfPyWvUvn/eoN
	1vKL9jegQctk98=; b=VYO6T9fKCeAscpI1yWMPR+VYQ+NwR0YrvsQjzolkwP5Ki
	mkO0RBdFuradqkW4+D5YMu5xfRDQ3AFAcR1fYVa8hKgiuHO8jDqhF2zHw5qbA/Nu
	WsNdlMyZ6uyVdByxnM16wiFM7fAh8qeQqiTIEgnJ8oN79z2onisyzQZUHg92tO1g
	2X3gbNK7p/kApnUXQR7XR421Ud5huFL7voF+7lX5j4LnkO9Sap9zLM+1k+o8JY+m
	n9+j498P1O6SI58fdreuuoXjcI2PistJMe/HUM1pbOxJgFdBfWMSkIMFU5XloaqI
	euUyQmlI5rLXIPnURR4mWMIs/3+p64X33mCRzG7QA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b44ng5d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 19:55:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53TJZPlW013769;
	Tue, 29 Apr 2025 19:55:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxacs4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 19:55:49 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53TJtm2K014842;
	Tue, 29 Apr 2025 19:55:48 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-61-185.vpn.oracle.com [10.154.61.185])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 468nxacs3e-1;
	Tue, 29 Apr 2025 19:55:48 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: andrii@kernel.org, ast@kernel.org, dwarves@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH dwarves] pahole: Sync with libbpf mainline
Date: Tue, 29 Apr 2025 20:55:46 +0100
Message-ID: <20250429195546.2194549-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=896 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504290146
X-Proofpoint-GUID: 5cpSt6bsDR947NDeG5XnVXFbXas0yiFF
X-Proofpoint-ORIG-GUID: 5cpSt6bsDR947NDeG5XnVXFbXas0yiFF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDE0NiBTYWx0ZWRfX5Hc0lXb+GTht H2lptDfLWPP44ABQtff6cKEccHMphvfZWtd/lNLlOt0EkA0XF8mhk5F1J/1E+uC2/U5gAn3CmSm LGMl7ysfGYq+Dl+ZRVdpv2AzyE1Ic0rcNrzJOETLJd3TIPmyTQK/KyeIuyBdU1IadGWQXXFQIY/
 mG54IGKZXKscDfMlwtTEk67FchU+RwygQkksoycK1HFFE2A1fVywR05KiR1LmtI6CqS53/yShAm z7wyfh/7Zme9vtaABqNxekAcJVrl3iOPHpdYOKrpqBaTHuKibw+KdApXgCVgum41QJsGLoMW4hT 6lIoeYRBoyJEN9w9OYukfYc4U8xKpbggIxAn8PqFBiJ3YV6FX1+NVLZR8gs2ALH5Hy+iFlSGWY6 cGB6X/88
X-Authority-Analysis: v=2.4 cv=KdDSsRYD c=1 sm=1 tr=0 ts=68112ec5 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=XR8D0OoHHMoA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=2oB62JFmLoi7h6HWMeMA:9

To pull in dedup fix in

commit 8e64c387c942 ("libbpf: Add identical pointer detection to btf_dedup_is_equiv()")

sync with latest libbpf.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>
---
 lib/bpf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf b/lib/bpf
index 42a6ef6..374f780 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit 42a6ef63161a8dc4288172b27f3870e50b3606f7
+Subproject commit 374f7807e197ff35b5c234478e89fddd03e6d0ef
-- 
2.43.5

