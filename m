Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7C64C6C
	for <dwarves@vger.kernel.org>; Thu, 10 Jul 2025 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164208; cv=none; b=Iipdik1Lxz3saDoMdEXrZjKoo3ZG7EQ5Ktep0cTp+atYIYDp0Lsf0fK2tS1vEgSnTImtwEcIINTF/BRxkZRQR7N6iPuymEnABE3iVosXBo3lzBEy51GIzk18uihW/lqxxr5/TV2dcl1FcGTnUUXu9sxwJ1sDSh0MOgTKzfVChlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164208; c=relaxed/simple;
	bh=A2le5iYh1ok6I5FY/LKg3gwLNHh+oubVtv6jcYrdTfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7/pJLlwBy1E6lMs6rigkihsBoSkL6e3Rn6fxjV4GvOXWsMrFRx/r8JLMtFUDRNvqL1KPJPl2k3szg3+l3703aQndjtFF3zu/9cFd1QO4Mg0dhuG1wMijtbZqZlxj7l7NW/3pn0D+Tsr/byNeSvgMKiI6jjqgxvJ9+cafA7g9t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MNS0aYK7; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MNS0aYK7"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AF7R8L008448;
	Thu, 10 Jul 2025 16:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=iAg3h
	t1/kAQRGg06zeM2i+u6hJXqbNGa7qtyDvIOLIs=; b=MNS0aYK7emgNXjtrWJXfI
	0RqAAYfmRubAPcQD03qneKg1FoAz1gEwN/SMnAG7Hx19cKbydgb0WwaSCGpwOYJD
	Uc9rf8ZKDcmsq1vxrm02cyNzj6xXjeuWqBhA14UakCmcN8AIA58ZI+X87lohPFfb
	uit23ewg9g8nNRF4RmLX0MvlE4cnrLjIz840j7i/8MXwKlNu3qB7wzYF9Ay5KcX/
	PteSdwQySK3srJue8xGCxeQR1R20xie1GTxqtl34IOgNiUW6eSb4fQ+r7sKCwYfu
	guzCB0NLhiZOhXLVN/cSXWSrrYb9EqCNcmZn2rv4+uVR495bIwKwkX6/aZlF/I82
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tfvd04tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:16:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AFSeiM014380;
	Thu, 10 Jul 2025 16:16:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgd90yt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:16:36 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56AGGY8e015053;
	Thu, 10 Jul 2025 16:16:36 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-49-129.vpn.oracle.com [10.154.49.129])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ptgd90wr-3;
	Thu, 10 Jul 2025 16:16:35 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: ihor.solodrai@linux.dev, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 2/2] github CI: Add comparison of generated BTF functions between baseline, change
Date: Thu, 10 Jul 2025 17:16:32 +0100
Message-ID: <20250710161632.191304-3-alan.maguire@oracle.com>
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
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100138
X-Authority-Analysis: v=2.4 cv=Ydi95xRf c=1 sm=1 tr=0 ts=686fe765 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=7jA8ekmyfC8sht671ToA:9 cc=ntf awl=host:13600
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzOSBTYWx0ZWRfX6KMX3oj7LSK0 Q9lR5EcVcW/akjX8VesCquX4ANTE/Et4AlSH8u+4u8+CI8FK8SaPG5uAvJ7+Ap/KvxRscD3w20B 9kLiwWYTKDtGm5UIxPza9weCQA+fOzJOyZgBd13AG1a0WDU1VsEgzM8WGy2d2ZPSwsbLy3ewEAb
 hLcuTWqfgV0Q8JtPZbGR2pPq21/ISMphXov1HqNZA8sH4/PmAo0kCLi/wI2xrUZahyffu5FPh0W 1S7tR1Gen8iE1/TtAEUlrU6iP05sAu5Nz6HkGcrrwwkHVnws91NUB4VziPaqnp3N1s8VL/umF0p chlB/wN0MRZZTTnp6hBDWpyWtam6BAAwiB/cAH90S1dZJmSqogIbArZTGLg0LYTvYXVxtlshSTt
 lez8TNmVPEJEZCzz2rHBhsMhtOFOhN4EyHG2FlfAIqN3GXmhVSmIJQt1swc3ZRHG0GEqbAx9
X-Proofpoint-ORIG-GUID: UjZyxA87uyFPTousNraRDRvNNXkn6Yji
X-Proofpoint-GUID: UjZyxA87uyFPTousNraRDRvNNXkn6Yji

Sometimes changes can be introduced that modify the set of functions
encoded in BTF, or change aspects of that encoding.  Add a non-fatal
comparison job to compare between the change and the base branch,
by default the "next" branch.  Update the build-pahole.sh script to build
baseline.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .github/scripts/build-pahole.sh      | 23 +++++++++++++++++++++
 .github/scripts/compare-functions.sh | 30 ++++++++++++++++++++++++++++
 .github/workflows/vmtest.yml         |  4 ++++
 3 files changed, 57 insertions(+)
 create mode 100755 .github/scripts/compare-functions.sh

diff --git a/.github/scripts/build-pahole.sh b/.github/scripts/build-pahole.sh
index 64f9eea..7a37771 100755
--- a/.github/scripts/build-pahole.sh
+++ b/.github/scripts/build-pahole.sh
@@ -4,8 +4,16 @@
 # Copyright (c) 2025, Oracle and/or its affiliates.
 #
 
+function restore() {
+	git checkout $SHA
+	git submodule update
+}
+
 GITHUB_WORKSPACE=${GITHUB_WORKSPACE:-$(dirname $0)/../..}
+BASELINE=${BASELINE:-next}
+
 cd $GITHUB_WORKSPACE
+git log --oneline -1
 git config --global --add safe.directory $GITHUB_WORKSPACE
 git submodule update --init
 mkdir -p build
@@ -15,3 +23,18 @@ cmake -DGIT_SUBMODULE=OFF -DBUILD_SHARED_LIBS=OFF ..
 make -j$((4*$(nproc))) all
 make DESTDIR=../install install
 
+# save sha to restore after building baseline
+cd $GITHUB_WORKSPACE
+export SHA=$(git log --format="%h" -1)
+trap restore EXIT
+
+git fetch origin ${BASELINE}:${BASELINE}
+git checkout ${BASELINE}
+git log --oneline -1
+git submodule update
+mkdir -p build.$BASELINE
+cd build.$BASELINE
+pwd
+cmake -DGIT_SUBMODULE=OFF -DBUILD_SHARED_LIBS=OFF ..
+make -j$((4*$(nproc))) all
+make DESTDIR=../install.$BASELINE install
diff --git a/.github/scripts/compare-functions.sh b/.github/scripts/compare-functions.sh
new file mode 100755
index 0000000..cbe6596
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
+BASELINE=${BASELINE:-next}
+GITHUB_STEP_SUMMARY=${GITHUB_STEP_SUMMARY:-/dev/null}
+
+export PATH=${GITHUB_WORKSPACE}/install/usr/local/bin:${PATH}
+which pahole
+pahole --version
+cd $REPO_TARGET
+pfunct --all --format_path=btf $VMLINUX > functions
+
+rm -f vmlinux vmlinux.o
+
+# now use baseline branch of pahole for comparison
+export PATH=${GITHUB_WORKSPACE}/install.${BASELINE}/usr/local/bin:${PATH}
+export PAHOLE=${GITHUB_WORKSPACE}/install.${BASELINE}/usr/local/bin/pahole
+which pahole
+pahole --version
+make oldconfig
+make -j $((4*$(nproc))) all
+pfunct --all --format_path=btf $VMLINUX > functions.${BASELINE}
+echo "### Compare vmlinux BTF functions generated with this change vs baseline (none means no differences)." | tee -a $GITHUB_STEP_SUMMARY
+diff functions.${BASELINE} functions | tee -a $GITHUB_STEP_SUMMARY
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

