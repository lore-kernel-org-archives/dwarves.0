Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837924AC14F
	for <dwarves@vger.kernel.org>; Wed,  2 Sep 2026 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368770; cv=none; b=kdfI6lLrPq/fcV4FAMVLXHHhVuq1Vu7M+l6ly7ycyTdjI1FCzsHSD0Ck4qgKqbsi1dj6QWQ1ep1X6Q7hFBxFYCD9JqyjGMH6GQBe2WPuI5n4r16RFVjv3O1NgYe9fuoE3lw4GugeepgOgOII++usbtuKKWI1+cz2l8hekR3gObc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368770; c=relaxed/simple;
	bh=puXQlvpW8y+orxvY9UI64AQ6p0t2MacZwGF4d/I+Zv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apKTTy/hjJ47yL2xSNjmnEG86ODQPM242PXPoVfabyfZwpSKVDChISO+7inR5Qxr67brrTM4YRXW1zX6utmD5RSl37ChBQ0pu7HkxAaFA9JdevCK/Piu/oJRqm8i4tJN8Ew6Gpe99JrB7OZrihsWW1a/790euYvflVddECxpwV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ql3pJNSl; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ql3pJNSl"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47de0093c42so1429482f8f.3
        for <dwarves@vger.kernel.org>; Wed, 02 Sep 2026 10:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788368767; x=1788973567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yBNsy58T12xGPrX3Bqrptl0P716epeEDMCgphQA9+lo=;
        b=Ql3pJNSlBJsABzs74o7WmS011czHOWDk7N9NiR4uyKS12BXlF/CoctyJqGJDVf/1N4
         2tsvjG8L9vq4zdlEAIENqrP4Cahtck+W9nmq+D3uImwEYZ9lLDsHsKo0Alfv7NgcY/YG
         /O2Fgz/VG1ktBzxuh61P0qAtidK94VYMc75fkvDckg1pa7QfCkGrHTCtXKFHsn0k6vSI
         M59u36lQaD9FVJNZJUadVkNdvwShS2WJ4Oo9MQ1BheyA2j7fL28LLQjbeQHvrra11OqB
         pYc7Q2eu5qcO8NzQox+IGZoY/Uo+BqRzBvWURqjnOD8H5/l+rBWycpJSbK5+l9OnWwbB
         +xEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788368767; x=1788973567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yBNsy58T12xGPrX3Bqrptl0P716epeEDMCgphQA9+lo=;
        b=ObW1p4FbWqatSKwJzLF908GTB5BtqMI6fCoZhx/SabQGW72+v9zEAHA4JAJc9TQNli
         dUJDiX4Z0Foj0Pim+fUK5djOY67fJ8ZlQeXTb9BNWmE+7N36t0LNLzV7m+dmiptzlOQc
         FrkNYqsHochHh/nwJF/m1j3C0sLmSj+pbM0Ps9R+fKkCOGKyj56g3nA/9yRWZiQ6pnPV
         FMw+OYYD8YvV854ys4fTdA9m7QcPPJGBdRVMrOkn4mABRsb2uJGbPl7hjUmOxVyav0v+
         1soX3LQKNYvs9nLiLOE98LrqstjbhRsXLSSYoKrHL4j9ZTMR9+sDDABPYX4yEuHIXqY8
         fxhQ==
X-Forwarded-Encrypted: i=1; AKwUvBz+CA7UIAEWSWhfJvyfpAvCv3p3zcIh19qqVHqgJTngD1GWbl+TA2TWzgCsB/Tfds6VwVgyd7G5@vger.kernel.org
X-Gm-Message-State: AFuF++kJeo6rA/TZHrkSyzzctmtFdOvY4wB9kTrT8NcsyJv+2m032PCn
	b/8+wcZ2qaCIQpZQNZsPnSUuUFg78t30YYjCWiNIXi2GWBQHg0bmh4l4
X-Gm-Gg: AYBFou2NQJy0VevYybDY+cw86QAJadY6mUL+6pd0T/7sa74Ahx+QMCEnea00elTYD09
	nWdmekBZHHB+yVbrEO54ptvQsJ/l4ieCHYAhPMZlbkXOE3HldeZ5RdlL3hpeH+lVUeAlnZEBowg
	xJY41MjYFFFAnLYBiy5qrV1RiTrgz1YGPRs6o6Hqxs9aW9psNyCkYn1AMTLFVjHxnPLD9S6oQny
	gGO+hyFSQe/G/lNgNfG4kZ7ugOLXvkJfcO+agTyPP8ce+hX9/PNXs0WnAEQdvYq5+6vFFBnG4W0
	wShWaIEbbSdo2xt1Ai4XDLu0UKrkR2P6GYwTSOOfGq6CtZI/oNvJvKWrQ/QqCau5Al5XGZ9q6+k
	blCzKBGdlUSYPciCnveweOEJXQM83uGH/BW2UW7abL+W+/EhTs9IAEr214XZRsYQguokGVwNF+Q
	uDJgS+v8NM2ExqSUxrMVE+m1/PB7jpoMHGIiFUY28piNQ9bPPnW3SOap5fwwk0z/gL5xs8Ep9f3
	wV5nkKTuuy1aXE683Jb4ba0nxI7qMZutA/Xc9mJK6udunbF4K/Xe9fhXbO/yfwOJUhUqrd6DK5F
	Jw3E4QphfP/rqTyOewuHE4rEXgFSHDovgGEYbjWNI0mU+Bg=
X-Received: by 2002:a05:6000:40cb:b0:482:e1b0:8a1a with SMTP id ffacd0b85a97d-484913b80e8mr10326324f8f.15.1788368766220;
        Wed, 02 Sep 2026 10:06:06 -0700 (PDT)
Received: from ip-10-0-1-42.eu-west-1.compute.internal (ec2-34-242-91-155.eu-west-1.compute.amazonaws.com. [34.242.91.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484492ce5e5sm7129345f8f.36.2026.09.02.10.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 10:06:05 -0700 (PDT)
From: Aditya Dutt <duttaditya18@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Aditya Dutt <duttaditya18@gmail.com>,
	dwarves@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves v2 2/3] pahole: Don't match unions with --with_flexible_array
Date: Wed,  2 Sep 2026 17:05:57 +0000
Message-ID: <a98ad2b33aecb5b2f4f85201b0ca9553e302dd26.1788368236.git.duttaditya18@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1788368236.git.duttaditya18@gmail.com>
References: <cover.1788368236.git.duttaditya18@gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

C doesn't allow a flexible array member in a union, but
--with_flexible_array prints unions anyway.

  $ cat flex.c
  union wrap_u { int a; long b; };
  union wrap_u u;

  $ pahole --with_flexible_array flex.o
  union wrap_u {
        int                        a;                  /*     0     4 */
        long int                   b;                  /*     0     8 */
  };

--with_embedded_flexible_array doesn't have this problem because its
option handler also sets just_structs.

Add both to the list so neither relies on that side effect.

After:

  $ pahole --with_flexible_array flex.o
  $

Structs with a flexible array are unaffected:

  $ cat has_flex.c
  struct has_flex { int n; char data[]; };
  struct has_flex *p;

  $ pahole --with_flexible_array has_flex.o
  struct has_flex {
        int                        n;                    /*     0     4 */
        char                       data[];               /*     4     0 */

        /* size: 4, cachelines: 1, members: 2 */
        /* last cacheline: 4 bytes */
  };

Signed-off-by: Aditya Dutt <duttaditya18@gmail.com>
---
 pahole.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/pahole.c b/pahole.c
index 7ec4a74..d2dcd90 100644
--- a/pahole.c
+++ b/pahole.c
@@ -734,7 +734,8 @@ static struct class *class__filter(struct class *class, struct cu *cu,
 	 */
 	if (!tag__is_struct(tag))
 		return (just_structs || show_packable || nr_holes || nr_bit_holes || hole_size_ge ||
-			end_padding_ge || end_padding) ? NULL : class;
+			end_padding_ge || end_padding || show_with_flexible_array ||
+			show_with_embedded_flexible_array) ? NULL : class;
 
 	if (tag->top_level)
 		class__find_holes(class);
-- 
2.50.1

