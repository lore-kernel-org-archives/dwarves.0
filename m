Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6FB18D642
	for <dwarves@vger.kernel.org>; Mon,  7 Oct 2024 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332748; cv=none; b=NiuVHxc5icFXm2JLeZrAncSoX2e81U+p4240vi8hOZQa/YT9a6wx1NyxZt/DhvJI/Y80EWjjhIDiTTr87aRw50JeN6TVX5XZib1NohAkzQ7gi1qXerzcLueUvcf3cZx2xVCHuCTplrhUgNpw9H92pwBXexSoCLBnbWes6mba/tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332748; c=relaxed/simple;
	bh=V2xnc3Bp2lTfvradyJ2Q7w78CADTrI89V8pshXXoNyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtebOyHzr9oJsVYfMlTb8TO5jlw1TKuInOPz7AVZ2nrB3nbVP683McAwmWkDWtMWMZvBdSKs6CDEMYRBt7cU9uGGUIBuHVuxF0z/9otIfwEkheS200ceRaLreD3PthiPJexIFIwjkdYuD4tvN+TaEec8ioOiyp60HpF6G3loFFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uszqBPL3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uszqBPL3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF71C4CECF;
	Mon,  7 Oct 2024 20:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728332747;
	bh=V2xnc3Bp2lTfvradyJ2Q7w78CADTrI89V8pshXXoNyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uszqBPL3oXD4O+RsHMtNSVg319auwFgMw2yfoy8cI3KSGm+aZ8w+idNbDts1UU3vF
	 oGmLGaPIXZTn2Y78cqd7yufhoG+Gb+8J1LfTDaW2ysmq7Zh6232K/H9mQBtQYPyIHq
	 8eSuw64VBkqVDBwDlqcxpAljOcLAo+0UqCQyx06wTslbe3bcxOME23ygcrphojfUH4
	 WdGXe3+NgkVDYHhaMrwFg2uyWF1gqMoSm+jLpLa2iI8nWylWQtHHgyyZ3HzGcvd0NM
	 DuBxS5yR6B+XwqUw8Bv8c76VGF5maLkaO5zb7ei288r/9vqupRuqlGFr1FL5A6tA9O
	 Tc63R2KKaXBiQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Willy Tarreau <w@1wt.eu>
Cc: dwarves@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 3/5] core: Introduce class__has_embedded_flexible_array()
Date: Mon,  7 Oct 2024 17:25:29 -0300
Message-ID: <20241007202531.942648-4-acme@kernel.org>
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

That we will use both when pretty printing structs, as a new comment,
and with a 'pahole --with_embedded_flexible_array' to show structs with
embedded structs that have flexible arrays and thus should be used with
super extra care.

Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarves.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 dwarves.h |  3 +++
 2 files changed, 47 insertions(+)

diff --git a/dwarves.c b/dwarves.c
index f5bc9cb27adee649..2ac82956bd5ea45d 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -1737,6 +1737,50 @@ void class__find_holes(struct class *class)
 	class->holes_searched = true;
 }
 
+bool class__has_embedded_flexible_array(struct class *cls, const struct cu *cu)
+{
+	struct type *ctype = &cls->type;
+	struct class_member *pos;
+
+	if (!tag__is_struct(class__tag(cls)))
+		return false;
+
+	if (cls->embedded_flexible_array_searched)
+		return cls->has_embedded_flexible_array;
+
+	type__for_each_member(ctype, pos) {
+		/* XXX for now just skip these */
+		if (pos->tag.tag == DW_TAG_inheritance &&
+		    pos->virtuality == DW_VIRTUALITY_virtual)
+			continue;
+
+		if (pos->is_static)
+			continue;
+
+		struct tag *member_type = tag__strip_typedefs_and_modifiers(&pos->tag, cu);
+		if (member_type == NULL)
+			continue;
+
+		if (!tag__is_struct(member_type))
+			continue;
+
+		cls->has_embedded_flexible_array = class__has_flexible_array(tag__class(member_type), cu);
+		if (cls->has_embedded_flexible_array)
+			break;
+
+		if (member_type == class__tag(cls))
+			continue;
+
+		cls->has_embedded_flexible_array = class__has_embedded_flexible_array(tag__class(member_type), cu);
+		if (cls->has_embedded_flexible_array)
+			break;
+	}
+
+	cls->embedded_flexible_array_searched = true;
+
+	return cls->has_embedded_flexible_array;
+}
+
 static size_t type__natural_alignment(struct type *type, const struct cu *cu);
 
 size_t tag__natural_alignment(struct tag *tag, const struct cu *cu)
diff --git a/dwarves.h b/dwarves.h
index bcf701706c61b4f5..f147b2bcfd8a153e 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -1413,7 +1413,9 @@ struct class {
 	uint8_t		 bit_padding;
 	bool		 holes_searched;
 	bool		 flexible_array_verified;
+	bool		 embedded_flexible_array_searched;
 	bool		 has_flexible_array;
+	bool		 has_embedded_flexible_array;
 	bool		 is_packed;
 	void		 *priv;
 };
@@ -1456,6 +1458,7 @@ static inline int class__is_struct(const struct class *cls)
 	return tag__is_struct(&cls->type.namespace.tag);
 }
 
+bool class__has_embedded_flexible_array(struct class *cls, const struct cu *cu);
 bool class__has_flexible_array(struct class *class, const struct cu *cu);
 void class__find_holes(struct class *cls);
 int class__has_hole_ge(const struct class *cls, const uint16_t size);
-- 
2.46.2

