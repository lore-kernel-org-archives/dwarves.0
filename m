Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7161FB8AE
	for <dwarves@vger.kernel.org>; Fri, 25 Oct 2024 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876563; cv=none; b=JqKXzoWVycgGicyF8GU8DPrdo25d9DIamcxNwbi4zE/SMGh9wPzZETDXxsJiV63RnQjJ/oQfQmuCJUWsZ3AekJYcFmMAmYiXqOqtaK5OPBfw56EAAOL6wsRtzGi0v0KmlqlMt8m17/47xHDuDpe0qp05QuB/AFPbEUHq1BsZdM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876563; c=relaxed/simple;
	bh=6gnyS4LMJ2IAQkJiihch/TTFPqvwLR/ImYl1XP3u27s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ivmuufRObT5BDAT0ecGOHJIPcbj93ZEfS0AFuiUQOnYwx0KODCkHW8+CGrn0UZYSJf5Ap/6wl2MsuNO/wvsxm6D/BqM4WfEWA59l58iqrGHqKHKbdJLiS9kDgEEHkGukNX5CwyvQlFJ2T/7Nxb7g8/Xl5TE+YqdFF0Bs6BYzQyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ER/AF8go; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ER/AF8go"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PG0WCV031844;
	Fri, 25 Oct 2024 17:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=g2LtxlX+j50BJdVj9YxXhcpMGHIAD
	fRpaKO6CnpR5Po=; b=ER/AF8gofumMIBsVY8QRarfYx0fyribsJAp67CqlhBRtU
	Jft4u5x9ZzyESMKjUjkrJEG+sNNk/q4H9VMYKbxpngCes2aAlSrC/mT6hgpc6WdU
	b/bTI/JKfpc7cE8p7MsBCYuQ1rv6ej+NJucCm5cSdsD0LANMeEB131b0DC34rxK3
	i+u6NVlseL3pLzGiIt4YoIwzdSX0VN15bCGImdAqCjV6P/aglJaMxGDBo4IVJkl2
	Addiu1zA9cfWShLsV6XR5qHLVQvGaUoWuMQ2QUuhEja3qZpdveEhWCek2L8Z+eaV
	exuvOWTaJ2ej7Dz/lcaOZCUWQhwAx2X4OkyxwWJlw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5asngh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 17:15:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PG1tKq036724;
	Fri, 25 Oct 2024 17:15:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh5jrfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 17:15:55 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49PHFtug013926;
	Fri, 25 Oct 2024 17:15:55 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-198-103.vpn.oracle.com [10.175.198.103])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 42emh5jreh-1;
	Fri, 25 Oct 2024 17:15:54 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH dwarves] pahole: distilled_base btf_feature should be reported for libbpf > 1.5
Date: Fri, 25 Oct 2024 18:15:53 +0100
Message-ID: <20241025171553.1850692-1-alan.maguire@oracle.com>
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
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410250133
X-Proofpoint-GUID: HtJjKBIClSRSD0sGSAGbBFn_XbV_qnbi
X-Proofpoint-ORIG-GUID: HtJjKBIClSRSD0sGSAGbBFn_XbV_qnbi

Alexei ran into issues [1] generating distilled base BTF with pahole built
against an older < 1.5 libbpf.  For older libbpf, we cannot support
distilled base BTF (since the library API btf__distill_base() is not
present) so we should not report it as a feature in that case.

[1] https://lore.kernel.org/bpf/CAADnVQKFjK8BnZ-rYzXKv-Zdw=HBJRoJ7jo5PN+0P6+qpJOxNg@mail.gmail.com/

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 pahole.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/pahole.c b/pahole.c
index 0b91a7e..55d04cf 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1206,7 +1206,9 @@ struct btf_feature {
 	BTF_DEFAULT_FEATURE(consistent_func, skip_encoding_btf_inconsistent_proto, false),
 	BTF_DEFAULT_FEATURE(decl_tag_kfuncs, btf_decl_tag_kfuncs, false),
 	BTF_NON_DEFAULT_FEATURE(reproducible_build, reproducible_build, false),
+#if LIBBPF_MAJOR_VERSION >= 1 && LIBBPF_MINOR_VERSION >= 5
 	BTF_NON_DEFAULT_FEATURE(distilled_base, btf_gen_distilled_base, false),
+#endif
 	BTF_NON_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
 };
 
-- 
2.43.5

