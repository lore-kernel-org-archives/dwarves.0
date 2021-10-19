Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5779BC433FE
	for <linux-dwarves@archiver.kernel.org>; Tue, 19 Oct 2021 10:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BF2960F02
	for <linux-dwarves@archiver.kernel.org>; Tue, 19 Oct 2021 10:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbhJSKKI (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 19 Oct 2021 06:10:08 -0400
Received: from foss.arm.com ([217.140.110.172]:46974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234794AbhJSKKH (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Tue, 19 Oct 2021 06:10:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C757FED1;
        Tue, 19 Oct 2021 03:07:54 -0700 (PDT)
Received: from e126130.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B92223F70D;
        Tue, 19 Oct 2021 03:07:53 -0700 (PDT)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     acme@redhat.com
Cc:     dwarves@vger.kernel.org, douglas.raillard@arm.com
Subject: [PATCH v1 1/2] fprintf: Allow making struct/enum/union anonymous
Date:   Tue, 19 Oct 2021 11:07:23 +0100
Message-Id: <20211019100724.325570-2-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019100724.325570-1-douglas.raillard@arm.com>
References: <20211019100724.325570-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

From: Douglas Raillard <douglas.raillard@arm.com>

Allow making inner struct enums and union anonymous.

Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
---
 dwarves.h         |  4 +++-
 dwarves_emit.c    |  2 +-
 dwarves_fprintf.c | 52 ++++++++++++++++++++++++++++++-----------------
 3 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/dwarves.h b/dwarves.h
index 30d33fa..be334cb 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -99,6 +99,7 @@ struct conf_fprintf {
 	uint8_t	   indent;
 	uint8_t	   expand_types:1;
 	uint8_t	   expand_pointers:1;
+	uint8_t	   inner_anonymous:1;
 	uint8_t    rel_offset:1;
 	uint8_t	   emit_stats:1;
 	uint8_t	   suppress_comments:1;
@@ -1327,7 +1328,8 @@ static inline const char *enumerator__name(const struct enumerator *enumerator)
 void enumeration__delete(struct type *type);
 void enumeration__add(struct type *type, struct enumerator *enumerator);
 size_t enumeration__fprintf(const struct tag *tag_enum,
-			    const struct conf_fprintf *conf, FILE *fp);
+			    const struct conf_fprintf *conf, FILE *fp,
+			    bool anonymous);
 
 int dwarves__init(uint16_t user_cacheline_size);
 void dwarves__exit(void);
diff --git a/dwarves_emit.c b/dwarves_emit.c
index 5bf7946..5c67559 100644
--- a/dwarves_emit.c
+++ b/dwarves_emit.c
@@ -91,7 +91,7 @@ static int enumeration__emit_definitions(struct tag *tag,
 		return 0;
 	}
 
-	enumeration__fprintf(tag, conf, fp);
+	enumeration__fprintf(tag, conf, fp, false);
 	fputs(";\n", fp);
 	type_emissions__add_definition(emissions, etype);
 	return 1;
diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index c35868a..803cdab 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -186,7 +186,8 @@ size_t tag__fprintf_decl_info(const struct tag *tag,
 }
 
 static size_t __class__fprintf(struct class *class, const struct cu *cu,
-			       const struct conf_fprintf *conf, FILE *fp);
+			       const struct conf_fprintf *conf, FILE *fp,
+			       bool anonymous);
 static size_t type__fprintf(struct tag *type, const struct cu *cu,
 			    const char *name, const struct conf_fprintf *conf,
 			    FILE *fp);
@@ -318,7 +319,7 @@ size_t typedef__fprintf(const struct tag *tag, const struct cu *cu,
 		struct conf_fprintf tconf = *pconf;
 
 		tconf.suffix = type__name(type);
-		return fprintf(fp, "typedef ") + __class__fprintf(tag__class(tag_type), cu, &tconf, fp);
+		return fprintf(fp, "typedef ") + __class__fprintf(tag__class(tag_type), cu, &tconf, fp, false);
 	}
 	case DW_TAG_enumeration_type: {
 		struct type *ctype = tag__type(tag_type);
@@ -329,7 +330,7 @@ size_t typedef__fprintf(const struct tag *tag, const struct cu *cu,
 		struct conf_fprintf tconf = *pconf;
 
 		tconf.suffix = type__name(type);
-		return fprintf(fp, "typedef ") + enumeration__fprintf(tag_type, &tconf, fp);
+		return fprintf(fp, "typedef ") + enumeration__fprintf(tag_type, &tconf, fp, false);
 	}
 	}
 
@@ -382,12 +383,16 @@ out:
 	return type->max_tag_name_len;
 }
 
-size_t enumeration__fprintf(const struct tag *tag, const struct conf_fprintf *conf, FILE *fp)
+size_t enumeration__fprintf(const struct tag *tag, const struct conf_fprintf *conf, FILE *fp, bool anonymous)
 {
 	struct type *type = tag__type(tag);
 	struct enumerator *pos;
 	int max_entry_name_len = enumeration__max_entry_name_len(type);
-	size_t printed = fprintf(fp, "enum%s%s {\n", type__name(type) ? " " : "", type__name(type) ?: "");
+	size_t printed = fprintf(fp, "enum%s%s%s%s {\n",
+				 type__name(type) ? " " : "",
+				 type__name(type) && anonymous ? "/* " : "",
+				 type__name(type) ? type__name(type) : "",
+				 type__name(type) && anonymous ? " */" : "");
 	int indent = conf->indent;
 
 	if (indent >= (int)sizeof(tabs))
@@ -622,7 +627,8 @@ static size_t type__fprintf_stats(struct type *type, const struct cu *cu,
 }
 
 static size_t union__fprintf(struct type *type, const struct cu *cu,
-			     const struct conf_fprintf *conf, FILE *fp);
+			     const struct conf_fprintf *conf, FILE *fp,
+			     bool anonymous);
 
 static size_t type__fprintf(struct tag *type, const struct cu *cu,
 			    const char *name, const struct conf_fprintf *conf,
@@ -638,6 +644,7 @@ static size_t type__fprintf(struct tag *type, const struct cu *cu,
 	};
 	size_t printed = 0;
 	int expand_types = conf->expand_types;
+	int inner_anonymous = conf->inner_anonymous;
 	int suppress_offset_comment = conf->suppress_offset_comment;
 
 	if (type == NULL)
@@ -795,7 +802,7 @@ print_default:
 				class__find_holes(cclass);
 
 			tconf.type_spacing -= 8;
-			printed += __class__fprintf(cclass, cu, &tconf, fp);
+			printed += __class__fprintf(cclass, cu, &tconf, fp, inner_anonymous);
 		}
 		break;
 	case DW_TAG_union_type:
@@ -805,7 +812,7 @@ print_default:
 			printed += fprintf(fp, "union %-*s %s", tconf.type_spacing - 6, type__name(ctype), name);
 		} else {
 			tconf.type_spacing -= 8;
-			printed += union__fprintf(ctype, cu, &tconf, fp);
+			printed += union__fprintf(ctype, cu, &tconf, fp, inner_anonymous);
 		}
 		break;
 	case DW_TAG_enumeration_type:
@@ -814,7 +821,7 @@ print_default:
 		if (type__name(ctype) != NULL)
 			printed += fprintf(fp, "enum %-*s %s", tconf.type_spacing - 5, type__name(ctype), name);
 		else
-			printed += enumeration__fprintf(type, &tconf, fp);
+			printed += enumeration__fprintf(type, &tconf, fp, inner_anonymous);
 		break;
 	}
 out:
@@ -968,7 +975,8 @@ static size_t union_member__fprintf(struct class_member *member,
 }
 
 static size_t union__fprintf(struct type *type, const struct cu *cu,
-			     const struct conf_fprintf *conf, FILE *fp)
+			     const struct conf_fprintf *conf, FILE *fp,
+			     bool anonymous)
 {
 	struct class_member *pos;
 	size_t printed = 0;
@@ -982,8 +990,11 @@ static size_t union__fprintf(struct type *type, const struct cu *cu,
 
 	if (conf->prefix != NULL)
 		printed += fprintf(fp, "%s ", conf->prefix);
-	printed += fprintf(fp, "union%s%s {\n", type__name(type) ? " " : "",
-			   type__name(type) ?: "");
+	printed += fprintf(fp, "union%s%s%s%s {\n",
+			   type__name(type) ? " " : "",
+			   type__name(type) && anonymous ? "/* " : "",
+			   type__name(type) ?: "",
+			   type__name(type) && anonymous ? " */" : "");
 
 	uconf = *conf;
 	uconf.indent = indent + 1;
@@ -1341,7 +1352,8 @@ out:
 }
 
 static size_t __class__fprintf(struct class *class, const struct cu *cu,
-			       const struct conf_fprintf *conf, FILE *fp)
+			       const struct conf_fprintf *conf, FILE *fp,
+			       bool anonymous)
 {
 	struct type *type = &class->type;
 	size_t last_size = 0, size;
@@ -1361,14 +1373,16 @@ static size_t __class__fprintf(struct class *class, const struct cu *cu,
 	const char *current_accessibility = NULL;
 	struct conf_fprintf cconf = conf ? *conf : conf_fprintf__defaults;
 	const uint16_t t = type->namespace.tag.tag;
-	size_t printed = fprintf(fp, "%s%s%s%s%s",
+	size_t printed = fprintf(fp, "%s%s%s%s%s%s%s",
 				 cconf.prefix ?: "", cconf.prefix ? " " : "",
 				 ((cconf.classes_as_structs ||
 				   t == DW_TAG_structure_type) ? "struct" :
 				  t == DW_TAG_class_type ? "class" :
 							"interface"),
 				 type__name(type) ? " " : "",
-				 type__name(type) ?: "");
+				 anonymous && type__name(type) ? "/* " : "",
+				 type__name(type) ?: "",
+				 anonymous && type__name(type) ? " */" : "");
 	int indent = cconf.indent;
 
 	if (indent >= (int)sizeof(tabs))
@@ -1785,7 +1799,7 @@ out:
 
 size_t class__fprintf(struct class *class, const struct cu *cu, FILE *fp)
 {
-	return __class__fprintf(class, cu, NULL, fp);
+	return __class__fprintf(class, cu, NULL, fp, false);
 }
 
 static size_t variable__fprintf(const struct tag *tag, const struct cu *cu,
@@ -1872,7 +1886,7 @@ size_t tag__fprintf(struct tag *tag, const struct cu *cu,
 		printed += array_type__fprintf(tag, cu, "array", pconf, fp);
 		break;
 	case DW_TAG_enumeration_type:
-		printed += enumeration__fprintf(tag, pconf, fp);
+		printed += enumeration__fprintf(tag, pconf, fp, false);
 		break;
 	case DW_TAG_typedef:
 		printed += typedef__fprintf(tag, cu, pconf, fp);
@@ -1880,7 +1894,7 @@ size_t tag__fprintf(struct tag *tag, const struct cu *cu,
 	case DW_TAG_class_type:
 	case DW_TAG_interface_type:
 	case DW_TAG_structure_type:
-		printed += __class__fprintf(tag__class(tag), cu, pconf, fp);
+		printed += __class__fprintf(tag__class(tag), cu, pconf, fp, false);
 		break;
 	case DW_TAG_subroutine_type:
 		printed += ftype__fprintf(tag__ftype(tag), cu, NULL, false, false, 0, true, pconf, fp);
@@ -1892,7 +1906,7 @@ size_t tag__fprintf(struct tag *tag, const struct cu *cu,
 		printed += function__fprintf(tag, cu, pconf, fp);
 		break;
 	case DW_TAG_union_type:
-		printed += union__fprintf(tag__type(tag), cu, pconf, fp);
+		printed += union__fprintf(tag__type(tag), cu, pconf, fp, false);
 		break;
 	case DW_TAG_variable:
 		printed += variable__fprintf(tag, cu, pconf, fp);
-- 
2.25.1

