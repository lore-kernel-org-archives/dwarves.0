Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149073A8F0
	for <dwarves@vger.kernel.org>; Sun, 16 Jun 2024 22:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718575772; cv=none; b=UNjrHJHNcyd+3V8pHHPjsZ4tTqZlW32wmQkgpnKTK20inRAVnMWl/6mgsSR8W3iro7OZNCwprNddlv91oIC+5C4h4f7VG4fZAgOGoUFOr5MGHwQS8E0N2AfAmvHa840rKcoUlz+DZ+hKD7gjPJ97pvOMs5FsZnHJr64YQE7rKFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718575772; c=relaxed/simple;
	bh=6NdjMpRbCorVDzTf+tv5ntUpOr+ZGwg+5nnmIYuX3KA=;
	h=Message-Id:To:From:Date:Subject; b=mdaYttFXkr3gy9aagl0uJJPK1cXjNKtDmwdWriEDY+H8FFZ04m9yeJA0UiZqovKg/SZCRWgf6Cvky1OavpJtyD/xIa8aztegpEt7r7zATbMDcLqhMEcRIjLXeYxiVgM/xVcXR0AUZ8D5IJLMIDTHS+RK5TxY0sYbKQ3GEMPW0gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ayaya.dev; spf=pass smtp.mailfrom=ayaya.dev; dkim=pass (1024-bit key) header.d=ayaya.dev header.i=@ayaya.dev header.b=E3r3C1Sm; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ayaya.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ayaya.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ayaya.dev header.i=@ayaya.dev header.b="E3r3C1Sm"
X-Envelope-To: dwarves@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ayaya.dev; s=key1;
	t=1718575766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc; bh=EkBCbZVHicXwnZt+1VESzZ9sVVXURcrUDvjPTpM/Yzc=;
	b=E3r3C1Smxi99P4FfKxj/Jy6nm0/ZIfkw8lpkJQIDIqnId5S/vsiJK1Wwhpzrv1QKNuBnl4
	XPlogQ3aSua35RtvwRBm3a5HDCyXM5hRdjdhLfkj4DGRomL16PVAun9ZgDlIFfXhxgJBWT
	clJJqLvX1wdhvFfpKwXTLl9ntRgvDEY=
Message-Id: <D21S9HZD9HNX.IW2QSGGOHM66@ayaya.dev>
To: <dwarves@vger.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "psykose" <alice@ayaya.dev>
Date: Sun, 16 Jun 2024 22:01:21 +0000
Subject: [PATCH] core: make ptr_table__add do exponential allocation instead
 of incrementing
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>

when building the linux kernel with btf info, a pahole invocation such as

pahole -J --btf_gen_floats -j '--lang_exclude=rust'
--skip_encoding_btf_inconsistent_proto
--btf_gen_optimized .tmp_vmlinux.btf

is ran.

the vmlinux symbol list is extremely large- so this allocated_entry
size grows in small 2048 increments each time, and runs realloc.
outside of glibc (with e.g. musl's malloc-ng allocator, or the llvm
scudo allocator), this seems to be a particularly expensive operation
that ends up repeatedly memcpy'ing the memory into the new realloc over
and over again.

on my hardware, this exponential realloc strategy makes the pahole
invocation on vmlinux.o go from 60 seconds to 25 due to significantly
lower reallocation pressure.

Signed-off-by: psykose <alice@ayaya.dev>
---
 dwarves.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dwarves.c b/dwarves.c
index 1ec259f..dc72d65 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -566,7 +566,7 @@ static int ptr_table__add(struct ptr_table *pt, void *ptr, uint32_t *idxp)
 	const uint32_t rc = pt->nr_entries;
 
 	if (nr_entries > pt->allocated_entries) {
-		uint32_t allocated_entries = pt->allocated_entries + 2048;
+		uint32_t allocated_entries = pt->allocated_entries < 2048 ? 2048 : pt->allocated_entries * 2;;
 		void *entries = realloc(pt->entries,
 					sizeof(void *) * allocated_entries);
 		if (entries == NULL)

base-commit: 3e265dac5ec85b956c664464072196c37d2af4f3
-- 
2.45.2
