Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4893F1E1E16
	for <dwarves@vger.kernel.org>; Mon, 23 Mar 2026 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271137; cv=none; b=Su9LvUC6piN9KkPX835SbalYX9lQwFIMf/gMUHeYX05OTMPCvYenHvKlVl9X8lnQTK6QqMANRBElGB3mAMaj47X8rBguiJrAcFnua1n96SilaL1NZ8ykCEItFRQmXpuM998MTc+f0DJO5y2WFJaAziJulU+09RkjgiUFfAoM8b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271137; c=relaxed/simple;
	bh=nukrPaJXxWbdOKw/mIZZfG6Su2lIuCKMhURD4Wk9tBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hLZY7mpaLX724voFtG65X59jKpAbs1ELc5Nh59UiF3RJyi9kzUYNKUPZm9+p5FSiLTF4Qt7Md+oXgQKWpcj6FBvd7s/f0uWJ0a2b154+a0ShOdFhtzD590v3YOXDs7qIVz3RJALVR300RoHY0VLVF3n8EEGpQSyiGdXafxgP/TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OyC1dxqN; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OyC1dxqN"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MNeUas1554459;
	Mon, 23 Mar 2026 13:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=8LXVbZMjVR9yGKwfRIbVyi2qssqRc
	qdptK4DneAIUqg=; b=OyC1dxqNLpZ6148Ukf4GLbW/vAAwEjydG7RXI/J81yihr
	8y3xX9Q+V4cP6lpJdXOcs7L/rkolG0WJTAaZwWol84JU2geB7Zs0vjhqprfv9cU0
	NE2fXrGaBBcNgakEpmZfSW01JLX+sE/wi8T1vcLSpCk0887Bsp8zbHK4XCptKYZn
	tH89UyJVruIOvG1siS1Wj2+jRyPY7WkjLrlyHG1NdBp73SiwmVfpJfYiiIW3uDLY
	woztI03HjxAxpH+Hfjl9LdnvSn+IGJ+O9ACpHeM7wdzSYGVonC2wLcp4d6UEf+7V
	jLRpMSIAl1wdZ0VYtKw+cbp+LVRCYJ+i7q6s7m45Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kfpj7s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 13:05:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62NBZ5BU039146;
	Mon, 23 Mar 2026 13:05:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hs8h82x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 13:05:05 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62ND54c7027432;
	Mon, 23 Mar 2026 13:05:04 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-150.vpn.oracle.com [10.154.53.150])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4d1hs8h822-1;
	Mon, 23 Mar 2026 13:05:04 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: arnaldo.melo@gmail.com, yonghong.song@linux.dev, olsajiri@gmail.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves] CI: support building kernel with LLVM
Date: Mon, 23 Mar 2026 13:05:03 +0000
Message-ID: <20260323130503.857217-1-alan.maguire@oracle.com>
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
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603230100
X-Proofpoint-GUID: ncLTDxez3kKzYN707VPBxFWIwITAd3L1
X-Authority-Analysis: v=2.4 cv=VKnQXtPX c=1 sm=1 tr=0 ts=69c13a81 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=dZgeU_h11kQLfw1G_SsA:9 cc=ntf awl=host:13824
X-Proofpoint-ORIG-GUID: ncLTDxez3kKzYN707VPBxFWIwITAd3L1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEwMSBTYWx0ZWRfX2jHkKk/ZJi14
 3CnXCIL5unpvJzG5ccMPq8XmFdCAVUl1B4FmV6dA7dhsEJoUo37eJ/7bdi47PY+4tMizkgPzPMB
 Zymh6I6NaZSg34Fjtis756aqtgPRz5T0nO8hQHN0C7PGgV1SAdLlMmhmJghcHJTzq01d7KeMGHn
 SIC+UtpcENkDp4pxbOZzPJVu7v516ExpgSgf/j8D542IH4ufoP7KdIzpUErW2ZE6W/v/ZiST5Ex
 MTDEnW7tgLha3Q7uTKUZichagBZUyCrEcVM9On9o8G5kFH6lAvttX2Yz57Et93TrEeapLubXMvr
 YFMDZrWI/GMxReqcGwv6yzNe64U8kEkFdvT2++YDBIrV9l9xyvRmfDwW3XHEdQRlWoGx9nGF7yM
 4wRcz3C4kwcmp5IZr5Zmk49N+lnHERgw6lL7soNb+AhyoqYMJUpYoWBD+kGFLjZgAeYmHQQhUAG
 RQi7LQn5Zwtn8iFtyIjvZYLHj7WpGwOHIqSV8i4Y=

Since LLVM true signature work will change function list, have
method to build kernel/compare functions for LLVM.

Example run here:

https://github.com/alan-maguire/dwarves/actions/runs/23435796365/job/68173414313

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .github/scripts/build-kernel.sh      | 12 ++++++++++--
 .github/scripts/build-pahole.sh      |  2 ++
 .github/scripts/compare-functions.sh | 12 ++++++++++--
 .github/workflows/test.yml           |  9 +++++++++
 .github/workflows/vmtest.yml         | 16 +++++++++++++++-
 5 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/.github/scripts/build-kernel.sh b/.github/scripts/build-kernel.sh
index 504c249..0a1fd3f 100755
--- a/.github/scripts/build-kernel.sh
+++ b/.github/scripts/build-kernel.sh
@@ -9,6 +9,8 @@ INPUTS_ARCH=${INPUTS_ARCH:-$(uname -m)}
 REPO=${REPO:-https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git}
 REPO_BRANCH=${REPO_BRANCH:-master}
 REPO_TARGET=${GITHUB_WORKSPACE}/.kernel
+CC=${CC:-gcc}
+LLVM_VERSION=${LLVM_VERSION:-18}
 
 export PATH=${GITHUB_WORKSPACE}/install/usr/local/bin:${PATH}
 export PAHOLE=${GITHUB_WORKSPACE}/install/usr/local/bin/pahole
@@ -22,13 +24,19 @@ fi
 cd $REPO_TARGET
 git checkout $REPO_BRANCH
 
+buildopts=
+if [[ "$CC" = "clang" ]]; then
+	buildopts="LLVM=-${LLVM_VERSION}"
+	echo "Building with $buildopts"
+fi
+
 cat tools/testing/selftests/bpf/config \
     tools/testing/selftests/bpf/config.${INPUTS_ARCH} > .config
 # this file might or might not exist depending on kernel version
 if [[ -f tools/testing/selftests/bpf/config.vm ]]; then
 	cat tools/testing/selftests/bpf/config.vm >> .config
 fi
-make olddefconfig && make prepare
+make $buildopts olddefconfig && make prepare
 cat .config
-make -j $((4*$(nproc))) all
+make -j $((4*$(nproc))) $buildopts all
 
diff --git a/.github/scripts/build-pahole.sh b/.github/scripts/build-pahole.sh
index 7a37771..4f4013f 100755
--- a/.github/scripts/build-pahole.sh
+++ b/.github/scripts/build-pahole.sh
@@ -11,6 +11,7 @@ function restore() {
 
 GITHUB_WORKSPACE=${GITHUB_WORKSPACE:-$(dirname $0)/../..}
 BASELINE=${BASELINE:-next}
+CC=${CC:-gcc}
 
 cd $GITHUB_WORKSPACE
 git log --oneline -1
@@ -19,6 +20,7 @@ git submodule update --init
 mkdir -p build
 cd build
 pwd
+
 cmake -DGIT_SUBMODULE=OFF -DBUILD_SHARED_LIBS=OFF ..
 make -j$((4*$(nproc))) all
 make DESTDIR=../install install
diff --git a/.github/scripts/compare-functions.sh b/.github/scripts/compare-functions.sh
index cbe6596..48fc086 100755
--- a/.github/scripts/compare-functions.sh
+++ b/.github/scripts/compare-functions.sh
@@ -9,10 +9,18 @@ REPO_TARGET=${GITHUB_WORKSPACE}/.kernel
 VMLINUX=${GITHUB_WORKSPACE}/.kernel/vmlinux
 BASELINE=${BASELINE:-next}
 GITHUB_STEP_SUMMARY=${GITHUB_STEP_SUMMARY:-/dev/null}
+CC=${CC:-gcc}
+LLVM_VERSION=${LLVM_VERSION:-18}
 
 export PATH=${GITHUB_WORKSPACE}/install/usr/local/bin:${PATH}
 which pahole
 pahole --version
+
+buildopts=
+if [[ "$CC" = "clang" ]]; then
+	buildopts="LLVM=-${LLVM_VERSION}"
+fi
+
 cd $REPO_TARGET
 pfunct --all --format_path=btf $VMLINUX > functions
 
@@ -23,8 +31,8 @@ export PATH=${GITHUB_WORKSPACE}/install.${BASELINE}/usr/local/bin:${PATH}
 export PAHOLE=${GITHUB_WORKSPACE}/install.${BASELINE}/usr/local/bin/pahole
 which pahole
 pahole --version
-make oldconfig
-make -j $((4*$(nproc))) all
+make $buildopts oldconfig
+make -j $((4*$(nproc))) $buildopts all
 pfunct --all --format_path=btf $VMLINUX > functions.${BASELINE}
 echo "### Compare vmlinux BTF functions generated with this change vs baseline (none means no differences)." | tee -a $GITHUB_STEP_SUMMARY
 diff functions.${BASELINE} functions | tee -a $GITHUB_STEP_SUMMARY
diff --git a/.github/workflows/test.yml b/.github/workflows/test.yml
index ac28e92..f47cc4a 100644
--- a/.github/workflows/test.yml
+++ b/.github/workflows/test.yml
@@ -21,11 +21,19 @@ jobs:
             arch: 'x86_64'
             llvm-version: '18'
             pahole: 'none'
+            cc: 'gcc'
+          - kernel: 'LATEST'
+            runs_on: 'ubuntu-24.04'
+            arch: 'x86_64'
+            llvm-version: '18'
+            pahole: 'none'
+            cc: 'clang'
           - kernel: 'LATEST'
             runs_on: 'ubuntu-24.04-arm'
             arch: 'aarch64'
             llvm-version: '18'
             pahole: 'none'
+            cc: 'gcc'
     name: Linux ${{ matrix.kernel }}
     uses: ./.github/workflows/vmtest.yml
     with:
@@ -34,3 +42,4 @@ jobs:
       arch: ${{ matrix.arch }}
       llvm-version: ${{ matrix.llvm-version }}
       pahole: ${{ matrix.pahole }}
+      cc: ${{ matrix.cc }}
diff --git a/.github/workflows/vmtest.yml b/.github/workflows/vmtest.yml
index 54bb92e..147b608 100644
--- a/.github/workflows/vmtest.yml
+++ b/.github/workflows/vmtest.yml
@@ -27,9 +27,14 @@ on:
         required: false
         default: '18'
         type: string
+      cc:
+        description: 'compiler'
+        required: true
+        type: string
+
 jobs:
   vmtest:
-    name: pahole@${{ inputs.arch }}
+    name: pahole-${{ inputs.cc }}@${{ inputs.arch }}
     runs-on: ${{ inputs.runs_on }}
     steps:
 
@@ -44,6 +49,9 @@ jobs:
 
       - name: Build,install current pahole
         shell: bash
+        env:
+          CC: ${{ inputs.cc }}
+          LLVM_VERSION: ${{ inputs.llvm-version}}
         run: .github/scripts/build-pahole.sh
 
       - name: Get kernel source
@@ -54,6 +62,9 @@ jobs:
 
       - name: Configure, build kernel with current pahole
         shell: bash
+        env:
+          CC: ${{ inputs.cc }}
+          LLVM_VERSION: ${{ inputs.llvm-version }}
         run: .github/scripts/build-kernel.sh
 
       - name: Run selftests
@@ -62,5 +73,8 @@ jobs:
 
       - name: Compare functions generated
         shell: bash
+        env:
+          CC: ${{ inputs.cc }}
+          LLVM_VERSION: ${{ inputs.llvm_version }}
         run: .github/scripts/compare-functions.sh
 
-- 
2.43.5

