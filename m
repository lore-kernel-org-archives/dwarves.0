Received: from mailrelay-egress1.pub.mailoutpod2-cph3.one.com (mailrelay-egress1.pub.mailoutpod2-cph3.one.com [46.30.211.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8940429ACFD
	for <dwarves@vger.kernel.org>; Wed,  7 Jan 2026 21:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767821412; cv=none; b=osDJjA/FkIHNG+O1687/P/dSVtwNZ4s+g6wsjFquxbFpi1POsnuP1qdwHP/hJUhY0i3OoLynYWV0h8SrLUsmcfMofGw14DVXLata3iTwYQBt7WMZ7RpFmG/VkQq1CGMkP4a/iex8aUSLsH4JBjYjMLzh5GTYoG8qjgUd3bboZJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767821412; c=relaxed/simple;
	bh=l1TLzAmZfM3LA553dWwWaKk9P7eGRyO4lBJ1RDsAG1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJPZv8vLMGSOy+JJVnBRn/8af6O63JhKhzqB1fwXyleypIYCOs/tgjIOlWdt9EnK6KkR+2sZxxpluxXfywsjqwU/ZyqLSFXbNa+WdajwtD/Em2VL336+GrT2w7oEobX4snBG6MPv1xRe7zewZI9Pwd61rSQQz91upqYIOtMIkYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pfft.no; spf=pass smtp.mailfrom=pfft.no; dkim=pass (2048-bit key) header.d=pfft.no header.i=@pfft.no header.b=ZSxxjS8e; dkim=permerror (0-bit key) header.d=pfft.no header.i=@pfft.no header.b=U0WtPWvq; arc=none smtp.client-ip=46.30.211.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pfft.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pfft.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pfft.no header.i=@pfft.no header.b="ZSxxjS8e";
	dkim=permerror (0-bit key) header.d=pfft.no header.i=@pfft.no header.b="U0WtPWvq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767821400; x=1768426200;
	d=pfft.no; s=rsa2;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:date:subject:cc:to:from:from;
	bh=O+4hWsK2Ew4IE9s+Gxj5N8emiKVMsuFnv8+Wy0a84Mg=;
	b=ZSxxjS8eVeUiIbBR0aiW4mQA8KR8g4eFg8I2uBqR6h7gg89MgnfjHxAvWltvzgh8C5TnMA4RCaplY
	 xsHUqGBZWZXatPiFBDd9yPCG0XZV8m+rwYNoDZghVUSsSQVU4mMtjkphZqjhNynaO3em4mqBjFmC3u
	 jRfaer5Ef7rdEWr/fOuql/it3NrW6Vs75qS3i7UbEg1fFShxYMIaJ+xeIVj0k1ZnPmv8LoWJsQxBQ0
	 oRGFkFwrb0Osex2D2ek4zgkHFUt+AjXZWu2dlCSY19UwfKR0vJfg6Ooq+QQCUT5MkIZPOmW+3PNnnC
	 3lHxGm6Pu87GrI2BXonOi3zkeMz/VUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767821400; x=1768426200;
	d=pfft.no; s=ed2;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:date:subject:cc:to:from:from;
	bh=O+4hWsK2Ew4IE9s+Gxj5N8emiKVMsuFnv8+Wy0a84Mg=;
	b=U0WtPWvq4qRSchB1YDq2uzNy9T2ZB5rpwmjaG3+0rEsIQpXLhzwDCDlbCWxtu+RQ+LCk7u3S8aVk8
	 xH1RuJKAA==
X-HalOne-ID: 05400457-ec10-11f0-b284-d510462faafc
Received: from mailproxy2.cst.dirpod3-cph3.one.com (64.109-247-83.customer.lyse.net [109.247.83.64])
	by mailrelay4.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 05400457-ec10-11f0-b284-d510462faafc;
	Wed, 07 Jan 2026 21:30:00 +0000 (UTC)
From: =?UTF-8?q?H=C3=A5vard=20F=2E=20Aasen?= <havard.f.aasen@pfft.no>
To: dwarves@vger.kernel.org,
	acme@kernel.org,
	alan.maguire@oracle.com
Cc: =?UTF-8?q?H=C3=A5vard=20F=2E=20Aasen?= <havard.f.aasen@pfft.no>
Subject: [PATCH 1/1] elfcreator: Fix NULL dereference in remove_dyn()
Date: Wed,  7 Jan 2026 22:29:11 +0100
Message-ID: <20260107212912.1619603-2-havard.f.aasen@pfft.no>
In-Reply-To: <20260107212912.1619603-1-havard.f.aasen@pfft.no>
References: <20260107212912.1619603-1-havard.f.aasen@pfft.no>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

scncopy segfaults when the requested section does not exist. In this
case, generic_dyn_fixup_fn() (and the related rela_dyn_fixup_fn() and
rel_dyn_fixup_fn()) may receive both a NULL 'dyn' and a NULL 'shdr'.
The code only checks 'shdr' and implicitly assumes 'dyn' is valid in
the else branch.

This leads to a NULL dereference in remove_dyn() when ctor->dynshdr is
NULL.

Add a NULL check to prevent the crash.

Signed-off-by: Håvard F. Aasen <havard.f.aasen@pfft.no>
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

