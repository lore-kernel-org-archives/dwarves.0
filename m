Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AE118D642
	for <dwarves@vger.kernel.org>; Mon,  7 Oct 2024 20:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332742; cv=none; b=lvusm3mdxuXmtwxYOmC+G4fjXi9GDQHlraRnwQ+gWyJueTOizrxW4+xY71t/XRfB/9T9YTA2+c2K4p2ugVjLvTlTdhpaOrmaj8PN+CEaCXSneO1egVpK37zMefnN3Upc6kL4dK4xh+vBkNGJClOySh+qzBhQy29dlUfqstWGUdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332742; c=relaxed/simple;
	bh=JsbugvzmQYEYjjWRzCPA7AI+xTcKDAzVWeKyFyZV+I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ma8JxjQVFW6PeU3Y9K4MiNb+mxmGlVuP2TPortRk9QWD02NbTAppAkg+WW+Fxh7DehDwTZRp1kCf4qox5JBGUYR2CIToNNXMh0b/4mAKuZVXOhhdTj5hMJo5kd8z4cpla0IMiuMxCcbpB5kzUoVV8018z56N6Y24Q+cXI7328yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2UBSnnP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2UBSnnP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DCAC4CECF;
	Mon,  7 Oct 2024 20:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728332741;
	bh=JsbugvzmQYEYjjWRzCPA7AI+xTcKDAzVWeKyFyZV+I0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g2UBSnnP4slkjaKgpHxu3+Qoa7INbRpackYbTzJvtbWZsfHPd/cq9l/pludiUEOvJ
	 wIhhSWIRLgnCl6RUIIpxQVErN6iwsZwtR2MmuzttRZfnuVwIKdCM5Iq1fK6EIgnOtH
	 K2fCoBmRgrNYsJOhQ2cCAALB1yaFD9B+8GxiL1FSvLdBkgxIvOnSCA5kKEhlMhs0QB
	 5geew/56lhB4fITdVZO7ZzEuMhVFfOJyZ84Av1FwmfkuREikqFxO6Tpc/b1K9QBVNe
	 YiZV4UdEL4FOr/oAkTePuyEylAKGcg0RkdXGmVFg2SBJdCPndzz84R4e//TNxIQQqT
	 bDrU/s8eFdfPA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Willy Tarreau <w@1wt.eu>
Cc: dwarves@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 1/5] core: Move class__has_flexible_array() from pahole to the core
Date: Mon,  7 Oct 2024 17:25:27 -0300
Message-ID: <20241007202531.942648-2-acme@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007202531.942648-1-acme@kernel.org>
References: <20241007202531.942648-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We want to cache that info, look if there are embedded fields of structs
with flexible arrays, etc.

Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarves.c | 23 +++++++++++++++++++++++
 dwarves.h |  1 +
 pahole.c  | 23 -----------------------
 3 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/dwarves.c b/dwarves.c
index 6e6a9e69a61d1e37..3d91e629277a329f 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -1575,6 +1575,29 @@ void lexblock__add_label(struct lexblock *block, struct label *label)
 	lexblock__add_tag(block, &label->ip.tag);
 }
 
+bool class__has_flexible_array(struct class *class, const struct cu *cu)
+{
+	struct class_member *member = type__last_member(&class->type);
+
+	if (member == NULL)
+		return false;
+
+	struct tag *type = cu__type(cu, member->tag.type);
+
+	if (type->tag != DW_TAG_array_type)
+		return false;
+
+	struct array_type *array = tag__array_type(type);
+
+	if (array->dimensions > 1)
+		return false;
+
+	if (array->nr_entries == NULL || array->nr_entries[0] == 0)
+		return true;
+
+	return false;
+}
+
 const struct class_member *class__find_bit_hole(const struct class *class,
 					    const struct class_member *trailer,
 						const uint16_t bit_hole_size)
diff --git a/dwarves.h b/dwarves.h
index 2bb0eed461d08d51..757fc05dd3363bf1 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -1454,6 +1454,7 @@ static inline int class__is_struct(const struct class *cls)
 	return tag__is_struct(&cls->type.namespace.tag);
 }
 
+bool class__has_flexible_array(struct class *class, const struct cu *cu);
 void class__find_holes(struct class *cls);
 int class__has_hole_ge(const struct class *cls, const uint16_t size);
 
diff --git a/pahole.c b/pahole.c
index 766835d93a1f3d1e..8bdfaf3e84c407d7 100644
--- a/pahole.c
+++ b/pahole.c
@@ -725,29 +725,6 @@ static int class__packable(struct class *class, struct cu *cu)
 	return 0;
 }
 
-static bool class__has_flexible_array(struct class *class, struct cu *cu)
-{
-	struct class_member *member = type__last_member(&class->type);
-
-	if (member == NULL)
-		return false;
-
-	struct tag *type = cu__type(cu, member->tag.type);
-
-	if (type->tag != DW_TAG_array_type)
-		return false;
-
-	struct array_type *array = tag__array_type(type);
-
-	if (array->dimensions > 1)
-		return false;
-
-	if (array->nr_entries == NULL || array->nr_entries[0] == 0)
-		return true;
-
-	return false;
-}
-
 static struct class *class__filter(struct class *class, struct cu *cu,
 				   uint32_t tag_id)
 {
-- 
2.46.2

