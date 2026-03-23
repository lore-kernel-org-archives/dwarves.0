Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062ED2C2374
	for <dwarves@vger.kernel.org>; Mon, 23 Mar 2026 21:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774300550; cv=none; b=aKliiy3yF8ndUzAfZIGlGoekAsnEP5vPOz/dd7BHr1KvVJsszKt742syf40JW2It3G2Gd1TXCdu4w9LJAiOTVuZ0B4GYmtC2zYOnbXyBCmbs/jizCaur1AvtLxeIr8PyRH2ELEjb6H6neuo5lAYu5kUYbAAfx0TFIrTUIQNRhDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774300550; c=relaxed/simple;
	bh=TD6z77zCBjCyU34xCAAn8rrxLVDcK0FGEIklifJEsGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yp+sBAAdi5nsbg58Kg+yOy9ICFcp3SmRWwfrwknldjepDEOvRozQqhQCmPTlp4b1xl1/tC5hJ0o/rczGlEaqTiZnEDPHAV8V0jR53URwxBW4T9q0CEc0srn/ovQmM3yQ50sRCyIr+YcO5D5f1SfApzC7oGcwLEwq8ijklAxBrTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qY5fOdoK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qY5fOdoK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF891C2BC87;
	Mon, 23 Mar 2026 21:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774300549;
	bh=TD6z77zCBjCyU34xCAAn8rrxLVDcK0FGEIklifJEsGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qY5fOdoKi7NQqj0DTeq66VUFZ4UJLZEjUmesGk4Zu6g+nXHAonA/EOa7tpIZq0Q/4
	 3JK+CQydLfjQPYxQH5HEkFGD6xgbVrqS+qWYZf/2AaojV6NOUa5U4lcArn0OJ8unha
	 6x5r3DnrZchRTVXbQX4iqkSmJ4LN1QICFoH9juRDMH7zhosoUL9AlBZJeA3uH2xS/p
	 PUPNtMfReMvy1fiGyWI0EGTcxmtcTtMlYbocVm8VzDr1XdWvqgS8c5ABnf5lnoVRd6
	 3rm/nqyUx3lmDukZzt89p95vYOfyX8Z7cLWcBHzaw4czfdwGQbyh/vha6ieMHR2C2X
	 peab0y8xX4ugw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/3] dwarf_loader: Initial support for DW_TAG_subprogram in DW_TAG_enumeration
Date: Mon, 23 Mar 2026 18:15:32 -0300
Message-ID: <20260323211533.1909029-3-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323211533.1909029-1-acme@kernel.org>
References: <20260323211533.1909029-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In Rust enums can have subprograms, add initial support for it.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index f0833e8c44a944a8..b5a92160ecf82f74 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1943,6 +1943,8 @@ out_delete:
 	return NULL;
 }
 
+static struct tag *die__create_new_function(Dwarf_Die *die, struct cu *cu, struct conf_load *conf);
+
 static struct tag *die__create_new_enumeration(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
 {
 	Dwarf_Die child;
@@ -1964,18 +1966,38 @@ static struct tag *die__create_new_enumeration(Dwarf_Die *die, struct cu *cu, st
 
 	die = &child;
 	do {
-		struct enumerator *enumerator;
+		switch (dwarf_tag(die)) {
+		case DW_TAG_enumerator: {
+			struct enumerator *enumerator = enumerator__new(die, cu, conf);
+
+			if (enumerator == NULL)
+				goto out_delete;
+
+			enumeration__add(enumeration, enumerator);
+			cu__hash(cu, &enumerator->tag);
+		}
+			continue;
+		case DW_TAG_subprogram: {
+			struct tag *tag = die__create_new_function(die, cu, conf);
+			uint32_t id;
+
+			if (tag == NULL)
+				goto out_delete;
 
-		if (dwarf_tag(die) != DW_TAG_enumerator) {
+			if (cu__add_tag(cu, tag, &id) < 0) {
+				tag__delete(tag, cu);
+				goto out_delete;
+			}
+
+			cu__hash(cu, tag);
+			struct dwarf_tag *dtag = tag__dwarf(tag);
+			dtag->small_id = id;
+			break;
+		}
+		default:
 			cu__tag_not_handled(cu, die);
 			continue;
 		}
-		enumerator = enumerator__new(die, cu, conf);
-		if (enumerator == NULL)
-			goto out_delete;
-
-		enumeration__add(enumeration, enumerator);
-		cu__hash(cu, &enumerator->tag);
 	} while (dwarf_siblingof(die, die) == 0);
 out:
 	return &enumeration->namespace.tag;
-- 
2.53.0

