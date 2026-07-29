Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4331D488DAF;
	Wed, 29 Jul 2026 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352124; cv=none; b=WpH84yvdU8Bd+sqQvEtr3X/vxbH+5ulLSBYw+9kQ/mARLsYyHF6M+Q8eLdBiULzZCsjeD5PsLca/DuWrEP+ycMvyLMIUGlt5Wrn+cd7QFdPbJeBeyTQxD7XxFzT7JkEZQ9MqGZyDUQY6TCQQn9cGDScuAxC4ShiURZRJihDndXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352124; c=relaxed/simple;
	bh=ek7igLRuTeTaPfBrGIqSB/ZUSc8tyC9ASwhtnPFx3IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I58iJ/R/6yL3eQKUFnsZCiBuUb4Oxe/dFnfwS+wav4lyF2+YuVXRaAF3LAlzvb05WfYuMEYKrk3jCIPr9UlUvAfFjh19WHwvFpPH4hFzVTmDWmL5903DVS7vUiiVngj4txg4neuad7v9x0CnB8g1d/zY5frUXmkFuR7S3CTzrCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LacV374X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LacV374X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098E01F00A3A;
	Wed, 29 Jul 2026 19:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352122;
	bh=WqryJtY0IB4qBPHIDxlsZ8HfEv3Glh1w++Q1o2wp5Bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LacV374Xz6qQHgdrZsQEvM6luydF5Wu1PiVE1FHvBAH7+hK1Kv5iOEPfjPCAaaG03
	 t0mUNCkUYi4EZgCKXENlEuNDe773yL1uRC5A9UomCtepzerQq06jyqx7w8Bj6wB2t3
	 51LIiSyGGIiJ4/c4yUD3/LWheCzhredwwy5vM4GQflkelnFJNdjRhvvW9F0KLAkkPT
	 fKb60MMP94HLzBkRFDToI6Tf5s1spC+B1EkZkkDvXc4cx8AQGrTMdVeIDiSHJRJV5a
	 9lbYs4OWd1RH1sO+WBlhaiIu6u0YJv95IjVWccHFHMM8Vk9ZPfvsbpF3JXinKYTlYj
	 qCSg0ei1RGdQA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 28/31] pfunct, dwarves_fprintf: Mark file-local functions as static
Date: Wed, 29 Jul 2026 16:07:28 -0300
Message-ID: <20260729190733.72876-29-acme@kernel.org>
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

Coverage analysis found 3 functions that were never declared in any
header and are only called within their own translation unit, yet
lacked the 'static' qualifier:

pfunct.c:
  elf_symtab__show:   introduced in 640bfd9679b4 ("pfunct: Introduce
                      --symtab", 2009), always local to the pfunct
                      executable.
  elf_symtabs__show:  introduced in the same commit, wrapper that
                      iterates elf_symtab__show over multiple files.

dwarves_fprintf.c:
  filename__read_int: introduced in 9f9588dc2bd8 ("fprintf: Add
                      alternative method for reading the data cacheline
                      size", 2021), only compiled on platforms without
                      _SC_LEVEL1_DCACHE_LINESIZE, only called by
                      cacheline_size() in the same file.

None were exported from shared libraries (pfunct is an executable;
filename__read_int is behind an #ifndef that evaluates to false on
Linux).  Adding 'static' lets the compiler warn if they ever become
truly dead and enables better inlining/optimization.

Before: 3 functions global without external callers
After:  3 functions properly marked static

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarves_fprintf.c | 2 +-
 pfunct.c          | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index e44ac05c3b9e7e73..d7edb0cb14a5b803 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -2242,7 +2242,7 @@ void cus__print_error_msg(const char *progname, const struct cus *cus,
 }
 
 #ifndef _SC_LEVEL1_DCACHE_LINESIZE
-int filename__read_int(const char *filename, int *value)
+static int filename__read_int(const char *filename, int *value)
 {
         char line[64];
         int fd = open(filename, O_RDONLY), err = -1;
diff --git a/pfunct.c b/pfunct.c
index 5a6dd59a1c7a30b1..237bd54ab9319b0f 100644
--- a/pfunct.c
+++ b/pfunct.c
@@ -426,7 +426,7 @@ static int cu_function_iterator(struct cu *cu, void *cookie __maybe_unused)
 	return 0;
 }
 
-int elf_symtab__show(char *filename)
+static int elf_symtab__show(char *filename)
 {
 	int fd = open(filename, O_RDONLY), err = -1;
 	if (fd < 0)
@@ -494,7 +494,7 @@ out_close:
 	return err;
 }
 
-int elf_symtabs__show(char *filenames[])
+static int elf_symtabs__show(char *filenames[])
 {
 	int i = 0;
 
-- 
2.55.0

