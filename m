Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE42A371880;
	Wed, 29 Jul 2026 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352074; cv=none; b=ND5hOARi6rON2sEAqUHOCWVJUTAtt/WMrV0YLhlYT+cbMMJo2MQZP5z2ywPu3JhqH0rnH1LlviCzgMj4QuNeVwrCxYc3aP6invpkTZUawzHdYwZflVplq5LezPBrXEtkqgP8SR7JZvKfKTKwcK653jva18i9SIyMQIWPv902EqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352074; c=relaxed/simple;
	bh=rfivy8Q8jHYkaphY53Eyk9sMlhfwnoSMT1pDliix8m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uR7tgQN/VeglHkZ5wFYQQolO9K/DzPP9NblwDKQgxTncv+P+p52Bb6b6RO4HX2RGx1Qbvzf5TqgLz655bgcYCirHknbOREXOC7IYWRTqFK28Dujm1QXwU7m5GDyySC8lO0ecZ24MaQKiIlHms6tQS1dbcTzyqiz01XAKCEYlKnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQLT/1Rn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQLT/1Rn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67D31F00A3A;
	Wed, 29 Jul 2026 19:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352072;
	bh=SeV2jVonekRjHxFpY3+cKF8dakpiLh8ELDhbPc7eYfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oQLT/1RnlX++RtzUsWWO0XBzAJYmiOc2YjLe3MBVQutcw04Bb8f/+dZN9De9dllyz
	 xo+WABaHGlca5h1YvFoeviJTlZqNZEyRif9YIdDtFI16YJgVL8dokA4zPhaDKlwUFq
	 VsWAadbUGlO3xnhYAifmpIQt+p987WkPqEYtGS2Q8GDZMzNbPdmav0AgVyG9zkuiH0
	 haENkw5um5rVJFQzYEJXrN9lFFkOpHTmQFlhpJ74NdDS7xJ3H2lTZFFZdTvSgZ/aNU
	 zeXlncKbNHlt7iSX3ixamoCejGwqgpC08DgU4h6oonSLzxVyY+RJjvTU59L2sf2Gll
	 Rlc/H1MfEvIvg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/31] ctf_loader, libctf: Fix error path resource leaks
Date: Wed, 29 Jul 2026 16:07:06 -0300
Message-ID: <20260729190733.72876-7-acme@kernel.org>
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

Three resource leaks in CTF loading error paths:

1. ctf__load_file(): if cu__new() returns NULL, the ctf state allocated
   by ctf__new() is leaked.  Add ctf__delete(state) before returning.

2. ctf__load_file(): if ctf__load() fails, both cu and state are
   leaked.  Since cu->priv = state and cu->dfops = &ctf__ops are
   already set, cu__delete(cu) will invoke ctf__cu_delete() which
   calls ctf__delete(), cleaning up both.

3. ctf__decompress(): if inflate() fails after inflateInit() succeeded,
   the zlib internal decompression state is leaked because the err:
   path only frees the output buffer without calling inflateEnd().
   Add inflateEnd(&state) before the goto.

Fixes: 2dfa5fe6eab0c157 ("[DWARVES]: Initial CTF support")
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 ctf_loader.c | 8 ++++++--
 libctf.c     | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/ctf_loader.c b/ctf_loader.c
index 501c4abe859c0d52..39aef17893da5314 100644
--- a/ctf_loader.c
+++ b/ctf_loader.c
@@ -704,8 +704,10 @@ int ctf__load_file(struct cus *cus, struct conf_load *conf,
 		return -1;
 
 	struct cu *cu = cu__new(filename, state->wordsize, NULL, 0, filename, false);
-	if (cu == NULL)
+	if (cu == NULL) {
+		ctf__delete(state);
 		return -1;
+	}
 
 	cu->language = LANG_C;
 	cu->uses_global_strings = false;
@@ -713,8 +715,10 @@ int ctf__load_file(struct cus *cus, struct conf_load *conf,
 	cu->dfops = &ctf__ops;
 	cu->priv = state;
 	state->priv = cu;
-	if (ctf__load(state) != 0)
+	if (ctf__load(state) != 0) {
+		cu__delete(cu);
 		return -1;
+	}
 
 	err = ctf__load_sections(state, cu);
 
diff --git a/libctf.c b/libctf.c
index 0641b10586527a6e..8e31e3d550ebd51a 100644
--- a/libctf.c
+++ b/libctf.c
@@ -104,6 +104,7 @@ static int ctf__decompress(struct ctf *ctf, void *orig_buf, size_t orig_size)
 
 	if (inflate(&state, Z_FINISH) != Z_STREAM_END) {
 		err_str = "struct ctf decompression inflate failure.";
+		inflateEnd(&state);
 		goto err;
 	}
 
-- 
2.55.0

