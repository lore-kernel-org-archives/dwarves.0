Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44F8212D3E
	for <dwarves@vger.kernel.org>; Tue,  8 Oct 2024 19:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728417156; cv=none; b=a6F1q0QCH3at7EBItdEdtF/cQYSWtHjXGolgcItK3xvjhBUN/Ci02DHl09V+hZ7ZeBTvhv6c/7a1eJd5nswzJMttqvWAK1DRdC7jAFCnDnlRYe4NCKNCycAsu2krj11MPw0BcYMlNvZn7gi82q5GLwpJumtHiWisChgI36ocnpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728417156; c=relaxed/simple;
	bh=hiT4j3GwrReazEZ/FPUFl6GM4vUlCwPNeQPDnkXEXGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsJw6lxSy+jfm+8/+LgoqvR4DcXCQUG0WZf58qBS6GoO0Vtc1QPv9Sh84OWT2PNxpMHBl4J7+ERuV8cS9wo+4IWOp+Mgx1U+IX3fAC3rXYFUePCAxGgnAdSXeXUE9kswd7RIT90wHY6YdCZNJB0gXCDw5HdmPI5TCkUJPGiNHGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joeYDJGf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joeYDJGf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF647C4CED0;
	Tue,  8 Oct 2024 19:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728417156;
	bh=hiT4j3GwrReazEZ/FPUFl6GM4vUlCwPNeQPDnkXEXGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=joeYDJGfUHtmDF4QUMhlhWFyI3aPVnWn9gHerlO+e3lOPKgOAnDstug5qbHzhcl2Y
	 ee7gTOAD9+qXrhjDkD2SpD8z9a8d/PoMYWHX6q/bigZ46SB2NOuCf6Ci6i3UtzIx3A
	 Oi0WCXo+bGxou4UwL8gsPTBZF9fKYYTv0sgM9uX1DvMcW7bdIZBjbDIA98WOsbfyhB
	 VJhHnnfD1ABCVyg7YyCpHrToh5k2FTrohZcs3IPyYL8d3o6j8StO0eLMl4Am8hDaFR
	 XLgzRXuc9m7/K1AMnYslrM8CV+BMXjQ4gBvn0BMUPrYki8uwFClKQ1ZLqFt7LyyLVW
	 HSg6Qv8ttFRJA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Willy Tarreau <w@1wt.eu>
Cc: dwarves@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 3/3] tests: Add a test for the accounting of flexible arrays
Date: Tue,  8 Oct 2024 16:52:09 -0300
Message-ID: <20241008195209.1094299-4-acme@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008195209.1094299-1-acme@kernel.org>
References: <20241008195209.1094299-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

  acme@x1:~/git/pahole$ tests/flexible_arrays.sh
  Flexible arrays accounting: Ok
  acme@x1:~/git/pahole$ VERBOSE=1 tests/flexible_arrays.sh
  Flexible arrays accounting: end: mem_cgroup: 2 2
  middle: mem_cgroup: 3 3
  end: pglist_data: 2 2
  middle: pglist_data: 0 0
  end: zone: 3 3
  middle: zone: 0 0
  end: cgroup: 1 1
  middle: cgroup: 0 0
  end: cgroup_root: 1 1
  middle: cgroup_root: 1 1
  end: page_counter: 2 2
  middle: page_counter: 0 0
  end: cpu_hw_events: 1 1
  middle: cpu_hw_events: 0 0
  end: crypto_shash: 1 1
  middle: crypto_shash: 0 0
  end: crypto_aead: 1 1
  middle: crypto_aead: 0 0
  end: crypto_ahash: 1 1
  middle: crypto_ahash: 0 0
  end: crypto_skcipher: 1 1
  middle: crypto_skcipher: 0 0
  end: crypto_sync_skcipher: 0 0
  middle: crypto_sync_skcipher: 1 1
  <SNIP>
  end: bpf_ctx_convert: 2 2
  middle: bpf_ctx_convert: 0 0
  Ok
  acme@x1:~/git/pahole$

Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tests/flexible_arrays.sh | 77 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100755 tests/flexible_arrays.sh

diff --git a/tests/flexible_arrays.sh b/tests/flexible_arrays.sh
new file mode 100755
index 0000000000000000..7c21253a7e08c9d3
--- /dev/null
+++ b/tests/flexible_arrays.sh
@@ -0,0 +1,77 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Match flexible array member info with the per struct final stats.
+#
+# Arnaldo Carvalho de Melo <acme@redhat.com> (C) 2024-
+
+vmlinux=${vmlinux:-$1}
+
+if [ -z "$vmlinux" ] ; then
+	vmlinux=$(pahole --running_kernel_vmlinux)
+fi
+
+if [ ! -f "$vmlinux" ] ; then
+	echo "$vmlinux file not available, please specify another"
+	exit 2
+fi
+
+pretty=$(mktemp /tmp/flexible_arrays.data.sh.XXXXXX.c)
+
+echo -n "Flexible arrays accounting: "
+
+for struct in $(pahole -F btf --sizes --with_embedded_flexible_array $vmlinux | cut -f1) ; do
+	pahole $struct > $pretty
+
+	# We need to check for just one tab before the comment as when expanding unnamed
+	# structs with members with flexible arrays inside another struct we would mess
+	# up the accounting, see 'pahole fanotify_fid_event' for instance, circa October 2024:
+	# $ pahole fanotify_fid_event
+	# struct fanotify_fid_event {
+	#	struct fanotify_event      fae;                  /*     0    48 */
+	#	__kernel_fsid_t            fsid;                 /*    48     8 */
+	#	struct {
+	#		struct fanotify_fh object_fh;            /*    56     4 */
+	#		/* XXX last struct has a flexible array */
+	#		unsigned char      _inline_fh_buf[12];   /*    60    12 */
+	#	};                                               /*    56    16 */
+
+	#	/* XXX last struct has embedded flexible array(s) */
+	#	/* size: 72, cachelines: 2, members: 3 */
+	#	/* flexible array members: middle: 1 */
+	#	/* last cacheline: 8 bytes */
+	# }
+
+	nr_flexible_arrays=$(grep $'^\t/\* XXX last struct has a flexible array' $pretty | wc -l)
+	nr_embedded_flexible_arrays=$(grep $'^\t/\* XXX last struct.*embedded flexible array' $pretty | wc -l)
+	stat_nr_flexible_arrays=$(grep "flexible array members:.*end:" $pretty | sed -r 's/.*end: *([[:digit:]]+).*/\1/g')
+	[ -z "$stat_nr_flexible_arrays" ] && stat_nr_flexible_arrays=0
+	stat_nr_embedded_flexible_arrays=$(grep "flexible array members:.*middle:" $pretty | sed -r 's/.*middle: *([[:digit:]]+).*/\1/g')
+	[ -z "$stat_nr_embedded_flexible_arrays" ] && stat_nr_embedded_flexible_arrays=0
+	test -n "$VERBOSE" && echo "end: $struct: $nr_flexible_arrays $stat_nr_flexible_arrays"
+	test -n "$VERBOSE" && echo "middle: $struct: $nr_embedded_flexible_arrays $stat_nr_embedded_flexible_arrays"
+
+	if [ "$nr_embedded_flexible_arrays" != "$stat_nr_embedded_flexible_arrays" ] ; then
+		test -n "$VERBOSE" && printf "struct %s: The number of embedded flexible arrays (%s) doesn't match the number of members marked as such (%s)\n" \
+			"$struct" "$stat_nr_embedded_flexible_arrays" "$nr_embedded_flexible_arrays"
+		test -n "$VERBOSE" && pahole $struct
+		FAILED=1
+	fi
+
+	if [ "$nr_flexible_arrays" != "$stat_nr_flexible_arrays" ] ; then
+		test -n "$VERBOSE" && printf "struct %s: The number of flexible arrays (%s) doesn't match the number of members marked as such (%s)\n" \
+			"$struct" "$stat_nr_flexible_arrays" "$nr_flexible_arrays"
+		test -n "$VERBOSE" && pahole $struct
+		FAILED=1
+	fi
+
+	rm -f $pretty
+done
+
+if [ -n "$FAILED" ] ; then
+	echo "FAILED"
+	exit 1
+fi
+
+echo "Ok"
+exit 0
-- 
2.46.0

