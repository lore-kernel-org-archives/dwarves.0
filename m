Received: from mailrelay-egress1.pub.mailoutpod2-cph3.one.com (mailrelay-egress1.pub.mailoutpod2-cph3.one.com [46.30.211.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899EB2C326B
	for <dwarves@vger.kernel.org>; Wed,  7 Jan 2026 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767821414; cv=none; b=K2q67bZCLJdpwLxrvYKOVNPrrecnLeNKJ7gv+8JmGDLdIAweDogejMSXwD9RiFCL/no4ItMG+Sm3kRvipAvS9eJOr4pYyDyG1W3gbHOJSF+1fHIjQqdpZYyyR/pGg6QDToa9Z5BxUAfDF3/gM/2OIou8csJtG18nI261FP/1TXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767821414; c=relaxed/simple;
	bh=5/ZACVdKFYN5QCJgOsrIJnuo3LQ61SqeX7GJ7E0xByY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErcGVvkQkKJgPuI8CG12Xb00cPOymcLXvQb6q+PPNivpiXzjW7G2VbedDddvVT+zldJ4npzPc2hxoIb+Zl5wt/38tLeqHHJ4WvAd4dh81qsC88OJAGLtg9tjgifOrwbMWTQ/d/qOgXicProIs9WZEsO8xSA9fm6Wm80q4658Teo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pfft.no; spf=pass smtp.mailfrom=pfft.no; dkim=pass (2048-bit key) header.d=pfft.no header.i=@pfft.no header.b=nxTZoTAd; dkim=permerror (0-bit key) header.d=pfft.no header.i=@pfft.no header.b=dB9AlMXd; arc=none smtp.client-ip=46.30.211.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pfft.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pfft.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pfft.no header.i=@pfft.no header.b="nxTZoTAd";
	dkim=permerror (0-bit key) header.d=pfft.no header.i=@pfft.no header.b="dB9AlMXd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767821408; x=1768426208;
	d=pfft.no; s=rsa2;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=HZHCQcifOfCgON17goWuf1vIE9aghrZ/k87MIG3uzCY=;
	b=nxTZoTAdFm7VDZ/J8TGc5r9dm1pxEZA5P+vY7QDxnojRrkI6Ak2qfe+C0NAiWN+P8EOKlIeHu0fiS
	 JdTZY4ni2olY7yjTTyTVN88cgiv+N3wEeZ1euGP6E/eYtaQ9OM8/4djLRQjAXN6Evde297Y5Qdd+6h
	 ftSUNNab+E1ZHwdpYPA9jX7n8SVFsQi9e3z2ylTqvIoBIyZs5404ULNxSrKn0RPbVbBEZVmoia9aC5
	 TZBxGdaSyWZqHljIcdelJx89rPqsQ/hJQHD6iwFIrtRKMd0iorCkNVzzonV7hpVzxa9FSVs6gzNBpB
	 bQxB5VApCLR6p5KTjkAFrMmUFJtbQhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767821408; x=1768426208;
	d=pfft.no; s=ed2;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=HZHCQcifOfCgON17goWuf1vIE9aghrZ/k87MIG3uzCY=;
	b=dB9AlMXdsNdfi/gMJvuMdxgi3bjS3yvivE8hyIef4L/bLVjjzsbIqsA+wSI49oZgmQUEr/1Bh9diR
	 XauVutFBg==
X-HalOne-ID: 0a1195da-ec10-11f0-bf1f-fb5fec76084d
Received: from mailproxy5.cst.dirpod4-cph3.one.com (64.109-247-83.customer.lyse.net [109.247.83.64])
	by mailrelay3.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 0a1195da-ec10-11f0-bf1f-fb5fec76084d;
	Wed, 07 Jan 2026 21:30:08 +0000 (UTC)
From: =?UTF-8?q?H=C3=A5vard=20F=2E=20Aasen?= <havard.f.aasen@pfft.no>
To: dwarves@vger.kernel.org,
	acme@kernel.org,
	alan.maguire@oracle.com
Cc: =?UTF-8?q?H=C3=A5vard=20F=2E=20Aasen?= <havard.f.aasen@pfft.no>
Subject: [PATCH 1/1] Fix segmentation fault in remove_dyn()
Date: Wed,  7 Jan 2026 22:29:12 +0100
Message-ID: <20260107212912.1619603-3-havard.f.aasen@pfft.no>
In-Reply-To: <20260107212912.1619603-1-havard.f.aasen@pfft.no>
References: <20260107212912.1619603-1-havard.f.aasen@pfft.no>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 elfcreator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/elfcreator.c b/elfcreator.c
index 8e775c5..ea8326f 100644
--- a/elfcreator.c
+++ b/elfcreator.c
@@ -159,6 +159,9 @@ static void remove_dyn(ElfCreator *ctor, size_t idx)
 {
 	size_t cnt;
 
+	if (!ctor->dyndata)
+		return;
+
 	for (cnt = idx; cnt < ctor->dynshdr->sh_size/ctor->dynshdr->sh_entsize;
 			cnt++) {
 		GElf_Dyn *dyn, dyn_mem;
-- 
2.51.0

