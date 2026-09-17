Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC3C4F392F
	for <dwarves@vger.kernel.org>; Thu, 17 Sep 2026 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663254; cv=none; b=qmq2ReyE6eDTV1K54tU7uBl+L4qSDk8i9Yf1QPdpYNWWcvREHxaXkq4jP1M93Us/CqpLOMpRISRfXW7PC28yH1fYP+w17knXQRtQKEIl9aybWGGl/QJyWb+Kq7JVoycLyA+P9Fzg4FTmRk02R8gBpEilUYKhY9tzkFueVIpYIF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663254; c=relaxed/simple;
	bh=1t+0EQDr/ovaisZixl4OHlAjmFYEcptzAEPYGZg9pjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bF+H4b+vn3l2ANBULu2BmrBLfs2wKQDppH4qMl1DfVMD2U/MdpH4oWXB2xcwjuy4ksw6WmLUvFRpX3rjFJ5qNihxk0v52TA4Y4jYSv4oCzVNVD68w6rDWN9ANnavz+ZK32B9LdP8k3xm87Vnr0Z4p4daYf+t3qpqsAFuhW++ajU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 7A44B2B6094804; Thu, 17 Sep 2026 09:40:38 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v2 0/3] pahole: Fix arm64 argument register allocation
Date: Thu, 17 Sep 2026 09:40:38 -0700
Message-ID: <20260917164038.1576763-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The arm64 ABI starts an argument twice the register size on an even-numbe=
red
argument register, leaving a hole when the next free register is an odd o=
ne:

  u64 f(u64 a, __int128 v, u64 b);

passes a in x0, v in x2:x3 -- skipping x1 -- and b in x4.  pahole did not
model the hole, so b looked like it was in an unexpected register and the
whole function was dropped from BTF.  Patch 1 skips the register the ABI
leaves behind, patch 3 adds a test for it.  Only arm64 has this rule; the
other architectures are unaffected.

Patch 2 is a small follow-up.  Floating point and vector arguments are
allocated from a register bank of their own -- v0-v7 on arm64, xmm0-xmm7 =
on
x86-64 -- so a wide one never occupies a general purpose register pair an=
d
must not trigger the even-register rule either.  It does not change the B=
TF
emitted today, because such an argument still advances the general purpos=
e
register index by its own size, so it comes with no test of its own; it
keeps the alignment rule scoped to the bank it applies to.

Changelog:
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20260911040955.339939-1-yonghong.so=
ng@linux.dev/
    - add commit "Do not align the argument register index for FP argumen=
ts".

Yonghong Song (3):
  dwarf_loader: Skip the argument register the arm64 ABI leaves as a
    hole
  dwarf_loader: Do not align the argument register index for FP
    arguments
  tests: tests: Add test for 16-byte aligned arguments on arm64

 dwarf_loader.c              | 72 ++++++++++++++++++++++++++++++++--
 dwarves.h                   | 11 ++++++
 tests/clang_parm_align16.sh | 77 +++++++++++++++++++++++++++++++++++++
 tests/test_lib.sh           |  3 +-
 4 files changed, 158 insertions(+), 5 deletions(-)
 create mode 100755 tests/clang_parm_align16.sh

--=20
2.53.0-Meta

