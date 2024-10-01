Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE94E1C0DC5
	for <dwarves@vger.kernel.org>; Tue,  1 Oct 2024 11:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727783200; cv=none; b=tD4gcyvSK8uDmZQV77KhFxMfrmUFzMfzcyc9BrG2aWIy1FiLGOP5o9L9lo4l85IRJ7rsXm9B5PPB/FIfchzhgnYmzaC9wXUHTWxdd24bFLeu9qgktqecEnRig9YvY9g55XwQLL/4wsUXSmU2dBCeSmQTT86MQ0XQNacNjuphic8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727783200; c=relaxed/simple;
	bh=IkKE0O51vfNOd5uJ0lzzLju1iKoHp/mD07hVsF5jGNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFXF+7E15VW5TcRgzv8ZcikAn/2PnmifvJb/OSX02GnVq5leaIdhbC8UNU09AX4k5TejWyWQ6ZMk09xhTwtNz9XlwAP7H+89IUuFWia1Hrl96dWV48tf0oOHUrTbCKY0ooz+DSyyhHYvFwhbSH7USKXQVg16hB5VCkplpQ5mBXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f3uTjo6r; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f3uTjo6r"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4911tZdI009541;
	Tue, 1 Oct 2024 11:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=h
	b+q1t5eNeaxVRFmUJBcp55UGw/vZVVlHjXndCwckiQ=; b=f3uTjo6r8ZfoEaJ2Q
	nFqxJ5BslWFpEoVPU/xHfbFkECDWMw0c+vpEIoXG9KYLHiiVD8xlnD47tSbFW2Y0
	olDAsW2luj4hYhl/N0nHy9O/dSvohkugy088dW7UAM0nwv/pnUhBDOfc1uW/9YS7
	r82ugd5ZfEMEiS9RkmntKszyEouvcQNRMNIWQglEdxpCgonkyNcr3/mUk7nX3rG+
	if3h9nPxmcREYaE4gmA6lc7zlfgcoX/sHyQGstne53J/25xgO6bYgGaIL0x9PiHp
	8Z6Itvr/HW+qJ/GKiz3Tr8Y4NJTwGnMNWwpmRXeDk7jSkFkf7JlOy4PKqGTgAMpo
	af08A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9ucp4be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 11:46:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 491A6nH1026243;
	Tue, 1 Oct 2024 11:46:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x887ee1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 11:46:34 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 491BkUS5024830;
	Tue, 1 Oct 2024 11:46:34 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-217-229.vpn.oracle.com [10.175.217.229])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41x887edyu-5;
	Tue, 01 Oct 2024 11:46:34 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 4/4] tests: distinguish between failed/skipped tests
Date: Tue,  1 Oct 2024 12:46:29 +0100
Message-ID: <20241001114629.3947401-5-alan.maguire@oracle.com>
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
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410010076
X-Proofpoint-GUID: 6jWFRbmB7z4qlJDAJitjQzyzNwYPIDM9
X-Proofpoint-ORIG-GUID: 6jWFRbmB7z4qlJDAJitjQzyzNwYPIDM9

When a test returns 2, it indicates it had to be skipped;
distingiush between this and other non-zero failures; the latter
should result in tests returning 1 to indicate something failed.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tests/tests | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/tests b/tests/tests
index 38bb975..11921ad 100755
--- a/tests/tests
+++ b/tests/tests
@@ -5,11 +5,24 @@
 tests_dir=$(dirname $0)
 cd $tests_dir
 
+let status=0
 let nr=1
 for test in *.sh ; do
 	printf "%3d: " $nr
 	./$test
+	case $? in
+	0)
+		;;
+	2)
+		echo "skipping..."
+		;;
+	*)
+		status=1
+		;;
+	esac
 	let nr+=1
 done
 
 cd -
+
+exit $status
-- 
2.43.5

