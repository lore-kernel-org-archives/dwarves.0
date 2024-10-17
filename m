Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1461D88C1
	for <dwarves@vger.kernel.org>; Thu, 17 Oct 2024 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729157086; cv=none; b=VSNzhnpEv20xitB1b12qpcz3m4BnvG0helbqVnv3Ucs/8fz8I2XuzqQU/lSSwKsw0AeppYBgpLt1zuulvCS2fO+Rxaj+hadaz6wEB7IeQRuhDidgH+35XXJEXnWyt5DZfE6bZr3RAh+9Q2RrI61jnuHFwFeRJwRCT1TunvlJczE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729157086; c=relaxed/simple;
	bh=ipzfkDMTJhiKHjcKmwPEpIFHQuvTX03PgGe8hLcKsLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taGIU+xu77BMB3VZvDSwy1cwIaTHWELvR4s/cQoJAkQoJl0mKsl1Cu3xXY10+SFRLsqU8yDgDsRInpfc+o7OmV6kr0iUIJu3ss1NN2mhbB9Q5svm0Lwdxwi4xDvRbCHgQqrtu/v2HWSPm3CtSomIj2b+MxPhdxUjp4WbYmHZcEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vv9YAjo0; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vv9YAjo0"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H9MdnD003351;
	Thu, 17 Oct 2024 09:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=YoOQz
	gTygT0UqAHOMNgOrqQbpa0VHL8HuOLAl/7jQ8w=; b=Vv9YAjo08gXo9yPzAYiG5
	SwSwfmewg9bbnafNipTBIr4RHwyK8rMhrBwj9G+h+Qy7M71zPC50QoxdPjZF9+G4
	Y1xb41n3+ChysxWo4RTzmSbZ4dPGMlxStOzlRkYy2fHW7+nKjooE4wbe+oQzWFno
	3z82LnSVYBt1DxzQtWeXbnaVI7xCU+EVHvZULoxXkyiDHTqO4xK0Cg9MP6L91/nY
	ozIJ8454p5iUgy1mcA2HRZlkVMS5BNt+OzGBT0TskfWjBTnpzrwr9AdQBUocnZnI
	ASVW6xd0pDyhM3Hnj225y0zDiYpAmpMfHwAQJwWKz1SgBEmfJCeFXwBbXiKnDeOh
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hntdwh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 09:24:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49H7WjV9019919;
	Thu, 17 Oct 2024 09:24:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj9yd91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 09:24:37 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49H9OZFZ013396;
	Thu, 17 Oct 2024 09:24:37 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-205-31.vpn.oracle.com [10.175.205.31])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 427fj9yd84-2;
	Thu, 17 Oct 2024 09:24:37 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, eddyz87@gmail.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 2/2] tests/btf_functions: redirect stderr for pfunct --format_path=btf
Date: Thu, 17 Oct 2024 10:24:33 +0100
Message-ID: <20241017092433.690192-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241017092433.690192-1-alan.maguire@oracle.com>
References: <20241017092433.690192-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_09,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=901 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170063
X-Proofpoint-ORIG-GUID: qjSR5cLrjBXI182dV_ECdz-K679M02PK
X-Proofpoint-GUID: qjSR5cLrjBXI182dV_ECdz-K679M02PK

...since otherwise we will see the following during test execution

WARNING: still unsuported BTF_KIND_DECL_TAG(bpf_fastcall) for bpf_iter_css_task_next already with attribute (bpf_kfunc), ignoring
WARNING: still unsuported BTF_KIND_DECL_TAG(bpf_fastcall) for bpf_iter_bits_new already with attribute (bpf_kfunc), ignoring

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tests/btf_functions.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
index 5794be9..1a28923 100755
--- a/tests/btf_functions.sh
+++ b/tests/btf_functions.sh
@@ -53,13 +53,13 @@ pahole --btf_features=default --btf_encode_detached=$outdir/vmlinux.btf --verbos
 
 test -n "$VERBOSE" && printf "done.\n"
 
-funcs=$(pfunct --format_path=btf $outdir/vmlinux.btf |sort)
+funcs=$(pfunct --format_path=btf $outdir/vmlinux.btf 2>/dev/null|sort)
 
 # all functions from DWARF; some inline functions are not inlined so include them too
 pfunct --all --no_parm_names --format_path=dwarf $vmlinux | \
 	sort|uniq > $outdir/dwarf.funcs
 # all functions from BTF (removing bpf_kfunc prefix where found)
-pfunct --all --no_parm_names --format_path=btf $outdir/vmlinux.btf |\
+pfunct --all --no_parm_names --format_path=btf $outdir/vmlinux.btf 2>/dev/null|\
 	awk '{ gsub("^bpf_kfunc ",""); print $0}'|sort|uniq > $outdir/btf.funcs
 
 exact=0
-- 
2.43.5

