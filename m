Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5621C2DECB2
	for <dwarves@vger.kernel.org>; Tue,  8 Jul 2025 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983744; cv=none; b=qaApKgqB6iEgdrYkCgM3OeNP/fLll2+cT/fd5MArk6bihVLq2HJ/5DS3AEqm5/bXj40NIixWNkO947UnI39FzZqMYY2ID9xnqAA2IKkOUC+gcjaJzNdGVLGD9ulCPMTxSRrsEvHLN0ZejSmv0MnrUElhNGg5wWc4OxOSp8Nm8/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983744; c=relaxed/simple;
	bh=0geH4ukuZFm1rA3WPuEDc7bUJuKdfItbr1h4UFPOwRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8ZiJjVVihrJk3/63zeZCXmG7UFxV4XYn/5P9G5fkCX/E5AFV6w5DPuRKCLJJd8T+SuNezzX+7TcW+XTaD6G90pBaRmO7Ha2Uhf6q3U/cfaWcqoGL1CkuhGij8ZdRn5PXB9UAnZK0fJMLpKkxm4hcx6SFQjulVvzby3USoIPtwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHvMC8Gq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHvMC8Gq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F63C4CEEF;
	Tue,  8 Jul 2025 14:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751983743;
	bh=0geH4ukuZFm1rA3WPuEDc7bUJuKdfItbr1h4UFPOwRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eHvMC8Gqt+9huSBm/vrLn6UJL19mOFizjlVekyYppCpqtFnfRBlczj10p7SLNlzSt
	 GvXD/UaEmAMnqWojvygggTfc5XWfuR54cLryU3E/oJWvmrj89L7CgKQqPS87SuJU1v
	 HUIakpqwuMpYkCRKqbWyoQu6PCAlqyv/C1ciDQVEKw4cyNFRo82H6zmTbhg2zh0qnf
	 OUhhZDk60aKoNXJvTCI+gUlsNP8oZNMcuuhmh5yBuPiq5CHrwYIruwMk7LS3MB/da2
	 2mYSz+y97qOYVjmEVGes6fywTs3P9M1gPKGlPUeeHDpPoYevL1zXMBvJgYqJ+yb0KJ
	 eAiKwO/p+C9WA==
From: Antoine Tenart <atenart@kernel.org>
To: dwarves@vger.kernel.org
Cc: Antoine Tenart <atenart@kernel.org>,
	pvalerio@redhat.com,
	alan.maguire@oracle.com
Subject: [PATCH v2 1/2] btf_loader: infer alignment for zero-length arrays
Date: Tue,  8 Jul 2025 16:08:54 +0200
Message-ID: <20250708140856.311717-2-atenart@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708140856.311717-1-atenart@kernel.org>
References: <20250708140856.311717-1-atenart@kernel.org>
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

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 btf_loader.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/btf_loader.c b/btf_loader.c
index f4f9f65289b5..6e345ec2442a 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -645,9 +645,15 @@ static int class__fixup_btf_bitfields(const struct conf_load *conf, struct tag *
 		pos->byte_size = tag__size(type, cu);
 		pos->bit_size = pos->byte_size * 8;
 
-		/* if BTF data is incorrect and has size == 0, skip field,
-		 * instead of crashing */
+		/* If the BTF data is incorrect and has size == 0, skip field
+		 * instead of crashing. However the field can be a zero or
+		 * variable-length array and we still need to infer alignment.
+		 */
 		if (pos->byte_size == 0) {
+			pos->alignment = class__infer_alignment(conf,
+								pos->byte_offset,
+								tag__natural_alignment(type, cu),
+								smallest_offset);
 			continue;
 		}
 
-- 
2.50.0

