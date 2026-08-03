Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E263B6C18
	for <dwarves@vger.kernel.org>; Mon,  3 Aug 2026 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761727; cv=none; b=RB/+do41FGC64FyQ44EUzaSS1R4Jv+TG4f64aogw1LXGfVRlNDYGzGm2pvYp6Dy2lzgIglJgAy2sbsmqaQNVZmdJKzjgUEWPL7SMB4SYF53/oeixt56THQvIg0ZPorvA8BtNft18pBeFfoheYW/67ST2clo4WN4aT+ytmdI+Mek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761727; c=relaxed/simple;
	bh=DBK2U0Fw8mNaQ7z9CPkbfPCO3ANYFttPj5gy23CUJRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AVl+XsLAyjF1DyFSd3fiXL6W5igLoU1MKblKBXE2DW36dqb6g7oWvp46mdsuWf0M0JmJ2zBVO7yF1jvwVk41ATsSzuc1wcUo1N1eNvxgoc/DwNsSLRZwmJB5EPL63YwHcnToEfoROyZRg0CVBJ1knvfmxyj4O4Xted5Jz8Z9HSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=peTNcuEG; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="peTNcuEG"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495459712d2so3583005e9.1
        for <dwarves@vger.kernel.org>; Mon, 03 Aug 2026 05:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785761723; x=1786366523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xbThS1PrxyBxNcEQm80yHHaj46Ueb887tHYIj0MKP9U=;
        b=peTNcuEGqn19yJF8AKo5xM3OmmQAXMneqflzn9XU1Z1vYfKBjGLE7ORlPx7nQuPGeA
         +G9pqxgBDc1RAiIRKZjT91nxNpksrluBSh5X4SNKdBvbx6z6Sro+9VtUpFYD66ts5M/j
         A1IS4hkLw2hko611MTZGAZDce9G5sSmUvRwc7pJYcOTz75XRRcSDwWLqn0u94szksv6K
         B/FysXIN3y13uxyjiXGKdt/Q14ZYCSFw5p1o+uTVp9JVuyUIjNbHEhn2+H6vo5G11J/T
         6XTBwvvd2tMDfxq8Qpa6ZoYEckF2keUjtLsubo+dutag1XXaLwxyeZTMvY0banbuogBZ
         fADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785761723; x=1786366523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xbThS1PrxyBxNcEQm80yHHaj46Ueb887tHYIj0MKP9U=;
        b=SdLULkPvVPhNWk4Hw5TiuUNhHx66K3uJ3znM0L1y74I3gmp1N4o79eaFM9E0xocvwP
         W8YrPk4rHxNA25PTWQSAgBv+tbvK8o+aBqWRqWswq0zB4eP6VBc7O5VnJvr0VEalZFlW
         QkJ/uO1901347GHBZ8mLOIdFcxwIxLarNXqUmcsdxbtAfTcdBKWBfbB/7hNps0i93NS3
         elZyFlMM+fk4L53IAACPZ33LLdOIUZAY0SrXtC0sJCvCr5/KFNk9d+Radh7yAjuL3Y8r
         h4hPEmkmjVi9ZekUUTSUvOSW7YqjZddUZngYo8G+FRByurOZ4j2ezC6O5g/z1z/qruFF
         jCxA==
X-Forwarded-Encrypted: i=1; AHgh+RrT5fsUEgmLaGjxKc6LllIzIn6x7LIqcLWrb0Hh9E5g5L/fz/NAnFnO8a1ZL8Mu1Jn5ER4EXE3U@vger.kernel.org
X-Gm-Message-State: AOJu0YwmcyhSV4RxEarkZ9V/LdF9bGSGYOqBksYuC42buZHWwAyTTUcF
	emgxPXRg/2N1qDqabatvWNN9npjBcFHV6oDw4C4ey7S6/b/ZvLXKWolI
X-Gm-Gg: AR+sD13qYXAtxLHJLlJ89264YetDRgco0qU1bb/GPBYkE3D00BbcqfZUiL8GzcZs4rU
	WCgIj1qyc6X5t3aFLN1L3Mz5zt6fzg/h+soiJE+tPHZpLdYYVQNq3OC9z32Mq8GXfCydDtv3Yi+
	Lug/4W0S0l4JMidUupUa+i9uGdYqLko1zz96VrfAOMuUPJV6nPWCP2oqI6g9P47M0yAxHe1MBzd
	fRCOTQ7JpKafsrW3rYG4OHtdZkqORqIZ5Bat3SVzYLbSsdKD8FdQqZW3Y0vIldN5fO0NeGdoo0r
	9fe7NDkgEI6cNwEK5f3w11FDZxWaVil2DicbV3H6pxmxtZO0GkJCkwTEllnWIez9dP0AR4xSICp
	iMBJIMM/hnwBgOTjjGpLg4kWxKyjX5SYjURpCkjEQJNM2EYCiibAd67icKTsSzc6W5qYN/V5cbF
	T7ht5OaLTIpty8bJ0Bu2q6vahnfobcTusmxF0NR9PvN4uEKNJglF2bAOtTkuA+O9wo9nLpI/H6R
	RbSCG7jcQt5uE6T6xGA6ppUXocUh4V1in5wNhqvYwgWACDN5gwS3GSmhfY+yQ9wP8cdbS3nLgKT
	pS9SbPEgyxrXXc+BlhDcO0No+p4p3hfQpjbCFg==
X-Received: by 2002:a05:600c:214d:b0:495:3e08:ad19 with SMTP id 5b1f17b1804b1-4980c653c0cmr162429085e9.9.1785761722771;
        Mon, 03 Aug 2026 05:55:22 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808690ffbsm258552165e9.10.2026.08.03.05.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 05:55:22 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH dwarves] btf_encoder: Infer arena kfunc arguments from suffixes
Date: Mon,  3 Aug 2026 14:55:18 +0200
Message-ID: <20260803125518.2279340-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel verifier recognizes __arena and __arena_nullable parameter
suffixes for registered kfuncs. These arguments need the matching
address_space(1) BTF type attribute so bpftool emits usable declarations.

Extend the existing KF_ARENA_ARG1/2 handling to select arguments by either
the legacy flag or either suffix. Iterate over all parameters, allowing the
suffix convention at any argument position and avoiding duplicate tags when
a flag and suffix select the same argument.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 btf_encoder.c | 38 ++++++++++++++++++++++++++++----------
 dutil.h       | 13 +++++++++++++
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 4b422e09800f..07ca4f41ac32 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -42,6 +42,8 @@
 #define BTF_KFUNC_TYPE_TAG	"bpf_kfunc"
 #define BTF_FASTCALL_TAG       "bpf_fastcall"
 #define BPF_ARENA_ATTR         "address_space(1)"
+#define BPF_ARENA_SUFFIX       "__arena"
+#define BPF_ARENA_NULLABLE_SUFFIX "__arena_nullable"
 
 /* kfunc flags, see include/linux/btf.h in the kernel source */
 #define KF_FASTCALL   (1 << 12)
@@ -808,12 +810,32 @@ static int btf__tag_bpf_arena_arg(struct btf *btf, struct btf_encoder_func_state
 	return id;
 }
 
-/* Modifies state->ret_type_id and state->parms[i].type_id for flagged kfuncs */
+static bool btf__is_bpf_arena_arg(const struct btf *btf,
+				  const struct btf_encoder_func_state *state, int idx)
+{
+	uint32_t flags = state->elf->kfunc_flags;
+	const char *name;
+	size_t name_len;
+
+	if ((idx == 0 && (flags & KF_ARENA_ARG1)) ||
+	    (idx == 1 && (flags & KF_ARENA_ARG2)))
+		return true;
+
+	name = btf__name_by_offset(btf, state->parms[idx].name_off);
+	if (!name)
+		return false;
+	name_len = strlen(name);
+	return (name_len > sizeof(BPF_ARENA_SUFFIX) - 1 && strends(name, BPF_ARENA_SUFFIX)) ||
+	       (name_len > sizeof(BPF_ARENA_NULLABLE_SUFFIX) - 1 &&
+		strends(name, BPF_ARENA_NULLABLE_SUFFIX));
+}
+
+/* Modifies state->ret_type_id and state->parms[i].type_id for arena kfuncs */
 static int btf__add_bpf_arena_type_tags(struct btf *btf, struct btf_encoder_func_state *state)
 {
 	uint32_t flags = state->elf->kfunc_flags;
 	int ret_type_id;
-	int err;
+	int err, i;
 
 	if (!btf__add_type_attr) {
 		fprintf(stderr, "btf__add_type_attr is not available, is libbpf < 1.6?\n");
@@ -830,14 +852,10 @@ static int btf__add_bpf_arena_type_tags(struct btf *btf, struct btf_encoder_func
 		state->ret_type_id = ret_type_id;
 	}
 
-	if (KF_ARENA_ARG1 & flags) {
-		err = btf__tag_bpf_arena_arg(btf, state, 0);
-		if (err < 0)
-			return err;
-	}
-
-	if (KF_ARENA_ARG2 & flags) {
-		err = btf__tag_bpf_arena_arg(btf, state, 1);
+	for (i = 0; i < state->nr_parms; i++) {
+		if (!btf__is_bpf_arena_arg(btf, state, i))
+			continue;
+		err = btf__tag_bpf_arena_arg(btf, state, i);
 		if (err < 0)
 			return err;
 	}
diff --git a/dutil.h b/dutil.h
index 603556fa0308..d55d01abc842 100644
--- a/dutil.h
+++ b/dutil.h
@@ -335,6 +335,19 @@ static inline bool strstarts(const char *str, const char *prefix)
 	return strncmp(str, prefix, strlen(prefix)) == 0;
 }
 
+/**
+ * strends - does @str end with @suffix?
+ * @str: string to examine
+ * @suffix: suffix to look for.
+ */
+static inline bool strends(const char *str, const char *suffix)
+{
+	size_t str_len = strlen(str);
+	size_t suffix_len = strlen(suffix);
+
+	return suffix_len <= str_len && strcmp(str + str_len - suffix_len, suffix) == 0;
+}
+
 void *zalloc(const size_t size);
 
 Elf_Scn *elf_section_by_name(Elf *elf, GElf_Shdr *shp, const char *name, size_t *index);
-- 
2.53.0

