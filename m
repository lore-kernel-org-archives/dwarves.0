Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AFD1097B
	for <dwarves@vger.kernel.org>; Thu, 19 Sep 2024 03:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726716674; cv=none; b=R7swq9s/3oouLCh+zbJBqMo+VtrA11ZQl9v9ByH7ASWTMSd4RXsvkPfkNf7V43FbBDHISmQ3Fxp7Da6wbV6UhCAER+U+ReUt5TsNX6GACsanwhPg6fqow1aTaBSIs8InQH1gsl3IULW1wMWsGpQypSQIzl9D1qv33Qk4HZ8oGCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726716674; c=relaxed/simple;
	bh=pax/jOQl9X7xAZuONs/s2eke7vx4uW1/6QokRrCm2Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXNGcN7MmnhocNc+kkRciKWMBgAfEklriG62FfdCq1Sw80PjJ2xQxLfS8svX+egMwdsgeMUjQPowh99aY4bu5X8uPatqEsvAkBqMc0Xgmpl1RG3zamAFdozOw9qZ5Ly4pQks8uyxIcMoQbJqXTCBHhMMd3bRdiPtZjtl1k1lFQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr; spf=none smtp.mailfrom=obs.cr; dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b=ai1Q71uY; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=obs.cr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="ai1Q71uY"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-82cd872755dso23293539f.1
        for <dwarves@vger.kernel.org>; Wed, 18 Sep 2024 20:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1726716672; x=1727321472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KoRcFempdG51ohDmiB9ScQEMbzmYkhWq720v1ndl7kY=;
        b=ai1Q71uYOXBe1ymyPI1aJBG0WfZ2c/QkE5VO2fUsHildY/1+cVnrf+BpLhypVjJrrI
         apalRnL78jXr/OPzsQiUMqs8v+oOovfuhguwm7sYYySvtCIs7BI7GErIRZyDff93z1+k
         pi414Rw7trMsesxQfMgnEmzcALJYxV3CdcDJrT1h0YHm2RBOmzIZ/aDq/dvRtX7h1lJG
         vtWXXj+8U7UJGrjQiL8sNXVbZwJpsZJV2a+kfM7TNCkVe7o/LlpCaFMwLTJyvV8IyF0V
         O9KlZpmNB9lMZdjBhllCdIUQEgdiitAFhlcvZlCkVR7w1m18fOmLJESovA04DXMQd5kw
         D5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726716672; x=1727321472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KoRcFempdG51ohDmiB9ScQEMbzmYkhWq720v1ndl7kY=;
        b=mzAZraVmcICz8THWHl8wiHLqHKuAMuxv4YW2TqgbsiEn+DQl6hFGpbZyNPz+LGCVnK
         mowr/bDLYHSl0DguHnYo70zwaHG1WoJshfF91hdmHG+Y0X5PuYuuvh3RrkkViH/IYht5
         P/pbgZ2hxTv+oCpybLiWq6HlrILjo/ZaWgdch2jgJeTo1DGrAbqAUAgeFh9pIAdf6hyP
         qOkrPbVh83Vb61aWeKdLlMlondlXmQG0JNWqjdG0xSiv04NxBrFWUI5SeJC0ZS8qPYRZ
         EbMJnY3vzaVfNldkTYa68DQ4/YYyARJY/gbFvl0r0xmrm3DULxBBESGJIrBzwozhATPu
         WCLw==
X-Gm-Message-State: AOJu0YzAzcL7CtY3gPg/SgJHldbOEzcjmSMPZoWi0ZQQ/BQfCF1oX0sz
	jD3BUIkjwF5tl4SWRNv7LDR1xKun8BklRNcrnSjvyb/hm1BQfB/aktsL+wpJN4t0lZeRd7wtmsw
	P
X-Google-Smtp-Source: AGHT+IEj5eudPxxa5/VlWCemqwa5cWKY/LzvIyUMw+dBboms5ma8IY/uaDnoTN4WFC9L9L0lBO8UcA==
X-Received: by 2002:a05:6602:608b:b0:82d:6a:4cae with SMTP id ca18e2360f4ac-831830edbd1mr817076639f.3.1726716671592;
        Wed, 18 Sep 2024 20:31:11 -0700 (PDT)
Received: from ininer.rhod.uc.edu ([129.137.96.15])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82d4928d686sm298513239f.18.2024.09.18.20.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 20:31:11 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: dwarves@vger.kernel.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Subject: [PATCH 1/1 v2] dwarves_fprintf: Handle pointer qualifiers correctly
Date: Wed, 18 Sep 2024 23:30:52 -0400
Message-ID: <20240919033057.2658569-2-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <4f09aa78-8a42-44dd-a685-37d6b9db7415@oracle.com>
References: <4f09aa78-8a42-44dd-a685-37d6b9db7415@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In certain cases, type qualifiers were attached to the wrong part
of a type.

In C-like languages, a basic variable declaration can be augmented
with certain _qualifiers_. Qualifiers are used in declarations by the
programmer to specify additional properties about the type being
declared. When it comes to applying qualifiers to pointer types,
placement can sometimes be tricky.

Because of the hierarchical nature of type encoding in both BTF and
DWARF, the representation of such confusing types is more natural.

For example
volatile -> ptr -> const -> int
is the "chained" list of types that will exist (with a few minor
differences between the formats) for BTF and DWARF to encode a
volatile pointer to a constant int.

To display types like these correctly, the modifier that applies
to the pointer must be a suffix modifier printed after the pointer,
and the modifier that applies to the pointer target must be printed
before the pointer.

This patch teaches the dwarves family of programs to print qualified
pointer types correctly.

Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
---

Notes:
            v1 -> v2:
                    Add additional comments inline.
                    Properly format comments using /**/.
                    Be more verbose in the commit message.

 dwarves_fprintf.c | 90 ++++++++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 40 deletions(-)

diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index 54d2fc2..2c53638 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -542,16 +542,6 @@ static const char *tag__ptr_name(const struct tag *tag, const struct cu *cu,
 			char tmpbf[1024];
 			const char *const_pointer = "";
 
-			if (tag__is_const(type)) {
-				struct tag *next_type = cu__type(cu, type->type);
-
-				if (next_type && tag__is_pointer(next_type)) {
-					if (!(conf && conf->skip_emitting_modifier))
-						const_pointer = "const ";
-					type = next_type;
-				}
-			}
-
 			snprintf(bf, len, "%s %s%s",
 				 __tag__name(type, cu,
 					     tmpbf, sizeof(tmpbf), conf),
@@ -612,25 +602,68 @@ static const char *__tag__name(const struct tag *tag, const struct cu *cu,
 	case DW_TAG_restrict_type:
 	case DW_TAG_atomic_type:
 	case DW_TAG_unspecified_type:
+		/*
+		* In C-like languages, a basic variable declaration can be augmented
+		* with certain _qualifiers_. In C++, the standard refers to them as
+		* cv-qualifiers (decl.type.cv). In C, the standard refers to them as
+		* type qualifiers (6.7.3). Qualifiers are used in declarations by the
+		* programmer to specify additional properties about the type being
+		* declared. When it comes to applying qualifiers to pointer types,
+		* placement can sometimes be tricky.
+		* Example 1: "const int * foo": The target of the pointer is const.
+		* Example 2: "const int * volatile foo" means that the target of the
+		* pointer is const * ("const int *") _and_ the pointer itself (volatile
+		* foo) is volatile.
+		* Example 3: "volatile int * volatile foo" means that both the target
+		* of foo _and_ the pointer itself are volatile.
+		*
+		* Note: cdecl(1) is a fun command-line tool for helping decode the
+		* meaning of these complicated type signatures.
+		*
+		* Because of the hierarchical nature of type encoding in both BTF and
+		* DWARF, the representation of such confusing types is more natural.
+		* For example
+		*
+		* volatile -> ptr -> const -> int
+		*
+		* is the "chained" list of types that will exist (with a few minor
+		* differences between the formats) for BTF and DWARF to encode a
+		* volatile pointer to a constant int. To display types like these
+		* correctly, the modifier that applies to the pointer must be a
+		* suffix modifier printed after the pointer, and the modifier that
+		* applies to the pointer target must be printed before the pointer.
+		*/
 		type = cu__type(cu, tag->type);
 		if (type == NULL && tag->type != 0)
 			tag__id_not_found_snprintf(bf, len, tag->type);
 		else if (!tag__has_type_loop(tag, type, bf, len, NULL)) {
 			char tmpbf[128];
-			const char *prefix = "", *suffix = "",
+			const char *prefix_modifier = NULL, *suffix_modifier = NULL,
 				   *type_str = __tag__name(type, cu, tmpbf,
 							   sizeof(tmpbf),
 							   pconf);
 			if (!pconf->skip_emitting_modifier) {
+				const char **modifier = &prefix_modifier;
+
+				/* If the modifier is addressing a pointer, then we will need
+				 * put it after the type that is being printed.
+				 */
+				if (tag__is_pointer(type))
+					modifier = &suffix_modifier;
+
 				switch (tag->tag) {
-				case DW_TAG_volatile_type: prefix = "volatile "; break;
-				case DW_TAG_const_type: prefix = "const "; break;
-				case DW_TAG_restrict_type: suffix = " restrict"; break;
-				case DW_TAG_atomic_type:   prefix = "_Atomic ";  break;
+				case DW_TAG_volatile_type: *modifier = "volatile"; break;
+				case DW_TAG_const_type: *modifier = "const"; break;
+				case DW_TAG_restrict_type: suffix_modifier = " restrict"; break;
+				case DW_TAG_atomic_type:   *modifier = "_Atomic";  break;
 				}
 			}
-			snprintf(bf, len, "%s%s%s%s", prefix, type_str, suffix,
-				 pconf->no_parm_names ? "" : " ");
+			snprintf(bf, len, "%s%s%s%s%s%s", prefix_modifier ? prefix_modifier : "",
+											  prefix_modifier ? " " : "",
+											  type_str,
+											  suffix_modifier ? " " : "",
+											  suffix_modifier ? suffix_modifier : "",
+											  pconf->no_parm_names ? "" : " ");
 		}
 		break;
 	case DW_TAG_array_type:
@@ -833,8 +866,6 @@ inner_struct:
 		tconf.suppress_offset_comment = suppress_offset_comment;
 	}
 
-	const char *modifier;
-
 next_type:
 	switch (type->tag) {
 	case DW_TAG_pointer_type: {
@@ -870,7 +901,6 @@ next_type:
 		/* Fall Thru */
 	}
 	default:
-print_default:
 		printed += fprintf(fp, "%-*s %s", tconf.type_spacing,
 				   tag__name(type, cu, tbf, sizeof(tbf), &tconf),
 				   name);
@@ -879,26 +909,6 @@ print_default:
 		printed += ftype__fprintf(tag__ftype(type), cu, name, 0, 0,
 					  tconf.type_spacing, true, &tconf, fp);
 		break;
-	case DW_TAG_atomic_type:
-		modifier = "_Atomic";
-		goto print_modifier;
-	case DW_TAG_const_type:
-		modifier = "const";
-print_modifier: {
-		if (!conf->skip_emitting_modifier) {
-			size_t modifier_printed = fprintf(fp, "%s ", modifier);
-			tconf.type_spacing -= modifier_printed;
-			printed		   += modifier_printed;
-		}
-
-		struct tag *ttype = cu__type(cu, type->type);
-		if (ttype) {
-			type = ttype;
-			goto next_type;
-		}
-	}
-		goto print_default;
-
 	case DW_TAG_array_type:
 		printed += array_type__fprintf(type, cu, name, &tconf, fp);
 		break;
-- 
2.45.2

