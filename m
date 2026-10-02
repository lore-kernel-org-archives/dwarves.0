Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E0550B438;
	Fri,  2 Oct 2026 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962910; cv=none; b=dIed+n2lvC2GfMBcM2fxIk7MCUvI3sylOEKag1I9sCNW1XEAUChtvLpukwKuCrO7BptLxeZZntLKhnCkFI+VdyJcLJbZ9dXHUpQS62k3A4W7hYH+CQr03IceDxUdkHUtV+WuCeV7g9qZ1WYnLWsty8RxWGhySpgBEBu3RlscWww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962910; c=relaxed/simple;
	bh=nS3F6+BDnYE2FLpKVsMyh1CMTYZshu4cFfksP7Unbzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eU3BwNXssw1ATgRxa9vAeSVyxhCLl6Ky6EgmVb7KnQEeZHXi/e/h6CpZIeRR14ijYjz60nY7740i2iX/OyTwanMQ6uqiCfSE3BHrWR7mCUfejnv3HHZ2XtHgj7Jv5tbSLitMSzT4rYC26OoNxfk/uLgYF+umXV+og5aTjxPucow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jb4mrBw1; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jb4mrBw1"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692EbdYm3156296;
	Fri, 2 Oct 2026 17:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=fqPz7
	0A27k9Ho65n13a7uqYE8KCiQN/G8il1rmJhZEI=; b=Jb4mrBw1BUK6PlXJiw6HD
	ewMURS2hhpq4UTRK5JX5imZalOS+yS9QAk857pfc8I/whITEQfIkC4i4c2hKsetY
	P+qmlaCtLqCQIenMK7VyhcUglRVZJDyfQovaO9cZBkJmMoHb54BZwzgXGRsOZ2Cu
	vLuV21SEYJIRNnLhwz1p/1D/N9cpSmDn8K14OAlfKi/2eOZ5/yNlhAKvitLoCKuS
	5StMHsxwKDkK1XIslsKcqUXlzN45EOUL6qgTuKZnoKHycNY1WueAyJ3xjib3sgQ5
	e5Eww+s8aGmEueA6iG/4Zo5QK7kPmBQSpDLBN599MNFZhS8hkd6hFacfdxjek8GW
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx6kscgm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Oct 2026 17:41:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 692HZT1q014464;
	Fri, 2 Oct 2026 17:41:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gtqu7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Oct 2026 17:41:12 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 692Hekef030471;
	Fri, 2 Oct 2026 17:41:12 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-83-232.vpn.oracle.com [10.154.83.232])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gx4gtqtes-10;
	Fri, 02 Oct 2026 17:41:12 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        jolsa@kernel.org, qmo@kernel.org
Cc: dwarves@vger.kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 dwarves 09/10] tests: Validate inline BTF encoding
Date: Fri,  2 Oct 2026 18:40:37 +0100
Message-ID: <20261002174043.3823987-10-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20261002174043.3823987-1-alan.maguire@oracle.com>
References: <20261002174043.3823987-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_05,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610020070
X-Proofpoint-GUID: wPlT8d7G6zhXla_uRrBcnyIwgNxyXUIk
X-Authority-Analysis: v=2.4 cv=U/gHnuru c=1 sm=1 tr=0 ts=6abfecba b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=LnL0v8D0lTJsJdIgR9UA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13537
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA3MCBTYWx0ZWRfX1A9KcpBtUKcV
 qeJhUueqL64E6N301/H7MaPYZDe0mNYbncpzbq5PdtMA5FHcNjWhHwQHCRVrUIl1UCL3hubq/cg
 N4rI2y3CdNd+BqqHKVyGoOu7Z/l+Ecsfriko+rv2lCLBZbx/SNZt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA3MCBTYWx0ZWRfXzxxS1xmKWdSp
 wwI2bsyAbgoY03mF57TdvOpUKPYDrm1XTF0/G/45KMU/klKD6TbZvYuYqSSNWVu+HH936HFNihX
 1esrppG1r1rr/cJQJ1YfQjAjfcLwt34ea4dFZE/LZCH+MkVDWuEZku6gS4nQw/Q/YqdYTgP8oCS
 80Y8YWBsy/dH5Idp3mb5l+aCYZXYis2qhS4gBMmbrKJz0flDTSQKO3s9s0zOfb9pL3KlLJxNfIr
 zFOJVdol2DqAedxYkpjg3ZkpjUhnOmrQsKaZ3AkBYZIQOU36bXeROR/Sfr7J+hsQ7H8/6XiAXH/
 l1EkLYdtndC0XfasqgQGqN5mNLCu+DHCrZgOhQY9+U8JQHnt8KT9oNYcIE3oBm+g//U3Bb3lfyV
 WdY1U3jv+JRe2gFJjDhQ0xgPSdslEYTCvSDJz+zW9OwyXnc31aMpEAIUG1nbSSa0xxF7wNC7+to
 dk9SBRn9PIbEswIfN7kqOQZCAcVOZymiGG+FXNaU=
X-Proofpoint-ORIG-GUID: wPlT8d7G6zhXla_uRrBcnyIwgNxyXUIk

Exercise nested inline calls, constant arguments, no-argument inline
functions, and repeated inline call sites. Verify that ordinary wrapper
function BTF remains present, inline functions are annotated by pfunct,
and when bpftool is available, LOCSEC contains multiple inline sites.

Also verify that pfunct:

 - lists the ordinary and inline BTF functions;
 - prints inline-site parameter locations from detached raw BTF using
   the regN fallback;
 - uses an explicitly supplied ELF file to resolve register names and
   containing functions; and
 - automatically uses ELF information when BTF is embedded in the ELF.

Build separate non-PIE and PIE test executables. This validates both
ordinary ELF-section lookup and the ET_DYN link-time address handling
needed for PIE inline locations.

Use a single-register inline parameter rather than asserting ABI-specific
register numbers or aggregate calling conventions, allowing the test to
run across supported architectures.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Assisted-by: Codex (GPT-5.6)
---
 tests/btf_inline.sh | 155 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)
 create mode 100755 tests/btf_inline.sh

diff --git a/tests/btf_inline.sh b/tests/btf_inline.sh
new file mode 100755
index 0000000..007fc48
--- /dev/null
+++ b/tests/btf_inline.sh
@@ -0,0 +1,155 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+script_dir=$(dirname "$0")
+source "$script_dir/test_lib.sh"
+
+outdir=$(make_tmpdir)
+trap cleanup EXIT
+
+title_log "Validation of additive inline BTF encoding."
+
+CC=${CC:-gcc}
+if ! command -v "$CC" >/dev/null 2>&1; then
+	info_log "skip: gcc not available"
+	test_skip
+fi
+
+if ! pahole --supported_btf_features | tr ',' '\n' | grep -Fxq inline; then
+	info_log "skip: pahole was built without BTF location support"
+	test_skip
+fi
+
+src=${outdir}/btf_inline.c
+
+cat > "$src" <<'EOF'
+/* Keep the inline functions small enough to guarantee inlining at -O2. */
+static inline int scale(int value, int factor)
+{
+	return value * factor;
+}
+
+static inline int add_bias(int value, int bias)
+{
+	return scale(value, 2) + bias;
+}
+
+static volatile int inline_bias;
+
+static inline int add_global(void)
+{
+	return inline_bias;
+}
+
+static inline int combine(int value, int bias)
+{
+	return add_bias(value, bias) + add_global();
+}
+
+__attribute__((noinline)) int wrapper_once(int value, int bias)
+{
+	return combine(value, bias);
+}
+
+__attribute__((noinline)) int wrapper_twice(int value, int bias)
+{
+	return combine(value, bias) + combine(bias, value);
+}
+
+int main(void)
+{
+	return wrapper_once(1, 3) + wrapper_twice(2, 4);
+}
+EOF
+
+run_inline_btf_test()
+{
+	local mode=$1
+
+	shift
+	obj=${outdir}/btf_inline-${mode}
+	btf=${obj}.btf
+	"$CC" -g -O2 "$@" -o "$obj" "$src"
+if [[ $? -ne 0 ]]; then
+	error_log "Could not compile $src"
+	test_fail
+fi
+
+if ! pahole --btf_features=default,inline --btf_encode_detached="$btf" "$obj"; then
+	error_log "Could not encode inline BTF for $obj"
+	test_fail
+fi
+
+# Inline location BTF augments the ordinary BTF_KIND_FUNC records for the
+# non-inline wrappers. It must cover nested calls, a constant parameter, a
+# no-argument inline function, and multiple call sites of the same inline.
+if ! pfunct --all --format_path=btf "$btf" 2>/dev/null | grep -Fq "int wrapper_once(int value, int bias);"; then
+	error_log "wrapper_once() is missing from inline BTF"
+	test_fail
+fi
+
+if ! pfunct --all --format_path=btf "$btf" 2>/dev/null | grep -Fq "int wrapper_twice(int value, int bias);"; then
+	error_log "wrapper_twice() is missing from inline BTF"
+	test_fail
+fi
+
+if ! pfunct --all --format_path=btf "$btf" 2>/dev/null | grep -Fq "inline int scale(int value, int factor);"; then
+	error_log "scale() inline location is missing from BTF"
+	test_fail
+fi
+
+if ! pfunct --all --format_path=btf "$btf" 2>/dev/null | grep -Fq "inline int add_bias(int value, int bias);"; then
+	error_log "add_bias() inline location is missing from BTF"
+	test_fail
+fi
+
+if ! pfunct --all --format_path=btf "$btf" 2>/dev/null | grep -Fq "inline int add_global(void);"; then
+	error_log "add_global() inline location is missing from BTF"
+	test_fail
+fi
+
+if ! pfunct --all --format_path=btf "$btf" 2>/dev/null | grep -Fq "inline int combine(int value, int bias);"; then
+	error_log "combine() inline location is missing from BTF"
+	test_fail
+fi
+
+if ! inline_sites=$(pfunct --inline_sites "$btf" 2>/dev/null) ||
+	   ! grep -Eq 'scale\(int value \[reg[0-9]+\], int factor \[const 0x2\]\)' <<<"$inline_sites"; then
+	error_log "pfunct did not render a fallback register name for an inline parameter"
+	test_fail
+fi
+
+if ! inline_sites=$(pfunct --inline_sites --elf "$obj" "$btf" 2>/dev/null) ||
+	   ! grep -Eq 'scale\(int value \[[^][,[:space:]]+\], int factor \[const 0x2\]\)' <<<"$inline_sites" ||
+	   grep -Eq 'scale\(int value \[reg[0-9]+\], int factor \[const 0x2\]\)' <<<"$inline_sites" ||
+	   ! grep -Eq '\[wrapper_once\+0x[0-9a-f]+, ' <<<"$inline_sites"; then
+	error_log "pfunct did not resolve inline-site registers and containing functions through ELF"
+	test_fail
+fi
+
+if command -v bpftool >/dev/null 2>&1; then
+	locsec_vlen=$(bpftool btf dump file "$btf" format raw 2>/dev/null |
+		     sed -n 's/.*LOCSEC .*vlen=\([0-9][0-9]*\).*/\1/p')
+	if [[ -z "$locsec_vlen" || "$locsec_vlen" -lt 2 ]]; then
+		error_log "multiple inline call sites are missing from LOCSEC"
+		test_fail
+	fi
+fi
+
+if ! pahole -J --btf_features=default,inline "$obj"; then
+	error_log "Could not encode embedded inline BTF for $obj"
+	test_fail
+fi
+
+if ! inline_sites=$(pfunct --inline_sites "$obj" 2>/dev/null) ||
+	   ! grep -Eq 'scale\(int value \[[^][,[:space:]]+\], int factor \[const 0x2\]\)' <<<"$inline_sites" ||
+	   grep -Eq 'scale\(int value \[reg[0-9]+\], int factor \[const 0x2\]\)' <<<"$inline_sites" ||
+	   ! grep -Eq '\[wrapper_once\+0x[0-9a-f]+, ' <<<"$inline_sites"; then
+	error_log "pfunct did not resolve inline-site registers and containing functions from embedded ELF BTF"
+	test_fail
+fi
+}
+
+run_inline_btf_test nonpie -fno-PIE -no-pie
+run_inline_btf_test pie -fPIE -pie
+test_pass
-- 
2.43.5

