Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B58C1DCB21
	for <dwarves@vger.kernel.org>; Tue, 26 Nov 2024 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641816; cv=none; b=GClmZ0APsHYXlAQ+AwCqbWiO/TciIleh9oPS+z4QM3kpsrdxtPF8HjqtIPxE+28uDe4lsvB2sAWj2GlAfBKH6x/Aoy29I942e7PAvNWogNVKyJMGsToqTpBuJOoDsop6tvWlavhcU0hMrih2oaCEjBDUTScBq2ld6z53CLH8TcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641816; c=relaxed/simple;
	bh=v0FQFkfIGSaogGMRew+HIYIyszPU84u+U8lkrEXPncs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fyBdxMdb1TggwGIzdw28WF7yQadJeVU4AOtJGtY68GhJh9mrfCU4Dl8F9A5g7UdraFaTdIP3OY/HySmJdKeOVAauSqQV/yMJ4Be7l16Is4G9LqqdAuJaQ+H2xSFu2E0czLpZ/Fz+bPkp3IySA8S0ka3RXuPpW3FCtFOgWPbcdwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtXvTvqD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtXvTvqD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34073C4CECF;
	Tue, 26 Nov 2024 17:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732641815;
	bh=v0FQFkfIGSaogGMRew+HIYIyszPU84u+U8lkrEXPncs=;
	h=Date:From:To:Cc:Subject:From;
	b=LtXvTvqDbpQrAteXcv0sMGudAb3uRrnVrZfB/pQq0hFvnUU4ly835TEzl1rJLHtdd
	 m/ynmxgEsILybCmfU/TPeCL2UpqBsFzPRFmqf0rk4o6vbSG9xYS6WOUHZN5Ojpu/D6
	 78g4Um66C3SPX04+URKY9qYMdXKay0AitU9xvr57aL3s1fyqd1edxoPNy5ViRWILjE
	 l9ipJf/7MIzzRiU28PmHP4HhtQLP3u+9mozzvPU97suBjZkhzriWpqUYR3DxR2XEDY
	 n4lxRxoP/MSEpzkeqbsko9SbrEMZ7NInTIe89HNwZ9LK87PmA8MG40gWAlBGol+grx
	 veFKfw/cToRow==
Date: Tue, 26 Nov 2024 14:23:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jan Alexander Steffens <heftig@archlinux.org>,
	Domenico Andreoli <cavok@debian.org>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Dominique Leuenberger <dimstar@opensuse.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Guilherme Amadio <amadio@gentoo.org>, dwarves@vger.kernel.org
Subject: [PATCH 1/1] CMakeLists.txt: Require cmake 3.5 or higher
Message-ID: <Z0YEFABQejfGTyrj@x1>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

To address this warning from cmake:

CMake Deprecation Warning at CMakeLists.txt:1 (cmake_minimum_required):
  Compatibility with CMake < 3.5 will be removed from a future version of
  CMake.

  Update the VERSION argument <min> value or use a ...<max> suffix to tell
  CMake that the project does not need compatibility with older versions.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 CMakeLists.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 1d0dadf6eea76158..90fa65c391b6ec47 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -1,4 +1,4 @@
-cmake_minimum_required(VERSION 2.8.12)
+cmake_minimum_required(VERSION 3.5)
 project(pahole C)
 cmake_policy(SET CMP0005 NEW)
 
-- 
2.46.2

