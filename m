Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128A3EAD0
	for <dwarves@vger.kernel.org>; Mon, 30 Dec 2024 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735587367; cv=none; b=tbpXWhQpipr+pVQyLaUQ1n8Zi48aMF2nWdkZKUFCGWD8EkEXYTlulsnzJ120eFs1+oKAvvcnnV4rZDKBC1sZ9EMRO+GoUriQQiH2kEv84NYqIhFRe0UoKT65NJqecT4FgdP49VFjujJ2utsSqZr9Nnmt+pRc8g2icpi32k3Q/Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735587367; c=relaxed/simple;
	bh=q8RV2Oc8PJmAkQA0msGvRp+fCSWtTLgFv+JOH691G9A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JEnavPsSyQOp+4xqK04trEcU1TBGOrRmfmFAp7HOBD83kM++PvExg8NORgCoLLXZliBcuwcOSg7f2N3u4rmldlOFO0dhVZkExNxpHTIYM3w+YNGF5X47rvvWCDQK/1vowYqOIXHBcQmzuWp0U/L78gpwW2KH06x6qsWM3FqN2qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2mne4uX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2mne4uX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D5AC4CED0;
	Mon, 30 Dec 2024 19:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735587366;
	bh=q8RV2Oc8PJmAkQA0msGvRp+fCSWtTLgFv+JOH691G9A=;
	h=Date:From:To:Cc:Subject:From;
	b=t2mne4uXi+fqdCYzDzwiJoPn2cUZNh5/+O6IQvQgQhX7XL2Aj8w93n1IbjJydysSt
	 BJOnJ4zxQ9XNWj3Tq/FUA02DQVFFC/+fWnfmuTOO6lwLOTfsL/18JsMVSZW+aHjpCx
	 fNVk2DKM62X5oheLKtjFKEkRMyIPwBSn+prEv550oQlAqTZWC896LX2kBenO9Pj/Jf
	 oMn20nVKRp7p/shfDcgTbhLqcY3Vm8vIUkDVgs9AYQ3YS+129jXBrf49faHLm9/B35
	 sJIBnrdMXm1HXgvoa2ekP64XpG/NXt1smnfX0XrgcvQN8qMlmyIl9sW3FWeLzUVW0C
	 EuIL9YcXzk9vg==
Date: Mon, 30 Dec 2024 16:36:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@pm.me>,
	Mykola Lysenko <mykolal@fb.com>, dwarves@vger.kernel.org
Subject: [PATCH 1/1] pfunct: Don't print functions twice when using -f
Message-ID: <Z3L2I_7Dzob9W0fs@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We print it in the pfunct_stealer, i.e. as soon as we load the CU
containing the function information, and then, later, we were iterating
all cus and printing the functions that matched.

Do it just at the stealer.

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Mykola Lysenko <mykolal@fb.com>
Link: https://lore.kernel.org/all/Z3LoTvt7PtUAbh5K@x1
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 pfunct.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/pfunct.c b/pfunct.c
index 55eafe8a8e790dcb..5a6dd59a1c7a30b1 100644
--- a/pfunct.c
+++ b/pfunct.c
@@ -415,14 +415,12 @@ static void function__show(struct function *func, struct cu *cu)
 		fstats->printed = true;
 }
 
-static int cu_function_iterator(struct cu *cu, void *cookie)
+static int cu_function_iterator(struct cu *cu, void *cookie __maybe_unused)
 {
 	struct function *function;
 	uint32_t id;
 
 	cu__for_each_function(cu, id, function) {
-		if (cookie && strcmp(function__name(function), cookie) != 0)
-			continue;
 		function__show(function, cu);
 	}
 	return 0;
@@ -816,10 +814,9 @@ try_sole_arg_as_function_name:
 		function__show(f, cu);
 	} else if (show_total_inline_expansion_stats)
 		print_total_inline_stats();
-	else if (function_name != NULL || expand_types)
-		cus__for_each_cu(cus, cu_function_iterator,
-				 function_name, NULL);
-	else
+	else if (expand_types)
+		cus__for_each_cu(cus, cu_function_iterator, NULL, NULL);
+	else if (function_name == NULL)
 		print_fn_stats(formatter);
 
 	rc = EXIT_SUCCESS;
-- 
2.46.2

