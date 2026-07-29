Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FACA25B0BE;
	Wed, 29 Jul 2026 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352108; cv=none; b=rdx9c/JEKhfhCfsqIXhBO0gof0JvjmsveHxG6QNS7aySLWvVBa9XKTUhbDn6AtNdYWuOTwmCLEQJE9wMmYrAs9O0ReSH8HhUtBTT/RM/0ifiZ3OaK/DFMvDMaHPnDHhqoyR26XZbExdejS0OCOHsUcXGH8LOZiAUuAzo1QvQyZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352108; c=relaxed/simple;
	bh=gwvO+4GU4UZ8M7/g7cPHq9w7e0zKABDloYUXJyMcNEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hsm2fzlHgCPH7mqe1UFa4YxvCWHjLaMyQUzgEGaIqhus4h0H2BWfuZ2dlgAfzZaAMrqkDHHHHL7IqF1g9mZwZ9MCKLacxQW8VFWwmtFTW9mJt0Osj2WKe7/ov0j9wDitxQQTOCK6VwOLzl7pj8OAO+Es79MyEdjZPnD/Jqecn3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhCH0ls5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhCH0ls5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D4D1F000E9;
	Wed, 29 Jul 2026 19:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352107;
	bh=EK9UhGmn/LO4w4ic6lk2acBfo4w2MpPb0qvMHNR94MQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XhCH0ls5GvH83Vb0MQrlRIVFoUaF+0oCnO4qvEpJ4hQJ1NMVbCFSxXSsRXrKB0xQZ
	 mR6M1ddxW8gcrOIx5sGIWI27N7ntv6pbGTtMhMLoQotCeCP1MmF1DDd+eCCRXZpVka
	 K/ono36igmEEUkj/cnb2MlcbHozexnndQpc9pG4Gr1D2yvGq1aZ81thAc2mSfcP8YC
	 BpPVcsMNOBh9vt13777OMVmVLLvk8kVqRQe6ZNFTLTlriSYfoCMe2ZQUfs1DOJ6z5A
	 gay2q5weWhW1cKdjTNCq6o/EDhBg9r57mlHCsajH923LB5JRKlu1Y7ptT4iJKkJZqG
	 SMTIm/pADUAWg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 21/31] btf_encoder: Fall back to objcopy when llvm-objcopy is not available
Date: Wed, 29 Jul 2026 16:07:21 -0300
Message-ID: <20260729190733.72876-22-acme@kernel.org>
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

Switch btf_encoder and libctf from system() to exec_objcopy() (previous
commit).  Probe LLVM_OBJCOPY and OBJCOPY environment variables, falling
back to llvm-objcopy then objcopy path search.

Before: hard failure if llvm-objcopy not in PATH
After:  tries llvm-objcopy, falls back to objcopy, respects env vars

Reported-by: Sashiko:gemini-3-1-pro-preview # Running on a local machine
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 btf_encoder.c | 44 +++++++++++++++++++++++++++++++++-----------
 libctf.c      |  7 +++----
 2 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index c7b71b5b741bfa6f..c7ebaec4829d121a 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2049,13 +2049,19 @@ static int btf_encoder__write_elf(struct btf_encoder *encoder, const struct btf
 		else
 			elf_error("elf_update failed");
 	} else {
-		const char *llvm_objcopy;
+		const char *objcopy;
 		char tmp_fn[PATH_MAX];
-		char cmd[PATH_MAX * 2];
+		char add_section[PATH_MAX + 64];
 
-		llvm_objcopy = getenv("LLVM_OBJCOPY");
-		if (!llvm_objcopy)
-			llvm_objcopy = "llvm-objcopy";
+		/*
+		 * The kernel build uses $(OBJCOPY) --add-section for
+		 * BTF since v5.2 (2019), supporting both GNU objcopy
+		 * and llvm-objcopy interchangeably.  Prefer
+		 * llvm-objcopy, fall back to objcopy.
+		 */
+		objcopy = getenv("LLVM_OBJCOPY");
+		if (!objcopy)
+			objcopy = getenv("OBJCOPY");
 
 		/* Use objcopy to add a .BTF section */
 		snprintf(tmp_fn, sizeof(tmp_fn), "%s.btf", filename);
@@ -2073,14 +2079,30 @@ static int btf_encoder__write_elf(struct btf_encoder *encoder, const struct btf
 			goto unlink;
 		}
 
-		snprintf(cmd, sizeof(cmd), "%s --add-section %s=%s %s",
-			 llvm_objcopy, btf_secname, tmp_fn, filename);
-		if (system(cmd)) {
-			fprintf(stderr, "%s: failed to add %s section to '%s': %d!\n",
-				__func__, btf_secname, filename, errno);
-			goto unlink;
+		snprintf(add_section, sizeof(add_section), "%s=%s",
+			 btf_secname, tmp_fn);
+
+		if (!objcopy) {
+			int rc = exec_objcopy("llvm-objcopy",
+					      add_section, filename);
+			if (rc == 0)
+				goto success;
+
+			if (rc != -ENOENT) {
+				fprintf(stderr, "%s: failed to add %s section to '%s'\n",
+					__func__, btf_secname, filename);
+				goto unlink;
+			}
+
+			objcopy = "objcopy";
 		}
 
+		if (exec_objcopy(objcopy, add_section, filename)) {
+			fprintf(stderr, "%s: failed to add %s section to '%s'\n",
+				__func__, btf_secname, filename);
+			goto unlink;
+		}
+	success:
 		err = 0;
 	unlink:
 		unlink(tmp_fn);
diff --git a/libctf.c b/libctf.c
index 72f9949a2d25b3d9..51f75fbd66463506 100644
--- a/libctf.c
+++ b/libctf.c
@@ -746,10 +746,9 @@ found_SUNW_ctf_str:
 	if (close(fd) < 0)
 		goto out_unlink;
 
-	char cmd[PATH_MAX * 2];
-	snprintf(cmd, sizeof(cmd), "objcopy --add-section .SUNW_ctf=%s %s",
-		 pathname, ctf->filename);
-	if (system(cmd) == 0)
+	char add_section[PATH_MAX + 32];
+	snprintf(add_section, sizeof(add_section), ".SUNW_ctf=%s", pathname);
+	if (exec_objcopy("objcopy", add_section, ctf->filename) == 0)
 		err = 0;
 out_unlink:
 	unlink(pathname);
-- 
2.55.0

