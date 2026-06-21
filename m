Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF16235BE2
	for <dwarves@vger.kernel.org>; Sun, 21 Jun 2026 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782046718; cv=none; b=n7rrUKogqx7lb5vWYIiVop+WYRvCjoAquWKldOcqZnQeaUlCfQOuj43N1kTTo2LA/QiOxfP3ytzbUGa9emv7+wTH9CGA7mojrKc3yTrCprh50C0SjWe7IBF1PN7xC7P1n4YdMG9y2uCUqbmROG7g5zLI+f6YBIanaaaxCGHrxdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782046718; c=relaxed/simple;
	bh=tV4gc/Q4QnjQS8e5JFllumKbOlnqxOh+KKIRJQL3/2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O2loF1fuqZFYwS52/TburSwo4QZntD5Xq+fBFhAdvfaaIXB/lsQmlbSU9VjjBbarx0vaGqp5MNZnP7yK4GPJUfKrt5seO4sX0rcylrQO75CHSBgv+DIsiVVV4BeIpyGQPXju7q6PQ86xcYa1xoC+/XJPCGv9DgkqIQfXn8Ib6/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Po0ouMAR; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Po0ouMAR"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65LCe2ea3449997;
	Sun, 21 Jun 2026 12:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=6qsm4Fg2T2ouCOGwvt5x49pEBq/WH
	KADPfsgj/EOXO8=; b=Po0ouMARxlr1eU2umvSpqF0OGtRnqTDLhjbhh3OTMxZzo
	Qdd4HoyHeewMwaS+Tc4EdccqTipZ91Lfw3cr3vymC3GjMidOhpgPaAPT9Ttq6U32
	JTVqc3kI/MZe99DejCbTF8dufS58Dj9lKEBJhw3LgMMbeuKm15I4dpawGIgOSAPF
	Q8pK4RkSakDvlkYCjBcAN3GHV6fRXgTQWSTVyJ57FstjA2VJ/NmGXLylVeCa5Hw+
	Wam8WxexZ5RKDqG6gV+D2tHYupNKb6HLpDCmWavQOCeyYuvK255X2PK7kCtHDKI8
	2goI60zReTXFAGZX7REgJQmg0mVALQzveKtZdKfQQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewhf1gvh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Jun 2026 12:58:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65LCwTuE018310;
	Sun, 21 Jun 2026 12:58:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ewhamv4d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Jun 2026 12:58:32 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65LCwVXa018575;
	Sun, 21 Jun 2026 12:58:31 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-57-160.vpn.oracle.com [10.154.57.160])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ewhamv47c-1;
	Sun, 21 Jun 2026 12:58:31 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: yonghong.song@linux.dev, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves] CI: Update llvm version to 22
Date: Sun, 21 Jun 2026 13:57:45 +0100
Message-ID: <20260621125745.34985-1-alan.maguire@oracle.com>
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
 definitions=2026-06-21_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606210131
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIxMDEzMSBTYWx0ZWRfX5B9kRNXSyK0w
 Aq/j0ZuJrxVdFgSfaH8+e5nBCxZRBPbC9jrAoUlmtfjC5zf+43I/U8SDImN5KmTtKnY/NBB1XJ2
 2oT89EENgBNreQLAt5t8KaFi/20LJ5lMf6j2qxakgTfnzlKTfSQSVOsOLRPpHKtaayu4fSMfsTF
 ZWfe/VNpWTtfpff5+tIGp1Sj58t9TcMhWpowHXH6ZCujpthwbHrcp/vN62Q3gLyHte3rVQWu7w4
 peZgiaBQ2UYxPdji10UYIULepxfzNyuxrhwNPAp+mwpxjtcPZXG9yZbfg3etbzLFlwsmiPghd1e
 MmnBSWxvR7+/aKp5rAiXBaUgYpgA3QUHEP8yJid6EtH0AEUtxo7vZq2mKhPA9AueE6QnmpjZd79
 3dm4TLvzfm8dYiwcNXbZVoe3glkxk9RD29kLzxohkZkk7uA94JD1fHTRqLdAbSeTcWOaOcg1j0T
 5KrMFHuNcc6bcBfxfeYrE1I4iZnUijjh/034YD9E=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIxMDEzMSBTYWx0ZWRfX8lzuVZrpYN58
 ixFvLGRWuFD9oAbswxDo14302Pix/yp/Dwh6kDFM3tKQ+AczQ38CcFg8B5Bkn1vPn/1ZeHt8kqm
 WIPP2dc29TNyzHH8iKBJJjEGedWqxtsJeEtm7TFAiLLTo5UzTIhL
X-Proofpoint-ORIG-GUID: o5skVA5tUDuofxFX4zqGKq_HNsVnhume
X-Proofpoint-GUID: o5skVA5tUDuofxFX4zqGKq_HNsVnhume
X-Authority-Analysis: v=2.4 cv=A+lc+aWG c=1 sm=1 tr=0 ts=6a37dff9 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=Hc93bnaS0I2autGKhfsA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12313

Best to test with most recent available version.

Suggested-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .github/scripts/build-kernel.sh      | 2 +-
 .github/scripts/compare-functions.sh | 2 +-
 .github/workflows/ondemand.yml       | 2 +-
 .github/workflows/test.yml           | 8 ++++----
 .github/workflows/vmtest.yml         | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/.github/scripts/build-kernel.sh b/.github/scripts/build-kernel.sh
index 9f11b22..63806f2 100755
--- a/.github/scripts/build-kernel.sh
+++ b/.github/scripts/build-kernel.sh
@@ -10,7 +10,7 @@ REPO=${REPO:-https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git}
 REPO_BRANCH=${REPO_BRANCH:-master}
 REPO_TARGET=${GITHUB_WORKSPACE}/.kernel
 CC=${CC:-gcc}
-LLVM_VERSION=${LLVM_VERSION:-18}
+LLVM_VERSION=${LLVM_VERSION:-22}
 
 export PATH=${GITHUB_WORKSPACE}/install/usr/local/bin:${PATH}
 export PAHOLE=${GITHUB_WORKSPACE}/install/usr/local/bin/pahole
diff --git a/.github/scripts/compare-functions.sh b/.github/scripts/compare-functions.sh
index 48fc086..fdc9aae 100755
--- a/.github/scripts/compare-functions.sh
+++ b/.github/scripts/compare-functions.sh
@@ -10,7 +10,7 @@ VMLINUX=${GITHUB_WORKSPACE}/.kernel/vmlinux
 BASELINE=${BASELINE:-next}
 GITHUB_STEP_SUMMARY=${GITHUB_STEP_SUMMARY:-/dev/null}
 CC=${CC:-gcc}
-LLVM_VERSION=${LLVM_VERSION:-18}
+LLVM_VERSION=${LLVM_VERSION:-22}
 
 export PATH=${GITHUB_WORKSPACE}/install/usr/local/bin:${PATH}
 which pahole
diff --git a/.github/workflows/ondemand.yml b/.github/workflows/ondemand.yml
index 5f3034f..6e48e12 100644
--- a/.github/workflows/ondemand.yml
+++ b/.github/workflows/ondemand.yml
@@ -7,7 +7,7 @@ on:
         default: 'x86_64'
         required: true
       llvm-version:
-        default: '18'
+        default: '22'
         required: true
       kernel:
         default: 'LATEST'
diff --git a/.github/workflows/test.yml b/.github/workflows/test.yml
index a81aa55..940dab1 100644
--- a/.github/workflows/test.yml
+++ b/.github/workflows/test.yml
@@ -19,25 +19,25 @@ jobs:
           - kernel: 'LATEST'
             runs_on: 'ubuntu-24.04'
             arch: 'x86_64'
-            llvm-version: '18'
+            llvm-version: '22'
             pahole: 'none'
             cc: 'gcc'
           - kernel: 'LATEST'
             runs_on: 'ubuntu-24.04'
             arch: 'x86_64'
-            llvm-version: '18'
+            llvm-version: '22'
             pahole: 'none'
             cc: 'clang'
           - kernel: 'LATEST'
             runs_on: 'ubuntu-24.04-arm'
             arch: 'aarch64'
-            llvm-version: '18'
+            llvm-version: '22'
             pahole: 'none'
             cc: 'gcc'
           - kernel: 'LATEST'
             runs_on: 'ubuntu-24.04-arm'
             arch: 'aarch64'
-            llvm-version: '18'
+            llvm-version: '22'
             pahole: 'none'
             cc: 'clang'
     name: Linux ${{ matrix.kernel }}
diff --git a/.github/workflows/vmtest.yml b/.github/workflows/vmtest.yml
index 147b608..d6f9f79 100644
--- a/.github/workflows/vmtest.yml
+++ b/.github/workflows/vmtest.yml
@@ -25,7 +25,7 @@ on:
       llvm-version:
         description: 'llvm version'
         required: false
-        default: '18'
+        default: '22'
         type: string
       cc:
         description: 'compiler'
-- 
2.43.5

