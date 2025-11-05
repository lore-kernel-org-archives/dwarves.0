Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF8A3168E5
	for <dwarves@vger.kernel.org>; Wed,  5 Nov 2025 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369194; cv=none; b=ltRFLiVsqq44+Z6q94//uIl+2b3HD36O0c0tBDZ+9VPCGxPAuK7FtwXf5kHkx4vMegWb6mUFk/qWlv4pPvG+NdFBMhQ/a+qDIXSuQIOsz7kS9xGehBFSaYfSp8aui2+04D5/7+CjENVGzDK3n09UBfVPCrKkAXsqMHRAMzGpiEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369194; c=relaxed/simple;
	bh=hzp3qvRKVUP8Toev82hsUuFRD5CXULNrTBrzUlF/RGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HNz9QB7sjhECieZxvLROiez6cL1DJJqGym8W72NXs6PfoUX+p4JaEdFJilYumRol3xYTmknH/GykPg+GT46lcK9c14zGnP3JGv9jj/kz3DTppV4DDn0G02x9Bp3J9ljJPnTwsiJUaD9i50Iw/3WWy0OSZgg1EeoAN5WZjt3ZSHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g6VB+M05; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g6VB+M05"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762369190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6kbCTK/sBAf7hQEvrwXu2rh9PPwr2+wI29DInbdBjZY=;
	b=g6VB+M05wFKwB6AHs1U7V8Z20az4ZqysD8lRJNySU8wloeVrX4eZ167q8IM7387BYsdJ1k
	db7oxzKsBGDFhaGV4djJHWlEvES9wDCc1IhBzzhk2PNGWhOZQ6lRjAbXEJO4YQ1ZLVdZC3
	IjXp5yGN4dM+MNqI7EITKhpG4cs5/+w=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com
Cc: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	kernel-team@meta.com
Subject: [PATCH dwarves v3 3/3] btf_encoder: Factor out BPF kfunc emission
Date: Wed,  5 Nov 2025 10:59:26 -0800
Message-ID: <20251105185926.296539-4-ihor.solodrai@linux.dev>
In-Reply-To: <20251105185926.296539-1-ihor.solodrai@linux.dev>
References: <20251105185926.296539-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Generating BTF for BPF kernel functions requires special
handling. Consolidate this behavior into btf_encoder__add_bpf_kfunc(),
which uses simplified btf_encoder_add_func().

No functional changes.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 btf_encoder.c | 49 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index bdda7d0..0bb7831 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -773,6 +773,7 @@ static int btf__tag_bpf_arena_arg(struct btf *btf, struct btf_encoder_func_state
 	return id;
 }
 
+/* Modifies state->ret_type_id and state->parms[i].type_id for flagged kfuncs */
 static int btf__add_bpf_arena_type_tags(struct btf *btf, struct btf_encoder_func_state *state)
 {
 	uint32_t flags = state->elf->kfunc_flags;
@@ -883,11 +884,6 @@ static int32_t btf_encoder__add_func_proto_for_state(struct btf_encoder *encoder
 	const char *name;
 	bool is_last;
 
-	/* Beware: btf__add_bpf_arena_type_tags may change some members of the state */
-	if (is_kfunc_state(state) && encoder->tag_kfuncs && encoder->encode_attributes)
-		if (btf__add_bpf_arena_type_tags(encoder->btf, state) < 0)
-			return -1;
-
 	type_id = state->ret_type_id;
 	nr_params = state->nr_parms;
 
@@ -1357,14 +1353,13 @@ static int btf__tag_kfunc(struct btf *btf, struct elf_function *kfunc, __u32 btf
 static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
 				     struct btf_encoder_func_state *state)
 {
-	struct elf_function *func = state->elf;
 	int btf_fnproto_id, btf_fn_id, tag_type_id = 0;
+	struct elf_function *func = state->elf;
+	char tmp_value[KSYM_NAME_LEN];
 	int16_t component_idx = -1;
-	const char *name;
 	const char *value;
-	char tmp_value[KSYM_NAME_LEN];
+	const char *name;
 	uint16_t idx;
-	int err;
 
 	btf_fnproto_id = btf_encoder__add_func_proto_for_state(encoder, state);
 	name = func->name;
@@ -1377,15 +1372,6 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
 		return -1;
 	}
 
-	if (func->kfunc && encoder->tag_kfuncs && !encoder->skip_encoding_decl_tag) {
-		err = btf__tag_kfunc(encoder->btf, func, btf_fn_id);
-		if (err < 0)
-			return err;
-	}
-
-	if (state->nr_annots == 0)
-		return 0;
-
 	for (idx = 0; idx < state->nr_annots; idx++) {
 		struct btf_encoder_func_annot *a = &state->annots[idx];
 
@@ -1408,6 +1394,28 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
 		return -1;
 	}
 
+	return btf_fn_id;
+}
+
+static int btf_encoder__add_bpf_kfunc(struct btf_encoder *encoder,
+				      struct btf_encoder_func_state *state)
+{
+	int btf_fn_id, err;
+
+	if (encoder->tag_kfuncs && encoder->encode_attributes)
+		if (btf__add_bpf_arena_type_tags(encoder->btf, state) < 0)
+			return -1;
+
+	btf_fn_id = btf_encoder__add_func(encoder, state);
+	if (btf_fn_id < 0)
+		return -1;
+
+	if (encoder->tag_kfuncs && !encoder->skip_encoding_decl_tag) {
+		err = btf__tag_kfunc(encoder->btf, state->elf, btf_fn_id);
+		if (err < 0)
+			return -1;
+	}
+
 	return 0;
 }
 
@@ -1507,7 +1515,10 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
 					0, 0);
 
 		if (add_to_btf) {
-			err = btf_encoder__add_func(encoder, state);
+			if (is_kfunc_state(state))
+				err = btf_encoder__add_bpf_kfunc(encoder, state);
+			else
+				err = btf_encoder__add_func(encoder, state);
 			if (err < 0)
 				goto out;
 		}
-- 
2.51.1

