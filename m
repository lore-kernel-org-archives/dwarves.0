Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D0F33261A;
	Fri, 27 Feb 2026 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186698; cv=none; b=H3Z1/HNSjRzCGT1Me6RNP9ELvBUfY8pitAXykeyCWljogFpLwIY8xj1K5DlGfOxWhw2L5/rRHrd5dLwqPNmoQsOzVRezLTXB/tO0mFnYghbzR9fZacFIAetM0l+GjVVWQsdPmeJscdU3cXR2PnJhCFh3FiFxMdiD/ad228ClRE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186698; c=relaxed/simple;
	bh=zZqWpkm3iwYrFmyi5KZxuLFQQp8epE9tEyHFO7AYCrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a7Z5RiPmOkCF+mNXvqNd2o830B0DUOefJE7hEoJWGmzUMKVQ/PmyOCAvcd1l9aGVMaeIqiIzLcU+JvZz57yFGesHQVtB9qSl+zV+XxutwDokeab4dnTud/Q1lpt7AeFnx+ozW23jn2uX2+R3RArdNT8GTQMX+o8+ZW5gkPYP7c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OlObyn+N; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OlObyn+N"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R9vdcK3020255;
	Fri, 27 Feb 2026 10:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=BZJQib+jBX6yvJnMdJ4FK4daC+fOc
	c5+/TpzVEH9nMc=; b=OlObyn+N3xgnwYc5mHVQ/hgneKNCfbgOgu9fCeiUHTqUS
	4N3YBkXK0PDjqvVJlud4hZ0MoPjE+3iA+NGmZu27VByHwNlNWY4I9TlrnGlHAiui
	DqRmMlEkCkDXsBg+TlMk7jiFvs6De/6zyBBuEJs09vvxjX4Z2NFRL/3RCUqtkEal
	tA5a5WO0q3/dlL833ICJwAS7zFOtz/o3Y526ji3bluAyxdyOPF9PnLTgQYoe4qoP
	3mUSkFvItW5RFIC7Cq0OVYK/5saAUyceb+UvlsCE4gE22ykygc8aiDLdStTiUEoP
	w47p/IIKS73HpYTR9WL7rA8n5JC4maarqUBvuYS7A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cjgjft70n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 10:04:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61R80wZZ027800;
	Fri, 27 Feb 2026 10:04:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35dmx61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 10:04:32 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61RA4VxW036185;
	Fri, 27 Feb 2026 10:04:31 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-60-228.vpn.oracle.com [10.154.60.228])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cf35dmx3p-1;
	Fri, 27 Feb 2026 10:04:31 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v10 bpf-next 00/10] Add BTF layout to BTF
Date: Fri, 27 Feb 2026 10:04:16 +0000
Message-ID: <20260227100426.2585191-1-alan.maguire@oracle.com>
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
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602270086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA4NiBTYWx0ZWRfXxAU4EBigcnAP
 IRfbbyZCcTtXoL8H3Immf+gBLyeKt2vTUVqv0tCc7r3vKmS2fTCd25OKMKFNeLCUsCpIltLrvG8
 LDltDaMkC9rdR5NkTdURi+grL18wcv+UnZaCohagUL0WKR5dpyr779kKaK1wFV0/X+TZxRxSm5H
 f/NJir7WWH5zKQo12JXgKkoFjoif1rtG8+btVW+WKJxwipNaqR7eFALZd/OBQlLg7mN9b3ZnT/H
 QzkAn4QE7HAxrEZ2vZzJlHat9xxdYjuJhdKV18zn/sJxLfwl7nl7hmtBki8977iKgobEKgsE+Sc
 Crzfv9Q1sEyJKnZDfpzQnWPwg5Y4S8ZZRicOqh5eH4m7XlKChk/0289f06JkfFb3X8dZyg6J2g/
 nYgcBkrYHI1CeasnJGReQFX40Z7x9+XNLZ4v68rZN1fkcdr/B7u76UpYkp9mq8f8injLp1YfsEG
 tC9BIb6B5uG3LDlYLOQ==
X-Proofpoint-ORIG-GUID: luy549-13stNI61Bw7BKUitVQSOgPGZ1
X-Proofpoint-GUID: luy549-13stNI61Bw7BKUitVQSOgPGZ1
X-Authority-Analysis: v=2.4 cv=L/oQguT8 c=1 sm=1 tr=0 ts=69a16c31 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=CBUCM8e3fqF-Uks7LccA:9

Update struct btf_header to add a new "layout" section containing
a description of how to parse the BTF kinds known about at BTF
encoding time.  This provides the opportunity for tools that might
not know all of these kinds - as is the case when older tools run
on more newly-generated BTF - to still parse the BTF provided,
even if it cannot all be used.

Also add support to bpftool to dump metadata about BTF; its size,
header information and kind layout section.

The ideas here were discussed at [1], with further discussion
at [2].

Patches for pahole will enable the layout addition during BTF
generation are at [3], but even absent these the addition of the
layout feature in the final patch in this series should not break
anything since such unknown features are simply ignored during pahole
BTF generation.

Changes since v9: [4]:

- fix memcpy header size overrun (review bot, patch 2)
- return size computation directly (Andrii, patch 333)
- revert to original unknown kind logging (Alexei/review bot,
  patch 6)
- gap-checking logic can be simplified now that we have
  4-byte aligned types and layout together (patch 6)
- fix naming of layout offset, unconditionally emit layout
  info in json (Quentin, review bot, patch 8)
- fix metadata output in man page to include flags (review bot,
  patch 9)

Changes since v8: [5]:

- updated name from "kind_layout" to "layout" (Andrii)
- moved layout info to inbetween types and strings since
  both types and layout info align on 4 bytes (Andrii)
- use embedded btf_header (Eduard)
- when consulting layout, fall back to base BTF if none found in
  split BTF; this will allow us to only encode layout info in
  vmlinux rather than repeating it for each module.

Changes since v7: [6]:

- Fixed comment style in UAPI headers (Mykyta, patch 1)
- Simplify calcuation of header size using min() (Mykyta, patch 2)
- simplify computation of bounds for kind (Mykyta, patch 3)
- Added utility functions for updating type, string offsets when
  data is added; this simplifies the code and encapsulates such
  updates more clearly (patch 2)

Changes since v6: [7]:

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

Changes since v5: [8]:

- removed flags field from kind layout; it is not really workable
  since we would have to define semantics of all possible future
  flags today to be usable. Instead stick to parsing only, which
  means each kind just needs the length of the singular and
  vlen-specified objects (Alexei)
- added documentation for bpftool BTF metadata dump (Quentin, patch 9)

Changes since v4: [9]:

- removed CRC generation since it is not needed to handle modules
  built at different time than kernel; distilled base BTF supports
  this now
- fixed up bpftool display of empty kind names, comment/documentation
  indentation (Quentin, patches 8, 9)

Changes since v3 [10]:

- fixed mismerge issues with kbuild changes for BTF generation
  (patches 9, 14)
- fixed a few small issues in libbpf with kind layout representation
  (patches 2, 4)

Changes since v2 [11]:

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
[4] https://lore.kernel.org/bpf/20260226085624.1909682-1-alan.maguire@oracle.com/
[5] https://lore.kernel.org/bpf/20251215091730.1188790-1-alan.maguire@oracle.com/
[6] https://lore.kernel.org/dwarves/20251211164646.1219122-1-alan.maguire@oracle.com/
[7] https://lore.kernel.org/bpf/20251210203243.814529-1-alan.maguire@oracle.com/
[8] https://lore.kernel.org/bpf/20250528095743.791722-1-alan.maguire@oracle.com/
[9] https://lore.kernel.org/bpf/20231112124834.388735-1-alan.maguire@oracle.com/
[10] https://lore.kernel.org/bpf/20231110110304.63910-1-alan.maguire@oracle.com/
[11] https://lore.kernel.org/bpf/20230616171728.530116-1-alan.maguire@oracle.com/

Alan Maguire (10):
  btf: add BTF kind layout encoding to UAPI
  libbpf: Support layout section handling in BTF
  libbpf: use layout to compute an unknown kind size
  libbpf: Add layout encoding support
  libbpf: BTF validation can use layout for unknown kinds
  btf: support kernel parsing of BTF with layout info
  selftests/bpf: test kind encoding/decoding
  bpftool: add BTF dump "format meta" to dump header/metadata
  bpftool: Update doc to describe bpftool btf dump .. format metadata
  kbuild, bpf: Specify "layout" optional feature

 include/uapi/linux/btf.h                      |  12 +
 kernel/bpf/btf.c                              |  50 ++-
 scripts/Makefile.btf                          |   2 +
 .../bpf/bpftool/Documentation/bpftool-btf.rst |  28 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
 tools/bpf/bpftool/btf.c                       |  91 +++-
 tools/include/uapi/linux/btf.h                |  12 +
 tools/lib/bpf/btf.c                           | 418 +++++++++++++-----
 tools/lib/bpf/btf.h                           |  20 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/btf_kind.c       | 206 +++++++++
 11 files changed, 710 insertions(+), 132 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_kind.c

-- 
2.39.3

