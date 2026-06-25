Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643AD3A7F60
	for <dwarves@vger.kernel.org>; Thu, 25 Jun 2026 02:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782352923; cv=none; b=GuLC5EZ7N2Fd2kc0yyVUX0wu3zcwGsh0Hn4gqWsBdmATI2Df6GFpSQWlrCP925WZnpIU2t5zuMVYe0TdIel2XioYhS4hcgtGBKIIvhGAdSLbzZVgFRPCsjhrljd8JgL+Vd5AKzPT2p1fRbYO5vDbk6vPSDR93PH5rbE+qyewd00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782352923; c=relaxed/simple;
	bh=4e+WFZ8VxusjHb/QlOBOnTDVeGPahs7a5hYCMLTQdTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G+y7nIuEXW2BDrB0i79HGXLAhqVXcrdCeTa+0S5wD0Rm1lWmEmqUi12rF9JRPD+heTcPhXQHkdkU0kQbubkk2BYlFQRz1rnkGHrNAEJh8QTokU2CfdbsV19N3C6TxYClZ3QAUmeGS6AJ1Q7qV6qeRyXkc6LEGSHzHi78wYPQ1qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 30DE219D954C04; Wed, 24 Jun 2026 19:01:48 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v10 0/5] pahole: Encode true signatures in kernel BTF
Date: Wed, 24 Jun 2026 19:01:48 -0700
Message-ID: <20260625020148.1883082-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
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
But for non DW_CC_nocall functions, it is possible that true signature st=
ill not
available due to locations. So every functions will be checked.

I did experiment with latest bpf-next. For x86_64, there are 69103 kernel=
 functions
and 875 kernel functions having signature changed. A series of patches ar=
e intended
to ensure true signatures are properly represented. Eventually, only 20 f=
unctions
cannot have true signatures due to locations.

For arm64, there are 863 kernel functions having signature changed, and
108 functions cannot have true signatures due to locations. I checked tho=
se
functions and look like llvm arm64 backend more relaxed to compute parame=
ter
values.

For full testing, I enabled true signature support in kernel scripts/Make=
file.btf like below:
  -pahole-flags-$(call test-ge, $(pahole-ver), 131) +=3D --btf_features=3D=
attributes
  +pahole-flags-$(call test-ge, $(pahole-ver), 131) +=3D --btf_features=3D=
attributes --btf_features=3D+true_signature

See individual patches for details.

Changelog:
  v9 -> v10:
    - v9: https://lore.kernel.org/bpf/20260624052553.3139112-1-yonghong.s=
ong@linux.dev/
    - Remove patch 'btf_encoder: Avoid comparing inlined and out-of-line =
function prototypes'
      as it caused btf_functions.sh failure.
  v8 -> v9:
    - v8: https://lore.kernel.org/bpf/20260623222850.3290612-1-yonghong.s=
ong@linux.dev/
    - v8 made a mistake where all functions go through main loop in
      function__analyze_parameter_locations(). This is not correct as it =
includes functions
      whose signature is not changed. See function
      function__match_clang_parameter_locations().
    - Add a change in btf_encoder to avoid comparing inlined and out-of-l=
ine function prototypes.
      This allows some functions to be in btf.
    - Add one more test, clang_parm_optimized_stack_2, where a global fun=
ction, with
      many unused parameters, gets properly handling in location checking=
.
  v7 -> v8:
    - v7: https://lore.kernel.org/bpf/20260623040704.2732530-1-yonghong.s=
ong@linux.dev/
    - Both Check and Analyze phases go through all functions.
    - Require true_signature in btf_encoder to have name like <paramName>=
__<field>.
    - Remove signature_changed (from nocall). It is possible that functio=
n signatures
      are not changed but the location reigsters do not match.
  v6 -> v7:
    - v6: https://lore.kernel.org/bpf/20260618011358.632394-1-yonghong.so=
ng@linux.dev/
    - Ensure that 'collect' and 'analyze' have the same location checking=
.
    - In 'analyze' stage, undo true_sig_member_name if the next expected =
register
      matches the previous source type although the previous parameter ma=
y
      only use half of the value.
  v5 -> v6:
    - v5: https://lore.kernel.org/bpf/20260523165712.1225231-1-yonghong.s=
ong@linux.dev/
    - The previous change relies on parameter__new() to collect and analy=
ze each
      parameter to decide true signatures. The new one separates collecti=
ng and
      analyzing phase from Alan. This two-phase makes logic easy to under=
stand.
    - In btf_encoder.c, remove usage of skip_idx to simplify the code.
  v4 -> v5:
    - v4: https://lore.kernel.org/bpf/20260326013144.2901265-1-yonghong.s=
ong@linux.dev/
    - Check info.signature_changed only under clang.
    - Fix an uninitialized varable issue (var reg_dix) for gcc.
  v3 -> v4:
    - v3: https://lore.kernel.org/bpf/20260320190917.1970524-1-yonghong.s=
ong@linux.dev/
    - Add simple prescan of parameter registers in order to get true sign=
atures
      for those functions where optimization could happen but compiler di=
dn't do it.
    - Do not create a new name (e.g. "uattr__is_kernel") with malloc at p=
arameter_reg()
      stage. Instead remember both "uattr" and "is_kernel" and later gene=
rate the
      name "uattr_is_kernel" in btf encoder.
    - Add comments to explain how to handle parameters which may take two=
 registers.
    - Fix some test failures on aarch64.
  v2 -> v3:
    - v2: https://lore.kernel.org/bpf/20260309153215.1917033-1-yonghong.s=
ong@linux.dev/
    - Change tests by using newly added test_lib.sh.
    - Simplify to get bool variable producer_clang.
    - Try to avoid producer_clang appearance in dwarf_loader.c in order t=
o avoid
      clear separation between clang and gcc.
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

Yonghong Song (5):
  dwarf_loader: Detect aggregate ABI register usage and signature
    changes
  dwarf_loader: Collect per-parameter information
  dwarf_loader: Analyze per-parameter information for true signatures
  btf_encoder: Emit true function signatures
  tests: Add BTF true_signature encoding tests

 btf_encoder.c                         |  26 +-
 dwarf_loader.c                        | 603 +++++++++++++++++++++++---
 dwarves.h                             |  14 +
 tests/clang_parm_aggregate_1.sh       |  85 ++++
 tests/clang_parm_aggregate_2.sh       |  88 ++++
 tests/clang_parm_memory.sh            |  77 ++++
 tests/clang_parm_optimized.sh         |  63 +++
 tests/clang_parm_optimized_stack_1.sh |  63 +++
 tests/clang_parm_optimized_stack_2.sh |  63 +++
 9 files changed, 1017 insertions(+), 65 deletions(-)
 create mode 100755 tests/clang_parm_aggregate_1.sh
 create mode 100755 tests/clang_parm_aggregate_2.sh
 create mode 100755 tests/clang_parm_memory.sh
 create mode 100755 tests/clang_parm_optimized.sh
 create mode 100755 tests/clang_parm_optimized_stack_1.sh
 create mode 100755 tests/clang_parm_optimized_stack_2.sh

--=20
2.53.0-Meta

