Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D52039EF1C
	for <dwarves@vger.kernel.org>; Fri, 21 Aug 2026 21:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348133; cv=none; b=nTkJs2+EzrU1ZZj+tdTkhUqrpK3UtYKtZQUr2rMRk0zIASh2PWq6IkETG25ZVFWFvWmSJcEWKIt/ZOxRwCYjrtHFXs8LYMvBevD6IG2fexOs+SoZ+0hz2c4M+M526sRfA9lwNXnc2flK6uGnPDZix6+zx9JX6XA+PyBB2cncxbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348133; c=relaxed/simple;
	bh=Fn0YE0VnHIJM2OxjdRRhU+5JfmnnLz+KyUUfGlRMqxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2NoPSrorVQLRi4QbgIZBesOBIqcTlGmG/GYDUhp1XTndFCXxIYXAp3tTZRoVqAvuxYQZVAC+4qQuoJWNkgfHbWUTdfs84wma7sLinfWQod91963zL7bl5DBcy6c29K1fsZ9fy7nwabPZ84eKlI3B2ovWV8smsq0A80aMI48EY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYfIYPe3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYfIYPe3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB281F000E9;
	Fri, 21 Aug 2026 21:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787348132;
	bh=4RaHeszGhXE5sgfIKUnvzSgdmge7PoL93UMmTg+4INU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VYfIYPe3gV9jMgkVe5X1VuPyvXEl5O+/zGk3tQY1q8BUasd31b59RLsQgcLjlL//x
	 QhM/Bye6Uf28CGpdYN9KRxs2e2gUViHjU44wXEEANMkngdEuo1Zuvy7zL1HbTh5bhG
	 J4Q1WQzz+zaTvL1G9Eh96QbZqqIaXD1fPwlE8c39jRLiK/QLbUWVwADdmkCZqzFVhm
	 QXf0FQ5Hbs2dcTsr9Mq4+Ww+yGf7IiJywUBlwKGekdfBFxrIsr3Wxo/jf4Bm6py9Cz
	 tHxjLisnvQIKJza9ICq6NkgY1BlJJrgAtkjW76xYOhpO/uW7/A/HDX2iPnH7RQ4IfG
	 NLFK10diMkFXw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 5/9] dwarf_loader: Fix cus__merging_cu failing to detect DW_FORM_ref_addr
Date: Fri, 21 Aug 2026 18:35:04 -0300
Message-ID: <20260821213510.22423-6-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260821213510.22423-1-acme@kernel.org>
References: <20260821213510.22423-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

cus__merging_cu() scans abbreviation tables looking for DW_FORM_ref_addr
to detect binaries with inter-CU type references (like Rust CUs in
perf). When found, it triggers the merged CU loading path that can
resolve cross-CU references.

However, dwarf_getabbrevattr() can fail on certain attributes, notably
when DW_FORM_implicit_const is used (DWARF5). The function was treating
this failure as terminal, returning false immediately without scanning
the remaining abbreviations. This prevented detection of
DW_FORM_ref_addr in later CUs, causing the parallel path to be taken
instead — which cannot resolve cross-CU references.

For example, with the perf binary containing 507 CUs where 7 Rust CUs
(CU 209-215) use DW_FORM_ref_addr, the function was failing at CU 0
abbreviation 20 attribute 8 and returning false, never reaching the
Rust CUs.

Before:

  $ pahole -F dwarf ~/bin/perf 2>&1 | grep "couldn't find" | wc -l
  314
  $ diff <(pahole -F dwarf ~/bin/perf 2>/dev/null) \
         <(pahole --features=force_cu_merging -F dwarf ~/bin/perf 2>/dev/null) \
    | grep '^[<>]' | wc -l
  70

After:

  $ pahole -F dwarf ~/bin/perf 2>&1 | grep "couldn't find" | wc -l
  0
  $ diff <(pahole -F dwarf ~/bin/perf 2>/dev/null) \
         <(pahole --features=force_cu_merging -F dwarf ~/bin/perf 2>/dev/null) \
    | wc -l
  0

The fix changes dwarf_getattrcnt() failure to skip the current
abbreviation (goto next_abbrev) and dwarf_getabbrevattr() failure to
skip to the next attribute (continue), both continuing to scan for
DW_FORM_ref_addr instead of aborting the entire detection.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index abe43ee0f6f816f1..086dd2bb9161dcae 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -4182,7 +4182,7 @@ static bool cus__merging_cu(Dwarf *dw, Elf *elf)
 
 			size_t attrcnt;
 			if (dwarf_getattrcnt (abbrev, &attrcnt) != 0)
-				return false;
+				goto next_abbrev;
 
 			unsigned int attr_num, attr_form;
 			Dwarf_Off aboffset;
@@ -4190,10 +4190,11 @@ static bool cus__merging_cu(Dwarf *dw, Elf *elf)
 			for (j = 0; j < attrcnt; ++j) {
 				if (dwarf_getabbrevattr (abbrev, j, &attr_num, &attr_form,
 							 &aboffset))
-					return false;
+					continue;
 				if (attr_form == DW_FORM_ref_addr)
 					return true;
 			}
+next_abbrev:
 
 			offset += length;
 		}
-- 
2.55.0

