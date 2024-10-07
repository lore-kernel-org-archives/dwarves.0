Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C8418D642
	for <dwarves@vger.kernel.org>; Mon,  7 Oct 2024 20:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332745; cv=none; b=Y2nOcDyr5BcqAPZjqaPDg8T+2qUfo/pla1klZIx3zwtGarPpOF4oSXe9++v7q+uahKqPCOjm83/zUSuTMUqk8Wn7dvbxtmtwQYLWhXzmCtL2k53Sedbl2DClH2nCojfI/gwF7tD008R1hQPmv5fpw84+qQqI+pR2IGl7GTrXdyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332745; c=relaxed/simple;
	bh=jpJ1yKWPtGmkTxcMc2gqZg2VZ3TS5j398anTa+1DSYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1MnqK65ep9k2YB7+TXczBSORGKCXyynd2phiyxPQJ1Ue2MCczioVOuH7yyLqI/ZsrEWnXB2spHJWuVEVHtzswP6gzIon48C78v+C+6/g3izWLQTplGiOJZhlNzcfTpr8utES8czjXQBO5YVCUehKu5NfFLDeAFbPK/Zcvhm8pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOY0wN5P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOY0wN5P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109E4C4CEC6;
	Mon,  7 Oct 2024 20:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728332744;
	bh=jpJ1yKWPtGmkTxcMc2gqZg2VZ3TS5j398anTa+1DSYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gOY0wN5Pt2TWJO2xFc/V8glu/Ezl3d0CRaFsW8Bmk09e9YESnPpP7+GMeR00q53w+
	 8gFM8pD6Zu7pgXS7PW7HOaTjmKQXCT8mO4EY5J75aeMAFdqkrHrn7tYSF7jpewgYll
	 VA+BxH1/GcXulPLid/HVoQQFHqnlAEETPVUwkLlEFFfdE0s3LDhfquS8BZHVoUBJ3V
	 VaeXKKbZuTJyUWjZ/8ayIoXdwP+YxLf9HvZZHjISoV7KGkL+4962WBm5h5SCoiFoId
	 dOGcxU70b406sU3XEyZdYzvCApC6hZ6imDlvjqPI6qNqumTZWoM4hQhEch9Qt7WNqt
	 SD2HiZzlqSP6w==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Willy Tarreau <w@1wt.eu>
Cc: dwarves@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 2/5] core: Cache info about flexible arrays in class__has_flexible_array()
Date: Mon,  7 Oct 2024 17:25:28 -0300
Message-ID: <20241007202531.942648-3-acme@kernel.org>
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

Just saving some calculations, to be in line with class->holes_searched,
etc.

Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarves.c | 12 +++++++++++-
 dwarves.h |  2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/dwarves.c b/dwarves.c
index 3d91e629277a329f..f5bc9cb27adee649 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -1575,7 +1575,7 @@ void lexblock__add_label(struct lexblock *block, struct label *label)
 	lexblock__add_tag(block, &label->ip.tag);
 }
 
-bool class__has_flexible_array(struct class *class, const struct cu *cu)
+static bool __class__has_flexible_array(struct class *class, const struct cu *cu)
 {
 	struct class_member *member = type__last_member(&class->type);
 
@@ -1598,6 +1598,16 @@ bool class__has_flexible_array(struct class *class, const struct cu *cu)
 	return false;
 }
 
+bool class__has_flexible_array(struct class *class, const struct cu *cu)
+{
+	if (!class->flexible_array_verified) {
+		class->has_flexible_array = __class__has_flexible_array(class, cu);
+		class->flexible_array_verified = true;
+	}
+
+	return class->has_flexible_array;
+}
+
 const struct class_member *class__find_bit_hole(const struct class *class,
 					    const struct class_member *trailer,
 						const uint16_t bit_hole_size)
diff --git a/dwarves.h b/dwarves.h
index 757fc05dd3363bf1..bcf701706c61b4f5 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -1412,6 +1412,8 @@ struct class {
 	uint8_t		 pre_bit_hole;
 	uint8_t		 bit_padding;
 	bool		 holes_searched;
+	bool		 flexible_array_verified;
+	bool		 has_flexible_array;
 	bool		 is_packed;
 	void		 *priv;
 };
-- 
2.46.2

