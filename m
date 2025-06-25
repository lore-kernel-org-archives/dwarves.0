Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC032D131A
	for <dwarves@vger.kernel.org>; Wed, 25 Jun 2025 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750865018; cv=none; b=N7K2HNB5FwwJPgV220fXOw1h20E7hYPnQ6RzWKIOXflf1YK3NT0s+/YplHo5JImcgx3yHGA2wJNC2uCJfSt6teuZXeRTi7TXXCwdHKuMdNKjMAL8+lC9iPriMINj+3i1dtyoKPTqcUsUqtLcpEvoUHASkA108T8HpIB66Tw7u5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750865018; c=relaxed/simple;
	bh=kzFG1IjVn/lKkFKVufoGk9UdOLPXcKfWodhjmsvX55U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDLXUL5Lf7HKpeED0+d9P/byUuYqxga9EOWPXqXPN8Li9ljCFeVXrd1hwi3BjNPv47s1SUuEXGM6mLVtKu+Rq+k+J4ZoM3qO/cQtRCkvddlmMFiGtF4D7auFq+BCA1vlR2ZItey0nhMwyRyXivuuzOMe2kSX8zM6UnSha0gm84c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=et8tco0N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="et8tco0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A37C4CEEA;
	Wed, 25 Jun 2025 15:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750865016;
	bh=kzFG1IjVn/lKkFKVufoGk9UdOLPXcKfWodhjmsvX55U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=et8tco0NU6+ldWwnsuzsQ7srNTPwIqAjOhR2i4bCkruPsf44GC8k8ZQwcUbxY6TuM
	 W+BZgzyBqJibdlTxm3gwjj6BrM75pXhPJmDk7Lcg5GiUJmJLPU5HWYu/PmKpiZv9Hh
	 O7CWTA1KF6znTXCngcjhTVwW+lOWnr4yBi2jm/QNDKfBims7l50h2aQNkrSqlnbCMO
	 ogWG73D8h8vpFeVnntr86br3P0+zr16769JDHzzggaZtqATbSduCWDt+F32MFMkUWg
	 7iIbWOsRhQdVRRrMYACJj6yb+esq1XbSEwhlpLLnSCtWFppV1V4xc1X134LjCGLxyb
	 +7BDuFyj0+67w==
From: Antoine Tenart <atenart@kernel.org>
To: dwarves@vger.kernel.org
Cc: Antoine Tenart <atenart@kernel.org>,
	pvalerio@redhat.com
Subject: [PATCH 1/2] btf_loader: infer alignment for zero-length arrays
Date: Wed, 25 Jun 2025 17:23:19 +0200
Message-ID: <20250625152329.28601-2-atenart@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250625152329.28601-1-atenart@kernel.org>
References: <20250625152329.28601-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zero sized arrays do not go through the bitfield fixup logic, which in
turn makes them to skip the alignment infer logic. The result is
zero-length arrays being incorrectly aligned when an explicit statement
is needed. E.g. this happens for variable length arrays at end of
structures, or for 0-length ones.

Before this patch we can see:

  struct skb_ext {
	refcount_t                 refcnt;               /*     0     4 */
	u8                         offset[4];            /*     4     4 */
	u8                         chunks;               /*     8     1 */

	/* XXX 7 bytes hole, try to pack */

	char                       data[];               /*    16     0 */

	/* size: 16, cachelines: 1, members: 4 */
	/* sum members: 9, holes: 1, sum holes: 7 */
	/* last cacheline: 16 bytes */
  } __attribute__((__aligned__(8)));

  offsetof(struct skb_ext, data) returns 9.

After this patch we get:

  struct skb_ext {
	refcount_t                 refcnt;               /*     0     4 */
	u8                         offset[4];            /*     4     4 */
	u8                         chunks;               /*     8     1 */

	/* XXX 7 bytes hole, try to pack */

	char                       data[] __attribute__((__aligned__(8))); /*    16     0 */

	/* size: 16, cachelines: 1, members: 4 */
	/* sum members: 9, holes: 1, sum holes: 7 */
	/* forced alignments: 1, forced holes: 1, sum forced holes: 7 */
	/* last cacheline: 16 bytes */
  } __attribute__((__aligned__(8)));

  offsetof(struct skb_ext, data) returns 16.

Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 btf_loader.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/btf_loader.c b/btf_loader.c
index f4f9f65289b5..76771afedd95 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -648,6 +648,10 @@ static int class__fixup_btf_bitfields(const struct conf_load *conf, struct tag *
 		/* if BTF data is incorrect and has size == 0, skip field,
 		 * instead of crashing */
 		if (pos->byte_size == 0) {
+			pos->alignment = class__infer_alignment(conf,
+								pos->byte_offset,
+								tag__natural_alignment(type, cu),
+								smallest_offset);
 			continue;
 		}
 
-- 
2.49.0

