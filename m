Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A46F307482
	for <dwarves@vger.kernel.org>; Tue, 24 Jun 2025 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750779680; cv=none; b=JOFFgSGQ2FAvRWhl3Bb7qaN6f2Qnf+HlIZrAjbdTf+ZVL+Nb6wAIz35cmLiUnyh4TxsUg5LmtWmLaTAUUrpMZ/eaVHeCzNOzNQTlaSBfsFVAqodX1s9RwdYeJxybx4O6ipRoveaet1ZrIhvBUZ9Tq4xRYU1WuXtkwp3Upm4Mckk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750779680; c=relaxed/simple;
	bh=DINHZ0mk1zYF3Do2+8yBSBtUKaIPXi5dozKmarg/MYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ln1H7sx6uZt8YhAGyJWf6BhMhiWuZ/XFtF0XR+GWRTw/jA0H8QtAN8qeiJz76zxOIZJ1xIqRDpQ/JaLa4SJfpK1XRr/nik6CWWJzCYBBErxGYnvEJptTZmn503IJdIpiRzib93hT9iDCVUtwrAw7xiD+nuT7uDU1fpAmOhUhdRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qxk0WK81; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qxk0WK81"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OFN9mo020350
	for <dwarves@vger.kernel.org>; Tue, 24 Jun 2025 15:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=guLw4
	neDQ+qrllSLS8xStga89iT9AhBp6vI8pgTobNM=; b=Qxk0WK81KpCtBx6VHEEeR
	OZzR2U74SU1+0+JF+rr4R2igYKZb22J6YlHB0dZMTHZ1x1Cv6RXeQWJezbkK7pC8
	1WY0mSZP4ZBuExoER9ijn8kWgEUGeNTpVWEnYPhF68pR3GMMKL4KincyuA4V8bcH
	ZkboBIdk7O24kwZwAKt+l9WhGOv8+qyS5HFiemWOL41taPw7BPVOb18rKK1svMcx
	IdC6PmB0eVCZmBcAE2qN4HJ8xbpeEWlzkKU0RwIKtAGnecTd/kSLqXDniTpwXOmj
	1+QIIX/NAHHm2i0eL8qoHdIaee4I1jij50o9hGXy6COvtVUB2FNtiFTSYD+jwqeq
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds7uwg4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Tue, 24 Jun 2025 15:41:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55OF0XsK031313
	for <dwarves@vger.kernel.org>; Tue, 24 Jun 2025 15:41:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehpq9yur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Tue, 24 Jun 2025 15:41:09 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55OFf6Lo029846
	for <dwarves@vger.kernel.org>; Tue, 24 Jun 2025 15:41:09 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-59-22.vpn.oracle.com [10.154.59.22])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47ehpq9yqs-3;
	Tue, 24 Jun 2025 15:41:08 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 2/2] github CI: Add comparison of generated BTF functions between baseline, change
Date: Tue, 24 Jun 2025 16:41:01 +0100
Message-ID: <20250624154101.163662-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250624154101.163662-1-alan.maguire@oracle.com>
References: <20250624154101.163662-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506240131
X-Proofpoint-GUID: R75-PioU1fKS4nx7aDV5J_BN9dbSVJzX
X-Authority-Analysis: v=2.4 cv=CeII5Krl c=1 sm=1 tr=0 ts=685ac71c cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=8QxxSIgSw6Lib4SkgnkA:9
X-Proofpoint-ORIG-GUID: R75-PioU1fKS4nx7aDV5J_BN9dbSVJzX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDEzMiBTYWx0ZWRfX4jYf9rfdcT0D YvtzT904QD/Z+4pwZj/yoHfxdbUZdYOjX9Ue3iaX+VI1tGFOZU6PQixYlbMQPKZ4UfyAuCPhTId lzj+nWTaG6QL747sRofcRfcHJZvNZuBjGchroT+GjrOXo0HLQovvQU+9Bdkkoo/gzItAbTYxPc6
 Y9p0nyblxsKQPr9svZF/HgwVTuUIf+4wNLu9cjoxuLBvrbAdOH3urldA1NMYc/iMlqyopSaMheG 951Qw/bXbVnxZjckRnkp3lHiz0golYt61u6nHXlh9uFo4ZaBPY0yWqfh870CQGJADnDOZFl5pXa Cns+zjS+9Sg8eAKBVLmgdixyx78LaPRMPg1hHte/ChyQk+hGhCBMtxU57VVZ6i0X1b5qh48bW1u
 1LtEvYlwtn310gV1t6ijH9N8dgWrdqx8B9KNCzmJz2A/ia6wwsKYqZ2hqZCxMe7LH/Sz6dkI

Sometimes changes can be introduced that modify the set of functions
encoded in BTF, or change aspects of that encoding.  Add a non-fatal
comparison job to compare between the change and the base branch,
by default the "next" branch.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .github/scripts/compare-functions.sh | 29 ++++++++++++++++++++++++++++
 .github/workflows/vmtest.yml         |  4 ++++
 2 files changed, 33 insertions(+)
 create mode 100755 .github/scripts/compare-functions.sh

diff --git a/.github/scripts/compare-functions.sh b/.github/scripts/compare-functions.sh
new file mode 100755
index 0000000..3c0e706
--- /dev/null
+++ b/.github/scripts/compare-functions.sh
@@ -0,0 +1,29 @@
+#!/usr/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (c) 2025, Oracle and/or its affiliates.
+#
+
+GITHUB_WORKSPACE=${GITHUB_WORKSPACE:-$(pwd)}
+REPO_TARGET=${GITHUB_WORKSPACE}/.kernel
+VMLINUX=${GITHUB_WORKSPACE}/.kernel/vmlinux
+SELFTESTS=${GITHUB_WORKSPACE}/tests
+export PATH=${GITHUB_WORKSPACE}/install/usr/local/bin:${PATH}
+which pahole
+pahole --version
+cd $REPO_TARGET
+pfunct --all --format_path=btf $VMLINUX > functions_latest
+# now use baseline pahole for comparison
+export PAHOLE=/usr/local/bin/pahole
+rm -f vmlinux vmlinux.o
+make -j $((4*$(nproc))) all
+pfunct --all --format_path=btf $VMLINUX > functions_base
+echo "Comparing vmlinux BTF functions generated with this change vs baseline."
+echo "Differences are non-fatal to the workflow, but should be examined for correctness."
+set +e
+diff functions_base functions_latest
+if [[ $? -eq 0 ]]; then
+	echo "Function lists are identical."
+fi
+set -e
+
diff --git a/.github/workflows/vmtest.yml b/.github/workflows/vmtest.yml
index 0f66eed..54bb92e 100644
--- a/.github/workflows/vmtest.yml
+++ b/.github/workflows/vmtest.yml
@@ -60,3 +60,7 @@ jobs:
         shell: bash
         run: .github/scripts/run-selftests.sh
 
+      - name: Compare functions generated
+        shell: bash
+        run: .github/scripts/compare-functions.sh
+
-- 
2.43.5

