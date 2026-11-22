Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795381623;
	b=GGsimlUJE8TPG/9yE3aEMlSfyjLJ2r9yfIpn7MjtuFXP5HyQ3J447wL2A30hUXLO2T5J
	 lsiEM2nFxkjXlQ+DodkPbD/7av6PWSUP1/8O1hkq+hiVvs9ND35E7OLLE5Fk5jlk8CaL+
	 mCYqLM04x1+Df/Tc9nMKARpko2h5nPxTl9TEElf7l+RuT0H/MObfGU4kJtKbzFKRwFV0u
	 6AMvmaBvMDj3/I0Jcsk/1lj6TNb2/0q6j0aSx/OrW7XrsR8CKC4pGSZY+IuJPNAtOk17K
	 kVqcz5S38CIaMeq9nu9qT9K7Tg3/YIkPfljSoWlwiSn/kdyssgBxod0g/G6nrUXSq/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795381623;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=2RpQsvbIpx0Y7Itl5ix7lK9bRuHvyJ7PjOMxzyujlfw=;
	b=z2A9115DxRawGxtvEBgni6EszLlHsLM1jdMdh0Bggn2Vq34yxWXQgYft9USeeCDqe7x8
	 WFutYZQlw9JkpwyDV1rYXkZ1XsUVT9fV3rnMAMQyFn3QpRTsn42RqY4Zl+OdseFrUzlIh
	 Udcd6uJO6RGt81drgse6Cmc6ciQE0AteGyYmCj3Mz5w5R+294+QYXgxuDF6+tTCD3Pa9Y
	 FrNLN6OI2phptXV0Ua5nXicg6mrT8Y2PF2L65o/UGw2tsCHTtgUquylzfdG2oQ/bPKsgy
	 EE0r+i0SAFBoZK3tMVVQsebZOCf6OcW5oDCJELxBFijZQlMY9gYg9lZjBaFlmBBztCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=b9XwSUOG;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81422606A31A;
	Sun, 22 Nov 2026 21:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81422606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=b9XwSUOG
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AMKZMW01707543;
	Sun, 22 Nov 2026 21:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2RpQsvbIpx0Y7Itl5
	ix7lK9bRuHvyJ7PjOMxzyujlfw=; b=b9XwSUOGcEvf0NGEmb8EuBJo50IfFsts7
	2sTyuAXC+GNaTaY56v31Y8jQmzhl9k5n3/O7OMvd0B/0suBv61bEJy8Z0TfHUIEn
	WHX/xkdyrPzcKodAt6Jls7pVDYTFtqTKAXnystmaPySxLf4KMSgs1ldGWayvifaw
	LYpUesn5BggNyFJNvX8XtkeU00LpNDOWkWtPtatGqQpA+bIRm0cx5Jhg9E6Y9P6l
	LuxcueGE8XbDwuQgBE0hQNc4vac5SdBR9gBD/p05cAIYS575L62bMnHz1qBsF8qA
	BYtJimaqmWbgdn9fpDQL+b4mN/LcTosmJuBRHuBjCBn+ll2XvdqUQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fa0ca2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 21:06:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AMKJQ2k1924345;
	Sun, 22 Nov 2026 21:06:43 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3q4h41gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 21:06:43 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AML6gfD32506540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Nov 2026 21:06:42 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B13275805A;
	Sun, 22 Nov 2026 21:06:42 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7744958052;
	Sun, 22 Nov 2026 21:06:41 +0000 (GMT)
Received: from thinkpad-p1.fritz.box (unknown [9.111.52.78])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 22 Nov 2026 21:06:40 +0000 (GMT)
From: Maxim Khmelevskii <max@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH dwarves v1 2/2] tests: Add test for in-memory return values
Date: Sun, 22 Nov 2026 22:06:20 +0100
Message-ID: <20261122210636.2896891-6-max@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261122210636.2896891-4-max@linux.ibm.com>
References: <20261122210636.2896891-4-max@linux.ibm.com>
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Post: <mailto:dwarves@vger.kernel.org>
List-Help: <mailto:dwarves+help@vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
List-Owner: <mailto:dwarves+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDA4NCBTYWx0ZWRfX306GKEyFv4ZJ
 UhPHHMTLxnba/FKzcZQRRC/luq6ns8fgFPenIlXQEmbj5+66MpbxOA6jFVst6SNbxGhvaNIDhCh
 L8deHg7qSgSZUxklN4Ivyi3F90S5tcFxtZFcgfqBsxpKiSVK1AQWsd57LgDJipf/G2YbkXH0qFp
 nGfekdS0LjkEaYYcbvKneWgL7QS6h1abtvKVmrnF2ha9j87CxOFuXSz6lvAwmccgVltJeTq1qq9
 gqQFF2ii5MaVwsb03MNn7a2i31AjyxXq7EWJZ7PhnpqF1YaFhDjh62FfDMgJspQdcoYxySvfE/n
 VxuHNZwZm68MKjBSk7RaGbqtEajuzUNgqmnEiJhAi2rCqaqI5OmTRTqfWSAfbI7+jL68mEzjfk4
 mWM50KeEwyslpgtYbrMZtLsMOCsXHlVxmqOWZE2e9otcEEMcpYqFWALvNCdJpPCalrGh5GkdWmU
 R2QDht+U5LNzX1buKDQ==
X-Proofpoint-ORIG-GUID: aeheD-8b89M3QtNiFHGog4_yIiJ5Zz96
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b035964 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=KGnV6wvy8-slfzG-XVcA:9
X-Proofpoint-GUID: aeheD-8b89M3QtNiFHGog4_yIiJ5Zz96
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDA4NCBTYWx0ZWRfX8WHItU1M+OkR
 0IGXiKuqbu6rvvO9ySYI07UINTDL1+TBIZimVmDkndWTUhfdhv30mAn9qEOmLYUyk94xIqwVM6s
 2k6PTPuNo+LvkVRrRAQpjX3PM66nZmg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_05,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1011 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611220084

Check that functions returning a value passed in memory have the
same signature in BTF and DWARF.

Signed-off-by: Maxim Khmelevskii <max@linux.ibm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com> 
---
 tests/ret_in_memory.sh | 113 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100755 tests/ret_in_memory.sh

diff --git a/tests/ret_in_memory.sh b/tests/ret_in_memory.sh
new file mode 100755
index 0000000..a5faa98
--- /dev/null
+++ b/tests/ret_in_memory.sh
@@ -0,0 +1,113 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+source "$(dirname "$0")/test_lib.sh"
+
+outdir=$(make_tmpdir)
+
+# Comment this out to save test data.
+trap cleanup EXIT
+
+title_log "BTF encoding: functions returning values passed in memory"
+
+supported_arches=(
+	x86_64
+	aarch64
+	s390x
+)
+
+CC=${CC:-gcc}
+if ! command -v "${CC%% *}" > /dev/null 2>&1; then
+	info_log "skip: $CC not available"
+	test_skip
+fi
+
+arch=$(uname -m)
+if [[ " ${supported_arches[*]} " != *" $arch "* ]]; then
+	info_log "skip: test does not support $arch"
+	test_skip
+fi
+
+run_cmd()
+{
+	verbose_log "$1" >&2
+	eval "$1"
+}
+
+src="${outdir}/ret_in_memory"
+obj="${src}.o"
+btf="${src}.btf"
+
+cat > ${src}.c << EOF2
+typedef long long i64;
+struct s128 { i64 a, b; };
+
+__attribute__((noinline)) __int128 ret_i128(i64 x, i64 y)
+{
+	return (__int128)x * y;
+}
+
+__attribute__((noinline)) struct s128 ret_s128(i64 x, i64 y)
+{
+	struct s128 r = { x * y, x - y };
+	return r;
+}
+
+/* Check if DWARF abstract function works correctly */
+static struct s128 ret_origin(i64 x, i64 y)
+{
+	struct s128 r = { x, y };
+	return r;
+}
+struct s128 (*fp)(i64, i64) = ret_origin;
+
+__int128 gi;
+struct s128 gs;
+i64 xx, yy;
+
+void entry(void)
+{
+	gi = ret_i128(xx, yy);
+	gs = ret_s128(xx, yy);
+	gs = ret_origin(xx, yy);
+}
+EOF2
+
+if ! $CC -g -O2 -c -o $obj ${src}.c; then
+	error_log "$CC: could not compile ${src}.c"
+	test_fail
+fi
+
+info_log "Generate $(basename $btf)"
+if ! run_cmd "pahole -J --btf_encode_detached=$btf $obj"; then
+	error_log "could not encode BTF for $obj"
+	test_fail
+fi
+
+expected_functions=(
+	ret_i128
+	ret_s128
+	ret_origin
+)
+
+info_log "Check that each function in DWARF has a match in BTF"
+for fn in "${expected_functions[@]}"; do
+	# DWARF lists ret_origin() twice: the abstract and the concrete instance,
+	# because of that sort is needed.
+	dwarf_sig=$(run_cmd "pfunct -P $obj | grep ' ${fn}(' | sort -u")
+	btf_sig=$(run_cmd "pfunct -P --format_path=btf $btf | grep ' ${fn}('")
+	if [[ -z "$dwarf_sig" ]]; then
+		error_log "${fn}() missing from DWARF"
+		test_fail
+	fi
+	if [[ -z "$btf_sig" ]]; then
+		error_log "${fn}() missing from BTF"
+		test_fail
+	fi
+	if [[ "$btf_sig" != "$dwarf_sig" ]]; then
+		error_log "${fn}() BTF signature '$btf_sig' differs from DWARF '$dwarf_sig'"
+		test_fail
+	fi
+done
+
+test_pass
-- 
2.56.0

