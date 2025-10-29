Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC889363377
	for <dwarves@vger.kernel.org>; Wed, 29 Oct 2025 19:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764593; cv=none; b=to4r2IpN9i/DVBRkIJV9+xMcFC4ZAn6cJy9iKV4jeLdAjZf66SzrHK6RT9mdT4/S0XQFibbxToQgKQA+HljsixLf3CUsrb2jfv2xgIaUs6KxFTfZzzAtqBdGplIitMpwbjHnh0js6E+/btFa6OCItPujakF1CXXFbQm3oCKdRS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764593; c=relaxed/simple;
	bh=dZOiqX5EoZXD+eoVEwQYCHtnHKTrFBipEphGz5wdEDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPFGxCKLb5GBXNymzEsiJrc1eY9vnuQ9T3GwLEEhPp9RXQj7H6bBuo/0Xbw5/pkFYNoq8X1w+IVHAdpPCGdAhmQoYNvgAqEX5UL68V6OUZu9omCg1EsYZwHFvF+7K6FxjDAiu3GBBevBAbIkd7iHyW9dMTotIupMBNCFwm885gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YdpqaK1R; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YdpqaK1R"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761764588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MlF1u/Gb9vYyiRjkPghLQkw8RCEqf4EY9G1Ad/tFfhc=;
	b=YdpqaK1RAgpw/LBhqtFzY5L4dpqGqqJfCqJmo0hDChenZNbX2g+fDjMSS/bL7KPUCwQPTw
	A8xFMLqRo4hC/4IcWvGynBSF8TKRmrpzPWCOxU693phJWCVtNYSwxOPwFfOB1+8Yx9GIw4
	GM3NechuhkdndmwgNwJr7jBS8fMzZ5s=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org
Cc: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	tj@kernel.org,
	kernel-team@meta.com
Subject: [PATCH dwarves v1 2/3] btf_encoder: factor out btf_encoder__add_bpf_kfunc()
Date: Wed, 29 Oct 2025 12:02:48 -0700
Message-ID: <20251029190249.3323752-3-ihor.solodrai@linux.dev>
In-Reply-To: <20251029190249.3323752-1-ihor.solodrai@linux.dev>
References: <20251029190249.3323752-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Emitting BTF for BPF kernel functions requires special
handling. Consolidate this behavior into btf_encoder__add_bpf_kfunc()
function, which uses simplified btf_encoder_add_func()

No functional changes.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 btf_encoder.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 0416824..b730280 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -774,6 +774,7 @@ static int btf__tag_bpf_arena_arg(struct btf *btf, struct btf_encoder_func_state
 	return id;
 }
 
+/* Modifies state->ret_type_id and state->parms[i].type_id for flagged kfuncs */
 static int btf__add_bpf_arena_type_tags(struct btf *btf, struct btf_encoder_func_state *state)
 {
 	uint32_t flags = state->elf->kfunc_flags;
@@ -883,10 +884,6 @@ static int32_t btf_encoder__add_func_proto_for_state(struct btf_encoder *encoder
 
 	assert(state != NULL);
 
-	if (is_kfunc_state(state) && encoder->tag_kfuncs && encoder->encode_attributes)
-		if (btf__add_bpf_arena_type_tags(encoder->btf, state) < 0)
-			return -1;
-
 	encoder = state->encoder;
 	btf = state->encoder->btf;
 	nr_params = state->nr_parms;
@@ -1370,7 +1367,6 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
 	const char *value;
 	char tmp_value[KSYM_NAME_LEN];
 	uint16_t idx;
-	int err;
 
 	btf_fnproto_id = btf_encoder__add_func_proto_for_state(encoder, state);
 	name = func->name;
@@ -1383,15 +1379,6 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
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
 
@@ -1414,6 +1401,28 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
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
 
@@ -1511,7 +1520,10 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
 					0, 0);
 
 		if (add_to_btf) {
-			err = btf_encoder__add_func(state->encoder, state);
+			if (is_kfunc_state(state))
+				err = btf_encoder__add_bpf_kfunc(state->encoder, state);
+			else
+				err = btf_encoder__add_func(state->encoder, state);
 			if (err < 0)
 				goto out;
 		}
-- 
2.51.1

