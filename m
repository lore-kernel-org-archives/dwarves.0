Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22578470433;
	Fri, 25 Sep 2026 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362394; cv=none; b=GzjRRF+ed6tjUzKncdRFx/iZaDlXTwW98JbUq2WzbJjcJ/sqtPGUWcblNcCO6s9h8Menl4nSq8BfDpKRxGo8Zu1yrWaex6AR7o8S23MvCra1wMPNWcdBL2IzSUzt5HaxG3y6SCTnn898bUgcLEEyMPAoImp7a/Ki3/oAcjHxjqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362394; c=relaxed/simple;
	bh=7Ndh1TZQXuxmEJjoaPLeHc+0g4qmcMTopHXfac0CwFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRTbpcnx9qQUl7/YAJRYb2jAyJhj2h/2qE/Opcr14EUtWIUIJ5f9xYW/iq/7+xTH4o52sxCFPN2w0xVPRJnbNqRLAa7el1anmnvn1z+YAupG7jWtwy8pheIrovF7GuEtPZMxpBDRNRqfovTX0pKm+fdSSMYt5zCgUq+YwWC//Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pi98pQCe; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pi98pQCe"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PEBqst3193022;
	Fri, 25 Sep 2026 18:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=R0y0i
	mXfppW1pMr3m+j42hT1SZr+eo6Q82RNxm6vvYw=; b=pi98pQCe68qPEPw+w+Fmq
	mGZQ+95q5phLvJluvh5KGi2v1Z1NhXaFWOkR8I7kwSnxghmVNUpE52tOkrW4MYwN
	EmbpuzV0apgR9d72IeWmTr+p27AzjnoWIEhJTpcSksYhr4CGH1aiwBibLjBqUNEp
	QJAz8pLuZIah7sVtfHO25Ih/2Bz1qJKimrCHTIH5uMOwZ3LfEg64mn8+cJ+8voRr
	e66Q4guPbnYE9Fte6U6d+FNmkhBNRGab10td6b5aAp/IkV9ynY7fPEQsOf9m7LpM
	9R1ySZEkKOD9xNYVLYAPacsru/6ZHQ08FasKavAuXOtztz1LLJvWI4nPIERjthSY
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk2d9u72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:52:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68PIqER0038654;
	Fri, 25 Sep 2026 18:52:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gtepthtfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:52:51 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68PIqQou040536;
	Fri, 25 Sep 2026 18:52:50 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-81-122.vpn.oracle.com [10.154.81.122])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gtepthsyc-9;
	Fri, 25 Sep 2026 18:52:50 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        qmo@kernel.org
Cc: dwarves@vger.kernel.org, jolsa@kernel.org, daniel@iogearbox.net,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
        bpf@vger.kernel.org, nsc@kernel.org, puranjay@kernel.org,
        yatsenko@meta.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 8/9] tests: Validate inline BTF encoding
Date: Fri, 25 Sep 2026 19:51:57 +0100
Message-ID: <20260925185200.1318067-9-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260925185200.1318067-1-alan.maguire@oracle.com>
References: <20260925185200.1318067-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609250075
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NSBTYWx0ZWRfXx0QvT1rbKrQP
 aGVUbtSoa4nxRv2XUitvO4LGJTx/+1DNOqB4fL28NBiaj8IIWcLYkFmmxl3MJ4qDt2GaifVxaXm
 f9fmlJ33OSZu0IeP1p6l2rVLs5izgfwbVAnaGKQO1XXXVM6AW67RZhJpxYdKdI1MA4x5Dp4vfsT
 hEegjwUkZLfmWWpD6fcfqn9cC7W5kaRYonbGGpsF1txonuuo67aietamzI6lrldigz8i+RuKFbi
 bnOEwCouy44Zu8rfwCnlhgNSMawhcfkT2spO3/zD7D9Eap19OjES6Oav1/zh3U8diDbBMVmB1g0
 yVOUOC5/zqDrZyQcNNGkmBa5dJMuHkF24uQXC9iNAPTcdOCVxLc+8AF0b0wl/dD2Ii5ReJ/g55h
 ayJD1UTbSn5m/Tvv2dKJ2uWE8SxRMO1pPhgH2lUrpWFx+fi2j2HTYzJavMvhCUZbnWU3vy0FU7b
 o7Kv6nra/OQhq5DR91woV77u7tGhPZDXxnFmxM1E=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NSBTYWx0ZWRfXygoAyUhhu2Pn
 sQlH/OOrsgTBA4hJHTWP+UcTjHzcF7s3/ChlseFEpHL9wi8cMlMGouyOJ9wvpUqLrbiagBPEp7F
 SxVYpUw3UfzX2usMFOqxayT57cyVRUQotwr7M4Ek1XlFhCy8fEuD
X-Proofpoint-ORIG-GUID: 1R85n11DvyAyk9TcaBACgYwzkcIR5hDd
X-Authority-Analysis: v=2.4 cv=f+Ddl+yM c=1 sm=1 tr=0 ts=6ab6c304 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=okCq5JjSQUMii4kNj_8A:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13532
X-Proofpoint-GUID: 1R85n11DvyAyk9TcaBACgYwzkcIR5hDd

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

Use a single-register inline parameter rather than asserting ABI-specific
register numbers or aggregate calling conventions, allowing the test to
run across supported architectures.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Assisted-by: Codex (GPT-5.6)
---
 tests/btf_inline.sh | 147 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)
 create mode 100755 tests/btf_inline.sh

diff --git a/tests/btf_inline.sh b/tests/btf_inline.sh
new file mode 100755
index 0000000..a782a65
--- /dev/null
+++ b/tests/btf_inline.sh
@@ -0,0 +1,147 @@
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
+obj=${outdir}/btf_inline
+btf=${outdir}/btf_inline.btf
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
+"$CC" -g -O2 -o "$obj" "$src"
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
+
+test_pass
-- 
2.43.5

