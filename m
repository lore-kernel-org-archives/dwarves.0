Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA19218E91
	for <dwarves@vger.kernel.org>; Tue,  2 Jun 2026 19:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780430142; cv=none; b=fsBl01NQtdQlVvv4Rr2vIOc5xEG9HW2Nf3G3OkN5t4VOO9+Uew8lD3X5vZNVOWLt66njqz09Vp5+IQ9Nvu4zjQROYPYRJ0gJR2IAPCBJv/k+KbFrrceEExy4S7pv9ImB9/dFA+839NDdaCAcBH93Ktlq1aFKJzQD3SlBd3hcJOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780430142; c=relaxed/simple;
	bh=/ZYXOFo5vE+PKc3iP2MKPNyevVs5uMvbqPg8fGxT8T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5sNd89eqg7o47JTOKN4DBFpvEjKM8oIMrMLDItodL1gqcVBuvZcyYWxN30wBZEa0s/0fng8XGCcfVPnwDgyeMiFanoStHnjAdL2wkxslEluTvHBSKgG8g9I23TqUlHM+DqiwJnyAx5iZ+ZfZW4xu4zBDEqrPuR/xX6o1yimqvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LZ57TRTc; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LZ57TRTc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780430138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfv4Bh8evilYADb0ch95QVByYGGkM5rm8RQ3ezLVzuc=;
	b=LZ57TRTcTxjBCtXb3ZF2yjIuOJOW9VBKOpBn49oJBq+uqcoKO4sXQ6RuoOi1WYBMW4Fm2N
	MLvbpA4lLTBZeoVbJYDO/OG/hNmuPkT3XcqEgn2+6f0Y44Ot4vP4yfBwR/ahUa5G4hYutf
	SBWY2WKqaIy/JVcjbpRbcyPYkQkHdhE=
From: Vineet Gupta <vineet.gupta@linux.dev>
To: dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	acme@kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	jose.marchesi@oracle.com,
	David Faust <david.faust@oracle.com>,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PAHOLE v4 3/3] tests: Support GCC in pfunct-btf-decl-tags test
Date: Tue,  2 Jun 2026 12:55:12 -0700
Message-ID: <20260602195512.1511013-3-vineet.gupta@linux.dev>
In-Reply-To: <20260602195512.1511013-1-vineet.gupta@linux.dev>
References: <20260602195512.1511013-1-vineet.gupta@linux.dev>
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

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 tests/pfunct-btf-decl-tags.sh | 72 +++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 16 deletions(-)

diff --git a/tests/pfunct-btf-decl-tags.sh b/tests/pfunct-btf-decl-tags.sh
index 35884b4e8687..a46aa1f3df55 100755
--- a/tests/pfunct-btf-decl-tags.sh
+++ b/tests/pfunct-btf-decl-tags.sh
@@ -6,24 +6,36 @@
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
@@ -31,7 +43,7 @@ __tag(a) __tag(b)          void bar(void) {}
 __tag(a)                   void buz(void) {}
 
 EOF
-) | $CLANG --target=bpf -c -g -x c -o $tmpobj -
+)
 
 # tags order is not guaranteed
 sort_tags=$(cat <<EOF
@@ -54,16 +66,44 @@ a void buz(void);
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
+	echo "$src" | $CLANG --target=bpf -c -g -x c -o $tmpobj -
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

