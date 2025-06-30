Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D1C1A9B53
	for <dwarves@vger.kernel.org>; Mon, 30 Jun 2025 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751278544; cv=none; b=knTvEZOZQfkmfo3OUrK7iv7JlS9F0S2Ml6TBZi8r5S24l1AWqmKHfKjxcURltYdc07+lYW9xzfTio6TSDgR5fTjrbu3dg/g0N37XTN7XHx4o/ju3iZ9PgY+ADc1TKS91YhPq0lyE6+RA1Aa0QPNxPFqlOSnmUIduVWGGuvnbLcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751278544; c=relaxed/simple;
	bh=dfDueC1JutO7+dkAECl2+TcQ50bpok097okKx2Oe8Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ju1QOXS0s6s9Yzs2/F2AicYHs/kMtT/2grHINhbSdZlnhijPf4L3HiavfR/pyWp/2/7Fb78+gFlezCULXRw2ngWpGK8vfJJ4T8RWVadE5PBUqt/zc50Q2iE4cQyvlCyjQzz0kJQOGOZm+lEKOqTeLUPb0NxuBYIAQoMxdXJVGFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZKeEe9e4; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZKeEe9e4"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55U84b8g010142
	for <dwarves@vger.kernel.org>; Mon, 30 Jun 2025 10:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=FhJT5
	Dx/9IduVjFiaazJ1k34FO2nJywez5n6/1Jcux4=; b=ZKeEe9e4R1HLPXW1UmKcJ
	k9E6j8P0kS0MeJagRG0umtZjL0qD0H8xQCyFevijSzKGH7ZO7I5jpk47ay89wbAs
	wDGIih1T73UAT2CpxOgZylYfhtTpg5kkCF1wy/PaGXtukxjhkCj4rbTUUkGxQK9Y
	7QdMIz6nCx2IH8oXwlO0qfvjCpe/Zca/6avFk9MDaIh9yutwCiMH8qHB6Y2s5k6K
	3mi0g2wXhWH+SXBZvqqf9wb4mlLO5O6iT/2Z/XQs8nUF3+yEhLjEX71KvpkCSAqJ
	HEqWkJgQCcPc4SLbcXwTi0CojPvOmjDKgO51D3pIpkc5ikI74Ij5CdgXxyjc9/dy
	Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8ef26m8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Mon, 30 Jun 2025 10:15:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55U9VIYT017051
	for <dwarves@vger.kernel.org>; Mon, 30 Jun 2025 10:15:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u7wb6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <dwarves@vger.kernel.org>; Mon, 30 Jun 2025 10:15:40 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55UAFdgb009159
	for <dwarves@vger.kernel.org>; Mon, 30 Jun 2025 10:15:40 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-61-18.vpn.oracle.com [10.154.61.18])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47j6u7wb4w-2;
	Mon, 30 Jun 2025 10:15:40 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 1/2] github CI: Build pahole "next" branch as well as latest changes
Date: Mon, 30 Jun 2025 11:15:36 +0100
Message-ID: <20250630101537.2680289-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250630101537.2680289-1-alan.maguire@oracle.com>
References: <20250630101537.2680289-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=898 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506300085
X-Proofpoint-GUID: _JQyhiPTuw3SY5mWJnSkE6JRB3xtG7hd
X-Proofpoint-ORIG-GUID: _JQyhiPTuw3SY5mWJnSkE6JRB3xtG7hd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA4NCBTYWx0ZWRfX3pfM40F0y3eH tGZPqVgXyzPtII4zgRk5YrSBlr1imRPFEbMqYJVWKMRI+5N9D73Ox3e3eGMfmh0YTdyrwOCNE1Z xWmJJfd6FwAZXzGeDTspIYWYhkFVCNykopTsMHPovi9rvPzz6UVN9mAMR78aTuYJZEmtAbGSag4
 YDXTpRbQe/eq6yxa6H1H+5z371y2lOG7DDkjdAlqht3ycKSPMjE2lsbmfpyHWhiH0/9qXrLN+UO rGpw5FJo9UhBSDHU/QeFfmOmWo5s1qm8SiJy60VcAy4VtcY2dA9zYUiW5uvZtJsSRviaSokWSIb qz/OXDAIPubo7QZTxnX6kdYd2Kp8dFndH8CVEnh8iSCYbH2LgKMC/2wZ6zC1onDurER3zbulNsV
 WX1tBgGX9fRYlut4N6k4d+cgdb6jLnVi7d3KMKGhpJ24lC5Ae8ICz66Tqi/J1pZXTIKqUIA/
X-Authority-Analysis: v=2.4 cv=ONgn3TaB c=1 sm=1 tr=0 ts=686263cd b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=nu1Gbx4GvDcpwsD1sbAA:9

In order to support compare/contrast of BTF generation with
changes, build next branch of pahole for comparison purposes.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 .github/workflows/test.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/test.yml b/.github/workflows/test.yml
index f11ebfe..99c179a 100644
--- a/.github/workflows/test.yml
+++ b/.github/workflows/test.yml
@@ -20,12 +20,12 @@ jobs:
             runs_on: 'ubuntu-24.04'
             arch: 'x86_64'
             llvm-version: '18'
-            pahole: 'master'
+            pahole: 'next'
           - kernel: 'LATEST'
             runs_on: 'ubuntu-24.04-arm'
             arch: 'aarch64'
             llvm-version: '18'
-            pahole: 'tmp.master'
+            pahole: 'next'
     name: Linux ${{ matrix.kernel }}
     uses: ./.github/workflows/vmtest.yml
     with:
-- 
2.43.5

