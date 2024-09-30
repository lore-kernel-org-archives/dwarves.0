Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899E6178378
	for <dwarves@vger.kernel.org>; Mon, 30 Sep 2024 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727684293; cv=none; b=NKUTW/XwFeJe0FbytzSwyqxRMRa4QIwY4+zhY6jrl31kKHIuuNMWd2e3RwAhoQhZtwc+dVwl18j9oHPf7twsKNcdywtgexTpRdt+BTW0JhKOcLIGlF6F8ArsSJot8GjewehP+CEhKf1YaC484fqdwRzfXrJQTQSvLfkb8DNKvW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727684293; c=relaxed/simple;
	bh=hsL/5w+wyl2jRe5i+WpzPxXtvm2x+r0uu0Zwe8fXoqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G3gEItAnhtXqjv0ig2su55g3HHAGnwBTq8327FK2/L74d68/8UhGnpJ9DDQWeVu7QVv7JfCbOcwRqggalRyubOjmLDPma2dTQ/76A+QmXRp3z5iZGZmfwdReQfzg2iLs7P8enQ17Vo0sr4VvIZfmB17NTjL/FV5wD7AMBwv3N8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V4onx7XI; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V4onx7XI"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U2tbaG015499;
	Mon, 30 Sep 2024 08:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=HGWHdXyNpXUPzC
	uS9xxiay9O1CRi/64o1VzzOcO7mk8=; b=V4onx7XIYBZRA+sYfxvrlA8W09WBU+
	h59A3pqxde+DML6gCVH4qxFSuLkiT9saUrQNSWZKtRSjoPiZzydwy3I+1OjoNvO0
	x2Qe/9OT+7MAOxUODksa27txVGQK1TAoAlG0P06x9S8ZeUS6FEMu5WbtoDwjdbr6
	x0Ws0wTqsmLxlmMH8DTj1ipc23ZbaCqKL0eSb5/h+R5gc78b/NwxRdgs5VGeGtDU
	PM2p1RnGXMhDHqa4F0slgJc/e87LkwSpjB/+4pZUXBWOrjOu8RrmIykDswfZg24m
	NumwEs+qty9kBDUS/omahycss1vCKC2eCoag5AjpJ1IRjGBjec+iXPsw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8d1ap8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 08:17:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48U7d6Me040493;
	Mon, 30 Sep 2024 08:17:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x885qhfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 08:17:29 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48U8HSoA017104;
	Mon, 30 Sep 2024 08:17:28 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-219-134.vpn.oracle.com [10.175.219.134])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41x885qheg-1;
	Mon, 30 Sep 2024 08:17:28 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org, eddyz87@gmail.com, olsajiri@gmail.com,
        shung-hsi.yu@suse.com, jirislaby@kernel.org, sedat.dilek@gmail.com,
        w@1wt.eu, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v4 dwarves 0/2] fixes for memory optimized BTF
Date: Mon, 30 Sep 2024 09:17:23 +0100
Message-ID: <20240930081725.2465825-1-alan.maguire@oracle.com>
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
 definitions=2024-09-30_07,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409300059
X-Proofpoint-ORIG-GUID: Zk7Gwq97L51WWAOUgqVe_181_wvGMADx
X-Proofpoint-GUID: Zk7Gwq97L51WWAOUgqVe_181_wvGMADx

This series is identical in effect to [1], it is simply applied
on top of the "next" branch which now includes v2 of the series.

Patch 1 fixes issues identified in code review around use of
func->state, strncpy issues.

Patch 2 speeds up the btf_functions.sh test by reducing the
number of greps/pipes, shaving ~1 minute off execution time.

[1] https://lore.kernel.org/dwarves/20240925091734.1943742-1-alan.maguire@oracle.com/

Changes since v2:

- fixed checks of func->state since it is always non-NULL and removed
  now-unneeded fields from dwarves.h; added assertions that either
  ELF or DWARF data is present for func encoding (Jiri, patch 1)
- fixed strncpy() issues, improved equality comparions between types
  (Eduard, patch 1)
- reworked btf_functions test to minimize overheads (patch 2)

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

Alan Maguire (2):
  btf_encoder: fix strncpy issues, other issues identified in code
    review
  tests: improve btf_functions.sh by reducing greps/pipes

 btf_encoder.c          | 68 ++++++++++++++++++++++++++++--------------
 tests/btf_functions.sh | 22 +++++---------
 2 files changed, 54 insertions(+), 36 deletions(-)

-- 
2.43.5

