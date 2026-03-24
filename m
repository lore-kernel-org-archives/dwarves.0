Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA163FB7FC;
	Tue, 24 Mar 2026 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374322; cv=none; b=uxma5nTOH3qYNFGAeSKkdStbOCfCZ99qFj1zl46y7Kio+SGkpqpCAxQ+CJYknRNib74RI19EUX0xuTItm+EeEgEPgn9HWiw2POcUAzFeF8HAFZYIX6Mwgcefy6SsM/ed0NkSTiRjfv9gObJ9jAch0gCsg0bD60MpapaXiWP8NJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374322; c=relaxed/simple;
	bh=KMKvvqQeEFeAKZI35SeK+6b2M+rTiee39EWMGPtBNjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jkm1iiu6zNW2XdrH6SaXjtICvxWDzWqxXgXoy3zXZ/LaHuf8NlLQUI294TlLRezu2qESxmPRqeTMSiLVO7SRrkB+bqVa7hEcF1cE7ZCv0hnHRItG9JxN2xuALxiv6DGnMZlO3+zJMTGSSIz5Cc9M161VcGP8DWWnihIuGxF+6MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hT+vCgKE; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hT+vCgKE"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OCBoAF1021001;
	Tue, 24 Mar 2026 17:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=TeXDdIu4hdMAq63mLaUyllzyAVMzu
	M0LVW3vRhDYFIk=; b=hT+vCgKEvR28pRFJemPmvy3YUc0sgQQkuAbXxOtm9mFpw
	CDVESd67iFNjbwRM2VUoU0uSwEw2VvCnF+yN1b8feypZfqvhMRBW0WXisZRkDp5K
	Hp2OpgIsSCzGJZL5r2q4b23jAkTB7FUvP/8ivRnYPvfZMAkTT02aJB8e0qrxGrBi
	PKNt+Inib2y12yX63hMSX5s8RxJnkvUATM7R7cxsqYQO/5c+bOJgp0o23p/lSLRm
	uayjT9mEjOVKA73gsT9WnTQi/mVvA1zE/QS9EVBqtDlLN0hbi4dYXKE1TBXT3CAv
	2qPwcyN9rngNFMtnyXQXJLc+Sy9oCw6SNYw2OVsnw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kfpmr1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 17:44:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62OGLWP3038910;
	Tue, 24 Mar 2026 17:44:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hsac71c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 17:44:53 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62OHirgi035539;
	Tue, 24 Mar 2026 17:44:53 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-54-179.vpn.oracle.com [10.154.54.179])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4d1hsac706-1;
	Tue, 24 Mar 2026 17:44:52 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
        qmo@kernel.org, ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v15 bpf-next 0/9] Add BTF layout to BTF
Date: Tue, 24 Mar 2026 17:44:41 +0000
Message-ID: <20260324174450.1570809-1-alan.maguire@oracle.com>
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
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603240137
X-Proofpoint-GUID: EU7ZkpY4zu3R3JGhGlFUnolkPhOdwJTg
X-Authority-Analysis: v=2.4 cv=VKnQXtPX c=1 sm=1 tr=0 ts=69c2cd96 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=wxdjVfVITMaiw2tsfTgA:9 cc=ntf awl=host:13824
X-Proofpoint-ORIG-GUID: EU7ZkpY4zu3R3JGhGlFUnolkPhOdwJTg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzOCBTYWx0ZWRfX/1XooeqOps1A
 n9v2hMX8wjWGfVtx31f18Yo0Lu+nH3HgsSfzRT7eheYbZisqA7Z+rwrcE1qRp8Q1fzSAguRxr2T
 lm92nhEOPd8H6VVuTncEJbmGnEusb1Kg/CsW4F4E7hSbtntpiLZvncj53Ac84dX6e/2HLUJy5fY
 4gab3b8+WelQedT/gRJSF5/WlsMbuAHo2oO+osf4+5lvnAw+QvEG5TRq+S/a7DBRJMQyH20NimG
 M2i90m0aBuZEm8aoSiyIS5rGJLKAiysGblQsSL90rTlRvIDZHbZN97iUva1w/zeDwsk3a/njoDq
 0V0/8hjFY7rLz7alDA7DsxJ3qmJtSLM/mlm2yw3qWYszh3P3KOEpz6aD1g5iACjme9KY3eDMh8f
 eEn0PG8gW7aJ7kmMiOQ5lltg76sq5nTnxuFb6yLJTX+XaRDOtpGG6NIkrMnv5MEUP0Q+yxyx/T9
 sv6s4JeEniiF43cnL9NhtZiYHZBrOMsfhnOjPgyE=

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

Separately tested sanitization of BTF location info with separate
small series which simulates feature absence to support testing of
features for older kernels; will follow up with that shortly.

Changes since v14: [4]:

- Fix potential overflow for swapped endian case (BPF review bot,
  patch 2)
- Add global: keyword to libbpf.map (sashiko.dev, patch 4)
- Fix endian issues in sanitization; we use the endian safe
  btf->hdr and check for endian mismatch between it and raw original
  BTF header to inform how we write the change str_off. Also fix
  potential truncation issues due to not including hdr->type_off
  (sashiko.dev, patch 6)
- Fix issues with selftests raw BTF file interactions (sashiko.dev,
  patch 8)
- Drop feature test test since it will be covered by another series

Changes since v13: [5]:

- add feature check/sanitization of BTF with layout info (Andrii,
  patch 6)
- added feature check test for layout support (patch 9)

Changes since v12: [6]:

- add logging of layout off/len to kernel header logging (review bot,
  patch 6)
- add mode to open() in selftest (review bot, patch 7)

Changes since v11 [7]:

- Revert unneeded changes to btf__new_empty() (Eduard, review bot,
  patch 4)
- Reorder btf_parse_layout_sec() checks to ensure min size check
  occurs before multiple check (review bot, patch 6)

Changes since v10 [8]:

- deal with read overflow with small header (review bot, patch 2)
- validate layout length is a multiple of sizeof(struct btf_layout)
  (review bot, patch 6)
- fix comment style (Alexei, patches 4,7)
- remove bpftool BTF metadata subcommands for now (Alexei)

Changes since v9: [9]:

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

Changes since v8: [10]:

- updated name from "kind_layout" to "layout" (Andrii)
- moved layout info to inbetween types and strings since
  both types and layout info align on 4 bytes (Andrii)
- use embedded btf_header (Eduard)
- when consulting layout, fall back to base BTF if none found in
  split BTF; this will allow us to only encode layout info in
  vmlinux rather than repeating it for each module.

Changes since v7: [11]:

- Fixed comment style in UAPI headers (Mykyta, patch 1)
- Simplify calcuation of header size using min() (Mykyta, patch 2)
- simplify computation of bounds for kind (Mykyta, patch 3)
- Added utility functions for updating type, string offsets when
  data is added; this simplifies the code and encapsulates such
  updates more clearly (patch 2)

Changes since v6: [12]:

- BPF review bot caught some memory leaks around freeing
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

Changes since v5: [13]:

- removed flags field from kind layout; it is not really workable
  since we would have to define semantics of all possible future
  flags today to be usable. Instead stick to parsing only, which
  means each kind just needs the length of the singular and
  vlen-specified objects (Alexei)
- added documentation for bpftool BTF metadata dump (Quentin, patch 9)

Changes since v4: [14]:

- removed CRC generation since it is not needed to handle modules
  built at different time than kernel; distilled base BTF supports
  this now
- fixed up bpftool display of empty kind names, comment/documentation
  indentation (Quentin, patches 8, 9)

Changes since v3 [15]:

- fixed mismerge issues with kbuild changes for BTF generation
  (patches 9, 14)
- fixed a few small issues in libbpf with kind layout representation
  (patches 2, 4)

Changes since v2 [16]:

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
[4] https://lore.kernel.org/bpf/20260318132927.1142388-1-alan.maguire@oracle.com/
[5] https://lore.kernel.org/bpf/20260306113630.1281527-1-alan.maguire@oracle.com/
[6] https://lore.kernel.org/bpf/20260303182003.117483-1-alan.maguire@oracle.com/
[7] https://lore.kernel.org/bpf/20260302114059.3697879-1-alan.maguire@oracle.com/
[8] https://lore.kernel.org/bpf/20260227100426.2585191-1-alan.maguire@oracle.com/
[9] https://lore.kernel.org/bpf/20260226085624.1909682-1-alan.maguire@oracle.com/
[10] https://lore.kernel.org/bpf/20251215091730.1188790-1-alan.maguire@oracle.com/
[11] https://lore.kernel.org/dwarves/20251211164646.1219122-1-alan.maguire@oracle.com/
[12] https://lore.kernel.org/bpf/20251210203243.814529-1-alan.maguire@oracle.com/
[13] https://lore.kernel.org/bpf/20250528095743.791722-1-alan.maguire@oracle.com/
[14] https://lore.kernel.org/bpf/20231112124834.388735-1-alan.maguire@oracle.com/
[15] https://lore.kernel.org/bpf/20231110110304.63910-1-alan.maguire@oracle.com/
[16] https://lore.kernel.org/bpf/20230616171728.530116-1-alan.maguire@oracle.com/

Alan Maguire (9):
  btf: Add BTF kind layout encoding to UAPI
  libbpf: Support layout section handling in BTF
  libbpf: Use layout to compute an unknown kind size
  libbpf: Add layout encoding support
  libbpf: BTF validation can use layout for unknown kinds
  libbpf: Support sanitization of BTF layout for older kernels
  btf: support kernel parsing of BTF with layout info
  selftests/bpf: Test kind encoding/decoding
  kbuild, bpf: Specify "layout" optional feature

 include/uapi/linux/btf.h                      |  12 +
 kernel/bpf/btf.c                              |  60 +-
 scripts/Makefile.btf                          |   2 +
 tools/include/uapi/linux/btf.h                |  12 +
 tools/lib/bpf/btf.c                           | 568 +++++++++++++-----
 tools/lib/bpf/btf.h                           |  20 +
 tools/lib/bpf/features.c                      |  29 +
 tools/lib/bpf/libbpf.c                        |  88 ++-
 tools/lib/bpf/libbpf.map                      |   2 +
 tools/lib/bpf/libbpf_internal.h               |   6 +
 tools/lib/bpf/libbpf_probes.c                 |  40 +-
 .../selftests/bpf/prog_tests/btf_kind.c       | 226 +++++++
 12 files changed, 859 insertions(+), 206 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_kind.c

-- 
2.39.3

