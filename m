Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074D4207DF7;
	Tue, 14 Jul 2026 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037043; cv=none; b=HOc592YQXoVEXO1sLLsazirwnrcXH8KgRGNvubjvzo+q98kHxDpWCu7wXImpFkG8L1CTYU9FoAJEVJTt/+gQTFPjCCe2BxVI/jk5jaKCeAmsqvz3qnVnMcJE8ap7Dw68igv4S+5qsnxffJzFazPBBiEwXz/bFT7jqDQRdq+a6TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037043; c=relaxed/simple;
	bh=S8MwiPSFtg2HQJwfNovLWXqWhq+RHCp2laLuQzZ12Do=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tvjmqMgu78/yWtedOQEcgeoIxo7b7XxmzHkrONs98pfzO8JSBi8POc2vCO3GEaxm5IZTJAjfZEoAdpljKnF6gIdDiqsikWFALczciG83MAX5exXfJe0Ila07/uTZYJvMVH/Y7TDdWTP5pXdr9E9R+9t2eWvzXUhGm8DOs9zsrTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d4fA7NqF; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d4fA7NqF"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ECO5eT1377234;
	Tue, 14 Jul 2026 13:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=WpHKcVTV03NtgCbsF1959OZu2kG2m
	van6Q6xdWZ8Rb4=; b=d4fA7NqFLlsHPlyv+lW5OoIhC4TVDKuTWfmEyDid2Jeyi
	KvP94xmQMBj687ExG7Iw2SJLaYVYfXLu5KTWMpNNj2hKxGpxQyxR04FJHznN42Ho
	3WVCH+Gm41uM1yCK4r6vasaIuIcNS8NSh7S3WGoO96Nh7Yszktj1eqsn0gjbkHK7
	m7O1v4RsHVeWgFRy4NSvpcpIlQXqACioh2XHBji47Ldkno83yUwXx0roDFCh9orx
	T2cSEVxPxhvt9mAb3YUBiqrjqceV2j+ykD7XSBoWAQTzNR+ZWAe91CHtZ4NwSkBW
	2nXilyvb2ezJBE48OcWyNsUnzrDpLMZJyLqwiZt4Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbeedm6n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 13:50:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66EDm8LR032350;
	Tue, 14 Jul 2026 13:50:37 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-49.vpn.oracle.com [10.154.50.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4fbc9dtr8p-1;
	Tue, 14 Jul 2026 13:50:37 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: yonghong.song@linux.dev, olsajiri@gmail.com
Cc: arnaldo.melo@gmail.com, bpf@vger.kernel.org, dwarves@vger.kernel.org
Subject: [PATCH dwarves 0/2] clang true signature follow-on
Date: Tue, 14 Jul 2026 14:50:33 +0100
Message-ID: <20260714135035.814273-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607140144
X-Authority-Analysis: v=2.4 cv=d+bFDxjE c=1 sm=1 tr=0 ts=6a563eae cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8
 a=BEG9pr17Aq1srr6O9tEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE0MyBTYWx0ZWRfX97TrNcaVDkDx
 ZPWuWA7J+EP87c4bmFJM/qqoIrJdT1Ek6PKnHIMMJXz39Okb0ZUR7XIeiJx1e8iT9txcErt555t
 /4HEmSYZyChjX/WjAt1qKJunIz+ZMRr/9aca7ECDBOZB+n6Lx48jFR+1pxqbigKyMqC19Khhd64
 aMuSDBfJPhMo6dsgIpPanuRmMDxhb6Ob1WEzi3h/uUnpWNXVad9Ws6Hzld8P/Z6LCjgFXu0zeSF
 qHkiNswp/BHMGBtoqHCwgsCGGijW7pE9xwQoK3vlgAI3wRl/kchYoD85w0N16Y2ZcyPJvzkCAw8
 uNISwHBELftWJdLrVjlBezyMh7OP4/F65Y1zvYzO08ctqgMY+rkPIMXidQ+mT/7s154wTT0PIcv
 jQaAw5UHmo9r8z5t9Cd/7ioBcrZ+h/9VJzNMd0JWBBDRbr1vpbeSvR2Ldt1bUapeD8iNImVlqTZ
 eVN26i7O5Y4kfEE7efQ==
X-Proofpoint-GUID: FiNsdEj2V3O84q4m3urQIjbexruCL0F5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE0MyBTYWx0ZWRfX9hDhdpzcAefs
 GQQFI/w7liDWuk/9vVL2Kel7pxhrV6sGjQK4yItcEZDI1wSQnj+Y7qcxfldVFG9fvCRzNKi+Hda
 cqWeMvUvK+aS1ftB7WQ37UgsvETlr9+eBPB38QhRGw1FdeYLtJta
X-Proofpoint-ORIG-GUID: FiNsdEj2V3O84q4m3urQIjbexruCL0F5

Though the true signature series [1] has not landed yet, this
is intended as a follow-on series to resolve an issue it raises;
by sharing the optimization detection code it can result in
the non true signature case being overly aggressive in omitting
functions from BTF that have optimized parameters.

See patch 1 for the details; patch 2 tests the change for gcc.

This series applies on top of [1]; the danger is we do not
want to land the true signature series without resolving this
issue first so hopefully folks can test with this series on top to
see if issues are resolved.  CI passed with this series on top
of the true signature series at [2].

[1] https://lore.kernel.org/dwarves/20260625020148.1883082-1-yonghong.song@linux.dev/
[2] https://github.com/alan-maguire/dwarves/actions/runs/29270441984

Alan Maguire (2):
  btf_encoder: Only skip optimized parms when ABI changed
  tests: Add GCC default-BTF optimized parameter coverage

 btf_encoder.c                  | 97 +++++++++++++++++++++++++---------
 tests/gcc_optimized_default.sh | 69 ++++++++++++++++++++++++
 2 files changed, 142 insertions(+), 24 deletions(-)
 create mode 100755 tests/gcc_optimized_default.sh

-- 
2.43.5

