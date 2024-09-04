Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BF41E009E
	for <dwarves@vger.kernel.org>; Wed,  4 Sep 2024 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725468117; cv=none; b=oPzpE87sDi/c8c+tMiHAgmCTLNlM4Ws533s3JrQjOqCz/pMpa03Rgu8wHirpzKRbY4XRL8higDMhMZBdZQmElvvm8/e7DIcPYx9WDsTr2VKTpTPjFQyHAYKEHbMvGMibwjclE4XbOVnDL7ktz086EJfgYcK28YDNSv8IDKLtTAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725468117; c=relaxed/simple;
	bh=3EDFdFVH86RaH0acRsqCAhJ8JbneuG1zEoMJaF8q9Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/stG65leHj7sfivpgXKqCYROGjO1wTtlsODy9EdgweLekbLAFJb8x+RgHVqs0GNormfgfExrmZhZMenGXfNXjfKdL3yoe7mQ52f/PZ7tscr0HeFFuWGQXlyowOKICs6vkZ6mhyDzSII+krAQWWDZyKkW82G/PRk7m4WEmkqxag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr; spf=none smtp.mailfrom=obs.cr; dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b=vaupeGTv; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=obs.cr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="vaupeGTv"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2780827dbafso1672402fac.1
        for <dwarves@vger.kernel.org>; Wed, 04 Sep 2024 09:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1725468115; x=1726072915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jt78rn03s/imu0OOZ99E4O2LOQ/uzcRu+Y80CYYCzK4=;
        b=vaupeGTvg5WzL9igFF/+YoN6q35rHxXi3GZoP4+g6pB12QMNCkV1Rxw9ItErfRNwrc
         PSCFoofGibP3hxxuCkmP0X1l5bn7ndMHivIh/VGC/X0mEh+Yc/7GdEu1lJzIxXEjDw6C
         d02Ebjfz1UhOWCeGp6sQQ8M5EDJnwob9ev6eNKSm65BdL2Sim+9w+1KjWnPCYxgSx0Ec
         hz0NKdMfGqbBlKtpvCfpm+w8yAVfuC895tyiRMYlp/BBt6ynkOOzyBqw9LNhLmZWJ/Qw
         BpK6f09XATYbMBnijoccBoPEZR7d1JPAfaFUKmHwoBvb2Jlf3tR9RRLciNFTebyrBpTB
         dy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725468115; x=1726072915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jt78rn03s/imu0OOZ99E4O2LOQ/uzcRu+Y80CYYCzK4=;
        b=CK6A5y6cDUZYisL7CnSkQZrttIeUP0bk7OO4pFrtro98SdnutwHvmGhUycZ6IclIHl
         kXrS65e1hjAWwAfnxeZ15XhFewoCaiN+t7lRN7MMyhBMZSGU/JPkVkRfWQsn3x+s7mt0
         S5QpdPw1UbGqL5QdLRor0wZOgFM8VjQj0y3y019kz4Ir/NI/IfWiofSl/Dof63pLdToM
         tCJ0VrFuox3DnyZ48PGA1Y14Uqs0xfDR5ZweVr1ef8wVRm9JevL9pPIXdKEEldF/+2Bo
         ByEBs8Bwgeetjq7fUw0CdkJpAXLwlnYydh69iXL7QWbBt51s1rLlH5+5PDbk+syS9JYp
         aQ9A==
X-Gm-Message-State: AOJu0Yz+vaGjf9pzXOtBCtIR8HxOPTs4n5+ATtrDep0UrYjRIC1jDGoU
	Vq55Y+4C1Ed0k+tVJ5J5/XSFXTeADJK9WDDSHjQjw4Pn/yyCUA3LB+W+HvKf9DjKfpPu22WcaOs
	+
X-Google-Smtp-Source: AGHT+IGYtX1T4mEWCG8GrsH8IazVzPEdX0EfUeloQZ0r+3BU4jf5w322/vWP6HqzOYSu3Z+a2S2/aw==
X-Received: by 2002:a05:6871:588:b0:254:bd24:de83 with SMTP id 586e51a60fabf-277d03a4fb5mr18384131fac.12.1725468114838;
        Wed, 04 Sep 2024 09:41:54 -0700 (PDT)
Received: from ininer.rhod.uc.edu ([129.137.96.15])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2e17ba7sm3164954173.77.2024.09.04.09.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 09:41:54 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: dwarves@vger.kernel.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Subject: [PATCH 1/1] dwarves_fprintf: Handle pointer modifiers correctly
Date: Wed,  4 Sep 2024 12:41:45 -0400
Message-ID: <20240904164148.1735624-2-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904164148.1735624-1-hawkinsw@obs.cr>
References: <20240904164148.1735624-1-hawkinsw@obs.cr>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In certain cases, pointer modifiers were attached to the wrong part of a type.

Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
---
 dwarves_fprintf.c | 57 ++++++++++++++---------------------------------
 1 file changed, 17 insertions(+), 40 deletions(-)

diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index 54d2fc2..6f1f997 100644
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
@@ -617,20 +607,30 @@ static const char *__tag__name(const struct tag *tag, const struct cu *cu,
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
+				// If the modifier is addressing a pointer, then we will need
+				// put it after the type that is being printed.
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
+				 							  pconf->no_parm_names ? "" : " ");
 		}
 		break;
 	case DW_TAG_array_type:
@@ -833,8 +833,6 @@ inner_struct:
 		tconf.suppress_offset_comment = suppress_offset_comment;
 	}
 
-	const char *modifier;
-
 next_type:
 	switch (type->tag) {
 	case DW_TAG_pointer_type: {
@@ -870,7 +868,6 @@ next_type:
 		/* Fall Thru */
 	}
 	default:
-print_default:
 		printed += fprintf(fp, "%-*s %s", tconf.type_spacing,
 				   tag__name(type, cu, tbf, sizeof(tbf), &tconf),
 				   name);
@@ -879,26 +876,6 @@ print_default:
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

