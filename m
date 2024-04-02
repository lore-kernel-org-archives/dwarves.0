Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB9A15B962;
	Tue,  2 Apr 2024 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086826; cv=none; b=NTUw8Jf3MiC4/XQ8gmGmKDcam9AdebKMA99ij/L6nRqZFzVS4JACRm4Z70auQYMAb3T8RoJJKcF78oIaJO1bMy6xriKpx1teJf+SeRxHEDxK3d7AJRD5CTnb+6bvW0a25UE3qDG6K8Ei1at7c+tI38l4styMIJfaOwq9Gww3x/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086826; c=relaxed/simple;
	bh=w7hwgkzrUbZqiWKsRGTQDtzfq+Myzi8KNFzNsNgtgO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/Qy8f3vuGblxPdqqBuU/m53GpB4YLeCpm2+qhJ+ikujPS6hVmj5p1uXPJqJQiO1aWjc9+iTBLARKZmgU7uVWNxToAusOTjg3SeM94AO82NXsMLE3HScxkGxo1qrRdgnEuxLtz0DP4Xw+y9BmU5IaCK+uvtANujp49wMD57bfOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+KpeLBV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+KpeLBV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED66BC433A6;
	Tue,  2 Apr 2024 19:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086826;
	bh=w7hwgkzrUbZqiWKsRGTQDtzfq+Myzi8KNFzNsNgtgO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G+KpeLBVUYfQfZp1yvN1Nk7P0uOif6M+IEaHUXR+MgdUi/0XEjC3UaEnVLQyOtdsy
	 TIhXW690ZIl6y6emAjzg2LX69dXD27umnzTAF1PMFsjlgR4VgSRdhCWDCUKFYgR1te
	 7XEpVWMWnBqaBJ37CIxfz3nuSEPAQ/NnGrqRiQ5keCx7sP+ROozwtFIuqKf2FWZ3y5
	 XePv0iUKfzQ3qONEEEi8jXD1G4HR45oi84r3t7ecTPdTUj7+6ie8MIht/yRSqtrwGY
	 O3IHZSQPjucBJgLfUA44OlJNrNkfD5x0Q0ahM3RcyPTjygwT6Y0lhVA3p2ILIgsRAl
	 Ih4O7R9qK09tA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: dwarves@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Kui-Feng Lee <kuifeng@fb.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 12/12] tests: Add a BTF reproducible generation test
Date: Tue,  2 Apr 2024 16:39:45 -0300
Message-ID: <20240402193945.17327-13-acme@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402193945.17327-1-acme@kernel.org>
References: <20240402193945.17327-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

  $ time tests/reproducible_build.sh vmlinux
  Parallel reproducible DWARF Loading/Serial BTF encoding: Ok

  real  1m13.844s
  user  3m3.601s
  sys   0m9.049s
  $

If the number of threads started by pahole is different than what was
requests via its -j command line option, it will fail as well as if the
output of 'bpftool btf dump' differs from the BTF encoded totally
serially to one of the detached BTF encoded using reproducible DWARF
loading/BTF encoding.

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Kui-Feng Lee <kuifeng@fb.com>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tests/reproducible_build.sh | 56 +++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100755 tests/reproducible_build.sh

diff --git a/tests/reproducible_build.sh b/tests/reproducible_build.sh
new file mode 100755
index 0000000000000000..9c72d548c2a21136
--- /dev/null
+++ b/tests/reproducible_build.sh
@@ -0,0 +1,56 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Test if BTF generated serially matches reproducible parallel DWARF loading + serial BTF encoding
+# Arnaldo Carvalho de Melo <acme@redhat.com> (C) 2024-
+
+vmlinux=$1
+outdir=$(mktemp -d /tmp/reproducible_build.sh.XXXXXX)
+
+echo -n "Parallel reproducible DWARF Loading/Serial BTF encoding: "
+
+test -n "$VERBOSE" && printf "\nserial encoding...\n"
+
+pahole --btf_encode_detached=$outdir/vmlinux.btf.serial $vmlinux
+bpftool btf dump file $outdir/vmlinux.btf.serial > $outdir/bpftool.output.vmlinux.btf.serial
+
+nr_proc=$(getconf _NPROCESSORS_ONLN)
+
+for threads in $(seq $nr_proc) ; do
+	test -n "$VERBOSE" && echo $threads threads encoding
+	pahole -j$threads --reproducible_build --btf_encode_detached=$outdir/vmlinux.btf.parallel.reproducible $vmlinux &
+	pahole=$!
+	# HACK: Wait a bit for pahole to start its threads
+	sleep 0.3s
+	# PID part to remove ps output headers
+	nr_threads_started=$(ps -L -C pahole | grep -v PID | wc -l)
+
+	if [ $threads -gt 1 ] ; then
+		((nr_threads_started -= 1))
+	fi
+
+	if [ $threads != $nr_threads_started ] ; then
+		echo "ERROR: pahole asked to start $threads encoding threads, started $nr_threads_started"
+		exit 1;
+	fi
+
+	# ps -L -C pahole | grep -v PID | nl
+	test -n "$VERBOSE" && echo $nr_threads_started threads started
+	wait $pahole
+	rm -f $outdir/bpftool.output.vmlinux.btf.parallel.reproducible
+	bpftool btf dump file $outdir/vmlinux.btf.parallel.reproducible > $outdir/bpftool.output.vmlinux.btf.parallel.reproducible
+	test -n "$VERBOSE" && echo "diff from serial encoding:"
+	diff -u $outdir/bpftool.output.vmlinux.btf.serial $outdir/bpftool.output.vmlinux.btf.parallel.reproducible > $outdir/diff
+	if [ -s $outdir/diff ] ; then
+		echo "ERROR: BTF generated from DWARF in parallel is different from the one generated in serial!"
+		exit 1
+	fi
+	test -n "$VERBOSE" && echo -----------------------------
+done
+
+rm $outdir/*
+rmdir $outdir
+
+echo "Ok"
+
+exit 0
-- 
2.44.0

