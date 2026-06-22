Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4438C34D398
	for <dwarves@vger.kernel.org>; Mon, 22 Jun 2026 20:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159912; cv=none; b=qyNslg0fCykF6Hj9Oy31uH/GjNJP7HvV+r/UBLS0AgMyVFOn6/1t/WatyT3Wam4aOOBIzaCx69cW8AoxX6rjyUdA1PTSbLh3P35wGnyxYO/LR9FIhSPhTl8pxedG7qB3+YupvOTWw5EiIkHQmXwbB09DKDeZEaCTbyTL/96sAkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159912; c=relaxed/simple;
	bh=L1cr1j8EK3qBh98rqPubYs8FI/gXyQgdmDS/lMwA8JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECu+/0stKImZAET90RbN+f8sjgCqYz2lZdze0D9Ub7Dzg8rghO/NB8kLeEhZPhyaatNklTwo61u73M130o/rCo9v5sMtAzgZo4efBA1J8h2x2dOW9+G/7dqGxWYny1YvHryqgZrCi8+4U3P8f6Ffepm+IIHeoSqHSrSRRyqdohY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaQE6HAk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaQE6HAk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE421F000E9;
	Mon, 22 Jun 2026 20:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782159910;
	bh=E+Iw/k7brjnQsvXcOiFDTxPDgHG9wo1yyEERN9BxMvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IaQE6HAkGiJgYNYzRtZKsCro3y6kpX42igkZYNRBwg4VdIPZvoS9H3cEFu072mtrD
	 4qrLc2uYw4ftjVLZcO4hpnttuvHK3m4sKKF7Ov0Va0OxctQQtHFihfCwpGu8H9Ec/V
	 71urENEq8TU2d8r/o/alLqA4ZTfFyJEMwluD4zTZcBfSeDS0UIgLrnkLyFRaadUv/N
	 BpDLVY4JDVwIxcug9hfhNAsmSq3OZFe5Gf2kQdnpN8h142uEh0YpGKHq8O6pTOeMr3
	 FgTE0DmGaKHGPC4PJkufLE3X7d4oJh/GviykJ3tulx7jnAV3rbgSFHbjS2dDtHpY2l
	 rRQt1zoD3ttAA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/16] btf_encoder: Encode variant parts as union members in BTF
Date: Mon, 22 Jun 2026 17:24:33 -0300
Message-ID: <20260622202441.14799-11-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622202441.14799-1-acme@kernel.org>
References: <20260622202441.14799-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

With the DWARF loader now populating DW_TAG_variant children (previous
commit), wire them into BTF encoding so Rust discriminated unions
(Option<T>, Result<T,E>, etc.) are no longer emitted as empty structs.

Two changes:

1. Struct-to-union promotion: when a DW_TAG_structure_type has
   variant_parts but no regular data members, encode it as BTF_KIND_UNION
   instead of BTF_KIND_STRUCT, since the variants overlap at offset 0.

2. Variant member encoding: after encoding regular data members, iterate
   the variant_parts and emit each variant as a BTF union field with the
   variant's name and resolved type reference.

Testing with the sashiko-cli Rust binary (a real-world async HTTP client
using tokio, hyper, serde, etc.):

Before:

  $ bpftool btf dump file sashiko-cli | grep -c UNION
  2073
  $ bpftool btf dump file sashiko-cli | grep 'STRUCT.*vlen=0' | grep -vc 'size=0'
  24335

After:

  $ bpftool btf dump file sashiko-cli | grep -c UNION
  25750
  $ bpftool btf dump file sashiko-cli | grep 'STRUCT.*vlen=0' | grep -vc 'size=0'
  2236

22,099 types that were previously encoded as empty structs are now
properly represented as unions with their variant members:

Before:

  $ bpftool btf dump file code_with_type.o | grep -A1 'Option<u32>'
  [11] STRUCT 'Option<u32>' size=8 vlen=0

After:

  $ bpftool btf dump file code_with_type.o | grep -A3 'Option<u32>'
  [11] UNION 'Option<u32>' size=8 vlen=2
          'None' type_id=9 bits_offset=0
          'Some' type_id=10 bits_offset=0

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 btf_encoder.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index dc1e18a986605d04..5a510afbde7afa84 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1743,6 +1743,11 @@ static int tag__check_id_drift(struct btf_encoder *encoder, const struct tag *ta
 	return 0;
 }
 
+static bool type__has_variant_parts(const struct type *type)
+{
+	return !list_empty(&type->variant_parts);
+}
+
 static int32_t btf_encoder__add_struct_type(struct btf_encoder *encoder, struct tag *tag)
 {
 	struct type *type = tag__type(tag);
@@ -1751,8 +1756,18 @@ static int32_t btf_encoder__add_struct_type(struct btf_encoder *encoder, struct
 	int32_t type_id;
 	uint8_t kind;
 
-	kind = (tag->tag == DW_TAG_union_type) ?
-		BTF_KIND_UNION : BTF_KIND_STRUCT;
+	/*
+	 * Rust discriminated unions (enums) are represented in DWARF as
+	 * DW_TAG_structure_type with DW_TAG_variant_part children.
+	 * If the struct has only variant parts and no regular data members,
+	 * encode it as a BTF union since the variants overlap at offset 0.
+	 */
+	if (tag->tag == DW_TAG_union_type)
+		kind = BTF_KIND_UNION;
+	else if (type__has_variant_parts(type) && type->nr_members == 0)
+		kind = BTF_KIND_UNION;
+	else
+		kind = BTF_KIND_STRUCT;
 
 	type_id = btf_encoder__add_struct(encoder, kind, name, type->size);
 	if (type_id < 0)
@@ -1770,6 +1785,24 @@ static int32_t btf_encoder__add_struct_type(struct btf_encoder *encoder, struct
 			return -1;
 	}
 
+	if (type__has_variant_parts(type) && kind == BTF_KIND_UNION) {
+		struct variant_part *vpart;
+
+		type__for_each_variant_part(type, vpart) {
+			struct variant *variant;
+
+			variant_part__for_each_variant(vpart, variant) {
+				if (variant->tag.type == 0)
+					continue;
+
+				uint32_t ref_type_id = encoder->type_id_off + variant->tag.type;
+
+				if (btf_encoder__add_field(encoder, variant->name, ref_type_id, 0, 0))
+					return -1;
+			}
+		}
+	}
+
 	return type_id;
 }
 
-- 
2.54.0

