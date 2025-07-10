Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93DF2749CD
	for <dwarves@vger.kernel.org>; Thu, 10 Jul 2025 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164207; cv=none; b=R8roRkkluyMXFUsN0G1aCGMVvw6HTigm1XKcy3ETbZyYuqNhq7JmNlwu9lJ4UfWsRqGYf9JqvbRsncx+Vfj3omVHGI/UoRgehO6gv5BHJ4bhQGrhRpYlSFB6zeQnO5OkqQPQ8xGTPIVGlwIZCg95tp3vVhI340Cb2PV2ViekP5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164207; c=relaxed/simple;
	bh=/wwZSA3Xnj9JRaErTajRPCJsxDjaDbg38uV7gRKxQf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDVU9/chw1z3btbOuc8SL5VChZVQkNzBAOpg33FxkpieAxCf6FZlvai1KLM9Y2cM4RaCVpsfgOcPZv8MgpS1N0TtHdRhIPAA4Ih4gAw0DuYoydBimJINDw0nVodjxS2OeqeBcJvO6EXFp2e+pAqNoB7HNFKTIauYOBTa0tyXwPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jbDOuUvf; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jbDOuUvf"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AFppqo022194;
	Thu, 10 Jul 2025 16:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=RKese
	umFQaWLi1FOzFfTFSfq2U37P8YTqA+gIqzSWdk=; b=jbDOuUvf2TCCV6NbVnSi3
	VE+ERJbiayz+BZBI/90hKEOq9QafE/6Q+8a4n7cXvwjrZaq58cgRIp8ESFZgWyBR
	NEWH76YABwvSUzCLor7Tv4PauU1KYV5EYKQp0mxlz0Zr9O7yubytH+Pu7X51dn5z
	vihBj4vhs/rh7N5pCqT31010XKuO28gwsD9vwrEvN39Q/dymqEriypeHo6ZpvMTY
	JJSDUiMMWwiEIi0UmyLqu9JfXENyFnLbVbREjrXFUsjpg5lBm3DgyW2f++tAOBjc
	3JsQrKkIKvgRwsPd2tDlTKWRoebRpuKvO5yFwwFT41vpdpbx2H5ywCiGLIUUSt2y
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tghe01c2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:16:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AFseEe014260;
	Thu, 10 Jul 2025 16:16:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgd90y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:16:35 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56AGGY8c015053;
	Thu, 10 Jul 2025 16:16:35 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-49-129.vpn.oracle.com [10.154.49.129])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ptgd90wr-2;
	Thu, 10 Jul 2025 16:16:34 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: ihor.solodrai@linux.dev, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 1/2] github CI: Do not build pahole as part of dwarves-ci setup
Date: Thu, 10 Jul 2025 17:16:31 +0100
Message-ID: <20250710161632.191304-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250710161632.191304-1-alan.maguire@oracle.com>
References: <20250710161632.191304-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=929 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100138
X-Proofpoint-GUID: hs-6fqRBfzAFmpHHfLGF9yd3EUQ2qFOR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzOSBTYWx0ZWRfX1REZyMUww5KL fq4XM7D8pSZhoRYxojLPl0SCQCNaXW6pwlCbLjy79DEB/uM9ghFLKr52mlodB/jE2CaCxfKpU3S yr5AF+w4olGHVPSJ+DeUMLU+rl8mdkUWFNoqyjnUr/5L1LlDTneoJK4374nSR2O/oGPmBbH/c/j
 ebNszMqW4ZmTTM+a3V936skOzOZC9QAW8ZvOqLUHYq8PTDn4BRVH3CpFLJf+p1KN/5AwWj5xWsh gi82jKkb5XQubCN25pHJ62Th+qOS6AR8aOGCu2wRErcOCx0SihzmP9SNGlWyhpxmtmzIMGbchI0 IzMdz5zd5rq0XKANR2d4cIIkuPOMMKSsV63W59+T0OTpD+xob+m/RZlv30qWxYEh35mTh8V7bli
 BfFBcZTzpBn57nifWJ7DW3aju6pS590MKMc6F4dTsc55Os43wGMWZDK637yP3c9xHUsGpMV9
X-Authority-Analysis: v=2.4 cv=X4NSKHTe c=1 sm=1 tr=0 ts=686fe764 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=nu1Gbx4GvDcpwsD1sbAA:9 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: hs-6fqRBfzAFmpHHfLGF9yd3EUQ2qFOR

We build it during testing, no need to do it during setup.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .github/workflows/test.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/test.yml b/.github/workflows/test.yml
index f11ebfe..ac28e92 100644
--- a/.github/workflows/test.yml
+++ b/.github/workflows/test.yml
@@ -20,12 +20,12 @@ jobs:
             runs_on: 'ubuntu-24.04'
             arch: 'x86_64'
             llvm-version: '18'
-            pahole: 'master'
+            pahole: 'none'
           - kernel: 'LATEST'
             runs_on: 'ubuntu-24.04-arm'
             arch: 'aarch64'
             llvm-version: '18'
-            pahole: 'tmp.master'
+            pahole: 'none'
     name: Linux ${{ matrix.kernel }}
     uses: ./.github/workflows/vmtest.yml
     with:
-- 
2.43.5

