Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E12322764
	for <dwarves@vger.kernel.org>; Wed, 20 Aug 2025 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755707329; cv=none; b=eOQEve3d5OvohOWMwWlmCpY4ac6eX+iWY1kudjcRgaBO1/zpZ3iDLlQOOXLY3he6I7SqA5tLSTo9Ewfj6U882ObGgQbmrA1nD0pUXGfUBKMHuf/hMPKYz4DllZY8OhzbNbw2Y6hQEQquIdh91q1i2/3Ro0emq2ysdCgbXs8dOjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755707329; c=relaxed/simple;
	bh=hqEkWrUAdS/f/bLHmghqI6b2714ft8rY5bxv37WQ2V8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V2D1oRWUBl115w6Uh+VaUcA0UT3Ar2NisoGprHePhq90HK6NaeOoxDqcmd21LbuEr6uVrd27kPmCRRpQs/SOr9UOEiv7F76Xr6+C4K/tWqXfb5+SiikuTnJwhR5UxmO1ppjWJXw+CO4j2Sccl3Zw5x8DLLqNv9CLsTcDZ+YWO9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZjIk19X4; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZjIk19X4"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KFWsp9026645
	for <dwarves@vger.kernel.org>; Wed, 20 Aug 2025 16:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=Gmp3wwsSP7Yqa6DMgVaucjd6mmApl
	oaOgurTvcRbtwI=; b=ZjIk19X4dJNZkMb6n1iYjM5wWWWHwXq0efVf4WamzInrt
	eLBILC/VGgiEk8QBFjoVeVZ6HnYXWpC7zmRSWhpSTI2NhZrOkerKCfpVE127A1dY
	dYlr+DCXzaZnTY98u2U4pGRZXHiQPSExPbPyBm2IOpDdAbvjQ9KLA50F1+29l6Gi
	XWepe+rc2nPmXZ9fun14WneunCpglZ4yzHb3uxiVWcAYzQh/isoBquKR8KdFbtVE
	nOufMGToTIc/uVZ1fc3lgC4NmTyMa2a9LG0Vm9FAoo0QTEbJJ90e66ggcmxQkMwq
	DJG/EOJIywbNWWx6Ph/OFtw0jKlkXM2tpXaKMmUng==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tthnbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Wed, 20 Aug 2025 16:28:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57KFlYVJ025513
	for <dwarves@vger.kernel.org>; Wed, 20 Aug 2025 16:28:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48my41gswg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Wed, 20 Aug 2025 16:28:46 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57KGSj6P009182
	for <dwarves@vger.kernel.org>; Wed, 20 Aug 2025 16:28:45 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-56-97.vpn.oracle.com [10.154.56.97])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 48my41gsvx-1;
	Wed, 20 Aug 2025 16:28:45 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves] tests: Add test to verify behaviour when debuginfo is absent/debuglink
Date: Wed, 20 Aug 2025 17:28:44 +0100
Message-ID: <20250820162844.953167-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508200146
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX/dP63sUrUSUC
 hrQ4wx9qnn5HljTVPxNVN3qBIqRlV9QH6Iqz9MQlO5qhaWCv8gxfGXOJDdpPfCtCdhjTz7BX2KS
 IhvcBxe/z1mjCZeMrrG/DSSurTLf/bDWErUuZCWe9Xh2NfxiqxJ+0G4jqA/DCYIP4c9adF3QK5a
 KI2lXwTqP31QQ2bAKCZWdGfC9Z99pLg/gvACoHMhi6RLt2gNCTrMJPCc9ax+rkjUdA3naVI4Otp
 BkjrYkXCyOYAEQ6e3Mme9dO1EBZSv3LZ8LjndlxN7cLi6cVEJutEft+rVUFZI65NR5gNwS5OMwr
 G+Mi089AnHiUZryYGq8cy5hGSl/BMZcPjvKY5qZpBbrZLeggbMlh07JBdzAQwH35phqNGX4+Its
 nuEnbOqBBVqKAXDDMGyBgEtRavp6ARfjfRG3fRTNYOIIVyh0kME=
X-Proofpoint-GUID: qpPuQW48KTtizVXiMXPxRF4OUp0I9KJD
X-Proofpoint-ORIG-GUID: qpPuQW48KTtizVXiMXPxRF4OUp0I9KJD
X-Authority-Analysis: v=2.4 cv=V94kEeni c=1 sm=1 tr=0 ts=68a5f7bf b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=w1bsUlNpwXprvNSZByoA:9
 cc=ntf awl=host:12070

Since BTF encoding behaviour has changed recently to

- succeed but do nothing when no debug info is present
- skip debuglink case

add a test that verifies these behaviours.

Debuglink test based on Ihor's instructions in [1].

[1] https://lore.kernel.org/dwarves/979a1ac4-21d3-4384-8ce4-d10f41887088@linux.dev/

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tests/missing_debuginfo.sh | 68 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100755 tests/missing_debuginfo.sh

diff --git a/tests/missing_debuginfo.sh b/tests/missing_debuginfo.sh
new file mode 100755
index 0000000..20298ac
--- /dev/null
+++ b/tests/missing_debuginfo.sh
@@ -0,0 +1,68 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (c) 2025, Oracle and/or its affiliates.
+#
+# Ensure correct behaviour for missing/debuglink DWARF.
+
+outdir=
+
+fail()
+{
+	# Do not remove test dir; might be useful for analysis
+	trap - EXIT
+	if [[ -d "$outdir" ]]; then
+		echo "Test data is in $outdir"
+	fi
+	exit 1
+}
+
+cleanup()
+{
+	rm ${outdir}/*
+	rmdir $outdir
+}
+
+vmlinux=${vmlinux:-$1}
+
+if [ -z "$vmlinux" ] ; then
+	vmlinux=$(pahole --running_kernel_vmlinux 2>/dev/null)
+fi
+
+outdir=$(mktemp -d /tmp/missing_debuginfo.sh.XXXXXX)
+
+trap cleanup EXIT
+
+echo -n "Validation of correct behaviour with missing/debuglink DWARF: "
+
+emptyfile=$outdir/emptyfile
+touch $emptyfile
+pahole --btf_features=default --btf_encode_detached=$emptyfile.btf $emptyfile
+ret=$?
+if [[ $ret -ne 0 ]]; then
+	echo "non-zero return value $ret for empty file with no debug info"
+	fail
+fi
+if [[ -f $emptyfile.btf ]]; then
+	echo "$emptyfile.btf should not exist"
+	fail
+fi
+
+if [[ -f "$vmlinux" ]]; then
+	debuginfo=$outdir/vmlinux.debug
+	objcopy --only-keep-debug $vmlinux $debuginfo
+	objcopy --strip-all --add-gnu-debuglink=$debuginfo $vmlinux $outdir/vmlinux.stripped
+	pahole --btf_features=default --btf_encode_detached=$outdir/debuglink.btf $outdir/vmlinux.stripped 2>/dev/null
+	ret=$?
+	if [[ $ret -ne 0 ]]; then
+		echo "non-zero return value $ret for stripped vmlinux $vmlinux with debuglink"
+		fail
+	fi
+	if [[ -f $outdir/debuglink.btf ]]; then
+		echo "$outdir/debuglink.btf should not exist"
+		fail
+	fi
+fi
+
+echo "Ok"
+exit 0
-- 
2.43.5

