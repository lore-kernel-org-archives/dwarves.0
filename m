Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9FA15CD52;
	Tue,  2 Apr 2024 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086808; cv=none; b=TJBXxj6sxMg2WwmNtSXqzJnLeYltx/EKq4iac8djgqLMj5u3X3lKCRagUJMIqEJiBA/PWeckTxzbu8eGFbnRcUwAz8Ocabs4nWHHLNNW0FZMdnn/MzQw3k7rAaCxgpKxZOw5/HLDhszCJvuCh2q1j88D8sAdd0Pp8TbCgt3H/hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086808; c=relaxed/simple;
	bh=lZh+YT5icSodMOONQ1qbwDnaEbwSwsYdN6TXHDg3f48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqrtdc9KLW9Rod0m2+Vq+iOJfVbJo+KQh5XFzTqjwm0OWB5DWNMN/U85TaQqhFKYdf2fvYvSjhVp/bpaVpNpPkXlJrb5zc0e5DrHagvAlPJP6PRPi/S8fOUjFfH0+CLbUah3syPo63MBFRzOzTgqm2ZnBVr7+xPatC640s4FMw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaDuOm+D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaDuOm+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEFAC433F1;
	Tue,  2 Apr 2024 19:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086807;
	bh=lZh+YT5icSodMOONQ1qbwDnaEbwSwsYdN6TXHDg3f48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IaDuOm+DIey+v0ijVDwiCx48UOiVpKb3YT42D26ukW5mekbTLjqy3ltF4KLVUVrH1
	 u/4LmRaY44vKJYh+ryc6jYErpL88Swzf3wdeR1rUJOc2nQ80ptoMGnhEfi+E/Les6R
	 9jVo3kZDb3WfJQr9DeLrYb3F5eWTX6YxjuszNV+l3POfiV1SbscLk4MFOApG9rO7va
	 ZNyk8jMdlzpqM/uSo6P4OwEHeC0HvkI8yyKUIHiXR9RXYGHt0uF/1gf59tKZk2XzMb
	 /2kleNUoBhwfEeETM5noyrn1aJjx17ecBYMSY1r3bSBgguIwlVlvd/oNIrWTqD3eI5
	 r3c4l8WR3A0JA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: dwarves@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Kui-Feng Lee <kuifeng@fb.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 05/12] dwarf_loader: Create the cu/dcu pair in dwarf_cus__nextcu()
Date: Tue,  2 Apr 2024 16:39:38 -0300
Message-ID: <20240402193945.17327-6-acme@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402193945.17327-1-acme@kernel.org>
References: <20240402193945.17327-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

dwarf_cus__nextcu() is only used in parallel DWARF loading, and we want
to make sure that we preserve the order of the CUs in the DWARF file
being loaded, so move creating the cu/dcu to under that lock.

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Kui-Feng Lee <kuifeng@fb.com>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 5090509309446890..a7a8b2bea112ba75 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3254,7 +3254,9 @@ static int dwarf_cus__create_and_process_cu(struct dwarf_cus *dcus, Dwarf_Die *c
 	return dwarf_cus__process_cu(dcus, cu_die, dcu->cu, thr_data);
 }
 
-static int dwarf_cus__nextcu(struct dwarf_cus *dcus, Dwarf_Die *die_mem, Dwarf_Die **cu_die, uint8_t *pointer_size, uint8_t *offset_size)
+static int dwarf_cus__nextcu(struct dwarf_cus *dcus, struct dwarf_cu **dcu,
+			     Dwarf_Die *die_mem, Dwarf_Die **cu_die,
+			     uint8_t *pointer_size, uint8_t *offset_size)
 {
 	Dwarf_Off noff;
 	size_t cuhl;
@@ -3274,6 +3276,15 @@ static int dwarf_cus__nextcu(struct dwarf_cus *dcus, Dwarf_Die *die_mem, Dwarf_D
 			dcus->off = noff;
 	}
 
+	if (ret == 0 && *cu_die != NULL) {
+		*dcu = dwarf_cus__create_cu(dcus, *cu_die, *pointer_size);
+		if (*dcu == NULL) {
+			dcus->error = ENOMEM;
+			ret = -1;
+			goto out_unlock;
+		}
+	}
+
 out_unlock:
 	cus__unlock(dcus->cus);
 
@@ -3286,13 +3297,13 @@ static void *dwarf_cus__process_cu_thread(void *arg)
 	struct dwarf_cus *dcus = dthr->dcus;
 	uint8_t pointer_size, offset_size;
 	Dwarf_Die die_mem, *cu_die;
+	struct dwarf_cu *dcu;
 
-	while (dwarf_cus__nextcu(dcus, &die_mem, &cu_die, &pointer_size, &offset_size) == 0) {
+	while (dwarf_cus__nextcu(dcus, &dcu, &die_mem, &cu_die, &pointer_size, &offset_size) == 0) {
 		if (cu_die == NULL)
 			break;
 
-		if (dwarf_cus__create_and_process_cu(dcus, cu_die,
-						     pointer_size, dthr->data) == DWARF_CB_ABORT)
+		if (dwarf_cus__process_cu(dcus, cu_die, dcu->cu, dthr->data) == DWARF_CB_ABORT)
 			goto out_abort;
 	}
 
-- 
2.44.0

