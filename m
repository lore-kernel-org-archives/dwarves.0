Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4527732E12E;
	Fri, 31 Jul 2026 19:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785526291; cv=none; b=cxWMWDZsUHIdxcShARPjLpzVgPooyav/Hn89+b2PqJTPsWOJCxBxvUyJbv1gVEniZHxrMNi9CR5Qf0xSK7++Kg8VQk0xy1/myR7sH7Edp4PrO89ToPHZhV5ZZveiyD+Hlg+26o4pnSyEPmQPv3yh+lac+rfLe8NCQGQb4IocK9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785526291; c=relaxed/simple;
	bh=Rfv7637c7KQCjSgVk/7OyVmlXUIiiaDdCdnijVgjhY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELWEa7VFS+iHD49MYqmDO+mdONNCdq3kk9FUxmzlUqvGIQK65a34VW31UAKI7ZmIPwlmPm0n9HSCPWf7LZxxwii/DoQDZQqDSHwM/N+KyfTloIry2ta+HGWc3ulGDG6rtKLLHn+eCCOJQCCD717tz3KRd63N7DLS3V6xWAOcF2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3IXzXhJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3IXzXhJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BDD1F00ACF;
	Fri, 31 Jul 2026 19:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785526290;
	bh=8E/zVZSEBDsuVmeCQZZ1N2Oy92Y/xt3LC+5AZ4jYFfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C3IXzXhJyNeQjYV5H7HKNxhjoCfaN/3wSmMweArpqWCLGgUmxxHVABnwR2zeh1Cgq
	 oIZki0Zapm/fhPrfL8fB01ZOZlHQ454tkD4qxtVygjHIxz5DPBxTkLa66MVGUqZR+2
	 HPrUFNgNImpFOnF6A2mI1T9SDCpzws1CDTG3rgw3cfK2tfi+jU30F8+Vhyj1KlyJqe
	 SzTB/tDJrkY6VPDIjWuGsQ8/oZqVMqXMeAmwmDBunTbknZjbKVvfgdCZ7Q/PSykYW7
	 lHQgI1NJYzBUBArY5Wfdgr7/dbedJ6eWBqOgib2gEk0lH0o3/0zT1qVNqa/00r7siw
	 mUbkwdMlP8SDQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Mark Wieelard <mjw@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 08/12] dwarf_loader: Fix cus__merging_cu failing to detect DW_FORM_ref_addr
Date: Fri, 31 Jul 2026 16:30:56 -0300
Message-ID: <20260731193102.110693-9-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731193102.110693-1-acme@kernel.org>
References: <20260731193102.110693-1-acme@kernel.org>
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
index ffdbd6c9fa3e6401..ab4036dc32cdda61 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -4287,7 +4287,7 @@ static bool cus__merging_cu(Dwarf *dw, Elf *elf)
 
 			size_t attrcnt;
 			if (dwarf_getattrcnt (abbrev, &attrcnt) != 0)
-				return false;
+				goto next_abbrev;
 
 			unsigned int attr_num, attr_form;
 			Dwarf_Off aboffset;
@@ -4295,10 +4295,11 @@ static bool cus__merging_cu(Dwarf *dw, Elf *elf)
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

