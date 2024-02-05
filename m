Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AD25812A
	for <dwarves@vger.kernel.org>; Mon,  5 Feb 2024 19:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160897; cv=none; b=KhhIPpYlUSbFNFroWk4SupzknaJfJFCFXEBGf9wB7HDQqD8cXuzPOJaIX5+4sHgU0FkGBg0S0WaasyezoVSNn5ttqhiH+eguks8sAHA9L9x3GRxXDWLZR+F+t9e2fcOUC8vyBmySiGeNCZzfTm2ZEtuEYP9GDQfVn1NA4DT6rDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160897; c=relaxed/simple;
	bh=ynjD7gPV6rI+uAvCwaBtqFOXsk7HH+5Xbr5YFNAThKs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DW2e0IPCZHIElz9u6reJDKP89NtVUqGE34Q/DF40ZY90UWAfI+2LLY2EsGTjKFW/F9czLyU0Valnt4VB2hksMwyn0T1Mb4zvg2bvMp4tf3r8cYVTolDXtnM3MC1OxfiAbOsNI944OpzqH25n57YDzmlPLacFZxB5Zuc0EqCq41M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNSnDhIl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNSnDhIl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3579C433C7;
	Mon,  5 Feb 2024 19:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707160896;
	bh=ynjD7gPV6rI+uAvCwaBtqFOXsk7HH+5Xbr5YFNAThKs=;
	h=Date:From:To:Cc:Subject:From;
	b=hNSnDhIljjVAk8IGxGuZvNZOmjs7pZZaHaj/QfkogGl85BYXOvMnjBlaoMMk29uim
	 EDPDIPqfYTo88QH8ciGEudW1g1n0jDMXO3MOJbEy6Crl3xAiz6edAnvgX/AZXUdG2E
	 K2BZwxA9Scs+oIBLQ2x++PalINfUY5jHrLSwkDv/8WCFbfg8mNoJYKK4sDePD1SZ3K
	 6kUqTVRJSnp25Z1Uv3kaDai49gnk7jpJbcwy4d2rd0pfHLbyT8UZP4rD0+R14zYskJ
	 12+Xxps+oalh/dzJt7SxXPmF69kHdeDmqFDEOVc5MbHQmP8x/AUyQGQEvynnGrxVFV
	 S6hBULNBgDykA==
Date: Mon, 5 Feb 2024 16:21:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, dwarves@vger.kernel.org
Subject: [PATCH 1/1] pahole: Make sure the features string is NUL terminated
Message-ID: <ZcE1PJ8MPXzVb3mJ@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

To address this compiler warning:

  /home/acme/git/pahole/pahole.c: In function ‘parse_btf_features’:
  /home/acme/git/pahole/pahole.c:1353:9: warning: ‘strncpy’ specified bound 1024 equals destination size [-Wstringop-truncation]
   1353 |         strncpy(f, features, sizeof(f));
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  $ gcc -v |& tail -1
  gcc version 13.2.1 20231205 (Red Hat 13.2.1-6) (GCC)
  $

When building in Release mode, for instance by using the buildcmd.sh
script.

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Fixes: 7bc9b9975545ab53 ("pahole: Add --btf_features support")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 pahole.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pahole.c b/pahole.c
index 768a2feb338a2f3c..0e079ae19f231a5a 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1338,7 +1338,7 @@ static void show_supported_btf_features(FILE *output)
 static void parse_btf_features(const char *features, bool strict)
 {
 	char *saveptr = NULL, *s, *feature_name;
-	char f[BTF_MAX_FEATURE_STR];
+	char f[BTF_MAX_FEATURE_STR + 1];
 
 	init_btf_features();
 
@@ -1350,7 +1350,7 @@ static void parse_btf_features(const char *features, bool strict)
 		return;
 	}
 
-	strncpy(f, features, sizeof(f));
+	strncpy(f, features, BTF_MAX_FEATURE_STR)[BTF_MAX_FEATURE_STR] = '\0';
 	s = f;
 	while ((feature_name = strtok_r(s, ",", &saveptr)) != NULL) {
 		struct btf_feature *feature = find_btf_feature(feature_name);
-- 
2.43.0

