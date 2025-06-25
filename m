Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF572874F2
	for <dwarves@vger.kernel.org>; Wed, 25 Jun 2025 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750865020; cv=none; b=PQaIuc9aIPLXAMKXXS7HGezezNo9VOx+xS0OkR/YtoI/6A/Za5Ft3pnBf9L2e6dnmqnrfJU0K+X9Ck1Bm+Se3M0QTT22DOi1DN4UQaUI749Dlxa9WtfDsoBUUC3qi4vgunNRvat8NAcPEQPxKqLb9xiOJcrjHRzyscAORliOjrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750865020; c=relaxed/simple;
	bh=Icxl2/uNORaY2tlFEP3GtOkqkYvmtoAAmYCxtEF+pAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkhI6qa8Dy9l5rt4MeuTLgmiV5v0i5WleO7grf90YHrULc/wjY21H+wXXRy3ne9NCeCAUusoE9wdE8ANilFXVzKFFk0+KdIVv0MlTSB3EDBSzI3JDs4SUiqssqsc0O4xWI50/d+imaqJ4PSiYpRck7IAshq/8pHWM5tdx9bTj7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8iwm3gd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8iwm3gd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED97C4CEEA;
	Wed, 25 Jun 2025 15:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750865020;
	bh=Icxl2/uNORaY2tlFEP3GtOkqkYvmtoAAmYCxtEF+pAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W8iwm3gdWs8GU6UgHVPevIpaHZg32/RuYqqgvV7rMgpdVf29NxDfA9c0IRiBaLrdC
	 D2fsHyScqHBi4SJ+nYBWUErkQfjaEVVJz2rb8jv7keBvJ1rL6GmloAScwEaUBSzqSO
	 GaQZaZfDlxTmB7etoZcAy7jFE3c5Jg24+2+3wB9slRWdj+qchGkb+DHPEqsNgRvTb3
	 Um0Pg2WYi8eh+/lsWashS0ISrOuP2pyF64qcs7Yl3bQ85Qa5bWBMHHsXc5ngZTZUH/
	 vSB1AxhXH/u/8RkVLcPfYlfzk2lc/z8veTV98nh4eqLSoFSIPvFKd9o5AFxv8kLl6l
	 xFB4OxvMS+ZMA==
From: Antoine Tenart <atenart@kernel.org>
To: dwarves@vger.kernel.org
Cc: Antoine Tenart <atenart@kernel.org>,
	pvalerio@redhat.com
Subject: [PATCH 2/2] btf_loader: fix smallest offset in case of bitfields
Date: Wed, 25 Jun 2025 17:23:20 +0200
Message-ID: <20250625152329.28601-3-atenart@kernel.org>
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

In case the member is a bitfield, using pos->byte_size can be misleading
as it can be larger than the actual size. In such case we could miss an
actual hole in the struct and not infer the alignment as expected.

Before this patch we can see:

  $ pahole nf_tables.btf -C nft_rule_dp
  struct nft_rule_dp {
  	u64                        is_last:1;            /*     0: 0  8 */
  	u64                        dlen:12;              /*     0: 1  8 */
  	u64                        handle:42;            /*     0:13  8 */

  	/* XXX 9 bits hole, try to pack */

  	unsigned char              data[];               /*     8     0 */

  	/* size: 8, cachelines: 1, members: 4 */
  	/* sum bitfield members: 55 bits, bit holes: 1, sum bit holes: 9 bits */
  	/* last cacheline: 8 bytes */
  };

  offsetof(struct nft_rule_dp, data) returns 7.

Where `data` won't be aligned as expected, as the first member fits on
the byte left after the bitfield.

After this patch we get:

  $ pahole nf_tables.btf -C nft_rule_dp
  struct nft_rule_dp {
  	u64                        is_last:1;            /*     0: 0  8 */
  	u64                        dlen:12;              /*     0: 1  8 */
  	u64                        handle:42;            /*     0:13  8 */

  	/* XXX 9 bits hole, try to pack */

  	unsigned char              data[] __attribute__((__aligned__(2))); /*     8     0 */

  	/* size: 8, cachelines: 1, members: 4 */
  	/* sum bitfield members: 55 bits, bit holes: 1, sum bit holes: 9 bits */
  	/* forced alignments: 1 */
  	/* last cacheline: 8 bytes */
  };

  offsetof(struct nft_rule_dp, data) returns 8.

Thanks to Paolo Valerio for helping, including narrowing down where the
issue was (BTF decoder).

Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 btf_loader.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/btf_loader.c b/btf_loader.c
index 76771afedd95..3beb5bba5f94 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -676,7 +676,10 @@ static int class__fixup_btf_bitfields(const struct conf_load *conf, struct tag *
 							pos->byte_offset,
 							tag__natural_alignment(type, cu),
 							smallest_offset);
-		smallest_offset = pos->byte_offset + pos->byte_size;
+		smallest_offset = pos->byte_offset;
+		smallest_offset += pos->bitfield_size ?
+			(pos->bitfield_offset + pos->bitfield_size + 7) / 8 :
+			pos->byte_size;
 	}
 
 	tag_type->alignment = class__infer_alignment(conf,
-- 
2.49.0

