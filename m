Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B5DC2DF
	for <dwarves@vger.kernel.org>; Fri, 20 Oct 2023 03:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzuJ5uL6"
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C05118E
	for <dwarves@vger.kernel.org>; Thu, 19 Oct 2023 20:04:51 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-307d58b3efbso236369f8f.0
        for <dwarves@vger.kernel.org>; Thu, 19 Oct 2023 20:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697771089; x=1698375889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USrRLbm8rA2qDtGikscwWIWsCVTx1Vlg0PNCu4/NpdA=;
        b=ZzuJ5uL6BHr2mGY//QTrHTL5IWYyCpSNIwKnND6LbBBBn/D307hzlQC9sBP6ax+oXP
         W/Q2WUtCKaMZ8E/R4cNXR7AQxjJjCUSmVKgj0r0p26Ha+wIMnllWOuziaWJFzIVBbUl8
         qa1hHRMoEf8OyOAVHdoxlg9DMOfW4z/e+fzRDBh9468lg7COxizMKGruSm/GCRWogmjb
         X/xuduZqP3mSDuO9Y+Az0aUtNGtXpKjGZEeGGazffR3Vr25SVqnkQYzDTt796o76NP0O
         x6FWKNhXS8frw8ZlA7ICf0WxSFNjCGkpHDj/cA+Hbl0PEZd/fUJ4Fwl6xlNXoTLo1P8C
         D+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697771089; x=1698375889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USrRLbm8rA2qDtGikscwWIWsCVTx1Vlg0PNCu4/NpdA=;
        b=AJ5bcQSZUMAe5FtXK9+LHmDX2Rc5mNo4OE1vZZggFin0W6J1nFpYGeERYdk+NvJgew
         Ljt7rHs1MgevBTPoX0F+aus1cuymZ9QBFUz1RVntojzSeP2wtkpNfJ5jdO8txz7QnTqX
         R7J5FmFX1wzQ93gDNrAIXeTSJ3cDJ3fVnxjdt7mTklyil6KDgEay1DH0Ts62VAi9gwdb
         Da5a7klYel1Vf2NgPWYvu0VAHcbXWbiOhnYqy11svjG+XsSY+AMmA+Du02Y6PbKLPz2D
         5xAtLGIc+ex1+Kv2KkhquM5KFU/QfpkkO9AvYZWtrtKPMIq6GJOEO8PhRVthcbTm+PZq
         Y8hw==
X-Gm-Message-State: AOJu0YzoMD46Nlt8cNaZaqFySmmce2jDCBM1wwfIGnxqiBvPuF91Tq3p
	cOlC2s+TGdGhdzahbGRMLviX/xLGSd+lMQ==
X-Google-Smtp-Source: AGHT+IFdGA7rcX6CVX7/ZCtoebQ3RJTxTO9EdckbIPUtOWOfpdP11Z4tY+2io7rHkKpoAtv+LbV7aA==
X-Received: by 2002:a5d:518f:0:b0:32d:ad4a:bced with SMTP id k15-20020a5d518f000000b0032dad4abcedmr364836wrv.23.1697771089147;
        Thu, 19 Oct 2023 20:04:49 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:8a0:7280:5801:9441:3dce:686c:bfc7])
        by smtp.gmail.com with ESMTPSA id b17-20020adfee91000000b0031c5e9c2ed7sm654242wro.92.2023.10.19.20.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 20:04:48 -0700 (PDT)
From: Pedro Falcato <pedro.falcato@gmail.com>
To: dwarves@vger.kernel.org
Cc: Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH 2/2] README: Add guidance in patch sending
Date: Fri, 20 Oct 2023 04:04:44 +0100
Message-ID: <20231020030444.345871-2-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020030444.345871-1-pedro.falcato@gmail.com>
References: <20231020030444.345871-1-pedro.falcato@gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

How to contribute changes isn't necessarily obvious if one only takes
into account what's in the git repo (even the mailing list's email is
hidden in a man page). Add some guidance for future contributors.

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 README | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/README b/README
index f9aeef7..3bd7dd8 100644
--- a/README
+++ b/README
@@ -21,3 +21,7 @@ cmake Options:
 You may need to update the libbpf git submodule:
 
 git submodule update --init --recursive
+
+Submitting patches:
+Please submit patches in git format-patch format to dwarves@vger.kernel.org (plain text emails only).
+Development roughly follows a simplified version of Linux kernel's Documentation/process/submitting-patches.rst.
-- 
2.42.0

