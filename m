Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF3338D6B6
	for <dwarves@vger.kernel.org>; Thu, 26 Mar 2026 01:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774488727; cv=none; b=Q2VH/rNQH4L8WKRsPpSb5h2HgRYR+9jNut9Cw2s1KsMN4bAEfIdrXUXVaciTJGV69rS29Tgbz+jBZ1KHaOUf26s8rOyQmsMCRX5paPrKUWpncDWbWqq8XWdNhZEVCTpQCxeyOh+xfZBWCMyg1jOowjl1dVV2UD3zTysY9RG8yV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774488727; c=relaxed/simple;
	bh=atlUyN+UmIgGjvOaPTwXWR+g9SwXQsHPnpaXADaRudY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l811JJDxuJgi+AJO+zoyWnWiP4FC7Bg3mGyMXOKxvvAoqWoyOozTttotIWyOQZzo+CHNosG6k8q+ooprpFHf42a9qH/gENMMS7rCwbdMkPNUAhGxJbbFWBk+F+Lnj4EkbC+0vmO6t79mGiSSN27U5BLkyx323OsDFBSRASF0HyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 9EAB92E280F29; Wed, 25 Mar 2026 18:31:54 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v4 02/11] dwarf_loader: Prescan all parameters with expected registers
Date: Wed, 25 Mar 2026 18:31:54 -0700
Message-ID: <20260326013154.2903247-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260326013144.2901265-1-yonghong.song@linux.dev>
References: <20260326013144.2901265-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Find expected registers for each parameter so the current
parameter can check the next one to decide what type should be
used. In some cases, based on dwarf locations, a particular
parameter can be optimized. But the compiler may not really
optimize it. In such cases, the original parameter type should
be preserved in order to match the next parameter register.

The following are two examples, all from arm64.
Example 1:
  $ cat t.c
  struct t { long f1; long f2; };
  __attribute__((noinline)) static long foo(struct t a, struct t b, int i=
)
  {
          return a.f1 + b.f1 + b.f2;
  }
  struct t p1, p2;
  int i;
  int main()
  {
          return (int)foo(p1, p2, i);
  }
  $ clang -O2 -g t.c
  $ llvm-dwarfdump a.out
  ...
  0x00000041:   DW_TAG_subprogram
                  DW_AT_calling_convention        (DW_CC_nocall)
                  DW_AT_type      (0x0000008f "long")
                  ...

  0x00000051:     DW_TAG_formal_parameter
                    DW_AT_location        (indexed (0x0) loclist =3D 0x00=
000014:
                       [0x0000000000000740, 0x0000000000000748): DW_OP_re=
g0 W0, DW_OP_piece 0x8)
                    DW_AT_name    ("a")
                    DW_AT_type    (0x00000077 "t")
                    ...

  0x0000005a:     DW_TAG_formal_parameter
                    DW_AT_location        (indexed (0x1) loclist =3D 0x00=
00001c:
                       [0x0000000000000740, 0x000000000000074c): DW_OP_re=
g2 W2, DW_OP_piece 0x8, DW_OP_reg3 W3, DW_OP_piece 0x8)
                    DW_AT_name    ("b")
                    DW_AT_type    (0x00000077 "t")
                    ...

  0x00000063:     DW_TAG_formal_parameter
                    DW_AT_name    ("i")
                    DW_AT_type    (0x00000027 "int")
                    ...

  0x0000006b:     NULL

In the above, parameter 'a' actually only uses the first 8 byte value, so=
 looks like
it can be optimized. But since the second parameter starts with register =
W2, it makes
sense to keep the first parameter original type to ensure correct ABI.

Another example from vmlinux dwarf:

  0x0533fd03:   DW_TAG_subprogram
                  DW_AT_calling_convention        (DW_CC_nocall)
                  DW_AT_type      (0x05334dc7 "int")
                  ...

  0x0533fd15:     DW_TAG_formal_parameter
                    DW_AT_name    ("str")
                    DW_AT_type    (0x05335918 "char *")
                    ...

  0x0533fd1f:     DW_TAG_formal_parameter
                    DW_AT_location        (indexed (0x3b) loclist =3D 0x0=
0eb9d83:
                       [0xffff80008419f2e0, 0xffff80008419f324): DW_OP_re=
g1 W1
                       [0xffff80008419f324, 0xffff80008419f47c): DW_OP_re=
g19 W19
                       [0xffff80008419f47c, 0xffff80008419f494): DW_OP_en=
try_value(DW_OP_reg1 W1), DW_OP_stack_value
                       [0xffff80008419f494, 0xffff80008419f498): DW_OP_re=
g19 W19)
                    DW_AT_name    ("used")
                    DW_AT_type    (0x05334dc7 "int")
                    ...

In the above, since the second argument has register W1, it makes sense t=
o
keep the type of the first argument to ensure correct ABI.

Without prescan, the above two cases will be rejected for btf due to mism=
atched
expected registers.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index c569002..412a73e 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1190,10 +1190,40 @@ static ptrdiff_t __dwarf_getlocations(Dwarf_Attri=
bute *attr,
 	return ret;
 }
=20
+/* Max 20 register parameters, considering some parameters may be optimi=
zed out.  */
+#define	MAX_PRESCAN_PARAMS	20
+
 struct func_info {
 	bool signature_changed;
+	int nr_params;
+	int param_start_regs[MAX_PRESCAN_PARAMS];
 };
=20
+/* Get the first DW_OP_X (should be a register) from a parameter's DW_AT=
_location. */
+static int parameter__peek_first_reg(Dwarf_Die *die)
+{
+	Dwarf_Attribute attr;
+	if (dwarf_attr(die, DW_AT_location, &attr) =3D=3D NULL)
+		return -1;
+
+	Dwarf_Addr base, start, end;
+	Dwarf_Op *expr;
+	size_t exprlen;
+	ptrdiff_t offset =3D 0;
+
+	pthread_mutex_lock(&libdw__lock);
+	offset =3D __dwarf_getlocations(&attr, offset, &base, &start, &end, &ex=
pr, &exprlen);
+	pthread_mutex_unlock(&libdw__lock);
+
+	if (offset <=3D 0 || exprlen =3D=3D 0)
+		return -1;
+
+	if (expr[0].atom >=3D DW_OP_reg0 && expr[0].atom <=3D DW_OP_reg31)
+		return expr[0].atom;
+
+	return -1;
+}
+
 /* For DW_AT_location 'attr':
  * - if first location is DW_OP_regXX with expected number, return the r=
egister;
  *   otherwise save the register for later return
@@ -2425,6 +2455,43 @@ out_enomem:
 	return -ENOMEM;
 }
=20
+/* Pre-scan all formal parameters to collect their starting registers.
+ * This allows look-ahead when processing parameters sequentially, so th=
at
+ * a parameter can check the next parameter's register to determine if t=
he
+ * ABI register layout is preserved despite partial optimization.
+ * For example, for a function like below:
+ *  struct t { long f1; long f2; };
+ *  __attribute__((noinline)) static long foo(struct t a, struct t b)
+ *  {
+ *      return a.f1 + b.f1 + b.f2;
+ *  }
+ * If dwarf has parameter 'a' at aarch64 register W0, and 'b' at registe=
r W2,
+ * even compiler could optimize 'a' to 'a.f1'. To conform to ABI, the
+ * parameter 'a' will keep 'struct t' type.
+ */
+static void func_info__prescan_params(struct func_info *info, Dwarf_Die =
*die)
+{
+	Dwarf_Die child;
+	int idx =3D 0;
+
+	if (!info->signature_changed)
+		return;
+
+	if (!dwarf_haschildren(die) || dwarf_child(die, &child) !=3D 0)
+		return;
+
+	do {
+		if (dwarf_tag(&child) !=3D DW_TAG_formal_parameter)
+			continue;
+		if (idx >=3D MAX_PRESCAN_PARAMS)
+			break;
+		info->param_start_regs[idx] =3D parameter__peek_first_reg(&child);
+		idx++;
+	} while (dwarf_siblingof(&child, &child) =3D=3D 0);
+
+	info->nr_params =3D idx;
+}
+
 static struct tag *die__create_new_function(Dwarf_Die *die, struct cu *c=
u, struct conf_load *conf)
 {
 	struct function *function =3D function__new(die, cu, conf);
@@ -2432,6 +2499,7 @@ static struct tag *die__create_new_function(Dwarf_D=
ie *die, struct cu *cu, struc
=20
 	if (function !=3D NULL) {
 		info.signature_changed =3D function__signature_changed(function, die);
+		func_info__prescan_params(&info, die);
=20
 		if (die__process_function(die, &function->proto, &function->lexblock, =
cu, conf, &info) !=3D 0) {
 			function__delete(function, cu);
--=20
2.52.0

