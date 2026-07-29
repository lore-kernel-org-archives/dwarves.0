Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C03463B82;
	Wed, 29 Jul 2026 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352076; cv=none; b=GIlk7k7a2Se12stVT2/e2s8yd34YBPTmirOPN9poVZnTcLPHJ+z9U6iAHlqJLNpW7DnnqLyVPYvo54K6G8bL7jZWouFwlWHm1TsIP2YVpQFY8G87QvceLThrTJWHPSRctYBl5WcSIuBD7qxX35V4+k2V3iWF3Sil48QJAz+a8kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352076; c=relaxed/simple;
	bh=5uxvzmM6Slou7eFhc0207KSAd05TIguNFK6GMWfHrPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qY4PBs7MGQ/e6BcjKU0DdPFlwor+ZfmKivLYHnIOKcarO6A8SqzE+MRhxA2mOmkR1jv2zVbU4/R7LmTaw+svoeH1atp3Pmagr/fy8+cq5akmqvqWxpNvG0d2889ASNq57oJfjfHkAEi+hyXk2gWKhSvcFNx9YiGInc+Qaqybx3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZfqJGuN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZfqJGuN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74421F000E9;
	Wed, 29 Jul 2026 19:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352074;
	bh=tV+pS6tmGuAwsE636hIpf5Xg38IBOKHJHNr7gU+tLw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AZfqJGuNYSIL2k3Zvgwqn4RLffbnUF1WH8MxfoFH12mS22AX+qNEhIzRRJ9YL0WB4
	 Sa+/h02AdhWYRwNXFJ9tinP81xcfZY+wxb701gdEO5mux9f8b4sNpJYMOr4nLkZgx+
	 T5rKtLLOgO2vFUYeraxohue3WUSIA/W0VuQVxOBcLlP/jAJ++QevYikaZTYSXUl4nF
	 MDoQ0SLqBCAKAhrPbE0zaaKlf/FXomqogbFOvJ3hJwBcGPNC+i/0ITb+xWmRzutPro
	 RapM/vKtundBhVlGityURVcWHnB6Nw9WJBdOdH/T/0tieVJFu+DfYZCG7YQy5o/Y2E
	 +5recaI/s1fCw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/31] dwarves: Don't search for holes before member byte sizes are cached
Date: Wed, 29 Jul 2026 16:07:07 -0300
Message-ID: <20260729190733.72876-8-acme@kernel.org>
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

cus__add() called cu__find_class_holes() which ran class__find_holes()
on all structs before cu__finalize() had cached member byte_sizes via
class_member__cache_byte_size(). In the merge path, cus__add() is
called during the CU-processing loop, but cu__finalize() runs after
the loop completes. With uncached byte_sizes (still 0), every member
appeared zero-sized, producing phantom holes between contiguous members.
The holes_searched flag then prevented re-computation when
class__find_holes() was called again during printing.

This caused 36 false "BRAIN FART ALERT!" warnings and phantom "XXX 8
bytes hole, try to pack" messages when processing Firefox debug info,
all on Rust vtable/trait types where members are contiguous at 8-byte
intervals.

Before (Firefox, 152.0-1.fc44.x86_64):

  $ pahole -F dwarf firefox-*.debug 2>&1 | grep -c "BRAIN FART"
  36

After:

  $ pahole -F dwarf firefox-*.debug 2>&1 | grep -c "BRAIN FART"
  0

All consumers already call class__find_holes() lazily, guarded by the
holes_searched flag, so the eager call in cus__add() was redundant.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 codiff.c  |  3 +++
 ctracer.c |  1 +
 dwarves.c | 11 -----------
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/codiff.c b/codiff.c
index 9e5c56546c314231..72a2c4d720f7ac78 100644
--- a/codiff.c
+++ b/codiff.c
@@ -286,6 +286,9 @@ static void diff_struct(const struct cu *new_cu, struct class *structure,
 
 	assert(class__is_struct(new_structure));
 
+	class__find_holes(structure);
+	class__find_holes(new_structure);
+
 	diff = class__size(structure) != class__size(new_structure) ||
 	       class__nr_members(structure) != class__nr_members(new_structure) ||
 	       check_print_members_changes(structure, cu,
diff --git a/ctracer.c b/ctracer.c
index 6894766abc236b45..f3f7f937bb981a58 100644
--- a/ctracer.c
+++ b/ctracer.c
@@ -354,6 +354,7 @@ static struct class *class__clone_base_types(const struct tag *tag,
 	if (clone == NULL)
 		return NULL;
 
+	class__find_holes(clone);
 	type__for_each_data_member_safe(&clone->type, pos, next) {
 		struct tag *member_type = cu__type(cu, pos->tag.type);
 
diff --git a/dwarves.c b/dwarves.c
index 95a8dcd66f861be9..57a4bd063cc9413d 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -506,15 +506,6 @@ reevaluate:
 	return result;
 }
 
-static void cu__find_class_holes(struct cu *cu)
-{
-	uint32_t id;
-	struct class *pos;
-
-	cu__for_each_struct(cu, id, pos)
-		class__find_holes(pos);
-}
-
 struct cus {
 	uint32_t	 nr_entries;
 	struct list_head cus;
@@ -567,8 +558,6 @@ void cus__add(struct cus *cus, struct cu *cu)
 	cus__lock(cus);
 	__cus__add(cus, cu);
 	cus__unlock(cus);
-
-	cu__find_class_holes(cu);
 }
 
 static void ptr_table__init(struct ptr_table *pt)
-- 
2.55.0

