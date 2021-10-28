Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2B9C433FE
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 12:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5FA460C40
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 12:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhJ1M3x (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 28 Oct 2021 08:29:53 -0400
Received: from foss.arm.com ([217.140.110.172]:54308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230361AbhJ1M3x (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 28 Oct 2021 08:29:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D778106F;
        Thu, 28 Oct 2021 05:27:26 -0700 (PDT)
Received: from e126130.arm.com (unknown [10.57.46.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A5D813F5A1;
        Thu, 28 Oct 2021 05:27:25 -0700 (PDT)
From:   Douglas RAILLARD <douglas.raillard@arm.com>
To:     acme@redhat.com
Cc:     dwarves@vger.kernel.org, douglas.raillard@arm.com
Subject: [PATCH v3 1/6] fprintf: Fix nested struct printing
Date:   Thu, 28 Oct 2021 13:27:05 +0100
Message-Id: <20211028122710.881181-2-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211028122710.881181-1-douglas.raillard@arm.com>
References: <20211028122710.881181-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

From: Douglas Raillard <douglas.raillard@arm.com>

This code:

    struct X {
       struct {
       } __attribute__((foo)) x __attribute__((bar));
    }

Was wrongly printed as:

    struct X {
       struct {
       } x __attribute__((foo)) __attribute__((bar));
    }

This unfortunately matters a lot, since "bar" is suppose to apply to
"x", but "foo" to typeof(x). In the wrong form, both apply to "x",
leading to e.g. incorrect layout for __aligned__ attribute.

Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
---
 dwarves_fprintf.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index c35868a..1c1d949 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -787,7 +787,7 @@ print_default:
 					   (type->tag == DW_TAG_class_type &&
 					    !tconf.classes_as_structs) ? "class" : "struct",
 					   tconf.type_spacing - 7,
-					   type__name(ctype), name);
+					   type__name(ctype), name ?: "");
 		} else {
 			struct class *cclass = tag__class(type);
 
@@ -802,7 +802,7 @@ print_default:
 		ctype = tag__type(type);
 
 		if (type__name(ctype) != NULL && !expand_types) {
-			printed += fprintf(fp, "union %-*s %s", tconf.type_spacing - 6, type__name(ctype), name);
+			printed += fprintf(fp, "union %-*s %s", tconf.type_spacing - 6, type__name(ctype), name ?: "");
 		} else {
 			tconf.type_spacing -= 8;
 			printed += union__fprintf(ctype, cu, &tconf, fp);
@@ -812,7 +812,7 @@ print_default:
 		ctype = tag__type(type);
 
 		if (type__name(ctype) != NULL)
-			printed += fprintf(fp, "enum %-*s %s", tconf.type_spacing - 5, type__name(ctype), name);
+			printed += fprintf(fp, "enum %-*s %s", tconf.type_spacing - 5, type__name(ctype), name ?: "");
 		else
 			printed += enumeration__fprintf(type, &tconf, fp);
 		break;
@@ -863,7 +863,21 @@ static size_t class_member__fprintf(struct class_member *member, bool union_memb
 	if (member->is_static)
 		printed += fprintf(fp, "static ");
 
-	printed += type__fprintf(type, cu, name, &sconf, fp);
+	/* For struct-like constructs, the name of the member cannot be
+	 * conflated with the name of its type, otherwise __attribute__ are
+	 * printed in the wrong order.
+	 */
+	if (tag__is_union(type) || tag__is_struct(type) ||
+	    tag__is_enumeration(type)) {
+		printed += type__fprintf(type, cu, NULL, &sconf, fp);
+		if (name) {
+			if (!type__name(tag__type(type)))
+				printed += fprintf(fp, " ");
+			printed += fprintf(fp, "%s", name);
+		}
+	} else {
+		printed += type__fprintf(type, cu, name, &sconf, fp);
+	}
 
 	if (member->is_static) {
 		if (member->const_value != 0)
-- 
2.25.1

