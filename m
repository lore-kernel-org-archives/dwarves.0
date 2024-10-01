Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42061BF7EA
	for <dwarves@vger.kernel.org>; Tue,  1 Oct 2024 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727783198; cv=none; b=DQgXKLi3WFMb9e94OAPe+NeLooEGklx4BekSZGU4iGcWR0rZ2gSdzn3H5fwwq3KE2eHUyU9ZBZsLjDTCwdfiuknhfIrZI9IqgQliAY5OGyvSTOvIQEfx5yxLQJkJj+Yyu3M07+Anp4DtzP9F5Bg0LmJR5pcYTb9Zm/nMTaXKW70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727783198; c=relaxed/simple;
	bh=NwUb6QqKPv15mAeRp2ZeEpZt5ZRl0aqRCzHkn643Uao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYgR8Q8yS71ql9k1cz2ieAY3HzBxSFDIQGPfPxpx/NMaAYaKlrhNbTyQJB+1gwGfOp4NCODtEuDY6kSK2/plwqZM4MYRGZIH32GHeVio972dwRFaRKdsXH93r/1cOFjVz+ee9xp4I9rNWLjbtqbX4lhzpU9GIs0EMiLORWESEvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fPaI9FuE; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fPaI9FuE"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4911thms025355;
	Tue, 1 Oct 2024 11:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=I
	UaUrRAVIZGr0Yh3BpNDpj7Rtzj4CzA9F6LZfX3xj60=; b=fPaI9FuEHdlyWC8q9
	i1ArFAU34CyjXhV76Sd3fqN5xLkqytly2jxhYeNvFXygeo5wmjnij8zegxGKV8Jx
	zT/H/h639bh7Moh2DDV6uws101fIDVbOGahV7eX1mMY5kc5p7LccL9VnaUxhVG07
	Su5C+SVKzqTE+o/EQkM/lUo2Av8GYhRfP91gYhRqRB/ZfaE4npY8XlWw2Vidff9i
	jpyZZD3bRYcOi//ZJHaEPa2TgCJVuKmGgYMIpkhyxuY1MAX/PMpmiLqvBGFax8K/
	kgdzEFyMb9gpYORq60C+P1pW9Sx1vsf2DC7ZFlQB49fvHtpirJQW39OGk8x1NKfG
	18+NQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9p9nwtm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 11:46:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 491BYxrw026199;
	Tue, 1 Oct 2024 11:46:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x887ee0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 11:46:32 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 491BkURx024830;
	Tue, 1 Oct 2024 11:46:31 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-217-229.vpn.oracle.com [10.175.217.229])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41x887edyu-2;
	Tue, 01 Oct 2024 11:46:31 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 1/4] tests/reproducible_builds: support envvar-specified vmlinux
Date: Tue,  1 Oct 2024 12:46:26 +0100
Message-ID: <20241001114629.3947401-2-alan.maguire@oracle.com>
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
 malwarescore=0 mlxlogscore=997 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410010076
X-Proofpoint-ORIG-GUID: v273yTQIf4FxgBbVndy2Bdq5e_KNdWMt
X-Proofpoint-GUID: v273yTQIf4FxgBbVndy2Bdq5e_KNdWMt

for running "tests" script on systems on which vmlinux is not
locatable via pahole, it is useful to be able to specify a
path to vmlinux that works across tests like this:

$ vmlinux=/path2/vmlinux bash ./tests

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tests/reproducible_build.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/reproducible_build.sh b/tests/reproducible_build.sh
index e3c5c23..8a151a9 100755
--- a/tests/reproducible_build.sh
+++ b/tests/reproducible_build.sh
@@ -4,7 +4,7 @@
 # Test if BTF generated serially matches reproducible parallel DWARF loading + serial BTF encoding
 # Arnaldo Carvalho de Melo <acme@redhat.com> (C) 2024-
 
-vmlinux=$1
+vmlinux=${vmlinux:-1}
 
 if [ -z "$vmlinux" ] ; then
 	vmlinux=$(pahole --running_kernel_vmlinux)
-- 
2.43.5

