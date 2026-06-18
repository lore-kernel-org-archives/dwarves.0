Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39112F7EFE
	for <dwarves@vger.kernel.org>; Thu, 18 Jun 2026 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781804002; cv=none; b=Ip5u7ZLug4MjIvvYaagtEMhBXgMd8ETG0dB+XRZrRLfJZobpQxGfCImDoa9h+BWO4CO4IWoE2G0bcPhP6J/wO/Yvbc0TUq3YjEX/FVoKqaZPUc1uuKXEoJiTKUzYjBwqu+A/DNNiBN8RBT8dppNoEsWAX/YN6FTnqGB3mEvXjgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781804002; c=relaxed/simple;
	bh=IrCS2sSd0R1ptfyCeGwzg8DRKid+bIPGzk+KoNj+rzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=craFmWQ9ju5+V8AXDS2DqIWjPeEGp7rvXLa6zmCvRK3psJfQSyegaRD7BM6XBTAO88uTc4j6cxy0zzbEfBc9KmHp9T9WToD2MYEr7KvqTBrV5MdISGJrgTlI5bNzJyMP0SfzvojNmafFpgj1EJ4blKfBcV8gZkftqVdznaX9nHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADxomlWx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADxomlWx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021741F000E9;
	Thu, 18 Jun 2026 17:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781804001;
	bh=DEFwPUvFqKF2ohGb0uznsGxfIL1WZfZlvmQJO1knrJc=;
	h=From:To:Cc:Subject:Date;
	b=ADxomlWx0lzmqVOv0Gs7Mg13rJR03mH7ptmn7SK3CrpDScSvqM/2sA7iSit56ZxeJ
	 IC6GVVgNZ4uceJBni7cGDYQYePO8NMQe2dDZMF32mBzW5wAzxuRraW8EpAZwPd+3Xi
	 oFvVDKn+rkEzTK0af+F1/JDWRqkcLDGNARYVQK0XykgCMQCc5SFTk4ynya3mhi4UAx
	 twU/T+ewG9JPcJ/0jQTyKDYjp0O1WUj8lhF6KAiJl3uoCflKQQ0WQcQi1JtKMWTI+B
	 HW/jAshZyJh+kK+vDWQ22xHtYiMOjzwKbH9te2QeKQ1xu3fYX/bHnyOO2Y2kwvuJpD
	 IutVojeIxSDuA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCHES v2 0/7] Initial support for some Rust tags + way to ask for CU merging at load time
Date: Thu, 18 Jun 2026 14:33:09 -0300
Message-ID: <20260618173316.83598-1-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
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

	Now this is implemented as --features=force_cu_merging,
following a suggestion from Alan, so that we can ask for this, that
albeit not optimal is a way to handle Rust and other cases that may need
this CU merging approach while we don't have something that works in
parallel as without this option.

- Arnaldo

Arnaldo Carvalho de Melo (7):
  dwarf_loader: Initial support for DW_TAG_variant_part
  dwarf_loader: Allow forcing the merge of CUs for solving inter CU tag references
  dwarf_loader: Initial support for DW_TAG_subprogram in DW_TAG_enumeration
  encoders: Fix diagnostic messages for unexpected tags in enumerations
  dwarves_fprintf: Accumulate function__fprintf return value in enumeration printing
  dwarves: Use tag__delete for enumeration children
  btf_encoder: Remove unused variables

 btf_encoder.c               | 17 ++++++----
 ctf_encoder.c               | 16 ++++++---
 dwarf_loader.c              | 67 +++++++++++++++++++++++++++++++------
 dwarves.c                   | 35 +++++++++++++++----
 dwarves.h                   | 19 ++++++++++-
 dwarves_emit.c              | 10 +++---
 dwarves_fprintf.c           | 44 +++++++++++++++++-------
 man-pages/pahole.1          | 17 ++++++++--
 pahole.c                    | 20 ++++++++---
 tests/prettify_perf.data.sh |  4 +--
 10 files changed, 195 insertions(+), 54 deletions(-)

-- 
2.54.0

