Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C6B463B73;
	Wed, 29 Jul 2026 19:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352099; cv=none; b=VHa46FH1SN3m4LzMu0M9k/deX6LsZjJooVhNqcNFpTUNAttDrNElWOAFklGPTXvKPmS6DJUcGrZI4qEerduNj8CFJGlSmtG9BR7kfflUBS/0XSDeSc3U6Q9Hy5Syu9tRrLImfchm/z/6DHln2/MgDexJe/UgDFm8RqPj+vQYA0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352099; c=relaxed/simple;
	bh=aPsoKTk0LaoOgfkbi56C/QNNET84ZedLHP+me5A0Dx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aI9EINKtiH1iNRFiGTLRRpcpYdsTBIQkaL+F2NAbfR/O+dkGZYJADbq7ziWLpeG41XM8Dy0DXgquQ/Ll5sYL0vm2BU0eoE6tPuFO+5JWfNZCL3AXnlFMQMkPkgAkGTHm2dJPvAOalCvPoFZMif7wBRf5BLulmG+9r2Q7aBEVw4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xps6mn3K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xps6mn3K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EC31F000E9;
	Wed, 29 Jul 2026 19:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352098;
	bh=ys3YbXkqer9cffxUblDPaevUrQE1sb/ceACWCMc2R9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xps6mn3KOklHxm5VgaZxZY6omPNG0VQ/Pq2TeLoXOlcegDZLdxKkDVndIbiZadmYV
	 nvtjGOyhCQ4geXFPLfjH8pxAjZ43prYwD+aOkpvDRs3NdYPADTRNIitpXhrB/Aa2vz
	 th+EjC+h5ieGdoNwyEoY1Bmev575g+5CmW6HYSru1sLXZ4l8QKBMkJjjMLsYOLNysX
	 YagvRuNYyq6AycawTUDrGQ2b8gr7YT6ori6m5pc9rlcRuD3rJe7M8MVnXAcH9OWfTY
	 ZPgxmhUY7PGe4lBetRUVMaiftKUu3mtah43MYrAd/WnoL9HHjcPfbte8Zw7pR5jn72
	 XhXYZWCtHANpQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/31] dwarf_loader: Fix data race in tag__init() decl_file string cache
Date: Wed, 29 Jul 2026 16:07:17 -0300
Message-ID: <20260729190733.72876-18-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729190733.72876-1-acme@kernel.org>
References: <20260729190733.72876-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The static variables last_decl_file and last_decl_file_ptr cache the
most recent dwarf_decl_file() result to avoid redundant strdup() calls
when consecutive DIEs share the same declaration file.

However, multiple worker threads call tag__init() concurrently, and
this cache is a pahole-internal optimization unrelated to libdw thread
safety. When _ELFUTILS_THREAD_SAFE makes libdw__lock a no-op, threads
race on these statics — one thread can see another's stale pointer,
skipping the strdup and assigning an incorrect (or freed) filename.

Make them __thread so each worker gets its own cache. The caching
still works well since DWARF CUs are processed per-thread and DIEs
within a CU tend to share the same source file:

  Before (__thread): j=1: 6.63s, j=4: 2.32s, j=32: 2.13s
  After  (__thread): same — no measurable overhead from TLS access

Fixes: a93160df5335ed2e ("dwarf_loader: Make dwarf_tag->decl_file a real string")
Reported-by: Sashiko:gemini-3-1-pro-preview
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 759883cad3fce693..04dffae3504efa06 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -534,7 +534,14 @@ static void tag__init(struct tag *tag, struct cu *cu, Dwarf_Die *die)
 
 		int32_t decl_line;
 		const char *decl_file = dwarf_decl_file(die);
-		static const char *last_decl_file, *last_decl_file_ptr;
+		/*
+		 * Per-thread string dedup cache: avoids strdup() when
+		 * consecutive DIEs share the same decl_file pointer.
+		 * Must be __thread, not plain static, because multiple
+		 * worker threads call tag__init() concurrently and a
+		 * shared cache would race regardless of libdw locking.
+		 */
+		static __thread const char *last_decl_file, *last_decl_file_ptr;
 
 		if (decl_file != last_decl_file_ptr) {
 			last_decl_file = decl_file ? strdup(decl_file) : NULL;
-- 
2.55.0

