Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B8815B98A;
	Tue,  2 Apr 2024 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086813; cv=none; b=kg3L2j9rtSTglYIj/ZxkQZSsn/WH5vYLbRaK7l0z9SZDrBkOqzxiKSwJ5v8yeZzl1WQYShX2TLU3BPSsgUPdwXw+3KXT8ZHCk4Jm8jiX8hnvbjtnWQmLgCYqw0JPs5jtb2jjCorJW6qQ6dkkiiv4i8BBn+KOcIvajRps8BFl9cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086813; c=relaxed/simple;
	bh=QPCVECCkNP/mRX6k0IN6gRC2BYWoQ9twP/v6i1a73s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BB4K16tDcKbRyS//iXE2iGDkH3VPqhPQcB6+N4tnI2Hwil6bjpqdM0bLqIKnzo2AEfvn7CMm8CkyafUQ5NWJytO9IE16osKYcvzETPQ9xnq5iKFvzbpAMnSz1oXei6B2ddSh3iUE1LBcwe9PJ49HCK7gnI70MCGAqeanwpsh03o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4FWt2N7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4FWt2N7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF65C433C7;
	Tue,  2 Apr 2024 19:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086813;
	bh=QPCVECCkNP/mRX6k0IN6gRC2BYWoQ9twP/v6i1a73s8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p4FWt2N7OBQHYmRH1VgAmm3hSqyNia6Qi8YAyFVBsnp5/08BbqDMtCC6FG6xQX5TB
	 IAD3oL0esloOKLs2SC/etLkIfml3KgqoL+CqXSrZIa1P3R5a1dwD75YhGhA+kUEa3l
	 wONMMUFXHmGuXNH9M15GQt+I5hacRZKIcCHz8NcIuxJrDii2nKJv0cowfElz0lqU5z
	 IimTjUUE0TW2Uopri7ypJW9DI2yV9roAwcsqCW8SrDIUEOMmUeHB1XoeeV62Ufln6X
	 mXkbg5w6HAuZdxj24I9ggtyxOzAgQ90+jDMBN+ryQIGMZWAZpQm7+qAIVT/hvc53lO
	 wcFKJzi3IoKiA==
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
Subject: [PATCH 07/12] core: Add unlocked cus__add() variant
Date: Tue,  2 Apr 2024 16:39:40 -0300
Message-ID: <20240402193945.17327-8-acme@kernel.org>
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

As we'll use with the cus lock already held when getting the next CU
from vmlinux to keep the order in the original DWARF file.

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Kui-Feng Lee <kuifeng@fb.com>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarves.c | 9 ++++++---
 dwarves.h | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/dwarves.c b/dwarves.c
index 3b4be595aa59a856..654a8085e9252a21 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -479,13 +479,16 @@ uint32_t cus__nr_entries(const struct cus *cus)
 	return cus->nr_entries;
 }
 
-void cus__add(struct cus *cus, struct cu *cu)
+void __cus__add(struct cus *cus, struct cu *cu)
 {
-	cus__lock(cus);
-
 	cus->nr_entries++;
 	list_add_tail(&cu->node, &cus->cus);
+}
 
+void cus__add(struct cus *cus, struct cu *cu)
+{
+	cus__lock(cus);
+	__cus__add(cus, cu);
 	cus__unlock(cus);
 
 	cu__find_class_holes(cu);
diff --git a/dwarves.h b/dwarves.h
index 4dfaa01a00f782d9..42b00bc1341e66cb 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -171,6 +171,7 @@ int cus__fprintf_load_files_err(struct cus *cus, const char *tool,
 int cus__load_dir(struct cus *cus, struct conf_load *conf,
 		  const char *dirname, const char *filename_mask,
 		  const int recursive);
+void __cus__add(struct cus *cus, struct cu *cu);
 void cus__add(struct cus *cus, struct cu *cu);
 void cus__print_error_msg(const char *progname, const struct cus *cus,
 			  const char *filename, const int err);
-- 
2.44.0

