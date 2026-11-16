Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828049;
	b=nvVdh6oBwRd9kvr0MpLijJAykQ9W7rBbJgnW9mGQId0fzyZ04Ew1/J9uiYR2koNVLRfy
	 dZhZEbqhk7IFZsEuFPRDUUGzdGIXxot47Gq11C4J1oRQGKhys/LgWTugslOet/7v3g4GG
	 T/Qf+/Ws7L459HwJLYVos/C7QP/zJ2PTQEJVN9GT2td8iaiWmK43wJiOy4kFBlbCMpiYz
	 moYwKG6NzQtyj3sDDyd2u2wmkFk3lIE35lN+HF3RduXurYJlI21hLaSkpRCHwV31lJWBK
	 3MIkonV4U0qqJDEQf/fQWmBcrEtZvdVseftpTHR2Bt8I4msoK/7h4gJnOVoGT+Uvurg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828049;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Az2ViXJ04sdZmBQmCGTzpnmVFiwuagigpsEFhitrevM=;
	b=b8v8AemftQ8GzhQPRaOG/2DSWfLJerOyAAXo3XoUXNyQWHSHPJ2IDHDQI0oIkpFjsBVG
	 aK5FuSaUFcHB8XsQB4NhBkiZX4fZqoMPWtLeA8K4Am/M/fONIszZ2avEzWqVlhGbNggu0
	 hZoujmEUIODhi8F2O5ljMl6WQERafy0SdJr1UdE4OOjC1AqsUEAjO0DSUmhIht5Ijk07t
	 K4gSLk4z1R/EUogWiKRBbp7Qx8T/VlcInfNjFAj2QYtU+PMHRhtwRGFDGWATonmDhrzaa
	 duZfcwwKSL5Q4dHyMzoHPj5L8i8Wo97OS6xzKczrix1H6RqrQjNr+oycCG0gJV54kJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=busEHSli;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4006071817
	for <dwarves@vger.kernel.org>; Mon, 16 Nov 2026 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=busEHSli
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CFA1F000C4;
	Mon, 16 Nov 2026 11:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828048;
	bh=Az2ViXJ04sdZmBQmCGTzpnmVFiwuagigpsEFhitrevM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=busEHSliS9uDdmmjI98rDsaU0yprKChh/9T0Eeu67Ccq5qwia/GTYnvN+ipYQtFbn
	 yQGONIL9+ao979nlAQTeNNVY47EctpjBli8rPEdyn9itbVR72kxe0uDXwZpiBxeVls
	 Yl8ctuh2/nBxRSb1zokCpmufIo68o0PyKgJgSDUvgcU7EVoOuEWO+SwcLFDUuZ3ADH
	 ihVerEy5eFNKL9EL4JGrYaRw1jh1lZSHLc5vhoJ63JDeydVFNxB75RWxJLJSUa5MQX
	 nJJwY/GEOqlZgxgXflA7UuTmZj/G1dm3ygVWEx+wCUNL0DawCoylbgyFtcvlCDIBNW
	 SssewqAyeeCMA==
From: Alan Maguire <almagui@kernel.org>
To: dwarves@vger.kernel.org
Cc: Alan Maguire <almagui@kernel.org>
Subject: [PATCH dwarves 2/6] tests: Match BTF and DWARF functions with set operations in btf_functions.sh
Date: Mon, 16 Nov 2026 11:20:39 +0000
Message-ID: <20261116112043.3831978-3-almagui@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116112043.3831978-1-almagui@kernel.org>
References: <20261116112043.3831978-1-almagui@kernel.org>
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Post: <mailto:dwarves@vger.kernel.org>
List-Help: <mailto:dwarves+help@vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
List-Owner: <mailto:dwarves+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btf_functions.sh validates each BTF function prototype by running
grep -F over the full list of DWARF prototypes, once per BTF function.
That is O(BTF * DWARF) with a fork per function (~50k on a typical
kernel), and on a clang ThinLTO kernel the test no longer completes in
a reasonable time in CI.

Replace the loop with sorted set operations: comm for exact and
"inline" matches, and comm/join on const-stripped prototypes for the
const-insensitive case, keeping the original BTF prototype so
mismatches are reported as before.  Run them under LC_ALL=C so sort,
comm and join agree on collation.

Matching is now on whole lines rather than substrings.  Previously
grep -F could return several DWARF lines (e.g. "int foo(void)" also
matches "unsigned int foo(void)", or const and non-const instances of
the same function), so such functions failed the exact comparison and
were only accepted via the const-insensitive fallback.  They are now
counted as exact matches; the total number of matched functions is
unchanged.

On a local x86_64 vmlinux the test drops from 2m44s to 34s with
identical results otherwise.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Alan Maguire <almagui@kernel.org>
---
 tests/btf_functions.sh | 71 ++++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 27 deletions(-)

diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
index 436ebeb..778f9fa 100755
--- a/tests/btf_functions.sh
+++ b/tests/btf_functions.sh
@@ -55,35 +55,52 @@ pfunct --all --no_parm_names --format_path=dwarf $vmlinux | \
 pfunct --all --no_parm_names --format_path=btf $outdir/vmlinux.btf 2>/dev/null|\
 	awk '{ gsub("^(bpf_kfunc |bpf_fastcall )+",""); print $0}'|sort|uniq > $outdir/btf.funcs
 
-exact=0
-inline=0
-const_insensitive=0
+# Match BTF prototypes against DWARF prototypes with sorted set operations
+# (comm/join) rather than one grep of dwarf.funcs per BTF function; the
+# latter is O(BTF * DWARF) and becomes very slow on large (e.g. LTO) kernels.
+# Matching is on whole lines.  Use the C locale so sort, comm and join
+# agree on collation order.
+(
+export LC_ALL=C
+cd $outdir
+
+sort -u btf.funcs > btf.sorted
+sort -u dwarf.funcs > dwarf.sorted
+
+# 1. exact matches
+comm -12 btf.sorted dwarf.sorted > match.exact
+comm -23 btf.sorted dwarf.sorted > nomatch.exact
+
+# 2. function might be declared inline in DWARF.
+sed 's/^/inline /' nomatch.exact | sort > nomatch.exact.inline
+comm -12 nomatch.exact.inline dwarf.sorted > match.inline
+comm -23 nomatch.exact.inline dwarf.sorted | sed 's/^inline //' > nomatch.inline
+
+# 3. some functions have multiple instances in DWARF where one has
+# const param(s) and another does not (see errpos()).  We do not
+# mark these functions inconsistent as though they technically
+# have different prototypes, the data itself is not different.
+# Compare with "const " (and any DWARF "inline " prefix) removed;
+# keep "<noconst>\t<original>" pairs so mismatches are reported
+# with the original BTF prototype.
+sed -e 's/const //g' -e 's/^inline //' dwarf.sorted | sort -u > dwarf.noconst
+sed 's/const //g' nomatch.inline | paste - nomatch.inline | \
+	sort -t $'\t' -k1,1 > nomatch.inline.keyed
+cut -f1 nomatch.inline.keyed | sort -u | comm -23 - dwarf.noconst > nomatch.noconst
+join -t $'\t' nomatch.noconst nomatch.inline.keyed | cut -f2 > mismatches
+)
+
+exact=$(wc -l < $outdir/match.exact)
+inline=$(wc -l < $outdir/match.inline)
+const_insensitive=$(( $(wc -l < $outdir/nomatch.inline) - $(wc -l < $outdir/mismatches) ))
 
 while IFS= read -r btf ; do
-	# look for non-inline match first
-	dwarf=$(grep -F "$btf" $outdir/dwarf.funcs)
-	if [[ "$btf" != "$dwarf" ]]; then
-		# function might be declared inline in DWARF.
-		if [[ "inline $btf" != "$dwarf" ]]; then
-			# some functions have multiple instances in DWARF where one has
-			# const param(s) and another does not (see errpos()).  We do not
-			# mark these functions inconsistent as though they technically
-			# have different prototypes, the data itself is not different.
-			btf_noconst=$(echo $btf | awk '{gsub("const ",""); print $0 }')
-			dwarf_noconst=$(echo $dwarf | awk '{gsub("const ",""); print $0 }')
-			if [[ "$dwarf_noconst" =~ "$btf_noconst" ]]; then
-				const_insensitive=$((const_insensitive+1))
-			else
-				error_log "ERROR: mismatch : BTF '$btf' not found; DWARF '$dwarf'"
-				test_fail
-			fi
-		else
-			inline=$((inline+1))
-		fi
-	else
-		exact=$((exact+1))
-	fi
-done < $outdir/btf.funcs
+	# show DWARF prototypes for the same function name to aid debugging.
+	fn=$(echo "$btf" | sed -e 's/(.*//' -e 's/.*[ *]//')
+	dwarf=$(grep -F " $fn(" $outdir/dwarf.funcs; grep -F "*$fn(" $outdir/dwarf.funcs)
+	error_log "ERROR: mismatch : BTF '$btf' not found; DWARF '$dwarf'"
+	test_fail
+done < $outdir/mismatches
 
 verbose_log "Matched $exact functions exactly."
 verbose_log "Matched $inline functions with inlines."
-- 
2.56.0

