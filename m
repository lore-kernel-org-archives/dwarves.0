Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E91D16190C
	for <dwarves@vger.kernel.org>; Fri, 27 Sep 2024 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727463624; cv=none; b=EZ+pSZVXBWggl+y+9/AN7qM/YobVtM8LaX2rcNmGfIzve1gpvZjn4Mfs8Hvw23SMT1+tqwCqqF1vjCtTsiG5nTV5CXjxiX+T8fPRCXgyKGKIrRRjanbk94SHvW2NCve9bXj54jZrzlPGU02j+yZp45yXd83OVSaBrYUB/rVBP6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727463624; c=relaxed/simple;
	bh=eaJo9bAgM26/jm8JqhR5S/pB3KqbESIcEZCxEjeJJik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QfXf6OmUBuHolo+7V4WaagybjHaQmi83FqGKkF8emIB4INU+gIf2QH/1mmTyiIeTkkopFULmU8H5/Gv8U7Eg564UtusDbXuJ2+SRC/M1Dfqh2omv9ieUQGSw70ggLbCptfyrpyR4lDthj8ffaqnQoFj1eiEf1esn8r5PDR7cHAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAGQysIP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAGQysIP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519A9C4CEC4;
	Fri, 27 Sep 2024 19:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727463624;
	bh=eaJo9bAgM26/jm8JqhR5S/pB3KqbESIcEZCxEjeJJik=;
	h=From:To:Cc:Subject:Date:From;
	b=PAGQysIP31kfMiGnOr0o+hwGcnq+yeULwKpTaIN1OE+jXpRHYIscwlrMEBWzUod2P
	 U+mD67ZmbZKAOkNArdYsb+mLsKQbrskxVN/xLN5O0gWt0p5MqwO61gXOuUvc3PikTE
	 hAhHa6+BTbX29JDxUk2cpBJjtLu691+98DSI9xS/stkj6OKMnp6aRyktxhXM/LigSU
	 givdtM8/pLp9TRd+Yzkx2vyOmpWZyvN99vlGmKUpwdd1EdtwVHStt5w+wAcfCBxSey
	 GCB/bF3fbNUWLuAvH0pvy5Arha7GoNADg/R5ev8IXA/MyI3RmvwxWDFvUucDaD6Ztv
	 BOYYLIIPHVU1A==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Willy Tarreau <w@1wt.eu>
Cc: dwarves@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 0/2] --padding option to combine with --with_flexible_array
Date: Fri, 27 Sep 2024 15:59:56 -0300
Message-ID: <20240927185958.37310-1-acme@kernel.org>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi,

	This implements --padding, that combined with the already
available --with_flexible_array option may catch some questionable
structs.

	This comes from a quick discussion I had with Willy Tareau after
Gustavo's talk at this year's Kernel Recipes.

	I have this in the 'next' branch of:

https://git.kernel.org/pub/scm/devel/pahole/pahole.git

	Willy, is that what you had in mind?

Cheers,

- Arnaldo

Arnaldo Carvalho de Melo (2):
  pahole: Add --padding_ge N to show only structs with at least N bytes of padding at its end
  pahole: Add --padding N to show only structs with N bytes of padding at its end

 man-pages/pahole.1 |  8 ++++++++
 pahole.c           | 17 ++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

-- 
2.46.0

