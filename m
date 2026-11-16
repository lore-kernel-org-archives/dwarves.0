Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828047;
	b=EaF+S0dLsEx2ormksJh3qUH8FSAljqQpLQWOBKA7W/1vbMp8YOl/bLBSahpQeLd5XGdP
	 c95S5pgZ1VoBd+p5UqWzxXMUNPCjqeZgawh0AZ08AwvuUYSFdHtBHRwWtzqKgfZcpJPGe
	 PRubx4HmNyicFxCYI+lwN6Ly/fvb9vpqoFZATItmSGyddd2eFQdcvBxBAoM1PIEiWslTx
	 uaoTYpRdtdQFIf0gSRWk+MnzqTUwfKdqGOONryO7TSy1jdpjDshyq3A4dSn3LlavcZwPM
	 DxkgUzk80iKVygAPo5aCOGBU04LZUCXLEDL1aZ97iGLhPA0Wo1/xiU9C1zqnbyKctjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828047;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iGt/4VL8BxwRYi9GlaHtjq7wR3Syx6e0Xsd7AzW71kM=;
	b=4lXY+in57CGu8hAa1b0xgfPf7U16vMtmZyzAUhQ/yppu8keC1h8s3clOelX8Hq6riXOf
	 c/uc0rhEiChwhQuA5jCNLlxDoE3H7cdNrTEDCOP4vd7Mut0VqG4O2eokLVgvbVAzDEjXh
	 suudH6E0k+M2jvjZXMu0lFUSeHKgZKqkkYTuDlqz5sXVfoQslWTEQaOpFNjU/4669nr+0
	 V1fNMTuku59slQyRrpYtYcOHygVeOviYcLY3jEVdWEFba167qp9e024e1uVdi6K+LEO98
	 TON8K+O6PfPOdUBbXYxl5thAssiIbHzTlZYCHm19HbVL6yiX3M0Gb+sy0OqmL80Imjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJOKqt7L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB416071800
	for <dwarves@vger.kernel.org>; Mon, 16 Nov 2026 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJOKqt7L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64DB1F000C4;
	Mon, 16 Nov 2026 11:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828046;
	bh=iGt/4VL8BxwRYi9GlaHtjq7wR3Syx6e0Xsd7AzW71kM=;
	h=From:To:Cc:Subject:Date;
	b=UJOKqt7LPDsUYWvRSzriZnqAU1jRLU7CXN6a4RYsHY0N8qQTepiA/CaOFWrq43bg6
	 oNSG2Bx2EpDdggZjDjiwawnY/xjKfEIFyXtSXsL4TBpD7i0JYway8yE1WAAk4Oxl/6
	 n6hhRXOKULY7MSXzQ2bHYTV2rM5fw4aAyRe78k50dSoFKOSr1UE1Y8cNBvObjOuKBH
	 4HRcQmUpNxt60k94NycPT0ReQWc8rUxNxvFr8BxICzsCuSkN/U0PyzcSlJ6Mvc5Rxj
	 n/IrnD+rTwSeev2MpEpfvmGBYO4MNggP0lfIixCBoxI12fTSFsj74392t/kRxTL/ql
	 RKwH9c0yy05qw==
From: Alan Maguire <almagui@kernel.org>
To: dwarves@vger.kernel.org
Cc: Alan Maguire <almagui@kernel.org>
Subject: [PATCH dwarves 0/6] Add support for LTO kernel builds, other CI fixes
Date: Mon, 16 Nov 2026 11:20:37 +0000
Message-ID: <20261116112043.3831978-1-almagui@kernel.org>
X-Mailer: git-send-email 2.56.0
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

CI has been flaky lately, git.kernel.org clones in particular.
Provide fallback locations for cloning and retry (patch 1).

When testing with LTO kernels, function comparisons between
DWARF/BTF take a long time; use more efficient methods (patch 2).

Fix a few other issues in CI (patches 3, 4).

Finally add ThinLTO kernel build support (patch 5).

Results of this series on top of pahole's next branch at [1];
all pass.

[1] https://github.com/alan-maguire/dwarves/actions/runs/43849750600

Alan Maguire (6):
  CI: Make kernel source fetch tolerant of git host failures
  tests: Match BTF and DWARF functions with set operations in
    btf_functions.sh
  CI: Scope workflow concurrency groups to the branch for push runs
  tests: Expect no DWARF loader threads in reproducible_build.sh when
    CUs are merged
  CI: Fix ondemand workflow inputs and LLVM version in function
    comparison
  CI: Add clang ThinLTO kernel build to test matrix

 .github/scripts/build-kernel.sh      | 34 +++++++++++--
 .github/scripts/get-kernel-source.sh | 46 ++++++++++++++++++
 .github/scripts/run-selftests.sh     |  2 +-
 .github/workflows/build.yml          |  2 +-
 .github/workflows/ondemand.yml       | 11 ++++-
 .github/workflows/test.yml           | 10 +++-
 .github/workflows/vmtest.yml         | 20 +++++---
 tests/btf_functions.sh               | 71 +++++++++++++++++-----------
 tests/reproducible_build.sh          | 17 ++++++-
 tests/test_lib.sh                    | 36 ++++++++++++++
 10 files changed, 207 insertions(+), 42 deletions(-)
 create mode 100755 .github/scripts/get-kernel-source.sh

-- 
2.56.0

