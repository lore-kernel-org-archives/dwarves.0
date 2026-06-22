Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB1B34D3B2
	for <dwarves@vger.kernel.org>; Mon, 22 Jun 2026 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159919; cv=none; b=dL+z1qgJodc76GF5gcChkGrzpr3vlsGpqnocZJcGzJTGr8X7/0hkS0Pgo6YRa6FyRxJNRmQhIZ2ExpuQG0JgaUB9INJ6jqiCh1kwexd17xMIu0x+CoYMIUFmw2u6AxrJGFj4VCqO1ejy++SsDHOvULha4TINA9RA+UyxlHfHMYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159919; c=relaxed/simple;
	bh=wTodIEvl9omlqnNMDeTKrxpcN0fylKgsiW5kBSeG/Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/gDT2AD6Kixgcdt+iiCY9hsNYY0R9waqFKCb1wwBRjOmNtmlzaq+F0iSZ+qajq1ccXowoo8klRkHdpEurN4PyDSKf7KU+W88P4FQMHLADySvx3epnfa7JGbumEA2Lq7OyEEBgMrHma0aZ6+qjIwF/3ecOIYOhWQ6uvI70sSZ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUH9yq0W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUH9yq0W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C021F00A3E;
	Mon, 22 Jun 2026 20:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782159918;
	bh=k7kII5GO3oTpFhw4wWyKGc8UGbK/hwvW484kdYfuTsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CUH9yq0WB6aVACnq770RgNBoITws/EnTnHm22gHGM0/Lza+45F0VS53lBH8lK/pW+
	 mJLKCFzr3HMEs99/thiKxqy6q3910EbjO4Ku54gIBOg5zKbA7AlJrW/uSZKcyKN396
	 +fMYpALKWjr3DSsvt5CGSyZfntajmI2gObkmvgPWyAWfWR+AQGMN+1Qz1X1JdFJ6//
	 GLSDBo/kC2JH8VMebY0S6zLYEKWOCtPQuWHNoikbhgIk3Z9MwVg4bZr1ZLlWkdPp2M
	 lKWINSfh83pFxfxSEzDMHbmJvJmkfLka1DnlUB8ZHzxBJobiafySTC4P4Yr8vl+T23
	 xoT11yzwtIa7g==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 13/16] dwarf_loader: Fix cus__merging_cu failing to detect DW_FORM_ref_addr
Date: Mon, 22 Jun 2026 17:24:36 -0300
Message-ID: <20260622202441.14799-14-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622202441.14799-1-acme@kernel.org>
References: <20260622202441.14799-1-acme@kernel.org>
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

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 7091655588cd8b4d..1ab680a4c30634c8 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3761,7 +3761,7 @@ static bool cus__merging_cu(Dwarf *dw, Elf *elf)
 
 			size_t attrcnt;
 			if (dwarf_getattrcnt (abbrev, &attrcnt) != 0)
-				return false;
+				goto next_abbrev;
 
 			unsigned int attr_num, attr_form;
 			Dwarf_Off aboffset;
@@ -3769,10 +3769,11 @@ static bool cus__merging_cu(Dwarf *dw, Elf *elf)
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
2.54.0

