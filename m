Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48E63672A8;
	Fri, 25 Sep 2026 18:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362378; cv=none; b=QDfqf/OJIThxY6NQzDtv5knASwkl0ZCSzzL28QsDW4t+2TNBlw6jNTv0iDR2hdwON/cXCFs1q0as4WGSrIkmUeVojHy/3i9/RM8XqPAsOfqSy+7A1tjAOo+3v+LKkg8qv4lktPIX6njPe/cyIV4VbnqRGKodJQkBaXjbUVi49Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362378; c=relaxed/simple;
	bh=qAUN0VZzjJuopLzm+/5Ggc3GQXsSmqxbhgQsxkZMtus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bdoz9Ka0At6v5roW9E173EtEJ1CnikNqFyofg9OehAQlG0Rvbtv5qCFmK5yBA1ITedYfZBXtexkuKyt3RvraNRXmtgYjl/1rRbbA7FW+488jursZJyUTH2ph3GseOmd1LAZ59K8SKBk/Ev6I7SHOuWrjdDSRU3j7qKju43BsZWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TDxp5ggY; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TDxp5ggY"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PEBoUm3837161;
	Fri, 25 Sep 2026 18:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=q63c6adxFLYFIual272lKII75EpCy
	P+7lEk5s+2aC7s=; b=TDxp5ggY6nnSFKpwKJPyORdvwEBADWZbmpGGEg8OgChcw
	muBpjAkxj5T0js6SLApElji814FdosQFVl6GAlglXiwwr2Fb8ox24T00dzKHCVgK
	JS1gGNmZsvkrRPh3WK+U+FCsdN78r9CkR4eSzwsE/MmCdnwkQvyDWG54Ljovr1Tn
	vUlbfnFhETIPqG3X67eTOWQhTqKeksql2O1K7YmBsTCk4j/xMGk9asp5WnuJWTxZ
	XZrHOK4Sw/rpVucp/F5USNSqdlqXB2bJRZVtPLoX1Lwr9Q58x+lAtWslbJQ9a2zg
	EkYLsACzcD4CvAZTBfHWFvXZV9Y4u+J+shQam7qKw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk1qhwy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:52:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68PIqI6w038935;
	Fri, 25 Sep 2026 18:52:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gteptht74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:52:27 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68PIqQoe040536;
	Fri, 25 Sep 2026 18:52:26 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-81-122.vpn.oracle.com [10.154.81.122])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gtepthsyc-1;
	Fri, 25 Sep 2026 18:52:26 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        qmo@kernel.org
Cc: dwarves@vger.kernel.org, jolsa@kernel.org, daniel@iogearbox.net,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
        bpf@vger.kernel.org, nsc@kernel.org, puranjay@kernel.org,
        yatsenko@meta.com, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v3 dwarves 0/9] Encoding of inline functions using BTF
Date: Fri, 25 Sep 2026 19:51:49 +0100
Message-ID: <20260925185200.1318067-1-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609250075
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NSBTYWx0ZWRfXwQo1tx8R6d7K
 OGmOgGQ0Kguvct7kh3fOwH6QExKnF+C8i6cBY57FT/lYP/t5hTQFTxlEOWnYY54L1XCW8VBLO7C
 YF6RXZwrFzM3U/W6yCw4EWUxENwiJcynDIyQV7NMKCdS0yYSPaCm
X-Proofpoint-ORIG-GUID: i0-cUYCFJJnIcFRoYHj8hjx5Cu7xTAH_
X-Proofpoint-GUID: i0-cUYCFJJnIcFRoYHj8hjx5Cu7xTAH_
X-Authority-Analysis: v=2.4 cv=LIzz05W9 c=1 sm=1 tr=0 ts=6ab6c2ed b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=gkyxjGqXORVeeKrT1oYA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13532
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NSBTYWx0ZWRfX3belLvVg8TAb
 W4T13Moz3r+KS6piHD/oiytkYbE/l6beo5LEF+9+2S4SS/qv/7A2g7h8OjQwQYahjNhPeRkOouB
 q7k4t9MIrL04TDFSSv3lJpYnNznEJMMzNlG5lKuW6Ds6p8Tzs9LYkrBwuVM/YaHbK+oawTJpWPl
 FyOq2wmzsTMDJgtW/LEIpCLrAMlOeNHB4wTNFhuF294oxZ6eZb3YUGTWFEik84+WDrTqjYnTOHO
 MpVk0EtAcs2B02Q4m9kFo7cCwMzO7vUqBfdYEwCYtXTYvDB5uYnCCBTymwH0WzpzFpxzdf5IwT2
 /DeapVV8kxaAjQid6J12N7Up5oiV/y3BK5YWnsIBLhKY2baQyNlkLhN9etEMGQXH2ty1csZf8jZ
 K6bFgH5445R3kxkT52dVyH4TM0fTJ/73A901gacExmrBHJQIPTDqu5WBFV6KNOK3VAV91RxjuZC
 NQNANZqmGNMgMy9nTCRuhAlsxuMHTSt3iK2c8MRE=

Support encoding information about inline functions using BTF,
in particular the libbpf interfaces added in [1].

When the "inline" BTF feature keywords is added, we also process
and encode BTF_KIND_LOC_PROTO, PARAM and LOCSEC info for inline
functions as part of CU traversal. Patches 1-3 add dwarf_loader
support for this; patch 4 then uses libbpf interfaces to add
inline info to the generated BTF. Patch 5 adds support to
the btf_loader to support recognition of inline functions in
BTF, supporting pfunct rendering of a function as inline.
Patch 6 verifies that encoding and display of inline functions
succeeds.

Inline support is gated by presence of BTF location-related
functions in libbpf, so the easiest path for testing is
to install the libbpf built from the series at [1], and
when building pahole to run

    cmake -DLIBBPF_EMBEDDED=off ..

as this ensures you will run with the updated libbpf with
those interfaces (otherwise pahole auto-detects the lack
of the relevant interfaces). To verify all is working,

    pahole --supported_btf_features

should show "inline".

Patches 1-3 prep the dwarf_loader to collect inline info;
patch 4 converts it to BTF; patch 5 adds the inline annotation
to pfunct output via BTF inline info; patch 6 creates an
inline site representation in the btf loader for use in patch
7 for the --inline_sites display; patch 8 tests inline display
via pfunct and patch 9 updates docs.

$ pahole -J --btf_features=default,inline  \
--btf_encode_detached=/tmp/vmlinux+inline vmlinux
$ pfunct --inline_sites --elf=vmlinux /tmp/vmlinux+inline
0xffffffff8120004a [trace_initcall_start_cb+0xa, .text +0x20004a] task_pid_nr(struct task_struct * tsk [%rax])
0xffffffff8120005f [trace_initcall_start_cb+0x1f, .text +0x20005f] get_current(void)
0xffffffff81200090 [trace_initcall_level+0x0, .text +0x200090] arch_static_branch(const struct static_key *  key [addr 0xffffffff83e275e8], const bool  branch [const 0])
0xffffffff81200097 [trace_initcall_level+0x7, .text +0x200097] __do_trace_initcall_level(const char  * level [%rdi])
...

The --elf uses ELF sections/arch info from vmlinux to render
registers, absolute addresses from base/section relative.

The --running option can be used on inline BTF and the running
kernel (kallsyms) is used for address resolution; this ensures
that kASLR is taken into account. However if kptr_restrict is
active /proc/kallsyms will show address 0 for kernel functions,
so pfunct should be run with privileges in such cases if absolute
address representations are needed.

The kbuild infrastructure will split inline info out into a
separate split BTF object, but pahole encodes inline info
together in the same BTF object here; this avoids the need to
invoke it twice during kernel builds.

[1] https://lore.kernel.org/bpf/20260924111428.75957-1-alan.maguire@oracle.com/


Alan Maguire (9):
  dwarf_loader: Add parameter list to inlined expansions
  dwarf_loader: Resolve inline expansion names during recoding
  dwarf_loader: Collect inline expansion location data
  pahole: Support inline BTF location encoding
  btf_loader: Add "inline" annotation for inlined functions
  btf_loader: Record inline sites in CU for BTF
  pfunct: Print inline site information
  tests: Validate inline BTF encoding
  man-pages: Document --inline_sites option

 btf_encoder.c       | 391 ++++++++++++++++++++----
 btf_loader.c        |  96 +++++-
 dwarf_loader.c      | 580 +++++++++++++++++++++++++----------
 dwarves.c           |  35 +++
 dwarves.h           |  69 +++++
 man-pages/pfunct.1  |  74 ++++-
 pahole.c            |  12 +
 pfunct.c            | 718 ++++++++++++++++++++++++++++++++++++++++++--
 tests/btf_inline.sh | 147 +++++++++
 9 files changed, 1872 insertions(+), 250 deletions(-)
 create mode 100755 tests/btf_inline.sh

-- 
2.43.5

