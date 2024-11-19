Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5E51CCB41
	for <dwarves@vger.kernel.org>; Tue, 19 Nov 2024 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732023657; cv=none; b=ZzP89Dvp3GQ4RBXk7ROjnK3dulacK24wayJ9/nSGhaox/d2bsTWnVr8K463Ld9o90+4Wz40gjUvvtq6J+xU9BpR9rqA7iD+yMXcKXnrgN5sqFgJ7rjgP9SrSm1CGYo7M43mp/C+YWOC1UYHITkxN1ic+IDJXm8AWJK6ew27ZIOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732023657; c=relaxed/simple;
	bh=ZZoEabNET8LhYmfgr9C8d3HWbYtXZ0zIhsoCjTyIlwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukgZjBt+U8WIBlFVpSTUF9XKsiqApoDvG3vWHtZwMYBl8hcLRIuaYEaTMFYon9ZMqyp9eXEMUo5mfKLQYH8qU/TFapmCrkKwD6mkmEVeGq8dVW+6EOj5xcj24axyi3yweSK6Mb4q8Vs1Ja8sMm7uko4GwPnkGjKzFHDnRhAYgYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyKP8nhU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyKP8nhU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C78C4CED2;
	Tue, 19 Nov 2024 13:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732023657;
	bh=ZZoEabNET8LhYmfgr9C8d3HWbYtXZ0zIhsoCjTyIlwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uyKP8nhUI6BVxwmdtesIth1PWmpBi9rQersfDWmS9ZRAFnbBko0FvcONaKg+9AQ75
	 /3ABw4A5YKnVK1lk2U3c2EScSGXobXsCsB9Ka5RZZ5ypHyRNVHMgYpBDKymAY3imlU
	 HhV2i5Z9LtKcS1gVfcNm6hzCnxHLjos+cfJiHQ0dyXS5M6zCjDoygZMPRTu6Dt80pS
	 ZL+nUaAxoMYHwWZ82DhtwudH+Joq6q0yFxUAXy+lOuK4WO8N2poluCfxLZWUioc0Hh
	 x/CaYacLvWbivjpiE9YDbFakxgG8sTN9F6hdi35K/Rdd0UpvGtOa890vooSTlU7d9z
	 JxAUuJG4eJlZQ==
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
Subject: [PATCH 3/5] pahole: Honour exclusive BTF loading
Date: Tue, 19 Nov 2024 10:40:30 -0300
Message-ID: <20241119134032.783215-4-acme@kernel.org>
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

When we specify 'btf' and BTF info is available in the system, in the
/sys/kernel/btf/vmlinux file, pahole will find it and use it to get the
type information asked for:

  root@x1:~# perf trace -o /tmp/output -e openat pahole -F btf list_head ; tail -1 /tmp/output
  struct list_head {
  	struct list_head *         next;                 /*     0     8 */
  	struct list_head *         prev;                 /*     8     8 */

  	/* size: 16, cachelines: 1, members: 2 */
  	/* last cacheline: 16 bytes */
  };

       1.579 ( 0.010 ms): pahole/764777 openat(dfd: CWD, filename: "/sys/kernel/btf/vmlinux", flags: RDONLY|CLOEXEC) = 3
  root@x1:~#

But, if the system doesn't have BTF info, which we now can simulate by using an
environment variable it is tryng DWARF after failing for BTF, which isn't what
the user asked for having specified just btf in the -F pahole command line:

  root@x1:~# export PAHOLE_VMLINUX_BTF_FILENAME=non-existent
  root@x1:~# perf trace -o /tmp/output -e openat,access pahole -F btf list_head ; tail -12 /tmp/output
  struct list_head {
  	struct list_head *         next;                 /*     0     8 */
  	struct list_head *         prev;                 /*     8     8 */

  	/* size: 16, cachelines: 1, members: 2 */
  	/* last cacheline: 16 bytes */
  };

  1.643 ( 0.003 ms): pahole/765220 access(filename: "list_head", mode: R)      = -1 ENOENT (No such file or directory)
  1.658 ( 0.002 ms): pahole/765220 access(filename: "non-existent", mode: R)   = -1 ENOENT (No such file or directory)
  1.697 ( 0.018 ms): pahole/765220 openat(dfd: CWD, filename: "/sys/kernel/notes") = 3
  1.801 ( 0.004 ms): pahole/765220 openat(dfd: CWD, filename: "vmlinux")       = -1 ENOENT (No such file or directory)
  1.807 ( 0.005 ms): pahole/765220 openat(dfd: CWD, filename: "/boot/vmlinux") = -1 ENOENT (No such file or directory)
  1.927 ( 0.005 ms): pahole/765220 openat(dfd: CWD, filename: "/usr/lib/debug/lib/modules/6.11.6-200.fc40.x86_64/vmlinux", flags: RDONLY|CLOEXEC) = 3
  root@x1:~#

So honour the request and fails when just BTF is asked and no BTF file is
found:

  # export PAHOLE_VMLINUX_BTF_FILENAME=non-existent
  # pahole -F btf list_head
  pahole: couldn't find any btf debug information on this system.
  #

Reported-by: Matthias Schwarzott <zzam@gentoo.org>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarves.c | 15 +++++++++++++--
 pahole.c  |  9 ++++++++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/dwarves.c b/dwarves.c
index 5b51b55191177e21..459311e64c8b45b2 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -2944,9 +2944,17 @@ const char *vmlinux_path__find_running_kernel(void)
 static int cus__load_running_kernel(struct cus *cus, struct conf_load *conf)
 {
 	int err = 0;
+	bool btf_only = false;
 
-	if ((!conf || conf->format_path == NULL || strncmp(conf->format_path, "btf", 3) == 0) &&
-	    access(vmlinux_path__btf_filename(), R_OK) == 0) {
+	if (!conf || conf->format_path == NULL)
+		goto try_btf;
+
+	if (!strstr(conf->format_path, "btf"))
+		goto try_elf;
+
+	btf_only = strcmp(conf->format_path, "btf") == 0;
+try_btf:
+	if (access(vmlinux_path__btf_filename(), R_OK) == 0) {
 		int loader = debugging_formats__loader("btf");
 		if (loader == -1)
 			goto try_elf;
@@ -2958,6 +2966,9 @@ static int cus__load_running_kernel(struct cus *cus, struct conf_load *conf)
 			return 0;
 	}
 try_elf:
+	if (btf_only)
+		return -1;
+
 	elf_version(EV_CURRENT);
 	vmlinux_path__init();
 
diff --git a/pahole.c b/pahole.c
index b94cb1a979a6923d..fa5d8c707bd4717d 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3782,7 +3782,14 @@ try_sole_arg_as_class_names:
 			remaining = argc;
 			goto try_sole_arg_as_class_names;
 		}
-		cus__fprintf_load_files_err(cus, "pahole", argv + remaining, err, stderr);
+		if (argv[remaining] != NULL) {
+			cus__fprintf_load_files_err(cus, "pahole", argv + remaining, err, stderr);
+		} else {
+			fprintf(stderr, "pahole: couldn't find any%s%s debug information on this system.\n",
+					conf_load.format_path ? " " : "",
+					conf_load.format_path ?: "");
+		}
+
 		goto out_cus_delete;
 	}
 
-- 
2.47.0

