Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC92456284;
	Wed, 29 Jul 2026 19:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352085; cv=none; b=l/JrGZuBDquVYRutqdyDEAE/SyjAgxFR5f48pyXIBppOe832vCZ5Qxt4yQSncXV7awNCq81Nhjry1ZvvmJZVdIyjWqE6tA5rFoMvg+qM1OCbf8mhvmec9EpsKr8s79ozCRX3j9Y7qXZPrZJiemsLAyDuVqnPeyuUqIlZXvWnr+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352085; c=relaxed/simple;
	bh=NeseW9+iYQ1qc4tyH4LpcYdd/H/ZqeXVWOS4+y6qZkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAnc9s4hZsVn1oJ9+xcmYuqCPqKxuCkKAcKoj5/8kUyvyTI6rQHu5iiSeH89aWEcsESIOaIzzRX+mZnGw85uE9YlGXNiLYuJd5wYbSs9zgni5h+bfJ4OmFwqAwe0JIDKi95PPgax6EkfU0wqBSCzGnoNKMFTDXF6D8R2nC1wRIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRLjnyx5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRLjnyx5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E4B1F000E9;
	Wed, 29 Jul 2026 19:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352083;
	bh=FoP8BvGos+CTA80tDMaRk8hhibpC7d91ukHEbVb1/rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kRLjnyx5/dvcrlzHgmXFfCB5l6C3yM2xUJ1aT+MMUDsgGFrDO0lm7PP5/rjMKDHi4
	 MDZBMfqmua8ujjd2oh0LsY5niEcv55U72RpQIT4aFrJB1l+g6OMIjOUXwDPaeWymqB
	 Qv1f/5KjWSSZxos+HEopnmMV0TOtZ9c38IubmQSc9bLoRkszeVeTeeknDKx7h7YU5Q
	 mIhfTfCZRVE3JIQ/r7rDrItJQNUEBWrbvjMJywBp3xqPmzdBZ8tLFqDUe7rXbug+zP
	 uoc/Bh8aZv+yPn4lKiN5mjABjkROzgAZfyNyVyJa4J2Tz/97QTmJ/Vq1T9vCtz990+
	 1JTks0imVxR8Q==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/31] pahole: Fix --errno typo that decrements instead of negating
Date: Wed, 29 Jul 2026 16:07:11 -0300
Message-ID: <20260729190733.72876-12-acme@kernel.org>
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

prototype__stdio_fprintf_value() uses --errno in three error paths,
which decrements the global errno value instead of negating it with
-errno.  This causes the function to return a wrong (often positive)
value on error, making callers think the operation succeeded.

Before: --errno with errno=5 returns 4 (positive, looks like success)
After:  -errno with errno=5 returns -5 (negative, correctly signals error)

Fixes: 9310b04854a8b709 ("pahole: Add support for referencing header variables when pretty printing")
Reported-by: Sashiko:gemini-3-1-pro-preview
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 pahole.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/pahole.c b/pahole.c
index 0096dfa34e5047c8..6ba3f578c28570a1 100644
--- a/pahole.c
+++ b/pahole.c
@@ -2584,7 +2584,7 @@ static int prototype__stdio_fprintf_value(struct prototype *prototype, struct ty
 		return -ENOMEM;
 
 	if (type__instance_read_once(header, input) < 0) {
-		printed = --errno;
+		printed = -errno;
 		fprintf(stderr, "pahole: --header (%s) type couldn't be read\n", conf.header_type);
 		goto out;
 	}
@@ -2667,7 +2667,7 @@ static int prototype__stdio_fprintf_value(struct prototype *prototype, struct ty
 		free(member_name);
 
 		if (pipe_seek(input, seek_bytes) < 0) {
-			printed = --errno;
+			printed = -errno;
 			fprintf(stderr, "Couldn't --seek_bytes %s (%" PRIu64 "\n", conf.seek_bytes, seek_bytes);
 			goto out;
 		}
@@ -2718,7 +2718,7 @@ static int prototype__stdio_fprintf_value(struct prototype *prototype, struct ty
 		}
 
 		if (pipe_seek(input, seek_bytes) < 0) {
-			printed = --errno;
+			printed = -errno;
 			fprintf(stderr, "Couldn't --seek_bytes %s (%" PRIu64 "\n", conf.seek_bytes, seek_bytes);
 			goto out;
 		}
-- 
2.55.0

