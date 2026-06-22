Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A66734D3B0
	for <dwarves@vger.kernel.org>; Mon, 22 Jun 2026 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159924; cv=none; b=o/fqxMy0OOd4dlfP3UMYXJHPgcQmfePnv2eQaX6+H7GR1+v4ipiJBD44Cz2aThsHoOxpwjd9F6qOOHYhK8nNh6GpgJMzMWa/JJmwJsOXm/hV6BezIYMBVtCyGblhGFsOmtK68n90U3NKfwcxmCcIH/qkTFq3eCpohhKp/TwzUGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159924; c=relaxed/simple;
	bh=Ebb1srZoQbCvBKMS8nn/OcxJKh40ULSbF4ju1w2lWxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=htOkeozoMby0o+1RnIvi87ghq0PVLvCfi+801qoB7ZzbsSIOdBuT5yN+RxzMDEDgZ+xrwRg6Q3iQ8FdPLRd5MJclcndF6Ep15/e+QgqEP/27yTVGLBRgoLa0+2nJEFAf/VOxArBJ3eLhwGb0YNd0AohU1RMtAZHSDOM44h1vFn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJZTKLil; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJZTKLil"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D220C1F00A3D;
	Mon, 22 Jun 2026 20:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782159922;
	bh=EtOOSvkdrddRdvCxtXXCCg4WU0g5slNZ9b2htoPVmFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HJZTKLilUaSfc/2ievHleAtJqAEieGtyY8NMBUI1r6nZN6epDQndqjaT4tCP8M8HQ
	 Bo8vsTqmnklRuRV8p5eKAWSxhaE4cOzc6eT68qxSWV5MdJRi6mc7t7xW904gsHP7H3
	 RMxsYu1kYbYmH2UfcWAIeahUJvXHq4OBA7jcDM7sdIIu3Asup+67PANx6lkEkTe/CL
	 O9cTmiDx1vOJCvdx2yHuet3MxJSzxKRNcSZn8gWcX+Aou/S9e0c4ncmxxMlxjjAKsN
	 M4oy5N/X6k2IxwTCiFAHl8vb/snZeUEPMFgh5FychW6FfcCtTEEOWhgS/PNUB7A518
	 Ec14vCYuzpomQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 15/16] tests: Guard cleanup() against empty outdir to prevent rm /*
Date: Mon, 22 Jun 2026 17:24:38 -0300
Message-ID: <20260622202441.14799-16-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622202441.14799-1-acme@kernel.org>
References: <20260622202441.14799-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

If make_tmpdir() fails, outdir is empty.  The cleanup() function
executes rm ${outdir}/* which expands to rm /* when outdir is unset or
empty — potentially deleting the entire root filesystem.

Add a guard to check that outdir is non-empty and points to an existing
directory before attempting removal.

Fixes: 52dbfb0b39595ed8 ("pahole: Refactor selftests")
Reported-by: Sashiko:gemini-3-1-pro-preview # Running on a local machine
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tests/test_lib.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/test_lib.sh b/tests/test_lib.sh
index fb724329b6079aa2..19c90e897d9bff53 100755
--- a/tests/test_lib.sh
+++ b/tests/test_lib.sh
@@ -176,7 +176,9 @@ test_skip()
 
 cleanup()
 {
-	rm ${outdir}/*
-	rmdir $outdir
+	if [ -n "$outdir" ] && [ -d "$outdir" ]; then
+		rm ${outdir}/*
+		rmdir $outdir
+	fi
 	return 0
 }
-- 
2.54.0

