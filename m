Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A5B1537B9
	for <dwarves@vger.kernel.org>; Wed, 25 Sep 2024 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727255869; cv=none; b=GYfDxN/yOceC0bJCFxqCXycnc0WFj1KdNZQhLl4dLgHRAdNxVWoW5cEU7GuXVwEOA9vyAoptzHKwFN7aHJbjKVc94UgWID6mB7Zrgp6CshzlSo9ZGCsLRhcePCQ3z2/OXHzw5C0s8cqwNyC/Xzrt+dhRD+oNj+Q8rRZ4vOZXJMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727255869; c=relaxed/simple;
	bh=A4+0mswvHJPn31U5kZlrqaChDUDUEotiQVDb31pTcvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EepBy/z1T1sEtruQM89WFQtSBU7cimrBeh/Za0HQWvyPXpQCa9B9QTZfaAQLz+D6BaqeTTDAWhIeG/d7BybPFvr1LygpIzv/414TyTLAAxNPT6Kvp194GijVni2SOTui7Dl2AT2KL6wuySLl4ZEtvpJ1heeinl1hhRs/NcbBncE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b3F7hhP9; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b3F7hhP9"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48P1u6HU011646;
	Wed, 25 Sep 2024 09:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=K9F7yCn052ysWI
	6VOmNeEBmL5xfZWafJMu+gHVjfVAo=; b=b3F7hhP9m9QiJpQYaiQthq655+AEzt
	D+gIdtjBhHTGfTjC8mkswBvlnVTE/wUsP0x0O+pHj+VhXLgCXVrkZsPnt7ewXrnC
	/3MzEqkMs2ZpwWJqu6YC3zSdHTvmafebYZ2nSI1boapeZWXlrAOTv34G11E+6i3L
	EYs+fJb3S8/2DUUiFLXT1OrDIpGQKiKnQ57EHz05xdHijvGNxr0PEdfvHWN3Qqbm
	tSArfu81PHinPOa68Z2mBfuotVa1ZohGhRMo2TPGGvSwiZMBKOwH7yZlhGNU6fos
	hv/WbHP8e8+tVlFri4FQNG49qAsy86RCXUyHLtRXlgWVX7p+rDa9DVrw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smx37bxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 09:17:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48P7bEA7025128;
	Wed, 25 Sep 2024 09:17:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkaetuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 09:17:37 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48P9Flhx007041;
	Wed, 25 Sep 2024 09:17:36 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-212-44.vpn.oracle.com [10.175.212.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41smkaettn-1;
	Wed, 25 Sep 2024 09:17:36 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, eddyz87@gmail.com, olsajiri@gmail.com,
        shung-hsi.yu@suse.com, jirislaby@kernel.org, sedat.dilek@gmail.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 0/3] reduce memory overhead of BTF encoding
Date: Wed, 25 Sep 2024 10:17:31 +0100
Message-ID: <20240925091734.1943742-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-25_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=841 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409250065
X-Proofpoint-ORIG-GUID: jdYdLVCseozGxCCntTPIqRhoxEUOQRO6
X-Proofpoint-GUID: jdYdLVCseozGxCCntTPIqRhoxEUOQRO6

The goal of this series is two-fold

- Reduce memory utilization during pahole BTF generation
- Improve testing for BTF function encoding

Patch 1 switches from using a DWARF representation when saving function
information for (possible) later addition to using BTF; the result
is we can discard DWARF info after use and memory usage will not
get out of hand.  Peak memory utilization is approximately 1Gb versus
3/4Gb prior to this change when specifying "-j --btf_features=all".

Patch 2 adds support to pfunct to show all functions that match a given
name (allowing us to find inconsistent prototypes in the test in patch
3), and also adds stealer support for printing all DWARF function
prototypes to speed up execution (the latter is used in the test also).

Patch 3 is a bash test script which carries out vmlinux BTF generation
and verifies the BTF functions match their DWARF equivalents, and also
verifies the skipped functions should have been skipped.  Patch 3
depends on the pfunct functionality from patch 2 and the pahole changes
in patch 1, but moving forward should be useful for validating pahole
function-related changes quickly.  The test takes approximately 4
minutes to run.

Changes since v2:

- fixed checks of func->state since it is always non-NULL and removed
  now-unneeded fields from dwarves.h; added assertions that either
  ELF or DWARF data is present for func encoding (Jiri, patch 1)
- fixed strncpy() issues, improved equality comparions between types
  (Eduard, patch 1)
- reworked btf_functions test to minimize overheads
- replaced egrep with grep -E (Arnaldo, patch 3)

Changes since RFC:

- fixed free issues (Jiri, patch 1)
- embed func state into struct elf_function as each function
  has state, and we can use the stack for state comparison
  avoiding the cost of additional allocations (patch 1)
- fix an intermittent coredump that resulted from using
  btf__str_by_offset() string in adding function prototype;
  needing more space could sometimes result in strset memory
  movement which would in turn invalidate the char * string,
  so copy it to a char array for param name/tag value encoding
  (patch 1)
- improve logging of decision to skip functions so that we can
  gather that info more easily for testing in patch 3
- added new option to pfunct to show all instances of a function
  prototype and - if no function is specified - use the stealer
  to dump out all prototypes more rapidly to aid quicker testing
- added test covering BTF function generation, checking that
  DWARF/BTF are consistent and that for skipped functions the
  skip rationale was valid (Jiri, patch 3)

There's no diff-style tests comparing encoding before/after
changes, but having automated tests probing DWARF/BTF
correspondence is useful I think.

Alan Maguire (3):
  btf_encoder: record BTF-centric function state instead of
    DWARF-centric
  pfunct: show all functions that match filter criteria
  tests: add test validating BTF encoding, reasons we skip functions

 btf_encoder.c          | 565 +++++++++++++++++++++++++++++++----------
 dwarves.h              |   2 -
 pfunct.c               |  36 ++-
 tests/btf_functions.sh | 186 ++++++++++++++
 4 files changed, 636 insertions(+), 153 deletions(-)
 create mode 100755 tests/btf_functions.sh

-- 
2.43.5

