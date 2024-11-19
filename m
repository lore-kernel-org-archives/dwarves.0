Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B56754673
	for <dwarves@vger.kernel.org>; Tue, 19 Nov 2024 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732023653; cv=none; b=Pn+EnP1yysZPj4xSZMGk5ghIekeH6384s4/7NLnwJHgJ23Rz1ZRSzMWYTDlAqRFHXMXwnPqcxWEuEGDuNKNTvjHOTE69c+hr9hfYQGEDI0ogY7kvrUURNtYdZodIi2rLGatATAHTbnba8Q7Y9VRx4VkjQiZCfSX4wo+rRUdZ55U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732023653; c=relaxed/simple;
	bh=wUltog3wseOx958LqxUTme+LzKijn/TQRJakWVRuHWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ecx4R0w2IEXFV1tjDNY/dx5iFW39Yblo4u3X7bzQbBjqNTa3mEXMrXI9kyF4bfeqiaPS1IZWVXZ/NFW4FRTq5S89iWMPhOlgzfgTvz70rs9RnxYUmB5XyUfrQo/k5h8xLAUmu0lpkbvfqcUxi0LRIxYNL+pORLnejAsNBViBgiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KN5C6/tE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KN5C6/tE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B40C4CED0;
	Tue, 19 Nov 2024 13:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732023653;
	bh=wUltog3wseOx958LqxUTme+LzKijn/TQRJakWVRuHWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KN5C6/tEzlTlkrOYSBeOSXp9xbgJ//ei5yk/76ZwJNId7pHKijE80i/C5YR8E255g
	 Kd/1VesZtA3MwJP7FEj04GyAQntEnfPLs80uUg8PDPEgU/B84M+OZgOh/jU2psR2zb
	 c1F0CsI0vZisfKrWhn+qkLUrxbekE6seKsZ/TgFOaFQb4MlWckU7gsJIsr56P1jCb7
	 CQq79yPs7kDIPFMRxggOq+bWM8hGl+21Ilx5qNlCXGpguuqse06Mb08tiAkmtyE86A
	 EkXmS407Rkpw/KpcuNnaLYCRHotXQieAFzW0Wvvx4TuGAuv3nN3G8qoy01DTS7a9MD
	 Y5KC4OoCW6m6A==
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
Subject: [PATCH 2/5] tests default_vmlinux_btf: Introduce test for using BTF by default
Date: Tue, 19 Nov 2024 10:40:29 -0300
Message-ID: <20241119134032.783215-3-acme@kernel.org>
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

On a system without any debugging info or when one specifies BTF as the
only BTF info desired but no BTF is available (or invalidated using
PAHOLE_VMLINUX_BTF_FILENAME to an invalid/non-existent file), we're
getting a segfault:

  root@x1:/home/acme/git/pahole# export PAHOLE_VMLINUX_BTF_FILENAME=non-existent
  root@x1:/home/acme/git/pahole# pahole --running_kernel_vmlinux
  pahole: couldn't find a vmlinux that matches the running kernel
  HINT: Maybe you're inside a container or missing a debuginfo package?
  root@x1:/home/acme/git/pahole# pahole
  Segmentation fault (core dumped)
  root@x1:/home/acme/git/pahole#

So add a test that checks for that before we fix it:

  root@x1:/home/acme/git/pahole# tests/default_vmlinux_btf.sh
  Default BTF on a system without BTF: FAILED
  root@x1:/home/acme/git/pahole#

Reported-by: Matthias Schwarzott <zzam@gentoo.org>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tests/default_vmlinux_btf.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100755 tests/default_vmlinux_btf.sh

diff --git a/tests/default_vmlinux_btf.sh b/tests/default_vmlinux_btf.sh
new file mode 100755
index 0000000000000000..a9effa2d6d37e0ee
--- /dev/null
+++ b/tests/default_vmlinux_btf.sh
@@ -0,0 +1,21 @@
+#!/bin/bash
+
+echo -n "Default BTF on a system without BTF: "
+
+ulimit -c 0
+
+# To suppress the "Segmentation fault core dumped" message in bash we
+# pipe it to some other command, if it segfaults it will not produce any
+# lines and thus we can infer from the number of lines that the segfault
+# took place, tricky, but couldn't find any other way to check this
+# while suppressing the core dumped message. -acme
+
+nr_lines=$(PAHOLE_VMLINUX_BTF_FILENAME=foobar pahole -F btf list_head 2>&1 | wc -l)
+
+if [ $nr_lines -eq 0 ] ; then
+	echo "FAILED"
+	exit 1
+fi
+
+echo "Ok"
+exit 0
-- 
2.47.0

