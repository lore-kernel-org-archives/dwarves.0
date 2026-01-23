Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DCF2BD022;
	Fri, 23 Jan 2026 17:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769189225; cv=none; b=QXwfNFAdekH8nqszCI78ITZvN58npc9+sLaswdQcXrNYcJJdTOuLKFxX2Sg0hvYu9BSr7Ko20NY5hxVxP6qsgCmBJ9A7y/pytzVfZQ1QWvoUezIec7Vkp8+2aRQnjunJm8YqrXPPHVVjqh7ZR8UpMODb3FkK+Gemf7xFPcWOeG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769189225; c=relaxed/simple;
	bh=gE+YSAmUdBU9tF5v5zjzS2N7WXLrWf9Pl+CsEd15rek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LLdO0g6OBqC61enZmJ/ZDy1U+KD2jmyBWlXGDO5O4ywOKdEGbiE6ScY1O7fgvnqePfsim0ctrlo4qv45ZaEIfJK2Uk6xqi264LykkZf/89C3BAPT+oCXqqb9XxuibYnZpqR/1n+Vv5fffZ8H70EWh5ARCkosJ7S8rlX4CUbzk0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V7LZfsJd; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V7LZfsJd"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NFQliQ1884148;
	Fri, 23 Jan 2026 17:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=EUmeirkADnF+iEw/WsQoXPRLsBxBf
	6cnvjcddv3gNl0=; b=V7LZfsJdOwzWJSyY81i5GFyNTVhSy7obBQRxynCK1QXuJ
	iV0i7qqmvQaXXw/Lp8eqxuQTpYEEJldVXyXGvb5s4VUMeT90OtZKC5cziz4KFAp+
	1an0oJyq5cW5dv3BBLJyiFLVcr/0/BP15v/8SZxEaSrSQ/RqgA7gnrOO06B3oZN7
	MdDn/8ULLGojffHTNfwJLQ3WTx9XiTnBdGJRcwbPThkeAZhyePj/PA8YPmaeC54D
	Pjrs6LCyBVDHB0AWBwCgn9wmYJTox6VwwkxZzFjaNBVzd5ZZXq28dMFa2sz9cuKP
	3g0+/WJVSgBwe2fum7YWryjMQcJIILV7sTSthS4lA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br1b8jt1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 17:26:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60NGrTmm025036;
	Fri, 23 Jan 2026 17:26:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bujd1q8pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 17:26:53 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60NHH3mL020337;
	Fri, 23 Jan 2026 17:26:52 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-82.vpn.oracle.com [10.154.50.82])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4bujd1q8n1-1;
	Fri, 23 Jan 2026 17:26:52 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: yonghong.song@linux.dev, mattbobrowski@google.com
Cc: ihor.solodrai@linux.dev, eddyz87@gmail.com, jolsa@kernel.org,
        andrii@kernel.org, ast@kernel.org, david.faust@oracle.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 0/5] Improve BTF concrete function accuracy
Date: Fri, 23 Jan 2026 17:26:45 +0000
Message-ID: <20260123172650.4062362-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=811 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601230131
X-Authority-Analysis: v=2.4 cv=WbcBqkhX c=1 sm=1 tr=0 ts=6973af5e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=JqVbt3Op-64Y-Lxj14cA:9 cc=ntf awl=host:12104
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDEzMSBTYWx0ZWRfX60S6VV3fjGWD
 s3p8XN/TWdrki/vGRZjXZ5tMZhqVa7P84WOB2vmS414k1Lk3e3tVcPJEeaPbmKseKTPuKHzZMGJ
 DING8BdwV+wRl9IuYbIFx+MNxUSEBbSlBWzNob9xujGfm482ZKR132z5dzV9bftDluvamJKJ+Vn
 zsBD6lguSRCvvob/Ra/iLcD9QqCSbTq4qUQU253bGdkivgPOJwbHfav/MxoFWcHMxFYyNWX/IAJ
 Aa86+rID73PgqkjTTMdJP/GXven2ERqALIG4nzRvCLA7OACJL1WqwJUNUZ8eYehAia7Jt857acJ
 ZnrjjxhqxNxa0swA2nDTL745Nkct9ykJgLmYX+hRpEJ1RFJjfjCB64EQ3WRGuu3R+u4sETIBNXz
 le/HzjgsaFgOxLN/sDr+jk16iypJfCmOtbhmScdkoKfYh0jVtD8gWx76vdn2apJ2YborSw2P5He
 8KB+mnCqux/SiZiiDlh2wUhwdkCQ2wHBjOGyMwGM=
X-Proofpoint-ORIG-GUID: DSlpwrg_mh8HW8qkO8pDQTNZAiE9kLLA
X-Proofpoint-GUID: DSlpwrg_mh8HW8qkO8pDQTNZAiE9kLLA

This series brings together a few solutions to issues we have
with accuracy of BTF function representation at the binary level.

The first patch detects mismatches between concrete (binary)
and abstract (source-level) function signatures as a means
of either excluding them or providing a "true" function signature.

Patch 2 adds GCC true function signature support for optimized
functions; with that support, we use binary-level signatures
for .isra.0, .constprop.0 functions and represent them with
their "." suffixes as BTF_KIND_FUNC names.

This allows for fentry attach to such functions, and
the "." suffix is an indicator of signature modification.
The feature is guarded by a default-off BTF feature because
older kernels did not support a "." in a function name.

Patch 3 uses Yonghong's example program as a test; compiling
with -O2 we expect a parameter to "foo" to be optimized
out and the true function signature should reflect that.

Patch 4 documents the non-default "true_signature" feature.

Patch 5 is Matt's patch to favour the strong function
over the associated weak declaration.  The other patches
are important prerequisites for this as the patch selects
the binary-level function (with a lowpc value), and in
the case of optimized functions we were often selecting
the .isra function with optimized-out parameters.  Because
pahole did not previously detect this correctly we ended
up with functions with signatures having reordered parameters.

Patches 1-2 help avoid this by better detecting optimized-out
function parameters.

With these patches in place, ~20 functions are omitted from
vmlinux BTF; all these are "."-suffixed functions which
we were not noticing had optimized-out parameters.

Experimenting with adding true_signature to BTF features
we end up adding approximately 500 .isra and .constprop
functions to vmlinux BTF.

The true function signature support here will also hopefully
help pave the way for Yonghong's work on the LLVM side.

Changes since v1 [1]

- dropped Yonghong's patch (Ihor)
- fixed up issues Yonghong found in true signature encoding
  where we did not adjust the number of parameters and
  were not handling true function signature case correctly
  when adding saved functions (Yonghong, patch 2)
- added test using Yonghong's example (patch 3)

[1] https://lore.kernel.org/dwarves/20260113131352.2395024-1-alan.maguire@oracle.com/

Alan Maguire (4):
  dwarf_loader/btf_encoder: Detect reordered parameters
  btf_encoder: Add true_signature feature support for "."-suffixed
    functions
  test: add gcc true signature test
  man-pages: document true_signature btf_feature

Matt Bobrowski (1):
  btf_encoder: Prefer strong function definitions for BTF generation

 btf_encoder.c                | 139 +++++++++++++++++++++++++++++++----
 dwarf_loader.c               |   5 +-
 dwarves.h                    |   3 +
 man-pages/pahole.1           |   5 ++
 pahole.c                     |   1 +
 tests/gcc_true_signatures.sh |  92 +++++++++++++++++++++++
 6 files changed, 227 insertions(+), 18 deletions(-)
 create mode 100755 tests/gcc_true_signatures.sh

-- 
2.43.5

