Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F3427462
	for <dwarves@vger.kernel.org>; Mon, 30 Sep 2024 08:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727684286; cv=none; b=pS4N/ckIdnCMQfdF7Z5fbNF6UT9s1UHxipAWbuUl7Vmu0cyxsqyEZcZ26dNYgxMBvVk4/wlMH9aknN6x7IPEEGJm1nGw2xW4rCLHmuLgw0feFfoml5j3gVXj/hlPT0I4ygnvMw0txuCuhYFkmv5LlvCTZeBwmehjcpFA2UEqIgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727684286; c=relaxed/simple;
	bh=Xk0rLUJOvogzdanGLqVfWuuSvzQnuoR4ioCu5hT7lmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHAzvP2adw/ePCG8iRtADXoq/mvrQsxHeUKRCpwR5GImLNPUXiae90i6UCq8mNPcWCV0rIVA+i6S/l9W7YBpoIjW1woOcAAx4Z7r7DlRua9WQsi7IDEt8V+GKBlw3DnQ/AI0Lk8UEhUTs7vw7K0RgbiGG4Z1uk0Xqh+i9v0bVVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P9cHl747; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P9cHl747"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U2thSN009535;
	Mon, 30 Sep 2024 08:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=K
	VNrjmpDesL7lT2N0uJFfCce3izG0sAz/JpnM30+SlE=; b=P9cHl7475ilkpc2oQ
	BmJRaR4Tkt7ox1vnXR0UvvhoS5thJoM6CUl2r44DNsaMpdBHt5JRWD/QaULPLpp2
	ufEG4QlrG4RIabFocRreZNQT9sVNBjMKhfweKP6RGqu1xtBvAfRVg+W/VxEeLn6W
	cBxhnKBh1jLOYhI48vubAy5hG2u6cGyxRTTCeb/32l4ENb0tQ97aBgMWsupeWbPF
	W8i8aVBGhw9sA9cG+Tza1l9MjZO1t0bR3RxqJjNuJsJyqtMdQItyqbxIRfNpbx1A
	37DcYaMq8U17SMpdc/26j0KBHfloP0cGrWE/QVwJcYsRxAqdGZBxDQEdK7dARsYx
	1Bvyw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8k32pt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 08:17:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48U7qEde040759;
	Mon, 30 Sep 2024 08:17:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x885qhgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 08:17:33 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48U8HSoE017104;
	Mon, 30 Sep 2024 08:17:33 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-219-134.vpn.oracle.com [10.175.219.134])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41x885qheg-3;
	Mon, 30 Sep 2024 08:17:33 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, eddyz87@gmail.com, olsajiri@gmail.com,
        shung-hsi.yu@suse.com, jirislaby@kernel.org, sedat.dilek@gmail.com,
        w@1wt.eu, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 dwarves 2/2] tests: improve btf_functions.sh by reducing greps/pipes
Date: Mon, 30 Sep 2024 09:17:25 +0100
Message-ID: <20240930081725.2465825-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240930081725.2465825-1-alan.maguire@oracle.com>
References: <20240930081725.2465825-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-30_07,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409300059
X-Proofpoint-GUID: 5p4V3kFU7kZnl5DL2h8_rB2Mwn7r5f7A
X-Proofpoint-ORIG-GUID: 5p4V3kFU7kZnl5DL2h8_rB2Mwn7r5f7A

Reduce number of greps/pipes to minimize overhead of test; in my
measurements this shaves ~1min off test run time to be approximately
4 minutes.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tests/btf_functions.sh | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
index 4a60a18..b8645cc 100755
--- a/tests/btf_functions.sh
+++ b/tests/btf_functions.sh
@@ -47,7 +47,8 @@ trap cleanup EXIT
 
 test -n "$VERBOSE" && printf "Encoding..."
 
-pahole --btf_features=default --btf_encode_detached=$outdir/vmlinux.btf --verbose $vmlinux |grep "skipping BTF encoding of function" > ${outdir}/skipped_fns
+pahole --btf_features=default --btf_encode_detached=$outdir/vmlinux.btf --verbose $vmlinux |\
+	grep "skipping BTF encoding of function" > ${outdir}/skipped_fns
 
 test -n "$VERBOSE" && printf "done.\n"
 
@@ -57,7 +58,7 @@ funcs=$(pfunct --format_path=btf $outdir/vmlinux.btf |sort)
 
 # all functions from DWARF; some inline functions are not inlined so include them too
 pfunct --all --no_parm_names --format_path=dwarf $vmlinux | \
-	awk '{ print $0}'|sort|uniq > $outdir/dwarf.funcs
+	sort|uniq > $outdir/dwarf.funcs
 # all functions from BTF (removing bpf_kfunc prefix where found)
 pfunct --all --no_parm_names --format_path=btf $outdir/vmlinux.btf |\
 	awk '{ gsub("^bpf_kfunc ",""); print $0}'|sort|uniq > $outdir/btf.funcs
@@ -66,14 +67,12 @@ exact=0
 inline=0
 const_insensitive=0
 
-for f in $funcs ; do
-	btf=$(grep " $f(" $outdir/btf.funcs)
+while IFS= read -r btf ; do
 	# look for non-inline match first
-	dwarf=$(grep " $f(" $outdir/dwarf.funcs | grep -Ev "^inline ")
+	dwarf=$(grep -F "$btf" $outdir/dwarf.funcs)
 	if [[ "$btf" != "$dwarf" ]]; then
 		# function might be declared inline in DWARF.
-		inline_dwarf=$(grep " $f(" $outdir/dwarf.funcs |grep "^inline ")
-		if [[ "inline $btf" != "$inline_dwarf" ]]; then
+		if [[ "inline $btf" != "$dwarf" ]]; then
 			# some functions have multiple instances in DWARF where one has
 			# const param(s) and another does not (see errpos()).  We do not
 			# mark these functions inconsistent as though they technically
@@ -83,7 +82,7 @@ for f in $funcs ; do
 			if [[ "$dwarf_noconst" =~ "$btf_noconst" ]]; then
 				const_insensitive=$((const_insensitive+1))
 			else
-				echo "ERROR: mismatch for '$f()' : BTF '$btf' not found; DWARF '$dwarf'"
+				echo "ERROR: mismatch : BTF '$btf' not found; DWARF '$dwarf'"
 				fail
 			fi
 		else
@@ -92,7 +91,7 @@ for f in $funcs ; do
 	else
 		exact=$((exact+1))
 	fi
-done
+done < $outdir/btf.funcs
 
 echo "Matched $exact functions exactly."
 echo "Matched $inline functions with inlines."
@@ -133,8 +132,6 @@ for r in $return_mismatches ; do
 	grep " $r(" $outdir/dwarf.funcs | \
 	awk -v FN=$r '{i = index($0, FN); if (i>0) print substr($0, 0, i-1) }' \
 	| uniq > ${outdir}/retvals.$r
-	test -n "$VERBOSE" && echo "'${r}()' has return values:"
-	test -n "$VERBOSE" && cat ${outdir}/retvals.$r
 	cnt=$(wc -l ${outdir}/retvals.$r | awk '{ print $1 }')
 	if [[ $cnt -lt 2 ]]; then
 		echo "ERROR: '${r}()' has only one return value; it should not be reported as having incompatible return values"
@@ -159,14 +156,11 @@ for p in $param_mismatches ; do
 	skipmsg=$(awk -v FN=$p '{ if ($1 == FN) print $0 }' $outdir/skipped_fns)
 	altname=$(echo $skipmsg | awk '{ i=index($2,")"); print substr($2,2,i-2); }')
 	if [[ "$altname" != "$p" ]]; then
-		test -n "$VERBOSE" && echo "skipping optimized function $p ($altname); pfunct may not reflect late optimizations."
 		optimized=$((optimized+1))
 		continue
 	fi
 	# Ensure there are multiple instances with incompatible params
 	grep " $p(" $outdir/dwarf.funcs | uniq > ${outdir}/protos.$p
-	test -n "$VERBOSE" && echo "'${p}()' has prototypes:"
-	test -n "$VERBOSE" && cat ${outdir}/protos.$p
 	cnt=$(wc -l ${outdir}/protos.$p | awk '{ print $1 }')
 	if [[ $cnt -lt 2 ]]; then
 		# function may be inlined in multiple sites with different protos
-- 
2.43.5

