Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC10B38F23D;
	Thu, 26 Feb 2026 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772096996; cv=none; b=D3cH2Ef67s1Afn1JmjFj/oO4VkzZuWWtXezGyFWJAq8KRYXtmcrevxDhKKMx4r4fc72moQxg49x2irNaD9nOuYu9lbM1/nNpYwHhj1d+9H44uuX0sXe4F2J3hJhelgCtc8wOomty3pzAxTZlN0hSjJB/uOuvW4jqDZAU0BGgCu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772096996; c=relaxed/simple;
	bh=1C640ESpd102pq3iSVEs8qWq8AE673eEK1qtROp9F08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mjEKf0xSkiZ8ORA1CUNb8xxPy89XLaGNkAcrb+lGEXhid3z1B7H5vKu25v/AmzFHxobMmSJZQ9GWwDz1AZjZ0YSkGhcMp3fc0+zNOumeIiqZ/reOtgHToor66gRsb6EWA8Kku9HO+tk1flquVoyfcNORQbiWJu6UcHsMV7IK56w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hVv6N9Ab; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hVv6N9Ab"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PNvrPl3277797;
	Thu, 26 Feb 2026 09:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=nKRWu3jzbDSF+FO4fn9HQ8c/4ZVj+
	SQSkrCEaeTkmo0=; b=hVv6N9AbXjHzCEtsJG3Zmd4qYI9Le0XkL1FUj8UDC4j63
	ZxzXfseuMWNtH7zI2HoGeBRNA1k+QUwaEJPDkqijL8nT/120bEKqP2CsSkYJFC+A
	dcI8drS8ip/86RGvoPi3Kcb/gW29UslNUZS0Ivs1UlSg9DQpwFSKAHd7k+wh3+Nh
	KYPIH5lWPI2XTfefE+iRymt6Uq74n70cNzVwF4FbLHqq9658ppexGMAoAZhg0eTi
	HhOlN/Uq6zdd2Y/n1zvG8QzSURJhTItUzT6ZV3zTsijpmJkIg10pjtWMb3qETzKL
	CohXxnjeL3RBhsjdxPvG+yFj5g9n+AgprkJhg/VbQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4k5ytyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 09:09:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61Q6a7Jk028678;
	Thu, 26 Feb 2026 08:56:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35c75bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 08:56:34 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61Q8uYaQ038952;
	Thu, 26 Feb 2026 08:56:34 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-58-146.vpn.oracle.com [10.154.58.146])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cf35c759a-1;
	Thu, 26 Feb 2026 08:56:33 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v9 bpf-next 00/10] Add BTF layout to BTF
Date: Thu, 26 Feb 2026 08:56:14 +0000
Message-ID: <20260226085624.1909682-1-alan.maguire@oracle.com>
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
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602260079
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA4MiBTYWx0ZWRfX1V4EHB9DIT8n
 rSumUoQT+wmpZevzObG9/me2nDJABQG2740eAUHN7U7rZfP8rw7YhJy2MmyPiCi1WSsgKEPGeE0
 4f3ny/XDikHoURbpLVtVxVMLEPHDp1ZZw/ObCCmFZbQAB8fZ6pdsE5eBVzylys1z7zSZn8SOp2i
 zD/t+v1CLpM1ejBD8DhQi29EUH0Pe1coBfT5StQxQoCdvA+h8VneuzoweZioar0Vy63BFDdl9wZ
 dof3eWQ7ATsWFmWsGazoMnj0qtDYN2qWrQcOybLwAFzTDe8at7Uqee7CTeFI+CnNtg/PS8FGhEh
 Iofwmd1smnTkBkNvPCJ9dYiCgv5XPzC69dfk5Kael3j3Ki5frIYwTlBY26EN749wDtis15ocEwZ
 jqltrwgatMum3J12QfPi+NJdMcj2/Nj4GwbdVsazmxZD8wuW/U4SJjR49puQoycWSeK5BC8WEue
 DLk9lTnqwrDrlqOUE/A==
X-Proofpoint-GUID: H5DBJK936lgDJKMH1Qzc2-slZKDcZCVa
X-Authority-Analysis: v=2.4 cv=b9C/I9Gx c=1 sm=1 tr=0 ts=69a00dc1 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=rhq5rkmzt818iw8Jb8EA:9
X-Proofpoint-ORIG-GUID: H5DBJK936lgDJKMH1Qzc2-slZKDcZCVa

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

Changes since v8: [4]:

- updated name from "kind_layout" to "layout" (Andrii)
- moved layout info to inbetween types and strings since
  both types and layout info align on 4 bytes (Andrii)
- use embedded btf_header (Eduard)
- when consulting layout, fall back to base BTF if none found in
  split BTF; this will allow us to only encode layout info in
  vmlinux rather than repeating it for each module.

Changes since v7: [5]:

- Fixed comment style in UAPI headers (Mykyta, patch 1)
- Simplify calcuation of header size using min() (Mykyta, patch 2)
- simplify computation of bounds for kind (Mykyta, patch 3)
- Added utility functions for updating type, string offsets when
  data is added; this simplifies the code and encapsulates such
  updates more clearly (patch 2)

Changes since v6: [6]:

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

Changes since v5: [7]:

- removed flags field from kind layout; it is not really workable
  since we would have to define semantics of all possible future
  flags today to be usable. Instead stick to parsing only, which
  means each kind just needs the length of the singular and
  vlen-specified objects (Alexei)
- added documentation for bpftool BTF metadata dump (Quentin, patch 9)

Changes since v4: [8]:

- removed CRC generation since it is not needed to handle modules
  built at different time than kernel; distilled base BTF supports
  this now
- fixed up bpftool display of empty kind names, comment/documentation
  indentation (Quentin, patches 8, 9)

Changes since v3 [9]:

- fixed mismerge issues with kbuild changes for BTF generation
  (patches 9, 14)
- fixed a few small issues in libbpf with kind layout representation
  (patches 2, 4)

Changes since v2 [10]:

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
[4] https://lore.kernel.org/bpf/20251215091730.1188790-1-alan.maguire@oracle.com/
[5] https://lore.kernel.org/dwarves/20251211164646.1219122-1-alan.maguire@oracle.com/
[6] https://lore.kernel.org/bpf/20251210203243.814529-1-alan.maguire@oracle.com/
[7] https://lore.kernel.org/bpf/20250528095743.791722-1-alan.maguire@oracle.com/
[8] https://lore.kernel.org/bpf/20231112124834.388735-1-alan.maguire@oracle.com/
[9] https://lore.kernel.org/bpf/20231110110304.63910-1-alan.maguire@oracle.com/
[10] https://lore.kernel.org/bpf/20230616171728.530116-1-alan.maguire@oracle.com/

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
 kernel/bpf/btf.c                              |  96 +++-
 scripts/Makefile.btf                          |   2 +
 .../bpf/bpftool/Documentation/bpftool-btf.rst |  28 +-
 tools/bpf/bpftool/bash-completion/bpftool     |   2 +-
 tools/bpf/bpftool/btf.c                       |  94 +++-
 tools/include/uapi/linux/btf.h                |  12 +
 tools/lib/bpf/btf.c                           | 420 +++++++++++++-----
 tools/lib/bpf/btf.h                           |  20 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/btf_kind.c       | 206 +++++++++
 11 files changed, 746 insertions(+), 147 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_kind.c

-- 
2.39.3

