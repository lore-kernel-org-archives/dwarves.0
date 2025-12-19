Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E1C34FF76
	for <dwarves@vger.kernel.org>; Fri, 19 Dec 2025 18:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766168061; cv=none; b=ClkcFCxuWXwvg9jJBEfvu7gtG+AmC7m4HLyJpoIWjuI42bXd9Yk28d4AtxIcFusMqstanwhNHI0DUhRgzWCGcM0NfLbC9w6GRRLiXTIP/bW3h0MgtpXzSZyVB+Xq7LI2hDSauHsv/0NWF+z71ZNB4KE3GYBq0WJoSa/zKPVoN8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766168061; c=relaxed/simple;
	bh=RIatdLGJs9ccgIc14D03GI3j70EcobeXV60MzFDU25U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ix9e6eRdyt3MMFUo5iOn6XYvpWC3kTimjZEuX9dKrSumw9K8Itl+Iq2eSA96cPsFDvsEozmNIUjg0Rlo8kUpAiTKdwJiRQ5f00E79fCvQ1U06ReKHsWagdRh6/OXi/oybuu9TmqwmHMl/cGr/i//U48rpFXZwN/p4285uZ/YcsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FJL6a7VF; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FJL6a7VF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766168054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRf8rJz1Tj2FggqEZIaoF6sSftsqCsFHz4HLS3YlcGY=;
	b=FJL6a7VFc+e4yDMm0SNaiEMKwVXlrLFRkSee2XYNWDNqfeBqdKoatBUwRV7vNgW5WwQbtp
	dgXjMJwqltaUhBZSajqH/nS5eYTH6jkfwejgrEW3X/I8zM0vKSt3qTbvIDzcsXLKBpmmow
	ZC9WbhTVn9f5bBfj81qkcrpCiqwelbA=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Donglin Peng <dolinux.peng@gmail.com>
Cc: bpf@vger.kernel.org,
	dwarves@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v7 4/8] resolve_btfids: Always build with -Wall -Werror
Date: Fri, 19 Dec 2025 10:13:17 -0800
Message-ID: <20251219181321.1283664-5-ihor.solodrai@linux.dev>
In-Reply-To: <20251219181321.1283664-1-ihor.solodrai@linux.dev>
References: <20251219181321.1283664-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

resolve_btfids builds without compiler warnings currently, so let's
enforce this for future changes with '-Wall -Werror' flags [1].

[1] https://lore.kernel.org/bpf/1957a60b-6c45-42a7-b525-a6e335a735ff@linux.dev/

Tested-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/resolve_btfids/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index ce1b556dfa90..1733a6e93a07 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -70,7 +70,8 @@ HOSTCFLAGS_resolve_btfids += -g \
           -I$(srctree)/tools/include/uapi \
           -I$(LIBBPF_INCLUDE) \
           -I$(SUBCMD_INCLUDE) \
-          $(LIBELF_FLAGS)
+          $(LIBELF_FLAGS) \
+          -Wall -Werror
 
 LIBS = $(LIBELF_LIBS) -lz
 
-- 
2.52.0

