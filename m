Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EB61537B9
	for <dwarves@vger.kernel.org>; Wed, 25 Sep 2024 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727255875; cv=none; b=FMZ1IiDRNgXbsatXYgyWEyUYGF/242J7JYO/nwrPiYpBg0lZajyX0QYZWcIlPSze2gF1bpmGriW7JnxDl279EQxSVeGwyFcY46F3m8Z6m4kSemoChd8PwK6Ia0VklPJ4vzjyfx5QKEy/ssnhNSx36tJMtkQgv5ZJXDMBOy9+oP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727255875; c=relaxed/simple;
	bh=df5/XwAj0PGuEOBeLRy9l67jdQENvIrb3bbxKBPbdoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuBiKUFs8HRjX+lfKvGk8bRLpgv9GEq9owb6f4uH+cV8r4oZqjhihPENqLhoTOR69ApnJyBMiFtjCr/keo6kfnWPy8zcSuqObvwxgbzDvARAnmjHtWIMipsybI3a/IfQ4tua3hSKWfQy0YavbB23j/YWB2ii1HkfF5m/4ANHvvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Td/5DL7O; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Td/5DL7O"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48P1tbWU013132;
	Wed, 25 Sep 2024 09:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=c
	m5mEZMKqrYjLsbsfRIlAQmgbbKIDSjMd1EKMnXCJBw=; b=Td/5DL7Oh9n/P1jGQ
	Zd7p+4ogscVJEFirD795bBXzJbwPfyBjU927L1C9CRCjC9qFIf+6q/shiBc0Ewlg
	ddwyqztGYXuqtGNJpGEqnHZ16huGNRmuHLh4rlXJRvLsqpUxH9FcDoAdaKhsGCgD
	TZx4wCbmUniQV2eAMUVqPgzglOlMoQkX4Ld59KhzBD2gq16Pf+mVc6W+t40UFaKG
	+EHAP39hHOddHsfXXV6hYWx1ic9zsVCBpfPv8+1TRmOBgFHiu3mU/59u1+p9JPTm
	xB96SIlNbm2Dvnn0d9DJ1iOjaBnfxG7Rw7d7nsMIHAsMaJuAVXniBjwy6OF7KwNJ
	t/2rQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp1ahqkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 09:17:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48P7U8aK025184;
	Wed, 25 Sep 2024 09:17:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkaetws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 09:17:41 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48P9Fli5007041;
	Wed, 25 Sep 2024 09:17:41 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-212-44.vpn.oracle.com [10.175.212.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41smkaettn-4;
	Wed, 25 Sep 2024 09:17:41 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, eddyz87@gmail.com, olsajiri@gmail.com,
        shung-hsi.yu@suse.com, jirislaby@kernel.org, sedat.dilek@gmail.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 3/3] tests: add test validating BTF encoding, reasons we skip functions
Date: Wed, 25 Sep 2024 10:17:34 +0100
Message-ID: <20240925091734.1943742-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240925091734.1943742-1-alan.maguire@oracle.com>
References: <20240925091734.1943742-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-25_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409250065
X-Proofpoint-ORIG-GUID: vJ0pd7mQRUOw04LdOF5VSy5pyZPMjD6B
X-Proofpoint-GUID: vJ0pd7mQRUOw04LdOF5VSy5pyZPMjD6B

use pahole to encode BTF and pfunct to check that

- DWARF functions that made it into BTF match signatures
- for functions we say we skipped, we did indeed skip them in BTF
  encoding; and
- it was correct to skip these functions

It is not possible to check everything, as pfunct does not
print "."-suffixed optimized representations, and it does not
analyze location calling conventions.  As a starting point we check
for

- functions encoded in BTF match signatures with DWARF
- functions with multiple incompatible return values
- functions with incompatible parameter count/type

This test automates manual validation of encoding/skipping,
and as such will be useful to ensure regressions are not
introduced, for comparing gcc/LLVM-based DWARF representations
etc.

The test takes ~4 minutes to run in all; output looks like this:

$ vmlinux=~/kbuild/bpf-next/vmlinux bash ./btf_functions.sh
Validation of BTF encoding of functions; this may take some time...
Matched 55969 functions exactly.
Matched 239 functions with inlines.
Matched 1 functions with multiple const/non-const instances.
Ok
Validation of skipped function logic...
Validating skipped functions are absent from BTF...
Skipped encoding 748 functions in BTF.
Ok
Validating skipped functions have incompatible return values...
Found 8 functions with multiple incompatible return values.
Ok
Validating skipped functions have incompatible params/counts...
Found 116 instances with multiple instances with incompatible parameters.
Found 2 instances where inline functions were not inlined and had incompatible parameters.
Found 351 instances where the function name suggests optimizations led to inconsistent parameters.
Found 0 instances where pfunct did not notice inconsistencies.
Ok

Suggested-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tests/btf_functions.sh | 186 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 186 insertions(+)
 create mode 100755 tests/btf_functions.sh

diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
new file mode 100755
index 0000000..b8645cc
--- /dev/null
+++ b/tests/btf_functions.sh
@@ -0,0 +1,186 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (c) 2024, Oracle and/or its affiliates.
+#
+# Examine functions - especially those for which we skipped BTF encoding -
+# to validate that they were indeed skipped for BTF encoding, and that they
+# also should have been.
+#
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
+vmlinux=${vmlinux:-$1}
+
+if [ -z "$vmlinux" ] ; then
+	vmlinux=$(pahole --running_kernel_vmlinux)
+	if [ -z "$vmlinux" ] ; then
+		echo "Please specify a vmlinux file to operate on"
+		exit 1
+	fi
+fi
+
+if [ ! -f "$vmlinux" ] ; then
+	echo "$vmlinux file not available, please specify another"
+	exit 1
+fi
+
+outdir=$(mktemp -d /tmp/btf_functions.sh.XXXXXX)
+
+trap cleanup EXIT
+
+test -n "$VERBOSE" && printf "Encoding..."
+
+pahole --btf_features=default --btf_encode_detached=$outdir/vmlinux.btf --verbose $vmlinux |\
+	grep "skipping BTF encoding of function" > ${outdir}/skipped_fns
+
+test -n "$VERBOSE" && printf "done.\n"
+
+echo "Validation of BTF encoding of functions; this may take some time..."
+
+funcs=$(pfunct --format_path=btf $outdir/vmlinux.btf |sort)
+
+# all functions from DWARF; some inline functions are not inlined so include them too
+pfunct --all --no_parm_names --format_path=dwarf $vmlinux | \
+	sort|uniq > $outdir/dwarf.funcs
+# all functions from BTF (removing bpf_kfunc prefix where found)
+pfunct --all --no_parm_names --format_path=btf $outdir/vmlinux.btf |\
+	awk '{ gsub("^bpf_kfunc ",""); print $0}'|sort|uniq > $outdir/btf.funcs
+
+exact=0
+inline=0
+const_insensitive=0
+
+while IFS= read -r btf ; do
+	# look for non-inline match first
+	dwarf=$(grep -F "$btf" $outdir/dwarf.funcs)
+	if [[ "$btf" != "$dwarf" ]]; then
+		# function might be declared inline in DWARF.
+		if [[ "inline $btf" != "$dwarf" ]]; then
+			# some functions have multiple instances in DWARF where one has
+			# const param(s) and another does not (see errpos()).  We do not
+			# mark these functions inconsistent as though they technically
+			# have different prototypes, the data itself is not different.
+			btf_noconst=$(echo $btf | awk '{gsub("const ",""); print $0 }')
+			dwarf_noconst=$(echo $dwarf | awk '{gsub("const ",""); print $0 }')
+			if [[ "$dwarf_noconst" =~ "$btf_noconst" ]]; then
+				const_insensitive=$((const_insensitive+1))
+			else
+				echo "ERROR: mismatch : BTF '$btf' not found; DWARF '$dwarf'"
+				fail
+			fi
+		else
+			inline=$((inline+1))
+		fi
+	else
+		exact=$((exact+1))
+	fi
+done < $outdir/btf.funcs
+
+echo "Matched $exact functions exactly."
+echo "Matched $inline functions with inlines."
+echo "Matched $const_insensitive functions with multiple const/non-const instances."
+echo "Ok"
+
+echo "Validation of skipped function logic..."
+
+skipped_cnt=$(wc -l ${outdir}/skipped_fns | awk '{ print $1}')
+
+if [[ "$skipped_cnt" == "0" ]]; then
+	echo "No skipped functions.  Done."
+	exit 0
+fi
+
+echo "Validating skipped functions are absent from BTF..."
+
+skipped_fns=$(awk '{print $1}' $outdir/skipped_fns)
+for s in $skipped_fns ; do
+	# Ensure the skipped function are not in BTF
+	inbtf=$(grep " $s(" $outdir/btf.funcs)
+	if [[ -n "$inbtf" ]]; then
+		echo "ERROR: '${s}()' was added incorrectly to BTF: '$inbtf'"
+		fail
+	fi
+done
+
+echo "Skipped encoding $skipped_cnt functions in BTF."
+echo "Ok"
+
+echo "Validating skipped functions have incompatible return values..."
+
+return_mismatches=$(awk '/return type mismatch/ { print $1 }' $outdir/skipped_fns)
+return_count=0
+
+for r in $return_mismatches ; do
+	# Ensure there are multiple instances with incompatible return values
+	grep " $r(" $outdir/dwarf.funcs | \
+	awk -v FN=$r '{i = index($0, FN); if (i>0) print substr($0, 0, i-1) }' \
+	| uniq > ${outdir}/retvals.$r
+	cnt=$(wc -l ${outdir}/retvals.$r | awk '{ print $1 }')
+	if [[ $cnt -lt 2 ]]; then
+		echo "ERROR: '${r}()' has only one return value; it should not be reported as having incompatible return values"
+		fail
+	fi
+	return_count=$((return_count+1))
+done
+
+echo "Found $return_count functions with multiple incompatible return values."
+echo "Ok"
+
+echo "Validating skipped functions have incompatible params/counts..."
+
+param_mismatches=$(awk '/due to param / { print $1 }' $outdir/skipped_fns)
+
+multiple=0
+multiple_inline=0
+optimized=0
+warnings=0
+
+for p in $param_mismatches ; do
+	skipmsg=$(awk -v FN=$p '{ if ($1 == FN) print $0 }' $outdir/skipped_fns)
+	altname=$(echo $skipmsg | awk '{ i=index($2,")"); print substr($2,2,i-2); }')
+	if [[ "$altname" != "$p" ]]; then
+		optimized=$((optimized+1))
+		continue
+	fi
+	# Ensure there are multiple instances with incompatible params
+	grep " $p(" $outdir/dwarf.funcs | uniq > ${outdir}/protos.$p
+	cnt=$(wc -l ${outdir}/protos.$p | awk '{ print $1 }')
+	if [[ $cnt -lt 2 ]]; then
+		# function may be inlined in multiple sites with different protos
+		inlined=$(grep inline ${outdir}/protos.$p)
+		if [[ -n "$inlined" ]]; then
+			multiple_inline=$((multiple_inline+1))
+		else
+			echo "WARN: '${p}()' has only one prototype; if it was subject to late optimization, pfunct may not reflect inconsistencies pahole found."
+			echo "Full skip message from pahole: $skipmsg"
+			warnings=$((warnings+1))
+		fi
+	else
+		multiple=$((multiple+1))
+	fi
+done
+
+echo "Found $multiple instances with multiple instances with incompatible parameters."
+echo "Found $multiple_inline instances where inline functions were not inlined and had incompatible parameters."
+echo "Found $optimized instances where the function name suggests optimizations led to inconsistent parameters."
+echo "Found $warnings instances where pfunct did not notice inconsistencies."
+echo "Ok"
+
+exit 0
-- 
2.43.5

