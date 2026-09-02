Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFCC456E15
	for <dwarves@vger.kernel.org>; Wed,  2 Sep 2026 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368767; cv=none; b=fg4NN7u9ISCM0GO0d6FmX58E5dVorPRZRc47x1WhHkoZ+7wnax6m04ijjgENfRRe3zhy81d7QidN5rFOgDyljxeZReJ29Cc5FeqzBDAk8P2heH1TqJ325w+fLJdDG4cEk9f6joPGHnx8/cUaX6FTSn4FIXR78RXBk217FnDm7aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368767; c=relaxed/simple;
	bh=Qx2NULcsGoW3crKP0FMXFaN7Qr5TP7UpUjXywT4A2Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gHV0kGj0xuCWd0h7z83ULVQxC84sayABlWF3WuB9yRHOdwBytnjn3eRyzr3fPtB1rUGdJoIiuUcbaktsBKB2LzQFy+GSGbAaKZwtW0OOj3om502Au5QzSvrEsfUqdw2yiXssLWUgxtfJrcrGzBQJI85hraY91ezm+4x6H0XwAu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vy8FEHv5; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vy8FEHv5"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48433e9562bso252396f8f.3
        for <dwarves@vger.kernel.org>; Wed, 02 Sep 2026 10:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788368764; x=1788973564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B8aEJZnPiIPW6Dzkrlot9ZPZi50RaK3UWUucraBUsY4=;
        b=Vy8FEHv5AOVIpPuYSKmd7peitmujn5dB8EnsKIf6257i0O1iaNNvwlWriRHLW9c2Hj
         KT156FZRc+BjLQ8d1PqIo7YpYrcAAI3xBxE13OSEH+63J0ma7oxr5IKJq5zT/JK7ZBBx
         SUzt8Ak+cVymFv9UtRXX2uOff1aC+nXs4qEA9+82oqr8spBYg0Wosz0lgTePlM7tAkNW
         dS7Mk8cTt499dMkfsekKzrNLOHu7nCndFhlToCz0eoUnpVdvBHAcvjNdBy98jRd7VPhc
         WGQQvJpBBTdr8aDgU5YrWy9P6CLgxlQLWrvqv4fbNf8Xw5nOvcOLvPV4gpW/8rOz8k/c
         P6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788368764; x=1788973564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B8aEJZnPiIPW6Dzkrlot9ZPZi50RaK3UWUucraBUsY4=;
        b=PXsDejPzfePUDJm6wBbe63wL/vabim/hqHTuafKI8a623DtqCkR95HOqUQ4BzO9hLm
         CXHjneXMC8mjInmSRb3hh9CbVJE8xsW1aTrRcmLEo1cvKJyRj89YnS9boxnslJelRB3T
         S8sjOPfS2C4pu6NsU19fsMpA5Tpt29OBiH0ctdtrWW8ftCuqbbmlTxhMqi+hx4rbMJA+
         OfDk+ne/4MqkV1YCxwwu7Av7jn3ZRo/enwXKxB+X8SV5N2d2cRuq9aIYpShX/KomMy2P
         V+K3GGJNxG5UwFQElpsHUEbxwbvzTWafwtnPrNfJRhENWTV37gEzMjHPTAEIJ0RgEw71
         cSew==
X-Forwarded-Encrypted: i=1; AKwUvByrMN75FtVihaTbXEc/xY3a6fj/azcLQ/6ZnkiCVRmmINNx+f8aCMbedvz2dOTriEYpfZ91BHlc@vger.kernel.org
X-Gm-Message-State: AFuF++lCmVQYiNxyxZijOWwX0Ex7t608cKSlasIkOSeeOiOZ3VbDd+HO
	TwI1v5X4YUbrKv2IqalpoJNYcL60Xjr8FPSJPNz0M5hFumfUZm6OVyna
X-Gm-Gg: AYBFou1q/yibGTzRsANUqDAWOcAc25B+J5gMZyCQW3up8OPPoG6PpI96qBK2L290xJ+
	uZRDqlJwsIJ6RykjhT+adco+v5d5yf6lw0hpADhnWznByt6dbdmUFXneWhalgJaQ6Cs5dmRzhgS
	aU/Dz1IKuSCSzKEqJonREQ9mm81NQZ8gzVcISiqyA1rFM8ZPJS539/JDuNr92zdSWDxwO4KhgUK
	0Bb9WvZ97NSAlFAQnja/R6fgRtLwETdWXtTnUGSaVctTSaHCjnnM/Zcm2uByTTnzL22cLPzsYt/
	ELCmjIAmgbQt5J6Xnu4vJtgSMRAmik8V8XH3DuzMG3I/rjxzdjzChcAbTY4jlg0G2DfbMTwnjtA
	uwkOD5EXOw2/OVTrZFMcy4Y43mxma+zJl2i4xnrbx8ZeW/TkE8VsfkMR54nMCSS/ADpSGb+cJ6b
	4gcvltIecHKJlWt8upBEPbm0af7YtiZ+8ae34bjnZ/e9isP+4lh6qjFZOKZ/kiG/zJpxFs1R9vP
	pn1oHUK6EN28BF8+76X4fToyn6r1PpkI5L3HezLk7ZU+lkll+yC9SXNYxwvTvHU+jk3buBY6U1i
	nmNs1BAcnmi1mbuSM/7R5UHV0Jr10wFsx2ulBlIdX6OjkzQ=
X-Received: by 2002:a05:6000:40d9:b0:481:bb82:3f31 with SMTP id ffacd0b85a97d-48488e03322mr13019439f8f.10.1788368763618;
        Wed, 02 Sep 2026 10:06:03 -0700 (PDT)
Received: from ip-10-0-1-42.eu-west-1.compute.internal (ec2-34-242-91-155.eu-west-1.compute.amazonaws.com. [34.242.91.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484492ce5e5sm7129345f8f.36.2026.09.02.10.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 10:06:02 -0700 (PDT)
From: Aditya Dutt <duttaditya18@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Aditya Dutt <duttaditya18@gmail.com>,
	dwarves@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves v2 0/3] pahole: Fix --unions bypassing the struct-only options
Date: Wed,  2 Sep 2026 17:05:55 +0000
Message-ID: <cover.1788368236.git.duttaditya18@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split into three independent patches as you asked, so any of them can be
picked up or dropped on its own:

  1/3 --unions --packable segfault fix with the Fixes: tag
  2/3 add flexible array options, to the struct only check
  3/3 stop ignoring the struct-only filters.

v1: https://lore.kernel.org/dwarves/20260831185641.971022-1-duttaditya18@gmail.com/

Holes and padding in the structs inside a union can be found with
'pahole -a -A.' Details are in my reply on the v1 thread.

Would a '--recursive' modifier make sense? The hole and padding filters
don't look inside member structs currently. Optionally with a depth like
'--recursive=2'.

Aditya Dutt (3):
  pahole: Fix --unions --packable segfault
  pahole: Don't match unions with --with_flexible_array
  pahole: Apply the struct-only filters to unions

 pahole.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

-- 
2.50.1

