Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B618C1E5B7B;
	Thu, 26 Feb 2026 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772096018; cv=none; b=K+CDl/GDU2PU8QYg8o7UKDSbYfCVC8npu2jUO3lRD+w8yRPksobyO266gg/5Lqo9TnXE0mtQxxMcp7G+pHCZ48YC84rW6WWux2zpfNJnemSwO1jpjffEMokQQz6sh81wtCkDxK8IFppnZrMkqB4RHWZ5r69j9+OeYYKzyXOHMxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772096018; c=relaxed/simple;
	bh=LOYVkqUNxM0Tw5Keg57OmN+wujtIObqn5Z74djHr6ho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NuOrhieYVHFNXP1kJvahloocdh5Em/ygkoyOm4X3M6tjbuf2YjRT4g3fluq0bJTTbKTIhOHd6FwHlBpCzBlE90RIaPUZd9X2Lg24sM8D8GG8rgwWwoRrZ/4ekwZipcm253engbFREYYlmTq1Vt6ZBR9d919mE/H3egCB78Y6Z3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fQTIAP5H; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fQTIAP5H"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q6H2jc1273218;
	Thu, 26 Feb 2026 08:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=SwxSo0lqnXldSyQ4zxIdYyJ5YHS6I
	U7Kin8a9B3n3L8=; b=fQTIAP5H3KlXK/HllaknNBXMIc5nk1yb7Aupz0gRuCKOq
	+VNL2PINB7Ka5IfW8p9TXX0wD881bKTvhOhv6A05sFGOgwDPMk/QFwbgvFHdfzgW
	znct1Tsp5i+K47l9klqA6RB6Z9r/sC5KWRrITW98BRw0qQcTLTFnZbavElHWMOMM
	Uk45aftVk9HcJ7yzTdUwlK/cVsxlr/UAVsfr33y8R3hT3qekJJWN4vFYcFHFv9T+
	cSCBjVl0fr9G4rdKEr7dTLa03ZSRB1XAH1nA1f1cmOeUDilJtBbufXSd2rq9Rk7D
	gHwwRqdLEIy423BxwmJ8571jAcL83RZjrVIO4wlQA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cjgs005nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 08:53:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61Q7IfLY012480;
	Thu, 26 Feb 2026 08:53:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35gfgen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 08:53:09 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61Q8r7gH014003;
	Thu, 26 Feb 2026 08:53:08 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-58-146.vpn.oracle.com [10.154.58.146])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4cf35gfg6e-1;
	Thu, 26 Feb 2026 08:53:08 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 0/2] pahole: add BTF layout encoding feature
Date: Thu, 26 Feb 2026 08:52:38 +0000
Message-ID: <20260226085240.1908874-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2602260079
X-Authority-Analysis: v=2.4 cv=BKK+bVQG c=1 sm=1 tr=0 ts=69a009f6 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=sUlCVmaeACBNb1sd2qoA:9 cc=ntf awl=host:13810
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA3OSBTYWx0ZWRfX5QtM8aQMUZ2y
 nunCyI/TL+R5JaB2m/El1anA7zNNmmaxrerB731OX5UUz8GLSJ71Ykf7/8bppy44BWpVdm71Egp
 KYR86WEyi9lfp4yqs9SvA2v7Nh+s+rbMz+GwIHc7it3qfRAT3QgRB8x6iI3f4MdVZtFtNIFCDYX
 RcSxNAeyMsPPD25RvFDiJlygLoHtLykBgXQjnwMhhfFde2mHk/Fwl6gbUW0bMQM1BBcb2khlYTD
 avVFHIaHI76zjEYZB37ePwlzgbmnTVSCOoEIxBvLBH6XRzPvJlIb8Kyh4XlYCNyaOzuwtzPvYPS
 V3zYgYMp16LzRHZ0HNhnjewfMW90DPcfKfef8nh7uYoy05NxNIi6HCSeQn0qduesRSSKCKE7bm4
 XlQGh62j0lIaknb57dkM7WxJL1asrJmcCp9pA+hhyBUvfuI1AgzmxEsXIIju64Uvx4GMXLg4aL4
 Q8ywMqXUSg/78TYngOZh8LvE7P37Vdb4cvFiD+Sg=
X-Proofpoint-ORIG-GUID: ftNeNJ7g2h1OHs1K4IF73SKz1-2J8dps
X-Proofpoint-GUID: ftNeNJ7g2h1OHs1K4IF73SKz1-2J8dps

A soon-to-arrive v9 series will add support to add BTF layout
information to BTF; this describes the BTF kinds known about at
time of encoding in order to support parsing even in cases where
the kinds are not known to the parser; the layout relates a
BTF kind to the amount of space it consumes via an optional single
element following the BTF type or a set of vlen-specified objects.

This series implements the support for the BTF "layout" feature
but does not require the libbpf changes to support it; the feature
test uses a weak declaration of btf__new_empty_opts() to handle the
unsupported case.

To test pahole with this feature, the following approach can be used;

1. Specify -DLIBBPF_EMBEDDED=OFF option to cmake
2. Install latest libbpf with associated patch series with layout support

Alternatively with embedded libbpf the changes can be applied to
the embedded libbpf in lib/bpf/src.

Changes since v2 [1]:

- Resynced, renamed kind_layout -> layout
- Avoid encoding layout info in split BTF since it is a waste of space

Changes since v1 [2]:

 - Resynced with latest pahole

[1] https://lore.kernel.org/dwarves/20251210202752.813919-1-alan.maguire@oracle.com/
[2] https://lore.kernel.org/dwarves/20250528095349.788793-1-alan.maguire@oracle.com/

Alan Maguire (2):
  pahole: Add "layout" BTF encoding feature
  man-pages: describe layout BTF feature

 btf_encoder.c      | 21 ++++++++++++++++++++-
 dwarves.h          |  4 ++++
 man-pages/pahole.1 |  2 ++
 pahole.c           |  6 ++++++
 4 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.39.3

