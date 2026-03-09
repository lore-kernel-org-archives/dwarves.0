Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6250E3D1CB0
	for <dwarves@vger.kernel.org>; Mon,  9 Mar 2026 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070349; cv=none; b=AxKxULzCL77WWVIL7Mjz9g2p+P0Dx6svwus4W3tRb6w1Yh21qNUxDQ3CBojTidKFH2BRLjVt7rFWqKN5J6duOso52TColn2aHxEHFF2/G7lkS7Ud+Qwz/f0QBmWUZY74lfRHsiThIYB7CPUGEiUqvpY6YSKsd73aV04K+D+GAuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070349; c=relaxed/simple;
	bh=7ZW3By0w3QyuzeVjBktUxP1vGE6Th7mzXbzHtvjDPRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uXt04Z1ABraPD/MTCjThy30ucD7f9S/PSO1OUxgoDprVHbVt5lpGKROIpGWbvwMX9Zn6xGLboVT+uJRHZg1X7XDcDL1or+owAyL2PGo4uakgLntMTFtZ6kTT6oZcqku49LKWGpXzWfLhJww3juElhMN+iMaRx3cuKx827yv5TAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 9859D24944292; Mon,  9 Mar 2026 08:32:15 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v2 0/9] pahole: Encode true signatures in kernel BTF
Date: Mon,  9 Mar 2026 08:32:15 -0700
Message-ID: <20260309153215.1917033-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Current vmlinux BTF encoding is based on the source level signatures.
But the compiler may do some optimization and changed the signature.
If the user tried with source level signature, their initial implementati=
on
may have wrong results and then the user need to check what is the
problem and work around it, e.g. through kprobe since kprobe does not
need vmlinux BTF.

Majority of changed signatures are due to dead argument elimination.
The following is a more complex one. The original source signature:
  typedef struct {
        union {
                void            *kernel;
                void __user     *user;
        };
        bool            is_kernel : 1;
  } sockptr_t;
  typedef sockptr_t bpfptr_t;
  static int map_create(union bpf_attr *attr, bpfptr_t uattr) { ... }
After compiler optimization, the signature becomes:
  static int map_create(union bpf_attr *attr, bool uattr__is_kernel) { ..=
. }
In the above, uattr__is_kernel corresponds to 'is_kernel' field in sockpt=
r_t.
This makes it easier for developers to understand what changed.

The new signature needs to properly follow ABI specification based on
locations. Otherwise, that signature should be discarded. For example,

    0x0242f1f7:   DW_TAG_subprogram
                    DW_AT_name      ("memblock_find_in_range")
                    DW_AT_calling_convention        (DW_CC_nocall)
                    DW_AT_type      (0x0242decc "phys_addr_t")
                    ...
    0x0242f22e:     DW_TAG_formal_parameter
                      DW_AT_location        (indexed (0x14a) loclist =3D =
0x005595bc:
                         [0xffffffff87a000f9, 0xffffffff87a00178): DW_OP_=
reg5 RDI
                         [0xffffffff87a00178, 0xffffffff87a001be): DW_OP_=
reg14 R14
                         [0xffffffff87a001be, 0xffffffff87a001c7): DW_OP_=
entry_value(DW_OP_reg5 RDI), DW_OP_stack_value
                         [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_=
reg14 R14)
                      DW_AT_name    ("start")
                      DW_AT_type    (0x0242decc "phys_addr_t")
                      ...
    0x0242f239:     DW_TAG_formal_parameter
                      DW_AT_location        (indexed (0x14b) loclist =3D =
0x005595e6:
                         [0xffffffff87a000f9, 0xffffffff87a00175): DW_OP_=
reg4 RSI
                         [0xffffffff87a00175, 0xffffffff87a001b8): DW_OP_=
reg3 RBX
                         [0xffffffff87a001b8, 0xffffffff87a001c7): DW_OP_=
entry_value(DW_OP_reg4 RSI), DW_OP_stack_value
                         [0xffffffff87a001c7, 0xffffffff87a00214): DW_OP_=
reg3 RBX)
                      DW_AT_name    ("end")
                      DW_AT_type    (0x0242decc "phys_addr_t")
                      ...
    0x0242f245:     DW_TAG_formal_parameter
                      DW_AT_location        (indexed (0x14c) loclist =3D =
0x00559610:
                         [0xffffffff87a001e3, 0xffffffff87a001ef): DW_OP_=
breg4 RSI+0)
                      DW_AT_name    ("size")
                      DW_AT_type    (0x0242decc "phys_addr_t")
                      ...
    0x0242f250:     DW_TAG_formal_parameter
                      DW_AT_const_value     (4096)
                      DW_AT_name    ("align")
                      DW_AT_type    (0x0242decc "phys_addr_t")
                      ...

The third argument should correspond to RDX for x86_64. But the location =
suggests that
the parameter value is stored in the address with 'RSI + 0'. It is not cl=
ear whether
the parameter value is stored in RDX or not. So we have to discard this f=
unciton in
vmlinux BTF to avoid incorrect true signatures.

For llvm, any function having
  DW_AT_calling_convention        (DW_CC_nocall)
in dwarf DW_TAG_subprogram will indicate that this function has signature=
 changed.
I did experiment with latest bpf-next. For x86_64, there are 69103 kernel=
 functions
and 875 kernel functions having signature changed. A series of patches ar=
e intended
to ensure true signatures are properly represented. Eventually, only 17 f=
unctions
cannot have true signatures due to locations.

For arm64, there are 863 kernel functions having signature changed, and
79 functions cannot have true signatures due to locations. I checked thos=
e
functions and look like llvm arm64 backend more relaxed to compute parame=
ter
values.

For the patch set, Patch 1 introduced usage of DW_AT_calling_convention, =
which
can precisely identify which function has signature changed. This can fil=
ter
majority of functions where their signature won't change.
Patches 2 to 7 tried to find functions with true signature.
Patch 8 enables to btf encoder to properly generate BTF.
Patch 9 includes a few tests.

Changelog:
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20260305225455.1151066-1-yonghong.s=
ong@linux.dev/
    - Added producer_clang guarding in btf_encoder. Otherwise, gcc kernel=
 build
      will crash pahole.
    - Fix an early return in parameter__reg() which didn't do pthread_mut=
ex_unlock()
      which caused the deadlock for arm64.
    - Add a few more places to guard with producer_clang and conf->true_s=
ignature
      to maintain the previous behavior if not clang or conf->true_signat=
ure is false.

Yonghong Song (9):
  dwarf_loader: Reduce parameter checking with clang
    DW_AT_calling_convention attr
  dwarf_loader: Handle signatures with dead arguments
  dwarf_loader: Refactor initial ret -1 to be macro PARM_DEFAULT_FAIL
  dwarf_laoder: Handle locations with DW_OP_fbreg
  dwarf_loader: Change exprlen checking condition in parameter__reg()
  dwarf_loader: Detect optimized parameters with locations having
    constant values
  dwarf_loader: Handle expression lists
  btf_encoder: Handle optimized parameter properly
  tests: Add a few clang true signature tests

 btf_encoder.c                                 |  13 +-
 dwarf_loader.c                                | 397 +++++++++++++++++-
 dwarves.h                                     |   3 +
 tests/true_signatures/clang_parm_aggregate.sh |  83 ++++
 tests/true_signatures/clang_parm_optimized.sh |  95 +++++
 .../clang_parm_optimized_stack.sh             |  95 +++++
 .../gcc_true_signatures.sh                    |   0
 7 files changed, 662 insertions(+), 24 deletions(-)
 create mode 100755 tests/true_signatures/clang_parm_aggregate.sh
 create mode 100755 tests/true_signatures/clang_parm_optimized.sh
 create mode 100755 tests/true_signatures/clang_parm_optimized_stack.sh
 rename tests/{ =3D> true_signatures}/gcc_true_signatures.sh (100%)

--=20
2.47.3

