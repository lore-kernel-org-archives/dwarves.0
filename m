Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5C41CDFDB
	for <dwarves@vger.kernel.org>; Tue,  3 Sep 2024 06:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725344644; cv=none; b=rV/sH04W3Q3zQ6W7H+MY5l2xiZyXQjDM9pNqQ/N9YuR8tyAQjL3TcGPLTxr7yVuLbK1SZVsZwE8ppXva1ILNMRp801H9BNdFyH6iZdQsfz/O6XZW+s4LZmu8ho6mmMNLK1EGZx3jggBqcikKbQH/biPR2KqYEx+EkSXSEpsUl4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725344644; c=relaxed/simple;
	bh=3G8BV9qJS4DlmAZ0GdwqzNo+EXqQTc9qjmOgPlzcZfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lf79gT/RsqMQrXGZDOIsf4pLlhFR9rWeRdk7qwCSXaNEmN6bDXy3KnV74qC7Xuw8/z9TmWKo3pI5c67t734FXEyZ1R2wrf+/0AN94TIV6gow9vZKstxerzDlf+zvC6ErXzmnmyZRCocxy19ellw+6VRdl8AmBkx3CxU3OHZKUVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FVKRsXGr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVKRsXGr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725344641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7JG+UMu5uCjI0L95yRYUrH8JT6B8p8Um8NP4te3queA=;
	b=FVKRsXGr4sNCsxYw9LZOnsnYlQioyOn1QmkyA2ylioYskOOdSg7PrTRcmOs9k0/MinNb/5
	WVFpMA26fZrsRlPxofA3O4rNC9X6+2LptHODAedcWN3RTOwa0zDrIk3AAE2J7bQidkKYLI
	ZenEvpx2eP5kDXc9oNYDJ9w8bTwrHrg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-p2NW2v0IMz6-ybEXSh62vw-1; Tue,
 03 Sep 2024 02:23:59 -0400
X-MC-Unique: p2NW2v0IMz6-ybEXSh62vw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6CB421955BF6;
	Tue,  3 Sep 2024 06:23:58 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.186])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F96119560AA;
	Tue,  3 Sep 2024 06:23:56 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH v2] dwarf_loader: Fix memleaks in creating cus
Date: Tue,  3 Sep 2024 08:23:52 +0200
Message-ID: <20240903062352.763644-1-vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Coverity reports a possible memleak in dwarf_cus__create_cu due to cu
not being freed for the case when it was allocated but cu__set_common
failed. The same situation occurs in __cus_load_debug_types.

Fix the leaks.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 dwarf_loader.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 04f5637..065ed4d 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3247,11 +3247,14 @@ static int __cus__load_debug_types(struct cus *cus, struct conf_load *conf, Dwfl
 				     build_id_len, filename, conf->use_obstack);
 			if (cu == NULL ||
 			    cu__set_common(cu, conf, mod, elf) != 0) {
+				cu__delete(cu);
 				return DWARF_CB_ABORT;
 			}
 
-			if (dwarf_cu__init(dcup, cu) != 0)
+			if (dwarf_cu__init(dcup, cu) != 0) {
+				cu__delete(cu);
 				return DWARF_CB_ABORT;
+			}
 			dcup->cu = cu;
 			/* Funny hack.  */
 			dcup->type_unit = dcup;
@@ -3378,8 +3381,10 @@ static struct dwarf_cu *dwarf_cus__create_cu(struct dwarf_cus *dcus, Dwarf_Die *
 	 */
 	const char *name = attr_string(cu_die, DW_AT_name, dcus->conf);
 	struct cu *cu = cu__new(name ?: "", pointer_size, dcus->build_id, dcus->build_id_len, dcus->filename, dcus->conf->use_obstack);
-	if (cu == NULL || cu__set_common(cu, dcus->conf, dcus->mod, dcus->elf) != 0)
+	if (cu == NULL || cu__set_common(cu, dcus->conf, dcus->mod, dcus->elf) != 0) {
+		cu__delete(cu);
 		return NULL;
+	}
 
 	struct dwarf_cu *dcu = dwarf_cu__new(cu);
 
-- 
2.46.0

