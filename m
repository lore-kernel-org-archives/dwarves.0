Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718623603E0;
	Tue, 14 Jul 2026 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037047; cv=none; b=fkxc/JYOplZKaeVcMCffEjSmIKT0jnOUFdqIoW5VmYI2yjLAZGv3cRPcV43dCjDruVhWac9QtiyHEM5pLB9g/1YkNnT3+iM1SnyH8IE6mQCFuma8QcwpkvK5XEesnUauxIaZ5JpyVYNCJA6jmvsRw6qih8UzbyvkhJ1K/Dc68ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037047; c=relaxed/simple;
	bh=6fvWjxd32t2RH/wUm5+tIukDcAd7h1EQv3Xdmvpi3J8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/P9vM1jgqxZgg5B4NZlx/gg66EqdM9VeARIVLSpLowqIuGwI2ONm7LEj8WkKV7Z8oO/Qo3eLHmIOWHrfYxOGM+64LqT+OGmm0OMlMd04WhdOcZMyZSnLy3432zHUYxxXRnqQtif5AHc8P1/oyq+i+PzEg0uLg51/mIkxf/XhGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i6JhDZwi; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i6JhDZwi"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ECg35Q1396315;
	Tue, 14 Jul 2026 13:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=oHUl0
	Cd9df/AY+VnBVlOLxCAX70BM5FZnfTlHBBT/GM=; b=i6JhDZwizRwtpDHnfJADY
	AZkhi21WqTi1zydmOM+sET1RYZmNn0tiqV6hfuF1qLMjj17E1levUIzkZ6XQcAjH
	ALz5ZR+5RfI4U3Mcdi9GIisKNV+V+p+IU16LzStH0Gt4gZbDVeBWaf0B70jTYxcg
	sBsAxHS42GZc7m2WQU3QdqrU2QpB7NqOGe+wQz1+lumQdQJ1h25OAfzcyet497zJ
	p8fiXbXS6C9K//jcF+0Sw3BuV/6xJHX3WuCw8iwWCtr8q5A7rbpF7mhSjHTn+Kda
	t79MaVSoWUGM8D/SWZp3WWvYALVhaOaUSH0v8/nc0KIP1GtgjXtFKtBEQ63RcaDX
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbef0v58a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 13:50:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66EDm8LV032350;
	Tue, 14 Jul 2026 13:50:41 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-49.vpn.oracle.com [10.154.50.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4fbc9dtr8p-3;
	Tue, 14 Jul 2026 13:50:40 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: yonghong.song@linux.dev, olsajiri@gmail.com
Cc: arnaldo.melo@gmail.com, bpf@vger.kernel.org, dwarves@vger.kernel.org
Subject: [PATCH dwarves 2/2] tests: Add GCC default-BTF optimized parameter coverage
Date: Tue, 14 Jul 2026 14:50:35 +0100
Message-ID: <20260714135035.814273-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260714135035.814273-1-alan.maguire@oracle.com>
References: <20260714135035.814273-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607140144
X-Proofpoint-GUID: hIsezy1xd0vVyVvAVkBMO9inhmPB8j1o
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE0MyBTYWx0ZWRfX5E4B3SF8DM4o
 rDys10krWjqK4ISPQwHzaXZQUN4zQsgmIN3Q/J7yQDJp/EgDcmfRa5ZWsjwBjEWa97Ywsn7ehfQ
 Pi3I6wf5G69IgO0Q+/5c5ysPcilLTjKKZ1y3bnvPCsDd7atLtrR3
X-Authority-Analysis: v=2.4 cv=KJZqylFo c=1 sm=1 tr=0 ts=6a563eb1 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=KRcLosZDZ0c7n3CqCwMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE0MyBTYWx0ZWRfX8KzjCnr8IC1M
 awfu/i3YtIIMkKunrgeJXBO43OaA0W2DVt43usRaOb3Wm6x5CFCaG4yRd5uN2LyIM4hoGDRrB4E
 XrBKHhlD086lS56ZY8COJePXHKUiIEC3iOHbYZNAEgM07L39Ofl3XfnkuLg57vLr/k0gFQHevOi
 kFMc4yMB3F54CprYzB0heE0CNaYRY2+vbEIkSQ5S5IeKT4iZlTb+MA3Zunku98MjdsARnhqll8J
 yNaD9Lm62BRUiiThjXFSlbkwi6TwhZZDWMM3cZGEtHO4Nd7bg7S3EZS1SIK228/5wIuJgttiW4T
 o3Ht8R3HYCaaciPRgADWPh5ozMH736xOAXZx40oXWSWtZWjP+tAKledo7Q5rPI/nKOO40OcYyIa
 fCsnqVXuybe0Zv+rZ+9/dGDu1MTU2RRPo3KzaVUhF7DFa0S444YL0Anxo11zX/+PaROgzAhXjhF
 RHxyRo/3VcBg68XlAyg==
X-Proofpoint-ORIG-GUID: hIsezy1xd0vVyVvAVkBMO9inhmPB8j1o

Add a regression test for GCC optimized parameters when true_signature is not
enabled.

The test builds one normal externally visible function that must remain in
default BTF, and one static function that GCC optimizes into an .isra clone
with an optimized-out parameter.  Default BTF cannot safely represent the
clone using the original DWARF prototype, so the test verifies it is skipped
while the normal function is still emitted.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tests/gcc_optimized_default.sh | 69 ++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100755 tests/gcc_optimized_default.sh

diff --git a/tests/gcc_optimized_default.sh b/tests/gcc_optimized_default.sh
new file mode 100755
index 0000000..2180666
--- /dev/null
+++ b/tests/gcc_optimized_default.sh
@@ -0,0 +1,69 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+source test_lib.sh
+
+outdir=$(make_tmpdir)
+
+# Comment this out to save test data.
+trap cleanup EXIT
+
+title_log "Validation of GCC optimized parameters in default BTF."
+
+CC=${CC:-gcc}
+if ! command -v "$CC" >/dev/null 2>&1; then
+	info_log "skip: gcc not available"
+	test_skip
+fi
+
+src=${outdir}/gcc_optimized_default.c
+obj=${outdir}/gcc_optimized_default
+btf=${outdir}/gcc_optimized_default.btf
+log=${outdir}/gcc_optimized_default.log
+
+cat > "$src" << EOF
+__attribute__((noinline)) int bar(int a, int b)
+{
+	return a + 1;
+}
+
+__attribute__((noinline)) static int foo(int a, int b, int c)
+{
+	return a * b - a - b;
+}
+
+int a, b, c;
+int main(void)
+{
+	return bar(a, c) + foo(a, b, c);
+}
+EOF
+
+"$CC" -g -O2 -o "$obj" "$src"
+if [[ $? -ne 0 ]]; then
+	error_log "Could not compile $src"
+	test_fail
+fi
+
+LLVM_OBJCOPY=objcopy pahole -J --btf_features=default --btf_encode_detached="$btf" --verbose "$obj" > "$log"
+if [[ $? -ne 0 ]]; then
+	error_log "Could not encode BTF for $obj"
+	test_fail
+fi
+
+if ! grep -q "foo : skipping BTF encoding of function due to optimized parameters" "$log"; then
+	error_log "foo() should be skipped for default BTF due to optimized parameters"
+	test_fail
+fi
+
+if pfunct --all --format_path=btf "$btf" | grep -Fq "int foo("; then
+	error_log "foo() should be absent from default BTF"
+	test_fail
+fi
+
+if ! pfunct --all --format_path=btf "$btf" | grep -Fq "int bar(int a, int b);"; then
+	error_log "bar() is missing from default BTF"
+	test_fail
+fi
+
+test_pass
-- 
2.43.5

