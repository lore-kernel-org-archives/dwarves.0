Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342F338AC7D
	for <dwarves@vger.kernel.org>; Mon, 31 Aug 2026 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788202613; cv=none; b=EAWWpcWZaNkNyrz/8fF7W130pqcWVNjOsr8BOQPPXbGx9X+kt5V2bw3I7Wj8CEnLikof72GH22dnjaKGAqh72tFh3/TTMth7Ap1e+RFLt8BPotypFGe2RfVRsl/hyfb9oRNuKlXzz+qkD8mGH1Gd/Gaax1lYE4MQHtRROnZp9L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788202613; c=relaxed/simple;
	bh=07nEq9WOkCPKVOPG1vokmyBiWBgc6aXoHm1vn0wE518=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z9O99ekdcfAkHw0++Qogq2OLUCVnt7s2H89/tJbxLRWHUWICJa9TUgTWns0Emn701CkeoJK95sNc2BURHfBRW7uR1WWss0TPM281e1x8SEhrWCzqeu7Q+Fp4NTPi54Yyxcso9TWntCsw0A2SdSJfq5pCw5SXqb+LxtiF4BbNzJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q5bgmI6t; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5bgmI6t"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d9201076b3so15898005ad.0
        for <dwarves@vger.kernel.org>; Mon, 31 Aug 2026 11:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788202611; x=1788807411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FvTBQ3ezvfOIDOZor2alrhREZ7/D6dqjvjOb1QXEEtU=;
        b=q5bgmI6tGzCFnZ3Dl7O7qH5Qq8x3alQIdm/+7JqMksm8Zvg8wEgOhtIAO1t2BPHV+U
         SDjJB1RYVgx1GewhizCuGeoEXYKwqNUGbsmGF2XLGVvEHQg5cgcA9KQqD0FYmSuQ2+dV
         31WAJRrNxcoGK4JTsqPd3zjWYm5ra4tRlIPlB9Rw7HjijvZsTlDOb6eFW2pxoI1tJzhQ
         0D1XIfvReegbSTZWMdhwitalfS2BaWA9F2gYwR9lYWsVmhdKJCrPsH9toYDxtTwiC4/C
         O5w/t6K90YLCFTAXDha9E4P3oKFmVnf58a67ITzXtaN5p0JTo3OO43QJpHi6j6pSStz/
         N2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788202611; x=1788807411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FvTBQ3ezvfOIDOZor2alrhREZ7/D6dqjvjOb1QXEEtU=;
        b=dHi7T2usi5OJYtjP8O1ixJsWFcfpsclgFrHoeAasfbCDtYuzj5JtoTjlTO3Rht52vX
         WtEdd4pAfRx7b8UV55IMxBT0BxDq3jtdViGz0GCkjmbAQLC2g+aYhjEvogFqXfvbEwAP
         se9YxPdce3iTR91afeGDiyJflDexYrQev5+63n3P8pPn+W4zekiarJ5JTDIQbNbvtrjz
         g5CYt+I+RPNHOfqEobAsgRJm1i2SvWIJEZnvQ1ExZGvA6e3OCIGxfF3CHDIs71VFK0YT
         FrqWXbJ6Ctttc9ktCxGYKujN/tmAlO9uYbccq4c2myrNPIn2VydEq95sKaEPQItr0OVF
         Sz/Q==
X-Forwarded-Encrypted: i=1; AKwUvBzTJOGmvS3Ctk2ei2GpOcy7nm8D8thz7tcC7rUJdWypOMM7ZQVbGJ294SSqSSKIxMrGqtxVylIX@vger.kernel.org
X-Gm-Message-State: AFuF++nhp35aksXlGK/BAZuUO/Q8fRVPzhMHhq4b4G7/XQxgQFgIpy9h
	wnMvANHmTrY7CEzkgfxmcWf8fklXRHeYSAg6RA45FPTXoHHpsS+G3QU8
X-Gm-Gg: AYBFou0sPrhPrqHFKI/jR0WBOrdMeUhO8Z13snCJ8FzyZx2jDyVZBUjAGSB3/PsAc6z
	lkz+JVn+mBQ6Qasc/myx1szuclrifRv1G5ZhroMbN4vwa/2fK7LXbiOVz2xG9J858SamwD1d2eK
	9KQnza4usCjf7XfkjJC01j4AZ3qKrFAl2XIBsAqIEEI9jvA/5zRMiu6jnuUATXndaecrr4By9m0
	w6YAGyoKL99axXc5J5ZKo9Xy8jNdijCBjKWqfkXsn0GNXf3Ukk6NcbUbN3QiuAoQm+fyyS4R+qR
	4htSCnLmZRhjVaJZR7RzRxJjH/CWhGDwQXf+vqNa3Xz4ZSusts+uK5qLSQcmc0Jwodz8zi7cVvw
	PVthWVoFLctOiPMsCFj9ZaqqTYkxzsCzbPAgiSasOW5FmkieCNkodt79rZyoFdQMuGHfm6ySi/E
	cRCDg5RncDwsno/zVkBWnWBl5LHT/7UXHrbya54cGEOTvxiq34x1hPhGxC5pq/mL4ii6WwZFuhN
	eLdUXK2xDwtnU60R8U=
X-Received: by 2002:a17:902:f688:b0:2d6:fb95:59f0 with SMTP id d9443c01a7336-2d94a75be30mr32551725ad.3.1788202611401;
        Mon, 31 Aug 2026 11:56:51 -0700 (PDT)
Received: from pop-os.. ([103.240.235.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d759640270sm39271965ad.34.2026.08.31.11.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:56:51 -0700 (PDT)
From: Aditya Dutt <duttaditya18@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Aditya Dutt <duttaditya18@gmail.com>,
	dwarves@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves] pahole: --unions shouldn't bypass struct-only options
Date: Tue,  1 Sep 2026 00:26:41 +0530
Message-Id: <20260831185641.971022-1-duttaditya18@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

class__filter() returns early for --unions before the guard for struct
only options. This results in calling functions like
print_packable_info(), which reads c->priv which doesn't exist for
unions.

  $ pahole --unions --packable m
  Segmentation fault (core dumped)

The early return also prevents other struct only option filtering.
                             before             after
  --unions --packable        segfault           (nothing)
  --unions -H 1              union u_named {}   (nothing)
  --unions --bit_holes 1     union u_named {}   (nothing)
  --unions --hole_size_ge 1  u_named            (nothing)
  --unions --padding_ge 1    union u_named {}   (nothing)
  --with_flexible_array      union u_named {}   (nothing)

These don't make sense for a union: all of its members start at offset 0,
so there are no holes to count or pack, C doesn't allow a flexible array
member in one. nr_holes, padding and has_flexible_array only exist in
'struct class', so there is nowhere to keep an answer either.

--with_flexible_array and --with_embedded_flexible_array were missing from the
struct only list, so add them too.

Fixes: 3661f17d0b2cd56b ("pahole: Introduce --unions to consider just unions")
Signed-off-by: Aditya Dutt <duttaditya18@gmail.com>
---

There are a few more CLI bugs and will be sending patches for them
soon: 'pahole -C <type> -T' segfaults etc.

Are there other things related to pahole I can contribute to? I would
also like to help with the Rust support if there is something useful I
can pick up.

 pahole.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/pahole.c b/pahole.c
index a1b3d4a..c7daa31 100644
--- a/pahole.c
+++ b/pahole.c
@@ -462,6 +462,11 @@ static void class_formatter(struct class *class, struct cu *cu, uint32_t id)
 static void print_packable_info(struct class *c, struct cu *cu, uint32_t id)
 {
 	const struct tag *t = class__tag(c);
+
+	/* unions are not packable */
+	if (!tag__is_struct(t))
+		return;
+
 	const size_t orig_size = class__size(c);
 	const size_t new_size = class__size(c->priv);
 	const size_t savings = orig_size - new_size;
@@ -716,12 +721,6 @@ static struct class *class__filter(struct class *class, struct cu *cu,
 	     strncmp(decl_exclude_prefix, tag__decl_file(tag, cu),
 		     decl_exclude_prefix_len) == 0))
 		return NULL;
-	/*
-	 * if --unions was used and we got here, its a union and we satisfy the other
-	 * filters/options, so don't filter it.
-	 */
-	if (just_unions)
-		return class;
 	/*
 	 * The following only make sense for structs, i.e. 'struct class',
 	 * and as we can get here with a union, that is represented by a 'struct type',
@@ -730,7 +729,8 @@ static struct class *class__filter(struct class *class, struct cu *cu,
 	 */
 	if (!tag__is_struct(tag))
 		return (just_structs || show_packable || nr_holes || nr_bit_holes || hole_size_ge ||
-			end_padding_ge || end_padding) ? NULL : class;
+			end_padding_ge || end_padding || show_with_flexible_array ||
+			show_with_embedded_flexible_array) ? NULL : class;
 
 	if (tag->top_level)
 		class__find_holes(class);
-- 
2.34.1

