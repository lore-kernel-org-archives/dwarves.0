Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D73DC433EF
	for <linux-dwarves@archiver.kernel.org>; Tue,  7 Dec 2021 17:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbhLGRfO (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 7 Dec 2021 12:35:14 -0500
Received: from foss.arm.com ([217.140.110.172]:37290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhLGRfN (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Tue, 7 Dec 2021 12:35:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C75911D4;
        Tue,  7 Dec 2021 09:31:43 -0800 (PST)
Received: from e126130.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 52AFF3F73B;
        Tue,  7 Dec 2021 09:31:42 -0800 (PST)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     acme@redhat.com
Cc:     dwarves@vger.kernel.org, douglas.raillard@arm.com
Subject: [PATCH v2 1/6] Revert "fprintf: Allow making struct/enum/union anonymous"
Date:   Tue,  7 Dec 2021 17:31:46 +0000
Message-Id: <20211207173151.2283946-2-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207173151.2283946-1-douglas.raillard@arm.com>
References: <20211207173151.2283946-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

From: Douglas Raillard <douglas.raillard@arm.com>

This reverts commit 7c5e35b63bd26f1de0a22acb6319bf2b1a4166c1.

Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
---
 dwarves.h         |  4 +---
 dwarves_emit.c    |  2 +-
 dwarves_fprintf.c | 52 +++++++++++++++++------------------------------
 3 files changed, 21 insertions(+), 37 deletions(-)

diff --git a/dwarves.h b/dwarves.h
index 2fbeac3..52d162d 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -105,7 +105,6 @@ struct conf_fprintf {
 	uint8_t	   indent;
 	uint8_t	   expand_types:1;
 	uint8_t	   expand_pointers:1;
-	uint8_t	   inner_anonymous:1;
 	uint8_t    rel_offset:1;
 	uint8_t	   emit_stats:1;
 	uint8_t	   suppress_comments:1;
@@ -1372,8 +1371,7 @@ static inline const char *enumerator__name(const struct enumerator *enumerator)
 void enumeration__delete(struct type *type);
 void enumeration__add(struct type *type, struct enumerator *enumerator);
 size_t enumeration__fprintf(const struct tag *tag_enum,
-			    const struct conf_fprintf *conf, FILE *fp,
-			    bool anonymous);
+			    const struct conf_fprintf *conf, FILE *fp);
 
 int dwarves__init(void);
 void dwarves__exit(void);
diff --git a/dwarves_emit.c b/dwarves_emit.c
index 5c67559..5bf7946 100644
--- a/dwarves_emit.c
+++ b/dwarves_emit.c
@@ -91,7 +91,7 @@ static int enumeration__emit_definitions(struct tag *tag,
 		return 0;
 	}
 
-	enumeration__fprintf(tag, conf, fp, false);
+	enumeration__fprintf(tag, conf, fp);
 	fputs(";\n", fp);
 	type_emissions__add_definition(emissions, etype);
 	return 1;
diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index ecb6c7f..c5921d7 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -198,8 +198,7 @@ size_t tag__fprintf_decl_info(const struct tag *tag,
 }
 
 static size_t __class__fprintf(struct class *class, const struct cu *cu,
-			       const struct conf_fprintf *conf, FILE *fp,
-			       bool anonymous);
+			       const struct conf_fprintf *conf, FILE *fp);
 static size_t type__fprintf(struct tag *type, const struct cu *cu,
 			    const char *name, const struct conf_fprintf *conf,
 			    FILE *fp);
@@ -331,7 +330,7 @@ size_t typedef__fprintf(const struct tag *tag, const struct cu *cu,
 		struct conf_fprintf tconf = *pconf;
 
 		tconf.suffix = type__name(type);
-		return fprintf(fp, "typedef ") + __class__fprintf(tag__class(tag_type), cu, &tconf, fp, false);
+		return fprintf(fp, "typedef ") + __class__fprintf(tag__class(tag_type), cu, &tconf, fp);
 	}
 	case DW_TAG_enumeration_type: {
 		struct type *ctype = tag__type(tag_type);
@@ -342,7 +341,7 @@ size_t typedef__fprintf(const struct tag *tag, const struct cu *cu,
 		struct conf_fprintf tconf = *pconf;
 
 		tconf.suffix = type__name(type);
-		return fprintf(fp, "typedef ") + enumeration__fprintf(tag_type, &tconf, fp, false);
+		return fprintf(fp, "typedef ") + enumeration__fprintf(tag_type, &tconf, fp);
 	}
 	}
 
@@ -395,16 +394,12 @@ out:
 	return type->max_tag_name_len;
 }
 
-size_t enumeration__fprintf(const struct tag *tag, const struct conf_fprintf *conf, FILE *fp, bool anonymous)
+size_t enumeration__fprintf(const struct tag *tag, const struct conf_fprintf *conf, FILE *fp)
 {
 	struct type *type = tag__type(tag);
 	struct enumerator *pos;
 	int max_entry_name_len = enumeration__max_entry_name_len(type);
-	size_t printed = fprintf(fp, "enum%s%s%s%s {\n",
-				 type__name(type) ? " " : "",
-				 type__name(type) && anonymous ? "/* " : "",
-				 type__name(type) ? type__name(type) : "",
-				 type__name(type) && anonymous ? " */" : "");
+	size_t printed = fprintf(fp, "enum%s%s {\n", type__name(type) ? " " : "", type__name(type) ?: "");
 	int indent = conf->indent;
 
 	if (indent >= (int)sizeof(tabs))
@@ -639,8 +634,7 @@ static size_t type__fprintf_stats(struct type *type, const struct cu *cu,
 }
 
 static size_t union__fprintf(struct type *type, const struct cu *cu,
-			     const struct conf_fprintf *conf, FILE *fp,
-			     bool anonymous);
+			     const struct conf_fprintf *conf, FILE *fp);
 
 static size_t type__fprintf(struct tag *type, const struct cu *cu,
 			    const char *name, const struct conf_fprintf *conf,
@@ -656,7 +650,6 @@ static size_t type__fprintf(struct tag *type, const struct cu *cu,
 	};
 	size_t printed = 0;
 	int expand_types = conf->expand_types;
-	int inner_anonymous = conf->inner_anonymous;
 	int suppress_offset_comment = conf->suppress_offset_comment;
 
 	if (type == NULL)
@@ -814,7 +807,7 @@ print_default:
 				class__find_holes(cclass);
 
 			tconf.type_spacing -= 8;
-			printed += __class__fprintf(cclass, cu, &tconf, fp, inner_anonymous);
+			printed += __class__fprintf(cclass, cu, &tconf, fp);
 		}
 		break;
 	case DW_TAG_union_type:
@@ -824,7 +817,7 @@ print_default:
 			printed += fprintf(fp, "union %-*s %s", tconf.type_spacing - 6, type__name(ctype), name ?: "");
 		} else {
 			tconf.type_spacing -= 8;
-			printed += union__fprintf(ctype, cu, &tconf, fp, inner_anonymous);
+			printed += union__fprintf(ctype, cu, &tconf, fp);
 		}
 		break;
 	case DW_TAG_enumeration_type:
@@ -833,7 +826,7 @@ print_default:
 		if (type__name(ctype) != NULL)
 			printed += fprintf(fp, "enum %-*s %s", tconf.type_spacing - 5, type__name(ctype), name ?: "");
 		else
-			printed += enumeration__fprintf(type, &tconf, fp, inner_anonymous);
+			printed += enumeration__fprintf(type, &tconf, fp);
 		break;
 	}
 out:
@@ -998,8 +991,7 @@ static size_t union_member__fprintf(struct class_member *member,
 }
 
 static size_t union__fprintf(struct type *type, const struct cu *cu,
-			     const struct conf_fprintf *conf, FILE *fp,
-			     bool anonymous)
+			     const struct conf_fprintf *conf, FILE *fp)
 {
 	struct class_member *pos;
 	size_t printed = 0;
@@ -1013,11 +1005,8 @@ static size_t union__fprintf(struct type *type, const struct cu *cu,
 
 	if (conf->prefix != NULL)
 		printed += fprintf(fp, "%s ", conf->prefix);
-	printed += fprintf(fp, "union%s%s%s%s {\n",
-			   type__name(type) ? " " : "",
-			   type__name(type) && anonymous ? "/* " : "",
-			   type__name(type) ?: "",
-			   type__name(type) && anonymous ? " */" : "");
+	printed += fprintf(fp, "union%s%s {\n", type__name(type) ? " " : "",
+			   type__name(type) ?: "");
 
 	uconf = *conf;
 	uconf.indent = indent + 1;
@@ -1375,8 +1364,7 @@ out:
 }
 
 static size_t __class__fprintf(struct class *class, const struct cu *cu,
-			       const struct conf_fprintf *conf, FILE *fp,
-			       bool anonymous)
+			       const struct conf_fprintf *conf, FILE *fp)
 {
 	struct type *type = &class->type;
 	size_t last_size = 0, size;
@@ -1396,16 +1384,14 @@ static size_t __class__fprintf(struct class *class, const struct cu *cu,
 	const char *current_accessibility = NULL;
 	struct conf_fprintf cconf = conf ? *conf : conf_fprintf__defaults;
 	const uint16_t t = type->namespace.tag.tag;
-	size_t printed = fprintf(fp, "%s%s%s%s%s%s%s",
+	size_t printed = fprintf(fp, "%s%s%s%s%s",
 				 cconf.prefix ?: "", cconf.prefix ? " " : "",
 				 ((cconf.classes_as_structs ||
 				   t == DW_TAG_structure_type) ? "struct" :
 				  t == DW_TAG_class_type ? "class" :
 							"interface"),
 				 type__name(type) ? " " : "",
-				 anonymous && type__name(type) ? "/* " : "",
-				 type__name(type) ?: "",
-				 anonymous && type__name(type) ? " */" : "");
+				 type__name(type) ?: "");
 	int indent = cconf.indent;
 
 	if (indent >= (int)sizeof(tabs))
@@ -1822,7 +1808,7 @@ out:
 
 size_t class__fprintf(struct class *class, const struct cu *cu, FILE *fp)
 {
-	return __class__fprintf(class, cu, NULL, fp, false);
+	return __class__fprintf(class, cu, NULL, fp);
 }
 
 static size_t variable__fprintf(const struct tag *tag, const struct cu *cu,
@@ -1909,7 +1895,7 @@ size_t tag__fprintf(struct tag *tag, const struct cu *cu,
 		printed += array_type__fprintf(tag, cu, "array", pconf, fp);
 		break;
 	case DW_TAG_enumeration_type:
-		printed += enumeration__fprintf(tag, pconf, fp, false);
+		printed += enumeration__fprintf(tag, pconf, fp);
 		break;
 	case DW_TAG_typedef:
 		printed += typedef__fprintf(tag, cu, pconf, fp);
@@ -1917,7 +1903,7 @@ size_t tag__fprintf(struct tag *tag, const struct cu *cu,
 	case DW_TAG_class_type:
 	case DW_TAG_interface_type:
 	case DW_TAG_structure_type:
-		printed += __class__fprintf(tag__class(tag), cu, pconf, fp, false);
+		printed += __class__fprintf(tag__class(tag), cu, pconf, fp);
 		break;
 	case DW_TAG_subroutine_type:
 		printed += ftype__fprintf(tag__ftype(tag), cu, NULL, false, false, 0, true, pconf, fp);
@@ -1929,7 +1915,7 @@ size_t tag__fprintf(struct tag *tag, const struct cu *cu,
 		printed += function__fprintf(tag, cu, pconf, fp);
 		break;
 	case DW_TAG_union_type:
-		printed += union__fprintf(tag__type(tag), cu, pconf, fp, false);
+		printed += union__fprintf(tag__type(tag), cu, pconf, fp);
 		break;
 	case DW_TAG_variable:
 		printed += variable__fprintf(tag, cu, pconf, fp);
-- 
2.25.1

