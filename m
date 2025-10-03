Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1324724468D
	for <dwarves@vger.kernel.org>; Fri,  3 Oct 2025 17:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759512996; cv=none; b=p8by81aVQQoLHVKyGZPrqz0j/k3kifLuDtjmtrXk2XqqFXRc3jwCD7ZG0FFMWDp2QK5IDba29asCbD4+P448GE57lSxtuMfFB1tv6RW1eS8zYL9dTfr6tcuB6lauc3/ZMEDnAxyWDzn8bT8XHN7L7m+CJYwFuYhEqBscNey4YUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759512996; c=relaxed/simple;
	bh=a/Mu5+DheXOpB8i1cu1MymCnwGhkdja/MOucTZPGgJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jiKY+Dkb8CXIfstesG9y0nfOnVnQ9l0MD0XYCkDH6ufjlZrgX5TrRR1tuB+MWFX1yCrPEp3Zy528lWqsHxTiwxizFSxNSCgVI0toddwd8/p0sMiSvTay6jnv2YgPvFWLTbFuafNxLKhDe0G6XLUZN5+yTvlZmAbjckfNswq0DnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id B99761180DD6F; Fri,  3 Oct 2025 10:36:20 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com
Subject: [PATCH dwarves] pahole: Avoid generating artificial inlined functions for BTF
Date: Fri,  3 Oct 2025 10:36:20 -0700
Message-ID: <20251003173620.2892942-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In llvm pull request [1], the dwarf is changed to accommodate functions
whose signatures are different from source level although they have
the same name. Other non-source functions are also included in dwarf.

The following is an example:

The source:
=3D=3D=3D=3D
  $ cat test.c
  struct t { int a; };
  char *tar(struct t *a, struct t *d);
  __attribute__((noinline)) static char * foo(struct t *a, struct t *d, i=
nt b)
  {
    return tar(a, d);
  }
  char *bar(struct t *a, struct t *d)
  {
    return foo(a, d, 1);
  }
=3D=3D=3D=3D

Part of generated dwarf:
=3D=3D=3D=3D
0x0000005c:   DW_TAG_subprogram
                DW_AT_low_pc    (0x0000000000000010)
                DW_AT_high_pc   (0x0000000000000015)
                DW_AT_frame_base        (DW_OP_reg7 RSP)
                DW_AT_linkage_name      ("foo")
                DW_AT_name      ("foo")
                DW_AT_decl_file ("/home/yhs/tests/sig-change/deadarg/test=
.c")
                DW_AT_decl_line (3)
                DW_AT_type      (0x000000bb "char *")
                DW_AT_artificial        (true)
                DW_AT_external  (true)

0x0000006c:     DW_TAG_formal_parameter
                  DW_AT_location        (DW_OP_reg5 RDI)
                  DW_AT_decl_file       ("/home/yhs/tests/sig-change/dead=
arg/test.c")
                  DW_AT_decl_line       (3)
                  DW_AT_type    (0x000000c4 "t *")

0x00000075:     DW_TAG_formal_parameter
                  DW_AT_location        (DW_OP_reg4 RSI)
                  DW_AT_decl_file       ("/home/yhs/tests/sig-change/dead=
arg/test.c")
                  DW_AT_decl_line       (3)
                  DW_AT_type    (0x000000c4 "t *")

0x0000007e:     DW_TAG_inlined_subroutine
                  DW_AT_abstract_origin (0x0000009a "foo")
                  DW_AT_low_pc  (0x0000000000000010)
                  DW_AT_high_pc (0x0000000000000015)
                  DW_AT_call_file       ("/home/yhs/tests/sig-change/dead=
arg/test.c")
                  DW_AT_call_line       (0)

0x0000008a:       DW_TAG_formal_parameter
                    DW_AT_location      (DW_OP_reg5 RDI)
                    DW_AT_abstract_origin       (0x000000a2 "a")

0x00000091:       DW_TAG_formal_parameter
                    DW_AT_location      (DW_OP_reg4 RSI)
                    DW_AT_abstract_origin       (0x000000aa "d")

0x00000098:       NULL

0x00000099:     NULL

0x0000009a:   DW_TAG_subprogram
                DW_AT_name      ("foo")
                DW_AT_decl_file ("/home/yhs/tests/sig-change/deadarg/test=
.c")
                DW_AT_decl_line (3)
                DW_AT_prototyped        (true)
                DW_AT_type      (0x000000bb "char *")
                DW_AT_inline    (DW_INL_inlined)

0x000000a2:     DW_TAG_formal_parameter
                  DW_AT_name    ("a")
                  DW_AT_decl_file       ("/home/yhs/tests/sig-change/dead=
arg/test.c")
                  DW_AT_decl_line       (3)
                  DW_AT_type    (0x000000c4 "t *")

0x000000aa:     DW_TAG_formal_parameter
                  DW_AT_name    ("d")
                  DW_AT_decl_file       ("/home/yhs/tests/sig-change/dead=
arg/test.c")
                  DW_AT_decl_line       (3)
                  DW_AT_type    (0x000000c4 "t *")

0x000000b2:     DW_TAG_formal_parameter
                  DW_AT_name    ("b")
                  DW_AT_decl_file       ("/home/yhs/tests/sig-change/dead=
arg/test.c")
                  DW_AT_decl_line       (3)
                  DW_AT_type    (0x000000d8 "int")

0x000000ba:     NULL
=3D=3D=3D=3D

In the above, there are two subprograms with the same name 'foo'.
Currently btf encoder will consider both functions as ELF functions.
Since two subprograms have different signature, the funciton will
be ignored.

But actually, one of function 'foo' is marked as DW_INL_inlined which mea=
ns
we should not treat it as an elf funciton. The patch fixed this issue
by filtering subprograms if the corresponding function__inlined() is true=
.

This will fix the issue for [1]. But it should work fine without [1] too.

  [1] https://github.com/llvm/llvm-project/pull/157349
---
 btf_encoder.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index 0bc2334..18f0162 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2652,6 +2652,8 @@ int btf_encoder__encode_cu(struct btf_encoder *enco=
der, struct cu *cu, struct co
 		 */
 		if (fn->declaration)
 			continue;
+		if (function__inlined(fn))
+			continue;
 		if (!ftype__has_arg_names(&fn->proto))
 			continue;
 		if (funcs->cnt) {
--=20
2.47.3

