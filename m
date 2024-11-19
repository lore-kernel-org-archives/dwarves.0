Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97E01CCEDA
	for <dwarves@vger.kernel.org>; Tue, 19 Nov 2024 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732023649; cv=none; b=Ua1pgGl/4lmSMv/SSuakKEZHYG6SPGhQ4klMHTrIW/DvAuVGdh/ZBb6ywYvGXYHGZ9M3AfJvM6pe9Ajcq10w1ns7afHRINRHvBy4WqEB9ApD2U2bg5wOU0k9ZFVIXf/Sqwq6SXtotMxiM1v2tDpZjm2umdYahDdx52xA7CNWK8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732023649; c=relaxed/simple;
	bh=/o2l1dz7CsWt0w0RvFloUaI1VNrKl63BMO+xJ+xlNZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ge8sb5YgSylpMPAY7jqgw968zqPhEO57bpCxAR4V62S46543meL04e654ZKhdQj7Kf2CsWXSFFtwwnp5I4+fM7UGorgsP+9C034nag2udK3zXDnJ1unZQ+5w6XBvcdeoFI+e6WXlWCnKeHUYWWtjfYvLkb/bXp0I+YsnV/WKkRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UskqipKi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UskqipKi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7DEC4CECF;
	Tue, 19 Nov 2024 13:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732023649;
	bh=/o2l1dz7CsWt0w0RvFloUaI1VNrKl63BMO+xJ+xlNZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UskqipKimwqS1Y4lRqN7E4kWiVDzYoFxIUFGhXllSfAa6fraMzdSEB94kz9+Sqqq4
	 Srg5pZ4wLBmpD14sesuIc4gKuDShMKVOxzYVfp7WQnb40UhHumtQyhlV2bs0rVPv2/
	 YcfIvkhSRsCNTTXGaGVhaOxvWtI8kuuw8tSbrtzwLPh1fNFVmiW5DV+2pqU4rt0Q0n
	 4zNGmWQFLz2C3dVxSZyOr9LzZnpztM6N00IyoOfGS23pYBSuZ2tkUM1Ijth6N32UN4
	 cnkUoTHlYODU+lm0gsSiTYPb6wyAEcG77WUVP3HGAS6vccDXGp1KRIadflWr36OOjD
	 PNNQOauyxsrmQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH 1/5] core: Add method to get the vmlinux BTF filename, allow overriding it via env var
Date: Tue, 19 Nov 2024 10:40:28 -0300
Message-ID: <20241119134032.783215-2-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241119134032.783215-1-acme@kernel.org>
References: <20241119134032.783215-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In systems where BTF isn't available there were reports that the
simplest pahole call, without any args, segfaults.

To have a proper test before fixing this problem, allow overriding the
/sys/kernel/btf/vmlinux filename, so that even in systems with BTF we an
point it to a invalid location, making pahole think that there is no BTF
available and thus fallback to something that currently segfaults.

Using it:

  $ pahole list_head
  struct list_head {
  	struct list_head *         next;                 /*     0     8 */
  	struct list_head *         prev;                 /*     8     8 */

  	/* size: 16, cachelines: 1, members: 2 */
  	/* last cacheline: 16 bytes */
  };
  $
  $ PAHOLE_VMLINUX_BTF_FILENAME=foobar pahole list_head
  Segmentation fault (core dumped)
  $

Reported-by: Matthias Schwarzott <zzam@gentoo.org>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarves.c          | 17 +++++++++++++++--
 dwarves.h          |  2 ++
 man-pages/pahole.1 |  4 ++++
 pahole.c           |  2 +-
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/dwarves.c b/dwarves.c
index 14ba4f0c6dd7f90f..5b51b55191177e21 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -2807,6 +2807,19 @@ static int filename__sprintf_build_id(const char *pathname, char *sbuild_id)
 static int vmlinux_path__nr_entries;
 static char **vmlinux_path;
 
+const char *vmlinux_path__btf_filename(void)
+{
+	static const char *vmlinux_btf;
+
+	if (vmlinux_btf == NULL) {
+		vmlinux_btf = getenv("PAHOLE_VMLINUX_BTF_FILENAME");
+		if (vmlinux_btf == NULL)
+			vmlinux_btf = "/sys/kernel/btf/vmlinux";
+	}
+
+	return vmlinux_btf;
+}
+
 static void vmlinux_path__exit(void)
 {
 	while (--vmlinux_path__nr_entries >= 0)
@@ -2933,7 +2946,7 @@ static int cus__load_running_kernel(struct cus *cus, struct conf_load *conf)
 	int err = 0;
 
 	if ((!conf || conf->format_path == NULL || strncmp(conf->format_path, "btf", 3) == 0) &&
-	    access("/sys/kernel/btf/vmlinux", R_OK) == 0) {
+	    access(vmlinux_path__btf_filename(), R_OK) == 0) {
 		int loader = debugging_formats__loader("btf");
 		if (loader == -1)
 			goto try_elf;
@@ -2941,7 +2954,7 @@ static int cus__load_running_kernel(struct cus *cus, struct conf_load *conf)
 		if (conf && conf->conf_fprintf)
 			conf->conf_fprintf->has_alignment_info = debug_fmt_table[loader]->has_alignment_info;
 
-		if (debug_fmt_table[loader]->load_file(cus, conf, "/sys/kernel/btf/vmlinux") == 0)
+		if (debug_fmt_table[loader]->load_file(cus, conf, vmlinux_path__btf_filename()) == 0)
 			return 0;
 	}
 try_elf:
diff --git a/dwarves.h b/dwarves.h
index 49988f1cf9d45be8..1cb0d629f5265523 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -1628,6 +1628,8 @@ void dwarves__resolve_cacheline_size(const struct conf_load *conf, uint16_t user
 
 const char *dwarf_tag_name(const uint32_t tag);
 
+const char *vmlinux_path__btf_filename(void);
+
 const char *vmlinux_path__find_running_kernel(void);
 
 struct argp_state;
diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index bd28259b65429acc..39e7b465c64e7e2c 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -75,6 +75,10 @@ struct list_head {
 };
 $
 .fi
+It is possible to override the /sys/kernel/btf/vmlinux file location by setting
+the PAHOLE_VMLINUX_BTF_FILENAME environment variable. This may be useful for
+testing, scripting when using a different BTF for vmlinux. Used in the pahole
+regression tests.
 
 If BTF is not present and no file is passed, then a vmlinux that matches the
 build-id for the running kernel will be looked up in the usual places,
diff --git a/pahole.c b/pahole.c
index 55d04cf82a3da683..b94cb1a979a6923d 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3754,7 +3754,7 @@ try_sole_arg_as_class_names:
 		if (filename &&
 		    strstarts(filename, "/sys/kernel/btf/") &&
 		    strstr(filename, "/vmlinux") == NULL) {
-			base_btf_file = "/sys/kernel/btf/vmlinux";
+			base_btf_file = vmlinux_path__btf_filename();
 			conf_load.base_btf = btf__parse(base_btf_file, NULL);
 			if (libbpf_get_error(conf_load.base_btf)) {
 				fprintf(stderr, "Failed to parse base BTF '%s': %ld\n",
-- 
2.47.0

