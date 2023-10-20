Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EFCC2DA
	for <dwarves@vger.kernel.org>; Fri, 20 Oct 2023 03:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIpWxXc1"
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B5DC2
	for <dwarves@vger.kernel.org>; Thu, 19 Oct 2023 20:04:49 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-323168869daso255261f8f.2
        for <dwarves@vger.kernel.org>; Thu, 19 Oct 2023 20:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697771087; x=1698375887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rfFIO7qosZ1v+pC8QqAmqEhlmMSPW1iz1UVomHIwCS4=;
        b=dIpWxXc14AUivsUqysLbpBDfvSxYiOAtfWBP1RLnohT7YwprtyPQCVoXq05Kc/Z+QQ
         KXTuIWT7gymkg2Knzo91pbCUODEWpGxBp+9GjLqlP97bnOMJinGswsnPCnUV7Ud3cWtT
         EcwWP8fCze/gfBJhRlK2P8+PJ7sFWWQP4m+IPSZYZ1SFcFhFoL6ZMTO+O+9WTW7RJL0r
         piusEbVlqXh7kIT29NppYnI6eMvnu2CB8HyN6Uiz/5Z74DC9m/srfXV7LthEiXxdbcgm
         apqCY78CFVpg8bzixvr+71WGOgiD+WlymBWCkMPfhA+NFf7VF4LWPJF13FHU+LUroour
         199Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697771087; x=1698375887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfFIO7qosZ1v+pC8QqAmqEhlmMSPW1iz1UVomHIwCS4=;
        b=ONpC5B5Er4bCRZN+JooybQGjRric7UZQnApJELbpqiH02qC4z/a//u0wXhh/6H0/06
         gPj6jVlPcNFfQnT4huVfb5vihblGQPouKjHihnQ6NJpOE2z2kz7/DIo0epJ72t82hixS
         G5r2eWagFRaZoJK+/BdQ57+AGrxDDPXv1oOrOczQfjvxT2wez5vGk3SQey/EljGiquBp
         rS1HduKp+3oyYmIxC/sDMHKTUEZPX3Zxinm3nrvy8onAEpHCm4p5l+Cd6XnyNIhg4WCo
         lNtbEpfbInynxmrSxCcmuORSzZOQ43c6HfouKPEyAvJq/z8IfA//r3IgblPo5Tql2Pjk
         9Rkg==
X-Gm-Message-State: AOJu0YzeHE1mTUTWdFZg2k2RDx9sKomz2fxqgauhj75B+1wkKn23A/wI
	pQCfaQYH49RiRCVkafWDT5ynOOMV6OcdOg==
X-Google-Smtp-Source: AGHT+IEg92gYka1pANfaT0fkWweU9ilE1qQ4hZICc7mpFVGjvAOiwX9N8vILVfx+gN4mG78iCDdSVQ==
X-Received: by 2002:a05:6000:1f07:b0:32c:837e:ef0 with SMTP id bv7-20020a0560001f0700b0032c837e0ef0mr384088wrb.50.1697771087282;
        Thu, 19 Oct 2023 20:04:47 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:8a0:7280:5801:9441:3dce:686c:bfc7])
        by smtp.gmail.com with ESMTPSA id b17-20020adfee91000000b0031c5e9c2ed7sm654242wro.92.2023.10.19.20.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 20:04:46 -0700 (PDT)
From: Pedro Falcato <pedro.falcato@gmail.com>
To: dwarves@vger.kernel.org
Cc: Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH 1/2] fprintf: Take inherited types' sizes into account when printing
Date: Fri, 20 Oct 2023 04:04:43 +0100
Message-ID: <20231020030444.345871-1-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, any struct/class that inherited a type had a BRAIN FART with
a size difference of exactly the size of the inherited types.

Example:

struct S
{
    unsigned long a;
};

struct S2 : public S
{
    unsigned long b;
};

pahole output:

struct S {
        long unsigned int          a;                    /*     0     8 */

        /* size: 8, cachelines: 1, members: 1 */
        /* last cacheline: 8 bytes */
};
struct S2 : S {
        /* struct S                   <ancestor>; */     /*     0     8 */
        long unsigned int          b;                    /*     8     8 */

        /* size: 16, cachelines: 1, members: 2 */
        /* last cacheline: 16 bytes */

        /* BRAIN FART ALERT! 16 bytes != 8 (member bytes) + 0 (member bits) + 0 (byte holes) + 0 (bit holes), diff = 64 bits */
};

Take those into account.

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 dwarves_fprintf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index ef8b82b..5c2d14d 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -1735,9 +1735,6 @@ static size_t __class__fprintf(struct class *class, const struct cu *cu,
 		fputc('\n', fp);
 		++printed;
 
-		/* XXX for now just skip these */
-		if (tag_pos->tag == DW_TAG_inheritance)
-			continue;
 #if 0
 		/*
  		 * This one was being skipped but caused problems with:
-- 
2.42.0

