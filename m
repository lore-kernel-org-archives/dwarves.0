Received: from mailrelay-egress1.pub.mailoutpod2-cph3.one.com (mailrelay-egress1.pub.mailoutpod2-cph3.one.com [46.30.211.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72295330644
	for <dwarves@vger.kernel.org>; Tue,  6 Jan 2026 18:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767723930; cv=none; b=SoxF1zrOfj0mjcdfL0uIw9P9eak1nZFUUZH69FYks5cKPYl9YDp57c1daeQ/dJeEAEgZkev4/R3cozKBoJo//nNW7d0OZQSuF2btevroJOPlLx/Jv68yyP80EWKFSEO18RKJ/Y/VTmoQgcj7k8tIPTpoO1i/J1qdzjPOw2lxacg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767723930; c=relaxed/simple;
	bh=Tu52tcCqvIpEYFKI7kkVnNwzXCinI2kI9SDGDnCZyws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nxOGu6dxxyebeKQxBFWQuk7EAV1ESOR9CqFn1N2N78rtT0iliDY4AoHsZvTOie/Jx1SB8dwyVCJgPgHOIPVamx5vv1i31fO67fdlJ9HR93aS62nG9UHD527/y0GHOr91AM0RQ0tKGxmxwx21Uzwp5gZNBXgdtTzpJvrfKz7tXJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pfft.no; spf=pass smtp.mailfrom=pfft.no; dkim=pass (2048-bit key) header.d=pfft.no header.i=@pfft.no header.b=r1AXjgNa; dkim=permerror (0-bit key) header.d=pfft.no header.i=@pfft.no header.b=9FjU1JH7; arc=none smtp.client-ip=46.30.211.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pfft.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pfft.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pfft.no header.i=@pfft.no header.b="r1AXjgNa";
	dkim=permerror (0-bit key) header.d=pfft.no header.i=@pfft.no header.b="9FjU1JH7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767723854; x=1768328654;
	d=pfft.no; s=rsa2;
	h=content-transfer-encoding:content-type:mime-version:message-id:date:subject:
	 cc:to:from:from;
	bh=yd7w3ETnJm/aNN8J18wIECXKCDF1nTQ2NP5I8F1jyhg=;
	b=r1AXjgNa9uBumRFLJSxskansipT0B2F26OR5yqoM4khSj+LvI/ysiEov8fBSUYgbluJX4lY0xoBz6
	 wIaGoogjo0MMT6+cSeBj3LMuNuXaLYrqEMtAkh97VtBvcui/jmdLlKffg+gNbcmN5IE+U9FoE/sw2W
	 berWyl3f5KPzPKYk63GK/v/j8x9AO2cqtLd/Uo7AuKhBCXpRfoGBV3d76skAQyNca8Odl8lyMP1ki7
	 OBNQc0sepg57z2so92ck+ie35ZA3kGlS9J1294g//jZjLvvL6+E5E90VhnSH1WfDHTJUT+0Vo1ADLg
	 07PitJTBTP2r7FmlGgAJfS7D/M9rHTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767723854; x=1768328654;
	d=pfft.no; s=ed2;
	h=content-transfer-encoding:content-type:mime-version:message-id:date:subject:
	 cc:to:from:from;
	bh=yd7w3ETnJm/aNN8J18wIECXKCDF1nTQ2NP5I8F1jyhg=;
	b=9FjU1JH7kIdbVE7HT6LgtRfXzG+NX5tprGBi1ANz8hfiG3zy0SBdjLgBGfQP17epD67C4VpOA8kpD
	 pNnFcRSCA==
X-HalOne-ID: e6e0e9db-eb2c-11f0-a052-494313b7f784
Received: from mailproxy5.cst.dirpod3-cph3.one.com (64.109-247-83.customer.lyse.net [109.247.83.64])
	by mailrelay6.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id e6e0e9db-eb2c-11f0-a052-494313b7f784;
	Tue, 06 Jan 2026 18:24:14 +0000 (UTC)
From: =?UTF-8?q?H=C3=A5vard=20F=2E=20Aasen?= <havard.f.aasen@pfft.no>
To: dwarves@vger.kernel.org
Cc: =?UTF-8?q?H=C3=A5vard=20F=2E=20Aasen?= <havard.f.aasen@pfft.no>
Subject: [PATCH] scncopy: Fix error handling when opening file
Date: Tue,  6 Jan 2026 19:23:54 +0100
Message-ID: <20260106182354.1579350-1-havard.f.aasen@pfft.no>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The original code tested '!fd', which treated fd=-1 as success. The if
statement has been updated to fail on any negative integer.

Signed-off-by: Håvard F. Aasen <havard.f.aasen@pfft.no>
---
 scncopy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scncopy.c b/scncopy.c
index 233cae2..d87b2b9 100644
--- a/scncopy.c
+++ b/scncopy.c
@@ -80,7 +80,7 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
-	if (!(fd = open(infile, O_RDONLY))) {
+	if ((fd = open(infile, O_RDONLY)) < 0) {
 		fprintf(stderr, "Could not open \"%s\" for reading: %m\n", infile);
 		return 1;
 	}
-- 
2.51.0

