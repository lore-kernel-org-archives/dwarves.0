Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216A31BFE00
	for <dwarves@vger.kernel.org>; Tue,  1 Oct 2024 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727783199; cv=none; b=YLrJhOYcHa3QDLOXs+APwXg8AE9OBod8vDv6hADKZZ1o0ShcUwWzMR5FdsiHZwvfSt+7TB6QsZkMVUEYQl4EbIpIaMgiuMo+so6AlwL+b2NDOiMrqyn6t+q7K7Yi5l49IAAvqk5DvpdWBOuw9awzGCKowqYlibAEkB7dEMvBYf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727783199; c=relaxed/simple;
	bh=VxfDUzvU+clKuiI/a9iWMNkWBLYSRQ6eBpB2dG/72FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwlJ3e1Z4ayxUqarHBWV+UqAkp2mMqYSug7Hbf0YaLo+JhKrWs9t449YDA1CGQXrforpfIYAjYcDj6KagbQLDSOiP1AJkmVCIlOp25i2kizW9Lq2+jPkKPvOjsq7TM6+Vke6x2PMH+VTzEt7DgffHDL3MT2VIDG2zkK7HW23/Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m4yqo8a4; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m4yqo8a4"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4911tclT024367;
	Tue, 1 Oct 2024 11:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=u
	kguatC0cnNAFR6cF+VOTUd6ONMVYIC1vG9F9ML3wG8=; b=m4yqo8a43jlqBCEdL
	DYBIaUfFp/ZyNxUO53f2jsMSa65DtpNPeduMp09g0JCv/xZ4Jto+0FGfWca8kf3Z
	Z5Q+NSJaXHaS1KKik3VDiBdj4KC8QdtksGhgDWKJAuKwy5mjb6BrmW43WPS5rA6H
	rfURjYOzwKS8+xNS6HExy3JsLPq9orgzVDWPY/wyaFadIHICdPoyp7walSZeJeuf
	fQ1RvB8r7XluN6jtd919tyURh1U2ymyCkJfrYqVpijpl7Lwl+GFfwZm2k/76jE0Y
	sy+rxeOLofHJqe2NeX3IepvgpRk0GTkK9fUgPX7A91K6E200A91jsV2wYU9RvGh6
	cJ8bg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8d1e1ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 11:46:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 491B16tV026318;
	Tue, 1 Oct 2024 11:46:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x887ee12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 11:46:34 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 491BkUS3024830;
	Tue, 1 Oct 2024 11:46:33 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-217-229.vpn.oracle.com [10.175.217.229])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41x887edyu-4;
	Tue, 01 Oct 2024 11:46:33 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 3/4] tests/reproducible_build: return 2 (skipped) if no vmlinux available
Date: Tue,  1 Oct 2024 12:46:28 +0100
Message-ID: <20241001114629.3947401-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241001114629.3947401-1-alan.maguire@oracle.com>
References: <20241001114629.3947401-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_07,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=912 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410010076
X-Proofpoint-ORIG-GUID: 2yMQYVVUjEyBNIZaEQe_eAcRqbDa-6pa
X-Proofpoint-GUID: 2yMQYVVUjEyBNIZaEQe_eAcRqbDa-6pa

Distinguish between test skipping (2) and test failure (1).

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tests/reproducible_build.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/reproducible_build.sh b/tests/reproducible_build.sh
index 8a151a9..a360379 100755
--- a/tests/reproducible_build.sh
+++ b/tests/reproducible_build.sh
@@ -10,13 +10,13 @@ if [ -z "$vmlinux" ] ; then
 	vmlinux=$(pahole --running_kernel_vmlinux)
 	if [ -z "$vmlinux" ] ; then
 		echo "Please specify a vmlinux file to operate on"
-		exit 1
+		exit 2
 	fi
 fi
 
 if [ ! -f "$vmlinux" ] ; then
 	echo "$vmlinux file not available, please specify another"
-	exit 1
+	exit 2
 fi
 
 outdir=$(mktemp -d /tmp/reproducible_build.sh.XXXXXX)
-- 
2.43.5

