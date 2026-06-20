Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C95433C52F
	for <dwarves@vger.kernel.org>; Sat, 20 Jun 2026 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781944263; cv=none; b=LN4Dv/c6EoWlo+BNxMBaCEEDB0d0GsZIQRIYxfRbL62eBPZjN2JB+UhBmBoRjbetoz4dJY8Ai4SoFza8avTbb8WRNdlWB1buLT5bM8hfPzwOX9Vlnqwm2lpLB7pfS4VNat0rPJi7N/i24k/F9bHr1MlpSCtMoBrq6K6dGs4IZ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781944263; c=relaxed/simple;
	bh=ZPwF4TalCDM5lP1EPoXM0yfuMioYxJXE/Ncw3MEuPB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PJfpo/w2WEUtdpRWiYTFwdScc5Uf42D6d4eDkuqzUXar3sCKgitRDMTxAoV9iFwUS0KtKzgSZVZEXrlOEJZbE2GSrLoDm6+m22cx+TGi8cvzpWFk1I8iEycVVXGnJZUU7cRi8/5E/fAgJY/WoFBHIMJPpWNt3j2Q8H+5BrzO9zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EL45BQJh; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EL45BQJh"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65K8Cui1622617;
	Sat, 20 Jun 2026 08:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=mFJeJ4JQrgT4B1JcuhWEARngZ8w5y
	ywM6i4HTR9CM/I=; b=EL45BQJhogA93QS67nYPIKlbMM8M6SycKmw29qMQkXgV9
	v/ha4B+BzG/smPQhcKPHz9zo7oK7imS8bU9ZxFY5ik1y+C1KvJdNdbpC7UZah0JD
	ZSL+lkg0kU89UutJ8Pd8jpZ/qjDFjXfvoGRFNiTgRASzYEp9PXG9VT999BGUNrI8
	qR2QSa6rKKajHNeQUCMZyKrAXAFFHigi+qQwagMvSkH3Uk/DZgwYNrNwyb3msola
	0ec73fTtYBCPhwfB7GOvBYFQONSZOI3Mve8PrQJfE/l0RY2E386FSRH1O7kqDTnp
	cxdDhCFyew4yaY1Upd3W0ZQ8fvLmsDWt9IB5U2RCA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewh9c04r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jun 2026 08:30:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65K8SSct029206;
	Sat, 20 Jun 2026 08:30:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ewhame9ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jun 2026 08:30:58 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65K8UvOJ034250;
	Sat, 20 Jun 2026 08:30:57 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-58-80.vpn.oracle.com [10.154.58.80])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ewhame9ae-1;
	Sat, 20 Jun 2026 08:30:57 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: yonghong.song@linux.dev, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves] CI: add clang+aarch64 to matrix
Date: Sat, 20 Jun 2026 09:30:56 +0100
Message-ID: <20260620083056.361658-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-20_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606200081
X-Proofpoint-GUID: GoxmTUrePnmqGsMjsApu5yqu8GX7RHxp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIwMDA4MiBTYWx0ZWRfX37ThUFq0Pnlq
 2x5zOVRLx86mpk394vuU3em4RFmkQ1l7pLjllEzR5vDhVfGRR7M36ub9itsUWAy3lvMs2A8jCqx
 T4N00f7Z8DWlwztWXgHRHTKrQOk5o0OQfu4KGblSCA+ytmvNmfFX
X-Proofpoint-ORIG-GUID: GoxmTUrePnmqGsMjsApu5yqu8GX7RHxp
X-Authority-Analysis: v=2.4 cv=Rd+gzVtv c=1 sm=1 tr=0 ts=6a364fc2 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=nu1Gbx4GvDcpwsD1sbAA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12312
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIwMDA4MiBTYWx0ZWRfX/BWGkKiD3x4E
 2YUXcvenxEEZiFI/Unz4U2Ql1U5qlnqSAQM76dLWSqJebuLg0561Nhxtkqk9Lv7wE3pzt3zIaMd
 2qtAeoUvXX6ldg4Uxl+z2rg5j9WyvM4VrtVxb438KrmwzTMlH+rBygaHBtbdxLKdeLHEzfMFYDY
 i0KGMTLSnm6V34VrNL7ImYZJpyASVEAmbczPLc7iE9uueLvkSI8PRRsT3H67mltIcGj+v0plMRK
 gyZlM30CYUw7Yf80ONkOobYexCOMiGw+oL6/I3Zb85WcQ/HCbZtHpi5AXrbABqnbZ0NjnXLZgqW
 5sVM+lHhvxHUmKma4xqQz6KSp28oz86GkgfcGgmQoNdX84y+pwK/fD8Ydcj498pT/yCdifUixAj
 6FdA/qfkDo2eOvQD/2TnkbLh/bSyBQhcXKkYgc2oGEyjH3hvi44gI2aTU8Yrq1i0M6OiVMZ+bpe
 sHa+nITO1110CwGlR2aBqkFiumNRYgtBmzbX0B5Y=

Need to test full matrix of gcc/clang + x86_64/aarch64.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .github/workflows/test.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.github/workflows/test.yml b/.github/workflows/test.yml
index f47cc4a..a81aa55 100644
--- a/.github/workflows/test.yml
+++ b/.github/workflows/test.yml
@@ -34,6 +34,12 @@ jobs:
             llvm-version: '18'
             pahole: 'none'
             cc: 'gcc'
+          - kernel: 'LATEST'
+            runs_on: 'ubuntu-24.04-arm'
+            arch: 'aarch64'
+            llvm-version: '18'
+            pahole: 'none'
+            cc: 'clang'
     name: Linux ${{ matrix.kernel }}
     uses: ./.github/workflows/vmtest.yml
     with:
-- 
2.43.5

