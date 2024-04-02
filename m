Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1F515B962;
	Tue,  2 Apr 2024 19:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086795; cv=none; b=hgcrL7IAJibCQ/secgKSm5Z9zWQVjl/MMVqvUBWU+ZEKvF7RV1CqMUQCRmDa+ofk8jqdcdQh54iKLwn0Se0GQCiXy9l2qc7N20nbKcr6ifmbGVOkgOzmIDrAlzvoHCHW4xuzygicIX0mMH2yM5HYMOa+h6++o+8bhraYRKNYTC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086795; c=relaxed/simple;
	bh=8dApHdSNyHftwwFY/JAFmeUZUoZSAM0rdqqv2yPJntE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oyNN/dNSGNn6KXtLy3OdyO/lLISjwYm78utcG3QiqfrmyuQ6R0tMwmFj01ctIY6Jd1oD77y8DYAn1RWYHyLAzWrZxPy9+rlkU8qq5DouYCqTPKu7gfmfcdP3KLRc3saQ66SFcBN0GxE9iPgO1p3VSXZWORdF1SPXE1cMHqr62fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ln4Bl6GD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ln4Bl6GD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5096C43390;
	Tue,  2 Apr 2024 19:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086794;
	bh=8dApHdSNyHftwwFY/JAFmeUZUoZSAM0rdqqv2yPJntE=;
	h=From:To:Cc:Subject:Date:From;
	b=Ln4Bl6GDps6Q/KCVLVsg/D+dEkBB8RrsH6ZtPFiLHHQUU2K6lOpsxHZk4HQIaEGDA
	 wfdkbswYc90aapJopJWgn8ACDsdAR22Oi8wkNkUJ1B3Ucois6e0pmaJtEAkeKNwko4
	 evMhzEJCvYQN6+wpEkDYEg9qZHFnTVUreRDAa9oTA474ngSDsPBnmGosl54tt2qm+C
	 ef0Bq0bIDmdRZfeBzTWbLnB7ITRXUr3TUi1bG37fDrCWaLFPBPriUOzQVatCwrCIpI
	 1y7KGq59LY6IdDmKQJSRbQR0QaWjb2pMbgjoWgDW4QCXNbOP29JUcp7cvLhAcsaqHp
	 84UOFH+LaVT6w==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: dwarves@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Kui-Feng Lee <kuifeng@fb.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [RFC/PATCHES 00/12] pahole: Reproducible parallel DWARF loading/serial BTF encoding
Date: Tue,  2 Apr 2024 16:39:33 -0300
Message-ID: <20240402193945.17327-1-acme@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

	This allows us to have reproducible builds while keeping the
DWARF loading phase in parallel, achieving a noticeable speedup as
showed in the commit log messages:

On a:

  model name    : Intel(R) Core(TM) i7-14700K

  8 performance cores (16 threads), 12 efficiency cores.

Serial encoding:

  $ perf stat -e cycles -r5 pahole --btf_encode_detached=vmlinux.btf.serial vmlinux
             5.18276 +- 0.00952 seconds time elapsed  ( +-  0.18% )

Parallel, but non-reproducible:

  $ perf stat -e cycles -r5 pahole -j --btf_encode_detached=vmlinux.btf.parallel vmlinux
              1.8529 +- 0.0159 seconds time elapsed  ( +-  0.86% )

reproducible build done using parallel DWARF loading + CUs-ordered-as-in-vmlinux serial BTF encoding:

  $ perf stat -e cycles -r5 pahole -j --reproducible_build --btf_encode_detached=vmlinux.btf.parallel.reproducible_build vmlinux
              2.3632 +- 0.0164 seconds time elapsed  ( +-  0.69% )

Please take a look, its in the 'next' branch at:

  https://git.kernel.org/pub/scm/devel/pahole/pahole.git
  https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=next

There is a new tool to do regression testing on this feature:

  https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=next&id=c751214c19bf8591bf8e4abdc677cbadee08f630
  
And here a more detailed set of tests using it:

  https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=next&id=4451467ca16a6e31834f6f98661c63587ce556f7

Working on libbpf to allow for parallel reproducible BTF encoding is the
next step.

Thanks a lot,

- Arnaldo

Arnaldo Carvalho de Melo (12):
  core: Allow asking for a reproducible build
  pahole: Disable BTF multithreaded encoded when doing reproducible builds
  dwarf_loader: Separate creating the cu/dcu pair from processing it
  dwarf_loader: Introduce dwarf_cus__process_cu()
  dwarf_loader: Create the cu/dcu pair in dwarf_cus__nextcu()
  dwarf_loader: Remove unused 'thr_data' arg from dwarf_cus__create_and_process_cu()
  core: Add unlocked cus__add() variant
  core: Add cus__remove(), counterpart of cus__add()
  dwarf_loader: Add the cu to the cus list early, remove on LSK_DELETE
  core/dwarf_loader: Add functions to set state of CU processing
  pahole: Encode BTF serially in a reproducible build
  tests: Add a BTF reproducible generation test

 dwarf_loader.c              | 73 +++++++++++++++++++++++---------
 dwarves.c                   | 58 ++++++++++++++++++++++++-
 dwarves.h                   | 17 ++++++++
 pahole.c                    | 84 +++++++++++++++++++++++++++++++++++--
 tests/reproducible_build.sh | 56 +++++++++++++++++++++++++
 5 files changed, 264 insertions(+), 24 deletions(-)
 create mode 100755 tests/reproducible_build.sh

-- 
2.44.0

