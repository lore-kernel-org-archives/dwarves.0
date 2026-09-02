Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B708472790;
	Wed,  2 Sep 2026 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349152; cv=none; b=XHc51SS7HWdacQmHWEJW+MeajtP13uVijWOxL3krPqBlgKW9n+sqkB7Sspd2HRgs805gdYEh5+bNbMGBJVQawgGzec+HHDVXWEoFXDp4cFzcsopgtt72GZDV1rA/EfP04Km5aTamibn/0z3sw0jtumzR5IzdYCADxFKwebM0+1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349152; c=relaxed/simple;
	bh=iDDg79pq73ZUyWvhm9uTDuLaNoQJfb1vt+3iksbQepM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZocX5d2ue4zN/d7fPm2y6hbyUXaqRT3WA95RBacGItonRDVsqKRi0uexMJx/KJdlmuXUOI3mCM3UpL0H0D80p465Fe2qNTCNm7XksSN3moSkIngF4qkwTARrSSV8BxvakaaUJ3Hz7mJZNOYm1xMlmLHaNj9Kv0aXesP3uRuJkQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e9KOvkzL; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e9KOvkzL"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681Kea71396218;
	Wed, 2 Sep 2026 11:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=S9Uba
	2EjhVfDCFiTkMuIVwkcd/QI7x0yWbQ1x13bgwQ=; b=e9KOvkzLuoYyKqG/utsZe
	FUivNckVT2EIuaCI83rgIr2iUFU95tj65OkmJ+dsxX3VqhQ4YDQKO70Fj+U2yOnZ
	UJx2lopg+6hkAC2Q/AWVAiNnHu0T9TwUf0UxTjk/c610j2vVorTRDJGSbTVa646o
	ClGzHfF6EivdUYHijj24zA1Y9oWfIx6sDcyTT6TEkNdE+dXa9JdDXoRhk4gpk7A8
	96Ss3p2FMRxsn4dXdLMuyNoAelm8iGOw2WujzXpQeOxKTPxxOico82YJc1A3ZEyb
	Nu4ro2c+KbwNANRLNkbFEl7rRk2wmlt4e95LoH7eoqxHWZK0xIwg++KqGKHy2Peh
	A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbpbaxpk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Sep 2026 11:38:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 682BaVNr029293;
	Wed, 2 Sep 2026 11:38:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvrnt8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Sep 2026 11:38:48 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 682BcYmk038508;
	Wed, 2 Sep 2026 11:38:48 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-253.vpn.oracle.com [10.154.52.253])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gbnvrnt37-7;
	Wed, 02 Sep 2026 11:38:48 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, eddyz87@gmail.com, jolsa@kernel.org,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, bpf@vger.kernel.org, dwarves@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 6/6] tests: Validate inline BTF encoding
Date: Wed,  2 Sep 2026 12:38:26 +0100
Message-ID: <20260902113829.1285407-7-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260902113829.1285407-1-alan.maguire@oracle.com>
References: <20260902113829.1285407-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2609020103
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEwMyBTYWx0ZWRfX9ok185WYqO0M
 P06EV3hjyJd8lUfp1PdvOSgredwZ8cdTkVxSiLr7z/M+A2Odr/C9GnRp9/Cm8tFlD1HEmUh+13J
 chu7kd+64Khf1/clw3CSCZmdibx3Yr+SToA8glYUvN6pBo3euF5w
X-Proofpoint-ORIG-GUID: fQ3t2tucQPyy_1R6z4ihw5oqrxoXt-Zg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEwMyBTYWx0ZWRfXyn9/WgfgCooj
 SkaH4+5nMOprgmBC08Cv6J/UkcUaP2tDAibheyKcAjRaEJUMuR5d5/Wjb2pcZ5J4Jy8DTpZDFul
 XVuAsU1ijkn7JgreY5eeWzNoUUn/5SjfMZUGitl5qN+QG24ZGg5EUZjYq84l4HYx+/6PX0nLVbG
 wYlZHIeKb5dVJBotq09Jrtul+etvAabjkuE9AXAgI86h0d6C3Osw5mfEap+ySdin2SKTxgcdvo4
 FxWgF+EYc06pH3TEQbhhS+GKo7LA0hEA4fxFKrNIyWTT8Jc9vCW4FV+TESUaVhZ7iGrnGd7i80y
 46BWVoHYiSPZBpKRr6BHRPyDH6MyS/Zd2s8iahbhHLs+SZKcR+1L8K2SHGbLBqZqsrUlpy8xk3i
 RgmnOMVK/5I5X6Gati0Tfueo3gks5XTcQZQKoSwqud3X9W6r3OWuMsq30FbTqlIVOBS+eOpTSQe
 i+fSe02b/yVNznqZhQasR6fLBeOzx+eJrpicT7tQ=
X-Authority-Analysis: v=2.4 cv=DMi/JSNb c=1 sm=1 tr=0 ts=6a980aca b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=rs4KagSHM2cNQbKWShsA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12102
X-Proofpoint-GUID: fQ3t2tucQPyy_1R6z4ihw5oqrxoXt-Zg

Exercise nested inline calls, constant arguments, no-argument inline
functions, and repeated inline call sites. Verify that ordinary wrapper
function BTF remains present, inline functions are annotated by pfunct,
and when bpftool is available, LOCSEC contains multiple inline sites.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tests/btf_inline.sh | 120 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100755 tests/btf_inline.sh

diff --git a/tests/btf_inline.sh b/tests/btf_inline.sh
new file mode 100755
index 0000000..d87298c
--- /dev/null
+++ b/tests/btf_inline.sh
@@ -0,0 +1,120 @@
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
+if command -v bpftool >/dev/null 2>&1; then
+	locsec_vlen=$(bpftool btf dump file "$btf" format raw 2>/dev/null |
+		     sed -n 's/.*LOCSEC .*vlen=\([0-9][0-9]*\).*/\1/p')
+	if [[ -z "$locsec_vlen" || "$locsec_vlen" -lt 2 ]]; then
+		error_log "multiple inline call sites are missing from LOCSEC"
+		test_fail
+	fi
+fi
+
+test_pass
-- 
2.43.5

