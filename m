Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13C5155A59
	for <dwarves@vger.kernel.org>; Mon, 16 Sep 2024 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726494606; cv=none; b=I84esrVsSqFJ8s4nphym0Gdk1LfqwvSUCWVYFNRRaQqlYjgo33d54O7fW7KnlOLEtm8TK587Ycsd5Mpl8fdmdJqREzBN3cOw97U8WcuXziQimi43dn/1w962pdZ6Pr2vc4+QtBMgc43Zi+tfQKMCsMZ7uhWeZBBPQVydztrogf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726494606; c=relaxed/simple;
	bh=+s+Ee+3y6bUOWtemJgNU8Z52Mgp41iJr5ili6CyiAX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqfXHx2w6SO9/sm2Oz0Ph6h+0Sy1sRq0j23igpPkns0hhJjBl4qXzavZ+5lKS5gJ1jMsZwlEBn8gSniGSVy/DXqi72mIW/DxOQ05H7allhC0hKvxNm1t3Ng9vVEzw9Erq+I+k9B81jz//IEzDjbvkN3f/1vtE6s5mQ9qUfusCS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KuBt1ZYI; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KuBt1ZYI"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GCC1Kv014448;
	Mon, 16 Sep 2024 13:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=P
	xGfPaQ7Q/83lKH4ktJaEDKuFnsWBjJZMZDAvUwNZXM=; b=KuBt1ZYIuC8O3cmv+
	eNDlL9LeC0Yd38MTVdV6ZaNTadWpZ5qQuO7OJhZ+RAxb4iDyeMieLrBHBRtLisrf
	rpgQEz/Yf/oiMUBDPwObKyeOIGZ0VyLmNiT8Az6mXvwhGx6gK/VlkgJUA4oJFCBm
	FHZTOmfS4gOzUM5zKIGcOO0sQMByEjwW0XPcnB7RMOnOfyagoM4qCcnwRdnMWdac
	h6zlKJa5gdAhfTxnnhBbSP64L6ltpmnI9rjGd+kpXHQtr88YGnlOhG4WEH1F1QFi
	UwDIy4mRMs6g3lkriaeYYiGgHhAUlyN8XuyUiVdgl8Sw8Us9x2x32myXB4qPNmDh
	ECKcw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3rwuaxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 13:49:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48GDPUaw017884;
	Mon, 16 Sep 2024 13:49:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nycvcbkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 13:49:58 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48GDlw0u019465;
	Mon, 16 Sep 2024 13:49:57 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-208-154.vpn.oracle.com [10.175.208.154])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41nycvcbbr-4;
	Mon, 16 Sep 2024 13:49:57 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, eddyz87@gmail.com, olsajiri@gmail.com,
        shung-hsi.yu@suse.com, jirislaby@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 3/3] tests: add test validating BTF encoding, reasons we skip functions
Date: Mon, 16 Sep 2024 14:49:46 +0100
Message-ID: <20240916134946.3893204-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240916134946.3893204-1-alan.maguire@oracle.com>
References: <20240916134946.3893204-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_10,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409160088
X-Proofpoint-GUID: v_NgVRsDQgscJxiZz2eyISxjRpx6GoPe
X-Proofpoint-ORIG-GUID: v_NgVRsDQgscJxiZz2eyISxjRpx6GoPe

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

The test takes ~5 minutes to run in all; output looks like this:

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
Ok

Suggested-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tests/btf_functions.sh | 192 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 192 insertions(+)
 create mode 100755 tests/btf_functions.sh

diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
new file mode 100755
index 0000000..4509407
--- /dev/null
+++ b/tests/btf_functions.sh
@@ -0,0 +1,192 @@
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
+pahole --btf_features=default --btf_encode_detached=$outdir/vmlinux.btf --verbose $vmlinux |grep "skipping BTF encoding of function" > ${outdir}/skipped_fns
+
+test -n "$VERBOSE" && printf "done.\n"
+
+echo "Validation of BTF encoding of functions; this may take some time..."
+
+funcs=$(pfunct --format_path=btf $outdir/vmlinux.btf |sort)
+
+# all functions from DWARF; some inline functions are not inlined so include them too
+pfunct --all --no_parm_names --format_path=dwarf $vmlinux | \
+	awk '{ print $0}'|sort|uniq > $outdir/dwarf.funcs
+# all functions from BTF (removing bpf_kfunc prefix where found)
+pfunct --all --no_parm_names --format_path=btf $outdir/vmlinux.btf |\
+	awk '{ gsub("^bpf_kfunc ",""); print $0}'|sort|uniq > $outdir/btf.funcs
+
+exact=0
+inline=0
+const_insensitive=0
+
+for f in $funcs ; do
+	btf=$(grep " $f(" $outdir/btf.funcs)
+	# look for non-inline match first
+	dwarf=$(grep " $f(" $outdir/dwarf.funcs |egrep -v "^inline ")
+	if [[ "$btf" != "$dwarf" ]]; then
+		# function might be declared inline in DWARF.
+		inline_dwarf=$(grep " $f(" $outdir/dwarf.funcs |grep "^inline ")
+		if [[ "inline $btf" != "$inline_dwarf" ]]; then
+			# some functions have multiple instances in DWARF where one has
+			# const param(s) and another does not (see errpos()).  We do not
+			# mark these functions inconsistent as though they technically
+			# have different prototypes, the data itself is not different.
+			btf_noconst=$(echo $btf | awk '{gsub("const ",""); print $0 }')
+			dwarf_noconst=$(echo $dwarf | awk '{gsub("const ",""); print $0 }')
+			if [[ "$dwarf_noconst" =~ "$btf_noconst" ]]; then
+				const_insensitive=$((const_insensitive+1))
+			else
+				echo "ERROR: mismatch for '$f()' : BTF '$btf' not found; DWARF '$dwarf'"
+				fail
+			fi
+		else
+			inline=$((inline+1))
+		fi
+	else
+		exact=$((exact+1))
+	fi
+done
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
+	test -n "$VERBOSE" && echo "'${r}()' has return values:"
+	test -n "$VERBOSE" && cat ${outdir}/retvals.$r
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
+		test -n "$VERBOSE" && echo "skipping optimized function $p ($altname); pfunct may not reflect late optimizations."
+		optimized=$((optimized+1))
+		continue
+	fi
+	# Ensure there are multiple instances with incompatible params
+	grep " $p(" $outdir/dwarf.funcs | uniq > ${outdir}/protos.$p
+	test -n "$VERBOSE" && echo "'${p}()' has prototypes:"
+	test -n "$VERBOSE" && cat ${outdir}/protos.$p
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

