Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A5B13A88A
	for <dwarves@vger.kernel.org>; Fri, 18 Oct 2024 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729244590; cv=none; b=DmYQkycOdoVc7js+CltOEY52kIHGdcpYweuO3hh3uiBN+mhI15LVSLOm1fL/BcAUZRuXKXNJOtwFKGFS/oUVRKZeo4Z3RBi6o32TiKH7iPkAyHaobFmWTBqhwQcCjLhwV+Xabnqt6AjFcNfW7Yc2aOtENLBlNIkD/uPJIJNYbcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729244590; c=relaxed/simple;
	bh=gUb4NZD5bq204Yli8Q5pQFYLwYLdgvNYIQvCaMxbSmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iaRgmD0Cp4LmwrdL8h1GNVi6PQcf71kFZOt8l9xMYZJIoMiXhTmx1j8tSg+97RRwOfTo8wpGK/YFWHGNUAlNLzyQxb28cDCUhAYy45tv91fR38cEF7Ie+RGSHSd9j5M0hjU131VnFVW3EqtjX5YQNdVC/17qkBpSWtUo4NcHAdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UxQNjuZp; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UxQNjuZp"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I8fknI020871;
	Fri, 18 Oct 2024 09:43:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=be70S1hd037jtaJJOrQn9C5yV2rI8
	1d2CUtwdKFWHzk=; b=UxQNjuZpMiVyo2rf7Ha7eAfRw9yF3rd9YQhSAv/7YnmVF
	6SSIQKFU8rYNoVMSZg5EGHD/CQv5y9F5iPTqLCKCrEzTFrIm+6BXMcZhLEhIzi6a
	7ke5zo0LtjBRJoe7KynTd+z/XH3mxGe9REw6+rxsG14F81YtrrBVLtPX5jqO8hfg
	UP8NSCFVlPyfWQ6YRWLFc+pKZsYr0UUhu7VUDvJCgzayWs2B3SgXGroqnc2VOPO0
	P3vpOq2XnuUADctw4vTTo+Ec6MsLkoSI2UdTL80lrItT7m7wSe33ieqy+ZmF/8Pm
	H0YdXi6+88416Zx9OTR5eTNo75SkR5vIeZlQd9TUg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h09qs26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 09:43:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49I9WrDH026268;
	Fri, 18 Oct 2024 09:43:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjbcyhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 09:43:04 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49I9h3IA031880;
	Fri, 18 Oct 2024 09:43:03 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-174-18.vpn.oracle.com [10.175.174.18])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 427fjbcyh4-1;
	Fri, 18 Oct 2024 09:43:03 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: ojeda@kernel.org, andrii.nakryiko@gmail.com, jolsa@kernel.org,
        dwarves@vger.kernel.org, stephen.s.brennan@oracle.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves] btf_encoder: filter var names before btf name check
Date: Fri, 18 Oct 2024 10:43:01 +0100
Message-ID: <20241018094301.1550149-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_05,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410180061
X-Proofpoint-GUID: OjhwU1rEp6I3C66NWSBBrfb8EYq3DLKO
X-Proofpoint-ORIG-GUID: OjhwU1rEp6I3C66NWSBBrfb8EYq3DLKO

...as this means we avoid seeing multiple messages of the form

PAHOLE: Warning: Found invalid variable name when encoding btf, ignored (sym: '__UNIQUE_ID___addressable__RNvXsa_NtCs2vSfyxKMEZc_4core4charNtB5_11EscapeDebugNtNtNtNtB7_4iter6traits10exact_size17ExactSizeIterator3len57').

Such symbols are filtered anyway due to the __UNIQUE_ID prefix, so
warning about them is not necessary; simply reordering the checks
should ensure we will not see these warnings.

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 5954238..e507e60 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2241,6 +2241,9 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 		if (!name)
 			continue;
 
+		if (filter_variable_name(name))
+			continue;
+
 		/* Check for invalid BTF names */
 		if (!btf_name_valid(name)) {
 			dump_invalid_symbol("Found invalid variable name when encoding btf",
@@ -2251,9 +2254,6 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 				return -1;
 		}
 
-		if (filter_variable_name(name))
-			continue;
-
 		if (var->ip.tag.type == 0) {
 			fprintf(stderr, "error: found variable '%s' in CU '%s' that has void type\n",
 				name, cu->name);
-- 
2.43.5

