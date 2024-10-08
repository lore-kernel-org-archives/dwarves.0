Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3A1213ECB
	for <dwarves@vger.kernel.org>; Tue,  8 Oct 2024 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728417141; cv=none; b=L5817PV9nefInD7HvTn5KIJG19+O0+f4P+k7vO7D2SmDsZvUSe9F15/Om9apDuK+2vBvF0WqKJsCfY6oRsnpgMjRhZOfP+WglhzSO/fl4yr0mWw8adlpcHNUou7ZiddnpBtwoSZGHsYWnkIPxRL4Aoy6QAe9wnUJjxdS6QyheKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728417141; c=relaxed/simple;
	bh=O7R5SwTbPBrxU/ZhHQycYappx7l8ibaJV3Hl4pgf6gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QrI3x+Urtr7epBgj7/4ziIHYsE3bRGRKPxY9TbLESI/drJAoXTMR0aloH5+QiiaLO8EmOiptjzR+nuEka8TPWtpq+9dod1t7q7O2FurHE3pkmZJsIFA/CIHV5zDyMkwUBTxDZcBOTSvoTsOmHPB0b/KMKK2L5slZ6Br5mi528XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1hE6Qid; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1hE6Qid"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3984BC4CEC7;
	Tue,  8 Oct 2024 19:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728417140;
	bh=O7R5SwTbPBrxU/ZhHQycYappx7l8ibaJV3Hl4pgf6gc=;
	h=From:To:Cc:Subject:Date:From;
	b=R1hE6QidpxBiaE1sHHVpAdlkgyws4u/emm/pLUdCQRt0NGywcJfMURcmepfAdKiBg
	 ixAWz9bqUC0hoUhEPpzUdBWgIj6CAu4Zf45LKcNEqZRIiD3pLUEjQh+BqMEMV8pujy
	 yzeWeAk691VYRQeKPROLfCAev2kklPaJNPluG7P+6XQhi6SViJUO4uS85HVa+SkYu6
	 WHvvcsMRDyeQVxJwCmsi3l2QgJl0tpdieyzhuUzWEZSOnkSg1/DsiCHBB31jm0JAuh
	 i3gQYXQ/Fye9yjqu4GPMTJWoZ/5lmySmFpKnbMlj4TDLdIPPbkk4x+zdVoAkhacUfm
	 geRiZyPeeSgbw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Willy Tarreau <w@1wt.eu>
Cc: dwarves@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 0/3] Differentiate embedded flexible arrays from flexible ones
Date: Tue,  8 Oct 2024 16:52:06 -0300
Message-ID: <20241008195209.1094299-1-acme@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi Willy, Gustavo,

	Now it has even a regression test, this now have what I think is
needed, take a look at the output of:

   pahole --with_embedded_flexible_arrays > \
	 http://vger.kernel.org/~acme/pahole--with_embedded_flexible_array-6.10.11-200.fc40.x86_64.c

And go on searching for 'flexible' :-)

	Now I'm flexibly moving to other final issues to release pahole
1.28.

- Arnaldo

Arnaldo Carvalho de Melo (3):
  fprintf: Differentiate embedded flexible arrays from flexible arrays
  fprintf: Show statistics about members with flexible arrays
  tests: Add a test for the accounting of flexible arrays

 dwarves_fprintf.c        | 32 +++++++++++++++--
 tests/flexible_arrays.sh | 77 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+), 3 deletions(-)
 create mode 100755 tests/flexible_arrays.sh

-- 
2.46.0

