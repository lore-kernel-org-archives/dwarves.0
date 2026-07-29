Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC416495526;
	Wed, 29 Jul 2026 19:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352113; cv=none; b=GXNjLIUK+3e5qlcDBWJO357DqP/4R1GzvdNYXDqXADVP16qNCxpfH/Eit/LC8waCN1ffJyo35MkyTxRpS51JdwOlpfBBq+rgddUjRhJT/OapZc2Lzm4jDjbkt9n1sxt+c+C8xfC0+3OL/LFNCT3x92yKcB7WtN7LECjNWo+3brI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352113; c=relaxed/simple;
	bh=/S6UrAZdezGyYPKHt/+svl/9aVKViT6PBfXe+EGj82k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9zmYxZXDwfnsxvIsmRKdFkqbLgA+nKh0O/MmawKeGP2oE5XEqh0o4dsJLOripbI5BtydKmrSB48CCmTqSwoj+mIYTffIHEk/YqAcrYwMK5hdbdbmlo84vRq9/2VBRXv/alKLn0Yt+wFC5IKmox2PQPWTH/gH8sDdOcao0pfe7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efFMvgC0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efFMvgC0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA271F000E9;
	Wed, 29 Jul 2026 19:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352111;
	bh=1Mu+swQ8jA/s/3JMMSglbT0uH8iCxdfBQEX40/uKtog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=efFMvgC0zsgrF3EZCbh4VRVzskHED+bXwZFNBIBdMR0GwFKs1Q/rndc9tHyrPg5eM
	 axqrvbvgWyOLnp3/MIX5kaP4zeQe1Njj/aWjD37OBoaQRg1IN0AB7jzBt0aH1MuRFC
	 AHQQrruMHpqIYx7jlzANSO7bb74gZ0seMe4Ndngf+lpIvmbP4NQmEubqKIlMpvZatN
	 guhb9Dp653+uWtQISV4jgqHoTSaUYzCuOEmjAWu63fnVnngkES5wT+Q88qbW9maLwl
	 OA4RBtdynQxo/W3L4THx5ZnYwnVHBDE9jfrWQOf5gQ6tvJEdLFFouJjAD0YZMY4HIk
	 4/YN/lXmtzwLA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 23/31] pahole: Skip inline expansions during BTF encoding
Date: Wed, 29 Jul 2026 16:07:23 -0300
Message-ID: <20260729190733.72876-24-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729190733.72876-1-acme@kernel.org>
References: <20260729190733.72876-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Enable ignore_inline_expansions for BTF encoding (-J).  Inline
expansions (DW_TAG_inlined_subroutine) describe code-flow inlining
decisions — the BTF encoder never uses them (it encodes types, not
code structure).

Skipping them avoids allocating and recursively processing one of
the most numerous DWARF tag types in a vmlinux, reducing memory
usage and DWARF processing time for BTF generation.

This mirrors the existing ignore_labels optimization that was
already enabled for BTF encoding.

In a vmlinux with 548,620 DW_TAG_inlined_subroutine DIEs (the 6th
most common tag type):

  Before (processing inline expansions):
    $ time pahole -J --btf_encode_detached /tmp/t.btf vmlinux
    7.41s, 1057 MB max RSS

  After (skipping inline expansions):
    $ time pahole -J --btf_encode_detached /tmp/t.btf vmlinux
    7.06s, 1042 MB max RSS

  ~5% faster BTF encoding, 15 MB less peak memory.  The savings
  scale with the inline expansion count — heavily-inlined codebases
  like the kernel benefit the most.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 pahole.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/pahole.c b/pahole.c
index a6012e6a157293e9..65becc938cb0fc01 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1891,9 +1891,7 @@ static error_t pahole__options_parser(int key, char *arg,
 	case 'J': btf_encode = 1;
 		  conf_load.get_addr_info = true;
 		  conf_load.ignore_alignment_attr = true;
-		  // XXX for now, test this more thoroughly
-		  // We may have some references from formal parameters, etc, (abstract_origin)
-		  // conf_load.ignore_inline_expansions = true;
+		  conf_load.ignore_inline_expansions = true;
 		  conf_load.ignore_labels	     = true;
 		  conf_load.use_obstack		     = true;
 		  no_bitfield_type_recode = true;	break;
-- 
2.55.0

