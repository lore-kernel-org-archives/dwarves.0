Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD581B85DB
	for <dwarves@vger.kernel.org>; Thu, 24 Oct 2024 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729769197; cv=none; b=YDS028c25bmwfscvlejNeIgCKfsYzHDTJ/cyV0zPI6OqdrMkh+pzpp4rOSjOHnIeSyr7wk7Cr7oMAvokKbJuEhwpoxLGhjG8KH7Fz91dhPKwPFXOthJz/4Z5SW+Q41eZLlduJoEteI4sZZBn4B9n06+NnZG/wXV3CYYBwNfCCgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729769197; c=relaxed/simple;
	bh=8PnOJ6jy58jpH3jGfPs+z8Amidi7YntR9KFgKpH91NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6pfo2T905+Gkhm9395j5GE7LnO+2ZNO6suFmKDArDhLzZeIOA/8Zm+MQdzvd9veKswa2eeoIIWXLIwoVwXWqOzPlmohsvtnRGm7+ESe0C9q8ItEvSSc6AH4CGCbcmrdHWRpUt55BJNMkM9qjGSP0exvTkxaTVCZanC+hsr/YxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DJYSuNeY; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DJYSuNeY"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49O2feUH024005;
	Thu, 24 Oct 2024 11:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=gUxnY
	wcdDPG03z61wJJFND86LtLKMuz/DOs8uYYEhlE=; b=DJYSuNeY9CiM90MYs/eoQ
	XJLyZlkUlJiBZFDIqgO1pe5PtSaggCWbbK308VHPbMDeVz/YFfDZ0QZ0JTGNTEub
	NUQ0mhD1LU0jbCfKYVvafiTYRoWbSUrsBSvoSKkmjQn7l1l9QK+F2vVZEQLvBLYV
	bP62Y8FWK3q5m8qaIX/f5w/jgA7Bkbg/eM5GIztxn7BuwHs+3oJH+XUCQ5qyaMcG
	t0R7bfPgT8Ew8rg60diM0/HJlmDIYMBuNewjf5TKe2OwaON6qIu3YmvFQ6hC63/r
	mSUrnmCeVA7/AugIB21Ei/jc47l/gYlqQTFTJb4C/rcVJxUwaW+LIJ6/maSSojWK
	w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42cqv3hfd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 11:26:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49OALHgg039579;
	Thu, 24 Oct 2024 11:26:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhcb9w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 11:26:18 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49OBMi2O005756;
	Thu, 24 Oct 2024 11:26:18 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-188-27.vpn.oracle.com [10.175.188.27])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42emhcb9un-3;
	Thu, 24 Oct 2024 11:26:18 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 2/2] tests/flexible_arrays: print flex array struct from same vmlinux
Date: Thu, 24 Oct 2024 12:26:15 +0100
Message-ID: <20241024112615.750704-3-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241024112615.750704-1-alan.maguire@oracle.com>
References: <20241024112615.750704-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_11,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410240093
X-Proofpoint-ORIG-GUID: dtYCp_S2YN5tZE-1-aBK-kJ_bvTrTPWp
X-Proofpoint-GUID: dtYCp_S2YN5tZE-1-aBK-kJ_bvTrTPWp

We get a list of flexible array structs from $vmlinux; use the
same $vmlinux to print each struct.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tests/flexible_arrays.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/flexible_arrays.sh b/tests/flexible_arrays.sh
index e9e3cb0..086db22 100755
--- a/tests/flexible_arrays.sh
+++ b/tests/flexible_arrays.sh
@@ -21,7 +21,7 @@ pretty=$(mktemp /tmp/flexible_arrays.data.sh.XXXXXX.c)
 echo -n "Flexible arrays accounting: "
 
 for struct in $(pahole -F btf --sizes --with_embedded_flexible_array $vmlinux 2>/dev/null| cut -f1) ; do
-	pahole $struct > $pretty
+	pahole $struct $vmlinux > $pretty
 
 	# We need to check for just one tab before the comment as when expanding unnamed
 	# structs with members with flexible arrays inside another struct we would mess
@@ -54,14 +54,14 @@ for struct in $(pahole -F btf --sizes --with_embedded_flexible_array $vmlinux 2>
 	if [ "$nr_embedded_flexible_arrays" != "$stat_nr_embedded_flexible_arrays" ] ; then
 		test -n "$VERBOSE" && printf "struct %s: The number of embedded flexible arrays (%s) doesn't match the number of members marked as such (%s)\n" \
 			"$struct" "$stat_nr_embedded_flexible_arrays" "$nr_embedded_flexible_arrays"
-		test -n "$VERBOSE" && pahole $struct
+		test -n "$VERBOSE" && pahole $struct $vmlinux
 		FAILED=1
 	fi
 
 	if [ "$nr_flexible_arrays" != "$stat_nr_flexible_arrays" ] ; then
 		test -n "$VERBOSE" && printf "struct %s: The number of flexible arrays (%s) doesn't match the number of members marked as such (%s)\n" \
 			"$struct" "$stat_nr_flexible_arrays" "$nr_flexible_arrays"
-		test -n "$VERBOSE" && pahole $struct
+		test -n "$VERBOSE" && pahole $struct $vmlinux
 		FAILED=1
 	fi
 
-- 
2.43.5

