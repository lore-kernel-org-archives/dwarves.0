Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E374A2BEFF6;
	Tue, 27 Jan 2026 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769534460; cv=none; b=oguvUxQ7dodS/On1/uSSTiaynRTeBr009v/Z9zHdvieZ9SA9Cr1ZRKQHYBzCV/sf7LAQ4R2bAnhDIfZvWu9VYt3QOlcjicrEmH1r9dl8qeAr6IyIeGw/tOoOa0mKlUbkeDvAQZMXZJpEJ/R4WCfkzoVZU8AMazfTv3TovkYEcnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769534460; c=relaxed/simple;
	bh=kHhc4V4FogK8AoUS897Z16HkmgyTQvIcYb+ysH0yuyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PSqEvI7/OAplGl6V0eGl9Xz4jAyy4gVKlZiO08x+VXsUCCYmITJx6nZYFhl3ZJbNRPxCJC9VIqIna0YhYSPT6F19RY1/GIxZ1uZ4xELYqhFNLbmL9eMNp8H+VIoRko5CR1laNPGkxnR+KlF2ra0EP4U+wtZ+T9PKL9MQ25DAeWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zv7tLCmR; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zv7tLCmR"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RD9Ru44016953;
	Tue, 27 Jan 2026 17:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=c/A2YU6Ax61R2mXp8YiU1QylJrJpD
	Pmfby0s4a2vrN8=; b=Zv7tLCmRlKz73+iXz0VcfAeBtxRqxpXBUlTgx0Byh4Gd+
	dkyrkR1+iy24c8x69a8MLqYY55kqHw/OrGNz2BEAxOW924IRualZU5B9VG85V4Bq
	M3zuxlBpWcIQuT1vK2T02wxfbumPszHzCtiThvD4iy+fQ93R5NQymCK6A8MFriZg
	uXNygpOset1m64zOaYqTiPbSe7cytK8NMZU0L3Le3FsEnvBzMydU4OQhAaBgshGF
	tupqDUYM2xKpfb9ONsO3orkaupxFxfaAtt6LbyS5WyzFbROxf9pWay9F67DzKGCv
	NPGI3bUV2Sq4FPFuDHBSmWaTtw5FmVgXTZyJQB2wQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bxx09gfbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 17:20:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RGY23h032704;
	Tue, 27 Jan 2026 17:20:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh9q7uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 17:20:45 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60RHKjSf011183;
	Tue, 27 Jan 2026 17:20:45 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-55-133.vpn.oracle.com [10.154.55.133])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4bvmh9q7sn-1;
	Tue, 27 Jan 2026 17:20:44 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: yonghong.song@linux.dev, mattbobrowski@google.com
Cc: ihor.solodrai@linux.dev, eddyz87@gmail.com, jolsa@kernel.org,
        andrii@kernel.org, ast@kernel.org, david.faust@oracle.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 0/5] Improve BTF concrete function accuracy
Date: Tue, 27 Jan 2026 17:20:36 +0000
Message-ID: <20260127172041.1558244-1-alan.maguire@oracle.com>
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
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=808
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601270141
X-Proofpoint-ORIG-GUID: HRhhexFo5xQJ1qRpdfcTpvVe50jq6h7u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE0MSBTYWx0ZWRfX0Kws6gRC7l9i
 XxZnUDP66riYJ92JdmcCkL8/C7PpejKFNenhbEwgYG2qK9coNz81ut9fTS2jAPj4bXuwIq1JKkj
 KBUwwlezQhaawMMJWorqlBjoh3s+nwTVx16sv4DYblKnxRmgax2jzyinVdKabaoiHpQxAW/ONYe
 9gzlRoNNdC3pzpIlDx92iBJb9nYcGtVBMpQIdmYhritu1P3/aZ3T6zNYUUOIrTr9EkS7B9Fo/XV
 zDvkHLgsW3Z8xjgZf21o3wHOq4scaDB8BvFLkOfNyCpcHXThpEK1TOmpeXCnXkWZOcwWGRANgcd
 kfrMV5qs0uHuEiG7N4NWjYrdOzBkLKHmyXdm+gTzRaJ90ye+2dVAhL4tiWBh4TB7tAci2iMVzg+
 WBwXjvlbm8Tj7syeemwtufp5SER8mmGy+FLukgcAzxqTUH13/pZZW56i/Hd/hxEPBWH91eYh2TE
 eAZM71SbqG7kbkoIfSg==
X-Authority-Analysis: v=2.4 cv=Qe5rf8bv c=1 sm=1 tr=0 ts=6978f3ee b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=JqVbt3Op-64Y-Lxj14cA:9
X-Proofpoint-GUID: HRhhexFo5xQJ1qRpdfcTpvVe50jq6h7u

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

Changes since v2 [1]
- updated patch 2 to set state->addr via function__address() and
  use it (Matt, patch 2)
- refactored true signature addition code into separate function
  (Matt, patch 2)

Changes since v1 [2]

- dropped Yonghong's patch (Ihor)
- fixed up issues Yonghong found in true signature encoding
  where we did not adjust the number of parameters and
  were not handling true function signature case correctly
  when adding saved functions (Yonghong, patch 2)
- added test using Yonghong's example (patch 3)

[1] https://lore.kernel.org/dwarves/20260123172650.4062362-1-alan.maguire@oracle.com/
[2] https://lore.kernel.org/dwarves/20260113131352.2395024-1-alan.maguire@oracle.com/

Alan Maguire (4):
  dwarf_loader/btf_encoder: Detect reordered parameters
  btf_encoder: Add true_signature feature support for "."-suffixed
    functions
  test: add gcc true signature test
  man-pages: document true_signature btf_feature

Matt Bobrowski (1):
  btf_encoder: Prefer strong function definitions for BTF generation

 btf_encoder.c                | 162 +++++++++++++++++++++++++++++++----
 dwarf_loader.c               |   5 +-
 dwarves.h                    |   3 +
 man-pages/pahole.1           |   5 ++
 pahole.c                     |   1 +
 tests/gcc_true_signatures.sh |  92 ++++++++++++++++++++
 6 files changed, 250 insertions(+), 18 deletions(-)
 create mode 100755 tests/gcc_true_signatures.sh

-- 
2.43.5

