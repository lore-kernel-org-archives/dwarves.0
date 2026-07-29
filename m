Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188D6463B60;
	Wed, 29 Jul 2026 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352067; cv=none; b=A1iH9X+emGmwYoi6+cMAgncbdfBFpbrx1Ps9cWKd3mJBfN/trh7lIn87y/IN4ylh2JPulvUPPKhlkkXO0hI49uSa/eZY16wA/GKRQleDt89ItjZkZLQy3YBSW04ne0/yZvBazE2if+BaMkdXcwuTENYmEKnlYhf8RoPI5u3oJSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352067; c=relaxed/simple;
	bh=mFKPapB6t7Y7d57cONkvRxPg+Aarp/yP6KThmYtK/fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gAVWv7XTIi99ir42MKb+BxAga1OEYrfSK484qEzfrMv5PLD6Y2sPAOqC+IL35DudmQHmapKdjBkaWqUdIkqWlKI2ZegApAjCRh/rNwSNbrSa74vWjiHTntWQ81BcxKOhTQem3b/UnV7VE62FceNG2RK/Rqa0EEs/ibS3KC/BV2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnT22TAi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnT22TAi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66F71F000E9;
	Wed, 29 Jul 2026 19:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352065;
	bh=e9c/b6aAT1ldyKzVX6fYq0LE4n8hJoKL/lDwtiJ7hd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JnT22TAi08HdUA/Uzla5nt1Mx7uBOlCc98X5Qh2kLop1LO26pduaivcnnT1tsPoWR
	 uFchMbXyD23MFL+NNJAINyopaEmwSuvVVRDvhnhtLB3jR0Id8iDLF0EWiWO7rzifiK
	 MktY6X10Y5v0EGuk5pQtt6OJentgJKOAyJDDF1A6p3i1wR6AIrTsgwSreIRusRuFH8
	 +qm6VXETftKoFvlhHYMIfB+0TgqqqAML62Ropb05ziEmtlODFjcf6s+jbJcce2gn4M
	 Nf11Lde/7XSLpfitNGcybiay6K3rW2c84Z0LbZ1+ZdS7TqERel22ZBvoXSU6kEMF5R
	 ebJ4A4620dzSA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/31] btf_encoder: Fix interior pointer free and missing NULL check
Date: Wed, 29 Jul 2026 16:07:03 -0300
Message-ID: <20260729190733.72876-4-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729190733.72876-1-acme@kernel.org>
References: <20260729190733.72876-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Two bugs in btf_encoder:

1. btf_encoder__save_func() called free(state) on error, but state is
   an interior pointer into func_states.array (returned by
   btf_encoder__alloc_func_state as &array[cnt++]), not a standalone
   malloc'd block.  Calling free() on it is undefined behavior that
   corrupts the heap allocator's metadata.

   Fix: clear the slot with memset and decrement func_states.cnt to
   release it back.  This is safe because no further func_state
   allocations happen between the alloc at the top of save_func and
   the error path, so state is always the last element.

2. btf_encoder__new() allocated func_states.array with zalloc() but
   did not check for NULL.  A failed allocation would cause a NULL
   pointer dereference in btf_encoder__alloc_func_state().

   Fix: add NULL check, goto out_delete on failure.

Fixes: 4bff1141bb48ae58 ("btf_encoder: Record BTF-centric function state instead of DWARF-centric")
Reported-by: Sashiko:gemini-3-1-pro-preview # Running on a local machine
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 btf_encoder.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 9f8cd279fa92af1c..5d0901da73b618d7 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1393,9 +1393,21 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 	}
 	return 0;
 out:
+	/*
+	 * state is an interior pointer into func_states.array (returned by
+	 * btf_encoder__alloc_func_state), not a standalone allocation.
+	 * Calling free(state) here was heap corruption.
+	 *
+	 * Since no further func_state allocations happen between the alloc
+	 * at the top of this function and this error path, state is always
+	 * the last element (index cnt-1), so decrementing cnt releases it.
+	 * If this invariant ever changes (e.g. nested alloc calls are added),
+	 * this cleanup must be revised.
+	 */
 	zfree(&state->annots);
 	zfree(&state->parms);
-	free(state);
+	memset(state, 0, sizeof(*state));
+	encoder->func_states.cnt--;
 	return err;
 }
 
@@ -2814,6 +2826,8 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 
 		/* Start with funcs->cnt. The array may grow in btf_encoder__alloc_func_state() */
 		encoder->func_states.array = zalloc(sizeof(*encoder->func_states.array) * funcs->cnt);
+		if (encoder->func_states.array == NULL && funcs->cnt > 0)
+			goto out_delete;
 		encoder->func_states.cap = funcs->cnt;
 		encoder->func_states.cnt = 0;
 
-- 
2.55.0

