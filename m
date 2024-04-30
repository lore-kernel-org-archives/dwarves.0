Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0931272AB
	for <dwarves@vger.kernel.org>; Tue, 30 Apr 2024 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714470919; cv=none; b=uGdL9Xfbuix3uHUcP03nT2/6CS9LOTDEcKav2c0lDALH991mHJy1NZFDJFCN9CfjP6iGSYLRckcsEw2KhS32NcMGT7k+jlS9ZPu8txnhsZzCtTHH0m2KFF4r7vZvLG8nWbUNlL13+9VfKb75IYf/tee4XEgUNeolMkfF5vRj5Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714470919; c=relaxed/simple;
	bh=Ar+NiVYDv87jOX83SfIscytEyIQ5YOb/cpGZQiIFtgc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OS3haFYJf+11Gg4ol7BVwMRLalRn0TX19rxEtTT6WkydZacst8Metg1XefXUacVXAuMZDdAVi0MhwaOU5eNiK/cf31+hTFUqUzA77vlxhIGfSSkEYUigkjrPnsVf6OixgkZTQJAUkb+memNVN6SkCavIMNW+tlQLb/wnDvO0acI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=obgM8/kd; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="obgM8/kd"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43U1hptx006302;
	Tue, 30 Apr 2024 09:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=fhORhLUg1retItGlxZ1ptr/rUtnJj/eo5AvpYFo/1xQ=;
 b=obgM8/kdWBg5sLM0ZaKAtZZSr/vOmIDXCNEVfW4vRSvBdfZ4864L1YMrw+olG59Le6ej
 XpqMHfw6bsuTVnWoFSc2FVw/p9b6MelBo4tkazzMg+KbC8ZFIY6pGTzpTemU+UWv2VI/
 gtf0QfV9kk+Qxlc9y4DG9K3BB/fqj78B9Jb8BGzMnByUy8uBIIs7ETivGbcUCsYT6y2J
 KVFgDYrzR9syjjhFpdE1RSgb1FWz0vEy7Fm1uSC08kT/XuzIyv3m/VA1+CkmyzFBbZ8Q
 Tne9AED9Hij6/gjnJ05QU0ryRIH//clide+RH+0UeD2ytlpnEeqCeQnP8bezUDB5cxuP Bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr54cnjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 09:55:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43U8dK4O016807;
	Tue, 30 Apr 2024 09:55:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtdncuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 09:55:10 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43U9t9ce035788;
	Tue, 30 Apr 2024 09:55:09 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-176-177.vpn.oracle.com [10.175.176.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xrqtdncmx-1;
	Tue, 30 Apr 2024 09:55:09 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: andrii.nakryiko@gmail.com, dwarves@vger.kernel.org, jolsa@kernel.org,
        williams@redhat.com, kcarcia@redhat.com, dxu@dxuuu.xyz,
        eddyz87@gmail.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves] Documentation/pahole: describe expected use of 'default'
Date: Tue, 30 Apr 2024 10:55:01 +0100
Message-Id: <20240430095501.1959359-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_04,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404300071
X-Proofpoint-ORIG-GUID: HP-VJ9mb2spsdz0tX5pfoyW5qJQeCdIZ
X-Proofpoint-GUID: HP-VJ9mb2spsdz0tX5pfoyW5qJQeCdIZ

the 'default' --btf_features option is useful for testing the latest
set of standard features used for BTF encoding, but will not be used
in the kernel Makefile.btf.  It functions as a useful shortcut for
testing the latest set of standard features.  Describe this in the manual
page.

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 man-pages/pahole.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index e3c58e0..19bf197 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -290,7 +290,7 @@ Allow using all the BTF features supported by pahole.
 
 .TP
 .B \-\-btf_features=FEATURE_LIST
-Encode BTF using the specified feature list, or specify 'default' for all standard features supported.  This option can be used as an alternative to unsing multiple BTF-related options. Supported standard features are
+Encode BTF using the specified feature list, or specify 'default' for all standard features supported.  This option can be used as an alternative to using multiple BTF-related options, and 'default' represents the standard set of BTF features that are in use for kernel BTF generation, so is useful as a shortcut for testing the latest set of standard features.  However kernel builds will call out specific features rather than using 'default' to ensure that the desired features are enabled regardless of pahole version and associated 'default' set.  Supported standard features are
 
 .nf
 	encode_force       Ignore invalid symbols when encoding BTF; for example
-- 
2.39.3

