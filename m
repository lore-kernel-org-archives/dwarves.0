Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECAD4AD4B1
	for <dwarves@vger.kernel.org>; Wed,  2 Sep 2026 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368768; cv=none; b=qg9cjKk2o0lCWS5xDNHLF639+PSRz6u8vhZkzzbrIr1D9AodlJsdve6emvoX0/+HJfLq2UXVlF1bHWdzrpkFNj81wWDnmFt2DYWYGyvZpTSuzQ+J/Y7SumPnC/PoTbkc2Y9ceLkeF1biBa4gymathCqjQm8lws+5ZUk9UWM0Wfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368768; c=relaxed/simple;
	bh=4Uq30zMq1xkRL85ZL6ysozRimZus2iINLbdQJaX80eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1dQ8eCFO+Lqot3XT/gNY8azorDvZmYF2C9GLw4Cv9xKpZsXChxNDbyJeKpMCGI4pZhmxAplmmipa5FNJxZo1Ro8B9Nm/YSaKTIbj2fz7HreLggv79Wr8JAOatC499FShdiKlasfadd7x/xschY8ju4nbOKxsStVkJQ3DKHw5ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=skPpNKX8; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skPpNKX8"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-482f9309813so1311552f8f.1
        for <dwarves@vger.kernel.org>; Wed, 02 Sep 2026 10:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788368765; x=1788973565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oDz0zqN3K6sxgGtnk4oNptW55pYp5u4+eesJhYn3JHQ=;
        b=skPpNKX83qrrcQCK0do+m648MEzLgX6bu45viG4W/Ov48aDg+PoYLOnpJYMS5mYWmw
         7L/gVzBdte1PkhRbbBS3ioP7npU5i+ZHsAHMZXlAW+YV9wg5MG0Pf4Rz13ARU+m35M3X
         bWUV9urFemo4Rq8nqursl34qFy+sMBXXjxLSEib/3WuN4KU44ZPQeHrviDhDDDyWfD4s
         BH3LnSMysBookH/dea7zF/xdSbdMIpOc/yz2YpeXck/NiwI0KEuuFMIiJi3BSisavaRp
         +0Ks5aaqxIhbjAARw57wJV6pXVhVvgfZwakMJunpXlflbWECDArFxM32RguGJopyIFEj
         VciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788368765; x=1788973565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oDz0zqN3K6sxgGtnk4oNptW55pYp5u4+eesJhYn3JHQ=;
        b=r7OJs+8KYV+lCxwTi81XlP+d9atD6q8NB5OXeU7kLHp9ywESJVE7SAa3O9HfnSn0P2
         yQPbOFqK7IPJP3vPXFzj9HklJjQm2zH23uB3yfznO5k4oBUfsSILJEfNHRs2/LiajN08
         m758nFzbkPnPm2jAyx5ejkK98LsRXCa/SCZkXL0J/VJ5gxEgk8D0QPqQ6M1ie0FXz7KM
         4vXQq7hBl2qV2zKJr3bgQvd3Ss4+UbVoLhagPfS27HYbkxfcAXtCP2d446Wpeax90eOW
         qmphnbqY3qTg/ic97w1F/bEOcLXEJbwuL9BnManExLMjOFE17ZE3ARWpL6+kOjfxZq9g
         KRKA==
X-Forwarded-Encrypted: i=1; AKwUvBx5iTe0jERE3/VVfxA3mwr5eAPlDEWoGeBBSPNpTJEliBc790qIoITS/7PfNDP5TWmhuLAlaFaR@vger.kernel.org
X-Gm-Message-State: AFuF++l4NOTMHUXmEADygWLDnLCApcpF5rewAA31ZR5v6MpAwu/FFT2a
	2KhBiTDsuQcwFlcFxDvhBTnXnrgAGQ6TDNAouFvBhbhPgBJ/mHyKq12qI9itwnMJcIM=
X-Gm-Gg: AYBFou3GUrtyTnKmJUxwIF8iHBIy+uMWqngtl7pFMBHMFlaNUM8fllkaUHBfqZC952w
	nfn+38lRIk6bN9qsQG9Z7H2FjppHhpSuGDjYnEbNE2Nxi5FWEGiUhQ6zjDQ19Xp+F6hfh9jt1cw
	mhhIieHF32s5nSRcWvhgnbG+dI5qCoCqSYzO/pjBsShU35etH7XxIfsVo/3e3pjv1e73GM2m5Gm
	a72q9RBY7FBlR8wQgj5OOZdZMShoS+rLUY0WvbfTe6kPF5RIWzUgYVGYH3bJcGNgRYTIWgAKtf7
	xV12OBRy0k2ghGaJbp3Y1JIw6OjDSjwBImtC3aU9EOXrMO4jXsyKB+GrvGYktptZcxF8AWLDcae
	UEZPPSOa49GIQirQQSOqgu8HrdHlsOWzjkO+xYbIlbQ4stuN4xqREfexaAzorEQ2iLCB88DJ5L8
	G4rbrV5TcPJypC5C7lpBLfcGk+w549KMFV8911LVW1Dla9bk+YyOxtF0DBC7A3KFXMnA8MpxbG/
	01n/X7PPDjrToQDDgThMH23wqpbjRyf0QZ96avfu9aEQwqo1VAotYi92fVu5IiKxYjrKe2m+65i
	UEp+LUgrVBemMP1VpKF23CNYAoH+aqE4o/yF2Z2rd0Zg5iA=
X-Received: by 2002:a05:6000:290f:b0:484:3310:9ab0 with SMTP id ffacd0b85a97d-484914d8435mr10996764f8f.25.1788368764833;
        Wed, 02 Sep 2026 10:06:04 -0700 (PDT)
Received: from ip-10-0-1-42.eu-west-1.compute.internal (ec2-34-242-91-155.eu-west-1.compute.amazonaws.com. [34.242.91.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484492ce5e5sm7129345f8f.36.2026.09.02.10.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 10:06:04 -0700 (PDT)
From: Aditya Dutt <duttaditya18@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Aditya Dutt <duttaditya18@gmail.com>,
	dwarves@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves v2 1/3] pahole: Fix --unions --packable segfault
Date: Wed,  2 Sep 2026 17:05:56 +0000
Message-ID: <5350fce43d07a388706e3c90517fa12559075278.1788368236.git.duttaditya18@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1788368236.git.duttaditya18@gmail.com>
References: <cover.1788368236.git.duttaditya18@gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

print_packable_info() reads c->priv. That field lives in
'struct class', but a union is allocated by as a 'struct type'.
It reads past the end of the allocation.

  $ pahole --unions --packable
  Segmentation fault (core dumped)

So we return before the read.

Fixes: 3661f17d0b2cd56b ("pahole: Introduce --unions to consider just unions")
Signed-off-by: Aditya Dutt <duttaditya18@gmail.com>
---
 pahole.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/pahole.c b/pahole.c
index a1b3d4a..7ec4a74 100644
--- a/pahole.c
+++ b/pahole.c
@@ -462,6 +462,10 @@ static void class_formatter(struct class *class, struct cu *cu, uint32_t id)
 static void print_packable_info(struct class *c, struct cu *cu, uint32_t id)
 {
 	const struct tag *t = class__tag(c);
+
+	if (!tag__is_struct(t))
+		return;
+
 	const size_t orig_size = class__size(c);
 	const size_t new_size = class__size(c->priv);
 	const size_t savings = orig_size - new_size;
-- 
2.50.1

