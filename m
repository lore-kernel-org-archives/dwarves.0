Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3E3273803;
	Fri,  6 Mar 2026 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772797021; cv=none; b=ljrQsTcZ7m9ajnIRGfiPMh28krXZV5mHiVOq/+lQ1B+bNvp/AKB0NilGFkMOm5SJyuGyewYUD64hXYAfAvey+nzRRo8nuQa4MDkvFpeyVJiUBDaxU2ZLvISGQEKodOEiiK9/kylHkQ64zszkW4g3QP4upzCqnDAS7CPSK3Z/2C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772797021; c=relaxed/simple;
	bh=t2iz0l7Bst9hQLkadRvGUGqWbQoph/1qRvrvF8cJr6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FVW+7Znd9lI5MAMBlm2ZxPwqTGdkGMDkAD/5uuolUaQUsvWn4g7xDwwlphbR/NZA/aN7uLfYWLbp6dWTP0WB1bjkhd38ywdILNdVTlb5GsnBskqDS8T37ERQIdobTG6uLc6G2m8Y6TTPiABzaUyJZcI3pDsOMAgilqisyJgKPYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IlA6+SCh; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IlA6+SCh"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626AtN0h2394956;
	Fri, 6 Mar 2026 11:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=+PVpcQLmqJMgLsYpSMUfehDa5rSrX
	RJjyafib+wbzJ0=; b=IlA6+SChDPKXEIqEnUylGZU1txWzsaTFWuuejBNOffr0B
	Bo1DPSsO74vHWToTevxvks8GhaenJ3pAvEz2Dli3fZjiHqVABy5OvEv/bpJpbENi
	kRgnLsS9II5JDiKqaiz4qD/1wFZ0JI1GPRjD582SFsFNvrEQ/Ec/fTHoiqiHvkAz
	D4SwSP+HyyTWa9BtsG2fJiZYI3IhAqTzzyIOe3cXvvSaytW8fkckxGvfugHzY6KJ
	rknPvykjBoEWL4kAlAN5bnlLnzQoNu8Zx2tBZS7wQGgSCQZ3z60nV/Pz62l9ai8m
	n+FKZJnsguxzPfS71YH3nojRbRi1U7GPkmW1WwbzQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cqwkp01gp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 11:36:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6269hJev023220;
	Fri, 6 Mar 2026 11:36:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptjtmn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Mar 2026 11:36:34 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 626BaXEp025727;
	Fri, 6 Mar 2026 11:36:33 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-62-192.vpn.oracle.com [10.154.62.192])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ckptjtmhd-1;
	Fri, 06 Mar 2026 11:36:33 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v13 bpf-next 0/8] Add BTF layout to BTF
Date: Fri,  6 Mar 2026 11:36:22 +0000
Message-ID: <20260306113630.1281527-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603060110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDExMCBTYWx0ZWRfX+aG7xC9iw/e5
 dvnL7E/ax8hvc29PQ6vf752nAfY/nzJR/UXUeBWtFP+De8D2F7JacsH3nyc+i17M2cF7egMl4uo
 ctxSroSspAOJZmqvlwJ8JXrE3vOzhXnv9Gz7u31rxpRxLZPJOLF9zhF5nrPxWJf3dhsoHrGvAMn
 uKo5ehyaskiAqNSDQyJ3msYmXyBjv+BFNlnJpm0Hl6YdmZpFvVbFRh7I9Ce0qS8V82EzzT1PneC
 9PzdG3nHoNehQbdu4/rCVZz59CnfRx+RqcRrvf43G0e5csNoyihPOlRDtproJ+L9Qc4AV9HbslT
 bQH4ghbvJ0hpAlYVjOnHDU63/To05Ve8M0iWNbGqAg1u5FrOUazIvHk33k1zq/PAYuP48A1HrNH
 r6g6fhwL2QUp9W038WylkOu+w9dSLWDIAowCNRixhbK11sSa7j9AiOeQzxS/sBV1wAK3xXs+Q4C
 ILvrKFhUfmkkR0NwGibyp+tCzE6RdbK1UybU/Vyw=
X-Proofpoint-ORIG-GUID: snRczdnYRgfXjC9OX9ZPyyNfvC5Hckm8
X-Proofpoint-GUID: snRczdnYRgfXjC9OX9ZPyyNfvC5Hckm8
X-Authority-Analysis: v=2.4 cv=Rc2dyltv c=1 sm=1 tr=0 ts=69aabc43 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=CBUCM8e3fqF-Uks7LccA:9 cc=ntf awl=host:12267

Update struct btf_header to add a new "layout" section containing
a description of how to parse the BTF kinds known about at BTF
encoding time.  This provides the opportunity for tools that might
not know all of these kinds - as is the case when older tools run
on more newly-generated BTF - to still parse the BTF provided,
even if it cannot all be used.

The ideas here were discussed at [1], with further discussion
at [2].

Patches for pahole will enable the layout addition during BTF
generation are at [3], but even absent these the addition of the
layout feature in the final patch in this series should not break
anything since such unknown features are simply ignored during pahole
BTF generation.

Changes since v12: [4]:

- add logging of layout off/len to kernel header logging (review bot,
  patch 6)
- add mode to open() in selftest (review bot, patch 7)

Changes since v11 [5]:

- Revert unneeded changes to btf__new_empty() (Eduard, review bot,
  patch 4)
- Reorder btf_parse_layout_sec() checks to ensure min size check
  occurs before multiple check (review bot, patch 6)

Changes since v10 [6]:

- deal with read overflow with small header (review bot, patch 2)
- validate layout length is a multiple of sizeof(struct btf_layout)
  (review bot, patch 6)
- fix comment style (Alexei, patches 4,7)
- remove bpftool BTF metadata subcommands for now (Alexei)

Changes since v9: [7]:

- fix memcpy header size overrun (review bot, patch 2)
- return size computation directly (Andrii, patch 333)
- revert to original unknown kind logging (Alexei/review bot,
  patch 6)
- gap-checking logic can be simplified now that we have
  4-byte aligned types and layout together (patch 6)
- fix naming of layout offset, unconditionally emit a layouts
  array in json (Quentin, review bot, patch 8)
- fix metadata output in man page to include flags (review bot,
  patch 9)

Changes since v8: [8]:

- updated name from "kind_layout" to "layout" (Andrii)
- moved layout info to inbetween types and strings since
  both types and layout info align on 4 bytes (Andrii)
- use embedded btf_header (Eduard)
- when consulting layout, fall back to base BTF if none found in
  split BTF; this will allow us to only encode layout info in
  vmlinux rather than repeating it for each module.

Changes since v7: [9]:

- Fixed comment style in UAPI headers (Mykyta, patch 1)
- Simplify calcuation of header size using min() (Mykyta, patch 2)
- simplify computation of bounds for kind (Mykyta, patch 3)
- Added utility functions for updating type, string offsets when
  data is added; this simplifies the code and encapsulates such
  updates more clearly (patch 2)

Changes since v6: [10]:

 BPF review bot caught some memory leaks around freeing
  of kind layout; more importantly, it noted that we were
  breaking with the contiguous BTF representation for
  btf_new_empty_opts(). Doing so meant that freeing kind_layout
  could not be predicated on having btf->modifiable set, so
  adpoted the contiguous raw data layout for BTF to be
  consistent with type/string storage (patches 2,4)
- Moved checks for kind overflow prior to referencing kinds
  to avoid any risk of overrun (patches 3, 8)
- Tightened up kind layout header offset/len header validation
  to catch invalid combinations early in btf_parse_hdr()
  (patch 2)
- Fixed selftest to verify calloc success (patch 7)

Changes since v5: [11]:

- removed flags field from kind layout; it is not really workable
  since we would have to define semantics of all possible future
  flags today to be usable. Instead stick to parsing only, which
  means each kind just needs the length of the singular and
  vlen-specified objects (Alexei)
- added documentation for bpftool BTF metadata dump (Quentin, patch 9)

Changes since v4: [12]:

- removed CRC generation since it is not needed to handle modules
  built at different time than kernel; distilled base BTF supports
  this now
- fixed up bpftool display of empty kind names, comment/documentation
  indentation (Quentin, patches 8, 9)

Changes since v3 [13]:

- fixed mismerge issues with kbuild changes for BTF generation
  (patches 9, 14)
- fixed a few small issues in libbpf with kind layout representation
  (patches 2, 4)

Changes since v2 [14]:

- drop "optional" kind flag (Andrii, patch 1)
- allocate "struct btf_header" for struct btf to ensure
  we can always access new fields (Andrii, patch 2)
- use an internal BTF kind array in btf.c to simplify
  kind encoding (Andrii, patch 2)
- drop use of kind layout information for in-kernel parsing,
  since the kernel needs to be strict in what it accepts
  (Andrii, patch 6)
- added CRC verification for BTF objects and for matching
  with base object (Alexei, patches 7,8)
- fixed bpftool json output (Quentin, patch 10)
- added standalone module BTF support, tests (patches 13-17)

Changes since RFC
- Terminology change from meta -> kind_layout
 (Alexei and Andrii)
- Simplify representation, removing meta header
  and just having kind layout section (Alexei)
- Fixed bpftool to have JSON support, support
  prefix match, documented changes (Quentin)
- Separated metadata opts into add_kind_layout
  and add_crc
- Added additional positive/negative tests
  to cover basic unknown kind, one with an
  info_sz object following it and one with
  N elem_sz elements following it.
- Updated pahole-flags to use help output
  rather than version to see if features
  are present

[1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=eOXOs_ONrDwrgX4bn=Nuc1g8JPFC34MA@mail.gmail.com/
[2] https://lore.kernel.org/bpf/20230531201936.1992188-1-alan.maguire@oracle.com/
[3] https://lore.kernel.org/dwarves/20260226085240.1908874-1-alan.maguire@oracle.com/
[4] https://lore.kernel.org/bpf/20260303182003.117483-1-alan.maguire@oracle.com/
[5] https://lore.kernel.org/bpf/20260302114059.3697879-1-alan.maguire@oracle.com/
[6] https://lore.kernel.org/bpf/20260227100426.2585191-1-alan.maguire@oracle.com/
[7] https://lore.kernel.org/bpf/20260226085624.1909682-1-alan.maguire@oracle.com/
[8] https://lore.kernel.org/bpf/20251215091730.1188790-1-alan.maguire@oracle.com/
[9] https://lore.kernel.org/dwarves/20251211164646.1219122-1-alan.maguire@oracle.com/
[10] https://lore.kernel.org/bpf/20251210203243.814529-1-alan.maguire@oracle.com/
[11] https://lore.kernel.org/bpf/20250528095743.791722-1-alan.maguire@oracle.com/
[12] https://lore.kernel.org/bpf/20231112124834.388735-1-alan.maguire@oracle.com/
[13] https://lore.kernel.org/bpf/20231110110304.63910-1-alan.maguire@oracle.com/
[14] https://lore.kernel.org/bpf/20230616171728.530116-1-alan.maguire@oracle.com/

Alan Maguire (8):
  btf: add BTF kind layout encoding to UAPI
  libbpf: Support layout section handling in BTF
  libbpf: use layout to compute an unknown kind size
  libbpf: Add layout encoding support
  libbpf: BTF validation can use layout for unknown kinds
  btf: support kernel parsing of BTF with layout info
  selftests/bpf: test kind encoding/decoding
  kbuild, bpf: Specify "layout" optional feature

 include/uapi/linux/btf.h                      |  12 +
 kernel/bpf/btf.c                              |  60 ++-
 scripts/Makefile.btf                          |   2 +
 tools/include/uapi/linux/btf.h                |  12 +
 tools/lib/bpf/btf.c                           | 418 +++++++++++++-----
 tools/lib/bpf/btf.h                           |  20 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/btf_kind.c       | 224 ++++++++++
 8 files changed, 623 insertions(+), 126 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_kind.c

-- 
2.39.3

