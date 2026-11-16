Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828051;
	b=mTWg18/XvuJ51TieSm7ENFt4WX8UqQcDNiYt+R15Ah4n7IpkupvqFUyuxt9amteTRdy5
	 usbcALGL+nQWHDDY5ydDXWGNEElgkBRPw77RD8z05K7unQZhWnKD1KAfP5dKa8Hk3IorH
	 UcbWYEXDsopjBOgS5JGkyIMEk/1STJY8/kimMr/APRB2Pd0YLODqzIhdBpEzboebGfIUP
	 +zReWZFAmNldmqEwm+5e/NiD61Ie/4FdQHpICFr38RJzEa1SErjW9Z+hiXTPkTuNSyFvh
	 lstV8FiYVdmsGy33DxiugK+TLN74wM1B1HovZg5wef4UGxIU2cSFg7JuEluE+Z/vigA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828051;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wDPBwH6GKXkzT/LOLB5xKatvq4IlZmf9D7ptPScwE58=;
	b=qnZwN3ZIls/PfVp5CYcFrizt9ScGkfDDt0/Q0D5pdP68VXEn+ZfOdx1F7m91/rxgfuJ+
	 IgisUhVx8dGj3YWxqteQqFzzrT9Ey3ZhMWDj2pZ05/ODsx3VZGrYuif4DzB0/hj+7SFPJ
	 toj+RlYlf7XIl9jfXpMSAqqo8mm+kqZwwUT/6YqrmQ6QdngRA1jus6fgPyhFOKBsz1Q+K
	 OXUov6UvMJskIkutcDfyoyDnsMqp5UeymAgV0t31DfRVXGmvgpMIs6LpEKTU1It3zlydq
	 mKr0mXp0JFpeG5LSKCHkLlaRpabBdn0vKW5/4jeVI5dv2R2PxmhE8WL5ECp6W5qza9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f70fdeLl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730EC6071031
	for <dwarves@vger.kernel.org>; Mon, 16 Nov 2026 11:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f70fdeLl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9575A1F000D2;
	Mon, 16 Nov 2026 11:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828051;
	bh=wDPBwH6GKXkzT/LOLB5xKatvq4IlZmf9D7ptPScwE58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f70fdeLlCirTgTro9Rm4DQ/D+RujXqgTrTNKkB4Y7brZXZ7IL7J08llQIcc4ZA8xg
	 XXWo/yavAPMOPUEO/PpjcksnJaG5seUj27hvMsiopxLGfrCkcSxldyjpl8lkSJx8BG
	 mbsNB8RWq/p4dT765fugVis/2mUW1tFAsQUPRnBQvYAup4wrH1jOCzY3mp42g11K/v
	 X5aSURMAzKt318QKx2R7yDGHtEEzU3M0M4yDB0DbHddvtU39V3Qp7ZHPQKOVV1w7uJ
	 P3BFwT/OGwj3qD8sgz+n723Ip6LlULQBlaBuam6YQRduiEeY3Znycc34DONOAT/0sO
	 8dLL/i30gYjhA==
From: Alan Maguire <almagui@kernel.org>
To: dwarves@vger.kernel.org
Cc: Alan Maguire <almagui@kernel.org>
Subject: [PATCH dwarves 4/6] tests: Expect no DWARF loader threads in reproducible_build.sh when CUs are merged
Date: Mon, 16 Nov 2026 11:20:41 +0000
Message-ID: <20261116112043.3831978-5-almagui@kernel.org>
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

reproducible_build.sh checks that "pahole -jN" starts N threads.  When
pahole merges all CUs into one, as it does for LTO kernels, DWARF is
loaded serially and no worker threads are started, so the test fails
on a clang ThinLTO vmlinux, as seen in the CI clang-lto-thin x86_64
job:

  ERROR: pahole asked to start 1 encoding threads, started 0

Add a dwarf_cus_merged() helper to test_lib.sh mirroring
cus__merging_cu(): the kernel's LINUX_ELFNOTE_LTO_INFO note is set, or
the DWARF uses DW_FORM_ref_addr.  When CUs are merged, expect zero
worker threads; the serial vs parallel BTF comparison is still done.

The helper walks the .notes section itself using the 4-byte layout of
the kernel's ELFNOTE() notes rather than relying on readelf -n.  On
kernels whose linker script does not discard .note.gnu.property (it is
discarded since kernel commit f7ba52f302fd ("vmlinux.lds.h: Discard
.note.gnu.property section")), .notes picks up the 8-byte alignment of
that section and readelf -n misparses the 4-byte aligned notes.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Alan Maguire <almagui@kernel.org>
---
 tests/reproducible_build.sh | 17 +++++++++++++++--
 tests/test_lib.sh           | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/tests/reproducible_build.sh b/tests/reproducible_build.sh
index 532b320..8b7b8eb 100755
--- a/tests/reproducible_build.sh
+++ b/tests/reproducible_build.sh
@@ -27,6 +27,16 @@ export PAHOLE_LANG_EXCLUDE=rust
 pahole --btf_features=default --btf_encode_detached=$outdir/vmlinux.btf.serial $vmlinux
 bpftool btf dump file $outdir/vmlinux.btf.serial > $outdir/bpftool.output.vmlinux.btf.serial
 
+# When CUs are merged (e.g. LTO kernels) pahole loads DWARF serially and
+# starts no loader threads whatever -j says; the encoding must still be
+# reproducible.
+if dwarf_cus_merged $vmlinux ; then
+	verbose_log "CUs are merged (LTO?); DWARF loading is serial, expecting no worker threads"
+	merged_cus=1
+else
+	merged_cus=0
+fi
+
 nr_proc=$(getconf _NPROCESSORS_ONLN)
 # Clamp to 1 so single-core machines don't produce -j0
 half_proc=$(( nr_proc / 2 > 0 ? nr_proc / 2 : 1 ))
@@ -43,8 +53,11 @@ for threads in $thread_list ; do
 	nr_threads_started=$(ls /proc/$pahole/task 2>/dev/null | wc -l)
 	nr_threads_started=$((nr_threads_started - 1)) # subtract main thread
 
-	if [ $threads != $nr_threads_started ] ; then
-		error_log "ERROR: pahole asked to start $threads encoding threads, started $nr_threads_started"
+	expected_threads=$threads
+	[ $merged_cus = 1 ] && expected_threads=0
+
+	if [ $expected_threads != $nr_threads_started ] ; then
+		error_log "ERROR: pahole asked to start $threads encoding threads, expected $expected_threads, started $nr_threads_started"
 		test_fail
 	fi
 
diff --git a/tests/test_lib.sh b/tests/test_lib.sh
index e2d0b0c..bd3784e 100755
--- a/tests/test_lib.sh
+++ b/tests/test_lib.sh
@@ -464,6 +464,42 @@ get_perf_with_debug()
 	fi
 }
 
+# Return success if pahole's DWARF loader will merge all CUs of $1 into
+# one and load them serially rather than with -j worker threads.  This
+# mirrors cus__merging_cu() in dwarf_loader.c: the kernel's
+# LINUX_ELFNOTE_LTO_INFO note says it was built with LTO, or the DWARF
+# uses DW_FORM_ref_addr (references across CUs, as with clang LTO).
+#
+# readelf -n gives up on the kernel's .notes section (4-byte aligned
+# notes in an 8-byte aligned section), so walk the notes directly.
+dwarf_cus_merged()
+{
+	local obj=$1 notes
+
+	notes=$(mktemp)
+	if objcopy -O binary --only-section=.notes "$obj" "$notes" 2>/dev/null &&
+	   od -An -v -tu4 -w4 "$notes" | awk '
+		# namesz, descsz, type, name (padded to 4), desc (padded to 4)
+		{ w[n++] = $1 }
+		END {
+			for (i = 0; i + 3 <= n; ) {
+				namesz = w[i]; descsz = w[i+1]; type = w[i+2]
+				i += 3 + int((namesz + 3) / 4)
+				# LINUX_ELFNOTE_LTO_INFO, owner "Linux"
+				if (type == 257 && namesz == 6 && descsz == 4 && w[i] != 0)
+					exit 0
+				i += int((descsz + 3) / 4)
+			}
+			exit 1
+		}'; then
+		rm -f "$notes"
+		return 0
+	fi
+	rm -f "$notes"
+
+	readelf --debug-dump=abbrev "$obj" 2>/dev/null | grep -q DW_FORM_ref_addr
+}
+
 make_tmpdir()
 {
 	# Ensure master test directory exists
-- 
2.56.0

