Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BD134CFDD
	for <dwarves@vger.kernel.org>; Mon, 22 Jun 2026 20:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159905; cv=none; b=P2u38szwiYLxfLlT37b/aGEMe49X5lU5n4jHx3KERSa9SGeHel+mMHB1UF2ieiF3oyZkO7+iiY2dAJXF8bqFQkDYIIT49Vz8B3VI9yQRPDGPYXfOAqi1+MPSygCwJEkgSfkVdDhf09Jn471PKSPMhcqOFiu0KlHn4WrSJoicVZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159905; c=relaxed/simple;
	bh=XnZtwf3DbRcfTufNThdf97HEFLleWIdPUt2hJtRsQnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqHgpAmur7ZvOaGZ/lCnTcE1HTlOLY31C6dCfk4Vh35F7DuYog2jrXv73j8z3F0W0zf9aceB6Pij9mb8hrQo/VvO0U4HdgLtJHVWuFwXQXtxaKPU4hsVb7FSF0LJnR/6v/LY6mNVXYArde5zvtTiuTXTYJS2I5kvgeRe9rRSS44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFzdaf39; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFzdaf39"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031D61F00A3A;
	Mon, 22 Jun 2026 20:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782159903;
	bh=jIpags/qoPgRCqYrogMMyW5BQhcXrWbfo9Bqh2GkvpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SFzdaf390y2RS0RozzSjYbmYIbJPrdLqjTwOdnW8T3PjdyFTCEmJ/av40IH9JtpNk
	 DgkvQebfzFRvAx+pxJHwOKSzVS0C3qylvbxuQ278qeNmeGLaCU7Sabc+My6dz+zcF+
	 T2+EcR1kKhKZzzLTy14imgu+5jfXeNcNHZpKdjcjhX3x86vM4ZnzWGSXDcyAevWXNW
	 BhXRDK1Eu2qM/W75t7PR7HWOgzKXp/jdHe1wSVgUczD6XghuBq7hKC8A8S66RuXi6G
	 bpAW145BhQiZ+uUgjWpAJefTFKaNs+FatX2bNMF52Gz6gxxAP7SNBcBHBdepE36fD5
	 Jp9ytR+0FamqQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/16] btf_encoder: Fix types__match parameter comparison in BTF_KIND_FUNC_PROTO
Date: Mon, 22 Jun 2026 17:24:30 -0300
Message-ID: <20260622202441.14799-8-acme@kernel.org>
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

The BTF_KIND_FUNC_PROTO loop in types__match() compared t1->type vs
t2->type (the return types) on every iteration instead of the individual
parameter types p1->type vs p2->type.  This meant all function prototypes
with the same return type and parameter count were considered matching
regardless of their actual parameter types, causing gcc to warn that p1
and p2 were unused:

  btf_encoder.c: In function 'types__match':
  btf_encoder.c:1123:49: warning: variable 'p2' set but not used
  btf_encoder.c:1122:49: warning: variable 'p1' set but not used

Fix the loop to compare each parameter type pair individually.

Reported-by: Sashiko:gemini-3-1-pro-preview # Running on a local machine
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 btf_encoder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 243064695f6cf171..82dd5f27138c2949 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1129,8 +1129,8 @@ static bool types__match(struct btf_encoder *encoder,
 					  btf2, t2->type))
 				return false;
 			for (i = 0; i < vlen; i++, p1++, p2++) {
-				if (!types__match(encoder, btf1, t1->type,
-						  btf2, t2->type))
+				if (!types__match(encoder, btf1, p1->type,
+						  btf2, p2->type))
 					return false;
 			}
 			return true;
-- 
2.54.0

