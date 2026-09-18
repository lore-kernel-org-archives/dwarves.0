Received: from smtp03.hmg9.webhuset.no (smtp03.hmg9.webhuset.no [46.226.9.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C359472557
	for <dwarves@vger.kernel.org>; Fri, 18 Sep 2026 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.226.9.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789754244; cv=none; b=SNFV/xeYWFyd46tQiBi3Gq/tvVukAU37gqLnS74Ie6d1+maLg7zJuA1KIXChnL9Mwaimxj22xsd2masCVW+8Ud61Bf0uCMFeYe9w7tkpBhcUTCT6Mdue++BCtIHzkvTIsglltyvndkNJ4H9wh8CDGTbkNKmFtfc4cfUYoEym7uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789754244; c=relaxed/simple;
	bh=yly/UVaN4oAuRIoqZykVDD/hDE47bUSk+yP7uvWvzJA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GPoeN3+fDYp//7mTFAE58VjoBX057r8lSVPOwAJuFE/JZiB5XulssHzho7RsVAE8+8v/rbFrdE4MkiKH/KCDZUdVuaQTQaH9kQCYpPzRtPZUNx7LMk2bHS4FXHNp39F2dIrsPlT94AjT3PA2s6VhVxipTthRtPES8oie5FlT178=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pfft.no; spf=pass smtp.mailfrom=pfft.no; arc=none smtp.client-ip=46.226.9.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pfft.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pfft.no
Received: from mail.pfft.no (unknown [109.247.74.5])
	by smtp03.hmg9.webhuset.no (Postfix) with ESMTPA id DD76F81741
	for <dwarves@vger.kernel.org>; Fri, 18 Sep 2026 19:48:11 +0200 (CEST)
From: =?UTF-8?q?H=C3=A5vard=20F=2E=20Aasen?= <havard.f.aasen@pfft.no>
To: dwarves@vger.kernel.org
Subject: [PATCH] Escape a leading dot in groff man-page
Date: Fri, 18 Sep 2026 19:47:08 +0200
Message-ID: <20260918174708.289274-1-havard.f.aasen@pfft.no>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use '\&' to prevent the line from being interpreted as a macro and
eliminate a warning.

Can be tested with command:
    LC_ALL=C.UTF-8 MANROFFSEQ='' MANWIDTH=80 man --warnings \
        -E UTF-8 -l -Tutf8 -Z man-pages/pfunct.1  >/dev/null

Signed-off-by: Håvard F. Aasen <havard.f.aasen@pfft.no>
---
 man-pages/pfunct.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man-pages/pfunct.1 b/man-pages/pfunct.1
index 9482ac4..5ce203b 100644
--- a/man-pages/pfunct.1
+++ b/man-pages/pfunct.1
@@ -212,7 +212,7 @@ $ pfunct --cc_inlined ~/src/bpf-next/vmlinux
 clean_cache_range
 copy_from_user_nmi
 __insn_get_emulate_prefix
-...
+\&...
 .fi
 
 .SH SEE ALSO
-- 
2.53.0

