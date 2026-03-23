Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100B437E2EF
	for <dwarves@vger.kernel.org>; Mon, 23 Mar 2026 21:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774300545; cv=none; b=jSjAQpPQh4i+y+dZUihL+KIJyoMueCW/ME76exgL5pfXmDo3nsebln76n42GbXtAMBEcQeqikAFg6rfGyebkzWsG9Chh269ZPiZIbJEeFxRN9hqrk7WdF30Vwy+vdvDtgCg8rkqQj7LjCVv7Z+HGGLW9JSdUCc8nhiCFPHO2r1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774300545; c=relaxed/simple;
	bh=38dbSha0sG7lpWJmkZA6OP82AYpA4nncrrqJ6Uwqz3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aW1u6sDga/2DcZQ7dhkBE8AnlyxTtWRfegWShcniFWpPOEAo0BZlP1avcrE9gYURpOq+R6YnX44n2GWcQ6iGAdIRTptK5/20ybFzQH+wsecmOnVeUjIMrWXekdJfzXTGxqamZ0lJT1Qodmc8IlQqinE/LyYHd77/k0fsyMuyQHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=az5J44ot; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="az5J44ot"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE3BC2BCB0;
	Mon, 23 Mar 2026 21:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774300544;
	bh=38dbSha0sG7lpWJmkZA6OP82AYpA4nncrrqJ6Uwqz3s=;
	h=From:To:Cc:Subject:Date:From;
	b=az5J44otJcEJBCQKEENN44jW+6WBxmK8MvoWknI2G3AcEn4K7d3f7F1LKMDxMjudt
	 4aEDXlEwz4eDKkLQTzNKqiwk3sQ2xmFssvSXBfCYlQSdEl9p1pqAH/RtObLvBeNHpp
	 HM52MtDNfmBcOmy7XYFWX+EYO6RYde0D6SxgPmiviai8DUgqYJ5c7KugdVgyfu0gmm
	 ETzW/t+QpZ/c4nOttRi8FGf289bG+Z/cxqVDtmvebjgSCOIl8db0MihotnlK7plSCo
	 2VsTLAhxT6vLj+CwBztuYcEzUxANCJkVvKMrE9nhIHBrwF6NSwW+D5moKSeG3kOg33
	 uzcTXUr0fs0FQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 0/3] Initial support for some Rust tags + way to ask for CU merging at load time
Date: Mon, 23 Mar 2026 18:15:30 -0300
Message-ID: <20260323211533.1909029-1-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

	Here is a series with some initial support for some Rust DWARF
tags and a way to ask for CUs to be merged just like we do for LTO to
cope with inter CU tag references.

	This makes one of the regression tests to pass again as perf now
has some rust source files and thus Rust CUs in a perf binary built with
DWARF, which is used to test pahole's pretty printing features, where it
uses the DWARF in a perf binary to decode perf.data records.

	As mentioned in the man page, this is hackish, to properly
support LTO, rust, and any inter-CU references we need to yet again
rethink how we do DWARF parallel loading, perhaps leaving the recoding
of ids to be a last step, using a common hash for types to be used at
the recoding of ids, etc, but for now reusing the existing merging of
CUs in such cases provides a workaround.

- Arnaldo

Arnaldo Carvalho de Melo (3):
  dwarf_loader: Initial support for DW_TAG_variant_part
  dwarf_loader: Initial support for DW_TAG_subprogram in
    DW_TAG_enumeration
  dwarf_loader: Allow forcing the merge of CUs for solving inter CU tag
    references

 dwarf_loader.c              | 66 +++++++++++++++++++++++++++++++------
 dwarves.c                   |  6 ++++
 dwarves.h                   |  8 +++++
 man-pages/pahole.1          | 12 +++++++
 pahole.c                    |  8 +++++
 tests/prettify_perf.data.sh |  4 +--
 6 files changed, 92 insertions(+), 12 deletions(-)

-- 
2.53.0

