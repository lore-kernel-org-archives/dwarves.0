Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A3C463B7D;
	Wed, 29 Jul 2026 19:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352094; cv=none; b=dM7UNGb03VvTugPEm2TmPYbW3v1ov2Jd3eB0esnaG0JNSx/1MmcCozTMPAOPnlfNQFsbPnzJuYYfwk0FYgfO3FuwbJp9THvesZxAhQSERYv8tR15d+xMZGMMAYWMtZvaLdUMUTPMRl5mWxWUA4Sznrp/H76S9dPOkZ4bkiJJwlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352094; c=relaxed/simple;
	bh=+EEkMWCPTdRX5Ggpr17S+eCvrTIVjmV2fGGQgVciWEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qhaf438y28CPYebc2Y+2zHEF9/im4h3W32FEdNBWDjryx29XwXXpg5pt5Maut8WHWY3viaku7W2GGRMkWaT+7AEXDq+ChDBNqZ1ZUc21US2BdfcRiJs+n5gyKN7j5Kk3/oYeSluPoUeh4+G+TuuFmKCR19sbBXT+5xmRKVYZQLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmDK8mMm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmDK8mMm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188971F000E9;
	Wed, 29 Jul 2026 19:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352093;
	bh=peN8MoGpj1uCUPEWK84Yr9JOpRZrCvk5r8JcGhhimc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LmDK8mMmiS/pBcVf1T9Xv1WPMHwys/mOXt6d3YQtcarDyzGuPnGjpD882INKux+4y
	 S1xKcY0MhVu6uADcyCWFNrX6avesVF/AByMj4zoHURqJ+TR5nSo+llMkFrsg1QzcjO
	 Aubw2H9PNFFs0NX76wpcVVrdZFY64CBz/nudB6/Qkz++FPG+QLDDfjevOxN4eerJku
	 nzdQs0tE0EaZ102zIfDcTEUfrdmlGGVvQNzc2I/ZX9MIEKYF4xW/uhjiBiQigntP1w
	 /EcNefRzJvuQ+L9kNKpCwcv0iBOat3ts/WJqLaZz9Dk/1U/ebW2tFuLuLkqh2z+5kJ
	 XeIybrnmX9DVw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 15/31] dwarf_loader: Fix --fixup_silly_bitfields condition check
Date: Wed, 29 Jul 2026 16:07:15 -0300
Message-ID: <20260729190733.72876-16-acme@kernel.org>
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

The condition for detecting silly bitfields (bitfields that use all bits
of their underlying type, e.g. "unsigned int x:32") was inverted since
commit 03d9b6ebcac7422f ("dwarf_loader: Fix bitfield fixup logic for
DWARF").

The check compared byte_size == 8 * bitfield_size, but byte_size is in
bytes and bitfield_size is in bits. For a "unsigned char val:8" silly
bitfield: byte_size=1, bitfield_size=8, so 1 == 8*8 = 64 was always
false.

Fix by multiplying byte_size by 8 to convert to bits before comparing:
byte_size * 8 == bitfield_size.

Before:
  $ pahole --fixup_silly_bitfields -C silly test.o
  unsigned int  reserved:32;   /* not fixed */
  unsigned char flags:8;       /* not fixed */

After:
  $ pahole --fixup_silly_bitfields -C silly test.o
  unsigned int  reserved;      /* fixed */
  unsigned char flags;         /* fixed */

Fixes: 03d9b6ebcac7422f ("dwarf_loader: Fix bitfield fixup logic for DWARF")
Cc: Andrii Nakryiko <andriin@fb.com>
Reported-by: Sashiko:gemini-3-1-pro-preview
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index ddf7cdcfd467beb4..ce0bead0e76e1876 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3798,10 +3798,14 @@ static int class_member__cache_byte_size(struct tag *tag, struct cu *cu,
 		member->byte_offset += member->byte_size;
 	}
 
+	/* A "silly" bitfield uses all bits of its underlying type
+	 * (e.g. unsigned char val:8).  Convert it to a plain field,
+	 * but only when byte-aligned — in packed structs a full-size
+	 * bitfield can start at a non-zero bit offset. */
 	if (conf_load && conf_load->fixup_silly_bitfields &&
-	    member->byte_size == 8 * member->bitfield_size) {
+	    member->byte_size * 8 == member->bitfield_size &&
+	    member->bitfield_offset == 0) {
 		member->bitfield_size = 0;
-		member->bitfield_offset = 0;
 	}
 
 	return 0;
-- 
2.55.0

