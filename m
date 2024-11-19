Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEAA1BF24
	for <dwarves@vger.kernel.org>; Tue, 19 Nov 2024 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732023661; cv=none; b=cZNYrn5UrcIHq13rnsB9EqhJEcSA4RvmexKRaAui6I4F3TS8JWa3BM8wg9M1B1l7O+JyXRSxtTVB/eqwDgGKmw7QrYcdrn+fFjczlm9pqcllZwv2OzMchh6fzAcXdaEDxy2m9fkRgxMqra0bDoS3BYvs6Hkig9zi4Dt6TSBFjJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732023661; c=relaxed/simple;
	bh=rLW4twyhWGOhIR7LV9GoiC7vwIxxcD4Vo36mh/UCn4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHjpIt/RSIqWokbv4sT3cIe15OV8Z1VA18MXVbP7LTt8mL7oHn/ewBY86mQ9QkUKoxPZFugBEIfhYeQil/hQpKVHheg4o/4yLqUGG0/PkodhGuz0wHNOoZoJUV6AI3UPB5RDi0K5wz2bM13dvF7nkbus4RJF2XZJqkPzQt/OGyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivaV5oTy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivaV5oTy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92645C4CECF;
	Tue, 19 Nov 2024 13:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732023661;
	bh=rLW4twyhWGOhIR7LV9GoiC7vwIxxcD4Vo36mh/UCn4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ivaV5oTyZB9/Y3U41ajPbmMJwMmG8NCbqDy27OGzAIhWLhuEiqZHu7b5gL2W4Lcui
	 Xi+C6yvx5WJfPsbIIIAWbgtB5kgxamr2qMfDw2RaZ8OzrLcIdk4W1+RXjh6lq9y1u1
	 OViP1atN9KFK5loDrVeabwIU4QqXPTWLDoXeLdn5yN6AysRMzlYZ6fJnEP/y3CI43D
	 wSgT/wu84XTIU5Ynn/hdouakAtV66q71Wr9lFcmKk40fMzhjiNOPxr+dF6rcAD3hTx
	 rn/TY6VGjhzwuXBEhEmn7wXpKlbmUyIEazrnIQtaBTLhbE1VMgqk1poa58F88kKvV2
	 2mOYx24kY4Q3w==
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
Subject: [PATCH 4/5] tests default_vmlinux_btf: Cover the no args segfault too
Date: Tue, 19 Nov 2024 10:40:31 -0300
Message-ID: <20241119134032.783215-5-acme@kernel.org>
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

  root@x1:/home/acme/git/pahole# pahole --running_kernel_vmlinux
  pahole: couldn't find a vmlinux that matches the running kernel
  HINT: Maybe you're inside a container or missing a debuginfo package?
  root@x1:/home/acme/git/pahole# tests/default_vmlinux_btf.sh
  Default BTF on a system without BTF: FAILED
  root@x1:/home/acme/git/pahole# pahole
  Segmentation fault (core dumped)
  root@x1:/home/acme/git/pahole#

Now to fix this one as well.

Reported-by: Matthias Schwarzott <zzam@gentoo.org>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tests/default_vmlinux_btf.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/default_vmlinux_btf.sh b/tests/default_vmlinux_btf.sh
index a9effa2d6d37e0ee..a855ca7587380934 100755
--- a/tests/default_vmlinux_btf.sh
+++ b/tests/default_vmlinux_btf.sh
@@ -17,5 +17,16 @@ if [ $nr_lines -eq 0 ] ; then
 	exit 1
 fi
 
+# There is also the case where no debugging info is available, be it DWARF of
+# BTF and it segfaults when calling just 'pahole', with no args, so check for
+# that as well
+#
+nr_lines=$(PAHOLE_VMLINUX_BTF_FILENAME=foobar pahole 2>&1 | wc -l)
+
+if [ $nr_lines -eq 0 ] ; then
+	echo "FAILED"
+	exit 1
+fi
+
 echo "Ok"
 exit 0
-- 
2.47.0

