Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D8B13FEE
	for <dwarves@vger.kernel.org>; Fri, 19 Dec 2025 00:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766104355; cv=none; b=dhI4w2LP5SmrCgekZSYW8KqFgMl9VPygqiJ2zjdDr+BgMSOMXrbaMJhhTBmXgdv8c0r+3Z3VVuX+yf4PgN8Codw92q7UqU0cN1vus1q7JpdqeiPbFoVXHYSyC1t6/M+UEoWsMD+tC+bbJkSOBQ1BkifsKif3N60FrVKvKcuuUQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766104355; c=relaxed/simple;
	bh=314A5Tj3+5f5HtyrFVZSBb6TJbogsocJkhmlAGdVqtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+VE/e4twb5mZR1FkB7oFOJgFgVH40Iqdh+uMc5W7JyT8F6E1IBr/O7w5kecgwvXMGO6gyxVr6iwDDoLXah934Z+kMup5dKZFy8Q4H5/hTxhq/HSPcreF5efeHEusz+GSqVEndMtNwRahhrL8E/tr+plw1n57IMOl6PuwGfQI40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=abn/ceQJ; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="abn/ceQJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766104346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KntbnHhIoFklWUgq4SsR9FNc6jQvPv1wzXNXP/Xkbr8=;
	b=abn/ceQJHXJU04Gjq0RtdA/ero3HO8to6j+99x9L2jqt2AdIU6YL85125SAbzXUkWcV6Qb
	Ikaw+8ye8b0RdvaEgMUzXfS2f50VPlZX3zyE9f6rtnygXxMlLnsJmdGpsicZYa9lmlJwlE
	Y5HoG2tWQcH5CvPTUST3T1q1fFTPzYw=
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
Subject: [PATCH bpf-next v5 2/8] resolve_btfids: Factor out load_btf()
Date: Thu, 18 Dec 2025 16:31:41 -0800
Message-ID: <20251219003147.587098-3-ihor.solodrai@linux.dev>
In-Reply-To: <20251219003147.587098-1-ihor.solodrai@linux.dev>
References: <20251219003147.587098-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Increase the lifetime of parsed BTF in resolve_btfids by factoring
load_btf() routine out of symbols_resolve() and storing the base_btf
and btf pointers in the struct object.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/resolve_btfids/main.c | 47 ++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 164f0c941f04..b4caae1170dd 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -116,6 +116,9 @@ struct object {
 	const char *btf_path;
 	const char *base_btf_path;
 
+	struct btf *btf;
+	struct btf *base_btf;
+
 	struct {
 		int		 fd;
 		Elf		*elf;
@@ -529,16 +532,10 @@ static int symbols_collect(struct object *obj)
 	return 0;
 }
 
-static int symbols_resolve(struct object *obj)
+static int load_btf(struct object *obj)
 {
-	int nr_typedefs = obj->nr_typedefs;
-	int nr_structs  = obj->nr_structs;
-	int nr_unions   = obj->nr_unions;
-	int nr_funcs    = obj->nr_funcs;
-	struct btf *base_btf = NULL;
-	int err, type_id;
-	struct btf *btf;
-	__u32 nr_types;
+	struct btf *base_btf = NULL, *btf = NULL;
+	int err;
 
 	if (obj->base_btf_path) {
 		base_btf = btf__parse(obj->base_btf_path, NULL);
@@ -546,7 +543,7 @@ static int symbols_resolve(struct object *obj)
 		if (err) {
 			pr_err("FAILED: load base BTF from %s: %s\n",
 			       obj->base_btf_path, strerror(-err));
-			return -1;
+			goto out_err;
 		}
 	}
 
@@ -555,9 +552,30 @@ static int symbols_resolve(struct object *obj)
 	if (err) {
 		pr_err("FAILED: load BTF from %s: %s\n",
 			obj->btf_path ?: obj->path, strerror(-err));
-		goto out;
+		goto out_err;
 	}
 
+	obj->base_btf = base_btf;
+	obj->btf = btf;
+
+	return 0;
+
+out_err:
+	btf__free(base_btf);
+	btf__free(btf);
+	return err;
+}
+
+static int symbols_resolve(struct object *obj)
+{
+	int nr_typedefs = obj->nr_typedefs;
+	int nr_structs  = obj->nr_structs;
+	int nr_unions   = obj->nr_unions;
+	int nr_funcs    = obj->nr_funcs;
+	struct btf *btf = obj->btf;
+	int err, type_id;
+	__u32 nr_types;
+
 	err = -1;
 	nr_types = btf__type_cnt(btf);
 
@@ -615,8 +633,6 @@ static int symbols_resolve(struct object *obj)
 
 	err = 0;
 out:
-	btf__free(base_btf);
-	btf__free(btf);
 	return err;
 }
 
@@ -824,6 +840,9 @@ int main(int argc, const char **argv)
 	if (symbols_collect(&obj))
 		goto out;
 
+	if (load_btf(&obj))
+		goto out;
+
 	if (symbols_resolve(&obj))
 		goto out;
 
@@ -833,6 +852,8 @@ int main(int argc, const char **argv)
 	if (!(fatal_warnings && warnings))
 		err = 0;
 out:
+	btf__free(obj.base_btf);
+	btf__free(obj.btf);
 	if (obj.efile.elf) {
 		elf_end(obj.efile.elf);
 		close(obj.efile.fd);
-- 
2.52.0

