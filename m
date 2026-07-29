Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD876488DAF;
	Wed, 29 Jul 2026 19:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352119; cv=none; b=WTxmibfP/aVzti39gKe3Obk9MD2VKt/VzcfzP/6K/GgLcVQUGBM/g+1EWfDWEGlyHXwWdfGj2cht5jELjpHWntpB/Wp+fFpNV05vcQ0nqF9NZ20gfD/Uq73ymFq0dLnxMEeYKdWuC4VFeV4CrzNqh+vP8prcvRbr3+rXCsw5T80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352119; c=relaxed/simple;
	bh=P2/Gkyh4c9u93itUHKsMciJ1W8HUPKmyrB0iu5evFFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I00087kzSSND4gursiX9vswPRxZF7Yh6PkFaVKqjU4I2J8M8lP3L5dyIX0BC4S9jM9pXvq9EW/fUKcOygKmiNlKWiFa68hPkjZaSbYenIuUUV94qyr3klsksVKWAm4dh3rcSpKSuaiCxINQb53pvxdV1WYJtzGPcdlG6mVpFFPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ng2v0o4P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ng2v0o4P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AAB91F00A3A;
	Wed, 29 Jul 2026 19:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352118;
	bh=TKfO1/FyZbUIoRqBnWqLwdx1/LBpNyG4EgL+SPzea5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ng2v0o4PZ1qJpaNglUIKATW2sL0LkNoOpFFc2PgBB/kwXuZjM1Ee4m0myQDEB6Mdn
	 mOLOPPImZWtBEPqAjXBD0H+s/1Bfj6kErXOLkO4dOl6mUHLjCKUuDAi7d/1qZG9yZZ
	 Z9m28XedSodFOcoODeyEGolhvARAEfNw8UxMdKTMTCa0hrGwPvf7hxGqFlNzMKeiZx
	 4U925C9C4BjBt4uLznqn6iyRa0WbFR1oT19pP8QBr4d785FqQ3mAWDV6yyd/TQ34we
	 ri6hsqw7b041MX5BRtdWBLRvd99hDp4LceBGqd94oFtK2LqlNakd2zefr/Glv1nheh
	 8ZyaTBeLDHiHw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 26/31] gobuffer: Remove 5 dead functions found via coverage analysis
Date: Wed, 29 Jul 2026 16:07:26 -0300
Message-ID: <20260729190733.72876-27-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729190733.72876-1-acme@kernel.org>
References: <20260729190733.72876-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Coverage analysis showed that 5 of 10 gobuffer functions have zero
callers anywhere in the codebase:

  gobuffer__new:      never called, dead since creation in be30be91
                      ("gobuffer: Move the non string specific bits",
                      2008)
  gobuffer__init:     only caller was gobuffer__new
  gobuffer__delete:   never called (only __gobuffer__delete is used)
  gobuffer__compress: last caller removed in 29fce8dc ("strings: use
                      BTF's string APIs for strings management", 2020)
  gobuffer__sort:     added in 2046cc50 for kfunc sorting (2024),
                      caller removed in c5677178 ("btf_encoder:
                      Refactor btf_encoder__tag_kfuncs()", 2025)

Removing them also drops the stdio.h and zlib.h includes and the
GOBUFFER__ZCHUNK constant that only gobuffer__compress used.

Before: 10 functions, 152 lines, 29% line coverage.
After: 5 functions, 77 lines, 55% line coverage.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 gobuffer.c | 74 ------------------------------------------------------
 gobuffer.h |  8 ------
 2 files changed, 82 deletions(-)

diff --git a/gobuffer.c b/gobuffer.c
index c439c48bb775593f..beeb677cfc3d7617 100644
--- a/gobuffer.c
+++ b/gobuffer.c
@@ -11,33 +11,12 @@
 #include <search.h>
 #include <stdint.h>
 #include <stdlib.h>
-#include <stdio.h>
 #include <string.h>
-#include <zlib.h>
 #include <errno.h>
 
 #include "dutil.h"
 
 #define GOBUFFER__BCHUNK (8 * 1024)
-#define GOBUFFER__ZCHUNK (8 * 1024)
-
-void gobuffer__init(struct gobuffer *gb)
-{
-	gb->entries = NULL;
-	gb->nr_entries = gb->allocated_size = 0;
-	/* 0 == NULL */
-	gb->index = 1;
-}
-
-struct gobuffer *gobuffer__new(void)
-{
-	struct gobuffer *gb = malloc(sizeof(*gb));
-
-	if (gb != NULL)
-		gobuffer__init(gb);
-
-	return gb;
-}
 
 void __gobuffer__delete(struct gobuffer *gb)
 {
@@ -47,12 +26,6 @@ void __gobuffer__delete(struct gobuffer *gb)
 	zfree(&gb->entries);
 }
 
-void gobuffer__delete(struct gobuffer *gb)
-{
-	__gobuffer__delete(gb);
-	free(gb);
-}
-
 void *gobuffer__ptr(const struct gobuffer *gb, unsigned int s)
 {
 	return s ? gb->entries + s : NULL;
@@ -102,50 +75,3 @@ void gobuffer__copy(const struct gobuffer *gb, void *dest)
 	}
 }
 
-void gobuffer__sort(struct gobuffer *gb, unsigned int size, int (*compar)(const void *, const void *))
-{
-	qsort(gb->entries, gb->nr_entries, size, compar);
-}
-
-const void *gobuffer__compress(struct gobuffer *gb, unsigned int *size)
-{
-	z_stream z = {
-		.zalloc	  = Z_NULL,
-		.zfree	  = Z_NULL,
-		.opaque	  = Z_NULL,
-		.avail_in = gobuffer__size(gb),
-		.next_in  = (Bytef *)(gobuffer__entries(gb) ? : ""),
-	};
-	void *bf = NULL;
-	unsigned int bf_size = 0;
-
-	if (deflateInit(&z, Z_BEST_COMPRESSION) != Z_OK)
-		goto out_free;
-
-	do {
-		const unsigned int new_bf_size = bf_size + GOBUFFER__ZCHUNK;
-		void *nbf = realloc(bf, new_bf_size);
-
-		if (nbf == NULL)
-			goto out_close_and_free;
-
-		bf = nbf;
-		z.avail_out = GOBUFFER__ZCHUNK;
-		z.next_out  = (Bytef *)bf + bf_size;
-		bf_size	    = new_bf_size;
-		if (deflate(&z, Z_FINISH) == Z_STREAM_ERROR)
-			goto out_close_and_free;
-	} while (z.avail_out == 0);
-
-	deflateEnd(&z);
-	*size = bf_size - z.avail_out;
-out:
-	return bf;
-
-out_close_and_free:
-	deflateEnd(&z);
-out_free:
-	free(bf);
-	bf = NULL;
-	goto out;
-}
diff --git a/gobuffer.h b/gobuffer.h
index cd218b629898307f..f9c461fec87c172f 100644
--- a/gobuffer.h
+++ b/gobuffer.h
@@ -13,16 +13,10 @@ struct gobuffer {
 	unsigned int	allocated_size;
 };
 
-struct gobuffer *gobuffer__new(void);
-
-void gobuffer__init(struct gobuffer *gb);
-void gobuffer__delete(struct gobuffer *gb);
 void __gobuffer__delete(struct gobuffer *gb);
 
 void gobuffer__copy(const struct gobuffer *gb, void *dest);
 
-void gobuffer__sort(struct gobuffer *gb, unsigned int size, int (*compar)(const void *, const void *));
-
 int gobuffer__add(struct gobuffer *gb, const void *s, unsigned int len);
 int gobuffer__allocate(struct gobuffer *gb, unsigned int len);
 
@@ -43,6 +37,4 @@ static inline unsigned int gobuffer__size(const struct gobuffer *gb)
 
 void *gobuffer__ptr(const struct gobuffer *gb, unsigned int s);
 
-const void *gobuffer__compress(struct gobuffer *gb, unsigned int *size);
-
 #endif /* _GOBUFFER_H_ */
-- 
2.55.0

