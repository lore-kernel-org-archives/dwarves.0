Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D678347521
	for <dwarves@vger.kernel.org>; Thu, 18 Jun 2026 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781804017; cv=none; b=Jv1YiME0LrlSg25aQjj7627Rh6C36KHdeYI05q++qIhthII6zv2l5s7P7OmEnzA2vtqgkhBTof2dj3uMnrcfb1CAadgnKdn7ogHVBrcs63r/pFvY23x/7ylvbIooFppUOopltyjt1esIK2ZYkVrCqNHWxvoyWNIc7bedMcoAjAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781804017; c=relaxed/simple;
	bh=B5J9hoqkQWwUaCr/NhIP66CwxI6sG8w0BrzxtoKi++k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wi7HIehOq/4Fw48p16368tERCdPI8q1aGpnp9LE8Ue0TR3/lPtYeJVFxGTd4CWd5+FCPKp93/2JChyNfNloqeIF15dOBsBZ3dOzeKaNe+I+Y0j6zhHObRLKZsQmSWoWNoyR97YYj53fD9JXCNSWtTpwy51KNKNEkLLDs1gTPevk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6lTV6Ov; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6lTV6Ov"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD861F00A3A;
	Thu, 18 Jun 2026 17:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781804015;
	bh=6OYGwKPi9e0F5A4HgCgYGwneO4l/HQKMv0UgxtkABl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d6lTV6Ov5aV3EgJxz1wLfb5lnZ69va9PygAvlwVIyZdTGynJpEA5dRdI4V5Wuw+fB
	 yCMEmhny9dQjmlZHOtX2nvltYyk2YyEz0V9myo/5vu45e43bCxD5fikbxiBHkfAo3Z
	 1zUWLu7DFi0GXDHBu/ZjpgJ9tw0UJo7ywJvMjzAweOHeU97OTk2hT25BBYupKhyAx3
	 CgXhD+FPvKHkKhCZJLRblssj6pvRaerg/qqcdjY7x8wXUWGq631qANup9WXoGcXIwd
	 1PYTbWlKJulZpjeqUKCHInLiPSrY10HehHZUiHRsHJiHZpPcWyL5nYwrWP5bnlfloN
	 xcWFozfcQkSKg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 7/7] btf_encoder: Remove unused variables
Date: Thu, 18 Jun 2026 14:33:16 -0300
Message-ID: <20260618173316.83598-8-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618173316.83598-1-acme@kernel.org>
References: <20260618173316.83598-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Detected with gcc on fedora44:

  /home/acme/git/pahole/btf_encoder.c: In function ‘types__match’:
  /home/acme/git/pahole/btf_encoder.c:1123:49: warning: variable ‘p2’ set but not used [-Wunused-but-set-variable=]
   1123 |                         const struct btf_param *p2 = btf_params(t2);
        |                                                 ^~
  /home/acme/git/pahole/btf_encoder.c:1122:49: warning: variable ‘p1’ set but not used [-Wunused-but-set-variable=]
   1122 |                         const struct btf_param *p1 = btf_params(t1);
        |                                                 ^~

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 btf_encoder.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 12c22b003b7990bf..4467710e4e03c32f 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1119,8 +1119,6 @@ static bool types__match(struct btf_encoder *encoder,
 			break;
 		}
 		case BTF_KIND_FUNC_PROTO: {
-			const struct btf_param *p1 = btf_params(t1);
-			const struct btf_param *p2 = btf_params(t2);
 			int i, vlen = btf_vlen(t1);
 
 			if (vlen != btf_vlen(t2))
@@ -1128,7 +1126,7 @@ static bool types__match(struct btf_encoder *encoder,
 			if (!types__match(encoder, btf1, t1->type,
 					  btf2, t2->type))
 				return false;
-			for (i = 0; i < vlen; i++, p1++, p2++) {
+			for (i = 0; i < vlen; i++) {
 				if (!types__match(encoder, btf1, t1->type,
 						  btf2, t2->type))
 					return false;
-- 
2.54.0

