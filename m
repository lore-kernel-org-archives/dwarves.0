Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58A535959
	for <dwarves@vger.kernel.org>; Thu,  7 Aug 2025 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754591151; cv=none; b=P+NfIbOCUDYCYfW62c0n2QvcCvuqU+KN2W7WAkbjr9gMX8brMlNH8OUiuZKnRmZ4qvSy59GhiG/jsAu0FFoovaeQwslmmKL2pkd3iwB65SKPWcKEHzelHoQbNafyqjc5TQe7dPYcz23Z0fJ/AiOvxJbURHIWtkiUdK+5+EQptGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754591151; c=relaxed/simple;
	bh=CWMmg3sC6kHYMynXC/CL9KkLyh0bv3iNTd6MscrAT3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXJa4zag4MRWMUmBmOHfZ+92ggHL9QHpGblWnIFH7MllkVv+Xa8WQGwYfnXV+Z6iwaUREzpZbqH7sUf/dLCJNFsFOqmNkBrmC7f8pSUu0e6s3XSREnkWcLapi+ykof/XTlCIsnpdp5sOGXWFbC4NGh3nYhXl1YEJrcEnsjgbd8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4BZRXq1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4BZRXq1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75010C4CEEB;
	Thu,  7 Aug 2025 18:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754591151;
	bh=CWMmg3sC6kHYMynXC/CL9KkLyh0bv3iNTd6MscrAT3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z4BZRXq1HRCyYeuyYgCNbQOjgV48nZ5XtfY5ctXF+HRsEuddP2ccGgAtKkD0yf8V/
	 EJDtw1mdhHtY/eqLyyTeq+q/kQMRp1KeTikUbPILC0jNiXf/LuPm01WNffw4z++FpB
	 QnwP2jDM3oThMU0PdzmLJD7LEkD11vRJUxcsoTMbpE2LEE6608QQUvQLjFnO06VrRx
	 1Z3bK1eqHfAm1M3a/ZtUyI9hp8zKWSEP88k0XoDmxDClrM20bZWxn0y08dTDt0VPE7
	 5MtzEAxvxHXKw02q5iDTTWttXk7KMykSnKyWvpYOHrurtzjpN2rIpg8lqc23OzUVFp
	 c0ygh7cJR7mWg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Nick Alcock <nick.alcock@oracle.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH 1/4] libbpf: Simplify error handling removing needless repeated err checks
Date: Thu,  7 Aug 2025 15:25:35 -0300
Message-ID: <20250807182538.136498-2-acme@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250807182538.136498-1-acme@kernel.org>
References: <20250807182538.136498-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The 'done' label can be inside the last test for 'err', as all jumps
there are immediately preceded by setting 'err' to a non-zero value, so
no need to check it.

Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nick Alcock <nick.alcock@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/bpf/btf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 37682908cb0f3bd4..9bacd4dddff366bf 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1090,11 +1090,9 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf, b
 	err = btf_parse_str_sec(btf);
 	err = err ?: btf_parse_type_sec(btf);
 	err = err ?: btf_sanity_check(btf);
-	if (err)
-		goto done;
 
-done:
 	if (err) {
+done:
 		btf__free(btf);
 		return ERR_PTR(err);
 	}
-- 
2.50.1

