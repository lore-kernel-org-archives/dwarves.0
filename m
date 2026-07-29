Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A207E371880;
	Wed, 29 Jul 2026 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352071; cv=none; b=q6hU/rdfYGXihAXFwoumEMpGDinl5yeow4Bya/kLVi5I+yCmJEk1Xja1wG7g1uDOd8WdfqvpD6BI/lGCGUAUdzdhVtDBBMAOZ1+8lSSpqDws8T8nb5jofeDZbk20icNIBcObGj/NMTPUSP0DtcnpEBuQBQj3iSiByFLt+4JDTko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352071; c=relaxed/simple;
	bh=rjpuGXYqeN5625RyXq43koplNh6VBLLTvqfnfeU5w68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZD1wZ8GUh4nMklsNUrGKrP4SmBrPp+t35HH+Rhi++1G8vPYgOEdDK7Cy4PQ/bLnfim7D77qy5hFEpbgBozuFFHBHBKlXmJkahZegiBCMNxvzo5MfGgreUCpAD71NfBgoG2jnZI8IkhhtOR+OtoLZo+qHgaY/rEiwNR3JPco81s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzYrKuGI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzYrKuGI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BE71F000E9;
	Wed, 29 Jul 2026 19:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352070;
	bh=AsmVO/MwZTWMqwo3+cV1YJ+baTRvBv/Xx95yhrPntSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RzYrKuGIAGsyDdY3ZnyHzLASd1lxJfUTOLs71w4XCW/FcKIIzop1CAR4+/iRKaQLs
	 EDFMrfRZqM+NCY2zIA1laUZSMtifXy4BNEeo0eYF4KfDCL625SL3fV6ikAUh4VRcSI
	 YSoy23mxBDFycvIZQBCDFHanIGiw2gVrdjFCR470+qFJjNlEAwYA64YlY9YF0YIJfq
	 dDA8G5JTXpKecJhJ9NpUcCJ0T9mD0AeuKyj8XjNb8tOYyQMHF2t7rPDl0qFBI0oZ1/
	 haqTys0zoS5n16lerCJnkNbAAI2ihlDOmGpVl+bXd80ocdAnjoXP/Blkl5GMKx4pCo
	 AHp+lHg/gDjnw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/31] pahole: Fix instance memory leak on early returns in prototype__stdio_fprintf_value
Date: Wed, 29 Jul 2026 16:07:05 -0300
Message-ID: <20260729190733.72876-6-acme@kernel.org>
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

prototype__stdio_fprintf_value() allocates an instance buffer via
malloc() but has 14 early return statements between the allocation
and the free(instance) at the out: label.  None of these early returns
free instance, leaking memory on every error path during --prettify
binary record processing.

Change all bare returns after the successful malloc to 'goto out',
setting printed to the error value before jumping.  The out: label
already does free(instance) and return printed.

The return -ENOMEM when instance == NULL (malloc failure) is kept
as-is since there is nothing to free.

Fixes: fdfc64ec44f4ad53 ("pahole: Introduce --range")
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 pahole.c | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/pahole.c b/pahole.c
index 390d5f2dd20e4dfd..0096dfa34e5047c8 100644
--- a/pahole.c
+++ b/pahole.c
@@ -2584,9 +2584,9 @@ static int prototype__stdio_fprintf_value(struct prototype *prototype, struct ty
 		return -ENOMEM;
 
 	if (type__instance_read_once(header, input) < 0) {
-		int err = --errno;
+		printed = --errno;
 		fprintf(stderr, "pahole: --header (%s) type couldn't be read\n", conf.header_type);
-		return err;
+		goto out;
 	}
 
 	if (conf.range || prototype->range) {
@@ -2598,14 +2598,16 @@ static int prototype__stdio_fprintf_value(struct prototype *prototype, struct ty
 				fprintf(stderr, "pahole: --header_type=%s not found\n", conf.header_type);
 			else
 				fprintf(stderr, "pahole: range (%s) requires --header\n", range);
-			return -ESRCH;
+			printed = -ESRCH;
+			goto out;
 		}
 
 		char *member_name = NULL;
 
 		if (asprintf(&member_name, "%s.%s", range, "offset") == -1) {
 			fprintf(stderr, "pahole: not enough memory for range=%s\n", range);
-			return -ENOMEM;
+			printed = -ENOMEM;
+			goto out;
 		}
 
 		int64_t value = type_instance__int_value(header, member_name);
@@ -2614,7 +2616,8 @@ static int prototype__stdio_fprintf_value(struct prototype *prototype, struct ty
 			fprintf(stderr, "pahole: couldn't read the '%s' member of '%s' for evaluating range=%s\n",
 				member_name, conf.header_type, range);
 			free(member_name);
-			return -ESRCH;
+			printed = -ESRCH;
+			goto out;
 		}
 
 		seek_bytes = value;
@@ -2628,7 +2631,8 @@ static int prototype__stdio_fprintf_value(struct prototype *prototype, struct ty
 		if (seek_bytes < total_read_bytes) {
 			fprintf(stderr, "pahole: can't go back in input, already read %" PRIu64 " bytes, can't go to position %#" PRIx64 "\n",
 					total_read_bytes, seek_bytes);
-			return -ENOMEM;
+			printed = -ENOMEM;
+			goto out;
 		}
 
 		if (global_verbose) {
@@ -2640,7 +2644,8 @@ static int prototype__stdio_fprintf_value(struct prototype *prototype, struct ty
 
 		if (asprintf(&member_name, "%s.%s", range, "size") == -1) {
 			fprintf(stderr, "pahole: not enough memory for range=%s\n", range);
-			return -ENOMEM;
+			printed = -ENOMEM;
+			goto out;
 		}
 
 		value = type_instance__int_value(header, member_name);
@@ -2649,7 +2654,8 @@ static int prototype__stdio_fprintf_value(struct prototype *prototype, struct ty
 			fprintf(stderr, "pahole: couldn't read the '%s' member of '%s' for evaluating range=%s\n",
 				member_name, conf.header_type, range);
 			free(member_name);
-			return -ESRCH;
+			printed = -ESRCH;
+			goto out;
 		}
 
 		size_bytes = value;
@@ -2661,9 +2667,9 @@ static int prototype__stdio_fprintf_value(struct prototype *prototype, struct ty
 		free(member_name);
 
 		if (pipe_seek(input, seek_bytes) < 0) {
-			int err = --errno;
+			printed = --errno;
 			fprintf(stderr, "Couldn't --seek_bytes %s (%" PRIu64 "\n", conf.seek_bytes, seek_bytes);
-			return err;
+			goto out;
 		}
 
 		goto do_read;
@@ -2676,7 +2682,8 @@ static int prototype__stdio_fprintf_value(struct prototype *prototype, struct ty
 			if (!header) {
 				fprintf(stderr, "pahole: --seek_bytes (%s) makes reference to --header but it wasn't specified\n",
 					conf.seek_bytes);
-				return -ESRCH;
+				printed = -ESRCH;
+				goto out;
 			}
 
 			const char *member_name = conf.seek_bytes + sizeof("$header.") - 1;
@@ -2684,7 +2691,8 @@ static int prototype__stdio_fprintf_value(struct prototype *prototype, struct ty
 			if (value < 0) {
 				fprintf(stderr, "pahole: couldn't read the '%s' member of '%s' for evaluating --seek_bytes=%s\n",
 					member_name, conf.header_type, conf.seek_bytes);
-				return -ESRCH;
+				printed = -ESRCH;
+				goto out;
 			}
 
 			seek_bytes = value;
@@ -2696,7 +2704,8 @@ static int prototype__stdio_fprintf_value(struct prototype *prototype, struct ty
 			if (seek_bytes < header->type->size) {
 				fprintf(stderr, "pahole: seek bytes evaluated from --seek_bytes=%s is less than the header type size\n",
 					conf.seek_bytes);
-				return -EINVAL;
+				printed = -EINVAL;
+				goto out;
 			}
 		} else  {
 			seek_bytes = strtol(conf.seek_bytes, NULL, 0);
@@ -2709,9 +2718,9 @@ static int prototype__stdio_fprintf_value(struct prototype *prototype, struct ty
 		}
 
 		if (pipe_seek(input, seek_bytes) < 0) {
-			int err = --errno;
+			printed = --errno;
 			fprintf(stderr, "Couldn't --seek_bytes %s (%" PRIu64 "\n", conf.seek_bytes, seek_bytes);
-			return err;
+			goto out;
 		}
 	}
 
@@ -2720,7 +2729,8 @@ static int prototype__stdio_fprintf_value(struct prototype *prototype, struct ty
 			if (!header) {
 				fprintf(stderr, "pahole: --size_bytes (%s) makes reference to --header but it wasn't specified\n",
 					conf.size_bytes);
-				return -ESRCH;
+				printed = -ESRCH;
+				goto out;
 			}
 
 			const char *member_name = conf.size_bytes + sizeof("$header.") - 1;
@@ -2728,7 +2738,8 @@ static int prototype__stdio_fprintf_value(struct prototype *prototype, struct ty
 			if (value < 0) {
 				fprintf(stderr, "pahole: couldn't read the '%s' member of '%s' for evaluating --size_bytes=%s\n",
 					member_name, conf.header_type, conf.size_bytes);
-				return -ESRCH;
+				printed = -ESRCH;
+				goto out;
 			}
 
 			size_bytes = value;
-- 
2.55.0

