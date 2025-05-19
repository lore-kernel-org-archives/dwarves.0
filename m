Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com [46.235.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6E12874FF
	for <dwarves@vger.kernel.org>; Mon, 19 May 2025 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747671072; cv=none; b=o84vSy1zj1aWPh5HB1dp56aFZHpSWACbxoAFvbO0T5ylSgCC+oZz6MYh8VC4Szl899nXmEiTMYkBbTRobfdTFQ2czs5ZNZ/de7Iv7WA1pVe1gulg9HY2nHygN0obL7Nv64xo41K9AAC+dG+q9YkVFjIRvHxVanHI/KVs+LwWSbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747671072; c=relaxed/simple;
	bh=v4C5JkXGz4+8f4nXy8bfwiC5nxnwZOv//TfAEDq7thI=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=CbdM04MJf81YSgR2nmOEUaDdCY55fCV7lQCnEGg1p11n21kTV5jzQBnlDrheTy9qoaZMITC8w6XVbcz+TnHlioDZpUWietHfQGYoZgoUUS2ZobYt0152e4knFFepjTJA9dvAPXyf2U1CsOUN7irycKfTOVJeDhPgPKkzvd4Dhqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pfrost.me; spf=pass smtp.mailfrom=pfrost.me; arc=none smtp.client-ip=46.235.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pfrost.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pfrost.me
Received: from [2a00:1098:86::12:1] (port=48922 helo=webmailb.vs.mythic-beasts.com)
	by mailhub-cam-d.mythic-beasts.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mail@pfrost.me>)
	id 1uH2NP-005oQq-Rf
	for dwarves@vger.kernel.org; Mon, 19 May 2025 16:26:04 +0100
Received: from localhost ([::1] helo=webmail.mythic-beasts.com)
	by webmailb.vs.mythic-beasts.com with esmtp (Exim 4.94.2)
	(envelope-from <mail@pfrost.me>)
	id 1uH2NN-002cCd-0o
	for dwarves@vger.kernel.org; Mon, 19 May 2025 16:26:01 +0100
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 May 2025 16:26:00 +0100
From: mail@pfrost.me
To: dwarves@vger.kernel.org
Subject: [PATCH] Fix pahole segfault with --show_reorg_steps option
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <09ac48cbfa5425e618d793b919c129e1@pfrost.me>
X-Sender: mail@pfrost.me
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

This function call seems to mistakenly use conf directly rather than 
cconf
which protects against conf being null

This makes pahole segfault seemingly whenever --show_reorg_steps is 
used,
for example: ./pahole -R -S -C task_struct

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
2.39.2

