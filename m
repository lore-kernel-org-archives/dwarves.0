Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59610271471
	for <dwarves@vger.kernel.org>; Thu, 18 Jun 2026 00:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781744274; cv=none; b=OIuhK9j2tjztjelFpeDaid+lDtHnDQYcKGd0s6A0UPa/w7A3BF9sj65ohQkDCnD1sgKtz2QXdUZaQuzQohhT10/F8b5bxwWJzyKE0MeqBrBBTD56pDpjHOJR98C66bJVzVNOQgT3lBDGhXy108W0UlDyLfblkBx8MFTYJAqjDHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781744274; c=relaxed/simple;
	bh=oUb2U+0e9zRN7tE3DBcervMz6r1inJ9SiIutqAB+Ri8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPHSijNd29n2kBBOVFoyT9fBlWu08I9TTaIbd9latSWDqBWwYSRcivGc/eBg8GY7q4KpoTSxA73dPnrlh9cHbbcuwY5yH1bfq8VX6l1Y1newHnp+O1ck9iyalA7Ftl4zONFp4tWFl3o3gDnKqUVXB+AtTvARJVawCKxPA0i2Duw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n6PnIhAi; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n6PnIhAi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781744270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ju20PdvmPPWk7xRQWacfdjDMX/VH6mE03pnZdAjRFjY=;
	b=n6PnIhAizjCjUl4qzwMYHpUF3LqINwQ3j4MAfRse3oOOINimBxJKwjVhslkn+2knaqp5zY
	Rnfg8n8f53VRRW8Ytd72We5U1DOj7OAmnv5xKlWChe+qcJCxsflEa621+lJNXFOy3oLe2o
	FZBNctCJDeKhaRbLT3T6DdfHmSsYtP8=
From: Vineet Gupta <vineet.gupta@linux.dev>
To: dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	acme@kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	jose.marchesi@oracle.com,
	David Faust <david.faust@oracle.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PAHOLE v5 1/5] btf_loader: Handle decl tag component_idx for parameters
Date: Wed, 17 Jun 2026 17:57:27 -0700
Message-ID: <20260618005731.273181-2-vineet.gupta@linux.dev>
In-Reply-To: <20260618005731.273181-1-vineet.gupta@linux.dev>
References: <20260618005731.273181-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Alan Maguire <alan.maguire@oracle.com>

A BTF_KIND_DECL_TAG with a non-negative component_idx applies to a
specific function parameter (or struct/union member), not to the
function itself. btf_loader.c however attached every decl tag to the
type named by btf_type->type, so parameter decl tags were recorded on
the function rather than on the parameter, and pfunct never printed
them with the parameter.

Resolve a non-negative component_idx to the corresponding parameter via
new helpers ftype__parameter()/function__parameter(), and attach the
tag there. Teach the pretty printer to emit a parameter's attributes by
factoring the function-level attribute loop into tag__attributes_fprintf()
and calling it from ftype__fprintf_parms() for each parameter.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 btf_loader.c      | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 dwarves_fprintf.c | 20 ++++++++++++++++----
 2 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/btf_loader.c b/btf_loader.c
index b591219a245d..9bb52c3c5801 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -477,12 +477,56 @@ static struct attributes *attributes__realloc(struct attributes *attributes, con
 	return result;
 }
 
+static struct tag *ftype__parameter(const struct ftype *ftype, int component_idx)
+{
+	struct parameter *pos;
+	int idx = 0;
+
+	ftype__for_each_parameter(ftype, pos) {
+		if (idx == component_idx)
+			return &pos->tag;
+		++idx;
+	}
+
+	return NULL;
+}
+
+static struct tag *function__parameter(const struct function *func, struct cu *cu,
+				       int component_idx)
+{
+	struct tag *tag;
+
+	if (component_idx < 0)
+		return NULL;
+
+	tag = cu__type(cu, func->proto.tag.type);
+	if (tag == NULL)
+		return NULL;
+
+	return ftype__parameter(tag__ftype(tag), component_idx);
+}
+
 static int process_decl_tag(struct cu *cu, const struct btf_type *tp)
 {
+	int component_idx = btf_decl_tag(tp)->component_idx;
 	struct tag *tag = cu__type(cu, tp->type);
 	struct attributes *tmp;
 
-	if (tag == NULL)
+	if (component_idx >= 0) {
+		struct tag *func_tag = cu__function(cu, tp->type);
+
+		if (func_tag != NULL) {
+			tag = function__parameter(tag__function(func_tag), cu,
+						  component_idx);
+			if (tag == NULL) {
+				fprintf(stderr, "WARNING: BTF_KIND_DECL_TAG for unknown parameter %d in BTF id %d\n",
+					component_idx, tp->type);
+				return 0;
+			}
+		}
+	}
+
+	if (tag == NULL && component_idx < 0)
 		tag = cu__function(cu, tp->type);
 
 	if (tag == NULL)
diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index 1ec478c2a027..54f483244bd2 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -1199,6 +1199,18 @@ const char *function__prototype(const struct function *func,
 					bf, len);
 }
 
+static size_t tag__attributes_fprintf(const struct tag *tag, FILE *fp)
+{
+	size_t printed = 0;
+	int i;
+
+	if (tag->attributes)
+		for (i = 0; i < tag->attributes->cnt; ++i)
+			printed += fprintf(fp, "%s ", tag->attributes->values[i]);
+
+	return printed;
+}
+
 size_t ftype__fprintf_parms(const struct ftype *ftype,
 			    const struct cu *cu, int indent,
 			    const struct conf_fprintf *conf, FILE *fp)
@@ -1240,6 +1252,7 @@ size_t ftype__fprintf_parms(const struct ftype *ftype,
 				if (n)
 					return printed + n;
 				if (ptype->tag == DW_TAG_subroutine_type) {
+					printed += tag__attributes_fprintf(&pos->tag, fp);
 					printed +=
 					     ftype__fprintf(tag__ftype(ptype),
 							    cu, name, 0, 1, 0,
@@ -1248,12 +1261,14 @@ size_t ftype__fprintf_parms(const struct ftype *ftype,
 				}
 			}
 		} else if (type->tag == DW_TAG_subroutine_type) {
+			printed += tag__attributes_fprintf(&pos->tag, fp);
 			printed += ftype__fprintf(tag__ftype(type), cu, name,
 						  true, 0, 0, 0, conf, fp);
 			continue;
 		}
 		stype = tag__name(type, cu, sbf, sizeof(sbf), conf);
 print_it:
+		printed += tag__attributes_fprintf(&pos->tag, fp);
 		printed += fprintf(fp, "%s%s%s", stype, name ? " " : "",
 				   name ?: "");
 	}
@@ -1405,11 +1420,8 @@ static size_t function__fprintf(const struct tag *tag, const struct cu *cu,
 	struct ftype *ftype = func->btf ? tag__ftype(cu__type(cu, func->proto.tag.type)) : &func->proto;
 	size_t printed = 0;
 	bool inlined = !conf->strip_inline && function__declared_inline(func);
-	int i;
 
-	if (tag->attributes)
-		for (i = 0; i < tag->attributes->cnt; ++i)
-			printed += fprintf(fp, "%s ", tag->attributes->values[i]);
+	printed += tag__attributes_fprintf(tag, fp);
 
 	if (func->virtuality == DW_VIRTUALITY_virtual ||
 	    func->virtuality == DW_VIRTUALITY_pure_virtual)
-- 
2.54.0

