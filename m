Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348D1274FD0
	for <dwarves@vger.kernel.org>; Thu, 18 Jun 2026 01:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781745272; cv=none; b=dr6mF0hk51D5n9DY9SLu0n/44CbGHLzXM4uq9rg/8Krwr7UTIiZqgXQtHDUMZg0KRyW3gQsYrn/fWDO7xFYa8AWrND0aPrVZyXiBwYwDWlRg0leOHl9wQGaVdVsSKQxPQPqPo1CuEvKFMGeuVHhIS56xzscNIGXmCSWjAV6tLUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781745272; c=relaxed/simple;
	bh=urrMvEu9GAKMViLn8HSKJt2ahkiorkrFJRLiN2TOf+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pIBp3jJiUjU3hJOcqkA8NIR2l+FKymXfUwwfdsHq/rnlRtteMBkw4+gCCDjBmbV/UyjwCsRtQUE8AQTyh34Mnkwc85ziHcq7FiXvNhEl9ozrx6rYNNjtH+UISqJVZ3NNL+KlHUd2xWcrvLV4+SspAo7gAvpdJovb7XKceEdGga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id ECF32176E3B9C4; Wed, 17 Jun 2026 18:14:19 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH dwarves v6 4/5] btf_encoder: Emit true function signatures
Date: Wed, 17 Jun 2026 18:14:19 -0700
Message-ID: <20260618011419.640165-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618011358.632394-1-yonghong.song@linux.dev>
References: <20260618011358.632394-1-yonghong.song@linux.dev>
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
 btf_encoder.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 633bc61..c8e8437 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1297,14 +1297,36 @@ static int32_t btf_encoder__save_func(struct btf_=
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
+		} else if (param->true_sig_member_name) {
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

