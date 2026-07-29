Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39B9463B74;
	Wed, 29 Jul 2026 19:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352083; cv=none; b=uyvj3DCNZ2RK/wdv3PphdpYaEqgnUILJteUK3KW8sUkophg/5bFr8154PB7b8ROYbiLr3dTFaB1ikjG+sMPkiuc9OWJhKp7hcBBwQ0mKBIuaF4XTvOKkYAldP4bAoAaX5JdgudBfwikKRD1XfmwLN2ziCqwm5fEsgEKHmLk1nPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352083; c=relaxed/simple;
	bh=Vg+pzAFjE7sAyVpJe5q1hXbdUuIUBkAFIW4zuqia7PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KftO4VSiswfJk6oKKKRWrxWONzD0EWS5ePmDGnVvXb3djIDTn58HRRDz39a4tED0bMaIrWRgHr4hYUCPg1Hkqn/1q3eZHC7cKOeSueVZxpML9FonF/h5u3X4/LI6IrKl8MT1WgNT84GxZgdQWlnLejAXurkD/estEMi3yIP1OLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPjI7AFn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPjI7AFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B740B1F00A3A;
	Wed, 29 Jul 2026 19:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352081;
	bh=swCaH9sjSXzPmLbQh3qoDpDZuPRDns4kGNGVhhVv1mM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BPjI7AFn2FdT+GZf4VLp+GZvNb0yeDh4gPYq4T0jXtHD18YggJaSIaxMTzSzS701R
	 E97AcnO17KUHLKwo87TcnHigkUzPD3juLkGrwB7rEl0k+rbgEsDpYOt0+Fwlr/vSM/
	 Sbf2rOJTSdRdJElibBf9achIXOwcaiYBSaRJk6XixhBN/KVbdwFCSueveJAi9g7J4r
	 hJt+Bm1jrLfUjkOEtowbfOoCDCoU4jXkKDJvU5cj/ZiI+kMwM2mfbV+GejNI2fK+UD
	 sWtbaTDvf4eCZdAyT0FJe+qoNy/Lq7MXedX+FQR1wLXihmjmxHkc0LMHlfZtWwB3qA
	 o0liC2kw7lfjw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/31] btf_encoder: Use btf_encoder__tag_type() for all type ID computations
Date: Wed, 29 Jul 2026 16:07:10 -0300
Message-ID: <20260729190733.72876-11-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729190733.72876-1-acme@kernel.org>
References: <20260729190733.72876-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Replace inline "encoder->type_id_off + tag_type" patterns with
btf_encoder__tag_type(), which already encapsulates both the zero-check
and the offset addition.  Some call sites had ternary guards
(tag_type == 0 ? 0 : ...) that are now handled inside the function.

Two sites that use nr_entries or core_id as table indices rather than
type references are left unchanged — they receive different treatment
in a subsequent commit.

No functional change.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 btf_encoder.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 5d0901da73b618d7..0fbd7e3420b0457f 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -865,7 +865,7 @@ static int32_t btf_encoder__add_func_proto_for_ftype(struct btf_encoder *encoder
 
 	ftype__for_each_parameter(ftype, param) {
 		name = parameter__name(param);
-		type_id = param->tag.type == 0 ? 0 : encoder->type_id_off + param->tag.type;
+		type_id = btf_encoder__tag_type(encoder, param->tag.type);
 		++param_idx;
 		if (btf_encoder__add_func_param(encoder, name, type_id, param_idx == nr_params))
 			return -1;
@@ -1284,7 +1284,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 	state->addr = function__addr(fn);
 	state->elf = func;
 	state->nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
-	state->ret_type_id = ftype->tag.type == 0 ? 0 : encoder->type_id_off + ftype->tag.type;
+	state->ret_type_id = btf_encoder__tag_type(encoder, ftype->tag.type);
 	if (state->nr_parms > 0) {
 		state->parms = zalloc(state->nr_parms * sizeof(*state->parms));
 		if (!state->parms) {
@@ -1363,8 +1363,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 			goto out;
 		}
 		state->parms[param_idx].name_off = str_off;
-		state->parms[param_idx].type_id = param->tag.type == 0 ? 0 :
-						  encoder->type_id_off + param->tag.type;
+		state->parms[param_idx].type_id = btf_encoder__tag_type(encoder, param->tag.type);
 		param_idx++;
 	}
 	if (ftype->unspec_parms)
@@ -1849,11 +1848,13 @@ static int32_t btf_encoder__add_struct_type(struct btf_encoder *encoder, struct
 		 * is required.
 		 */
 		name = class_member__name(pos);
-		if (btf_encoder__add_field(encoder, name, encoder->type_id_off + pos->tag.type,
+		if (btf_encoder__add_field(encoder, name, btf_encoder__tag_type(encoder, pos->tag.type),
 					   pos->bitfield_size, pos->bit_offset))
 			return -1;
 	}
 
+
+
 	return type_id;
 }
 
@@ -1894,7 +1895,7 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
 				   struct conf_load *conf_load)
 {
 	/* single out type 0 as it represents special type "void" */
-	uint32_t ref_type_id = tag->type == 0 ? 0 : encoder->type_id_off + tag->type;
+	uint32_t ref_type_id = btf_encoder__tag_type(encoder, tag->type);
 	struct base_type *bt;
 	const char *name;
 
@@ -2720,7 +2721,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 			continue;
 		}
 
-		type = var->ip.tag.type + encoder->type_id_off;
+		type = btf_encoder__tag_type(encoder, var->ip.tag.type);
 		linkage = var->external ? BTF_VAR_GLOBAL_ALLOCATED : BTF_VAR_STATIC;
 
 		if (encoder->verbose) {
@@ -2983,7 +2984,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 		type_id_t id;
 		if (cu__find_base_type_by_name(cu, "int", &id)) {
 			encoder->has_index_type = true;
-			encoder->array_index_id = encoder->type_id_off + id;
+			encoder->array_index_id = btf_encoder__tag_type(encoder, id);
 		} else {
 			encoder->has_index_type = false;
 			encoder->array_index_id = encoder->type_id_off + cu->types_table.nr_entries;
-- 
2.55.0

