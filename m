Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EAF2C2374
	for <dwarves@vger.kernel.org>; Mon, 23 Mar 2026 21:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774300547; cv=none; b=aPFbx/TmbxfFrK8zkF52RnmJBCyk/71jSPQlP9i0Bpuuonovvxzu8My9K9pg6QCqI+Tmx06z2A3v8Dcql02SRb1HZHyD9OP77tJbiMqUUIG/UymZ9NZXTzk+nB02J3rNwLOPEAEaMKjyk8jSUZ0LfGtHwtubbzCYbf9/lubmjAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774300547; c=relaxed/simple;
	bh=BWMjXNQVbhC1oNLwDOKC7aLXCrVRBF+/2eStuT+K+c8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/x/0vnZEu2lk0qNv1IuS6AwXEdP4zw+giM53FYhwidDoPcA3CCqSyooamBcqKvSThRrCFFlFBDAUJQJ9Pg5YA2j7NZmgrWkQ9JXswHPswdt+32Z79pKXuFy61QSNMimtzS3umzRCXJjpMgqrvLr+hhNxpPh1widrYfl4oy/OsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhvp/WKy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhvp/WKy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFACC4CEF7;
	Mon, 23 Mar 2026 21:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774300547;
	bh=BWMjXNQVbhC1oNLwDOKC7aLXCrVRBF+/2eStuT+K+c8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fhvp/WKynvx8PjtmYiz7Vq2qfrMacC4LfTKQK6dNkiQs1FT1jMDQBxKaAmaH2IWPo
	 dWGH6EitJx3cGq82FCuq/WRPI2QWh//9noZNujZWa6fLlJe4hx9ZXoQFWpSjjvyu+L
	 34WamdR5tCG+u3t+cFk+kB/FyLzqcFluGUEPmZDsMsmgdRimqhjMjmPBagjx1UcE6L
	 KgspLwNAWnEcrQ/p0+ddmau4am+KY0RYOd72WaQDEud76ygnqeZaZXk2wxh0QRnRJW
	 nld5zSX4trUgc/S504fDFTPOMl+mrrh/v3ErD5GJVHcfUdLrI/BSki3oXvtQy5295Y
	 g0ywHJQ8Km0PA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/3] dwarf_loader: Initial support for DW_TAG_variant_part
Date: Mon, 23 Mar 2026 18:15:31 -0300
Message-ID: <20260323211533.1909029-2-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323211533.1909029-1-acme@kernel.org>
References: <20260323211533.1909029-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Still doesn't handle its sub hierarchy, i.e. the DW_TAG_variant entries
and its underlying DW_TAG_member entries.

This was noticed when running the regression test that uses a debug
build of perf to process a perf.data file and test pahole's pretty
printing features, as now perf has a synthetic workload that is written
in rust:

 <0><20c95a>: Abbrev Number: 1 (DW_TAG_compile_unit)
    <20c95b>   DW_AT_producer    : (indirect string, offset: 0x4ee5a): clang LLVM (rustc version 1.93.1 (01f6ddf75 2026-02-11) (Fedora 1.93.1-1.fc43))
    <20c95f>   DW_AT_language    : 28	(Rust)
    <20c961>   DW_AT_name        : (indirect string, offset: 0x4eeaa): tests/workloads/code_with_type.rs/@/code_with_type.d6e680867bfb8b27-cgu.0
    <20c965>   DW_AT_stmt_list   : 0x5e1ed
    <20c969>   DW_AT_comp_dir    : (indirect string, offset: 0x487f1): /home/acme/git/perf-tools/tools/perf
    <20c96d>   DW_AT_low_pc      : 0
    <20c975>   DW_AT_ranges      : 0x2d0
⬢ [acme@toolbx pahole]$

So lets add some scaffolding for the Rust DWARF constructs involved for
us to be able to continue using perf with DWARF to test the pretty
printing features.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 26 +++++++++++++++++++++++++-
 dwarves.c      |  6 ++++++
 dwarves.h      |  7 +++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 16fb7becffee56f6..f0833e8c44a944a8 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -508,6 +508,8 @@ static void tag__init(struct tag *tag, struct cu *cu, Dwarf_Die *die)
 
 	if (tag->tag == DW_TAG_imported_module || tag->tag == DW_TAG_imported_declaration)
 		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_import);
+	else if (tag->tag == DW_TAG_variant_part)
+		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_discr);
 	else
 		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_type);
 
@@ -1170,6 +1172,18 @@ static struct template_parameter_pack *template_parameter_pack__new(Dwarf_Die *d
 	return pack;
 }
 
+static struct variant_part *variant_part__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
+{
+	struct variant_part *vpart = tag__alloc(cu, sizeof(*vpart));
+
+	if (vpart != NULL) {
+		tag__init(&vpart->tag, cu, die);
+		INIT_LIST_HEAD(&vpart->variants);
+	}
+
+	return vpart;
+}
+
 /* Returns number of locations found or negative value for errors. */
 static ptrdiff_t __dwarf_getlocations(Dwarf_Attribute *attr,
 				      ptrdiff_t offset, Dwarf_Addr *basep,
@@ -1990,9 +2004,19 @@ static int die__process_class(Dwarf_Die *die, struct type *class,
 		case DW_TAG_GNU_template_template_param:
 #endif
 		case DW_TAG_subrange_type: // XXX: ADA stuff, its a type tho, will have other entries referencing it...
-		case DW_TAG_variant_part: // XXX: Rust stuff
 			tag__print_not_supported(die);
 			continue;
+		case DW_TAG_variant_part: {
+			struct variant_part *vpart = variant_part__new(die, cu, conf);
+
+			if (vpart == NULL)
+				return -ENOMEM;
+
+			// For rust it seems we have just one, but DWARF, according to Gemini, support having
+			// more than one DW_TAG_variant_part for a given DW_TAG_structure_type, so future proof it
+			type__add_variant_part(class, vpart);
+			continue;
+		}
 		case DW_TAG_template_type_parameter: {
 			struct template_type_param *ttparm = template_type_param__new(die, cu, conf);
 
diff --git a/dwarves.c b/dwarves.c
index ef93239d26827711..efc7ae214376e1c1 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -428,6 +428,7 @@ void __type__init(struct type *type)
 	INIT_LIST_HEAD(&type->type_enum);
 	INIT_LIST_HEAD(&type->template_type_params);
 	INIT_LIST_HEAD(&type->template_value_params);
+	INIT_LIST_HEAD(&type->variant_parts);
 	type->template_parameter_pack = NULL;
 	type->sizeof_member = NULL;
 	type->member_prefix = NULL;
@@ -1366,6 +1367,11 @@ void type__add_template_value_param(struct type *type, struct template_value_par
 	list_add_tail(&tvparam->tag.node, &type->template_value_params);
 }
 
+void type__add_variant_part(struct type *type, struct variant_part *vpart)
+{
+	list_add_tail(&vpart->tag.node, &type->variant_parts);
+}
+
 struct class_member *type__last_member(struct type *type)
 {
 	struct class_member *pos;
diff --git a/dwarves.h b/dwarves.h
index d7c64742c29a9e9f..95d84b8ce3a6e95d 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -1011,6 +1011,11 @@ static inline struct formal_parameter_pack *tag__formal_parameter_pack(const str
 
 void formal_parameter_pack__add(struct formal_parameter_pack *pack, struct parameter *param);
 
+struct variant_part {
+	struct tag	 tag;
+	struct list_head variants;
+};
+
 /*
  * tag.tag can be DW_TAG_subprogram_type or DW_TAG_subroutine_type.
  */
@@ -1281,6 +1286,7 @@ struct type {
 	uint8_t		 is_signed_enum:1;
 	struct list_head template_type_params;
 	struct list_head template_value_params;
+	struct list_head variant_parts;
 	struct template_parameter_pack *template_parameter_pack;
 };
 
@@ -1401,6 +1407,7 @@ static inline struct class_member *class_member__next(struct class_member *membe
 void type__add_member(struct type *type, struct class_member *member);
 void type__add_template_type_param(struct type *type, struct template_type_param *ttparm);
 void type__add_template_value_param(struct type *type, struct template_value_param *tvparam);
+void type__add_variant_part(struct type *type, struct variant_part *vpart);
 
 struct class_member *
 	type__find_first_biggest_size_base_type_member(struct type *type,
-- 
2.53.0

