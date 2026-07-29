Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98434463B84;
	Wed, 29 Jul 2026 19:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352101; cv=none; b=DEUCYSe3dSL8+3O618MFNU/3qlPFmXH5DRV2sC7Vm0bx7i6cPfETa5484n2CVRRvmfJ2PnE0io2d9pXfi4rlqfAoGlgnqzYbWU7Q7zevQz0PBEbIR0+0WqEvd6dZN11yd7oaWvOslcK1X7byyY46LdpisEltd9+hC4dz0D8wc2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352101; c=relaxed/simple;
	bh=NX8HdB0gVhwKot6+y/ANuo3tn8CDCbdlAJusDJ0lEfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YLPKno8bL9E0/4tshZkRXXgg2dOihaASTvG9YVMrPYv6aSEIO3ZusaSe/Xx3LnvpN0lE2GEYm7blts6xJuPfSmpuFJ1pr2TrjAov9uvfj9Y0rH+4LwETfe2YPtS+a3Iv9f6nzwfxoouwEqPV9GCGEESr/MzaHxYdKDwK2EWSS2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmbHSKS7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmbHSKS7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1BD1F00A3A;
	Wed, 29 Jul 2026 19:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352100;
	bh=fBtwyyC7imY4FG/oiDVOkUIOh6KBURCfVAwIZG/SOIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YmbHSKS7tbgqgtVhEFF5P2C/t0jbyNjg3H1vAMtxd6j00XMg3TcfkBJqXS8Ho2I2F
	 5r2NWdpZgmVYCp1yAgkUQ/nIJqcMTeJxtPU4zU2Jh38GuazN4awg5G5QZWhUgOrDw1
	 CqrwfZp7r0q6wj9eh/0w3Dl1C64fCQwCayFIAJZn2OVstX9k2OIy/V3/rrISgoP/Fw
	 V3Qb9USBMScKNNqXGd4mrovAxIldeSZvDfmo0PUEhQijHeUAPwLVtOqIH21dF+a2bC
	 GzaQa6OfHHcuvYzLO/lZLph2rvsnD/4bb/DHMjeTgAdEDcYF/3S3Mlt/dTnS6oJ0/5
	 IfHNiBIziFn5w==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 18/31] pahole: Fix parse_btf_features("all") being a silent no-op
Date: Wed, 29 Jul 2026 16:07:18 -0300
Message-ID: <20260729190733.72876-19-acme@kernel.org>
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

"all" was not recognized as a feature name, so
parse_btf_features("all") silently did nothing — no features were
enabled and no error was reported.

Add btf_features__enable_all() that enables every feature in the
btf_features[] table, and wire it into parse_btf_features() both as
a standalone value and as a token in comma-separated lists.

Before: --btf_features=all silently enabled nothing.
After:  --btf_features=all enables all features in the table.

Fixes: 7bc9b9975545ab53 ("pahole: Add --btf_features support")
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 pahole.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/pahole.c b/pahole.c
index 0e2acc35d6d679f0..a6012e6a157293e9 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1299,6 +1299,22 @@ static void btf_features__enable_default(void)
 	}
 }
 
+static void btf_features__enable_all(void)
+{
+	for (size_t i = 0; i < ARRAY_SIZE(btf_features); i++) {
+		/* distilled_base requires a --btf_base argument to
+		 * provide the base BTF that btf__distill_base() will
+		 * split against.  Enabling it unconditionally causes
+		 * btf_encoder__encode() to call btf__distill_base()
+		 * on standalone objects like vmlinux, which returns
+		 * -EINVAL and makes pahole fail fatally.  Users who
+		 * want distilled_base must request it explicitly. */
+		if (btf_features[i].conf_value == &conf_load.btf_gen_distilled_base)
+			continue;
+		enable_btf_feature(&btf_features[i]);
+	}
+}
+
 /* Translate --btf_features=feature1[,feature2] into conf_load values.
  * Explicitly ignores unrecognized features to allow future specification
  * of new opt-in features.
@@ -1315,6 +1331,11 @@ static void parse_btf_features(const char *features, bool strict)
 		return;
 	}
 
+	if (strcmp(features, "all") == 0) {
+		btf_features__enable_all();
+		return;
+	}
+
 	// Adding extra features to the set of standard features.
 	if (strstarts(features, "+")) {
 		btf_features__enable_default();
@@ -1332,6 +1353,8 @@ static void parse_btf_features(const char *features, bool strict)
 			 */
 			if (strcmp(feature_name, "default") == 0) {
 				btf_features__enable_default();
+			} else if (strcmp(feature_name, "all") == 0) {
+				btf_features__enable_all();
 			} else if (strict) {
 				fprintf(stderr, "Feature '%s' in '%s' is not supported.  Supported BTF features are:\n",
 					feature_name, features);
-- 
2.55.0

