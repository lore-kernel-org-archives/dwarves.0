Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2D0271A6D
	for <dwarves@vger.kernel.org>; Thu,  7 Aug 2025 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754591163; cv=none; b=cE6kHobvAPx3JCDrO2fd+HsQFQW/slYvfpfJbRGAWM6IRMVD3Vxb9LmZBDmf4xICfsJ206FBub/VayqV3+Rr/55/pPnHKSRuDLG2p+zBg+ICq5DXXVobOzEvqCwnghMZdFe2p5CESUKXOrNunZrwHOydDZEJPMgfv3ya+9hT/fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754591163; c=relaxed/simple;
	bh=AX2ElA1XJut9tChoWz3O7MvrT9ZGBjcDQGz6BbPmhxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgrwL+4EUv5PNjQSdseslsVKvod8/sFRjzmMAA73RK/neCa6CyFTIKrfjIULQhTeOa3+oZMyM053QK5BRXY2dl9IJsgIY54o2CrtqPf+yFCa7CIv71tGDs2UtE5It6C1ZsvTrDX+l8OarSkGObBVUpHEdonUPEUQPQ0k4SthwuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozwaPsur; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozwaPsur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD21C4CEEB;
	Thu,  7 Aug 2025 18:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754591163;
	bh=AX2ElA1XJut9tChoWz3O7MvrT9ZGBjcDQGz6BbPmhxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ozwaPsur5GiBTOz3flEDgWYRnkYDJkFR1hOH2ekaeCJzdG0YdKqRcAwoOYBll5rii
	 jL86J56GFnuB4ug7JYTkU7fC+K/vWTNrDDrDTcK+JSYkXSjlUyCYR0KXHuaRdM4Z1o
	 jFZ5i6TeCQfX81z1+q4+SI89weuOi847csdSI+4srhenbFd+34eaF9PZ1+ED6R9z2d
	 71yrh0T7rFDuKhn2Dd+mcXyPN1QjnBDaoQ0EfYoWor/h+dkuj/07X3OKcgPL7R6wy/
	 MNDy3xbZoJUwutOgVnGclwWA4z570ZK/Fqygqo/K1SYapW0gf1gSGF+eoLJDdTNY09
	 mGpekPQeVvNxw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Nick Alcock <nick.alcock@oracle.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH 3/4] libbpf: Add support for detecting and dedup'ing a BTF archive
Date: Thu,  7 Aug 2025 15:25:37 -0300
Message-ID: <20250807182538.136498-4-acme@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250807182538.136498-1-acme@kernel.org>
References: <20250807182538.136498-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As defined by being a series of BTF raw_data concatenated that then
are combined using btf__add_btf() to then be passed to btf__dedup().

This is a simpler interface, a more involved one, maybe for pahole
would involve doing the same approach as for encoding BTF from DWARF:
create a series of threads that would load the BTF archive in parallel
to then dedup it.

Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nick Alcock <nick.alcock@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/bpf/btf.c | 38 ++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/btf.h |  3 +++
 2 files changed, 41 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index ee45d461d53bea9a..73a6d94eeda125e1 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1127,6 +1127,44 @@ struct btf *btf__new(const void *data, __u32 size)
 	return libbpf_ptr(btf_new(data, size, NULL, false));
 }
 
+bool btf__is_archive(const struct btf *btf)
+{
+	return btf->extra_raw_data;
+}
+
+int btf__dedup_archive(struct btf *btf, const void *data, __u32 size, const struct btf_dedup_opts *opts)
+{
+	__u32 raw_size = btf->raw_size;
+	struct btf *brother;
+	int err = 0;
+
+	while (size > raw_size) {
+		data += raw_size;
+		size -= raw_size;
+		brother = btf_new(data, size, btf->base_btf, btf->raw_data_is_mmap);
+
+		if (IS_ERR(brother)) {
+			err = PTR_ERR(brother);
+			pr_debug("%s: __btf_new() failed! %d\n", __func__, err);
+			goto out;
+		}
+
+		if (btf__add_btf(btf, brother) < 0) {
+			err = -errno;
+			pr_debug("%s: btf__add_btf() failed: %d(%s)!\n", __func__, errno, strerror(errno));
+			btf__free(brother);
+			goto out;
+		}
+
+		raw_size = brother->raw_size;
+		btf__free(brother);
+	}
+
+	err = btf__dedup(btf, opts);
+out:
+	return libbpf_err(err);
+}
+
 struct btf *btf__new_split(const void *data, __u32 size, struct btf *base_btf)
 {
 	return libbpf_ptr(btf_new(data, size, base_btf, false));
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index ccfd905f03dfe7b6..71a6b8e037f5c98b 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -258,6 +258,9 @@ struct btf_dedup_opts {
 #define btf_dedup_opts__last_field force_collisions
 
 LIBBPF_API int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts);
+LIBBPF_API int btf__dedup_archive(struct btf *btf, const void *data, __u32 size,
+				  const struct btf_dedup_opts *opts);
+LIBBPF_API bool btf__is_archive(const struct btf *btf);
 
 /**
  * @brief **btf__relocate()** will check the split BTF *btf* for references
-- 
2.50.1

