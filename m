Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2CC13E8AE
	for <dwarves@vger.kernel.org>; Mon, 18 Nov 2024 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731962539; cv=none; b=gZPWZXMk/SIzdeRUzIty4pRTh+wpDNhuOnHNJG90sWuTaBGEqNvP+/RNBkFq4biWcjDXuOcWF28V8nIrqM5k5PESOQmy7E+4BgC72TBGmW7DDMSMiYlvRgKH8saXwotCYIIqTvrNb5MbDMBKrM5DMReYJMvo9/Oqchx5XlFFiE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731962539; c=relaxed/simple;
	bh=65xtKVq1anaiaokryAlNHeg7tVtmtcCHYLrDg8ynBNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qy1Yiu/U2ejiaNyaLPm3JGRjygn3EZOqS35F4MbTldeP2nZci68NYh6vQyB5/5g7U7Js2vOMYv8NVH78r8OPCtq7O5THUHAbRDdoDBFV8uhJnrokdmLGVp68zOGjuvBg5n1YFf+30Cx3/UY05fZOa5TmXiMU1V9uEH79VNYKBPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d137Bc6n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d137Bc6n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7287FC4CECC;
	Mon, 18 Nov 2024 20:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731962538;
	bh=65xtKVq1anaiaokryAlNHeg7tVtmtcCHYLrDg8ynBNM=;
	h=From:To:Cc:Subject:Date:From;
	b=d137Bc6nYgYR8COdf+rLEcv3ZbpgFsNI+RNkhjV+bPQvAKbRggOx6jIjYid5n9p/Q
	 bWGAgfiQVR9z1P17WfqcsnGb8cEQoq3JcDWjOkolPGEf+I+rvpG3VD7WBWas72NDGl
	 K2mNKgyooe0Y6MS9urI/kx1nyA/eAahoyFYvVuzcA9/1WtWmRtyEAMD8ZuO2vHcK+C
	 Esz+fHzNOPypdOTZTx0zItV+0fRuHeUn/eu46fIZl0arutj3zYON+H7HnSFQo9DQPs
	 k86YOQGa8pr4uQTOiCDpT2A/bZgdi2XYP8eE7yha7GirELMQg0Vlx7TrgXpzbua3cg
	 DZ238A43tu0bA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	dwarves@vger.kernel.org
Subject: [PATCH 0/5] Fix segfaults related to missing BTF support
Date: Mon, 18 Nov 2024 17:41:41 -0300
Message-ID: <20241118204146.772762-1-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

	While looking for reports to fix before release 1.28 I got to
Matthias reports about segfaults in systems where BTF isn't present, so
I introduced a regression test and infrastructure to allow testing
handling such a system, please take a look.

Thanks,

- Arnaldo

Arnaldo Carvalho de Melo (5):
  core: Add method to get the vmlinux BTF filename, allow overriding it via env var
  tests default_vmlinux_btf: Introduce test for using BTF by default
  pahole: Honour exclusive BTF loading
  tests default_vmlinux_btf: Cover the no args segfault too
  core, libctf: Check if constructor arguments are NULL before using them

 dwarves.c                    | 33 ++++++++++++++++++++++++++++++---
 dwarves.h                    |  2 ++
 libctf.c                     |  3 +++
 man-pages/pahole.1           |  4 ++++
 pahole.c                     | 11 +++++++++--
 tests/default_vmlinux_btf.sh | 32 ++++++++++++++++++++++++++++++++
 6 files changed, 80 insertions(+), 5 deletions(-)
 create mode 100755 tests/default_vmlinux_btf.sh

-- 
2.47.0

