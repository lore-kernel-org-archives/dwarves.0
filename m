Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB43198A25
	for <dwarves@vger.kernel.org>; Tue, 19 Nov 2024 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732023645; cv=none; b=H7Fcogz+9gH4JISG9SvskfAwVRgkZhSfEh/fqVpkjac2e+Hknb+wc1SSNbiB77G4Tj5Y/lUWwfN7NJ9iirHcLFmvRom5Pgi+9kUJ2gtQa4aFehIvk93B0QBZ1apH/4X5cisU+L3o211TiQT6iAheKo7B0FmNomhJOHsLNonU/1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732023645; c=relaxed/simple;
	bh=UWubTqvQ8+9bmHoq48nJ619f0n3IfIBFTN7YX6Fdc+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B7gETMX6LdMo53AQCv6XW+9Pj7IkZ5VJvbCRXkrZi7HhyR0qYVJP/LE6kqjnHLNDSdjReMW4yt8CdmhXa9jAgmgfIaw4wjK60JuCgefM59+EaVJbo0szVR31UmhBOM2HGqxlRoAzZVK+gPegShtgncPp8xuMYhqIBK4fZ+sj0S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3yTw9vT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3yTw9vT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA9AC4CECF;
	Tue, 19 Nov 2024 13:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732023645;
	bh=UWubTqvQ8+9bmHoq48nJ619f0n3IfIBFTN7YX6Fdc+Y=;
	h=From:To:Cc:Subject:Date:From;
	b=i3yTw9vT/kMbA0+doXFkDqqmy7dqHbEnbeKrtWvExh+BnxFH6KWLjKH2xGQm/+VS2
	 5Xp55WempugV5sZ6YQTOufa8zHIN36M12fPPCDi/YPu9tn6UXGi5M67keWOyD8Cq0b
	 WqU9GFAGpKJl4oa3l+6JwuOAycoyOCs+dEqYoUbLshlbQMuWLtab3ZsXfeGsdKuo5p
	 8fDuKQGVy8zwRDUIILlCMK6iDfiuQQo9NexHPEotPmmJMe6+0VSAtKHxZKbhssWsp8
	 +ZJ/HKDE+dN+s6QfLlfzU3fMJ60mi6U6EhetIYnLBKxrWCVDlCH88qcmeSsWy64RPI
	 bscWj/cu6ETQg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Matthias Schwarzott <zzam@gentoo.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH 0/5] Fix segfaults related to missing BTF support
Date: Tue, 19 Nov 2024 10:40:27 -0300
Message-ID: <20241119134032.783215-1-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry for the top post: Only the cover letter ended up reaching the
mailing list, so resending to have it there :-\

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

