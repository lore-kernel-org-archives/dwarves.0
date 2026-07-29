Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E52463B60;
	Wed, 29 Jul 2026 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352069; cv=none; b=RsLjmAxHjbJrHB/c+EvMw/XftqyNodfyaMuXjKfsnGg1r8569qRlPJm7/8/XmRpkM5jTf3A3tD/ySOJgPQmEkKjc0A8Djr4XXlCdCiIWySVpvXnc+Hc23KTfOj7IHZmBfKN8c1Qqcdxn9ZDzd13MEmlKV3jtqQnymBeOQYLvJgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352069; c=relaxed/simple;
	bh=1H3A7eegRMwMnf8lgX1GTYnSbTt5jxRMLrgotfVDKhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdcyb5ZfGNOpGqONJubv3R4MPsQvg2hZNsUFbBbpp55q5kmWIvs8O2v8ZEBFYu5KA//YXoDUG8PnI9Fqh4pvmPmE43S2oNsVwGlm0To3B6dRyy34hvScq5NNjqwL9G0OQUptv5RCi4LvXqoSNuol02x3eCbS/gRMh/kH1TOOVZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+cDlFjb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+cDlFjb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FA11F00A3A;
	Wed, 29 Jul 2026 19:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352068;
	bh=ElMAWH6aOQQxySU3fjpAhXlvNVUR8iyUDbk3h4SVsqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W+cDlFjbfDn/ZtcdUTexndMGU83mVWFySupiWKifps3tYgyBKYtGPk2g+BpauNrE5
	 G8qK4PsbJUqqsZERQs6p2LUNchIvHGdLujaLyGStLjhRZtDCGRMY35p+x/kaKwQ567
	 C+5zF35GcuiRN2jUUCFn4nPJIAunrL1bxXmEZaCAWdtZ5BxFnidYIDBXWeNImZ2avN
	 ZisAz7clwH59IeHZUwsIZzAc3MDblx3NzNRRfMH5U1KabEHD5yfZQUuZuaE6S/+msG
	 giuB9kwd1pUPPFYtUffFWEaOZq3ZmkY0N11yVCrdjKlYHAyytDgvTZw8wiDDLJWKYQ
	 VCFZYG4Ctdxuw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/31] dwarves: Fix missing list head initialization in type__clone_members
Date: Wed, 29 Jul 2026 16:07:04 -0300
Message-ID: <20260729190733.72876-5-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729190733.72876-1-acme@kernel.org>
References: <20260729190733.72876-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

After class__clone() does memcpy(class, from, sizeof(*class)), the
clone's list_head fields still point into the source type's linked
list chains.  type__clone_members() reinitializes namespace.tags and
variant_parts, but misses type_enum, template_type_params, and
template_value_params.

If the source type has non-empty lists for any of these, subsequent
list operations on the clone (e.g. during --reorganize) corrupt both
the clone's and the source's lists, leading to crashes or infinite
loops.

Add the three missing INIT_LIST_HEAD calls, matching the initialization
done in __type__init().

Fixes: 8a1e0238ee4005a6 ("dwarf_loader: Initial support for DW_TAG_template_type_param tag")
Reported-by: Sashiko:gemini-3-1-pro-preview # Running on a local machine
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarves.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/dwarves.c b/dwarves.c
index f05c4d3b4b669335..95a8dcd66f861be9 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -1382,6 +1382,10 @@ static int type__clone_members(struct type *type, const struct type *from, struc
 
 	type->nr_members = type->nr_static_members = 0;
 	INIT_LIST_HEAD(&type->namespace.tags);
+	INIT_LIST_HEAD(&type->namespace.annots);
+	INIT_LIST_HEAD(&type->type_enum);
+	INIT_LIST_HEAD(&type->template_type_params);
+	INIT_LIST_HEAD(&type->template_value_params);
 
 	type__for_each_member(from, pos) {
 		struct class_member *clone = class_member__clone(pos, cu);
@@ -1400,6 +1404,8 @@ struct class *class__clone(const struct class *from, const char *new_class_name,
 
 	 if (class != NULL) {
 		memcpy(class, from, sizeof(*class));
+		INIT_LIST_HEAD(&class->vtable);
+		class->nr_vtable_entries = 0;
 		if (new_class_name != NULL) {
 			class->type.namespace.name = strdup(new_class_name);
 			if (class->type.namespace.name == NULL) {
-- 
2.55.0

