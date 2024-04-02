Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0944D15CD52;
	Tue,  2 Apr 2024 19:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086816; cv=none; b=I0PALZguF7X6JvZ4eWdg9UGU0oUR/t6YoD8Cf8dcyKn3ynRZgnpoqEbH75DWSsbgw9/F9CLWLfvVUWktSjDikdMpyz131wMwJewzxxbGo6qlVF+82uoR3aISKElPtRpmbr7Eh/FtvIo9MFmUq4TIxcjNUVxCGhyzm5tMrf7JvUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086816; c=relaxed/simple;
	bh=JXjQeIPnvToaq4XBL3VYo8qBVMZF3R3DIiw5BmWaoJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UggUwWcUExpo+aenr8s6VqufR/MuOrPVXRxmjTnUqNeSFHozKHS7llVgFsh0OQx2WXXy3BqwYv8xZA1QE1M1PQenqV4mb2C3dFv/uzo7WyDsPU9RxgqJfnw2eg99yYne7h4FB4NHbGvYzj6fDQ8Tq/WVu+CG7Tb/I+LEPVYW8IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZFk6HQw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZFk6HQw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB65C433F1;
	Tue,  2 Apr 2024 19:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086815;
	bh=JXjQeIPnvToaq4XBL3VYo8qBVMZF3R3DIiw5BmWaoJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KZFk6HQwTTiYWg4u9C7EvDz7Mh24MvDr6xwrSR6R+J02EEylJ+bEsgETeb3znN6AT
	 MpH/i363JWN9Sn1vJMeFJcI9mpVc9CoOz3CYsiKOKfKOAn4A/6debEyBSXoevrKim9
	 RvElIgcq9Le38UmKzVPOubqdlCn/hU9A6d5XIuk8nsd+H0+G3GLskqB3WyRgpzK3Fv
	 Ugtxfo9MftH1HRBK+IIEgVlIzCY3D1YWt6V62jMOeXQkhLz2SC1E/BUQhuCyAREm0e
	 I88O3lhUpFMlpUuUO4w+705QJs6J3guCj7nl2FF4kzeN5pvbxeB3JBTQSuF1+vNJh6
	 440U6IOOUYqVQ==
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
Subject: [PATCH 08/12] core: Add cus__remove(), counterpart of cus__add()
Date: Tue,  2 Apr 2024 16:39:41 -0300
Message-ID: <20240402193945.17327-9-acme@kernel.org>
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

We'll switch to adding the 'struct cu' instance to the 'struct cus' list
early, under the lock, to keep the order from the original DWARF file
and then LSK_KEEPIT will just leave it there while LSK_DELETE will first
remove it from the cus list, under cus lock, to then call cu__delete().

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Kui-Feng Lee <kuifeng@fb.com>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarves.c | 13 +++++++++++++
 dwarves.h |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/dwarves.c b/dwarves.c
index 654a8085e9252a21..3cd300db97973ce4 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -479,6 +479,19 @@ uint32_t cus__nr_entries(const struct cus *cus)
 	return cus->nr_entries;
 }
 
+void __cus__remove(struct cus *cus, struct cu *cu)
+{
+	cus->nr_entries--;
+	list_del_init(&cu->node);
+}
+
+void cus__remove(struct cus *cus, struct cu *cu)
+{
+	cus__lock(cus);
+	__cus__remove(cus, cu);
+	cus__unlock(cus);
+}
+
 void __cus__add(struct cus *cus, struct cu *cu)
 {
 	cus->nr_entries++;
diff --git a/dwarves.h b/dwarves.h
index 42b00bc1341e66cb..9dc9cb4b074b5d33 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -173,6 +173,10 @@ int cus__load_dir(struct cus *cus, struct conf_load *conf,
 		  const int recursive);
 void __cus__add(struct cus *cus, struct cu *cu);
 void cus__add(struct cus *cus, struct cu *cu);
+
+void __cus__remove(struct cus *cus, struct cu *cu);
+void cus__remove(struct cus *cus, struct cu *cu);
+
 void cus__print_error_msg(const char *progname, const struct cus *cus,
 			  const char *filename, const int err);
 struct cu *cus__find_pair(struct cus *cus, const char *name);
-- 
2.44.0

