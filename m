Received: from mailrelay-egress1.pub.mailoutpod2-cph3.one.com (mailrelay-egress1.pub.mailoutpod2-cph3.one.com [46.30.211.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776F02C1589
	for <dwarves@vger.kernel.org>; Wed,  7 Jan 2026 21:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767821410; cv=none; b=tWf2+2X1d7XrA1/zO1t8IAUDIZLqLYfAs7J/35XRkgCNuHCbZ3GuAPrkHu6jTXO5YChjo9dfk8ZdVhM19c4jAKeiIvmpnJb7pbiw78wVWfVVd+BhPetzLpy4iYBkPplnbhaDSdPc6dwDjl5uP7PWvqkZX7Z3Scx9ldXlEAFOqHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767821410; c=relaxed/simple;
	bh=oq6Dpi4gfzP4PX2htJ8BmIRbIBm9yRl7WIaGkfYFOXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rUZOqUnMSqw0MPSdIt7m3lvDu6lLiJNMiIZkhMAC4drqvWmiCALF8KHzi+FNdawmJA9PGdvG4KnPhB/ymK3Ipu3GedEDEyoJpve8iS13mOQH2dGdtWE+DBrpUJalJVZfIHG+H8US71WDJ7UEwJK5dYPwNV0Cr5ODLrFpyMFCCZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pfft.no; spf=pass smtp.mailfrom=pfft.no; dkim=pass (2048-bit key) header.d=pfft.no header.i=@pfft.no header.b=FW88zBgV; dkim=permerror (0-bit key) header.d=pfft.no header.i=@pfft.no header.b=OoglKw+Z; arc=none smtp.client-ip=46.30.211.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pfft.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pfft.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pfft.no header.i=@pfft.no header.b="FW88zBgV";
	dkim=permerror (0-bit key) header.d=pfft.no header.i=@pfft.no header.b="OoglKw+Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767821395; x=1768426195;
	d=pfft.no; s=rsa2;
	h=content-transfer-encoding:content-type:mime-version:message-id:date:subject:
	 cc:to:from:from;
	bh=U169QD8nUVS/+bG4bk63ApoOPLRJhA+/VL4+1pFeCV4=;
	b=FW88zBgVEOnnFts4HhLTVtQxx9xOR/nZD4ZkitsnBp6hKZPBqkhwqfPj8qk8jAg4ntzPqQVW/OGiE
	 QnaxilVVhHy28x1GdjzNuY29fFE1UWahFboWNnkK1C7Z3yy9i+r0KtkiC7l7e6DXeo0Py4zQ6hwRX3
	 xuvLPgd54xAxMTcupnlUcQvZaqPsUhbWsZwWq78tUNQE7lCGnzSbkXDi5BSEo98yxR0TeRUPRAL6RC
	 Pw+jLhYVs3v332XOnEll6Zn8YUSqPf2mzcKHrYiDg9WyNsoaQlvwN67Ws6bipbUB3Qsjxt+suDD/qp
	 K/pep9jGiV+xnwpGStbtuBN0Rs59g6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767821395; x=1768426195;
	d=pfft.no; s=ed2;
	h=content-transfer-encoding:content-type:mime-version:message-id:date:subject:
	 cc:to:from:from;
	bh=U169QD8nUVS/+bG4bk63ApoOPLRJhA+/VL4+1pFeCV4=;
	b=OoglKw+Z47Pp7ffDznhwa/q6ihTgvYLcnQ4mLPyzvjBrMXsrE9zzHuo2dUcrDq0Bg4q3dltUcObJ5
	 5POOzihBw==
X-HalOne-ID: 0248476c-ec10-11f0-bf39-632fe8569f3f
Received: from mailproxy3.cst.dirpod3-cph3.one.com (64.109-247-83.customer.lyse.net [109.247.83.64])
	by mailrelay2.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 0248476c-ec10-11f0-bf39-632fe8569f3f;
	Wed, 07 Jan 2026 21:29:55 +0000 (UTC)
From: =?UTF-8?q?H=C3=A5vard=20F=2E=20Aasen?= <havard.f.aasen@pfft.no>
To: dwarves@vger.kernel.org,
	acme@kernel.org,
	alan.maguire@oracle.com
Cc: =?UTF-8?q?H=C3=A5vard=20F=2E=20Aasen?= <havard.f.aasen@pfft.no>
Subject: [PATCH 0/1] elfcreator: Fix NULL dereference in remove_dyn()
Date: Wed,  7 Jan 2026 22:29:10 +0100
Message-ID: <20260107212912.1619603-1-havard.f.aasen@pfft.no>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

scncopy segfaults if it doesn't find any sections. The crash occurs
inside remove_dyn() when 'ctor->dynshdr' is null.

The attached patch adds a null check in the function where the
segmentation fault occurs. The calling function could also benefit
from stronger validity checks to prevent this crash in the first place.

Whats happens is that in generic_dyn_fixup_fn(), and the two similar
functions rela_dyn_fixup_fn() and rel_dyn_fixup_fn(), both 'dyn' and
'shdr' may be null (see lines 191-192 in elfcreator.c). The if statement
implicitly assumes that 'dyn' is non-null in the else branch.

It's fairly straight forward to reproduce the issue. Any valid
executable should work: simply run scncopy with a section name that you
know does not exist.

The segmentation fault is as follows:
#0  0x0000555555555e9f in remove_dyn (ctor=0x55555555c3a0, idx=0) at /srv/git/pahole/elfcreator.c:162
#1  0x0000555555555fa2 in generic_dyn_fixup_fn (ctor=0x55555555c3a0, d_tag=4, scn=0x0) at /srv/git/pahole/elfcreator.c:194
#2  0x000055555555634c in fixup_dynamic (ctor=0x55555555c3a0) at /srv/git/pahole/elfcreator.c:264
#3  0x0000555555556476 in elfcreator_end (ctor=0x55555555c3a0) at /srv/git/pahole/elfcreator.c:289
#4  0x00005555555558cd in main (argc=6, argv=0x7fffffffde88) at /srv/git/pahole/scncopy.c:123

Håvard F. Aasen (1):
  elfcreator: Fix NULL dereference in remove_dyn()

 elfcreator.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.51.0

