Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBDA50C2BC
	for <dwarves@vger.kernel.org>; Thu,  3 Sep 2026 20:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788469071; cv=none; b=Hl6vlVmbB8eRhIGNMxRocqgwwRu9z7I1P2HwRFDD28bvlBO4Bdt9OptqVhqzvzBTTA0dJ/WwoNpMKbm3WDwcFzeHW0UK8JgL0dA7OxL8mJcCZKTKs+SuzD6cq3dwIfvZ9rYtPbrVPJpiyaG4KlmkiitO04Sxu9ICCyiwEvC54Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788469071; c=relaxed/simple;
	bh=wIT3ce8XVMOwsR2tTNRA2aNpDszPKstYyE/2+d/Nljg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EpxHMMn91eJ4chk7n9aq3MGulBgn4aDVkd77EUZRyULAvayY7XJM1UHBoNcue3+APTD9F3hjOGWE4VA9qo/7qNH7xk+rDuqCH5JcJCnX7nHxODmQpFLkM6FrC/mJjyq7/DBTumf9bmaTGU25WBZMQ13GBVLHM7y2eCxY2mYc9jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJeqhh7z; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJeqhh7z"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc1c9879395so346398a12.1
        for <dwarves@vger.kernel.org>; Thu, 03 Sep 2026 13:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788469063; x=1789073863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ROBhFbx9oy5g8gcSMzygHSPcRfMebznh7UGYcW16als=;
        b=BJeqhh7zt4jrLfnT2hIhH1U5LrLqjap41wbQjUg/vBf5/SXpwCRr79NrfY1vvIcwWg
         qJiVum9ZNPv52I6Js6nY2waJ3gJxJkoOrvrAewW1mBVhp836E9QW47eeVyWrr8NZgtxy
         rRu8o6zEFLft+0nbdYiLemD2CiqWxK6H7th0XCmg7PIx9xYUlqqlOHtEJz/m30Vpvy4e
         7ZSr+wxjKYkDY3HJgb3QwLNtZuBtvykbQn0SG2zr0UU8c+LnOwxSAxDLarO1zEIpHE2e
         qdRmYmLgM7FpgAOJqD/trRGUcSjqmrTqjeZaZXLAbUJCN3iHlEq/QRDLcjzA7EuKc34X
         DVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788469063; x=1789073863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ROBhFbx9oy5g8gcSMzygHSPcRfMebznh7UGYcW16als=;
        b=AYXCz/hWvU8mHjZbQdK33QF9gEhfiv7N9cpee8VKU/XTMAhCliIzJ49WEYIkf4ZgKN
         E7+HRwXFbEyA8U7VKvDk+lc65OQPj4tfrtUGSY6NwFgZuJEyKmqrXz1MvLCULijqDauw
         /zDep+lu/1vMmHKlLN5ZzarfSeoAtjsHpkmGB3rS0p4SjuhjAIf1oeAcHGkYvvUcgeBL
         bq3bkNeJ13GvKujqdwQCNz2QK8Ec7yAf+uoYJOjiSCUTXauHr8vlr/MFvc44WBe5Yug/
         UdDVCk7W0WetxBBtw+OfblFrxUdjq1rTODgbTSGfhuYCCwP1uMjLEzLvpcVMlq0sY+pi
         yaeg==
X-Forwarded-Encrypted: i=1; AKwUvBzIyqDZHzTBxIZx9cbh1r9gj4DSD6qxSpD9H4w8yNC6Yf8Kd0NCFjrclwZVUzeLGkVtvk0wVVhx@vger.kernel.org
X-Gm-Message-State: AFuF++mECyBeaCoh7iYiV+aM083g1O+oXMH2YiMn/bAxzpVvyiu3rEzN
	gpqNM4FLNi/dgVQnJMLS0HQNj7oASVLOI+WeLlKhonRO/9heDE8Kp9v1rYiKQ0HK
X-Gm-Gg: AYBFou1ep83yqvJPId36KJ/5tktKQE/Bz5tPMqrS3JArG7YAjWuX3bgywJKq9oDbEmF
	GVtkan/ymt+T9zDwDW/9WWxZUIZgXFlrPSXMxwYtwedXbsnH3buV3FqzXvPB/E8beNbME6LEjUL
	3f4zuv/fbuViN0S/FasKFOKSwlpuMqT3t+rub1qTozHkS91tP+x+Yt2AKcD0T4ohrkdCSoFwOTx
	hhYM+ffPWRvtwugQs0j0Fk/3G872yRmCGmGnCAcC/IjflIyYSYjxip8sDEQX96BO/gM7Ah/XbBm
	Xkwm+3DoThIC4krSdBZ3Blk6Vz9GahDejPoDbpwRz4/pztCsq7uM467yEMw6+0tKA3s44PPQerd
	CmjyNnBGG7Meu8qTkHAR3XHuK6PmXolOeNCUm8w22wHHs1r6oirQlNu6bRHYyMMeXp9USuvsvyI
	NXVRkQDli4pcaV1e0hlaYTj3QV25Wp5jUfCaJqVIwlWYAJ/aCgHYnqCjIfp7d6j3G+1UswxB9Up
	sXtETopZW4GFotWRRU4mxuLj8ueVw6O
X-Received: by 2002:a17:90b:3b52:b0:38f:18f9:785 with SMTP id 98e67ed59e1d1-39b26101d25mr1658699a91.8.1788469062576;
        Thu, 03 Sep 2026 13:57:42 -0700 (PDT)
Received: from pop-os.. ([106.219.234.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260cd15asm753185a91.4.2026.09.03.13.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 13:57:42 -0700 (PDT)
From: Aditya Dutt <duttaditya18@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Aditya Dutt <duttaditya18@gmail.com>,
	dwarves@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves 0/2] pahole: Fix -C -T segfault
Date: Fri,  4 Sep 2026 02:26:57 +0530
Message-Id: <20260903205659.1543175-1-duttaditya18@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'formatter' is NULL when -T is given and the -C path calls it, which
segfaults.
Patch 2 rejects that, like '-m -C' already does.
Patch 1 fixes the '-m -C' error, which names '--class' incorrectly.

-T has set 'formatter' to NULL since commit 286c7740fd98c4df but -C did
not call formatter until f5857bd34b220a64 (used to call tag__fprintf
before), so added Fixes tag referencing it. 

I think support for the combinations '-T -C' and '-m -C' could be added
in the future.

Problem with doing that right now is that the counting logic lives in
the 'class_name == NULL' block that -C skips. And -C stops loading CUs
once all classes are found.

Aditya Dutt (2):
  pahole: Fix option name in the -m/-C error message
  pahole: Fix -C -T segfault

 pahole.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.34.1

