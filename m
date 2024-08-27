Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772A025634
	for <dwarves@vger.kernel.org>; Tue, 27 Aug 2024 04:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724731756; cv=none; b=T2LROglM9clCkz/8I6S258SimpSj8S8yigjcaNScU03NreDngP3lYpcSHzMjq84ukCH5WSaFbqbxn3XV/9SnqLFi6v004SdRbGPhW4CPlz0KICoq0eQ5aP4Z40K1qeKkLaU9x3OA1XjhPH/qgsJJjXfi94JsGyMXTOkflvJCtI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724731756; c=relaxed/simple;
	bh=EW4nbvueodb/p6TCwsHRH8CLYNjJ+f/ilocygC6fEIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJibddV+nuiPv0tM4OZHHA1WZiUQlOWhq86Qf9SEL9mw7hurWcBfXu8ldNtoSUz3X591xHSac3jthGcjEutA5ahXDxXI49YogjZso/HSNA6npiZ0OShJFGgXUl4XHsR1CPJbP5r7UuW7+4U0A3kEMNJfrw9mheH4NKKBwVTMqRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr; spf=none smtp.mailfrom=obs.cr; dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b=esGH8XE0; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=obs.cr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="esGH8XE0"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-39d4161c398so20956205ab.3
        for <dwarves@vger.kernel.org>; Mon, 26 Aug 2024 21:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1724731753; x=1725336553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNeZsgdkNl+jLW/+SISm1aAhv61RBhLblWEVOlvCJqA=;
        b=esGH8XE0vUOploZSKUHflqAj9VlC4h+lmh+s3wq1B8ELwWqEUnaEk9siu2h0B4iFiO
         XK9lGbjTe/Sd7Fe+OLl2MYyygTycFtTAdYRf9TWI0Y0l5YngWko8X76APAJAW3KvSNCE
         re9EAIh0EscJ7RNLIqXy8cEgdAmBsUOzdaUOzdFyXY82T8mEVW1VyXl1f5zUoqZB4Tk/
         fZ2+cEO2YPiPu4s8YeZdzFzIuaQxCpgMpppMGzof/X/TZQYC7VXH/3qosAYkEkvx9xg6
         UpBpBMEQe9nlv2LhVkcq2owHEwCfiliuKWQxKj3AowmE5F7JL6ZLEM8mHhqRIMZBnIoC
         qa4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724731753; x=1725336553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNeZsgdkNl+jLW/+SISm1aAhv61RBhLblWEVOlvCJqA=;
        b=O1C0V2ohM8oGuEcA86/BDg3F6qcLPn9wTLVZ+lvvpvWSWwKlqAg08/NPo3qGXkgb1K
         BTL+bsf/YFGBRTtsGNHzaYK1CVmZwF0far0D6G9HQVtYaX/uZaGd1Cva3KawvZKCFz2X
         u/k7Jbf8hxpEuwHP0BtmWx8I8AHh1kbFGL7lnum3gTTE9yc8zFRaDcMnLTukdR4wbtxp
         gzG8KIWBWyOC3z//0pCH9Rivv/zHjLDUcYK37ESqOk5oAUbZoaaXkPC9iborrKt3qIna
         uLR5fEVxk877dIiWInwh1zcwwFa3sxn13cEKsWHoUALTHmntX8zXdMbLQofJRgKyIqcd
         7DkQ==
X-Gm-Message-State: AOJu0YwspMaRuIMpBN7h5oNmUsfIOErZyTJx63Dt1Kk3qvd8sktRIiRa
	4JRmPZdKP+G0gW7iStgCErdyO/mv3kDcyG4muMjztkyj+mvVQfVMVLilKg8OJVMzdBBVI/423Hh
	D
X-Google-Smtp-Source: AGHT+IE7MAwH2j0SAb2r4mjlaebfgJyIb0N4jUd13BW0WTCU4rJjqT8Tuy5EtqbDkSd9N/GibrX+bg==
X-Received: by 2002:a05:6e02:1a8f:b0:39d:4976:6772 with SMTP id e9e14a558f8ab-39e63ed6e5bmr20828455ab.23.1724731753243;
        Mon, 26 Aug 2024 21:09:13 -0700 (PDT)
Received: from ininer.rhod.uc.edu ([129.137.96.15])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39d73e68e55sm37262255ab.6.2024.08.26.21.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 21:09:13 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: dwarves@vger.kernel.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Subject: [PATCH v2 1/1] btf_loader: Support linkages for BTF subprograms
Date: Tue, 27 Aug 2024 00:09:08 -0400
Message-ID: <20240827040909.1358861-2-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240823212835.1078351-1-hawkinsw@obs.cr>
References: <20240823212835.1078351-1-hawkinsw@obs.cr>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle static and external linkage for BTF subprograms (functions).

Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
---
 btf_loader.c |  4 +++-
 dwarves.h    |  2 +-
 pfunct.c     | 15 ++++++++++++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/btf_loader.c b/btf_loader.c
index e0d029a..16962f9 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -85,8 +85,10 @@ static int create_new_function(struct cu *cu, const struct btf_type *tp, uint32_
 		return -ENOMEM;
 
 	// for BTF this is not really the type of the return of the function,
-	// but the prototype, the return type is the one in type_id
+	// but the prototype, the return type is the one in type_id.
 	func->btf = 1;
+	func->declaration = BTF_INFO_VLEN(tp->info) == BTF_FUNC_EXTERN;
+	func->external = BTF_INFO_VLEN(tp->info) == BTF_FUNC_GLOBAL;
 	func->proto.tag.tag = DW_TAG_subprogram;
 	func->proto.tag.type = tp->type;
 	func->name = cu__btf_str(cu, tp->name_off);
diff --git a/dwarves.h b/dwarves.h
index f5ae79f..c6d2b63 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -983,7 +983,7 @@ struct function {
 	uint16_t	 cu_total_nr_inline_expansions;
 	uint8_t		 inlined:2;
 	uint8_t		 abstract_origin:1;
-	uint8_t		 external:1;
+	uint8_t		 external:1; /* DW_AT_external */
 	uint8_t		 accessibility:2; /* DW_ACCESS_{public,protected,private} */
 	uint8_t		 virtuality:2; /* DW_VIRTUALITY_{none,virtual,pure_virtual} */
 	uint8_t		 declaration:1;
diff --git a/pfunct.c b/pfunct.c
index 938dd72..725cc2e 100644
--- a/pfunct.c
+++ b/pfunct.c
@@ -366,9 +366,22 @@ static void function__show(struct function *func, struct cu *cu)
 {
 	struct tag *tag = function__tag(func);
 
-	if (func->abstract_origin || func->external)
+	if (func->abstract_origin)
 		return;
 
+	// If this function is more than a declaration, then be
+	// explicit about its linkage. For dwarf, external comes
+	// from DW_AT_external which, when combined with whether
+	// the DIE represents a defined subprogram, determines
+	// the linkage. BTF maintains these semantics when it reads
+	// type information.
+	if (!func->declaration) {
+		if (func->external)
+			fprintf(stdout, "extern ");
+		else
+			fprintf(stdout, "static ");
+	}
+
 	if (expand_types)
 		function__emit_type_definitions(func, cu, stdout);
 	tag__fprintf(tag, cu, &conf, stdout);
-- 
2.45.2

