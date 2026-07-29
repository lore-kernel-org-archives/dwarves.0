Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A8F463B69;
	Wed, 29 Jul 2026 19:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785352062; cv=none; b=ajB/7Em5IPtaILypdZF5Ru68peScWYM8ErKDTHlh5dmljAnW3RtKZPN4uRHu3X/tXdyWUAMpIr3Rmiz32BuFFxh46+ebOL5SX6Ko3N0hrjHOSERuEWY6PE/MH3pXN6RhYb/HWLUPBck9Qfx4T2ssS51Naov+aqB4u/ZQzHWyQZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785352062; c=relaxed/simple;
	bh=Vxy23usPwrjMEXcruKC7sXIN00hfmFUy30N1xWgErz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pF8KHx1GUMJbWk33i9guwlMeGAt2vrI2E9PnZwEU1tT2qeB+6EQtnxSXnhOYaP9JRJ8isvd6mIE8v6pHiy3VkCeVypqgIiIe7PReulWQ4s391UPnnZWyovYOzm6vDvJlPTe+iPjTiJDr38ej/VzLHTxo9m7825aQ+1phU9g/XEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EN75sZ1n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EN75sZ1n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535A61F000E9;
	Wed, 29 Jul 2026 19:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785352061;
	bh=P3MQ4IAq1ecBrVF5mrc9PEbmcQxGOwtlWrZgAjV59DU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EN75sZ1npyrXm9GfdZQAd81t/Hu7Ivt+uaOtopvxmUyoODVWlocIBs+z+xtr3RQpF
	 MaWZVtl8e7FpJ9Tj93cD4zRSFLHd/UbEEC6DlnBA31+cvw339sQ4+tInN+hZujdhTp
	 sNuBk+aLQm/Gm1QYU/rOLPw6PmlaB8NZoLcpQXVQRP0JBqtpmtSvwArnqC1LmnR7Na
	 Qz4bEEGb3ONWZduFG1odhF5L8PwqFhs21byodBKzN7XpER9vDWRSycqO4bQL6Id/O3
	 QLptL2vnfXhzZSr68d0MxpUQNff0vp7c2vsYsO0FXYR0/O1w4Qo+hmFl167KKn7nxs
	 EUcYdb1fgIZkw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/31] cmake: Update minimum required version from 3.5 to 3.10
Date: Wed, 29 Jul 2026 16:07:01 -0300
Message-ID: <20260729190733.72876-2-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729190733.72876-1-acme@kernel.org>
References: <20260729190733.72876-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

CMake warns that compatibility with versions < 3.10 will be removed from
a future version. Update cmake_minimum_required to 3.10 to eliminate the
deprecation warning during build.

CMake 3.10 was released in November 2017 and is widely available across
all currently supported Linux distributions.

Before: CMake Deprecation Warning about VERSION < 3.10 on every build
After:  No deprecation warning

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 CMakeLists.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index a6c329f88e343e66..dc1d742b07531194 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -1,4 +1,4 @@
-cmake_minimum_required(VERSION 3.5)
+cmake_minimum_required(VERSION 3.10)
 project(pahole C)
 cmake_policy(SET CMP0005 NEW)
 
-- 
2.55.0

