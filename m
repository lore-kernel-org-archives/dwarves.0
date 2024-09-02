Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B469418454F
	for <dwarves@vger.kernel.org>; Mon,  2 Sep 2024 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275530; cv=none; b=HUgR4wEbI1SRaIm0GvXMBwUFq7Nz7WPzAiayaCs8BCynxmejjTeAix7wEHl3hZYn79rSFXr/PKZ64a+n+pgEVi/ia9J77AEd7qE/i9v/phPQpKLCkiOugKgFLo2bLsw7IKmUTxstkXjM4xNCl04NssoiGw5TJYwLQtDv94Zv0Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275530; c=relaxed/simple;
	bh=YkMmVpPE3UnxFbnAfNLrTNbYWBh8P6uJGwKSvTyvHfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lj5Zl16J/yx5FJM9Sd8QuYW4kESRQoChDtaqgJt7IOdsezf+nVXetX3pmq6e4Ty8BByfr9r/SUaJyWUlkdhuCGmjRuXY1LfoMtQnyc2/z41TJXtCJtisR3bt+6mh6Ydm2Ff9cLL439eNw+QfhPXCf1QT7suwAsseAWyw22z1j/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T+0O0sID; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+0O0sID"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725275527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fgkkXwPGvqNbyO6+nNm874z1yG55JBe5yWhxAYIgCXM=;
	b=T+0O0sIDRN76MJEsvyqCWp7S+5ZqbzB0La6LfS5IBbH+gYlWzTIu97Jf/kQPcQdklMnjxH
	dVB7szSv+MXG5Tthz74qOhidCr9lgzMPnrnHuBIr06q1rELM3H7RNFHzAnw7tlckwwwEym
	tOeoNsgAniEh2LSvdK0KQIVBxNOMiqQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-QVkUoB4jOFapqTI03qLcew-1; Mon,
 02 Sep 2024 07:12:05 -0400
X-MC-Unique: QVkUoB4jOFapqTI03qLcew-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFBC31955F43;
	Mon,  2 Sep 2024 11:12:04 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.225.95])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AAE61955F1B;
	Mon,  2 Sep 2024 11:12:02 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: acme@kernel.org
Cc: dwarves@vger.kernel.org,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH dwarves] dwarf_loader: Fix memleak in dwarf_cus__create_cu
Date: Mon,  2 Sep 2024 13:11:57 +0200
Message-ID: <20240902111157.748247-1-vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Coverity reports a possible memleak in `dwarf_cus__create_cu` due to
`cu` not being freed for the case when it was allocated but
`cu__set_common` failed. Fix the leak.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 dwarf_loader.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 04f5637..ad36e3c 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3378,8 +3378,10 @@ static struct dwarf_cu *dwarf_cus__create_cu(struct dwarf_cus *dcus, Dwarf_Die *
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

