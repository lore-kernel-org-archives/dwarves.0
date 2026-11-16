Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828053;
	b=OR/a8HuRBQOeLtB8zz4P3p0+2283Q8Yxyp1h0dIUOoQvWAQL7W2QBByS0+Njf3Adn8K/
	 MQJpunIsIHlQpurQhunAHnHo6cvSuNMylTPD2M1Vjddj99KlI+b2pa++JpRPfZAK/dYXY
	 JeN9oNU4ln26MzJiDsd77XEhFdLLVAruNt5Ooa7c4N815ITNSw0scLrpF/UYf9Qn8UQvb
	 3JjWoUFXLVCeuN9Mda5oQvXT8Yd8MfF+O1ttZOYpOU+NIbppDwzCv9GC4NFPfMnaJTaID
	 zsaBxa99EfyNxJhbb0q7/BaPqe4d2WMp3wX5e9EViAzsmADqbMIefsoUviQLinzJSRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828053;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9/x4qLyRFLUZHfm3nwx39SiMSab4WxnLxghGr2e2KQI=;
	b=kaNZwi6d4EmutpEuLdtLps+ASWn4CLQgmyxWU86UDguZy56Sh/4QUGrt1y7FecbFof/3
	 L4GGc4PQrxMYnKIc/ENXo7qgHkbcPdhgVAbvtvTZiKifIPYCOptno/TWtZ4WXjc+bzA+7
	 2JWBaepjslh4hDKm3FYMl8lfNSCN2mehbf/uxsn+rP5kBEi/StDc5BeF47sHIYiVQDcTd
	 vy9yh5Tsi80MmSi8gG5k6vgNJ4fYhpQCbz++7IoFQAF0rxiDG10wkyadwf55kmjEHEzud
	 Rw7yEvauLOno561u4leDD4iHBuraR/k1HNzrIYs9oCXi19zuXSy9FEmXLjAGf/VV1Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JE8xgU7M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82D2607182C
	for <dwarves@vger.kernel.org>; Mon, 16 Nov 2026 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JE8xgU7M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D471F000C4;
	Mon, 16 Nov 2026 11:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828053;
	bh=9/x4qLyRFLUZHfm3nwx39SiMSab4WxnLxghGr2e2KQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JE8xgU7MleXNEM6mNFHmzujEH9LmK1rRtRE04RFHw7y+mOn92mZc3gqrYOJWTGWnz
	 gkzZ+94jH7stb3nwRF7wAJeBRG1n0HkJiIGm679VdR40/trv5pabUH7765AtQ58Jjm
	 CtC/QUFx0QaPn2gcos2GWG8HGWP2KNLOpMR0iFmiVJrwHOw2cdW31acFvqSldz9QjO
	 R9OOqZp2vO+MtnKNbypCLYMxqIHu4+Fz48/ESDyAqJtwZZuyhvr1KB12VA8GgQis02
	 6m2FFTaR+cNyIB7z/yBjEuoae+eqbSHrsNcCcQ2SgcOMON3eorYxllYDBHDeC8JIMQ
	 wWQjMFlmPAnng==
From: Alan Maguire <almagui@kernel.org>
To: dwarves@vger.kernel.org
Cc: Alan Maguire <almagui@kernel.org>
Subject: [PATCH dwarves 6/6] CI: Add clang ThinLTO kernel build to test matrix
Date: Mon, 16 Nov 2026 11:20:43 +0000
Message-ID: <20261116112043.3831978-7-almagui@kernel.org>
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

LTO kernels are an important case for BTF generation: cross-CU
inlining and function merging change what pahole sees in DWARF and
the ELF symbol table.  Add an x86_64 clang job that builds the kernel
with CONFIG_LTO_CLANG_THIN=y.

vmtest.yml gets an optional "lto" input (default "none") that is
passed to build-kernel.sh, which enables LTO_CLANG_THIN via
scripts/config.  Since olddefconfig silently falls back to LTO_NONE
when a dependency is unmet (e.g. KASAN, GCOV), fail the build if
ThinLTO did not end up enabled rather than quietly testing a non-LTO
kernel.  The function comparison step reuses the existing .config, so
the baseline build is LTO too.  The ondemand workflow gets a matching
"lto" input.

The tests runner starts all tests in parallel by default.  Several of
them load the full vmlinux with pahole/pfunct, and on a ThinLTO kernel
running them concurrently can exhaust the runner's memory.  Have
run-selftests.sh pass -j $SELFTEST_JOBS to the tests runner when set,
and set it to 2 for LTO jobs in vmtest.yml.  Non-LTO jobs keep running
all tests in parallel.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Alan Maguire <almagui@kernel.org>
---
 .github/scripts/build-kernel.sh  | 30 +++++++++++++++++++++++++++++-
 .github/scripts/run-selftests.sh |  2 +-
 .github/workflows/ondemand.yml   |  7 ++++++-
 .github/workflows/test.yml       |  8 ++++++++
 .github/workflows/vmtest.yml     | 11 ++++++++++-
 5 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/.github/scripts/build-kernel.sh b/.github/scripts/build-kernel.sh
index 8326e1d..18a6f47 100755
--- a/.github/scripts/build-kernel.sh
+++ b/.github/scripts/build-kernel.sh
@@ -11,6 +11,7 @@ REPO_BRANCH=${REPO_BRANCH:-master}
 REPO_TARGET=${GITHUB_WORKSPACE}/.kernel
 CC=${CC:-gcc}
 LLVM_VERSION=${LLVM_VERSION:-22}
+LTO=${LTO:-none}
 
 export PATH=${GITHUB_WORKSPACE}/install/usr/local/bin:${PATH}
 export PAHOLE=${GITHUB_WORKSPACE}/install/usr/local/bin/pahole
@@ -36,7 +37,34 @@ cat tools/testing/selftests/bpf/config \
 if [[ -f tools/testing/selftests/bpf/config.vm ]]; then
 	cat tools/testing/selftests/bpf/config.vm >> .config
 fi
-make $buildopts olddefconfig && make prepare
+make $buildopts olddefconfig
+
+case "$LTO" in
+none)
+	;;
+thin)
+	if [[ "$CC" != "clang" ]]; then
+		echo "LTO=thin requires CC=clang" >&2
+		exit 1
+	fi
+	echo "Enabling Clang ThinLTO"
+	scripts/config -d LTO_NONE -e LTO_CLANG_THIN
+	make $buildopts olddefconfig
+	# olddefconfig silently falls back to LTO_NONE if a dependency
+	# is not met (e.g. KASAN, GCOV); fail rather than test non-LTO.
+	if ! grep -q '^CONFIG_LTO_CLANG_THIN=y' .config; then
+		echo "CONFIG_LTO_CLANG_THIN could not be enabled:" >&2
+		grep -E 'LTO|HAS_LTO' .config >&2
+		exit 1
+	fi
+	;;
+*)
+	echo "Unsupported LTO mode '$LTO'" >&2
+	exit 1
+	;;
+esac
+
+make $buildopts prepare
 cat .config
 make -j $((4*$(nproc))) $buildopts all
 
diff --git a/.github/scripts/run-selftests.sh b/.github/scripts/run-selftests.sh
index bb826bf..748c4b9 100755
--- a/.github/scripts/run-selftests.sh
+++ b/.github/scripts/run-selftests.sh
@@ -13,5 +13,5 @@ export LLVM_OBJCOPY=objcopy
 which pahole
 pahole --version
 bpftool --version
-vmlinux=$VMLINUX ./tests
+vmlinux=$VMLINUX ./tests ${SELFTEST_JOBS:+-j $SELFTEST_JOBS}
 
diff --git a/.github/workflows/ondemand.yml b/.github/workflows/ondemand.yml
index 09e7ccb..d9f8617 100644
--- a/.github/workflows/ondemand.yml
+++ b/.github/workflows/ondemand.yml
@@ -21,10 +21,14 @@ on:
       cc:
         default: 'gcc'
         required: true
+      lto:
+        description: 'kernel LTO mode (none or thin; thin requires cc=clang)'
+        default: 'none'
+        required: true
 
 jobs:
   vmtest:
-    name: ${{ inputs.kernel }} kernel ${{ inputs.cc }} llvm-${{ inputs.llvm-version }} pahole@${{ inputs.pahole }}
+    name: ${{ inputs.kernel }} kernel ${{ inputs.cc }} lto-${{ inputs.lto }} llvm-${{ inputs.llvm-version }} pahole@${{ inputs.pahole }}
     uses: ./.github/workflows/vmtest.yml
     with:
       runs_on: ${{ inputs.runs-on }}
@@ -33,3 +37,4 @@ jobs:
       llvm-version: ${{ inputs.llvm-version }}
       pahole: ${{ inputs.pahole }}
       cc: ${{ inputs.cc }}
+      lto: ${{ inputs.lto }}
diff --git a/.github/workflows/test.yml b/.github/workflows/test.yml
index 8bff4e4..8bc3897 100644
--- a/.github/workflows/test.yml
+++ b/.github/workflows/test.yml
@@ -28,6 +28,13 @@ jobs:
             llvm-version: '22'
             pahole: 'none'
             cc: 'clang'
+          - kernel: 'LATEST'
+            runs_on: 'ubuntu-24.04'
+            arch: 'x86_64'
+            llvm-version: '22'
+            pahole: 'none'
+            cc: 'clang'
+            lto: 'thin'
           - kernel: 'LATEST'
             runs_on: 'ubuntu-24.04-arm'
             arch: 'aarch64'
@@ -49,3 +56,4 @@ jobs:
       llvm-version: ${{ matrix.llvm-version }}
       pahole: ${{ matrix.pahole }}
       cc: ${{ matrix.cc }}
+      lto: ${{ matrix.lto || 'none' }}
diff --git a/.github/workflows/vmtest.yml b/.github/workflows/vmtest.yml
index 0bc19d7..7010205 100644
--- a/.github/workflows/vmtest.yml
+++ b/.github/workflows/vmtest.yml
@@ -31,10 +31,15 @@ on:
         description: 'compiler'
         required: true
         type: string
+      lto:
+        description: 'kernel LTO mode (none or thin; thin requires clang)'
+        required: false
+        default: 'none'
+        type: string
 
 jobs:
   vmtest:
-    name: pahole-${{ inputs.cc }}@${{ inputs.arch }}
+    name: pahole-${{ inputs.cc }}${{ inputs.lto != 'none' && format('-lto-{0}', inputs.lto) || '' }}@${{ inputs.arch }}
     runs-on: ${{ inputs.runs_on }}
     steps:
 
@@ -64,10 +69,14 @@ jobs:
         env:
           CC: ${{ inputs.cc }}
           LLVM_VERSION: ${{ inputs.llvm-version }}
+          LTO: ${{ inputs.lto }}
         run: .github/scripts/build-kernel.sh
 
       - name: Run selftests
         shell: bash
+        env:
+          # ThinLTO vmlinux is large; limit how many tests load it at once.
+          SELFTEST_JOBS: ${{ inputs.lto != 'none' && '2' || '' }}
         run: .github/scripts/run-selftests.sh
 
       - name: Compare functions generated
-- 
2.56.0

