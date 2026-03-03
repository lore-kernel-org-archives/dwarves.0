Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ED6346FA8;
	Tue,  3 Mar 2026 18:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772562091; cv=none; b=fcAx0LDvcuk/CuNGI28m8lmjCIM3otfBPhzaCLTQl1nMw8Z/PAZNIxqw3iyQMAnQCSkKTRhHSKcleL58iqAzt5QV13DndWm6QOrX+/amDDeZbRqPnL3hxKeNZXU9nGxPChGVnba3OfrSU5J5f3XbsYg3pjoGsecdFcAYwnoooGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772562091; c=relaxed/simple;
	bh=ujL+6dMd5SAKKNwDjrqW6qtj6OV9abCunAuF43o60oI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AE5umMkhGUyQUsEhLzBvCPCg0ImRm45bbHBOewcBYFt0vVQbe+Whqu8D/7lZH6Tc9ZoNFroKRBAZdoQE8jqsRoHwcEA/Lozmk0jwL2odoNyQmcl/0Pp4HnQtVMb258mjbvp8J+4+ZA7FAnhjoe4D/LX/zGnV7XJv/BHdOhnnthA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PK+NZif8; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PK+NZif8"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623Hk3Fw637939;
	Tue, 3 Mar 2026 18:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=S1FtDtCO1EI97sfaku6dm7pXFghCM
	jy7llmydUtXeRk=; b=PK+NZif8rkYudeEDhlis70PMmvLFKvbjnkHeBTt+cBxaS
	WybBdGkN691ipQC3j+c3IsII62QHe9d2Qf9MlLwKQhAicp7SyQ9ZVETdqDMFk6p0
	gFCVDX4z+dj/O8EpMT/rBQ0DFcT9ADcVFY6/fFxeEXBOgmjCxKK9JyJq2vQpze6G
	o4ujVHVouwIS/et//xyUPCRADNaFFQSPNk3PxPo4U0sl2mZdlK/EnT0PuKMvAyin
	gAdPwsbprj5NeRUj6mUM/bKsrQNDsBaRtfYv9Y82+ckPW5HBZUgVz4pHg4u6ifwt
	6BnDNKT9XsfUKQU3nMMccI8408MpOITFYiuy5aQDg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cp4b3g1r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 18:20:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 623HcZCt037800;
	Tue, 3 Mar 2026 18:20:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpteyy0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 18:20:08 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 623IK7o3029269;
	Tue, 3 Mar 2026 18:20:07 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-62-133.vpn.oracle.com [10.154.62.133])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ckpteyxu6-1;
	Tue, 03 Mar 2026 18:20:07 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v12 bpf-next 0/8] Add BTF layout to BTF
Date: Tue,  3 Mar 2026 18:19:55 +0000
Message-ID: <20260303182003.117483-1-alan.maguire@oracle.com>
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
 definitions=2026-03-03_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603030148
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE0OCBTYWx0ZWRfX0aKRzKYdQQI8
 TSIHfcaoTJqRlTNTPy/7X/HAQds4wjgLBI9tdsxzAMcLIS+QV2jzGY+X3QGADVdcxva5VEJEiHn
 kzDDBHW7nltZKxuUCU/ld7z2IQG8jKiEQfPycg7sWI9+1c/1oDgjXOszt/AxqKEeQ7O2PbcAEUW
 mSP5LXhoh5EDn34pTN0FvKK95zWVwqg6/OxRK3mLH6B2C/8Rw2OjDeHvpWZ5pIL93CmpiBgb9TC
 pB2XFJmvv2sVb1l9N10PJYJ36aYwJrYgvxNmzWcB400OOsqqJwFjdK1ua/K9UIpcaVe04QREwXn
 j7iHae+vPltK50bKgla582LEBVBPIyMrJpIvZ7J+Cs1AERs/ODBFbqNMlfMVL3UxtgKPq734jGG
 5pGJCXu1J3vpTswCQc/kKcsYNopP/8HGlWGFtqkPzCUQ6m/C5ne63sAmeKhQq4gVE+OIYCORwAj
 kE7Zq47tt3rQs7hJQ7VAi/Rghx/F+5AoPzL3JdKU=
X-Proofpoint-GUID: PgTC5NIcfO73IqFCQRUGNHFDTi7XjAYH
X-Proofpoint-ORIG-GUID: PgTC5NIcfO73IqFCQRUGNHFDTi7XjAYH
X-Authority-Analysis: v=2.4 cv=GuRPO01C c=1 sm=1 tr=0 ts=69a72658 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=CBUCM8e3fqF-Uks7LccA:9 cc=ntf awl=host:13812

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

Changes since v11 [4]:

- Revert unneeded changes to btf__new_empty() (Eduard, review bot,
  patch 4)
- Reorder btf_parse_layout_sec() checks to ensure min size check
  occurs before multiple check (review bot, patch 6)

Changes since v10 [5]:

- deal with read overflow with small header (review bot, patch 2)
- validate layout length is a multiple of sizeof(struct btf_layout)
  (review bot, patch 6)
- fix comment style (Alexei, patches 4,7)
- remove bpftool BTF metadata subcommands for now (Alexei)

Changes since v9: [6]:

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

Changes since v8: [7]:

- updated name from "kind_layout" to "layout" (Andrii)
- moved layout info to inbetween types and strings since
  both types and layout info align on 4 bytes (Andrii)
- use embedded btf_header (Eduard)
- when consulting layout, fall back to base BTF if none found in
  split BTF; this will allow us to only encode layout info in
  vmlinux rather than repeating it for each module.

Changes since v7: [8]:

- Fixed comment style in UAPI headers (Mykyta, patch 1)
- Simplify calcuation of header size using min() (Mykyta, patch 2)
- simplify computation of bounds for kind (Mykyta, patch 3)
- Added utility functions for updating type, string offsets when
  data is added; this simplifies the code and encapsulates such
  updates more clearly (patch 2)

Changes since v6: [9]:

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

Changes since v5: [10]:

- removed flags field from kind layout; it is not really workable
  since we would have to define semantics of all possible future
  flags today to be usable. Instead stick to parsing only, which
  means each kind just needs the length of the singular and
  vlen-specified objects (Alexei)
- added documentation for bpftool BTF metadata dump (Quentin, patch 9)

Changes since v4: [11]:

- removed CRC generation since it is not needed to handle modules
  built at different time than kernel; distilled base BTF supports
  this now
- fixed up bpftool display of empty kind names, comment/documentation
  indentation (Quentin, patches 8, 9)

Changes since v3 [12]:

- fixed mismerge issues with kbuild changes for BTF generation
  (patches 9, 14)
- fixed a few small issues in libbpf with kind layout representation
  (patches 2, 4)

Changes since v2 [13]:

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
[4]
[5] https://lore.kernel.org/bpf/20260227100426.2585191-1-alan.maguire@oracle.com/
[6] https://lore.kernel.org/bpf/20260226085624.1909682-1-alan.maguire@oracle.com/
[7] https://lore.kernel.org/bpf/20251215091730.1188790-1-alan.maguire@oracle.com/
[8] https://lore.kernel.org/dwarves/20251211164646.1219122-1-alan.maguire@oracle.com/
[9] https://lore.kernel.org/bpf/20251210203243.814529-1-alan.maguire@oracle.com/
[10] https://lore.kernel.org/bpf/20250528095743.791722-1-alan.maguire@oracle.com/
[11] https://lore.kernel.org/bpf/20231112124834.388735-1-alan.maguire@oracle.com/
[12] https://lore.kernel.org/bpf/20231110110304.63910-1-alan.maguire@oracle.com/
[13] https://lore.kernel.org/bpf/20230616171728.530116-1-alan.maguire@oracle.com/

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
 kernel/bpf/btf.c                              |  55 ++-
 scripts/Makefile.btf                          |   2 +
 tools/include/uapi/linux/btf.h                |  12 +
 tools/lib/bpf/btf.c                           | 418 +++++++++++++-----
 tools/lib/bpf/btf.h                           |  20 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/btf_kind.c       | 212 +++++++++
 8 files changed, 606 insertions(+), 126 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_kind.c

-- 
2.39.3

