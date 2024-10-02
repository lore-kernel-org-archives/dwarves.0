Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EBD12E1EE
	for <dwarves@vger.kernel.org>; Wed,  2 Oct 2024 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727868829; cv=none; b=iCbZfZlIymu1e2fMJyR+zeBRsLHkF1wgtf3dL7mDhgLay9dtaLjmPOyWsA/8UPr7NrA6x4hDd0vUSrEfNJX7hmaleS3dY3ghxqCfispXA8uX4UdnUeuT9sJAAhigxpDr2nirBpeAgnTxiHl14mTdEgLyGkSszNWMKx/kObj6d9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727868829; c=relaxed/simple;
	bh=2UhQM+9a2vL64m+K6PXpUhGp0qaqAoXrALzcXBCzMVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fD15phGPS5PwZ8FhowQqEm2zW/0x+cUJ3TWKdchzC+LpCZi9lEx3X7c/MMv+K0PgYClRWZPzGugNA0rmv4PC1WA8EeOq9EYxvJFZfYpIv/UANUJCxCUIsnZEqzBVnElsUGKbgbEKqNxGjkdnN5ey6JiZGP1aA+KRud5+/F66MEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M1861b9q; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M1861b9q"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4927fWSV024436;
	Wed, 2 Oct 2024 11:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=9
	jzNDmTZznnEoEn2T85KEPD6x3/uIOrsumkayc6RsHs=; b=M1861b9qUwVOETscv
	89HVNwncAYOd7bTUIc9UX4lmUfu0ck9YB2iLIXz6QDAGOObEWQBnJxyp1E5Qjwhq
	sTwy6SKoWGA67uJVzaDPduq56BM8SC16DxNqVcz1I6whSCxS/DKc3X2qgdzaSrCz
	jDs7SQhqjLsvmHaivutSzd3P8B9ghL/vFXmWPWP6O5R+tumPi7xsJ8SIZTUEDpXI
	wxe2MYOlxea3XRmNDEB6KLlV5PHpx5rTf8olUu4xnjK7BniZVO42iRLJs+pj73IN
	6XNweV6+MH/L13T0VQKUbjpQfW3RjK5FO96ZgobEmmZ2GAdOr7gpMR+bGeM3ds9y
	I+v2A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8k38x18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 11:33:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492B10NX028553;
	Wed, 2 Oct 2024 11:33:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x888ykwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 11:33:41 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 492BXeQp004496;
	Wed, 2 Oct 2024 11:33:41 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-184-213.vpn.oracle.com [10.175.184.213])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41x888yksp-2;
	Wed, 02 Oct 2024 11:33:41 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 1/2] tests/reproducible_build: fix vmlinux finding logic
Date: Wed,  2 Oct 2024 12:33:25 +0100
Message-ID: <20241002113326.792495-2-alan.maguire@oracle.com>
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
X-Proofpoint-GUID: c8WezR6rtaA8OOvy8K2y6AhepjIxs0XB
X-Proofpoint-ORIG-GUID: c8WezR6rtaA8OOvy8K2y6AhepjIxs0XB

In updating the logic that finds the path for vmlinux, it is useful
to support a few different options

1. command-line parameter specification
2. retrieval via pahole option
3. environment variable based retrieval

Options 2 and 3 are useful for the case where the script is run
via the tests script.  When adding support for 3 I incorrectly
specified

vmlinx=${vmlinux:-1}

...which should have been

vmlinux=${vmlinux:-$1}

i.e. assign var vmlinux to the env var vmlinux if set, and if that
is not set, use the first parameter for the vmlinux value.  If neither
are set we can then fall back to the pahole option.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tests/reproducible_build.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/reproducible_build.sh b/tests/reproducible_build.sh
index 19ef227..c595636 100755
--- a/tests/reproducible_build.sh
+++ b/tests/reproducible_build.sh
@@ -4,12 +4,12 @@
 # Test if BTF generated serially matches reproducible parallel DWARF loading + serial BTF encoding
 # Arnaldo Carvalho de Melo <acme@redhat.com> (C) 2024-
 
+vmlinux=${vmlinux:-$1}
+
 if [ -z "$vmlinux" ] ; then
 	vmlinux=$(pahole --running_kernel_vmlinux)
 fi
 
-vmlinux=${vmlinux:-1}
-
 if [ ! -f "$vmlinux" ] ; then
 	echo "$vmlinux file not available, please specify another"
 	exit 2
-- 
2.43.5

