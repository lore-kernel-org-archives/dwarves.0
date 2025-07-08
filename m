Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E43F2DEA84
	for <dwarves@vger.kernel.org>; Tue,  8 Jul 2025 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983747; cv=none; b=PPoj6RJXdI6eUUimepQxq+Ft1Nf+dC0pm3g/vyUuiuTKekGr/VscTGzFmbulFXqG5ELhfdwXKH5zZzxcRrH+10DMvnxaPl1nchRPEhFNbpfrylwEPa2B8pJOgPkxNmmSLzN/7PfQCui1b1Zltmd878C3nl+Isjs9w1lbX1y3EIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983747; c=relaxed/simple;
	bh=Q6LvWkYTJB4bL2q+7t4u7yJ42e3NqQ4uLusSAVKV3P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mi6kR7rLVNkhgSNf6r7r0niDOtmX+EuvT9nrUrDi32np66K/3la1CGeL24qRlSh8OSui68JMHtUjfEIdR4FKWR8BgyMjvWjEncr8hedmMKOOo+mmnOlQixu38aYeuik91fjENny16/dlkb9tClT928pLwGc0KemrH1VGU6H9Mjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlHN2tQ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlHN2tQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85D8C4CEED;
	Tue,  8 Jul 2025 14:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751983747;
	bh=Q6LvWkYTJB4bL2q+7t4u7yJ42e3NqQ4uLusSAVKV3P8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HlHN2tQ46fDD960GxUMEa/6Gav3tYh9grSrfKvseEX047DT4sXKBsYRu0SOPSaB4q
	 6SxWTfC6yR5wvSgcC8sB929t90B23eA1BOBeRz+xumsTZ84DAqI2k5M8Y/C7C1cM04
	 T81y2VJpLX6jAzCj/uEJ/+mJlWuSwcsDUV/Cv/i8KObGasxU3knbf91/kfPHNHy9uO
	 CxOY5c1KsbWzZwILUfaSu5HoK5a4WvNQ0UpiXd6qggJF0Mzhu093aNS3s835yfaY/+
	 ikqXWGM9Y53LDdce4hZEESRHs/jyoPQZhT8Mt6cAnjgHLiS3DnQeaBzvejyZpK78Y7
	 U0EOimIYIVNmA==
From: Antoine Tenart <atenart@kernel.org>
To: dwarves@vger.kernel.org
Cc: Antoine Tenart <atenart@kernel.org>,
	pvalerio@redhat.com,
	alan.maguire@oracle.com
Subject: [PATCH v2 2/2] btf_loader: fix smallest offset in case of bitfields
Date: Tue,  8 Jul 2025 16:08:55 +0200
Message-ID: <20250708140856.311717-3-atenart@kernel.org>
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

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 btf_loader.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/btf_loader.c b/btf_loader.c
index 6e345ec2442a..64ea68022ab0 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -678,7 +678,18 @@ static int class__fixup_btf_bitfields(const struct conf_load *conf, struct tag *
 							pos->byte_offset,
 							tag__natural_alignment(type, cu),
 							smallest_offset);
-		smallest_offset = pos->byte_offset + pos->byte_size;
+
+		/* Compute the smallest offset between this field and the next
+		 * one.
+		 *
+		 * In case of bitfields we need to take into account the
+		 * actual size being used instead of the underlying type one as
+		 * it could be larger, otherwise we could miss a hole.
+		 */
+		smallest_offset = pos->byte_offset;
+		smallest_offset += pos->bitfield_size ?
+			(pos->bitfield_offset + pos->bitfield_size + 7) / 8 :
+			pos->byte_size;
 	}
 
 	tag_type->alignment = class__infer_alignment(conf,
-- 
2.50.0

