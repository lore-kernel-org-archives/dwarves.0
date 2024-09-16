Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFA814A60C
	for <dwarves@vger.kernel.org>; Mon, 16 Sep 2024 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726494598; cv=none; b=SFFnRCNT36hXrWUHUnZzRrUntT7t8iDQz/ro1uT1A04sf5DHoFORg+xtR0mwAreHf2WCr6cjGVo7Qw+zfRAML2hIZLvQCSPJhW9vAOsiVPziPp6ye4p2jTCkUN16qby+KUhQpogd7FzmonnkEq8R9BKE1cu6MjyA/Ac0CjxWBZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726494598; c=relaxed/simple;
	bh=ZbG48DziUjs72cMxICQVTEtXSwXDjdwu04sOPDhBfdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fI9soK0VMT94A8afGFIi8J8bZ0rftE/nx2IUzP/KZvebWAOVRNLE9HQYV38PjGSg+VBCxlxdBCkrCawlW7hJhtiLyNmaPNRpZGC2LQaXdQ8MoxTuucicbvc4RQAxButcdILMvmtj6HgVl7g7brYSEYpxlzXyGG1Kh5CpuoPnCKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VkrLsYW8; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VkrLsYW8"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GCC4Pg011574;
	Mon, 16 Sep 2024 13:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=M9Xk7zy8MYFhFG
	GMuQVcappMp6RBArGtCzqkByEgC3k=; b=VkrLsYW8BkCvPShN0dqXwGyuCA7T/7
	mSG3RhTdEq35DF54omZP5ZqSAuYtxxZoDs0lwxv9VMprAqYedy8BpRsm+R1C5xzb
	EVwJNCQXI7+Zx4vcHz6ufK44VeI413XlzjT1U6vHpfD+6RCCWMw2Y4Oq+IjInf7y
	f3HNNRufqovnfjRXgpAS6XDYSck7SO0p6N5ecDHqTkTDhWkokJf5foBa5k0a4twz
	Uvd+HkPFF7U4ssTEpLmSTmSZz3MkoUlKhoz/LGa8cyuUXpMX4L7ZLiLeHsbr/0e4
	LuLgb3gKTDEM4dCXFkOJ6zWqg2Y1sF2mN3a+sXBJSfX/Bx4L5rhsJ+xQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3rjua6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 13:49:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48GDG9Ar017868;
	Mon, 16 Sep 2024 13:49:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nycvcbef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 13:49:50 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48GDlw0o019465;
	Mon, 16 Sep 2024 13:49:50 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-208-154.vpn.oracle.com [10.175.208.154])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41nycvcbbr-1;
	Mon, 16 Sep 2024 13:49:49 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, eddyz87@gmail.com, olsajiri@gmail.com,
        shung-hsi.yu@suse.com, jirislaby@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 dwarves 0/3] reduce memory overhead of BTF encoding
Date: Mon, 16 Sep 2024 14:49:43 +0100
Message-ID: <20240916134946.3893204-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_10,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409160088
X-Proofpoint-ORIG-GUID: T9udX90zv4LVB528_68bHhA1sgURdKG7
X-Proofpoint-GUID: T9udX90zv4LVB528_68bHhA1sgURdKG7

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
function-related changes quickly.  The test takes approximately 5
minutes to run.

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

 btf_encoder.c          | 543 ++++++++++++++++++++++++++++++-----------
 pfunct.c               |  36 ++-
 tests/btf_functions.sh | 192 +++++++++++++++
 3 files changed, 619 insertions(+), 152 deletions(-)
 create mode 100755 tests/btf_functions.sh

-- 
2.43.5

