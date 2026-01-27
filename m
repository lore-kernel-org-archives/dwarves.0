Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54512BEFF6;
	Tue, 27 Jan 2026 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769534463; cv=none; b=M0ceOclNjBqmhO7FhMsj8RAp7HkEGrJJZs+zHrR4qbngBds8FoPgEfXVIXaCdubSs/uANPGaCNU42rBkF0RGJY1uo/iD8xkFRq/ukqpWQvX+jPkT5zxsfsmxWd+p9sv0xlpBLuYvx0+oEGu0cezIGrLIeZ0+04QU4QM6tHAfMYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769534463; c=relaxed/simple;
	bh=YttrqFBQTWIl9WT5IQzLB/wLhc8HNqoQvWRlliIeANc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djyeIWCNdL7kmZy3kveP0ajgntVUp8j4TfY9hiisxt47SaCMOQMgnoCMJRBH3ZkKlRA/HQexGqZasU6znaF7rtzeq0ub9CStelm5l8bo45cmIP/+l7HX18y8uo9o1UgjZ7590nCrXwzWyZk760g7Q85u2nmN8UnMfAAXFiEIT6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XA6VEZI9; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XA6VEZI9"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBETAs4055955;
	Tue, 27 Jan 2026 17:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=WxqmZ
	2z6XXLPxrOFdKFWA9ffgN+MWKmcyQZQnT1llRg=; b=XA6VEZI9eMLh7bCU4/inR
	hW4xWMO5NslZRGtmR28sSWNaNQXfqbWmMTD1gyQqpFDXq4OSz70SpzOCY/IJ+3pJ
	GsR6YZ2RFi0bWcP89PL4IQZTMP5UweXRquwNOWCLUP/fufGQ5+iOE+xwYVzjLmdW
	AdqkfVdI/H8b+IgfuF9KifhT8ZXOtep8Zeu54hjzCr1TF5HnBodueMdD7V1sWDKO
	uBjg3U6+rzqNMZzrTL/ZglhGyHqOILICjvtsCvsSCFHfiFlcEH3Lq9o6WuLliodZ
	vHOG1PHAxiDQ2GZ5CsP3/h36U0YNWlvg8D9kJ9t7opztI49wFnnCff3j4JQ3cCHS
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvnpscdxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 17:20:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RGBVce035152;
	Tue, 27 Jan 2026 17:20:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh9q816-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 17:20:54 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60RHKjSl011183;
	Tue, 27 Jan 2026 17:20:53 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-55-133.vpn.oracle.com [10.154.55.133])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4bvmh9q7sn-4;
	Tue, 27 Jan 2026 17:20:53 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: yonghong.song@linux.dev, mattbobrowski@google.com
Cc: ihor.solodrai@linux.dev, eddyz87@gmail.com, jolsa@kernel.org,
        andrii@kernel.org, ast@kernel.org, david.faust@oracle.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 3/5] test: add gcc true signature test
Date: Tue, 27 Jan 2026 17:20:39 +0000
Message-ID: <20260127172041.1558244-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260127172041.1558244-1-alan.maguire@oracle.com>
References: <20260127172041.1558244-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601270141
X-Authority-Analysis: v=2.4 cv=dY2NHHXe c=1 sm=1 tr=0 ts=6978f3f7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=74enMH05-RYm0AneQoYA:9
X-Proofpoint-GUID: ooJLdizulMwZpn-XPvfRZH9U1DqBIsC5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE0MSBTYWx0ZWRfX0t3teM+clVUf
 XU+EqE01hBIoRsuMImIEK2AytRgYWUYWbbcJ/MTA07O0nj71ILp7FYXDvD6GXtEreKEVS2e6erG
 cxrgNdgsXxOUvBLUEGwmlSkFzmGRgn7OHT+0MimzjsVD5S/IEsKCbA2HpT1HdKKHZNAQ/fkfQeu
 8TQXxbHlmZtzdwB0YmB0hmI8iij9PYliEAgQn00VSoCsw8qPY9MWMP505ONVqc9NHRNw1yJe6vY
 ZfExREFyBe0FgwnZY7/JaBUfoP6+hltZ4cGhIF0MIeryYBrfgSFSCbcb2iTWcfSy7ZRq4UweWPQ
 cB1zUvklqzDEvabQwsIjcgKzz8I54jOzaKuzxXpY5tDokr/xf18gv5SpEIvKhpDI8CMThi/p7ku
 E89MsAP8qRCs2RKoK065J82DOTn+CBhRHWGuUuRmMiIUhEbnu963Dlwk49GIRCCTBWoUf7WDfbB
 QhkbmS+/TzOci3BCSgA==
X-Proofpoint-ORIG-GUID: ooJLdizulMwZpn-XPvfRZH9U1DqBIsC5

Use Yonghong's true signature test program to verify signatures
differ for function "foo" with optimized-out parameter.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 tests/gcc_true_signatures.sh | 92 ++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100755 tests/gcc_true_signatures.sh

diff --git a/tests/gcc_true_signatures.sh b/tests/gcc_true_signatures.sh
new file mode 100755
index 0000000..57cbe3f
--- /dev/null
+++ b/tests/gcc_true_signatures.sh
@@ -0,0 +1,92 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
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
+outdir=$(mktemp -d /tmp/gcc_true.sh.XXXXXX)
+
+trap cleanup EXIT
+
+echo -n "Validation of BTF encoding of true_signatures: "
+
+gcc_true="${outdir}/gcc_true"
+CC=$(which gcc 2>/dev/null)
+
+if [[ -z "$CC" ]]; then
+	echo "skip: gcc not available"
+	exit 2
+fi
+
+cat > ${gcc_true}.c << EOF
+struct t { int a; };
+__attribute__((noinline)) char *tar(struct t *a, struct t *d)
+{
+	if (a->a == d->a)
+		return (char *)10;
+	else
+		return (char *)0;
+}
+
+__attribute__((noinline)) static char * foo(struct t *a, int b, struct t *d)
+{
+	return tar(a, d);
+}
+
+__attribute__((noinline)) char *bar(struct t *a, struct t *d)
+{
+	return foo(a, 1, d);
+}
+
+struct t p1, p2;
+int main()
+{
+	return !!bar(&p1, &p2);
+}
+EOF
+
+CFLAGS="$CFLAGS -g -O2"
+${CC} ${CFLAGS} -o $gcc_true ${gcc_true}.c
+if [[ $? -ne 0 ]]; then
+	echo "Could not compile ${gcc_true}.c" >& 2
+	exit 1
+fi
+LLVM_OBJCOPY=objcopy pahole -J --btf_features=+true_signature $gcc_true
+if [[ $? -ne 0 ]]; then
+	echo "Could not encode BTF for $gcc_true"
+	exit 1
+fi
+
+btf_optimized=$(pfunct --all --format_path=btf $gcc_true |grep "foo\.")
+if [[ -z "$btf_optimized" ]]; then
+	echo "skip: no optimizations applied."
+	exit 2
+fi
+# Convert foo.[constprop|isra].0 to foo to allow comparison.
+btf_cmp="$(echo $btf_optimized \
+	awk '/foo/ {sub(/\.constprop.0/,""); sub(/\.isra.0/,""); print $0 }')"
+dwarf=$(pfunct --all $gcc_true |grep "foo")
+
+test -n "$VERBOSE" && printf "\nBTF: $btf_optimized  DWARF: $dwarf \n"
+
+if [[ "$btf_cmp" == "$dwarf" ]]; then
+	echo "BTF and DWARF signatures should be different and they are not: BTF: $btf_optimized ; DWARF $dwarf"
+	exit 1
+fi
+echo "Ok"
+exit 0
-- 
2.43.5

