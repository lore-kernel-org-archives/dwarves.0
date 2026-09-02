Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C944AC14F
	for <dwarves@vger.kernel.org>; Wed,  2 Sep 2026 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368771; cv=none; b=rtsBrVH9nPeLdYB3teyLS29KMHuruoespkkh0+57QH1hg217vtw1M/mScsH3Nrqu/AYQmVsZ9O6RaMMI1sVOPAhjUjC5ujF2nw9Fj6OUi6py/YSQBerCOTgwGyHYf4hico6OjQulJmj1OcPrBbDUYJEuVs+IrMzwLUk93w/LcDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368771; c=relaxed/simple;
	bh=iVFE77rlImjhCUJacr+kMy/69T8kpBxWqtGs9x0XG14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2n7G3bhjn/okl4KdAI1ADi9dMMDDc1G8rMlBaSHxzW8RvmGc0ceXIBSGYoOvRpJArZ4GLaiWfUe3NP5VL0c4kyy3Y/D22iXXkKiw5FA6UOtj5ITi6X14yt9qbhwRn+p7mOxUrkFfsJmXIFOr6puuLU/Qh93Jg2f8MloEX4HF0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BV4khudG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BV4khudG"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47de0093c42so1429522f8f.3
        for <dwarves@vger.kernel.org>; Wed, 02 Sep 2026 10:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788368768; x=1788973568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VwN2ruwcRbTrfAsEBhXkvrqhERlnNXQxO++5rFPPsEQ=;
        b=BV4khudGIKMroTqDPgN1hFstGQfqL3wEM7k/y6U0956uuvm2xPVaiBCZhFghHfJMas
         j8Riz4EgG8qDjEahqojUhnNLzIhrdKJ/rVwj5c8Z4A4afcRzPcVLNpUsa4J+i29Oxtni
         fE35WDzx+V5gYK0ae+pysFO2fnpt4U+Fy2Kwq9G/9sI6dSbKVHw04W46JswiYmtd8Rb9
         Q4qhDDg41OwwWCuGepuOovKJrhpPMB3M9Hzo5R10c2BMZMrFPi19iPD1HVEdooW5AiQ0
         CRaK5Idy3DZPaJb88YqHKQ5ZXrCrdzgExFNKRxIyXpTMm/BmgF2T0A7Ql6hrB8Bymvl0
         N63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788368768; x=1788973568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VwN2ruwcRbTrfAsEBhXkvrqhERlnNXQxO++5rFPPsEQ=;
        b=V/fwRGwkr6bJoMq51IiDTY+eRP8S0AtszcGbHvwqXQXP+peHlUcLsODcFE4ZmTyXtk
         K9mWB+i2PNsXZ45BK0DvL0brIIuXpEDs2BqQrfTsivXNylSnBn6bYt0DNymnjPKCSunh
         pDcJpapuyNGsVnVCht/tvr37zr1nU33jL3R20bqoj/SBWKvSp6cagzXNyQEJBMUyIo0P
         LNAL/QmO2jibJsKzjeJZBIHo1AsgIVA/zTtre5b3NGIdeWKT1WKHx3o3D46CKXN/4hkH
         zZjTBThEfVFSKALQx7kGTc0xu5xjOfBt56zB/cmIgAhLyhHs7PCUohOC3/3VzzJzXiVa
         mldA==
X-Forwarded-Encrypted: i=1; AKwUvBxZfwKKX/zzH8acQuEPr6ebYvCUdncnZ0s8eGidt9PZgy8gFPML3mC0eo7AH8OqvK4gkGgcMrZZ@vger.kernel.org
X-Gm-Message-State: AFuF++mzo9d3t2uIwzSe3BoqMAXbkCMX0b8iEWr9AiOBLN5KwOAFLsWy
	y2Ss6mvIu7CBUYuJbSoZMlHryq0LN5/8pdZe6CNkQYHt/DQoyjKqaVwv
X-Gm-Gg: AYBFou0n+3g0a35gE8b757jmQ2Rl2Yzlk922Lz4//EuHO+Ua1j4OCwCfuRcG1UjHCaO
	GVojzaeHcdCKnvWfLtpqvxCthTXDFWS1r+LyjPFvOBy3AMqgHtOhUBydTPHZ0SF+KmxrLmOYyGp
	jm2BjcGth1IM51HECGcaicfeVQA3CtPBnGUyU+86hcODENWQ4cuqjSkGomOaYDgbrRm2Rw0mWa9
	vWRcVYXp0xS8W8/eoHibRvTyaIz5Pm6inWFQE/eeRfvc74dsKc5fpb9r4NgbBQI9XKZofodZOfZ
	G2HcBIZ6nPF0pnNVo62ZwbeQTBwVJTEVM450PksyZmzEUb31j9Q83v8qdmnQvi9B9l8yCem6Dn6
	y8+eSHttWhIcA2bCSJ4vECHPmPkLA5MR1owjMGCi+4kZqpI2xF79iYt6ot4l0P/FxL8bGF7Bu5I
	vnC+k8mvIY0802iL0gg0Fadf+cI7iZFjtlGJ7KWoXzlMvr+ia7mL+oqi9QWpFxnBLfdPV4lR3su
	KhXijeN0m0B8F574KMbGOsGZP2GdxEAvPjqWSX05IM/FXb9PVpVfSH5m0ISdDSwu1KAM0ey1IXy
	cUqyfm/yLQJcvTLN0bxrP53OBqcqNXulhxa2NX67bvYGpStN
X-Received: by 2002:a05:6000:2512:b0:47f:fb2e:f63d with SMTP id ffacd0b85a97d-48488f03964mr14504983f8f.9.1788368768453;
        Wed, 02 Sep 2026 10:06:08 -0700 (PDT)
Received: from ip-10-0-1-42.eu-west-1.compute.internal (ec2-34-242-91-155.eu-west-1.compute.amazonaws.com. [34.242.91.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484492ce5e5sm7129345f8f.36.2026.09.02.10.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 10:06:06 -0700 (PDT)
From: Aditya Dutt <duttaditya18@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Aditya Dutt <duttaditya18@gmail.com>,
	dwarves@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves v2 3/3] pahole: Apply the struct-only filters to unions
Date: Wed,  2 Sep 2026 17:05:58 +0000
Message-ID: <064659677a4ba7e42125aebbe903c91ce83fe842.1788368236.git.duttaditya18@gmail.com>
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

class__filter() returns early with --unions before the struct only
filters.

  $ pahole --unions -H 99 /sys/kernel/btf/vmlinux | wc -l
  1786

No union has 99 byte holes, so after this it prints 0.

  $ pahole --unions -H 99 /sys/kernel/btf/vmlinux | wc -l
  0

Signed-off-by: Aditya Dutt <duttaditya18@gmail.com>
---
 pahole.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/pahole.c b/pahole.c
index d2dcd90..83ca321 100644
--- a/pahole.c
+++ b/pahole.c
@@ -720,12 +720,6 @@ static struct class *class__filter(struct class *class, struct cu *cu,
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
-- 
2.50.1

