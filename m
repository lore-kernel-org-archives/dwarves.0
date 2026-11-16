Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828050;
	b=IKyYWeA3wLpfHYS9hoctjX9YMphQGW3ZD9NEJ9Jw9HQpQedqdzOM8h9lR2J6jDVmE9OJ
	 cybRG5klyPiA/aQ7Y5Hn6K6R5mJXOLdsyIwHbKA2QRvreh4IjYW0z/UfUR23WwSc2DyDW
	 qKmDjbKQAVWWfcG/JFwoJwat6ud0jrJz2WSa34rmKpDFi+T6cVVx5OtaZGurfdPMdVctJ
	 aRnyTPtTzXXdVZjLDr5lKm287ixU0pUSxKZvpl4IZ2lkKU4HnWBlNXb5MF8UbXZqP7mn4
	 js88l26HIqIBIYOgMgTesw3CLK/SgKgvyQfpVEDfsNBxtUv2c9URSOhQJBuRa+YJlCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828050;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Rk06TPsNuSYNZpmcY1EL1bB69MosIEeHhnb1bttpITI=;
	b=YAIagX8Q45uFIFafY1Tg55aMPC3tFzF1G/tRclHk3F1zGb0COnypsXY1sAiJoTRwbzbq
	 9CUwqo0E0VD4RipVLHdnXKtRdUDqZAXijJLIGgZpj2WHQuT9fanE6y+9X57mTLPEGg4UG
	 XMuNQoFSLGHBOyA92umIw4f6KlB7ZTc7Oy7MCNtj2QbkKs4DYx+lbDsscpvqR/c2aF2mR
	 AyXE35cxTu20D0mNyWaiuLrT4qoR2XMWyzNF3ccy9NyN4yjO31BzsR33n5Ly7Ww8sF+b5
	 k7p5EqVD6yhNK6jwLq0+EHYCSMoUKfiy4KBe0aX2wdVIbj7c6qvODEg4r23laUPFjdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AALQtEQ2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A49E607181B
	for <dwarves@vger.kernel.org>; Mon, 16 Nov 2026 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AALQtEQ2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5421F000CE;
	Mon, 16 Nov 2026 11:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828050;
	bh=Rk06TPsNuSYNZpmcY1EL1bB69MosIEeHhnb1bttpITI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AALQtEQ2kEovu3LOa7fijVMg7SVc7dHaWr7ZnhZR71+dMWXGBGrGUhpkHfE5/fLS9
	 0RqMYItb+lNQ+FIU+sWfumMP5KOl/Qu/uHCQC5l5J9F3PmlTpt6Aowo2/i7qqFhPHo
	 qUQ4soPCJ+z2zwvcnj3en12e+6+A6pJOSR+JxfxgToMrUzXTtuMiwlKbTtg3ur03B5
	 +Td3ve/QGJac3I4jBlNa8meH/Hr/q+Eh11+9gSZ4XrXiHQDQE9AviVYYt27ol5cfbd
	 Pc+wQ2h/BIJBGlprkN/S/imir8xfwulcHVeMu1jh3xABMGD1QOXfte2Nd9+q4+03So
	 fJque+mAlaZgA==
From: Alan Maguire <almagui@kernel.org>
To: dwarves@vger.kernel.org
Cc: Alan Maguire <almagui@kernel.org>
Subject: [PATCH dwarves 3/6] CI: Scope workflow concurrency groups to the branch for push runs
Date: Mon, 16 Nov 2026 11:20:40 +0000
Message-ID: <20261116112043.3831978-4-almagui@kernel.org>
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

test.yml and build.yml use ci-{test,build}-${{ github.head_ref }} as
their concurrency group with cancel-in-progress.  github.head_ref is
only set for pull_request events, so for push and scheduled runs the
group is just "ci-test-"/"ci-build-": a push to any branch, or the
daily scheduled run, cancels in-progress push runs on every other
branch.

Fall back to github.ref when head_ref is empty so that only runs for
the same PR or branch cancel each other.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Alan Maguire <almagui@kernel.org>
---
 .github/workflows/build.yml | 2 +-
 .github/workflows/test.yml  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index 25a395f..d45b05a 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -7,7 +7,7 @@ on:
     - cron:  '0 18 * * *'
 
 concurrency:
-  group: ci-build-${{ github.head_ref }}
+  group: ci-build-${{ github.head_ref || github.ref }}
   cancel-in-progress: true
 
 jobs:
diff --git a/.github/workflows/test.yml b/.github/workflows/test.yml
index 940dab1..8bff4e4 100644
--- a/.github/workflows/test.yml
+++ b/.github/workflows/test.yml
@@ -7,7 +7,7 @@ on:
     - cron:  '0 18 * * *'
 
 concurrency:
-  group: ci-test-${{ github.head_ref }}
+  group: ci-test-${{ github.head_ref || github.ref }}
   cancel-in-progress: true
 
 jobs:
-- 
2.56.0

