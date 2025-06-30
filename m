Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108561A76DE
	for <dwarves@vger.kernel.org>; Mon, 30 Jun 2025 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751278545; cv=none; b=OjVYx+tnkEJDyxiEVmX5gDq9GUZTJBwxZeTSqgvdf1pmg/34Cbo8zG6AoGuEiEY7d+6skP4zR4WRdmKgBWsYmDxsuBURxMCM03299k0sJvwW11qmdG5My/8IBU0cb56EYF2DZb2FLQA91Lml7cYYDKJQuz1fEMNC1/3uo+NF0T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751278545; c=relaxed/simple;
	bh=zowPXZj4g1ZjgdBIPWpQ3YtPHZTYI+uQ+knj7aRfNas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Idut5TNCSbeIs5+api2rapRQnZrDdML4BfYCw/MYhXp3s1WTUaqZAk7qaDtwSXYzxZMriz8zG+snnct0LPZxgbPErmkTiU+kvqq3XIHXm8iK1cuX/DPfluxXU5bRv9hr2p6IKZ/oPpSabopix++/fNE3yrKpJVWk9vNLb3gWC/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zuaaw4YQ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zuaaw4YQ"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U84ffk004453
	for <dwarves@vger.kernel.org>; Mon, 30 Jun 2025 10:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=s1vDM
	QFbo1Q4nkH22QOb5pRUX7DvJMfxhwyKCTg6KdE=; b=Zuaaw4YQznmidYaPyGyD5
	+jads/fXs0VTNoIc/1ANfLxqb5g7ortevmWxl7PxymIM1p8cwr5nkU1/+ANZJUzz
	sLzolkU12TzGBBi85FuQsKVNA6XeS4JgPEFXPjWqYoOMeplcMuEV74JqBCg9NGHj
	6X06Nhze4AdcsGkBHIXxdbK4/78XFKJPzB+BKxAghLiwNQI1eGDmgHxduy/CWkR3
	U3V2M43qx5sKcnD5tfyrC0/i0Nw1qsgeZiTcsfwyvNhkoIjYt/pkPOSrVT4eH0Mp
	bSz/PejYg08f+V3CfrEJAmMqJoimgll8ITQmXnSJOJrlwLd9Zd2+xHCLAMBXPxnu
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j766a72x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Mon, 30 Jun 2025 10:15:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55U9KE0W017084
	for <dwarves@vger.kernel.org>; Mon, 30 Jun 2025 10:15:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u7wb78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Mon, 30 Jun 2025 10:15:41 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55UAFdgd009159
	for <dwarves@vger.kernel.org>; Mon, 30 Jun 2025 10:15:41 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-61-18.vpn.oracle.com [10.154.61.18])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47j6u7wb4w-3;
	Mon, 30 Jun 2025 10:15:41 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 2/2] github CI: Add comparison of generated BTF functions between baseline, change
Date: Mon, 30 Jun 2025 11:15:37 +0100
Message-ID: <20250630101537.2680289-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250630101537.2680289-1-alan.maguire@oracle.com>
References: <20250630101537.2680289-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506300085
X-Proofpoint-GUID: YrH0p5c1Ci5hNCu2kwqCJwF3AQ1pP6i-
X-Proofpoint-ORIG-GUID: YrH0p5c1Ci5hNCu2kwqCJwF3AQ1pP6i-
X-Authority-Analysis: v=2.4 cv=b82y4sGx c=1 sm=1 tr=0 ts=686263ce b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=8QxxSIgSw6Lib4SkgnkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA4NCBTYWx0ZWRfXyajDVxzve5Rg V4pnBy/57lcVp3BkMGl0vvOYFycEcfpScu/4rOpMmDBJHYA0gKYGZtMgA8HZ4rl635bht96rQAI xXVi9gAda5hZniBv7i4rI4qRmC4gXiFDeLTCah7d6Dbv2fpDWzYGwxMKpJh8wA8MbGt1VuoQ+wQ
 G0DLrjIibTPGzW6Y7f31e487vSc7M5geBymxkFNwCR3V4bzgfOUabQ7AoWHN4BVw5Rez/yA9ufC c4fPdudwCXNWGH6pikuI73dQWx6BEHRoUcX/RZRqDd4xi+JVPlEQPRkkOApqFFIuHLd+fWry+DX yxhjvBLA/+wDtE1TKt5hxxSaRrouU0pRhEpY3TCpsNsVbY1qnXFC2ghwDoboCIQUJGAr4v9aJyz
 L0m7NjFBxE8GTW5hRnYbNlvHpJBfteDyrPJ8xNsNGV4jhfs2G/KRnOVrr5qov4yJjy14mwAY

Sometimes changes can be introduced that modify the set of functions
encoded in BTF, or change aspects of that encoding.  Add a non-fatal
comparison job to compare between the change and the base branch,
by default the "next" branch.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .github/scripts/compare-functions.sh | 30 ++++++++++++++++++++++++++++
 .github/workflows/vmtest.yml         |  4 ++++
 2 files changed, 34 insertions(+)
 create mode 100755 .github/scripts/compare-functions.sh

diff --git a/.github/scripts/compare-functions.sh b/.github/scripts/compare-functions.sh
new file mode 100755
index 0000000..062f15c
--- /dev/null
+++ b/.github/scripts/compare-functions.sh
@@ -0,0 +1,30 @@
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
+export PATH=/usr/local/bin:${PATH}
+make oldconfig
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

