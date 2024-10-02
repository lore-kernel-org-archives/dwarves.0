Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C7212E1EE
	for <dwarves@vger.kernel.org>; Wed,  2 Oct 2024 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727868842; cv=none; b=e8TLMYdUPKOw1G4LQOm83GLltzAND0IeLKToTSsQaJ3K49o35hNB9J6Dgc2En6RYf5UjwbtIKqVx/T0XI9hxlKRbdp9H/4QipE7yfZLlFN1DHUqwyhbfJ0ycKCzkkEXf+MBPXjLEBD71zOWDE6rXvIyz8EiNUbu/+fnuzsXC+tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727868842; c=relaxed/simple;
	bh=9GyVsRpbz8gJybAk6i4ph2SIi5S0o9MJkuRFh+n6pDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZC19aUp6+5PlxK7kgpGa63j3eLyMIOvf8kei/RvT+z2A7m1aJJZJ1UL1brFuC/rhUgcvT0/QtDmG98WhSRCJI/ykwkG3GGVLMOYHIYjS+CUVyIKZ3/Kzo0tPICUChg42PmeFu2kCtBfyzaX1yUnb+XdQ3lQh4P3CnAsJpPWQpzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lZxnY4xf; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lZxnY4xf"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4927flPc010272;
	Wed, 2 Oct 2024 11:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=u
	LcqOo7Ne9rD0HYHGlWnwan5VXy0n7TBnyxDgC5hxow=; b=lZxnY4xfid4bQL9X1
	kUBsjBQ0IkblcCSaGF2jRx9K6NlXYRrb98pswBvCBwhvs5stlT43VY781WV1BrpL
	VrurrpcfrhuaUqXWpn/7lpzO0lFl2NRkdq36NRXhdewTwNaRcs7BQsZMHkY6hLHx
	iLemFFnOTsu2AWE9ZyPSF+4ciYsVTj6ojNOA5xyF8fSDSLo/Fkt1QHL7gWQYt3EV
	b6RwZHnIlLyeyYW0cbBs4ApFeMVUJGSz1IddvVIciGzvf1FS8WdtAYNl9PlZBS0J
	KZ5qYlTqmrZ+VeNHYdd5T/Et5sOjiXPXtOnAW5aPrmqCG6HVLMFsLm7oW+yj8OYY
	ZAZGw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41xabtrpmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 11:33:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492B10NY028553;
	Wed, 2 Oct 2024 11:33:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x888ykxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 11:33:43 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 492BXeQr004496;
	Wed, 2 Oct 2024 11:33:42 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-184-213.vpn.oracle.com [10.175.184.213])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41x888yksp-3;
	Wed, 02 Oct 2024 11:33:42 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH dwarves 2/2] tests/btf_functions: reduce verbosity of test
Date: Wed,  2 Oct 2024 12:33:26 +0100
Message-ID: <20241002113326.792495-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241002113326.792495-1-alan.maguire@oracle.com>
References: <20241002113326.792495-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_11,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020085
X-Proofpoint-ORIG-GUID: 2HP2sIR-LCbajxjMpGfNyHz1d78hD2nL
X-Proofpoint-GUID: 2HP2sIR-LCbajxjMpGfNyHz1d78hD2nL

when in non-verbose mode, emit a single line describing test + result.

Non-verbose output now looks like this:

  1: Validation of BTF encoding of functions; this may take some time: Ok

Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tests/btf_functions.sh | 54 +++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
index fbe68f9..5794be9 100755
--- a/tests/btf_functions.sh
+++ b/tests/btf_functions.sh
@@ -45,15 +45,14 @@ outdir=$(mktemp -d /tmp/btf_functions.sh.XXXXXX)
 
 trap cleanup EXIT
 
-test -n "$VERBOSE" && printf "Encoding..."
+echo -n "Validation of BTF encoding of functions; this may take some time: "
+test -n "$VERBOSE" && printf "\nEncoding..."
 
 pahole --btf_features=default --btf_encode_detached=$outdir/vmlinux.btf --verbose $vmlinux |\
 	grep "skipping BTF encoding of function" > ${outdir}/skipped_fns
 
 test -n "$VERBOSE" && printf "done.\n"
 
-echo "Validation of BTF encoding of functions; this may take some time..."
-
 funcs=$(pfunct --format_path=btf $outdir/vmlinux.btf |sort)
 
 # all functions from DWARF; some inline functions are not inlined so include them too
@@ -93,12 +92,13 @@ while IFS= read -r btf ; do
 	fi
 done < $outdir/btf.funcs
 
-echo "Matched $exact functions exactly."
-echo "Matched $inline functions with inlines."
-echo "Matched $const_insensitive functions with multiple const/non-const instances."
-echo "Ok"
-
-echo "Validation of skipped function logic..."
+if [[ -n "$VERBOSE" ]]; then
+	echo "Matched $exact functions exactly."
+	echo "Matched $inline functions with inlines."
+	echo "Matched $const_insensitive functions with multiple const/non-const instances."
+	echo "Ok"
+	echo "Validation of skipped function logic..."
+fi
 
 skipped_cnt=$(wc -l ${outdir}/skipped_fns | awk '{ print $1}')
 
@@ -107,8 +107,6 @@ if [[ "$skipped_cnt" == "0" ]]; then
 	exit 0
 fi
 
-echo "Validating skipped functions are absent from BTF..."
-
 skipped_fns=$(awk '{print $1}' $outdir/skipped_fns)
 for s in $skipped_fns ; do
 	# Ensure the skipped function are not in BTF
@@ -119,10 +117,11 @@ for s in $skipped_fns ; do
 	fi
 done
 
-echo "Skipped encoding $skipped_cnt functions in BTF."
-echo "Ok"
-
-echo "Validating skipped functions have incompatible return values..."
+if [[ -n "$VERBOSE" ]]; then
+	echo "Skipped encoding $skipped_cnt functions in BTF."
+	echo "Ok"
+	echo "Validating skipped functions have incompatible return values..."
+fi
 
 return_mismatches=$(awk '/return type mismatch/ { print $1 }' $outdir/skipped_fns)
 return_count=0
@@ -140,10 +139,11 @@ for r in $return_mismatches ; do
 	return_count=$((return_count+1))
 done
 
-echo "Found $return_count functions with multiple incompatible return values."
-echo "Ok"
-
-echo "Validating skipped functions have incompatible params/counts..."
+if [[ -n "$VERBOSE" ]]; then
+	echo "Found $return_count functions with multiple incompatible return values."
+	echo "Ok"
+	echo "Validating skipped functions have incompatible params/counts..."
+fi
 
 param_mismatches=$(awk '/due to param / { print $1 }' $outdir/skipped_fns)
 
@@ -168,8 +168,10 @@ for p in $param_mismatches ; do
 		if [[ -n "$inlined" ]]; then
 			multiple_inline=$((multiple_inline+1))
 		else
-			echo "WARN: '${p}()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found."
-			echo "Full skip message from pahole: $skipmsg"
+			if [[ -n "$VERBOSE" ]]; then
+				echo "WARN: '${p}()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found."
+				echo "Full skip message from pahole: $skipmsg"
+			fi
 			warnings=$((warnings+1))
 		fi
 	else
@@ -177,10 +179,12 @@ for p in $param_mismatches ; do
 	fi
 done
 
-echo "Found $multiple instances with multiple instances with incompatible parameters."
-echo "Found $multiple_inline instances where inline functions were not inlined and had incompatible parameters."
-echo "Found $optimized instances where the function name suggests optimizations led to inconsistent parameters."
-echo "Found $warnings instances where pfunct did not notice inconsistencies."
+if [[ -n "$VERBOSE" ]]; then
+	echo "Found $multiple instances with multiple instances with incompatible parameters."
+	echo "Found $multiple_inline instances where inline functions were not inlined and had incompatible parameters."
+	echo "Found $optimized instances where the function name suggests optimizations led to inconsistent parameters."
+	echo "Found $warnings instances where pfunct did not notice inconsistencies."
+fi
 echo "Ok"
 
 exit 0
-- 
2.43.5

