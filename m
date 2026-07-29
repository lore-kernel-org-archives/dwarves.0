Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18211463B98;
	Wed, 29 Jul 2026 19:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352093; cv=none; b=WPrWUaSl8oYBIh6fDHH9YBI0+6+eXqR7AJHQnfNP+8fI9vuB7DpK1IsuFahgYr9uSp2A8TCoOE9GmZ3Nkqb6FXbTNH6Gr1eDR90WGHUkgWan1gRPqPlzt6PNotSRBdFby7viae4LRl8MEFipCRVavz7iTNTlAJPwTN0BVfJn5Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352093; c=relaxed/simple;
	bh=ijMrEc3jRxdopD0BUV4yGbwZ7Fas7euazSWquoEYYBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZn3pMAOktvX5KrP/qck0FqhHab3WlmB2nL0jmi3h/3BEGOs832Q2YSo8TvMDIffk1HFYNgxLfSqpBUmlAImkEmRCF1qTOCC6u+Eb5XLE7r1Ym8/uWq0WrGlJhQt/JdalmY/OIsO9iPgaGzRlMZhcHTtkTH8icfO467BWZvJ1JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVO8Bu1g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVO8Bu1g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5D91F00A3A;
	Wed, 29 Jul 2026 19:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352090;
	bh=WTqiZLN2d5Dd/OcK7PWCaNfUPPAI/D6p0LCSnV4KmVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bVO8Bu1gN0ioKvvEKffgsAsF+Qltrp1B3DqBN4FCCGkPF0IlmSVSXP66mdNGm7Bc8
	 OiTjkSM+sN4Q0alxbKklxck1sH8YSqNJBir/WMsqLUNeL/nG9dnU5Jy9D6RqeLDOUH
	 3qxn4cKAghBRIQf81ReJeOQcggNSrtRqvYwKCxX6vG8x2832zeq3+qyLJ66Dw65OYO
	 BbP53dzJ4KWdfDCL8kwPaIck1XQ7Z/5/E5WVQTLd8kLUweWVzgY2QOsRJdkw+d++Q/
	 8lqQPRVTstSQO2bQYtrazxa+A8bunJU5zff7u26jkG/52tjRMJo4oeKyBC1/mJEdye
	 F9TR5JO7Fdh4A==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/31] btf_encoder, libctf: Add elf_strptr NULL checks and fix kfunc bounds
Date: Wed, 29 Jul 2026 16:07:14 -0300
Message-ID: <20260729190733.72876-15-acme@kernel.org>
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

Several elf_strptr() calls in btf_encoder and libctf lacked NULL checks,
which would cause segfaults on malformed ELF files:

1. btf_encoder__new(): strcmp(secname, PERCPU_SECTION) crashes if
   elf_section_by_idx() returns a valid section but elf_strptr() fails
   internally.

2. btf_encoder__collect_kfuncs(): two elf_strptr() calls for symbol
   names passed to strstarts()/get_func_name() without NULL guards.

3. libctf.c ctf__encode(): strcmp(secname, ".SUNW_ctf") without
   NULL check.

Also fix is_sym_kfunc_set() bounds check: the original `off >= d_size`
only verified the start offset, but accessing set->flags could read
past the buffer.  Changed to `off + sizeof(*set) > d_size` and added
an `off < 0` guard to prevent signed-to-unsigned wraparound when the
symbol address is below the section base.

Before: malformed ELF with invalid string table causes SIGSEGV
After: gracefully skips bad entries

Fixes: 72e88f29c6f7e142 ("pahole: Inject kfunc decl tags into BTF")
Fixes: ff34e733a0c23bf4 ("btf_encoder: Allow encoding VARs from many sections")
Fixes: dcef613288086156 ("libctf: give up "for now" on using libelf to add a section to an existing file")
Reported-by: Sashiko:gemini-3-1-pro-preview
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 btf_encoder.c | 10 ++++++----
 libctf.c      |  2 +-
 pahole.c      | 14 +++++++++++---
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 5c12e79f5ef648ba..c7b71b5b741bfa6f 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2099,14 +2099,14 @@ static int is_sym_kfunc_set(GElf_Sym *sym, const char *name, Elf_Data *idlist, s
 {
 	void *ptr = idlist->d_buf;
 	struct btf_id_set8 *set;
-	size_t off;
+	ptrdiff_t off;
 
 	/* kfuncs are only found in BTF_SET8's */
 	if (!strstarts(name, BTF_ID_SET8_PFX))
 		return false;
 
 	off = sym->st_value - idlist_addr;
-	if (off >= idlist->d_size) {
+	if (off < 0 || (size_t)off + sizeof(*set) > idlist->d_size) {
 		fprintf(stderr, "%s: symbol '%s' out of bounds\n", __func__, name);
 		return false;
 	}
@@ -2276,7 +2276,7 @@ static int btf_encoder__collect_kfuncs(struct btf_encoder *encoder)
 			continue;
 
 		name = elf_strptr(elf, strtabidx, sym.st_name);
-		if (!is_sym_kfunc_set(&sym, name, idlist, idlist_addr))
+		if (name == NULL || !is_sym_kfunc_set(&sym, name, idlist, idlist_addr))
 			continue;
 
 		range.start = sym.st_value;
@@ -2305,6 +2305,8 @@ static int btf_encoder__collect_kfuncs(struct btf_encoder *encoder)
 			continue;
 
 		name = elf_strptr(elf, strtabidx, sym.st_name);
+		if (name == NULL)
+			continue;
 		func = get_func_name(name);
 		if (!func)
 			continue;
@@ -2879,7 +2881,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 			if (encoder->encode_vars & BTF_VAR_GLOBAL)
 				encoder->secinfo[shndx].include = true;
 
-			if (strcmp(secname, PERCPU_SECTION) == 0) {
+			if (secname != NULL && strcmp(secname, PERCPU_SECTION) == 0) {
 				found_percpu = true;
 				if (encoder->encode_vars & BTF_VAR_PERCPU)
 					encoder->secinfo[shndx].include = true;
diff --git a/libctf.c b/libctf.c
index 8e31e3d550ebd51a..72f9949a2d25b3d9 100644
--- a/libctf.c
+++ b/libctf.c
@@ -674,7 +674,7 @@ int ctf__encode(struct ctf *ctf, uint8_t flags)
 		if (shdr == NULL)
 			continue;
 		char *secname = elf_strptr(elf, strndx, shdr->sh_name);
-		if (strcmp(secname, ".SUNW_ctf") == 0) {
+		if (secname != NULL && strcmp(secname, ".SUNW_ctf") == 0) {
 			data = elf_getdata(scn, data);
 			goto out_update;
 		}
diff --git a/pahole.c b/pahole.c
index 6ba3f578c28570a1..0e2acc35d6d679f0 100644
--- a/pahole.c
+++ b/pahole.c
@@ -2361,6 +2361,11 @@ static int pipe_seek(FILE *fp, off_t offset)
 			chunk = offset;
 	}
 
+	/* On EOF (not I/O error), clear errno so callers don't
+	 * pick up a stale value from an earlier successful fread. */
+	if (!ferror(fp))
+		errno = 0;
+
 	return offset == 0 ? 0 : -1;
 }
 
@@ -2583,8 +2588,9 @@ static int prototype__stdio_fprintf_value(struct prototype *prototype, struct ty
 	if (instance == NULL)
 		return -ENOMEM;
 
+	errno = 0;
 	if (type__instance_read_once(header, input) < 0) {
-		printed = -errno;
+		printed = errno ? -errno : -EIO;
 		fprintf(stderr, "pahole: --header (%s) type couldn't be read\n", conf.header_type);
 		goto out;
 	}
@@ -2666,8 +2672,9 @@ static int prototype__stdio_fprintf_value(struct prototype *prototype, struct ty
 
 		free(member_name);
 
+		errno = 0;
 		if (pipe_seek(input, seek_bytes) < 0) {
-			printed = -errno;
+			printed = errno ? -errno : -EIO;
 			fprintf(stderr, "Couldn't --seek_bytes %s (%" PRIu64 "\n", conf.seek_bytes, seek_bytes);
 			goto out;
 		}
@@ -2717,8 +2724,9 @@ static int prototype__stdio_fprintf_value(struct prototype *prototype, struct ty
 			seek_bytes -= ftell(input);
 		}
 
+		errno = 0;
 		if (pipe_seek(input, seek_bytes) < 0) {
-			printed = -errno;
+			printed = errno ? -errno : -EIO;
 			fprintf(stderr, "Couldn't --seek_bytes %s (%" PRIu64 "\n", conf.seek_bytes, seek_bytes);
 			goto out;
 		}
-- 
2.55.0

