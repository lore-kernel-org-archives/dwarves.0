Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com [46.235.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7601DA61B
	for <dwarves@vger.kernel.org>; Tue, 20 May 2025 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747736012; cv=none; b=Nfb0Ze+1KFcay/e2wQ3ut97M3T+txCEsk9SQgaRVr/tmpSoM2pBU2YrJ/n7BUFOayy8DSncJHu3ysAtVXV0iDr3T8RnAAsBTwBxyhrznIZN0x4X7CBkjK/QYsOWlwNScJPwiKsD3QnYbifCPDRC3OwtNzR/l5YZhQeSwIuZ0zmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747736012; c=relaxed/simple;
	bh=skmzzW9rjGArLNNUhNvgWwkoiB1mn7rVnTCA0gyBokk=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=UTq4R8X50FbyLZ6nJTdcNN1uCXKEC5zssIYehZPwiFq8T3NOzmp9sJAI3gkf+UwIf0CkoAbWLgF1po2Eq3R4fKX7JrekTCYowWOAz6PUxmd1yBlKDo7ZyD3xDJaCqQLo015vcc/SUObMvXFs6yHy+Kqf+wkkP0+au3lAYXjdxEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pfrost.me; spf=pass smtp.mailfrom=pfrost.me; arc=none smtp.client-ip=46.235.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pfrost.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pfrost.me
Received: from [2a00:1098:86::12:1] (port=33086 helo=webmailb.vs.mythic-beasts.com)
	by mailhub-cam-d.mythic-beasts.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mail@pfrost.me>)
	id 1uHJyS-00EhFK-Lg
	for dwarves@vger.kernel.org; Tue, 20 May 2025 11:13:28 +0100
Received: from localhost ([::1] helo=webmail.mythic-beasts.com)
	by webmailb.vs.mythic-beasts.com with esmtp (Exim 4.94.2)
	(envelope-from <mail@pfrost.me>)
	id 1uHJyS-002ucG-7Q
	for dwarves@vger.kernel.org; Tue, 20 May 2025 11:13:28 +0100
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 20 May 2025 11:13:28 +0100
From: mail@pfrost.me
To: dwarves@vger.kernel.org
Subject: [PATCH v2] Fix pahole segfault with --show_reorg_steps option
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <c2308f16f78150e43529fd5ecc58bcfb@pfrost.me>
X-Sender: mail@pfrost.me
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

This function call seems to mistakenly use conf directly rather than 
cconf which protects against conf being null

This makes pahole segfault seemingly whenever --show_reorg_steps is 
used, for example: ./pahole -R -S -C task_struct

Signed-off-by: Peter Frost <mail@pfrost.me>
---
  dwarves_fprintf.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index 4407fd1..1ec478c 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -2007,7 +2007,7 @@ next_member:

  		printed += fprintf(fp, " */\n");
  	}
-	cacheline = (cconf.base_offset + type->size) % 
conf_fprintf__cacheline_size(conf);
+	cacheline = (cconf.base_offset + type->size) % 
conf_fprintf__cacheline_size(&cconf);
  	if (cacheline != 0)
  		printed += fprintf(fp, "%.*s/* last cacheline: %u bytes */\n",
  				   cconf.indent, tabs,
-- 
2.39.5

