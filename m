Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3361BF24
	for <dwarves@vger.kernel.org>; Tue, 19 Nov 2024 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732023665; cv=none; b=mrtPTC5h0hzrlrMUYdxAMxkaChlB45Ozgs0jD40oVhqhjdvYw1eiy/5Jm08VRvwqiEYp8yVo6ihIZvaZtH+KxdpMILy/CQAvUFUTsM8CmIffVDGWoWBNG102dkn0hk8YMWfid0lnNd1bssf6jzcJvrV+HS5gj3kOlkjdH/v99Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732023665; c=relaxed/simple;
	bh=OvpqhZ9jw7y/PogzRzVYV9d8USLYU4FulJSTOwKHxRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXQikmYp0lA64zld6GSZzB/thcf1OqOrzpX5WUiqi6wHfFVcK+strsPwAzjYKKWPG5+M4APbgE0tc1F/rwLvrJpLqRTujFD5/2TSg3R2YvBS8f7Gs9s6JXaPxNcX2ZGNwd0TkbwozUR7ZCzkmCSETLbNdQMUQwKXNqrlWzaZiDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wf+wf5/3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wf+wf5/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B84C4CECF;
	Tue, 19 Nov 2024 13:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732023665;
	bh=OvpqhZ9jw7y/PogzRzVYV9d8USLYU4FulJSTOwKHxRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wf+wf5/3SHOaMGprcCXbB68xhfVcs5++GDPPaJrA7mMEEHGIJjpqYJspafvjwZYIR
	 sgi3FSF9Zt1Xv87kbhmdFKNpBx7zcdyaSMvZzjlF0p2ggEl+ZtQEmguu01o9xsyCwY
	 BcDKajsbj4Rg7FO8ib5LnboW8fWcDaJSnQ08Tc6CS6RNshCc3vB6NWjXx/qrWiu1g+
	 s9D7tpoH+PR7qvGLY8jg2aCB8FBZyILBTajYIXk0hyreKxID3dRc2UOxZSPFsJrqlJ
	 cShL0dc1V3jG3NuwO+HgMtRv3wrwqViTGfNJDvjVs95j9VFbD6aa//Et32SLWhAHhO
	 ZspUZphP7NqPA==
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
Subject: [PATCH 5/5] core, libctf: Check if constructor arguments are NULL before using them
Date: Tue, 19 Nov 2024 10:40:32 -0300
Message-ID: <20241119134032.783215-6-acme@kernel.org>
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

  # pahole
  Segmentation fault (core dumped)
  #

Now we have:

  # ls -la bla
  ls: cannot access 'bla': No such file or directory
  # export PAHOLE_VMLINUX_BTF_FILENAME=bla
  # pahole
  pahole: couldn't find any debug information on this system.
  # pahole list_head
  pahole: couldn't find any debug information on this system.
  # pahole -F btf list_head
  pahole: couldn't find any btf debug information on this system.
  # pahole -F dwarf list_head
  pahole: couldn't find any dwarf debug information on this system.
  # tests/default_vmlinux_btf.sh
  Default BTF on a system without BTF: Ok
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
 dwarves.c | 3 +++
 libctf.c  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/dwarves.c b/dwarves.c
index 459311e64c8b45b2..ae512b9f46ddcc0a 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -777,6 +777,9 @@ struct cu *cu__new(const char *name, uint8_t addr_size,
 		if (cu->use_obstack)
 			obstack_init(&cu->obstack);
 
+		if (name == NULL || filename == NULL)
+			goto out_free;
+
 		cu->name = strdup(name);
 		if (cu->name == NULL)
 			goto out_free;
diff --git a/libctf.c b/libctf.c
index edb34dbf10de09e7..0641b10586527a6e 100644
--- a/libctf.c
+++ b/libctf.c
@@ -179,6 +179,9 @@ struct ctf *ctf__new(const char *filename, Elf *elf)
 	struct ctf *ctf = zalloc(sizeof(*ctf));
 
 	if (ctf != NULL) {
+		if (filename == NULL)
+			goto out_delete;
+
 		ctf->filename = strdup(filename);
 		if (ctf->filename == NULL)
 			goto out_delete;
-- 
2.47.0

