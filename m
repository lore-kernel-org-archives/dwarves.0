Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1603326ED3C
	for <dwarves@vger.kernel.org>; Fri, 17 Jul 2026 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311272; cv=none; b=Y6sqNPj/02CSMU2tYaFd5g9TWLY624sMQgD+Pu3UaS4sJWVbuAHF+X/nGf9jHnt5ili/Qrgzq+xgDgFUiQEX0fQ/kMF2ieXlt/SwOCOamsvx8pID4gjIjzu4ViZXCUFmSq4CTh1FQvXU9BXwJPTxqrlT4vNYFaQ83Gw6sS62EPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311272; c=relaxed/simple;
	bh=7oaZ9dM03CLg4MtOHlv2a0b/rW8ew1hIogznqWFPDGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oO0kZv5P1aeNZQnlI5wLsBHOB5cpxndna6R3n6irbrt8Nwu4tBbR24fZKWO3Rq/R31kKRWLHHg3cMMG7qIlYntW3BRYbG9GmcudPVrZ+CQA1DjVgQFKDdXmmjJ5sdIF2W8n5lP+eZy4HMo0N/RK18BfFr69MVTyQNFK2VjGgLJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyvxFi8N; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyvxFi8N"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c96bfabc8d4so2894443a12.3
        for <dwarves@vger.kernel.org>; Fri, 17 Jul 2026 11:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784311270; x=1784916070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QZaW/46DgvyN39M4Kj51qRH9KycNWNlcs1nnYtnfcHI=;
        b=UyvxFi8NVIMufj9P0Rx3Lu2yf1zrN9bTVvlxXKP/6MXLDPrdSZYJm2tNZvvA1X+iJO
         ViKrV/i46nCwdh4ZTlq1SOdnoNYhDykjmZ1NwfkHFOOSJiHi59eDIFCN505XdMmy3Mab
         5IxxBhpgjua17c3Vw81JTn7CxSvS271OIKn57QvBsv6XStJ8VFy8tINjoBI/9kcHTvF3
         GOvySjBeSEQzp9JVxi/x6X70y0TfczZwa/kXqcZNnAyPGbR/wwAuxFtwTBYxCHQOG1ov
         vfXGteD+AiPRcH364igTOryp55MBUM3BM3UB0Jjk61xKTLPi+D5V48TUz4GkvOFO/7YY
         ZMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784311270; x=1784916070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QZaW/46DgvyN39M4Kj51qRH9KycNWNlcs1nnYtnfcHI=;
        b=ag+zMiPKwraBXS+hMsvIS0fc8m2UQp1cpxSCXCKeCTN1j3te4ceXOntNnrm+yzY4EE
         6rKhfPx94DLSQ/Ja7JTi6F5MWl5ykfm7Gmqsviz0Ky7PudwmVxKjobCAitjkqiXoB/5o
         lZZuR4EhbNCi1ZaDW/3VHQbqMhLZeSHDUZ20TRpQhdLjbPn/AryoKjQA+oT7gvgKhlZo
         72TWhf2t5bpk8sZvI+LBNdYz9G16dXb7XX2pJjmIG1e1egoN9h95qhvW3+gihKGEmao4
         BRkNxs+ukPPW+j4vhG+eiUq8WYL9+OQ8WFdJki27YuYLd0L505jYk1pMUjfUxdEQy+OW
         lRdw==
X-Gm-Message-State: AOJu0YxPz6o7+kKcNLVHq6ydEQ8x0MkAlLC/8gq8DXw0U+YJ0f9GsKmf
	Dtft6Fn7Ogv5hQn8GBfIMrd86r/Lyp9vRAE4NRyy86eiH/KS1GI7CCzd
X-Gm-Gg: AfdE7ckS/FJ5K95+INzoiywf4oZjF6CTIDXu9fX0nr0c6Solc+4ioCCEcNGOI1LU4Xv
	oSGJmD3G2/YjCuFSVoQReCDYmhTt0aRIzyES/zQxYg7tKfNQ/5m4jDul5Zm8HcIG8Gb/iDQlFla
	kBwLT10ERqkUgciqc7BvqSTi/dTAIiB47De4J+eiCOocTScfvQc3r6cM/gyEbM+6kD0M9f1BopF
	dtHLAG9EGumyvFQaopEpieXnlBeSn8rlWtqxRJEo2GVc0/zhaXyI2/wcBK0rkvqkKMtiClrx2Rq
	h1TivgygKHw/TgKt3P2D/IucuFC+vDsU6N6auPC5tib6dqoEhuDc/E0oF/Sr/6JCnWQCzzd4hYJ
	EVBFOJzG0HW0cs/T0SWzKR0MmFb3npZgSVsyyAdU2DyIhmyUKEXzZHwr2gcK/LeCSUBsKy7d9Vh
	xIt0RlTt6+Uj1Vgp9YXKbotD7tvcroECtJa3JIfcY52mYgkdt/AE8M/g==
X-Received: by 2002:a17:90b:2f4b:b0:37f:9cdf:f03e with SMTP id 98e67ed59e1d1-38e4b540acbmr3990690a91.33.1784311270175;
        Fri, 17 Jul 2026 11:01:10 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2a00:79e0:2ed2:c:2e6e:4cf:60f4:b60])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429fdcb09sm10293565eec.9.2026.07.17.11.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:01:09 -0700 (PDT)
From: Namhyung Kim <namhyung@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org
Subject: [PATCH] btf_encoder: Add O_TRUNC to btf_encoder__write_raw_file()
Date: Fri, 17 Jul 2026 11:01:05 -0700
Message-ID: <20260717180105.136705-1-namhyung@gmail.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When it creates a raw file, it should truncate the content in case there
is an old file with the same name.  Otherwise it may have some garbage
at the end of the file and it could make the kernel fail to verify BTF.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 btf_encoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index d36984a..b810dd5 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1878,7 +1878,7 @@ static int btf_encoder__write_raw_file(struct btf_encoder *encoder)
 		return -1;
 	}
 
-	fd = open(filename, O_WRONLY | O_CREAT, 0640);
+	fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0640);
 	if (fd < 0) {
 		fprintf(stderr, "%s: Couldn't open %s for writing the raw BTF info: %s\n", __func__, filename, strerror(errno));
 		return -1;
-- 
2.55.0.229.g6434b31f56-goog

