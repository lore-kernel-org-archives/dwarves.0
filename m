Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2363748662D;
	Wed, 29 Jul 2026 19:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352115; cv=none; b=bHq493wuEvkI4X2Sxhca+WBMfsMiP07WLXnPGeFu3kG7MoSpGXsDfmy/KpBIxXyRV+vFAQrzk2zr0QKPUq8PUnBr5IlzZuIR7kZqEDJQYrQXKzYcng0UkcX2Jlq8FWQQefK/LAk8QL9qQP9iYYsYSVqttf+wPx8CRSkt+xuKx2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352115; c=relaxed/simple;
	bh=dl1d7MclUstFOtC69najf3oEFm4jPng5YfVK3SlIfNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9pFOpeFnhWxVlNzx/ScpZZ5BlbEnad8zuQxeYtmrbU0OAhN6RzHlNDont1RGOPV0NCidQIG08FveB5BmITCXeZkYNJG6v7Dh8K6iqyabwMAs0MgbVvQVRNRGlRyatYlm2Ohw+wprX6lX7K5+SFzjHjPEIX0byvvH+KMFAO+2cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoVMbUuL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoVMbUuL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE301F00A3A;
	Wed, 29 Jul 2026 19:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352113;
	bh=hFEluD5lgZp/ILXQjMPtgBwzqo3dgE55ELnu3FMOzS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QoVMbUuL2Js+aEPQmz5m9q0bEFdEVqbphzf6lUwV/+u6SiuoBBCTyivjbC6vmrdSS
	 wBkmdBllGTrqU4CoR63qD8J5IJHKZ9hRYr8iemZ3A3tSto63usp83qRaQBJvJh/2g1
	 G/EeSwZLdtGGPQwOnmHOjUVABKrgjczK6gYB+sn6pr1KXeNuFMycuKDdu34KWAKY5b
	 a75IV9Hd9NODjhZ0Zh32sbFzvgjvW8zZbGM2Nb1W00rfACn9HwiIElAhAk7at4ncrL
	 Rm6g+WLs1d6BaE6llhz3Up6Hc0/YFBGXzIw8IWYB3dvEKRJrcsvLs2+N6RV4RU5bTw
	 UmFt3lg5mYprw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 24/31] pahole: Use fseek for seekable files in --prettify and --seek_bytes
Date: Wed, 29 Jul 2026 16:07:24 -0300
Message-ID: <20260729190733.72876-25-acme@kernel.org>
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

pipe_seek() simulates forward seeking by reading and discarding data
in 4096-byte chunks.  This was the only seek strategy because the
input could be stdin.  But when --prettify_input_filename is a regular
file (the common case), the FILE pointer is seekable.

Use fseeko() first for both --range and --seek_bytes paths.  If it
fails (ESPIPE on pipes/stdin), fall back to pipe_seek().  This gives:

- O(1) seeks for regular files instead of reading N bytes through
  4096-byte chunks
- Backward seeks now work for regular files where --range offsets
  point before the current read position (previously errored with
  "can't go back in input")
- No behavior change for pipe/stdin input

Also remove a misleading FIXME on the structures__add find-or-insert
pattern — the code was already correct and the allocation is needed
for deduplication.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 pahole.c | 69 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 30 deletions(-)

diff --git a/pahole.c b/pahole.c
index 65becc938cb0fc01..cceaf9030d442248 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1042,7 +1042,7 @@ static int type__print_containers(struct type *type, struct cu *cu, uint32_t con
 		return 0;
 
 	if (ident == 0) {
-		bool existing_entry; // FIXME: This should really just search, no need to try to add it.
+		bool existing_entry;
 		struct structure *str = structures__add(type__class(type), cu, 0, &existing_entry);
 		if (str == NULL) {
 			fprintf(stderr, "pahole: insufficient memory for "
@@ -2651,23 +2651,35 @@ static int prototype__stdio_fprintf_value(struct prototype *prototype, struct ty
 
 		free(member_name);
 
-		off_t total_read_bytes = ftell(input);
-
-		// Since we're reading input, we need to account for what we already read
-		// FIXME: we now have a FILE pointer that _may_ be stdin, but not necessarily
-		if (seek_bytes < total_read_bytes) {
-			fprintf(stderr, "pahole: can't go back in input, already read %" PRIu64 " bytes, can't go to position %#" PRIx64 "\n",
-					total_read_bytes, seek_bytes);
-			printed = -ENOMEM;
-			goto out;
-		}
-
 		if (global_verbose) {
 			fprintf(output, "pahole: range.seek_bytes evaluated from range=%s is %#" PRIx64 " \n",
 				range, seek_bytes);
 		}
 
-		seek_bytes -= total_read_bytes;
+		/*
+		 * Use fseek() for seekable files (regular files opened
+		 * by path).  Fall back to forward-reading pipe_seek()
+		 * for non-seekable streams (stdin, pipes).
+		 */
+		if (fseeko(input, seek_bytes, SEEK_SET) != 0) {
+			off_t total_read_bytes = ftell(input);
+
+			if (seek_bytes < total_read_bytes) {
+				fprintf(stderr, "pahole: can't seek backward in non-seekable input, already read %" PRIu64 " bytes, target %#" PRIx64 "\n",
+						total_read_bytes, seek_bytes);
+				printed = -ESPIPE;
+				goto out;
+			}
+
+			seek_bytes -= total_read_bytes;
+
+			errno = 0;
+			if (pipe_seek(input, seek_bytes) < 0) {
+				printed = errno ? -errno : -EIO;
+				fprintf(stderr, "Couldn't seek to offset %" PRIu64 " for range=%s\n", seek_bytes, range);
+				goto out;
+			}
+		}
 
 		if (asprintf(&member_name, "%s.%s", range, "size") == -1) {
 			fprintf(stderr, "pahole: not enough memory for range=%s\n", range);
@@ -2693,13 +2705,6 @@ static int prototype__stdio_fprintf_value(struct prototype *prototype, struct ty
 
 		free(member_name);
 
-		errno = 0;
-		if (pipe_seek(input, seek_bytes) < 0) {
-			printed = errno ? -errno : -EIO;
-			fprintf(stderr, "Couldn't --seek_bytes %s (%" PRIu64 "\n", conf.seek_bytes, seek_bytes);
-			goto out;
-		}
-
 		goto do_read;
 	}
 
@@ -2740,16 +2745,20 @@ static int prototype__stdio_fprintf_value(struct prototype *prototype, struct ty
 		}
 
 
-		if (header) {
-			// Since we're reading input, we need to account for already read header:
-			seek_bytes -= ftell(input);
-		}
-
-		errno = 0;
-		if (pipe_seek(input, seek_bytes) < 0) {
-			printed = errno ? -errno : -EIO;
-			fprintf(stderr, "Couldn't --seek_bytes %s (%" PRIu64 "\n", conf.seek_bytes, seek_bytes);
-			goto out;
+		/*
+		 * Use fseek() for seekable files, fall back to
+		 * forward-reading pipe_seek() for pipes/stdin.
+		 */
+		if (fseeko(input, seek_bytes, SEEK_SET) != 0) {
+			if (header)
+				seek_bytes -= ftell(input);
+
+			errno = 0;
+			if (pipe_seek(input, seek_bytes) < 0) {
+				printed = errno ? -errno : -EIO;
+				fprintf(stderr, "Couldn't --seek_bytes %s (%" PRIu64 ")\n", conf.seek_bytes, seek_bytes);
+				goto out;
+			}
 		}
 	}
 
-- 
2.55.0

