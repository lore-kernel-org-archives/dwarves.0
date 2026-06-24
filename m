Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA322F7EEF
	for <dwarves@vger.kernel.org>; Wed, 24 Jun 2026 05:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782278781; cv=none; b=KvgLdgFJ7DMfrspUlH2GMByuunRVQQE5WnREA/WhLfPsZB+EQ3a5K8Sir/TJhvC2KkE8qqg2FIYVnhj3rQ9hvMCeHPeLyhRZREAQwnw+2Hitq9tagEn44zyM/563AgUOdFhUVRihx1ZQ6Sfek7jjumshUcywv53TfspALTEgQWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782278781; c=relaxed/simple;
	bh=wNs5eoAvIdfkM/TJ9gcA8BPJMY0wnrfn4DdnAYgbstw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6PeylfYo5QwrfnidTRMZ6vm1QTSGirx5fvC5NVi22yxfFh76exK2l3H3+hmT4e3ltYjwNGu/r+/rlWtJh33C/6OrbuTuBMlUuTxqTmjASEngnum2a5oqsATyxsabAUVYhYS3AqGO89KPtP2NVAppDoPkxv1jOQiMyQZI/ZjnNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 1B763198D40CFB; Tue, 23 Jun 2026 22:26:14 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v9 4/6] btf_encoder: Emit true function signatures
Date: Tue, 23 Jun 2026 22:26:14 -0700
Message-ID: <20260624052614.3142419-1-yonghong.song@linux.dev>
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

When true_signature is enabled, consume the per-parameter analysis the
DWARF loader recorded while saving a function's BTF:
 - Drop parameters that were optimized out of a signature-changed functio=
n
   (ftype->signature_changed && param->optimized), adjusting the saved
   parameter count accordingly.
 - When a parameter was reduced to a single aggregate member
   (param->true_sig_member_name is set), emit it under the synthesized na=
me
   "<parameter>__<member>" so the BTF reflects the value actually passed =
in
   the register.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 btf_encoder.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index d5af706..38455a4 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1297,14 +1297,38 @@ static int32_t btf_encoder__save_func(struct btf_=
encoder *encoder, struct functi
 	state->reordered_parm =3D ftype->reordered_parm;
 	ftype__for_each_parameter(ftype, param) {
 		const char *name;
+		char *final_name =3D NULL;
=20
 		/* No location info/optimized + reordered means optimized out. */
 		if (ftype->reordered_parm && (!param->has_loc || param->optimized)) {
 			state->nr_parms--;
 			continue;
 		}
-		name =3D parameter__name(param) ?: "";
+		if (encoder->true_signature && ftype->signature_changed && param->opti=
mized) {
+			state->nr_parms--;
+			continue;
+		}
+
+		name =3D parameter__name(param);
+		if (!name) {
+			name =3D "";
+		} else if (encoder->true_signature &&
+			   ftype->signature_changed &&
+			   param->true_sig_member_name) {
+			/* Non-null param->true_sig_member_name indicates that the parameter
+			 * name is <parameter_name>__<field_name>.
+			 */
+			if (asprintf(&final_name, "%s__%s", name, param->true_sig_member_name=
) =3D=3D -1) {
+				err =3D -ENOMEM;
+				goto out;
+			}
+			name =3D final_name;
+		}
+
 		str_off =3D btf__add_str(btf, name);
+		if (final_name)
+			free(final_name);
+
 		if (str_off < 0) {
 			err =3D str_off;
 			goto out;
--=20
2.53.0-Meta

