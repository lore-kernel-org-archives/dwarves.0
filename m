Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026C8C433DB
	for <linux-dwarves@archiver.kernel.org>; Fri, 12 Feb 2021 21:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACDF364E05
	for <linux-dwarves@archiver.kernel.org>; Fri, 12 Feb 2021 21:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhBLVRF (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 12 Feb 2021 16:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhBLVRD (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 12 Feb 2021 16:17:03 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C964EC061786
        for <dwarves@vger.kernel.org>; Fri, 12 Feb 2021 13:16:22 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v17so935598ybq.9
        for <dwarves@vger.kernel.org>; Fri, 12 Feb 2021 13:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ZEMW0Z2ejWn7QhiizYeAVctQKIuWplEIADwwg0z3zW4=;
        b=dLlVaK20xbUOQhgD4S9zcRXRu6cwDybcW7l7MSWDTC4qlXJBZBnvpHN4+vRwv1Znen
         3lR5c3ZK7rJ3/dN20W8oMuCdO1lE7SRV7E6bCmxai9vNWLrOslhWj0+2bRfcXeD2i4ls
         QGwYlpBcZy+/Ld6ft0yYQxS5vsNcU1pJqxLz19e1b2AWf+a5EDvTmZR6Ov4OZVc9MI8A
         /jMrTzurHgZk9PiVO6dvtabEW/piBs0tjSJmA5BbHThr7yjN7HGOU8LhFMLaelPvMGXz
         6wg+57awmV20LWTCYNTemhDhTmWCPIi4HUjQhqgk8KdY3LNbOwTHTw8bdbT/kQ8E6982
         mJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZEMW0Z2ejWn7QhiizYeAVctQKIuWplEIADwwg0z3zW4=;
        b=PDvYR67rYjqp6sqEunRgbR2w0fvgqIceHG5w97fJDYCkOUaXUdKSKv7C8aGkcUfiLP
         uvY+HEJ832xwApoe2umvmMhpAM6zZiLCZvJgXToQmj2Z46U2XPZ1TceWFMpA8u7OvQw5
         V+9nv4QD5YjPM8n6eBobkPHFQy+psVqk7S7drazrcegkCuDD6wi01zUDXHhFuwBMYbfh
         o7fLHud1cIQ6NcTZE5H4u1ZfzllzI7Wtuip8hCI7lv7QyQMi2d2k3ore5myDXGcGQXrK
         BCdyJ+menvQxyC3tmzcQLEAGHnpjaGVMK14WqSu4emRMdBlJAO5NfYqzNIU5Mm11lbpg
         8seQ==
X-Gm-Message-State: AOAM533J4ncZAigZXo3Ur53IHpqlbQe+QXYNMSMEM4F5a/3QvMqyIhLh
        6oDg3h2yAyRNvYQO18ERta7l23aoK16jbzViq6qFBsIf5aC7D+DexV+jsKSkbZhV9nDJ0+JpkoT
        2330d77Fgbc11cdPb5OLOIyyldHRn2/UOOkURHgfywNU4eRDqeYrHBu7oR1U=
X-Google-Smtp-Source: ABdhPJx6GM6dIf3SKO0QQJAu4+rc7JMZ4Yv0ppGEbzLIRcfxe/2nkEad17PnW9hAAqbO7BO7Cq6HUuXJ9A==
Sender: "morbo via sendgmr" <morbo@fawn.svl.corp.google.com>
X-Received: from fawn.svl.corp.google.com ([2620:15c:2cd:202:ed1b:1611:4b90:c2e9])
 (user=morbo job=sendgmr) by 2002:a25:9a89:: with SMTP id s9mr6499666ybo.407.1613164581980;
 Fri, 12 Feb 2021 13:16:21 -0800 (PST)
Date:   Fri, 12 Feb 2021 13:16:07 -0800
In-Reply-To: <20210212211607.2890660-1-morbo@google.com>
Message-Id: <20210212211607.2890660-2-morbo@google.com>
Mime-Version: 1.0
References: <20210212211607.2890660-1-morbo@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [RFC PATCH 1/1] dwarf_loader: have all CUs use a single hash table
From:   Bill Wendling <morbo@google.com>
To:     dwarves@vger.kernel.org, bpf@vger.kernel.org
Cc:     arnaldo.melo@gmail.com, Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

In some instances, e.g. with clang's LTO, a DWARF compilation units may
reference tags in other CUs. This presents us with a "chicken and egg"
problem, where in order to properly process on CU we need access to the
tags in all CUs.

This increases the runtime by ~28% (from 11.11s to 14.27s).

Signed-off-by: Bill Wendling <morbo@google.com>
---
 dwarf_loader.c | 45 +++++++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index b73d786..2b0d619 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -102,7 +102,7 @@ static void dwarf_tag__set_spec(struct dwarf_tag *dtag, dwarf_off_ref spec)
 	*(dwarf_off_ref *)(dtag + 1) = spec;
 }
 
-#define HASHTAGS__BITS 15
+#define HASHTAGS__BITS 16
 #define HASHTAGS__SIZE (1UL << HASHTAGS__BITS)
 
 #define obstack_chunk_alloc malloc
@@ -117,21 +117,42 @@ static void *obstack_zalloc(struct obstack *obstack, size_t size)
 	return o;
 }
 
+/* The tags and types hashes used by all "dwarf_cu" objects. */
+struct dwarf_cu_hash {
+	struct hlist_head tags[HASHTAGS__SIZE];
+	struct hlist_head types[HASHTAGS__SIZE];
+};
+
 struct dwarf_cu {
-	struct hlist_head hash_tags[HASHTAGS__SIZE];
-	struct hlist_head hash_types[HASHTAGS__SIZE];
+	struct dwarf_cu_hash *hashes;
 	struct obstack obstack;
 	struct cu *cu;
 	struct dwarf_cu *type_unit;
 };
 
+static struct dwarf_cu_hash *dwarf_cu__init_hashes(void)
+{
+	static struct dwarf_cu_hash *hashes = NULL;
+
+	if (!hashes) {
+		unsigned int i;
+
+		hashes = malloc(sizeof(struct dwarf_cu_hash));
+		if (!hashes)
+			return NULL;
+
+		for (i = 0; i < HASHTAGS__SIZE; ++i) {
+			INIT_HLIST_HEAD(&hashes->tags[i]);
+			INIT_HLIST_HEAD(&hashes->types[i]);
+		}
+	}
+
+	return hashes;
+}
+
 static void dwarf_cu__init(struct dwarf_cu *dcu)
 {
-	unsigned int i;
-	for (i = 0; i < HASHTAGS__SIZE; ++i) {
-		INIT_HLIST_HEAD(&dcu->hash_tags[i]);
-		INIT_HLIST_HEAD(&dcu->hash_types[i]);
-	}
+	dcu->hashes = dwarf_cu__init_hashes();
 	obstack_init(&dcu->obstack);
 	dcu->type_unit = NULL;
 }
@@ -166,8 +187,8 @@ static void cu__hash(struct cu *cu, struct tag *tag)
 {
 	struct dwarf_cu *dcu = cu->priv;
 	struct hlist_head *hashtable = tag__is_tag_type(tag) ?
-							dcu->hash_types :
-							dcu->hash_tags;
+							dcu->hashes->types :
+							dcu->hashes->tags;
 	hashtags__hash(hashtable, tag->priv);
 }
 
@@ -179,7 +200,7 @@ static struct dwarf_tag *dwarf_cu__find_tag_by_ref(const struct dwarf_cu *cu,
 	if (ref->from_types) {
 		return NULL;
 	}
-	return hashtags__find(cu->hash_tags, ref->off);
+	return hashtags__find(cu->hashes->tags, ref->off);
 }
 
 static struct dwarf_tag *dwarf_cu__find_type_by_ref(const struct dwarf_cu *dcu,
@@ -193,7 +214,7 @@ static struct dwarf_tag *dwarf_cu__find_type_by_ref(const struct dwarf_cu *dcu,
 			return NULL;
 		}
 	}
-	return hashtags__find(dcu->hash_types, ref->off);
+	return hashtags__find(dcu->hashes->types, ref->off);
 }
 
 extern struct strings *strings;
-- 
2.30.0.478.g8a0d178c01-goog

