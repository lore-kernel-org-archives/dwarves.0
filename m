Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828048;
	b=DMsFybs08Iw6OB8mvtPw5ZYVejlginqp33+I6ugkwmiynxn048pV3ntUF2kZ1uHfuwrQ
	 p+OWS3uOMsoSB/jlRHPUJqg9iKMMeXB8tCgURFzeRLMjoY3T+b9jU94ki7h8FLtmx9Lp0
	 9zygQz4MPZqLqQSGTwG7JEI7hlrGNkOR/nr4P+eI8DbRzZZhdU6ALXZrSgMXt3BNGiLnG
	 +sWkxbs6tiaU1uDuX/B8pNH8W85FxbX8YzxKmwkmXn1J03XjxIrRm6vr79zINZ130Xica
	 zNfGO/j8MVIb0JFDnw4eJDu0evJMGeWbrrmRgJ1fNGnvozh/iPHFliar1qphW+0rPGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828048;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=S9k/F8CcYPJtQHjFanoh8czitovaeGZPHvmh58Hifp0=;
	b=aOFHA9XPVLD7Rj3Jh+I5/xhfjYh0j+48N8BgVorWYuOJAUBieBKTFdfd7c0qqOcKjJGT
	 Y3qeWMpvEedvxKh4lXhxHxrdNLV30TgQvhYu9y9BVeqlvNGnfCIV4ds3y3j1LNkDdDDTU
	 cm0xIiWffQi3HFfBabrdrdRV+HwS5Hldg53Tg4Ni3CyVjjNjZNKFfZdfo9VPFuP9Ax3mW
	 jnF7U5S3b7GGo0+TDJw4a7KJ4pX15ReWpvFF3HmBT0G4nq8MhoYD64S1EhgEcBa39QoWb
	 jAFR1ZjgS+xAVRheXpLv61je9FMPY4+Y3W3PV/E/hCQXXKMGvqX+W17j0EkGPPwtmLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XYHyzjx3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A0C607180E
	for <dwarves@vger.kernel.org>; Mon, 16 Nov 2026 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XYHyzjx3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFF11F000C4;
	Mon, 16 Nov 2026 11:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828047;
	bh=S9k/F8CcYPJtQHjFanoh8czitovaeGZPHvmh58Hifp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XYHyzjx30YWHLcZGoLxEm6gIlXs4lo2+0ulqWg7nX5PQh16Et49kxbiNNmlPE7AtP
	 T719RG+p4qDVR5JXPAFeXGBLRjF5+0K7IFL95RYuPmOOmo+w4IoKGNENQZMDgtKg0B
	 4JEOPHhtnIe78EQY/dvg7lMP8MigpIBzqkjLJgMQPfWC/4EyF0oAa99dTPhBsb50gd
	 nMfOFbgDQPe+vTtXC8SnVeTduSX6sgUEqs8K/iXLsKP4BaIVzfFUkBhSUb1cTCE4Uf
	 OPJCudLBBLAWbTTB2LamZO6k8GGN0Uqo4wRT4FGavh4y2M+3buWvy2mXQqWfUvvDlJ
	 De3hw1jOJOzeg==
From: Alan Maguire <almagui@kernel.org>
To: dwarves@vger.kernel.org
Cc: Alan Maguire <almagui@kernel.org>
Subject: [PATCH dwarves 1/6] CI: Make kernel source fetch tolerant of git host failures
Date: Mon, 16 Nov 2026 11:20:38 +0000
Message-ID: <20261116112043.3831978-2-almagui@kernel.org>
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

CI jobs have been failing with timeouts fetching bpf-next from
git.kernel.org.  Replace the libbpf/ci/get-linux-source action with
a script that does a shallow fetch, retrying across mirrors:

1. git.kernel.org bpf-next master
2. github.com/kernel-patches/bpf bpf-next_base (github-to-github;
   bpf-next plus BPF CI commits)
3. kernel.googlesource.com bpf-next master

with up to 3 rounds and backoff between them.  Each fetch attempt is
bounded by a timeout, and git's low-speed limits abort stalled
transfers so we move on to the next mirror rather than hanging until
the job times out.  The commit fetched is logged.

Since the source is now a detached shallow checkout, build-kernel.sh
no longer checks out REPO_BRANCH; its fallback clone (for local use)
is now a shallow clone of that branch.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Alan Maguire <almagui@kernel.org>
---
 .github/scripts/build-kernel.sh      |  4 +--
 .github/scripts/get-kernel-source.sh | 46 ++++++++++++++++++++++++++++
 .github/workflows/vmtest.yml         |  7 ++---
 3 files changed, 51 insertions(+), 6 deletions(-)
 create mode 100755 .github/scripts/get-kernel-source.sh

diff --git a/.github/scripts/build-kernel.sh b/.github/scripts/build-kernel.sh
index 63806f2..8326e1d 100755
--- a/.github/scripts/build-kernel.sh
+++ b/.github/scripts/build-kernel.sh
@@ -18,11 +18,11 @@ export PAHOLE=${GITHUB_WORKSPACE}/install/usr/local/bin/pahole
 which pahole
 $PAHOLE --version
 
+# In CI, get-kernel-source.sh has already fetched the source.
 if [[ ! -d $REPO_TARGET ]]; then
-	git clone $REPO $REPO_TARGET
+	git clone --depth=1 --branch $REPO_BRANCH $REPO $REPO_TARGET
 fi
 cd $REPO_TARGET
-git checkout $REPO_BRANCH
 
 buildopts=
 if [[ "$CC" = "clang" ]]; then
diff --git a/.github/scripts/get-kernel-source.sh b/.github/scripts/get-kernel-source.sh
new file mode 100755
index 0000000..2d28215
--- /dev/null
+++ b/.github/scripts/get-kernel-source.sh
@@ -0,0 +1,46 @@
+#!/usr/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Fetch bpf-next kernel source, tolerating failures/stalls of any
+# single git host by retrying across mirrors.
+#
+
+GITHUB_WORKSPACE=${GITHUB_WORKSPACE:-$(dirname $0)/../..}
+DEST=${GITHUB_WORKSPACE}/.kernel
+FETCH_TIMEOUT=${FETCH_TIMEOUT:-15m}
+ATTEMPTS=${ATTEMPTS:-3}
+
+# "URL REF" pairs, tried in order.  kernel-patches/bpf bpf-next_base tracks
+# bpf-next master plus BPF CI commits, and is github-to-github so is the
+# first fallback.
+MIRRORS=(
+	"https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master"
+	"https://github.com/kernel-patches/bpf.git bpf-next_base"
+	"https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git master"
+)
+
+git init -q "$DEST" && cd "$DEST" || exit 1
+# Abort stalled transfers (< 1KB/s for 60s) rather than hanging until
+# the job times out, so we move on to the next mirror.
+git config http.lowSpeedLimit 1000
+git config http.lowSpeedTime 60
+
+for attempt in $(seq 1 $ATTEMPTS); do
+	for mirror in "${MIRRORS[@]}"; do
+		read -r url ref <<< "$mirror"
+		echo "Fetching $ref from $url (attempt $attempt/$ATTEMPTS)"
+		if timeout $FETCH_TIMEOUT git fetch --depth=1 "$url" "$ref"; then
+			git checkout -q FETCH_HEAD
+			echo "Fetched kernel source from $url $ref:"
+			git log -1 --oneline
+			exit 0
+		fi
+		echo "Fetch from $url failed"
+	done
+	if [[ $attempt -lt $ATTEMPTS ]]; then
+		sleep $((attempt * 30))
+	fi
+done
+
+echo "Failed to fetch kernel source from all mirrors" >&2
+exit 1
diff --git a/.github/workflows/vmtest.yml b/.github/workflows/vmtest.yml
index d6f9f79..1e876a0 100644
--- a/.github/workflows/vmtest.yml
+++ b/.github/workflows/vmtest.yml
@@ -55,10 +55,9 @@ jobs:
         run: .github/scripts/build-pahole.sh
 
       - name: Get kernel source
-        uses: libbpf/ci/get-linux-source@v3
-        with:
-          repo: 'https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git'
-          dest: '${{ github.workspace }}/.kernel'
+        shell: bash
+        timeout-minutes: 60
+        run: .github/scripts/get-kernel-source.sh
 
       - name: Configure, build kernel with current pahole
         shell: bash
-- 
2.56.0

