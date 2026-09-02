Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5163358B9;
	Wed,  2 Sep 2026 11:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349147; cv=none; b=CBNuv/WxdGXi91EevJyExtbQdQFBYWcuWXdP4ZwJkzZ76DOXo+Z7Iqf90S1lQWc5pZaFxjth+vyx8R8CyFVQ0sR+H6vL3aVwHX5aLzcRUpnPJEdXi2v6n9WPQLBgfZgnkd8Tj0DjJmszFUTmBIYhavPGn2JBz6yVy3+C6f/XD3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349147; c=relaxed/simple;
	bh=0KCh9HGa7lQUz4lwWiPgzRORWYPD86UTjPYcKtKujiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=phbFK5LqasoZzMOHIyLyGYZzeeLEvtM3Zp9SwxESW93NtKzx7Q9lsgnywp23A/qdArXc01aMWn9MZTDeCSM9WGxCmYYBcRVkwuDohtrR4EEu866D9fzv3ZZLNjqWzwcPD4/S8ChMMLh8sBF84Nk9+BQYLsN9ktsY1z+ltlDHFTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qYKZWfI6; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qYKZWfI6"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681KbNjr3963534;
	Wed, 2 Sep 2026 11:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=u7zo3n3eSPW2GkrvoV02j2/bSXhKt
	490qA5xoHDi7Fo=; b=qYKZWfI6wHIPJQM/uvH0VyutO12xjjN/tJ095tsj7WU6j
	MdAnobsYgjXxYAQRPMiWGmZzRXCZHJM7oc4Mj/d6o5LLKjMbeEDqp3RxjntxlKki
	dPni1AJ1pspwAKYtd00QsNID431QYhkv9vX0LnU5gmu6tL2e4eU/CpKY73osi4AU
	nYGLP0uC9v3MvYDLc2o5G9RJj0SAkEgMTYBd2D0VLMwk5t5d7DIEvjjCQfQHR9YM
	VAPRhwbU4FrTmGpecknm+rq/YWgsA20KeddFBtYq5/ypXIlmtCEzSvcDAHai8wnN
	5rSM0P6J/xDpioRxoed9JtpBrGXZ88B0m3pZ7LZlw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbqyrxkm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Sep 2026 11:38:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 682BaY3L029406;
	Wed, 2 Sep 2026 11:38:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvrnt4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Sep 2026 11:38:34 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 682BcYmY038508;
	Wed, 2 Sep 2026 11:38:34 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-52-253.vpn.oracle.com [10.154.52.253])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gbnvrnt37-1;
	Wed, 02 Sep 2026 11:38:33 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, eddyz87@gmail.com, jolsa@kernel.org,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, bpf@vger.kernel.org, dwarves@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 0/6] Encoding of inline functions using BTF
Date: Wed,  2 Sep 2026 12:38:20 +0100
Message-ID: <20260902113829.1285407-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2609020103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEwMyBTYWx0ZWRfX6smBj0ifTwU0
 fmjiWsAAZWn9RdKDlQ32xdXYKkt7QGSDLLNlwG9eO7obnK+Qd7i4H135Jc6J18ejERIKI8MaH2P
 +XnBk44M2GAjazqA+SAauDtp1B/kejaE78tiM54ASPpcZhws/KrjdhnztXOl3WoyYWttfVHQwHu
 sSZUZizB4Rfips7Nb5vb3fu7um1evfXX/Y2NSQwsigAmXrv9rlPqwi7KlKKzo3wkv58+9GEC8LU
 pfdIU9O9m/rtmZ+8HcV7+VmvH/8i9W9jq73vWDGOJM8q2vBRG4n8ykvbir+knj1OJ4FjbEEZ+QX
 1w7j/Csk1psPeGBlO6FP96DSlI9A3mLPIyPx77f2mxHb2Wwwa/ci9W8qpQDKDaV8g3rmQqfieYS
 FAyEhosxqaz2gniEkjmwXEJIJL73k7rhsnCuZi9VOY4f3aswlMMCKiJNQwwjFV372dJqMG2Mcub
 NhBzhNfFC1pCD3MseWtJTISQ45E2qZP9rq6Fj/WA=
X-Proofpoint-ORIG-GUID: LLLjLzKUqSK4zCCOJFWtYW6w8x9TTa7D
X-Authority-Analysis: v=2.4 cv=fbCdDUQF c=1 sm=1 tr=0 ts=6a980abb b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=OrFIkyZIpKdRzsvFrI8A:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12102
X-Proofpoint-GUID: LLLjLzKUqSK4zCCOJFWtYW6w8x9TTa7D
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEwMyBTYWx0ZWRfX2y8wpe882owB
 h8z7ZeRfQozzYMDB6pMMea4sgEUlzUy3hn1mio5pZIijRPUR5XN0NxUvRSwjpSeISNk1rQycPM6
 77R8dT6c3Jdz7mmPukoLZ6+pj4iPykW9MZwoMSb2g9JH1jJ5InnD

Support encoding information about inline functions using BTF,
in particular the libbpf interfaces added in [1].

When the "inline" BTF feature keywords is added, we also process
and encode BTF_KIND_LOC_PROTO, PARAM and LOCSEC info for inline
functions as part of CU traversal. Patches 1-3 add dwarf_loader
support for this; patch 4 then uses libbpf interfaces to add
inline info to the generated BTF. Patch 5 adds support to
the btf_loader to support recognition of inline functions in
BTF, supporting pfunct rendering of a function as inline.
Patch 6 verifies that encoding and display of inline functions
succeeds.

Inline support is gated by presence of BTF location-related
functions in libbpf, so the easiest path for testing is
to install the libbpf built from the series at [1], and
when building pahole to run

    cmake -DLIBBPF_EMBEDDED=off ..

as this ensures you will run with the updated libbpf with
those interfaces (otherwise pahole auto-detects the lack
of the relevant interfaces). To verify all is working,

    pahole --supported_btf_features

should show "inline".

[1] https://lore.kernel.org/bpf/20260901165757.801449-1-alan.maguire@oracle.com/

Alan Maguire (6):
  dwarf_loader: Add parameter list to inlined expansions
  dwarf_loader: Resolve inline expansion names during recoding
  dwarf_loader: Collect inline expansion location data
  pahole: Support inline BTF location encoding
  btf_loader: Add "inline" annotation for inlined functions
  tests: Validate inline BTF encoding

 btf_encoder.c       | 339 +++++++++++++++++++----
 btf_loader.c        |  52 +++-
 dwarf_loader.c      | 645 ++++++++++++++++++++++++++++++++------------
 dwarves.c           |  34 +++
 dwarves.h           |  59 ++++
 pahole.c            |  12 +
 tests/btf_inline.sh | 120 +++++++++
 7 files changed, 1041 insertions(+), 220 deletions(-)
 create mode 100755 tests/btf_inline.sh

-- 
2.43.5

