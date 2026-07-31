Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2A1328267;
	Fri, 31 Jul 2026 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785526284; cv=none; b=eXMUQ2opCMUGhbxleMgF3Gz7uuQgFSzYZTGvNqsbS+OhPQOLuw74XmoU/7UlQRAMMRQJxaSjMtflbHj5u6CON8TSbE+Oja7Kn0IQFQdYZXXba3H257treAsCfuqzmtCv68lSIY/vcQI+soStEukmVegc+8mXaKsmkYCrHZEOATA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785526284; c=relaxed/simple;
	bh=5l6FaYJkn6oCcAKEZjnCMRSVrNmMBbu07ooZ4KCl1Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KoTSQ090eyZugXqBOnDnEq7uAr+uD6IunBALrmRQBj06nYUL2+qHJ+oXz44IlxQ6rNWtEdlRvKcuyqltrIdPbz1Tx1fh2vNXPnbJqwHojNG3FLzn+pnwgnCZ8NYRpJuBTBrh/2/h6Ic17s+RT6sNKmPc5itHynMw+XM4TEck1L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/Qy0ABG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/Qy0ABG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04771F00ACA;
	Fri, 31 Jul 2026 19:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785526282;
	bh=GTtXtrAiSx2sKu1nVc+5C+moYtTj9XeN8boWgwBW31w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J/Qy0ABGKUeTZCztuiNbXcv1CV7zADIksLyxTSUQnFzxk1v8ts11/KWlhsOewhSM4
	 u1ABfMXY+OXuoThkl33b4KuvO+yEWOfJD1M7/HPcnLZnzH252yCZXItNsa9RvbAX/M
	 JsTjDNMt7qDUa1XwNUx8zfOAWaz9nEtgk3N08sAdnuZeqJOEvRZDvOuM5273kOfrDM
	 LQn5w92CoWzdf26Ek2SnvrvkYrJiqBA269hHeovYyDoLydCpStxJ/iafVdNteamDXt
	 KGN17SpbxCgzFArHObI5XI0phC0dZMzpClAWQ9Js3TcP4L/XNCqUna1fGWof4w02Cy
	 P0l3R+tNty9PA==
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
Subject: [PATCH 05/12] dwarf_loader: Handle DW_FORM_block in attr_numeric for Rust discriminant values
Date: Fri, 31 Jul 2026 16:30:53 -0300
Message-ID: <20260731193102.110693-6-acme@kernel.org>
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

Rust enums with 128-bit discriminant types (i128/u128) encode their
DW_AT_discr_value as a DW_FORM_block1 containing a 16-byte little-endian
integer, rather than using a standard data form like DW_FORM_data*.

Since attr_numeric did not handle DW_FORM_block*, these discriminant
values were not read and produced 311 warnings on a real Rust binary like
sashiko-cli:

  DW_AT_<0x16>=0xa
  DW_AT_<0x16>=0xa
  ...

(0x16 = DW_AT_discr_value, 0xa = DW_FORM_block1)

Add DW_FORM_block1/block2/block4/block to attr_numeric, reading up to 8
bytes from the block into a uint64_t via memcpy and converting from
little-endian with le64toh() so the result is correct on big-endian hosts
as well.  This covers all practical discriminant values.

Before (sashiko-cli):

  $ pahole --btf_encode sashiko-cli 2>&1 | grep -c 'DW_AT_'
  311

After:

  $ pahole --btf_encode sashiko-cli 2>&1 | wc -l
  0

All warnings from Rust DWARF encoding of sashiko-cli are now resolved.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c        |  51 +++++++++++++--
 tests/block_endian.sh | 146 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 190 insertions(+), 7 deletions(-)
 create mode 100755 tests/block_endian.sh

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 4979968828c63d8f..934d410b2f983828 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -7,6 +7,7 @@
 #include <assert.h>
 #include <dirent.h>
 #include <dwarf.h>
+#include <endian.h>
 #include <elfutils/libdwfl.h>
 #include <elfutils/version.h>
 #include <errno.h>
@@ -335,7 +336,7 @@ static uint64_t __libdw_get_uleb128(uint64_t acc, uint32_t i,
 		var = __libdw_get_uleb128 (var, 1, &(addr));	\
 	} while (0)
 
-static uint64_t attr_numeric(Dwarf_Die *die, uint32_t name)
+static uint64_t __attr_numeric(Dwarf_Die *die, uint32_t name, bool little_endian)
 {
 	Dwarf_Attribute attr;
 	uint32_t form;
@@ -371,6 +372,31 @@ static uint64_t attr_numeric(Dwarf_Die *die, uint32_t name)
 			return value;
 	}
 		break;
+	case DW_FORM_block1:
+	case DW_FORM_block2:
+	case DW_FORM_block4:
+	case DW_FORM_block: {
+		/* Block data is in target byte order, convert to host */
+		Dwarf_Block block;
+		if (dwarf_formblock(&attr, &block) == 0 && block.length > 0) {
+			uint64_t value = 0;
+			size_t n = block.length > sizeof(value) ? sizeof(value) : block.length;
+			if (little_endian) {
+				memcpy(&value, block.data, n);
+				return le64toh(value);
+			}
+			/*
+			 * BE: the least-significant bytes are at the END of
+			 * the block.  Skip any high bytes that don't fit in
+			 * uint64_t, then accumulate the rest MSB-first.
+			 */
+			size_t off = block.length - n;
+			for (size_t i = 0; i < n; i++)
+				value = (value << 8) | (uint8_t)block.data[off + i];
+			return value;
+		}
+	}
+		break;
 	default:
 		fprintf(stderr, "DW_AT_<0x%x>=0x%x\n", name, form);
 		break;
@@ -379,6 +405,16 @@ static uint64_t attr_numeric(Dwarf_Die *die, uint32_t name)
 	return 0;
 }
 
+/*
+ * Most callers don't use DW_FORM_block, so this wrapper keeps them unchanged.
+ * When the attribute can be a block (e.g. DW_AT_discr_value), use
+ * __attr_numeric() with the CU's endianness instead.
+ */
+static uint64_t attr_numeric(Dwarf_Die *die, uint32_t name)
+{
+	return __attr_numeric(die, name, true);
+}
+
 static uint64_t attr_alignment(Dwarf_Die *die, struct conf_load *conf)
 {
 	return conf->ignore_alignment_attr ? 0 : attr_numeric(die, DW_AT_alignment);
@@ -712,7 +748,7 @@ static struct enumerator *enumerator__new(Dwarf_Die *die, struct cu *cu, struct
 	if (enumerator != NULL) {
 		tag__init(&enumerator->tag, cu, die);
 		enumerator->name = attr_string(die, DW_AT_name, conf);
-		enumerator->value = attr_numeric(die, DW_AT_const_value);
+		enumerator->value = __attr_numeric(die, DW_AT_const_value, cu->little_endian);
 	}
 
 	return enumerator;
@@ -801,7 +837,7 @@ static struct constant *constant__new(Dwarf_Die *die, struct cu *cu, struct conf
 	if (constant != NULL) {
 		tag__init(&constant->tag, cu, die);
 		constant->name = attr_string(die, DW_AT_name, conf);
-		constant->value = attr_numeric(die, DW_AT_const_value);
+		constant->value = __attr_numeric(die, DW_AT_const_value, cu->little_endian);
 	}
 
 	return constant;
@@ -1080,7 +1116,7 @@ static struct class_member *class_member__new(Dwarf_Die *die, struct cu *cu,
 
 		if (!cu__is_c(cu)) {
 			member->accessibility = attr_numeric(die, DW_AT_accessibility);
-			member->const_value   = attr_numeric(die, DW_AT_const_value);
+			member->const_value   = __attr_numeric(die, DW_AT_const_value, cu->little_endian);
 			member->virtuality    = attr_numeric(die, DW_AT_virtuality);
 		}
 		member->hole = 0;
@@ -1189,8 +1225,8 @@ static struct template_value_param *template_value_param__new(Dwarf_Die *die, st
 	if (tvparm != NULL) {
 		tag__init(&tvparm->tag, cu, die);
 		tvparm->name = attr_string(die, DW_AT_name, conf);
-		tvparm->const_value = attr_numeric(die, DW_AT_const_value);
-		tvparm->default_value = attr_numeric(die, DW_AT_default_value);
+		tvparm->const_value = __attr_numeric(die, DW_AT_const_value, cu->little_endian);
+		tvparm->default_value = __attr_numeric(die, DW_AT_default_value, cu->little_endian);
 	}
 
 	return tvparm;
@@ -1246,7 +1282,8 @@ static struct variant *variant__new(Dwarf_Die *die, struct cu *cu, struct conf_l
 
 	if (var != NULL) {
 		tag__init(&var->tag, cu, die);
-		var->discr_value = attr_numeric(die, DW_AT_discr_value);
+		/* DW_AT_discr_value uses DW_FORM_block, needs target endianness */
+		var->discr_value = __attr_numeric(die, DW_AT_discr_value, cu->little_endian);
 		var->name = NULL;
 
 		Dwarf_Die child;
diff --git a/tests/block_endian.sh b/tests/block_endian.sh
new file mode 100755
index 0000000000000000..9ede49a9a133e5a1
--- /dev/null
+++ b/tests/block_endian.sh
@@ -0,0 +1,146 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright © 2026 Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+#
+# Test the DW_FORM_block byte order conversion logic used by
+# __attr_numeric() in dwarf_loader.c.  Exercises both LE and BE
+# conversion paths with block lengths 1, 2, 4, and 8 to catch
+# endianness mistakes like using be64toh on sub-8-byte blocks.
+
+. "$(dirname "$0")/test_lib.sh"
+
+outdir=$(make_tmpdir)
+trap cleanup EXIT
+
+title_log "DW_FORM_block byte order conversion."
+
+CC=${CC:-gcc}
+if ! command -v ${CC%% *} > /dev/null 2>&1; then
+	info_log "skip: $CC not available"
+	test_skip
+fi
+
+cat > "$outdir/block_endian_test.c" << 'EOF'
+#define _DEFAULT_SOURCE
+#include <endian.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+
+/*
+ * These two functions replicate the exact conversion logic from
+ * __attr_numeric() in dwarf_loader.c for the DW_FORM_block case.
+ * Any change to that code must be mirrored here.
+ */
+static uint64_t block_to_u64_le(const uint8_t *data, size_t len)
+{
+	uint64_t value = 0;
+	size_t n = len > sizeof(value) ? sizeof(value) : len;
+
+	memcpy(&value, data, n);
+	return le64toh(value);
+}
+
+static uint64_t block_to_u64_be(const uint8_t *data, size_t len)
+{
+	uint64_t value = 0;
+	size_t n = len > sizeof(value) ? sizeof(value) : len;
+
+	for (size_t i = 0; i < n; i++)
+		value = (value << 8) | data[i];
+	return value;
+}
+
+struct test_case {
+	const char  *name;
+	int          is_be;       /* 0 = LE target, 1 = BE target */
+	uint64_t     expected;
+	size_t       len;
+	uint8_t      data[8];
+};
+
+static const struct test_case tests[] = {
+	/* LE target, 1 byte */
+	{ "LE n=1 val=5",     0, 5,     1, {0x05} },
+	{ "LE n=1 val=0",     0, 0,     1, {0x00} },
+	{ "LE n=1 val=255",   0, 255,   1, {0xff} },
+
+	/* LE target, 2 bytes */
+	{ "LE n=2 val=256",   0, 256,   2, {0x00, 0x01} },
+	{ "LE n=2 val=0x0102",0, 0x0102,2, {0x02, 0x01} },
+
+	/* LE target, 4 bytes */
+	{ "LE n=4 val=66051", 0, 66051, 4, {0x03, 0x02, 0x01, 0x00} },
+	{ "LE n=4 val=1",     0, 1,     4, {0x01, 0x00, 0x00, 0x00} },
+
+	/* LE target, 8 bytes */
+	{ "LE n=8",           0, 0x0807060504030201ULL, 8,
+	  {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08} },
+
+	/* BE target, 1 byte (single byte has no endianness) */
+	{ "BE n=1 val=5",     1, 5,     1, {0x05} },
+	{ "BE n=1 val=0",     1, 0,     1, {0x00} },
+	{ "BE n=1 val=255",   1, 255,   1, {0xff} },
+
+	/* BE target, 2 bytes */
+	{ "BE n=2 val=256",   1, 256,   2, {0x01, 0x00} },
+	{ "BE n=2 val=0x0102",1, 0x0102,2, {0x01, 0x02} },
+	{ "BE n=2 val=1",     1, 1,     2, {0x00, 0x01} },
+
+	/* BE target, 4 bytes */
+	{ "BE n=4 val=66051", 1, 66051, 4, {0x00, 0x01, 0x02, 0x03} },
+	{ "BE n=4 val=1",     1, 1,     4, {0x00, 0x00, 0x00, 0x01} },
+
+	/* BE target, 8 bytes */
+	{ "BE n=8",           1, 0x0102030405060708ULL, 8,
+	  {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08} },
+};
+
+int main(void)
+{
+	int failures = 0;
+	size_t n = sizeof(tests) / sizeof(tests[0]);
+
+	for (size_t i = 0; i < n; i++) {
+		const struct test_case *t = &tests[i];
+		uint64_t got;
+
+		if (t->is_be)
+			got = block_to_u64_be(t->data, t->len);
+		else
+			got = block_to_u64_le(t->data, t->len);
+
+		if (got != t->expected) {
+			fprintf(stderr, "FAIL: %s: expected 0x%llx, got 0x%llx\n",
+				t->name,
+				(unsigned long long)t->expected,
+				(unsigned long long)got);
+			failures++;
+		}
+	}
+
+	if (failures) {
+		fprintf(stderr, "%d/%zu tests failed\n", failures, n);
+		return 1;
+	}
+	return 0;
+}
+EOF
+
+$CC -std=c11 -Wall -Werror -o "$outdir/block_endian_test" \
+	"$outdir/block_endian_test.c" 2>/dev/null
+if [ $? -ne 0 ]; then
+	error_log "FAIL: failed to compile block_endian_test"
+	test_fail
+fi
+
+output=$("$outdir/block_endian_test" 2>&1)
+if [ $? -ne 0 ]; then
+	error_log "FAIL: block endian conversion test failed:"
+	error_log "$output"
+	test_fail
+fi
+
+info_log "   block form LE+BE conversion: ok"
+
+test_pass
-- 
2.55.0

