Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717AC48662D;
	Wed, 29 Jul 2026 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352117; cv=none; b=c4lmX3XPJdHBa4deqDDEkxFuPnkiFEIfXbonoQHEhIcEmuHt219o2+liOu8rneyRWJGukjrav9FfrJbHfILiPJAKrx3099/tOh0J4OWeTNev3Au/nIrmaqn1MWGex3sZ8LFrd/NUK5fBV70AjZvUwlnL12UUaP7Av5XEfKZRdfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352117; c=relaxed/simple;
	bh=vjC3m6cKKHdetsv8u5Fe2wpgu9OY//O7EJ66mJxFQLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DR9ZKaZmtep8lH3Hnocd0dJohMqaslKSi5RrJbA7jnZHPQbsJamA5PEEvLww2twzUMyGdV80b77uy6nkpM0wSr8ZN67IQ13op86GHHHs5oLqzQ5e/H0YYDSp0RwgeHyT8nv82X14nEeu2INuMp9VkkbK3I1ThXIP2HKk0yHwrxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7MHqEqD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7MHqEqD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E661F000E9;
	Wed, 29 Jul 2026 19:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352116;
	bh=ezguSWzp4+25GtDUHcaHtyi3I9+OurtFvBRFgu6gi/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d7MHqEqDmerTmGS1F+BtU5ohnz/ZwwsAz81EF3OiyQuGd6px5MtQGiIA6oJ8IVB4G
	 ZhmzRn5I1VXLMADBusAdUUgOsWzhd3GeqlRaDAQxSwkT9saF7dHNj1TCbt1yQsThYW
	 fZh/x4ZLpATaCjWEMkLD80Tf0LtqG5gncmQb/UB9sKUkicrEMI90yzm5CSTVHaIsMv
	 ma1KImB5ak5ipYSuNBfEMZT0qBRympbBpcpgeE6Qmpsr/ElZJeuxyXlLqpc65Esh9s
	 LOz8RE9rfkM8EX/VxV4i6yCuCUL15hUoWdpkQfU3cXccX7uU/NMcw2G3h4NnIjbqlE
	 dnN72Gv2iEcgw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 25/31] pahole: Guard pipe_seek() against negative offsets
Date: Wed, 29 Jul 2026 16:07:25 -0300
Message-ID: <20260729190733.72876-26-acme@kernel.org>
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

pipe_seek() simulates forward seeking on non-seekable streams by
reading and discarding chunks into a 4096-byte stack buffer.  When
called with a negative offset, 'chunk' gets a negative value that is
implicitly cast to a huge size_t by fread(), causing a stack buffer
overflow.

This can happen when a user passes a negative --seek_bytes value:
fseeko() fails (SEEK_SET rejects negatives), then the fallback calls
pipe_seek() with the unchecked negative value.

Guard against this by rejecting negative offsets at the top of
pipe_seek(), and short-circuit zero offsets as a no-op.

Before:

  $ echo | pahole --seek_bytes -1 --prettify - -C task_struct vmlinux
  (stack buffer overflow / crash)

After:

  $ echo | pahole --seek_bytes -1 --prettify - -C task_struct vmlinux
  Couldn't --seek_bytes -1 (18446744073709551615)

Uncovered during code coverage analysis work.

Fixes: fe284221448c950d ("pahole: Introduce --seek_bytes")
Reported-by: Sashiko:gemini-3.1-pro-preview
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 pahole.c | 58 ++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/pahole.c b/pahole.c
index cceaf9030d442248..5cf92833e6e84df9 100644
--- a/pahole.c
+++ b/pahole.c
@@ -18,6 +18,7 @@
 #include <stdarg.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/stat.h>
 #include <unistd.h>
 #include <bpf/btf.h>
 #include "bpf/libbpf.h"
@@ -2371,6 +2372,13 @@ static int pipe_seek(FILE *fp, off_t offset)
 	char bf[4096];
 	int chunk = sizeof(bf);
 
+	/* Negative offset would wrap chunk to a huge size_t in fread() */
+	if (offset < 0)
+		return -1;
+
+	if (offset == 0)
+		return 0;
+
 	if (chunk > offset)
 		chunk = offset;
 
@@ -2605,16 +2613,22 @@ static int prototype__stdio_fprintf_value(struct prototype *prototype, struct ty
 	uint64_t size_bytes = ULLONG_MAX;
 	uint32_t count = 0;
 	uint32_t skip = conf.skip;
+	/* Bytes consumed from input so far, for absolute→relative seek on pipes */
+	off_t consumed = 0;
+	int64_t header_bytes;
 
 	if (instance == NULL)
 		return -ENOMEM;
 
+	/* Keep consumed in sync with bytes actually fread'd from input */
 	errno = 0;
-	if (type__instance_read_once(header, input) < 0) {
+	header_bytes = type__instance_read_once(header, input);
+	if (header_bytes < 0) {
 		printed = errno ? -errno : -EIO;
 		fprintf(stderr, "pahole: --header (%s) type couldn't be read\n", conf.header_type);
 		goto out;
 	}
+	consumed = header_bytes;
 
 	if (conf.range || prototype->range) {
 		off_t seek_bytes;
@@ -2662,21 +2676,25 @@ static int prototype__stdio_fprintf_value(struct prototype *prototype, struct ty
 		 * for non-seekable streams (stdin, pipes).
 		 */
 		if (fseeko(input, seek_bytes, SEEK_SET) != 0) {
-			off_t total_read_bytes = ftell(input);
-
-			if (seek_bytes < total_read_bytes) {
-				fprintf(stderr, "pahole: can't seek backward in non-seekable input, already read %" PRIu64 " bytes, target %#" PRIx64 "\n",
-						total_read_bytes, seek_bytes);
+			if (seek_bytes < consumed) {
+				fprintf(stderr, "pahole: can't seek backward in non-seekable input, already read %" PRId64 " bytes, target %#" PRIx64 "\n",
+						(int64_t)consumed, seek_bytes);
 				printed = -ESPIPE;
 				goto out;
 			}
 
-			seek_bytes -= total_read_bytes;
-
 			errno = 0;
-			if (pipe_seek(input, seek_bytes) < 0) {
+			if (pipe_seek(input, seek_bytes - consumed) < 0) {
 				printed = errno ? -errno : -EIO;
-				fprintf(stderr, "Couldn't seek to offset %" PRIu64 " for range=%s\n", seek_bytes, range);
+				fprintf(stderr, "Couldn't seek to offset %" PRId64 " for range=%s\n", (int64_t)seek_bytes, range);
+				goto out;
+			}
+		} else {
+			struct stat sb;
+			if (fstat(fileno(input), &sb) == 0 && S_ISREG(sb.st_mode) && seek_bytes >= sb.st_size) {
+				fprintf(stderr, "pahole: seek offset %" PRId64 " is beyond file size %" PRId64 " for range=%s\n",
+						(int64_t)seek_bytes, (int64_t)sb.st_size, range);
+				printed = -EINVAL;
 				goto out;
 			}
 		}
@@ -2750,13 +2768,25 @@ static int prototype__stdio_fprintf_value(struct prototype *prototype, struct ty
 		 * forward-reading pipe_seek() for pipes/stdin.
 		 */
 		if (fseeko(input, seek_bytes, SEEK_SET) != 0) {
-			if (header)
-				seek_bytes -= ftell(input);
+			if (seek_bytes < consumed) {
+				fprintf(stderr, "pahole: can't seek backward in non-seekable input, already read %" PRId64 " bytes, target %#" PRIx64 "\n",
+						(int64_t)consumed, seek_bytes);
+				printed = -ESPIPE;
+				goto out;
+			}
 
 			errno = 0;
-			if (pipe_seek(input, seek_bytes) < 0) {
+			if (pipe_seek(input, seek_bytes - consumed) < 0) {
 				printed = errno ? -errno : -EIO;
-				fprintf(stderr, "Couldn't --seek_bytes %s (%" PRIu64 ")\n", conf.seek_bytes, seek_bytes);
+				fprintf(stderr, "Couldn't --seek_bytes %s (%" PRId64 ")\n", conf.seek_bytes, (int64_t)seek_bytes);
+				goto out;
+			}
+		} else {
+			struct stat sb;
+			if (fstat(fileno(input), &sb) == 0 && S_ISREG(sb.st_mode) && seek_bytes >= sb.st_size) {
+				fprintf(stderr, "pahole: --seek_bytes %" PRId64 " is beyond file size %" PRId64 "\n",
+						(int64_t)seek_bytes, (int64_t)sb.st_size);
+				printed = -EINVAL;
 				goto out;
 			}
 		}
-- 
2.55.0

