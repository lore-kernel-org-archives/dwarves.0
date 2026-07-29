Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2C4463B84;
	Wed, 29 Jul 2026 19:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352103; cv=none; b=BpMcSXQ67UJCJANNYOC5aMl9PZMAIPlXDuDYY9BcKknCbBP86XiMzfCrF8vzqHZrzBmOFH/xenVxF+0YYHijM9jtXwap3u7xLZXh8sV4t4jBrPcJEd5CPkxfiDfe4vdUCnv+G/JTZgzuO18SvDz8k6olAoWG25Vk+bbopZzNzOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352103; c=relaxed/simple;
	bh=lkFYc5mdE2G2TKyMAph3XX5KKCl38Wo+BUL++0IVEMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zq51mKHP8gI+X41EizzSEen8x8WfDFofyLP9/BiXZcr1WrxVG7qm0z5ybNfu9sWZaaXxwCHWzvKyfk9Pnl+Dpahder/cePu+wMGx2eZ3fyqfPf1w2sJNfKklbRNcNs6CY9W9EHBGkkjmMmroRjHxuVipNEOH0XFIAt1xkH+P/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KebkiFvn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KebkiFvn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5A51F000E9;
	Wed, 29 Jul 2026 19:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352102;
	bh=rl6LcT88taBVw0rkDJOxeGdUHftYdCARQklPC+iqxgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KebkiFvnRaOu5YW8ug+xcyfk6ErLD13VWO1iUS3+qFMZQBupTCfK313QWovJi/6Vq
	 rlZJmie7B/JSehmQsl/EP5E1iTBNuVKy7+EDEfSWbDDwB8wh2EAwlzpwAPHa53wPVU
	 J2j+Zxy1J800CsCuXlJbvdaC1AllE1Yl8U5OK3KxKFVpVSjlcb+oBbwgKQvWrAfzCz
	 Gk+CF6LrVUNJNdmC/cW1KdOsh005bbCsEIgWOPXqmwAhy4kLuoVf7/52/CiqeCOdLB
	 n0hbNOiGP+3P8hX/0tSxrnNqHQ1zm5rxytYu9wYO0OX6gGwo8+9iZBWxXI7UA4fCC5
	 KuIF5sFE8t/9g==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 19/31] dwarves: Fix variable shadowing in __cus__find_struct_by_name()
Date: Wed, 29 Jul 2026 16:07:19 -0300
Message-ID: <20260729190733.72876-20-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729190733.72876-1-acme@kernel.org>
References: <20260729190733.72876-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The inner loop declared 'struct tag *tag' which shadowed the outer
'struct tag *tag = NULL' at function scope.  When the inner lookup
succeeded and we broke out of the loop, the function returned the
outer (still NULL) tag instead of the found one.

This broke any tool that loads CUs without a steal callback and then
calls cus__find_struct_by_name() — notably ctracer.  Tools like pahole
and pfunct were unaffected because they use a steal callback to process
each CU as it arrives, calling per-CU cu__find_struct_by_name() which
has no shadowing issue.

Before: ctracer loads 3291 CUs, cus__find_struct_by_name() returns NULL
After:  ctracer loads 3291 CUs, cus__find_struct_by_name() finds the struct

Fixes: fb99cad539e58638 ("dwarf_loader: Parallel DWARF loading")
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarves.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/dwarves.c b/dwarves.c
index 5c9d83a6dee897c2..94bab301d598695d 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -1049,7 +1049,8 @@ static struct tag *__cus__find_struct_by_name(struct cus *cus, struct cu **cu, c
 	cus__lock(cus);
 
 	list_for_each_entry(pos, &cus->cus, node) {
-		struct tag *tag = __cu__find_struct_by_name(pos, name, include_decls, unions, id);
+		/* Don't shadow the outer 'tag' — we need to return it */
+		tag = __cu__find_struct_by_name(pos, name, include_decls, unions, id);
 		if (tag != NULL) {
 			if (cu != NULL)
 				*cu = pos;
-- 
2.55.0

