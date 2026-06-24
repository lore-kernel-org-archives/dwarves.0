Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DDB31F989
	for <dwarves@vger.kernel.org>; Wed, 24 Jun 2026 05:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782278788; cv=none; b=hIw6mRe5YxRPav0UwG7gs/P9lGBzMbFE4urAU2PlOpgQb2xPrrc+B/2FE1a+A+VtnQQ8LCgKg8An04P7CthPv1w3aq6PhSt1O3/a2eezhnoy5OA+oDFQP9JfrO6HU6cpmXMu1pW05JLtOo2McqHVDVRlui/zt1qEbJS2aREtnTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782278788; c=relaxed/simple;
	bh=JcH/Be17KhP1zQCWiwuhH9CPN5oHN7pp2fKKiT1l0qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VaK6kp4+EgwoebHxhEe9U1YlDrdG4oAI+JH0O/OxuVGh5N3YcbTwl/I2cog4JU58TkuR3IUpquk1+Yel8Al0VYN/gfg2CD72fXNXa+STK4Cw7QZgMtXDf3epXRYPTafJR9pkZSAtOn2rpD7lVzmOSA1fqembU2QZ1jE1gQSko2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 39D2E198D40D44; Tue, 23 Jun 2026 22:26:19 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v9 5/6] btf_encoder: Avoid comparing inlined and out-of-line function prototypes
Date: Tue, 23 Jun 2026 22:26:19 -0700
Message-ID: <20260624052619.3143003-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624052553.3139112-1-yonghong.song@linux.dev>
References: <20260624052553.3139112-1-yonghong.song@linux.dev>
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
the reconstructed true signature. These two legitimately differ, so
comparing them in saved_functions_combine() wrongly flags the function as
having an inconsistent prototype and drops it from BTF.

Record which kind a state is by adding an 'inlined' bit to
btf_encoder_func_state, set from function__inlined() in
btf_encoder__save_func().

Use it in two places:
 - saved_functions_cmp() breaks ties by 'inlined' so that out-of-line
   (real) instances sort before inlined (abstract) ones. Since
   saved_functions_combine() compares every state in a group against the
   first (anchor) state, keeping a real instance as the anchor ensures re=
al
   instances are still compared against each other for prototype
   consistency.
 - saved_functions_combine() only runs the prototype-consistency check wh=
en
   both states are of the same kind (a->inlined =3D=3D b->inlined). The t=
rue
   signature always comes from the out-of-line instance, which is the one
   picked by btf_encoder__select_canonical_state().

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 btf_encoder.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 38455a4..81bfda3 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -96,6 +96,7 @@ struct btf_encoder_func_state {
 	uint8_t uncertain_parm_loc:1;
 	uint8_t reordered_parm:1;
 	uint8_t ambiguous_addr:1;
+	uint8_t inlined:1;
 	int ret_type_id;
 	struct btf_encoder_func_parm *parms;
 	struct btf_encoder_func_annot *annots;
@@ -1295,6 +1296,7 @@ static int32_t btf_encoder__save_func(struct btf_en=
coder *encoder, struct functi
 	state->optimized_parms =3D ftype->optimized_parms;
 	state->uncertain_parm_loc =3D ftype->uncertain_parm_loc;
 	state->reordered_parm =3D ftype->reordered_parm;
+	state->inlined =3D function__inlined(fn);
 	ftype__for_each_parameter(ftype, param) {
 		const char *name;
 		char *final_name =3D NULL;
@@ -1489,8 +1491,19 @@ static int saved_functions_cmp(const void *_a, con=
st void *_b)
 {
 	const struct btf_encoder_func_state *a =3D _a;
 	const struct btf_encoder_func_state *b =3D _b;
+	int ret;
=20
-	return elf_function__name_cmp(a->elf, b->elf);
+	ret =3D elf_function__name_cmp(a->elf, b->elf);
+	if (ret)
+		return ret;
+
+	/* For the same function, sort the out-of-line (real) instances before
+	 * the inlined (abstract) ones. saved_functions_combine() compares ever=
y
+	 * state in a group against the first (anchor) one, so keeping a real
+	 * instance as the anchor ensures real instances are still compared
+	 * against each other for prototype consistency.
+	 */
+	return a->inlined - b->inlined;
 }
=20
 static int saved_functions_combine(struct btf_encoder *encoder,
@@ -1507,7 +1520,17 @@ static int saved_functions_combine(struct btf_enco=
der *encoder,
 	inconsistent =3D a->inconsistent_proto | b->inconsistent_proto;
 	uncertain_parm_loc =3D a->uncertain_parm_loc | b->uncertain_parm_loc;
 	reordered_parm =3D a->reordered_parm | b->reordered_parm;
-	if (!unexpected && !inconsistent && !reordered_parm && !funcs__match(en=
coder, a, b))
+
+	/* Only compare prototypes that are of the same kind. An inlined
+	 * (abstract) instance carries the original signature while the
+	 * out-of-line instance carries the true signature, so the two will
+	 * legitimately differ; comparing them would wrongly flag the function
+	 * as having an inconsistent prototype and drop it from BTF. The true
+	 * signature always comes from the out-of-line (real) instance, which i=
s
+	 * the one selected by btf_encoder__select_canonical_state().
+	 */
+	if (a->inlined =3D=3D b->inlined &&
+	    !unexpected && !inconsistent && !reordered_parm && !funcs__match(en=
coder, a, b))
 		inconsistent =3D 1;
 	a->optimized_parms =3D b->optimized_parms =3D optimized;
 	a->unexpected_reg =3D b->unexpected_reg =3D unexpected;
--=20
2.53.0-Meta

