Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4934B22256F
	for <dwarves@vger.kernel.org>; Thu, 18 Dec 2025 00:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766018091; cv=none; b=ElxFnyYvpku6vdo3biz/J3oaClh6sMYook3M5I2Tszlx+avrCubvMdA2gm1FydS8SXZS3DqI0nWx7r5JO8CH3l63rxRnGTqdJQk6cZKLDlL8SCBtaf61Avi6P3xCJoWSAZPQr3C/T6/RvDE3fxydszgfTgTY8mzPci0Xe7A/BTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766018091; c=relaxed/simple;
	bh=VuNfMpTBm0CUYXaO+t8aSyvTsMROnkknWppmR/tAKfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqKDkmedf1Cx2nYQ8+7HyZ/kyRD7v/j4O3RoapiI0OBW3XI4Bq+rJuQRokAKfKTDsOyhm0/0iWLjMzYm78Jc+C8EyR4LGkIMGjDohtxZ/OKmKnJqM8mUS41hJJdmXJLqchRxmElIDRsbIjsCgM/7GswJgTHiW7meaqyh9eHf83c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bKugnyia; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bKugnyia"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766018081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aayb7iWI2Jbv+ieS21a4aukFU/2uaqV3fIN+m3cIAm4=;
	b=bKugnyiaeJjpFz2y46IkkQwpJzL4P3WDwUAk1VR5OfDKgJPW/SngXhRT/DPZTiG5BS5B8c
	4cZmYG1MPBokL/mhN0KQOUUiMxCUVZKw6jGIGT9Sf9zoQL8hwVfz0TzBMrR1lcEKY3xe6z
	VGL5r/WcKIbF/dwfspYcH6Wt39SWi9E=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Vernet <void@manifault.com>,
	Donglin Peng <dolinux.peng@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Nicolas Schier <nsc@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tejun Heo <tj@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org,
	dwarves@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v4 4/8] resolve_btfids: Always build with -Wall -Werror
Date: Wed, 17 Dec 2025 16:33:10 -0800
Message-ID: <20251218003314.260269-5-ihor.solodrai@linux.dev>
In-Reply-To: <20251218003314.260269-1-ihor.solodrai@linux.dev>
References: <20251218003314.260269-1-ihor.solodrai@linux.dev>
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

