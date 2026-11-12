Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=69.171.232.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794499904;
	b=0NXsPP87xc3MymLkSEsMS35WJJCd5jgq+Egco/9QEzilirGhtSGV/teUWmBm5ErvxEWz
	 2Quj3o572UJjYTJwLrHCHKGj/2T3ZRVhf5O7zGtay0+QCepfkSiGolhN0H0P3dM/yHGwL
	 AAEdTOJgCwqsz8KEIzpUJhoi+s2/1G9N806U8l+QMmtBBBNcNPD5zZ3ZANq47fLa22Ove
	 4OlvEz3el/OBugzbdpVzFPXiyVwBTZb12FbWu3jbOLKGi7yvX2EdHObOHwTE2gfnTERzX
	 wB+w7J8/LdBf1azxKhpngrSDLPwFyXlu36tPMipZnC/TslhlI0Octn31svvfAyqeDlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499904;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YveoyabFfEkpknWUccD4GnejroQxoMPfnh9Wqt0wcEk=;
	b=XdUgL2B7dglTpjWwt/+Ie5mTfhiO4MjaV7oo4OurLQfZEm4gkv7bnTSu9zeA8RiMSOkR
	 AOKbp6+fV3hpwkB/pfmaJOhgAlkaIfPDLeFnPBcYeUOeN1Ei97zkmt2rikudp4p4m+ToB
	 Tovi7B/XlcK9dZlMUhm53keElxWXUyI41OmI3iIyMeHX+t9eSHsZSP9Ym9yZs0hjfNjkW
	 MPl0Af1VoXTJ/DWdm309MOrwDEr7WFSPiAmw3nfud56VrIPb2dBUy9kdPyd9yeg1UAcwc
	 Q031QLkdi0dk9Pps8T7NKCl69CnZlCXWECwJJMWjSovozE8lK/q1AV4IPVtoA/26rhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.dev;
	spf=fail smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=69.171.232.181
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E01606A327
	for <dwarves@vger.kernel.org>; Thu, 12 Nov 2026 16:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02E01606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm50310.atn0.facebook.com (Postfix, from userid 128203)
	id EAEBF583745DF; Thu, 12 Nov 2026 08:11:29 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH dwarves v2] btf_encoder: Keep the source prototype of kfuncs
Date: Thu, 12 Nov 2026 08:11:29 -0800
Message-ID: <20261112161129.1903805-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Post: <mailto:dwarves@vger.kernel.org>
List-Help: <mailto:dwarves+help@vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
List-Owner: <mailto:dwarves+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The location based checks can drop kfuncs from BTF even though their ABI
did not change. With the arm64 KCSAN setup in the report, resolve_btfids
fails with:

  WARN: resolve_btfids: no BTF func for kfunc bpf_tcp_ops_set_rcvlowat in=
 bpf_tcp_ops_set_rcvlowat_kfunc_set
  WARN: resolve_btfids: unresolved symbol bpf_tcp_ops_set_rcvlowat

The location list of 'rcvlowat' starts after the function entry, in a
callee-saved register, so the function is marked unexpected_reg and
skipped. scx_bpf_tid_to_task() hits the same skip through a
different DWARF pattern.

Kfuncs are defined with __bpf_kfunc ("__used __retain __noclone
noinline"), so the compiler keeps the calling convention of the C
prototype. Odd parameter locations of a kfunc are debug info artifacts,
not ABI changes.

For kfuncs, do not set the flags when saving the state,
keep all source parameters, and skip the location based checks, also in
btf_encoder__add_saved_funcs() where saved_functions_combine() can merge
the flags back in. The inconsistent prototype and ambiguous address
checks still apply.

Kfuncs were only collected with decl_tag_kfuncs, which the kernel no
longer passes since commit 692393104909 ("resolve_btfids: Emit bpf_kfunc
and bpf_fastcall decl tags"). Collect them whenever BTF is encoded; the
decl tags are still only emitted with decl_tag_kfuncs.

With this change, bpf_tcp_ops_set_rcvlowat() and scx_bpf_tid_to_task()
are encoded again, and no other function in vmlinux BTF changes.

Reported-by: Breno Leitao <leitao@debian.org>
Closes: https://lore.kernel.org/all/au27Y9m78_3EH2v1@gmail.com/
Tested-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 btf_encoder.c | 71 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 27 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 05ffe82..8537628 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1405,32 +1405,42 @@ static int32_t btf_encoder__save_func(struct btf_=
encoder *encoder, struct functi
 			break;
 		}
 	}
-	state->inconsistent_proto =3D ftype->inconsistent_proto;
-	state->unexpected_reg =3D ftype->unexpected_reg;
-	state->optimized_parms =3D ftype->optimized_parms;
-	state->uncertain_parm_loc =3D ftype->uncertain_parm_loc;
-	state->reordered_parm =3D ftype->reordered_parm;
-	state->signature_changed =3D ftype->signature_changed;
-	if (state->addr && func) {
-		for (int i =3D 0; i < func->sym_cnt; i++) {
-			if (state->addr !=3D func->syms[i].addr)
-				continue;
-			if (str_contains_optimized_fn_suffix(func->syms[i].name)) {
-				state->optimized_symbol =3D 1;
-				break;
+	/*
+	 * A kfunc keeps the ABI of its C prototype, so avoid setting
+	 * state flags, otherwise the kfunc may be treated as
+	 * optimized and skipped, or lose parameters in BTF.  For other
+	 * cases, ensure the optimizations/uncertainties are reflected
+	 * in state flags.
+	 */
+	if (loc || !is_kfunc_state(state)) {
+		state->inconsistent_proto =3D ftype->inconsistent_proto;
+		state->unexpected_reg =3D ftype->unexpected_reg;
+		state->optimized_parms =3D ftype->optimized_parms;
+		state->uncertain_parm_loc =3D ftype->uncertain_parm_loc;
+		state->reordered_parm =3D ftype->reordered_parm;
+		state->signature_changed =3D ftype->signature_changed;
+		if (state->addr && func) {
+			for (int i =3D 0; i < func->sym_cnt; i++) {
+				if (state->addr !=3D func->syms[i].addr)
+					continue;
+				if (str_contains_optimized_fn_suffix(func->syms[i].name)) {
+					state->optimized_symbol =3D 1;
+					break;
+				}
 			}
 		}
 	}
+
 	ftype__for_each_parameter(ftype, param) {
 		const char *name;
 		char *final_name =3D NULL;
=20
 		/* No location info/optimized + reordered means optimized out. */
-		if (!loc && ftype->reordered_parm && (!param->has_loc || param->optimi=
zed)) {
+		if (!loc && state->reordered_parm && (!param->has_loc || param->optimi=
zed)) {
 			state->nr_parms--;
 			continue;
 		}
-		if (!loc && encoder->true_signature && ftype->signature_changed &&
+		if (!loc && encoder->true_signature && state->signature_changed &&
 		    param->optimized) {
 			state->nr_parms--;
 			continue;
@@ -1797,17 +1807,20 @@ static int btf_encoder__add_saved_funcs(struct bt=
f_encoder *encoder, bool skip_e
 		 * signature; true_signature can rewrite those signatures.
 		 * Also exclude functions with unexpected register use, multiple
 		 * inconsistent prototypes or uncertain parameter locations.
+		 * The location based checks do not apply to kfuncs.
 		 */
-		if (state->unexpected_reg)
-			skip_reason =3D "unexpected register usage for parameter\n";
+		if (!is_kfunc_state(state)) {
+			if (state->unexpected_reg)
+				skip_reason =3D "unexpected register usage for parameter\n";
+			if (state->uncertain_parm_loc)
+				skip_reason =3D "uncertain parameter location\n";
+			if (state->reordered_parm)
+				skip_reason =3D "reordered parameters\n";
+			if (btf_encoder_func_state__skip_optimized_parms(encoder, canonical_s=
tate))
+				skip_reason =3D "optimized parameters\n";
+		}
 		if (skip_encoding_inconsistent_proto && state->inconsistent_proto)
 			skip_reason =3D "inconsistet prototype\n";
-		if (state->uncertain_parm_loc)
-			skip_reason =3D "uncertain parameter location\n";
-		if (state->reordered_parm)
-			skip_reason =3D "reordered parameters\n";
-		if (btf_encoder_func_state__skip_optimized_parms(encoder, canonical_st=
ate))
-			skip_reason =3D "optimized parameters\n";
 		if (state->elf->ambiguous_addr)
 			skip_reason =3D "ambiguous address\n";
=20
@@ -3056,10 +3069,14 @@ struct btf_encoder *btf_encoder__new(struct cu *c=
u, const char *detached_filenam
 		if (!found_percpu && encoder->verbose)
 			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename=
, PERCPU_SECTION);
=20
-		if (encoder->tag_kfuncs) {
-			if (btf_encoder__collect_kfuncs(encoder))
-				goto out_delete;
-		}
+		/*
+		 * Mark kfuncs before any function state is saved, so
+		 * btf_encoder__save_func() keeps their source prototypes.
+		 * Needed even without decl_tag_kfuncs, which only controls
+		 * the decl tags.
+		 */
+		if (btf_encoder__collect_kfuncs(encoder))
+			goto out_delete;
=20
 		if (encoder->verbose)
 			printf("File %s:\n", cu->filename);
--=20
2.53.0-Meta

