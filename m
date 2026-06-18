Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B2D274650
	for <dwarves@vger.kernel.org>; Thu, 18 Jun 2026 00:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781744284; cv=none; b=tyMpehP60Yc8pc6rohdUAVTFlfqFEBmvK4tWXj9Qad//IO+OmvNwrfpOEkdlX0yQBhapBMa6wwVHHJZTWdYWYwjZgMD4FBIsP4gQH7W9ViRhq0BmHQhRVh+zClsysjqzkC4cqGY5N5LcwiZ0Jt2acLZYqUYHiFW0zl9w7y0zwaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781744284; c=relaxed/simple;
	bh=r6S79Xx2Q2zh6zPvokozN+aKvdSqiLvnNLVc5eSBYTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lCVHSgkPpIX2OlSBp0+5phtAVpFaAO6hR4+HmgARzxobvvrPIKnnImxxmPISffW9VDM3LAYalqJM2v1i084ghjfxEAEa2onvkF8UIM/0SXHBq/Ozu+lpnEI2F6ZxGFaI4ka+7junqEycfrFIqhVNbKcuGvoNeL3n5ERuLpvUodk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AMALGjeF; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AMALGjeF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781744280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kpmnn5gfKglbrZIZQHmES7AK+jrzS3ppac8ZXzTxEKA=;
	b=AMALGjeFD/7BfdAhMAfU7N5kuSKpmVoCYMdiiYQCahWQuUqa0zRUEyEW26QsP6r+UN/Qs8
	KOxFSrueFqgHtvmWGhOjCcK2nYMTDsSOCXrjYViiP5xYYVCsxN129IXPDoTHeKZIW1HmT5
	xNha3BadqfiBGQVAKCjqrbFSOH0BVMQ=
From: Vineet Gupta <vineet.gupta@linux.dev>
To: dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	acme@kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	jose.marchesi@oracle.com,
	David Faust <david.faust@oracle.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PAHOLE v5 5/5] tests: Add btf_type_tag ordering test
Date: Wed, 17 Jun 2026 17:57:31 -0700
Message-ID: <20260618005731.273181-6-vineet.gupta@linux.dev>
In-Reply-To: <20260618005731.273181-1-vineet.gupta@linux.dev>
References: <20260618005731.273181-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Alan Maguire <alan.maguire@oracle.com>

Add a test that compiles a pointer carrying two btf_type_tags
(__tag(outer) __tag(inner)) and checks the BTF that pahole emits to
ensure the tag chain is PTR -> TYPE_TAG inner -> TYPE_TAG outer ->
struct sample, i.e. the innermost tag is closest to the pointer.

This exercises the type_tag ordering for both encodings: LLVM emits the
annotations as child DIEs in source order (reversed when building the
tag list), while GCC chains them via DW_AT_GNU_annotation already in BTF
order. The test runs with gcc and clang when they support btf_type_tag,
and is skipped when bpftool is unavailable.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 tests/btf_type_tag_order.sh | 179 ++++++++++++++++++++++++++++++++++++
 1 file changed, 179 insertions(+)
 create mode 100755 tests/btf_type_tag_order.sh

diff --git a/tests/btf_type_tag_order.sh b/tests/btf_type_tag_order.sh
new file mode 100755
index 000000000000..09d1ac346000
--- /dev/null
+++ b/tests/btf_type_tag_order.sh
@@ -0,0 +1,179 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+# Check that pahole preserves btf_type_tag order when emitting BTF from DWARF.
+
+source test_lib.sh
+
+outdir=$(make_tmpdir)
+
+# Comment this out to save test data.
+trap cleanup EXIT
+
+title_log "Check BTF type tag order."
+
+GCC=${GCC:-gcc}
+CLANG=${CLANG:-clang}
+PAHOLE=${PAHOLE:-pahole}
+BPFTOOL=${BPFTOOL:-bpftool}
+
+if ! command -v "$BPFTOOL" > /dev/null; then
+	info_log "skip: bpftool not available"
+	test_skip
+fi
+
+compiler_has_btf_type_tag()
+{
+	local compiler=$1
+
+	if ! command -v "$compiler" > /dev/null; then
+		return 1
+	fi
+
+	"$compiler" -x c -E -P - <<'EOF' 2>/dev/null | grep -qx 1
+#ifndef __has_attribute
+#define __has_attribute(x) 0
+#endif
+#if __has_attribute(btf_type_tag)
+1
+#else
+0
+#endif
+EOF
+}
+
+use_gcc=0
+if compiler_has_btf_type_tag "$GCC"; then
+	use_gcc=1
+fi
+
+use_clang=0
+if compiler_has_btf_type_tag "$CLANG"; then
+	use_clang=1
+fi
+
+if [ "$use_gcc" -eq 0 ] && [ "$use_clang" -eq 0 ]; then
+	error_log "Need gcc or clang with btf_type_tag support for test $0"
+	test_fail
+fi
+
+src=$(cat <<EOF
+#define __tag(x) __attribute__((btf_type_tag(#x)))
+
+struct sample {
+	int value;
+};
+
+struct sample __tag(outer) __tag(inner) *global_ptr;
+
+EOF
+)
+
+check_type_tag_order()
+{
+	local btf=$1
+	local dump
+
+	if ! dump=$("$BPFTOOL" btf dump file "$btf"); then
+		return 1
+	fi
+
+	printf '%s\n' "$dump" | awk '
+	function parse_id(line, m) {
+		if (match(line, /^\[([0-9]+)\]/, m))
+			return m[1]
+		return 0
+	}
+	function parse_name(line, m) {
+		if (match(line, /\047([^\047]*)\047/, m))
+			return m[1]
+		return ""
+	}
+	function parse_type(line, m) {
+		if (match(line, /type_id=([0-9]+)/, m))
+			return m[1]
+		return 0
+	}
+	function check_ptr(ptr, id, tags, seen) {
+		id = type[ptr]
+		while (id != 0 && !seen[id]) {
+			seen[id] = 1
+			if (kind[id] == "TYPE_TAG") {
+				tags = tags (tags == "" ? "" : " -> ") name[id]
+				id = type[id]
+				continue
+			}
+			if (kind[id] == "STRUCT" && name[id] == "sample") {
+				if (tags == "inner -> outer")
+					exit 0
+				candidates = candidates (candidates == "" ? "" : ", ") tags
+			}
+			return
+		}
+	}
+	/^\[[0-9]+\]/ {
+		id = parse_id($0)
+		kind[id] = $2
+		name[id] = parse_name($0)
+		type[id] = parse_type($0)
+		if (kind[id] == "PTR")
+			ptrs[++nr_ptrs] = id
+	}
+	END {
+		for (i = 1; i <= nr_ptrs; i++)
+			check_ptr(ptrs[i])
+		if (candidates != "") {
+			print "type tag order mismatch; expected inner -> outer, found " candidates > "/dev/stderr"
+			exit 1
+		}
+		print "could not find tagged pointer to struct sample" > "/dev/stderr"
+		exit 1
+	}'
+}
+
+run_test()
+{
+	local compiler=$1
+	local tmpobj=$2
+	local btf=$3
+
+	info_log "Testing with $compiler"
+
+	if ! echo "$src" | "$compiler" -g -c -x c -o "$tmpobj" - 2>/dev/null; then
+		error_log "Could not compile type tag order test with $compiler"
+		return 1
+	fi
+
+	if ! "$PAHOLE" --btf_features=+type_tag --btf_encode_detached="$btf" "$tmpobj" 2>/dev/null; then
+		error_log "Could not encode BTF for $tmpobj"
+		return 1
+	fi
+
+	if check_type_tag_order "$btf"; then
+		info_log "  passed"
+		return 0
+	fi
+
+	error_log "BTF type tag order does not match expected order ($compiler)"
+	return 1
+}
+
+failed=0
+
+if [ "$use_gcc" -eq 1 ]; then
+	tmpobj=$(make_tmpobj)
+	btf=${tmpobj%.o}.btf
+	run_test "$GCC" "$tmpobj" "$btf" || failed=1
+fi
+
+if [ "$use_clang" -eq 1 ]; then
+	tmpobj=$(make_tmpobj)
+	btf=${tmpobj%.o}.btf
+	run_test "$CLANG" "$tmpobj" "$btf" || failed=1
+fi
+
+if [ "$failed" -eq 0 ]; then
+	test_pass
+else
+	test_fail
+fi
-- 
2.54.0

