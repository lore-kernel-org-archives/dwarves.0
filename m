Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A621097B
	for <dwarves@vger.kernel.org>; Thu, 19 Sep 2024 03:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726716671; cv=none; b=pkmbU16P4UoCoBUSHP69e2eSRvSTJeMgBXQn1VVaFblWoAqiId/aqWWE40N1R+U0ih2VyzEziDleEceHk/RoddrCRPzcVXIb9rt3MjGgCX2wtgo9mv4YtUBVr2e3h3zhVtZbjSOmBjEsP0dTEO4JvHtUcbWaxAUHVNSJm3PFTA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726716671; c=relaxed/simple;
	bh=Sw+/P839V+Xx36WSrJiAzabDmRIAVEe8btpSpdRd4xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZalZDvnOunj6g5xNqUg8rR9LFGvV8RnsuApoCYybKSOcom2GkDUqyJblWGevPptqtPpfxi1ThrgM8ZY6yrI2X6k3xR8BuLvS+fNGEgCTbU2Cw0gAtI1bHVMRnOpAdWr1rRSxzKA8ASW7cwaxy5vJWw1PNp1bgLEI39ZtsizOg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr; spf=none smtp.mailfrom=obs.cr; dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b=JZRkPI+H; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=obs.cr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="JZRkPI+H"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-82aa7c3b498so13697639f.1
        for <dwarves@vger.kernel.org>; Wed, 18 Sep 2024 20:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1726716668; x=1727321468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hig3tF1/OagpjjdPq/7SYd+gGozPfNfG01nZrKPZJDo=;
        b=JZRkPI+HXENWDAZMIZMCdjXKJzVCo49Pgix6Xfzo1sniJx+ejRYyDUo03FM/X3FHyb
         5JaZZefdNvDPMH7YNhXCIE3ixRniR3dr1TrR5T3LwdLCtRoAIWEJ2hmUmfyYOI8KgLYb
         hE9Lr+NfkttpzVsggZnKegm7JD0due961jZqh0EPvNlsSyt//7M4x8SDsrB7hYHfQRG1
         JXMo5RBivtFg4x2S2bWEn4QfV6E4dMBs1fVEm6WwNGFjDTQLLuRMaUbADT8u9YB97sr7
         eoo1sPAiqj5hmLENnRmVvPuyzEw3heTaH4fF70geP/o4DNSDbnO1Aa/htVDcisNP3Iya
         JMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726716668; x=1727321468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hig3tF1/OagpjjdPq/7SYd+gGozPfNfG01nZrKPZJDo=;
        b=Zl5KmibmkIUSLLzq1cOigM2yF2OO1KmCx5A/OAVBkDowBTsuHDFp4XCumjNTfpI9RU
         RXPB7kI/GdXIisUFrWX9f+RBU53ddU0IbIg3ak1MzrznXWUkcudyhPfpxwNOOGpN/791
         kPEZArtzaPNXFs/fOdzvqLqRpW5yMZ4GAQyYBL3ncyL5xmaw4u7lJQy+gGBdB95nQImC
         OlzvW5vjhdtIHYNKb6T5MhXa0WO4gxBSBuAAYB21QEtY+x8fBGwgzOS53s1LzUyuLKgR
         hLSgmWTWpcn8iXDez3XujWYJMB3v+13khgT8sfqdw+9aF62avXDeIaHp2hsUO+zMCUsU
         FPvQ==
X-Gm-Message-State: AOJu0YyElHhzWXRloL32tjO/61jgUN3Pg13B2QwTjL+MzCxY/Dz7oz66
	WJSCgg9yfNUV32wrSYhLjjbMhYnsm/lM6G/B97ODJHQbYWNT/EkkF8+xJnROc73//LGTccjIiFQ
	s
X-Google-Smtp-Source: AGHT+IG5D2UKNihJ19r8h2FNuHx5ILC+XATpQaoyGLS8XeRTFgHZWnouXtcxSZY5aW6RtrI8SLC4Ug==
X-Received: by 2002:a05:6602:1c8a:b0:82a:13f0:800d with SMTP id ca18e2360f4ac-831fbf8ccb9mr144677939f.5.1726716668228;
        Wed, 18 Sep 2024 20:31:08 -0700 (PDT)
Received: from ininer.rhod.uc.edu ([129.137.96.15])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82d4928d686sm298513239f.18.2024.09.18.20.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 20:31:07 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: dwarves@vger.kernel.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Subject: [PATCH 0/1 v2] Handle printing pointer modifiers correctly
Date: Wed, 18 Sep 2024 23:30:51 -0400
Message-ID: <20240919033057.2658569-1-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <4f09aa78-8a42-44dd-a685-37d6b9db7415@oracle.com>
References: <4f09aa78-8a42-44dd-a685-37d6b9db7415@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you to Alan for the excellent feedback. I am sorry that it took me
so long to incorporate it into a v2. 

I hope that Plumbers is going well!

Will Hawkins (1):
  dwarves_fprintf: Handle pointer qualifiers correctly

 dwarves_fprintf.c | 90 ++++++++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 40 deletions(-)

-- 
2.45.2

