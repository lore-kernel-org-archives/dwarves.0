Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AF834D382
	for <dwarves@vger.kernel.org>; Mon, 22 Jun 2026 20:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159897; cv=none; b=ujIT1F504GwSIMp1zAGUHCo+P4odr+bTJQqT17YfG9UG6JMVVtktP4TvkPgZ5r7LwDaaIzAcg6jqWqUftLOWheBfq7aqPvmRSscMoW6ldySJCpvyqMwVKB2AM2Obk0xjjPHtMErzSu3FFFjDP3UZSWVKUDy+ucflW6kuv7KlUXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159897; c=relaxed/simple;
	bh=2sS24RfZntTcxWSxNCSJlDWLT8jPiKFBxNQYu4NCUPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSn5C+pTpzqZX9s5xQUVVX9opkkWZvV+X4MCVj+wofO/Eo+WGcQeEqOQfDIwh5SCVslLcnDabZuzddSx+a3W79RENs2bNw0z7zRvHqsrFDJkeY9iqboFfx8sfPyIM+kY/FMeAPTGFkDNNR/Ui1b6TvCS5IwBtkxgKvXlI0b4yDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvJ9XWEY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvJ9XWEY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41571F000E9;
	Mon, 22 Jun 2026 20:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782159896;
	bh=0JS2GD8x0kKtObBXAQQ7w6DGVjV9eggKGmQFzzACuXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OvJ9XWEYtEaw4OaR6OwRpSgfhR73NG80td3ytJJxDh0IXBR70KFVhZLG56/TMs8Ym
	 FCd+EPD817kRdfvq7kDg5NVYcKD2cuLT4XQMcpPswCtCT+lF4pOi5sVC+VpIWz1V/a
	 aDPwAME/PvOjzz79Jl/K2675ldjIlhgO1AFfhU5w25acCR1RL54E2poga7pxKcVFaC
	 Wtg5ZbTpETH7iPJdqiC2xeAvvQ/c/UVEudKzFiWc0IaZ/a2o544uN0FEE7NNErLOoj
	 llQR4/x1IMgCOfsA6TE8A40JCKS8taveDuksx3xt1zmR5GxZyDRRbLo+r3KD2nVqL1
	 BNXa494yPlsAw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/16] encoders: Fix diagnostic messages for unexpected tags in enumerations
Date: Mon, 22 Jun 2026 17:24:27 -0300
Message-ID: <20260622202441.14799-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622202441.14799-1-acme@kernel.org>
References: <20260622202441.14799-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Print the actual unexpected child tag's name and id instead of the
parent enumeration's, so the diagnostic message is useful for debugging.

Fixes: 5c0162ee40f06c95 ("dwarf_loader: Initial support for DW_TAG_subprogram in DW_TAG_enumeration")
Assisted-by: Claude:claude-opus-4-6-1m
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 btf_encoder.c     | 2 +-
 ctf_encoder.c     | 2 +-
 dwarves_fprintf.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index b6814f6a92899d07..243064695f6cf171 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1800,7 +1800,7 @@ static int32_t btf_encoder__add_enum_type(struct btf_encoder *encoder, struct ta
 	type__for_each_enumerator(etype, pos) {
 		if (pos->tag.tag != DW_TAG_enumerator) {
 			fprintf(stderr, "Unexpected DW_TAG_%s <%llx>, skipping it...\n",
-				dwarf_tag_name(tag->tag), tag__orig_id(tag, cu));
+				dwarf_tag_name(pos->tag.tag), tag__orig_id(&pos->tag, cu));
 			continue;
 		}
 		name = enumerator__name(pos);
diff --git a/ctf_encoder.c b/ctf_encoder.c
index 1c61c76ba20e06bc..f2c63c2b039026f8 100644
--- a/ctf_encoder.c
+++ b/ctf_encoder.c
@@ -157,7 +157,7 @@ static int enumeration_type__encode(struct tag *tag, const struct cu *cu, uint32
 	type__for_each_enumerator(etype, pos) {
 		if (pos->tag.tag != DW_TAG_enumerator) {
 			fprintf(stderr, "Unexpected DW_TAG_%s <%llx>, skipping it...\n",
-				dwarf_tag_name(tag->tag), tag__orig_id(tag, cu));
+				dwarf_tag_name(pos->tag.tag), tag__orig_id(&pos->tag, cu));
 			continue;
 		}
 		ctf__add_enumerator(ctf, pos->name, pos->value, &position);
diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index acbfbc091c9f86dc..e0887e14daa16c8c 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -506,8 +506,8 @@ size_t enumeration__fprintf(const struct tag *tag, const struct cu *cu,
 						   (unsigned long long)pos->value);
 			break;
 		default:
-			printed += fprintf(fp, "/* Unexpected %s <%llx> */\n", dwarf_tag_name(tag->tag),
-					   tag__orig_id(tag, cu));
+			printed += fprintf(fp, "/* Unexpected %s <%llx> */\n", dwarf_tag_name(pos->tag.tag),
+					   tag__orig_id(&pos->tag, cu));
 			continue;
 		}
 		printed += fprintf(fp, ",\n");
-- 
2.54.0

