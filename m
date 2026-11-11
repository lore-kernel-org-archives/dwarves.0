Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=69.171.232.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435904;
	b=Lf27yc3XSCpFYgBdBk6y85FB2ekb3/RrG5tpR3exa1PCScwvF7UK7vxd+gLhEvUrhsSd
	 +Q1QO7T/bM/vTFmWf++AOSwFRKR0Ci2cuOjAWaEjFrpBM62vzKOdeshrp2DA5lV0pqLl8
	 Fnz7y2l11qs/oUxEMPNI1mYqcU13RuaXAPNiJhT4OMICxI5WbKNl8LjfInYpB0wMkbq/m
	 napGQXrd2SqUn8Q8VjdvzGeHoLNaB58Ad1BnjpPiAXw1tz+IxNtatRjYAZBk8pFPNZkd6
	 RbwQYZvRXc520Xn3TG583I1FX4gsQrAgxSk33+zyzi+zJe0ufN+/OCpWhmM/q7UBbow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435904;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EYAzxpAXkSep1aSgFztTSqWSbJMTFI9JEhF20reLYNs=;
	b=U5phPVT2IKfpkHY/tcnmmZqAFjkh0VGDkVqrSv6kOv0koVHhvzwl3zqPCzNqTfZtpEpR
	 aCgW+t2gHDof9tGfkIp/VaD9bB+1OYjC7YbmNAxehCDlQNeGnA8wfvMhYRsHzVN3DB7/z
	 6tNKVtm4g7+Gzs21+BUprbbqs3Ol8+xLvBTHr+f7CBCFb6U+UEA/DY8fiYrcWk0VlmWUQ
	 Ieawd2eZ23QWl/4p/KoaRN2Ll4X8OEOk4MPu3ulvqC4p8kkVZiUFJBt7t3DvAK57Ie3Q3
	 X5MtNpok0zxAYx/6y3/Z7OqndVjV/5pGZ6ELpW/2j0wGyIuqiicDGOwXani61tZARyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.dev;
	spf=fail smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=69.171.232.180
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF283606A327
	for <dwarves@vger.kernel.org>; Wed, 11 Nov 2026 22:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF283606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm50310.atn0.facebook.com (Postfix, from userid 128203)
	id 2B3835824EE2C; Wed, 11 Nov 2026 14:24:47 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH dwarves] btf_encoder: Keep the source prototype of kfuncs
Date: Wed, 11 Nov 2026 14:24:47 -0800
Message-ID: <20261111222447.322978-1-yonghong.song@linux.dev>
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

For kfuncs, clear the location derived flags when saving the state,
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
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 btf_encoder.c | 49 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 05ffe82..4269467 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1421,16 +1421,30 @@ static int32_t btf_encoder__save_func(struct btf_=
encoder *encoder, struct functi
 			}
 		}
 	}
+
+	/*
+	 * A kfunc keeps the ABI of its C prototype, so reset the DWARF
+	 * location based flags: otherwise the kfunc may be treated as
+	 * optimized and skipped, or lose parameters in BTF.
+	 */
+	if (!loc && is_kfunc_state(state)) {
+		state->unexpected_reg =3D 0;
+		state->optimized_parms =3D 0;
+		state->uncertain_parm_loc =3D 0;
+		state->reordered_parm =3D 0;
+		state->signature_changed =3D 0;
+	}
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
@@ -1797,17 +1811,20 @@ static int btf_encoder__add_saved_funcs(struct bt=
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
@@ -3056,10 +3073,14 @@ struct btf_encoder *btf_encoder__new(struct cu *c=
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

