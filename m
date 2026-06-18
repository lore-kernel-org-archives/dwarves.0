Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE21274FDF
	for <dwarves@vger.kernel.org>; Thu, 18 Jun 2026 00:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781744281; cv=none; b=GYNi6fZiQzmwkO71HwtC92/JvFnGCOozm5tls4da+GydvrF6bdpcSqPocDsL0wcdYj4oKk7thrReYuqp4NeLoHurYkgQIL/TM+AH2kxZqo/vFMi46QmlR3ihifFT4Z0KC3iCkJeHyN/kuKVpDGY1t/glYydgZ8C1blLmlfp/5VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781744281; c=relaxed/simple;
	bh=79X7oL8cSGpC56pkaUi08p44ZXuXafiLYys4SFI3mFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQmdCKLX6F+rUW+YA4CaG3P+DMPQG/gD2PNprLMVXoUiqUcoiTAjoj+tWzdzaIuuwh6QjQcC8OOAuMy9mk9QPLW9BvjnjsayMXtAnXzYUw2Mfv4rCgWxiuRezvwsoS1IIIfFykXPo1MkhbNmrqzSXfQ44iGXuenrpZQwHdw8fI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a0n2is3H; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a0n2is3H"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781744277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+q5gxFpxEXhfT4wn2QqKMnqkXXHptiKiynM11bTUGW0=;
	b=a0n2is3HYy3U6KY0D6PdWym5idtT+RkWuZDbYDtuX9KURYLECgaHMR5FVWtp+JPmuBAUrj
	YJYqO7le5e2sTYroRERH9lavKE2tVi2hm+nJKL+Z23sb2ijohA5LRXER3xVa+T/slPowUD
	H6JAlY3PGhNILxH3vIb6u/cBv5eRmh8=
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
Subject: [PAHOLE v5 4/5] tests: Support GCC in pfunct-btf-decl-tags test
Date: Wed, 17 Jun 2026 17:57:30 -0700
Message-ID: <20260618005731.273181-5-vineet.gupta@linux.dev>
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

GCC 16+ supports btf_decl_tag via DW_TAG_GNU_annotation. Update the
test to run with both GCC (>= 16) and clang when available, instead
of requiring clang only.

Compile the clang case natively and encode BTF with "pahole -J" (like
the GCC case) rather than emitting BPF-target BTF directly, so both
compilers exercise the same DWARF -> BTF path.

Add a function with a parameter decl tag (qux) to cover decl tags that
carry a component_idx, and make the awk post-processing pass through
lines that have no leading tags.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
Changes since v4 [4]
 - Test function param decl tag [Alan]
 - Missing "pahole -j" for clang [Yonghong]
 - Collected the review tags [Emil, Yonghong]

[4] https://lore.kernel.org/bpf/20260602195512.1511013-3-vineet.gupta@linux.dev/
---

 tests/pfunct-btf-decl-tags.sh | 93 ++++++++++++++++++++++++++---------
 1 file changed, 70 insertions(+), 23 deletions(-)

diff --git a/tests/pfunct-btf-decl-tags.sh b/tests/pfunct-btf-decl-tags.sh
index 35884b4e8687..520148b2ccef 100755
--- a/tests/pfunct-btf-decl-tags.sh
+++ b/tests/pfunct-btf-decl-tags.sh
@@ -6,43 +6,60 @@
 source test_lib.sh
 
 outdir=$(make_tmpdir)
-tmpobj=$(make_tmpobj)
 
 # Comment this out to save test data.
 trap cleanup EXIT
 
 title_log "Check that pfunct can print btf_decl_tags read from BTF."
 
-# gcc now also supports decl tags as of gcc commit 43dcea48b8c,
-# in upstream version 16.
-# UPTODO: add a check here for that.
+# gcc 16+ supports decl tags via DW_TAG_GNU_annotation (gcc commit ac7027f180b).
 
+GCC=${GCC:-gcc}
 CLANG=${CLANG:-clang}
-if ! command -v $CLANG > /dev/null; then
-	error_log "Need clang for test $0"
+
+use_gcc=0
+if command -v $GCC > /dev/null; then
+	gcc_ver=$($GCC -dumpversion 2>/dev/null | cut -d. -f1)
+	if [ "$gcc_ver" -ge 16 ] 2>/dev/null; then
+		use_gcc=1
+	fi
+fi
+
+use_clang=0
+if command -v $CLANG > /dev/null; then
+	use_clang=1
+fi
+
+if [ "$use_gcc" -eq 0 ] && [ "$use_clang" -eq 0 ]; then
+	error_log "Need gcc >= 16 or clang for test $0"
 	test_fail
 fi
 
-(cat <<EOF
+src=$(cat <<EOF
 #define __tag(x) __attribute__((btf_decl_tag(#x)))
 
 __tag(a) __tag(b) __tag(c) void foo(void) {}
 __tag(a) __tag(b)          void bar(void) {}
 __tag(a)                   void buz(void) {}
+void qux(int __tag(param_a) arg) {}
 
 EOF
-) | $CLANG --target=bpf -c -g -x c -o $tmpobj -
+)
 
 # tags order is not guaranteed
 sort_tags=$(cat <<EOF
 {
-match(\$0,/^(.*) (void .*)/,tags_and_proto);
-tags  = tags_and_proto[1];
-proto = tags_and_proto[2];
-split(tags, tags_arr ,/ /);
-asort(tags_arr);
-for (t in tags_arr) printf "%s ", tags_arr[t];
-print proto;
+delete tags_arr;
+if (match(\$0,/^(.*) (void .*)/,tags_and_proto)) {
+	tags  = tags_and_proto[1];
+	proto = tags_and_proto[2];
+	split(tags, tags_arr ,/ /);
+	asort(tags_arr);
+	for (t in tags_arr) printf "%s ", tags_arr[t];
+	print proto;
+} else {
+	print \$0;
+}
 }
 EOF
 )
@@ -51,19 +68,49 @@ expected=$(cat <<EOF
 a b c void foo(void);
 a b void bar(void);
 a void buz(void);
+void qux(param_a int arg);
 EOF
 )
 
-out=$(pfunct -P -F btf $tmpobj | awk "$sort_tags" | sort)
-d=$(diff -u <(echo "$expected") <(echo "$out"))
+run_test() {
+	local compiler=$1
+	local tmpobj=$2
+
+	info_log "Testing with $compiler"
+	out=$(pfunct -P -F btf $tmpobj | awk "$sort_tags" | sort)
+	d=$(diff -u <(echo "$expected") <(echo "$out"))
+
+	if [[ "$d" == "" ]]; then
+		info_log "  passed"
+		return 0
+	else
+		error_log "pfunct output does not match expected ($compiler):"
+		info_log "$d"
+		info_log
+		info_log "Complete output:"
+		info_log "$out"
+		return 1
+	fi
+}
+
+failed=0
+
+if [ "$use_gcc" -eq 1 ]; then
+	tmpobj=$(make_tmpobj)
+	echo "$src" | $GCC -c -g -x c -o $tmpobj - 2>/dev/null
+	pahole -J $tmpobj 2>/dev/null
+	run_test "$GCC (version $gcc_ver)" "$tmpobj" || failed=1
+fi
+
+if [ "$use_clang" -eq 1 ]; then
+	tmpobj=$(make_tmpobj)
+	echo "$src" | $CLANG -c -g -x c -o $tmpobj -
+	pahole -J $tmpobj 2>/dev/null
+	run_test "$CLANG" "$tmpobj" || failed=1
+fi
 
-if [[ "$d" == "" ]]; then
+if [ "$failed" -eq 0 ]; then
 	test_pass
 else
-	error_log "pfunct output does not match expected:"
-	info_log "$d"
-	info_log
-	info_log "Complete output:"
-	info_log "$out"
 	test_fail
 fi
-- 
2.54.0

