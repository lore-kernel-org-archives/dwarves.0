Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC014A2A7A
	for <dwarves@vger.kernel.org>; Wed,  2 Sep 2026 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355705; cv=none; b=sOyAwPJoph3NdP2thD37DbYZkNuZooMChjjJ+iyQXSCEUGcnUnhTbclP2nqJx5qGpv0yzov/O3W1rC/kUIT/UfHCzcZRHtqobPGDTKaqwT/pRwKPhFGq9orYpGqeEkFYESl4K/nfzkM96xPb0xKqFTyz9keMCVYS/e3yVkBvpeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355705; c=relaxed/simple;
	bh=hJAXtVgFt/P1XGvUScZCHBNwcTmswKjSiUSsoXtW3Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAXTL+ABoOi8PKHVsfy3S58OV0ikGWXp0GlcYekTTkBTPRd79qejqy3e+GzPvKOgiCzh+9TKrK6nK7gboSqWFxZdfnHnEkDz2ZHbPzne1uBwEaMGTbQSmfgyAKf6KhfoGYpa+v1RDRKKZjr8wmzqe2EvrOl5mPacAQZ1jAx8EWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YmRTbrc7; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YmRTbrc7"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6821WIWJ1380870;
	Wed, 2 Sep 2026 13:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=9XizF
	z6rxQ2a4UxJqzVsxi0UTeDQCWLE5zTRPizXH/w=; b=YmRTbrc7R9SjMdlHCi9Za
	uHaocUt3O8ovDookwvHdotaiS2C+/YlZCCCwMlLbCWvCS11nUnsuyGeh3l+c7zeb
	sZ5xUfVeLafkW4oxbPx/4GCXIBhof7jL80MKAVPh9jRqluUn+mO4eVzAKb03roKG
	jOI8gfXwmu0IuDR3BxMCwNt8wFahq8rbw6xcANYpe9feQYXX+p22p+mJk6ltOR4Q
	L/jiopUsfvZFkgPyWE9Nbslnsef+ZHzo+6SS+GhcvjucScD4T/hQVqTGFdVF9Z77
	OWFfKqN44j9qs3C5JHkbuRlI0vJe/T5U06PBAxdg+jEg8pAEf/JA8akE8L6QE2f9
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbqa7pv3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Sep 2026 13:28:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 682DOt6N007249;
	Wed, 2 Sep 2026 13:28:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvfsr1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Sep 2026 13:28:21 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 682DPWZJ010350;
	Wed, 2 Sep 2026 13:28:21 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-253.vpn.oracle.com [10.154.52.253])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4gbnvfsr0u-2;
	Wed, 02 Sep 2026 13:28:20 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 2/3] tests: Add pfunct split BTF test to btf_split
Date: Wed,  2 Sep 2026 14:28:17 +0100
Message-ID: <20260902132818.1361588-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260902132818.1361588-1-alan.maguire@oracle.com>
References: <20260902132818.1361588-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2609020119
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDExOSBTYWx0ZWRfXzThp+SlqBhgo
 MMRoM59oOFT/heVw7DLF2CDr6IJXEHplKBLcLXfpMhHt1ez/rD0LxTtw87SFDfQ7qh25JeVFoR1
 FJWl8Mq9tC9ROvu3TKiDO7gIpGY5mU07nEOEZNMdOjGsa+0kCG3h
X-Proofpoint-GUID: iaBm2jPPdqmN2PfraCfHzKW3vXgrW-Qc
X-Authority-Analysis: v=2.4 cv=DPu/JSNb c=1 sm=1 tr=0 ts=6a982476 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=hhxKcpFJKLJqryVmuo4A:9
X-Proofpoint-ORIG-GUID: iaBm2jPPdqmN2PfraCfHzKW3vXgrW-Qc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDExOSBTYWx0ZWRfXxphEAVJdTS6d
 JZyJJcO0lNopIT4VJUjrVIpdjn32nfAGx410HPUtKAlE1IxZuAWA8zxAanqSf8Ydby1o0tSY0Oe
 A5+qt9bNo1yyvbOpSCxRwBObgvGtv/i2sDBU2wOfVR82smP9uVTtLp83kiUFthfbDFuOg0LVwD7
 +sEpeL+zpdTNtqaJ82dWryFmOjHTSDXREe7wLmTYRZB5hPr9TAlzJYjGuHNTsSPK2gasiXbpy8y
 8+eXNTWcdkJMwqvLuYuiGqqjt+llL5/mBgfYhsljdZQHBih+jdVQKhtfz7Q5AC9WtwrfXses/nE
 zvI/1HdeFN8Da3qrx2h48yPdcDUItXFNOQ0kKUrxx2AK5iBc/xYb44gIMhrTnb8zYfmCR/Up6ql
 2tK3uedIvfm96hCUULm0hD/ICoJuJYy964EWKrawHzYoCC60AonfRjyYIBodWOstQm8Ukt59Q9I
 22ME2oX4+uQFMc8vAsw==

Validate newly-added --btf_base pfunct support.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tests/btf_split.sh | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tests/btf_split.sh b/tests/btf_split.sh
index 135f721..09329fd 100755
--- a/tests/btf_split.sh
+++ b/tests/btf_split.sh
@@ -14,6 +14,7 @@
 #  3. bpftool -B can resolve and dump the split BTF using the base BTF
 #  4. split BTF type IDs start strictly above the vmlinux type count
 #     (i.e. the module references base types by the correct offset)
+#  5. pfunct can load the split BTF using the base BTF
 #
 # Requirements:
 #  - bpftool with --base-btf (-B) support
@@ -29,7 +30,7 @@ trap cleanup EXIT
 
 title_log "Split BTF encoding (vmlinux base + kernel module)."
 
-for cmd in bpftool python3 debuginfod-find; do
+for cmd in bpftool pfunct python3 debuginfod-find; do
 	if ! command -v "$cmd" > /dev/null 2>&1; then
 		info_log "skip: $cmd not available"
 		test_skip
@@ -147,4 +148,17 @@ if [ "$first_split_id" -le "$last_base_id" ]; then
 fi
 info_log "split type IDs ($first_split_id+) above last base type ID ($last_base_id): ok"
 
+# --- Check 4: pfunct can load the split BTF with its base ---
+
+if ! pfunct --btf_base="$base_btf" --all "$split_btf" > "$outdir/pfunct.out" 2>&1; then
+	error_log "FAIL: pfunct could not load split BTF with its base"
+	cat "$outdir/pfunct.out" >&2
+	test_fail
+fi
+if ! [ -s "$outdir/pfunct.out" ]; then
+	error_log "FAIL: pfunct produced no output for split BTF"
+	test_fail
+fi
+info_log "pfunct split BTF loading: ok"
+
 test_pass
-- 
2.43.5

