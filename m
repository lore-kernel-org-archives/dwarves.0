Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0661B85DB
	for <dwarves@vger.kernel.org>; Thu, 24 Oct 2024 11:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729769184; cv=none; b=V7S5vN7ODefGYtmalL9Q68l6LC8pB0taIdvo+6nC0DMppCSO45UJo6SneAJxd+lEc22dJRGj8gtJyuRRpdgRx8lubvFhVeCKIE59nrisB4ouU9H3BevWb96eIzgPw7ZtpvaE3clMf2u/d1JHoqANuAH2USSXK4lIuFVl6Fy0kiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729769184; c=relaxed/simple;
	bh=A6UNIwcCjbhPkNCpivcp54r13Rc4wa1T+N/xYkld4O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBGlOlCz6J7w1NJMo+Y6QVkrJG7anbmv80BzE4nycExz4qsE89NYyRLC6qwAqJqafQAJmTmJUqXVIE311MiPONBXp2jEy8N8OGJSgF4Z4Jg95qXOL0rOQweJ2Dz6v1FlDcRjQbSJXFEUpOIxE73ezak3ZTsfqe4QVCHlB7zaZSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OMO3NvNz; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OMO3NvNz"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49O2frVG029917;
	Thu, 24 Oct 2024 11:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=XHa+B
	NvFU5TFENTFjQoCJ8tCN2twrejzi8Rgj51VxTc=; b=OMO3NvNz2Gi7pxolCvZJL
	RuPVn9yS4PwqbgvhUhgd3nKFLwGs5eWy4NekGBWR9lJMOELPTB9b/b5dwoRIeHA3
	End5F2vZxJw8zUPvht9N3yCC6GsiPA2H7Ny/QBNuzoB5mhOGmW6KFlFj/mxcgtOT
	l1SFeNClc6GFrUoyC/90dDqj+XWmGAqvQMdo1FpBx/NCAtSt4YkunPF4fLpDWNtS
	DLoAEoXJ4AYhd3237941o9Nwd6bVXGmKw18ISjHxR7snhQ4mhZ71rwY8eIwTTXya
	+3V+BdxP66Eb281rFxU3HUBJM7pxqtYvGE6AU3i4BUpX4T81xzwnJnI4Xn/SbHBU
	w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5asjbb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 11:26:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49OAIan9039572;
	Thu, 24 Oct 2024 11:26:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhcb9vq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 11:26:17 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49OBMi2M005756;
	Thu, 24 Oct 2024 11:26:17 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-188-27.vpn.oracle.com [10.175.188.27])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42emhcb9un-2;
	Thu, 24 Oct 2024 11:26:17 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 1/2] tests/flexible_arrays: redirect stderr to avoid warnings
Date: Thu, 24 Oct 2024 12:26:14 +0100
Message-ID: <20241024112615.750704-2-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: gE4-xIMRXtD-dlzH-rxxbtAPt4xHZikJ
X-Proofpoint-ORIG-GUID: gE4-xIMRXtD-dlzH-rxxbtAPt4xHZikJ

With recent kernel, saw

  2: Flexible arrays accounting: WARNING: still unsuported BTF_KIND_DECL_TAG(bpf_fastcall) for bpf_cast_to_kern_ctx already with attribute (bpf_kfunc), ignoring
WARNING: still unsuported BTF_KIND_DECL_TAG(bpf_fastcall) for bpf_rdonly_cast already with attribute (bpf_kfunc), ignoring
Ok

Redirect pahole output to avoid seeing the stderr messaging.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tests/flexible_arrays.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/flexible_arrays.sh b/tests/flexible_arrays.sh
index 7c21253..e9e3cb0 100755
--- a/tests/flexible_arrays.sh
+++ b/tests/flexible_arrays.sh
@@ -20,7 +20,7 @@ pretty=$(mktemp /tmp/flexible_arrays.data.sh.XXXXXX.c)
 
 echo -n "Flexible arrays accounting: "
 
-for struct in $(pahole -F btf --sizes --with_embedded_flexible_array $vmlinux | cut -f1) ; do
+for struct in $(pahole -F btf --sizes --with_embedded_flexible_array $vmlinux 2>/dev/null| cut -f1) ; do
 	pahole $struct > $pretty
 
 	# We need to check for just one tab before the comment as when expanding unnamed
-- 
2.43.5

