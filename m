Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4F32DAFC9
	for <dwarves@vger.kernel.org>; Wed, 25 Jun 2025 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750865013; cv=none; b=C4M7d4mK4gqTuN2c3p8N4jzXlqFQPear7yi3IKUWOESPla/EoOutA/J/NyeXCWK6MzHAczYgv/CS7wr3Mzvih/YuBbekz6Y660gRT7OdxYF6X5yFOSIP69EkckE3QLuNk/9xO+r1g+SQUH+8DUn5+EJASBRSEqCJtRmShphpYP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750865013; c=relaxed/simple;
	bh=7Eo5tzicDfmlj5aK0U3Qjklfbw6BwYxooBGHeqYl8ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lX6YnMXIUMTcqns7WE1kQe7w0DpnJDb5r7oZXwuxFhhUM2tHG4i5QtFq/9udJFKgOGdM4d86ODoZ3mBRgQGWx9gKitXrXrnUeaTmr9ZyD4MgLn32gLibdk+ef34X0UzUtFuYDWP3LmAnjqRmzEEVLz8KKt7DK0G0BWuAO83L6Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cI9knt5U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cI9knt5U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3E4C4CEEA;
	Wed, 25 Jun 2025 15:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750865013;
	bh=7Eo5tzicDfmlj5aK0U3Qjklfbw6BwYxooBGHeqYl8ow=;
	h=From:To:Cc:Subject:Date:From;
	b=cI9knt5UGFRIJVvrRvrstAG4sap3QtJEG777OUiORHJaqEQpmxDB8/yy4eokKL/Rw
	 KjX9ofXpWnd6Nqs8zc7C2dF4Wta2tqa0zUBF5FlO264eUneWn3AyphR1sCvm3HzsaN
	 2IJ9zP684K7UqfT8uGX2+4ORvqjkwO+wykRPXJoUa6tFVjDbDRbV/w9ZIoBQcaO3T1
	 TUQ5rN+/Awp+JPLAHmDDn0f78PIILORvnhcmqMt480sv/AjY7bW0JX0K819B4iY3nn
	 fGBZy/4LY9jF65y+/pInbXcZyeDZJZQ2WKXD0bo4Y7DVyLAz0sQg7+NXVloJj5cdak
	 elqBp4M5fw+yA==
From: Antoine Tenart <atenart@kernel.org>
To: dwarves@vger.kernel.org
Cc: Antoine Tenart <atenart@kernel.org>,
	pvalerio@redhat.com
Subject: [PATCH 0/2] pahole: BTF alignment inference improvements
Date: Wed, 25 Jun 2025 17:23:18 +0200
Message-ID: <20250625152329.28601-1-atenart@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

While generating C code using pahole we noticed alignment issues in rare
cases: when having variable size and 0-length arrays, and when a hole
follows a bitfield. It's worth noticing alignment is inferred when using
BTF as a source as the format does not contain such information. As such
the logic is tricky.

The first patch fixes alignment inference for zero-length and variable
length arrays. The second patch fixes alignment when a hole follows a
bitfield.

I generated a full vmlinux.h using `pahole --compile` before and after
the changes, the differences looked reasonable to me. I've also ran the
project's tests using GH actions.

Thanks,
Antoine

Antoine Tenart (2):
  btf_loader: infer alignment for zero-length arrays
  btf_loader: fix smallest offset in case of bitfields

 btf_loader.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.49.0

