Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDA22FD694;
	Fri, 31 Jul 2026 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785526281; cv=none; b=CujamjBmm3CQbsLbiQbMXPw5f01n44oKy+HL2P6iwaUHzMI1rrMuMRNU9vSIdZkvX3SKoRVH+JPpwxBbsJwOHXCP7Q9OheoGpUDNmKeDhKkQ69K5z42z0G046B+Lhc0HOYSrciNK5qvqbWWOf33erR+eZS3TdG6e3I+FPkXpnX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785526281; c=relaxed/simple;
	bh=PGOzPEUEhxjfd48VAQa3GpsJ30UPnnD1SQ1ay4ejC4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGgyP1pZ/upvfIZHPXvkX2GH+RCKyTeXU5nqPNyHdO6ouEZ72JA+LvbGwiYmsqqXJQ4rlTXGrv7G2e6wcVMY7vHKb3EL2MWWwT+wMzPdEJSsotnlkq1ap0+oO6Fnp5kPmx5RYLxLb6LqATrRP0LTfYFC2Ys08T7aWhc3eyNjm3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HG2SMTtD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HG2SMTtD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1620F1F00AC4;
	Fri, 31 Jul 2026 19:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785526279;
	bh=WGFVQSvjqk4TKdRIvRCFbY8Eii7LAzaIsnlVPeNtldA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HG2SMTtDNuRrd8FllfmI9Rvr0oioLP0ANJfZzuXS5ANWxbCS7YYLGJXhneO/LXuc+
	 7ArcvFvOdz4cnk8sOx2AMUmKNcG/04UY1ye9Y5f9awnOG+EXsB7PTf2g/J5rJaAP7/
	 NnYdy02c0GgNKc6nR48RIcZU0OLZXy567ivQW+eBa4xWVVBG65kOc9AhG9smkVyzPY
	 T4a7ohMY7j7Olaj4ND4myM+a7uRD8wfhJU51Gcq4kvM28u/xNn6Lp+z4SmxtRnwagz
	 JcV5qDfRclGRI3mssls3mAoU5/LSI2nBZCtZFaNuc+nu3RLdVi3zPbnPZd2iHyhIju
	 1IhKNvClyaTVA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Mark Wieelard <mjw@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/12] btf_encoder: Encode variant parts as union members in BTF
Date: Fri, 31 Jul 2026 16:30:52 -0300
Message-ID: <20260731193102.110693-5-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731193102.110693-1-acme@kernel.org>
References: <20260731193102.110693-1-acme@kernel.org>
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

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 btf_encoder.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 83ce21186ea7da36..acf0a5ade5e29014 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1855,6 +1855,12 @@ static void dump_invalid_symbol(const char *msg, const char *sym,
 	fprintf(stderr, "PAHOLE: Error: Use '--btf_encode_force' to ignore such symbols and force emit the btf.\n");
 }
 
+static bool type__has_variant_parts(const struct type *type)
+{
+	return !list_empty(&type->variant_parts);
+}
+
+
 static int32_t btf_encoder__add_struct_type(struct btf_encoder *encoder, struct tag *tag)
 {
 	struct type *type = tag__type(tag);
@@ -1863,8 +1869,18 @@ static int32_t btf_encoder__add_struct_type(struct btf_encoder *encoder, struct
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
@@ -1882,6 +1898,23 @@ static int32_t btf_encoder__add_struct_type(struct btf_encoder *encoder, struct
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
+				uint32_t ref_type_id = btf_encoder__tag_type(encoder, variant->tag.type);
+
+				if (btf_encoder__add_field(encoder, variant->name, ref_type_id, 0, 0))
+					return -1;
+			}
+		}
+	}
 
 
 	return type_id;
-- 
2.55.0

