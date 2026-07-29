Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF21456284;
	Wed, 29 Jul 2026 19:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352087; cv=none; b=PMIgZEisfVddWp2tc3mjfistXLwwuhIKPCIlSupINLI2nS3BLwsLy7x/fabBcIDOEfW3+V3n8OPX7t8/1soPtU1N824c7jzWHHeQBYY8Z6/z7iqNSSUlj2FcpL21pXbcZTK+Y9ZTI43wnua36NXlju5u0O/5i7UEyDMMBnuBNGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352087; c=relaxed/simple;
	bh=mkKvTpk2BZblANafLIPapR16xZQnjmr/W+qdU1OSy8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mtri4XWidurW+AfbYVg8kIUtL+bHvXM8ys0OlEBh6p5tbpzOEf7ORwD2p13eJqHDX9AeBoyu5UuySSlJLeYbvrl2rHXn5ZywBGs9xOg8A6wa8XH8XUXJQyBFpBJFzDqfh7ZE5JAif6w1xbf6YiO63jOD6atQXzVK39IVwALrhAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDfIM3CQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDfIM3CQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E151F00A3A;
	Wed, 29 Jul 2026 19:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352086;
	bh=rXTIYhUfD9AU7ELkErhcIgNiuGeNc7Happ0iNLdy8v8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NDfIM3CQxALKlZMSzVLT9d9rr3pmRZje2JCTPCKIUz2fPJ8faCiHMPh+ON+xLKiae
	 YeWaHLvez96lM7mNY4pE1pHURErlWs2jrnw5Wbtb+M0qt2INGwTcIewJmIyIaEUz3T
	 9A2+eZYij2LGPDJiTbzFPt4IyqkqEluVGrnFegFXVkl/OlUfbmTXMRiVBM8B7vczUo
	 zDC/5vTZVojoufbbri1wKv9RjsSg23lu+71Ve4Rm+n9azgOc9Css16Uz1WhpOfvFso
	 s+I49sf2brBm/ZtdQOFMpuQsEC2n4no0pGKSg7fuV95weSEsb+DXd78t/1DuAPtHWJ
	 u+YtmERX3hIpQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/31] dwarves: Fix heap buffer overflow in languages__parse realloc
Date: Wed, 29 Jul 2026 16:07:12 -0300
Message-ID: <20260729190733.72876-13-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729190733.72876-1-acme@kernel.org>
References: <20260729190733.72876-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The realloc() call in languages__parse() passes nr_allocated as the
size in bytes, but the array holds int elements.  When nr_allocated
doubles past 4 (the initial allocation), the buffer is undersized by
a factor of sizeof(int), causing subsequent writes to corrupt heap
memory.

Before: realloc(entries, nr_allocated) — allocates nr_allocated bytes
After:  realloc(entries, nr_allocated * sizeof(int)) — allocates correct size

With 5+ comma-separated --lang arguments, this would write 4*sizeof(int)
bytes past the allocated buffer.

Fixes: 8fc09fd3315ce934 ("core: Adopt the languages__parse(), languages__in() and 'struct languages' from pahole")
Reported-by: Sashiko:gemini-3-1-pro-preview
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarves.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dwarves.c b/dwarves.c
index 57a4bd063cc9413d..5c9d83a6dee897c2 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -2499,7 +2499,7 @@ int languages__parse(struct languages *languages, const char *tool)
 
 		if (languages->nr_entries >= nr_allocated) {
 			nr_allocated *= 2;
-			int *entries = realloc(languages->entries, nr_allocated);
+			int *entries = realloc(languages->entries, nr_allocated * sizeof(int));
 
 			if (entries == NULL)
 				goto out_enomem;
-- 
2.55.0

