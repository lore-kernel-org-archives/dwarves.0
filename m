Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC762F3636;
	Fri, 23 Jan 2026 17:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769189287; cv=none; b=B0cd53PwpUxrgVEMpV+bDaPGT3p9r79sE3Y0/i8p4nN5dbGLTxdwIWQ0vGIEiI20f08rYhQveBiqPDxQII7ioNBBdpvjcGZdIa+RTA8s1KuKe3Y3nNPKbmT5rm5xVWX2KyvBKTvHweUqr1Svi0QLKjiYneNHV4AIrBXA8qkzz4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769189287; c=relaxed/simple;
	bh=YGua4cm//nRuyC1rP/28O/9tl4tf3s9p1TijYe5264g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmJrNnxTqTXojEmXIF3PLyzgd8ECRF/+Zbowd0iGI1vhaB7Up4b/k54UVwNOhVKj48DC3YVd93+660yt8/SkZFgG/BI/AjD49uqbD+w3QvbbW9qayy6bwwOcLfrCf14xKRu914oQsuraptGzvj7IpIJGmWUNxH+mrtcV+Y3AH5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gAZVHTEa; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gAZVHTEa"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NF4LGQ1674968;
	Fri, 23 Jan 2026 17:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=XFAmS
	Hby8DH7S575d1MWQdDKT4vmP4NKYq7ubh0tiSs=; b=gAZVHTEaxz1T3epwFHY8q
	CP995E9SUWN7Ad2fEg532SP3dT36txZJrRBAUMVlGSDklUQjBjL7eLzzDkvk/0/r
	+V/zgkVZO56EJfR0GAoQ7xCMW3DESuwtQfoCb+EjC8zXeFM5uXnu/HkCLS3WSxae
	CWi6GQPln+JHZxW6ZNxrk86oJ64XxDojpYMWVdVKfY1xd7A1aNDC27sOuCnZH9Oh
	c27Rmn3JOXzbsOsRm+dAlBbPveCSUPcw132CQHqAHGc+lpb2GCBFARECXHL9s1H3
	0i9Wy+ghpY1ovGcq4XdnOOq39SVOciDbw4yRn0CwcU4wd3IEGtRInVkw0h2nTmb4
	g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br10w2sqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 17:26:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60NGb2dc024943;
	Fri, 23 Jan 2026 17:26:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bujd1q8sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 17:26:58 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60NHH3mR020337;
	Fri, 23 Jan 2026 17:26:57 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-82.vpn.oracle.com [10.154.50.82])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4bujd1q8n1-4;
	Fri, 23 Jan 2026 17:26:57 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: yonghong.song@linux.dev, mattbobrowski@google.com
Cc: ihor.solodrai@linux.dev, eddyz87@gmail.com, jolsa@kernel.org,
        andrii@kernel.org, ast@kernel.org, david.faust@oracle.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 3/5] test: add gcc true signature test
Date: Fri, 23 Jan 2026 17:26:48 +0000
Message-ID: <20260123172650.4062362-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260123172650.4062362-1-alan.maguire@oracle.com>
References: <20260123172650.4062362-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601230131
X-Authority-Analysis: v=2.4 cv=H4nWAuYi c=1 sm=1 tr=0 ts=6973af63 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=74enMH05-RYm0AneQoYA:9 cc=ntf awl=host:12104
X-Proofpoint-GUID: lV75lmZmVTOYyHTBg5u_tC3t3-YALkH5
X-Proofpoint-ORIG-GUID: lV75lmZmVTOYyHTBg5u_tC3t3-YALkH5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDEzMSBTYWx0ZWRfX2O9RDZpNPvMv
 C52ikV3ETYR0uJYXvw4ya2RK8IRScKzbwmeBA218gjyl+lS7tnrkeFlQPIydh7Ha4t7YdYnZIlU
 xrumbkjQ2wWl73GUoDN2ooWpDhViYYfhWLk/NMAW7oK6RajNPmHsvZc80VXjNl1DVWsjjyBcDQD
 vu4F432Tbfof9Z/fAxidagOjBdWb+/GkNNn1pYaEQG59WmGooIhXhPwGXwZrRrJLLvwiWKeL1rd
 i7jqre/CNpvV9hPaflTW7t9h3dfyfg1ASsSg052JPD1VR2+lmYNDGiw4aLfT6ge9k8dhHfof3qX
 9Inj3zLtQZKfDTjKQNMrR+e7bWcB8/fPBgJkA6/9NVNqy59pwMBJtBLSygaUqmSC3Ycc6IF7Qe3
 Nhww+HxVemq5wTXqpanPm0D00TFBB2dmVkPt9U5B/vuRbsi8XPFLr/MLSarJ6buPuLSAq8t0nf5
 0+vFeQXPtbQ1s+G4ec3uv8/6/4pPT+alRUs1xst0=

Use Yonghong's true signature test program to verify signatures
differ for function "foo" with optimized-out parameter.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
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

