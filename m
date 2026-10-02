Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6533435CB7F;
	Fri,  2 Oct 2026 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962894; cv=none; b=qS0ZEhU7sLMJ5lS22KFBy3FvvQgiPaOmsoe61d3c9ECtjGoUpKzjelgSjzQDMZYKZy28rlP1zM25Hho4O0ox4HYZKUZ0COQaR+0r0UGBGdrCNyHcthFpCpV2hOucXC17CtB3yrBR6eUajbn7gpkO4WVXmYAevbDJaj2V3oiz3pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962894; c=relaxed/simple;
	bh=hY04kYFzi3oVZ9jKqMnPYZbJbrxket6Vy+yQOEp1kWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bFwE2Bo3E4tEG5jVAimAu8rXxaxkWhiMnh+UTh6Pm6WiNdlTE17nGkBkPsiPtxYPpLFtd1RvqcS9OJ86hP8lzGulfEbs3tDaU5l/7RYtl9LaCA8PdZJYKfHXdW0gddRR+JqjFLyDDFv4RR77DboJlXjEVDur8UoQ7B7gaCehkGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k7e9vf/U; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k7e9vf/U"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692EbaWh3204339;
	Fri, 2 Oct 2026 17:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=oKy/uznolxNed3otcr7AOeo1puXMy
	baa0BgKgDxADBc=; b=k7e9vf/U4UNAhrqft9Zso74/0tt9wR9ulrWuhA8n2ZCDW
	zvVrI47JCKYfToXiZ0ULkQsUiOPl2PR8wENO8zP+R9uX0e8/TV4HgYBvsK+i+ZTJ
	ZtqIqkYCg9CTgGGg9EtsfJ7u0UlxjLi7KfZY/daZ831tOkEgldPIT3hL0mw+pIFQ
	tB2TizwreFxwniscBLTEJS4IEv3mWBqz1J9iZC/Bvxxdy++BHJZDIHS3tyHqMkzg
	WZ+YMKKo7JDjblkpZbNU1iaHYLD/Dgr+nU/lw65a/quhzcnSiTVPtl0wHqtX5lgG
	OLpdzTF1TTJsGoYnZQFnWRoXwEMFt+sbA3kkOzCrA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4fbmat9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Oct 2026 17:40:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 692HZQFm014305;
	Fri, 2 Oct 2026 17:40:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gtqthj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Oct 2026 17:40:47 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 692HekeN030471;
	Fri, 2 Oct 2026 17:40:46 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-83-232.vpn.oracle.com [10.154.83.232])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4gx4gtqtes-1;
	Fri, 02 Oct 2026 17:40:46 +0000 (GMT)
From: Alan Maguire <alan.maguire@oracle.com>
To: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        jolsa@kernel.org, qmo@kernel.org
Cc: dwarves@vger.kernel.org, daniel@iogearbox.net, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, bpf@vger.kernel.org,
        nsc@kernel.org, puranjay@kernel.org, yatsenko@meta.com,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v5 dwarves 00/10] Encoding of inline functions using BTF
Date: Fri,  2 Oct 2026 18:40:28 +0100
Message-ID: <20261002174043.3823987-1-alan.maguire@oracle.com>
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
 definitions=2026-10-02_05,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610020070
X-Proofpoint-ORIG-GUID: 5GL5FV7zLWOM7GoB8OOf2VHtanFFfH0E
X-Proofpoint-GUID: 5GL5FV7zLWOM7GoB8OOf2VHtanFFfH0E
X-Authority-Analysis: v=2.4 cv=eJCGH3p1 c=1 sm=1 tr=0 ts=6abfec9f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=Fn6lFP0pQm9nfbwrvrMA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:13537
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA3MCBTYWx0ZWRfXznlTuq0g+v5v
 zmTNO+4E2gA7P6N9tri+H8xSV5gzEEi9EvvDgiF5Q+lsM6m1b0PZCwDXy0XJJJRbLf7u82q49wd
 2tOXmWgVcbglDrxbY13/JUuaIrxtLeqk+m9PdCvZR2lmxS+/9LtI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA3MCBTYWx0ZWRfX0lDS8eDGqDsv
 GIPB/TCa3DXsDCdbSPOLtVgwRlE7rSvGqvoqC9fSUgCI3f4dXP1LnQBzGOmGKxUnOgcqBx9nnYo
 Ssy0GkTqyEkf1lJRZ7w/DXr+9uK+qBcQB9n3VgJmYUEBvl5PvQ093PKMiZJXf8yaiRXX6QGLZjj
 MgGxbr8qhhtF6ESUkvS28VfCtoUKQ2f5DAo9bU8gRkUL+rExx1tnRlCHINfNWUwHQ3ezTqGibYA
 Yzj1GWGiT/NK9oiGQ3x/rATy7diXJPhnb5MHQ5TsF9Mw06O62v+q6pVLf0Ng+xGaHP9rO9zA8fA
 TesmfI1LT63IUuJjIEHlIFEOic5M4bgjkznJ+OWX/0KPR+R+/lvdvN9tS9OnPklrxbKPvfrgHCb
 iJCBywOCxuoL/y5eXrZU9ay7H+3rvLePhlM8tCzUvVoozQU2l7Ks7Tb/n3U0mS5DEy0jhqsQbHf
 VtPpRmltcMjxEuBbeh/dvSJZ/JjHiJ+vu+wif4cE=

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
functions in libbpf; either use a bpf-next libbpf containing
the series [1] or use the embedded libbpf (the default)
from latest pahole.

To verify all is working,

    pahole --supported_btf_features

should show "inline".

Patches 1-4 prep the dwarf_loader to collect inline info;
patch 5 converts it to BTF; patch 6 adds the inline annotation
to pfunct output via BTF inline info; patch 7 creates an
inline site representation in the btf loader for use in patch
8 for the --inline_sites display; patch 9 tests inline display
via pfunct and patch 10 updates docs.

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

Changes since v4:

- Removed unneeded bool (Jiri, patch 1)
- Split adding parameters to inline expansion (patch 1) from
  recoding changes (Jiri, patch 2)
- Fixed issue with parameter indexing for inlne sites; use ordering
  from abstract origin (Jiri, patch 2)
- Fixed issues with PIE binaries; our section checking for instruction
  pointers did not work there.  Fix (patch 5) and update test to do
  PIE and non-PIE validation of inline encoding (patch 9)

[1] https://lore.kernel.org/bpf/20260924111428.75957-1-alan.maguire@oracle.com/
[2] https://lore.kernel.org/dwarves/20260925185200.1318067-1-alan.maguire@oracle.com/

Alan Maguire (10):
  dwarf_loader: Add parameter list to inline expansions
  dwarf_loader: Recode inline expansion parameter types
  dwarf_loader: Resolve inline expansion names during recoding
  dwarf_loader: Collect inline expansion location data
  pahole: Support inline BTF location encoding
  btf_loader: Add "inline" annotation for inlined functions
  btf_loader: Record inline sites in CU for BTF
  pfunct: Print inline site information
  tests: Validate inline BTF encoding
  man-pages: Document --inline_sites option

 btf_encoder.c       | 427 ++++++++++++++++++++++----
 btf_loader.c        |  96 +++++-
 dwarf_loader.c      | 581 +++++++++++++++++++++++++----------
 dwarves.c           |  35 +++
 dwarves.h           |  69 +++++
 man-pages/pfunct.1  |  74 ++++-
 pahole.c            |  12 +
 pfunct.c            | 718 ++++++++++++++++++++++++++++++++++++++++++--
 tests/btf_inline.sh | 155 ++++++++++
 9 files changed, 1917 insertions(+), 250 deletions(-)
 create mode 100755 tests/btf_inline.sh

-- 
2.43.5

