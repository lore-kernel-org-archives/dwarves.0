Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0159314BF92
	for <dwarves@vger.kernel.org>; Tue, 28 Jul 2026 02:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785206256; cv=none; b=SQ6TQZt86vHDaq6unF4v3cTjiBBa9bNu3/EhPETT5DMaOwokCVsi6McP7CQNQl9ObaD121TdJpi3RGPCJeE/rP15kIVAZF83DScajQj6uNMhy/bUDmS/PPs28Xil9zRLf+7Ci1EDRPCEmXfXH3uzH8E5jDZMJq07DHMawpq0RAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785206256; c=relaxed/simple;
	bh=/n+zXG3/H2tPR/U4JMam8SFc7YhOaJWkwmOiRXV+yQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FedbMY5VSYPzZlh0tMGcJ8w7rheENSBQCS1fL7ziHrDMMZXx5t+2DgnEJJJ5VZybTq1iMCshwRufmcIHkBciCTJ6+A1NDXHk6r0+oV9pxtyq6Wg1+7BZh+GdgrgB3x06M7QMi990TvurEcAP7kxXmsh/1WLTHaRQQMc4gm7TE04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id C238820673397C; Mon, 27 Jul 2026 19:37:22 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves] btf_encoder: Ensure the first same-name function has a non-zero address
Date: Mon, 27 Jul 2026 19:37:22 -0700
Message-ID: <20260728023722.1978868-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When true_signature is enabled, the same function can appear as two kinds
of saved states: an inlined (abstract) instance that carries the original
source signature with no address, and an out-of-line instance that carrie=
s
the reconstructed true signature. saved_functions_combine() compares ever=
y
same-name state in a group against the first (anchor) one and, when their
prototypes differ, marks the function as having an inconsistent prototype=
.

Without this patch, the first same-name function may be an inlined instan=
ce
whose prototype is the original source signature and thus differs from th=
e
true signature. The two prototypes are then flagged as inconsistent and,
because --btf_features=3D+true_signature also enables the default
consistent_func feature (skip_encoding_btf_inconsistent_proto), which dro=
ps
functions flagged with an inconsistent prototype, the whole function is
dropped from BTF. This primarily affects clang: its signature-changed
functions keep their original name (no "." suffix), so state->sym is neve=
r
set and they bypass btf_encoder__add_true_signature(), falling through to
this canonical-state path.

With this patch, same-name functions are sorted so that, if any instance
has a non-zero address, such an instance becomes the first (anchor). That
addressed out-of-line instance is the one whose signature represents the
true signature, so the consistency check compares real instances against
each other and the function is retained in BTF with its true signature.

It is hard to create a test case where one function is inlined in one
place and not inlined in another place. So I built the latest bpf-next
kernel with
  make LLVM=3D1 -j
and then did
  with master branch:
    pahole -JV --btf_features=3D+true_signature vmlinux >& log.pahole.old
  with this patch on top of master branch:
    pahole -JV --btf_features=3D+true_signature vmlinux >& log.pahole.new
and then get warning messages:
  grep "skipping BTF encoding of function" log.pahole.old > log.old
  grep "skipping BTF encoding of function" log.pahole.new > log.new
and compare log.old and log.new
  diff log.old log.new > log.diff

The following are some results:
  --- log.old     2026-07-27 19:06:20.223881463 -0700
  +++ log.new     2026-07-27 19:06:28.874109831 -0700
  @@ -15,45 +15,28 @@
   ZSTD_getCParams_internal : skipping BTF encoding of function due to un=
expected register usage for parameter
   ZSTD_getParams : skipping BTF encoding of function due to unexpected r=
egister usage for parameter
   __ata_sff_port_intr : skipping BTF encoding of function due to unexpec=
ted register usage for parameter
  -__build_flow_key : skipping BTF encoding of function due to param coun=
t mismatch; 9 params !=3D 8 params
  -__build_flow_key : skipping BTF encoding of function due to inconsiste=
t prototype
   __collect_tables : skipping BTF encoding of function due to ambiguous =
address
   __fl_lookup : skipping BTF encoding of function due to return type mis=
match
   __fl_lookup : skipping BTF encoding of function due to ambiguous addre=
ss
   __in6_dev_get : skipping BTF encoding of function due to ambiguous add=
ress
   __in_dev_get_rcu : skipping BTF encoding of function due to ambiguous =
address
  -__instance_destroy : skipping BTF encoding of function due to param ty=
pe mismatch for param#1 inst !=3D inst
  -__instance_destroy : skipping BTF encoding of function due to inconsis=
tet prototype
   __ioremap_caller : skipping BTF encoding of function due to unexpected=
 register usage for parameter
  -__ipmr_get_table : skipping BTF encoding of function due to param coun=
t mismatch; 2 params !=3D 1 params
  -__ipmr_get_table : skipping BTF encoding of function due to inconsiste=
t prototype
   __ipv6_neigh_lookup_noref : skipping BTF encoding of function due to a=
mbiguous address
   __key_get : skipping BTF encoding of function due to ambiguous address
  -__kmem_cache_create : skipping BTF encoding of function due to param c=
ount mismatch; 5 params !=3D 2 params
  -__kmem_cache_create : skipping BTF encoding of function due to inconsi=
stet prototype
  -__kunmap_atomic : skipping BTF encoding of function due to param count=
 mismatch; 1 params !=3D 0 params
  -__kunmap_atomic : skipping BTF encoding of function due to inconsistet=
 prototype
   __map_range : skipping BTF encoding of function due to ambiguous addre=
ss
   __map_range_leaf : skipping BTF encoding of function due to ambiguous =
address
  -__map_single_page3 : skipping BTF encoding of function due to param co=
unt mismatch; 3 params !=3D 4 params
  -__map_single_page3 : skipping BTF encoding of function due to inconsis=
tet prototype
   __migrate_disable : skipping BTF encoding of function due to ambiguous=
 address
   __migrate_enable : skipping BTF encoding of function due to ambiguous =
address
   __mod_tree_insert : skipping BTF encoding of function due to unexpecte=
d register usage for parameter
   __mptcp_pm_send_ack : skipping BTF encoding of function due to unexpec=
ted register usage for parameter
  +__neigh_lookup : skipping BTF encoding of function due to param count =
mismatch; 3 params !=3D 2 params
   __neigh_lookup : skipping BTF encoding of function due to ambiguous ad=
dress
  -__netdev_walk_all_lower_dev : skipping BTF encoding of function due to=
 param count mismatch; 1 params !=3D 3 params
  -__netdev_walk_all_lower_dev : skipping BTF encoding of function due to=
 inconsistet prototype
   __pci_bus_set_current_state : skipping BTF encoding of function due to=
 unexpected register usage for parameter
   __pskb_trim : skipping BTF encoding of function due to ambiguous addre=
ss
   __release_region : skipping BTF encoding of function due to unexpected=
 register usage for parameter
   __remove_hrtimer : skipping BTF encoding of function due to unexpected=
 register usage for parameter
   __sk_dst_get : skipping BTF encoding of function due to ambiguous addr=
ess
   __skb_complete_tx_timestamp : skipping BTF encoding of function due to=
 unexpected register usage for parameter
  -__skb_gro_checksum_validate_complete : skipping BTF encoding of functi=
on due to param count mismatch; 2 params !=3D 1 params
  -__skb_gro_checksum_validate_complete : skipping BTF encoding of functi=
on due to inconsistet prototype
  -__skb_gro_checksum_validate_needed : skipping BTF encoding of function=
 due to param count mismatch; 3 params !=3D 1 params
  -__skb_gro_checksum_validate_needed : skipping BTF encoding of function=
 due to inconsistet prototype
   __task_rq_unlock : skipping BTF encoding of function due to unexpected=
 register usage for parameter
   __tracing_open : skipping BTF encoding of function due to unexpected r=
egister usage for parameter
   __tty_buffer_request_room : skipping BTF encoding of function due to u=
nexpected register usage for parameter
  @@ -63,44 +46,28 @@
  ...

With true signature enabled, this patch allows more BTF functions.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 btf_encoder.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 993a61c..fb2b5b0 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1519,8 +1519,20 @@ static int saved_functions_cmp(const void *_a, con=
st void *_b)
 {
 	const struct btf_encoder_func_state *a =3D _a;
 	const struct btf_encoder_func_state *b =3D _b;
-
-	return elf_function__name_cmp(a->elf, b->elf);
+	int ret;
+
+	ret =3D elf_function__name_cmp(a->elf, b->elf);
+	if (ret)
+		return ret;
+
+	/* For the same function, sort the out-of-line (real) instances, which
+	 * have a function address, before the inlined (abstract) ones, which d=
o
+	 * not. saved_functions_combine() compares every state in a group again=
st
+	 * the first (anchor) one, so keeping a real instance as the anchor
+	 * ensures real instances are still compared against each other for
+	 * prototype consistency.
+	 */
+	return (a->addr =3D=3D 0) - (b->addr =3D=3D 0);
 }
=20
 static int saved_functions_combine(struct btf_encoder *encoder,
@@ -1536,7 +1548,9 @@ static int saved_functions_combine(struct btf_encod=
er *encoder,
 	inconsistent =3D a->inconsistent_proto | b->inconsistent_proto;
 	uncertain_parm_loc =3D a->uncertain_parm_loc | b->uncertain_parm_loc;
 	reordered_parm =3D a->reordered_parm | b->reordered_parm;
-	if (!unexpected && !inconsistent && !reordered_parm && !funcs__match(en=
coder, a, b))
+
+	if ((!encoder->true_signature || !!a->addr =3D=3D !!b->addr) &&
+	    !unexpected && !inconsistent && !reordered_parm && !funcs__match(en=
coder, a, b))
 		inconsistent =3D 1;
 	a->unexpected_reg =3D b->unexpected_reg =3D unexpected;
 	a->inconsistent_proto =3D b->inconsistent_proto =3D inconsistent;
--=20
2.53.0-Meta

