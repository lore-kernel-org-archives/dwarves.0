Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828052;
	b=DYmiC+WTdBKYgLtMTCaU+RpiEfKVSoh5VlvW1oEhAzPgnD1BuFy6Biy1u9e80YlPPTyg
	 sMBWde3qNAWk8i4f3LATJd17p/MMTD9XhTdAQu0a82s5gjS/tcMBzJ3Bx7AQKRJnHytyG
	 W7+Bc6dpR6Ypw2ekV4MPA5qvcd0w5xEFjDkojLAAdjV+wPo1Emb7cQ2CNOn0euYwU3aYm
	 1oLM/K88Gxx/xh+1FpesJBA3pfArM4kUOo+zAEnmrk9hUby7WAVQUv2cW1gP+H38DgIk8
	 59uEZtSWbnz+bPShWs3elCuuIQMBYVoHV/WVYl4Zygw5mVA8RxqBh0PZnCwFyLOmlKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828052;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FpgKOso31e98MSAoiX6JJTyqayDDkcuGQTmtUyVxap8=;
	b=spHuydp1JwyYjWaE4fk27akh9rr+lLWY1fRHPyF5yfBdg7rokqaLGr5oZIpyjhAAyRmP
	 b2yrstCpFUrHsx6HrTVsEJ6tKr1A2R3VCH20s0G7S+SQ22iXD647dk/l4utZtRH7e+atO
	 AbYal2ek6zeoD7b0dWV+BcpnfNshzspF2+RICbs0+U+iyvpbhuv5ttIIPq2jgxdypSaPn
	 ue3zwunCv/FfEA1H5tXEOx56y3djjtis2O+PPMCYsWacWkS5zNbyI+kuxtWUpTvqyhbqJ
	 Nr92HNPZfl9/evSvXHDvnMfzDBhqHcltEqhEfgJhERx/bC2gyPBTj9Jq7f/3qxpWmnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gF4/jPfR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74F06071031
	for <dwarves@vger.kernel.org>; Mon, 16 Nov 2026 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gF4/jPfR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89EA1F000C5;
	Mon, 16 Nov 2026 11:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828052;
	bh=FpgKOso31e98MSAoiX6JJTyqayDDkcuGQTmtUyVxap8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gF4/jPfRWKhVjL/eKRArY7yZ5Rb4C5EmuxBanxpIqGzKnMWID4mBRSkyDRXW5S0D2
	 9g5Oo4eheMcmgvicSZy1HZBodlMzi7jx7DROVYqITrWndQgVz5Mwo9+BRkHLcuFPC2
	 2FnipDMRTHE5DGh19Hse+x+xbMTEBRNtcZxSOW+0wxUbbGCYHAyYZNLx7FXF2oCRxA
	 dH5pZgx+RStq6uqpapb4Vn4PnDm5i8hxEVU0cFibnK8Xf2h06mKmEbVnZFHakEOmBG
	 paCJDj+3w1mraLM5ksi4PpdiGcsbJ55DXbm7e8XfjAGiuh9q9ZlfK/VwvpvtlZv4zQ
	 Ap/JtP2eFyJ/Q==
From: Alan Maguire <almagui@kernel.org>
To: dwarves@vger.kernel.org
Cc: Alan Maguire <almagui@kernel.org>
Subject: [PATCH dwarves 5/6] CI: Fix ondemand workflow inputs and LLVM version in function comparison
Date: Mon, 16 Nov 2026 11:20:42 +0000
Message-ID: <20261116112043.3831978-6-almagui@kernel.org>
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

The ondemand workflow calls vmtest.yml without the required "cc"
input, so manually dispatched runs fail.  Add a "cc" input (default
gcc) to ondemand.yml, pass it through, and include it in the job name.

The function comparison step in vmtest.yml referenced
inputs.llvm_version rather than inputs.llvm-version, so LLVM_VERSION
was always empty there and compare-functions.sh silently fell back to
its default of 22 whatever llvm-version the caller requested.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Alan Maguire <almagui@kernel.org>
---
 .github/workflows/ondemand.yml | 6 +++++-
 .github/workflows/vmtest.yml   | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/ondemand.yml b/.github/workflows/ondemand.yml
index 6e48e12..09e7ccb 100644
--- a/.github/workflows/ondemand.yml
+++ b/.github/workflows/ondemand.yml
@@ -18,10 +18,13 @@ on:
       runs-on:
         default: 'ubuntu-24.04'
         required: true
+      cc:
+        default: 'gcc'
+        required: true
 
 jobs:
   vmtest:
-    name: ${{ inputs.kernel }} kernel llvm-${{ inputs.llvm-version }} pahole@${{ inputs.pahole }}
+    name: ${{ inputs.kernel }} kernel ${{ inputs.cc }} llvm-${{ inputs.llvm-version }} pahole@${{ inputs.pahole }}
     uses: ./.github/workflows/vmtest.yml
     with:
       runs_on: ${{ inputs.runs-on }}
@@ -29,3 +32,4 @@ jobs:
       arch: ${{ inputs.arch }}
       llvm-version: ${{ inputs.llvm-version }}
       pahole: ${{ inputs.pahole }}
+      cc: ${{ inputs.cc }}
diff --git a/.github/workflows/vmtest.yml b/.github/workflows/vmtest.yml
index 1e876a0..0bc19d7 100644
--- a/.github/workflows/vmtest.yml
+++ b/.github/workflows/vmtest.yml
@@ -74,6 +74,6 @@ jobs:
         shell: bash
         env:
           CC: ${{ inputs.cc }}
-          LLVM_VERSION: ${{ inputs.llvm_version }}
+          LLVM_VERSION: ${{ inputs.llvm-version }}
         run: .github/scripts/compare-functions.sh
 
-- 
2.56.0

