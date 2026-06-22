Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBD934D398
	for <dwarves@vger.kernel.org>; Mon, 22 Jun 2026 20:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159907; cv=none; b=qiQ7WmqyA1soJLoEmugU/nfQSmD9Gwj6HPVnqKa9/yZiF/koNnen1QvhVGunU9xOUgzONlypI9gYMppEFes/S51BUUQ1Ek1CE1IJfORtj3DCcN/OW/jsNiT+wjmLbtW5hbrQ3tgz29+P/g+ev6Ef8w8CDC8yvPBZrZBPTWxBkYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159907; c=relaxed/simple;
	bh=VRMy0nCfb/gIZwDVrUtzwJ148fYLkTPCSi6ZlEBgcRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjzxHuFYyVt16TqjMEUBEh0WLW45OtSdFinEZQd8qpYHGs8NWFAOaCnIhcliSRka3djZlaglzdajZEuLsH3EV/TKekVpdUCQHMDPgVL9oqdcWCVVAiCnjBb7ALCEHsLXI+0IZGfh2tknsBX58XLwSiy8Ii51ZEfzeiNA92zgQBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rc2Vz52P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rc2Vz52P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5841F000E9;
	Mon, 22 Jun 2026 20:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782159906;
	bh=vpq4F/8rTkICa6VEqxXsppQ+18MTkl6xAhQijqbHLbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rc2Vz52P4xcWrgSsRHJD/F8GnBIGsKXfSDiIdLJ08qAYsAenDUunju4Yae1fYqJh+
	 QhTQiLLsTAne/F3zdbVwNjG3kuyoskO3P5UAlDevuhkoSeFksSzAygBEjqdlz4vbn2
	 ucEicxPhCp1B4vgqgFISW/EMHNSye/+cDEe+FL7fA9c3g22cZuoi96St133AokUa4i
	 ieYBnG4ceqw1UViQZEPMTZCu2mOPceM8dZ4dEOIPdBHyE4gwYH1Mlnm5KxYKUVfRbe
	 4Tlls9VlXdqhVE4qJ79EShYvuv69nz+AQx0o4Vu5V6/CYdRnqnMRKSMoZfaXJ26reB
	 w76TZJfIswW+A==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 08/16] encoders: Handle DW_TAG_subprogram in enumerations during BTF/CTF encoding
Date: Mon, 22 Jun 2026 17:24:31 -0300
Message-ID: <20260622202441.14799-9-acme@kernel.org>
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

Since commit 5c0162ee40f06c95 ("dwarf_loader: Initial support for
DW_TAG_subprogram in DW_TAG_enumeration"), Rust enumerations with
associated functions (impl blocks) are loaded with DW_TAG_subprogram
children in their namespace.

However, the BTF and CTF encoders were not aware of this and treated
these subprogram tags as unexpected, producing noisy warnings:

  Unexpected DW_TAG_subprogram <0>, skipping it...

This was problematic for real Rust binaries.  For instance, BTF encoding
the sashiko-cli Rust binary produced 653 such warnings from enumerations
like Ordering (137), ChunkedState (106), TlsState (20), and others.
Even the Rust standard library object produced 8 warnings.

Since BTF and CTF have no representation for subprograms inside
enumerations, we should skip them, but inform the user about it rather
than warn about an unexpected tag.

Switch the enumerator iteration in both encoders from an if/continue
pattern to a proper switch statement:

  - DW_TAG_enumerator: processed normally
  - DW_TAG_subprogram: silently skipped (BTF logs it in verbose mode)
  - anything else: still warned about with the enumeration name for
    better diagnostics

Before:

  $ pahole --btf_encode sashiko-cli 2>&1 | grep -c subprogram
  653

After:

  $ pahole --btf_encode sashiko-cli 2>&1 | grep -c subprogram
  0

  $ pahole -V --btf_encode sashiko-cli 2>&1 | grep -c 'subprogram in enumeration'
  653

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 btf_encoder.c | 22 +++++++++++++++-------
 ctf_encoder.c | 15 ++++++++++-----
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 82dd5f27138c2949..dc1e18a986605d04 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1798,14 +1798,22 @@ static int32_t btf_encoder__add_enum_type(struct btf_encoder *encoder, struct ta
 		return type_id;
 
 	type__for_each_enumerator(etype, pos) {
-		if (pos->tag.tag != DW_TAG_enumerator) {
-			fprintf(stderr, "Unexpected DW_TAG_%s <%llx>, skipping it...\n",
-				dwarf_tag_name(pos->tag.tag), tag__orig_id(&pos->tag, cu));
-			continue;
+		switch (pos->tag.tag) {
+		case DW_TAG_enumerator:
+			name = enumerator__name(pos);
+			if (btf_encoder__add_enum_val(encoder, name, pos->value, etype, conf_load))
+				return -1;
+			break;
+		case DW_TAG_subprogram:
+			if (encoder->verbose)
+				fprintf(stderr, "BTF: DW_TAG_subprogram in enumeration '%s' not supported, skipping\n",
+					type__name(etype) ?: "(anonymous)");
+			break;
+		default:
+			fprintf(stderr, "BTF: unexpected DW_TAG_%s in enumeration '%s', skipping\n",
+				dwarf_tag_name(pos->tag.tag), type__name(etype) ?: "(anonymous)");
+			break;
 		}
-		name = enumerator__name(pos);
-		if (btf_encoder__add_enum_val(encoder, name, pos->value, etype, conf_load))
-			return -1;
 	}
 
 	return type_id;
diff --git a/ctf_encoder.c b/ctf_encoder.c
index f2c63c2b039026f8..f9e75a5821ce4e83 100644
--- a/ctf_encoder.c
+++ b/ctf_encoder.c
@@ -155,12 +155,17 @@ static int enumeration_type__encode(struct tag *tag, const struct cu *cu, uint32
 
 	struct enumerator *pos;
 	type__for_each_enumerator(etype, pos) {
-		if (pos->tag.tag != DW_TAG_enumerator) {
-			fprintf(stderr, "Unexpected DW_TAG_%s <%llx>, skipping it...\n",
-				dwarf_tag_name(pos->tag.tag), tag__orig_id(&pos->tag, cu));
-			continue;
+		switch (pos->tag.tag) {
+		case DW_TAG_enumerator:
+			ctf__add_enumerator(ctf, pos->name, pos->value, &position);
+			break;
+		case DW_TAG_subprogram:
+			break;
+		default:
+			fprintf(stderr, "CTF: unexpected DW_TAG_%s in enumeration '%s', skipping\n",
+				dwarf_tag_name(pos->tag.tag), type__name(etype) ?: "(anonymous)");
+			break;
 		}
-		ctf__add_enumerator(ctf, pos->name, pos->value, &position);
 	}
 
 	return 0;
-- 
2.54.0

