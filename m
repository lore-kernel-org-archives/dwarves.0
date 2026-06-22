Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DD234D3B0
	for <dwarves@vger.kernel.org>; Mon, 22 Jun 2026 20:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159926; cv=none; b=pCOhQfwjsnDZ7s/3X/oHG32FwaDZYaOvPocVmqJUz4z3J/+xstIejej+sp147tStCX7ZvD2I/IF5pJ4dE8F6yr9eXS3Y8aRnY3GyY+OfpG74/10EllMRk9LAC/hmeApw673FUBl1iw3yU3h28Hmdzv7IbBn88gxorDHf1rYOSVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159926; c=relaxed/simple;
	bh=YrN5GfhHpYXz4JN8vs/m9lne/vhM6MSjUOstfICQY4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnBd4fdguYv6to1i3Rs1knDWgAjanDwnqI2aF9IqIIcfwgyigWmgw5DUVXKtZEhKjak8ECbc4+7Lu63ulawBlwtnMDXVea+XVPtNSdS366KMpdHu6zsCzWMaZvQYJHm21GILMBybpvaPipjbBI0rcMJGNeiR9repAwfHhP8IwZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkDDYBGe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkDDYBGe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354701F000E9;
	Mon, 22 Jun 2026 20:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782159925;
	bh=SRnj9FUclJpys9mt5vRXTMmZCXCwC41mlcpE0p9eAuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dkDDYBGePYzMILIEMGzh48bxrGrRjLW8dME7YzHkJz4VcXQ9laAFJtoYmbslTcfSK
	 ulUlK2oSQkJs5Y0pT72WJQzeFGPF/QxECzSQ5mSvFNE/sohTxDVNd7xUBbAlqiv74+
	 0l2UejK+BefQ29lRyReDLtethNwbs4FW36X7PgoHp/BKQ1GGeCMZocO5Nu82B1UqLZ
	 czeAORiGoNl/lOPyzjOSy+U2ItERvJM0lI/UNeosV+t3SpGxiLdgh556GLg2HH5Qi7
	 SXxNULXUSn0jZtUZtw2KbUf6fRsI2px9mbp386klxCHaiwUoaPZF2AOSb2+ObQAFVn
	 vk5XXglj8Ey9A==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	dwarves@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 16/16] tests: Source test_lib.sh via dirname so tests run from any directory
Date: Mon, 22 Jun 2026 17:24:39 -0300
Message-ID: <20260622202441.14799-17-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622202441.14799-1-acme@kernel.org>
References: <20260622202441.14799-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The test scripts sourced test_lib.sh using a bare filename (source
test_lib.sh or . ./test_lib.sh), which only works when the current
working directory is tests/.  Running a test from the repository root
(e.g. tests/inter_cu_refs.sh) would fail with "test_lib.sh: No such
file or directory".

Use $(dirname "$0")/test_lib.sh so each script locates the library
relative to its own path, regardless of the caller's working directory.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tests/btf_functions.sh        | 2 +-
 tests/btf_type_tag_order.sh   | 2 +-
 tests/default_vmlinux_btf.sh  | 2 +-
 tests/flexible_arrays.sh      | 2 +-
 tests/gcc_true_signatures.sh  | 2 +-
 tests/inter_cu_refs.sh        | 2 +-
 tests/pfunct-btf-decl-tags.sh | 2 +-
 tests/prettify_perf.data.sh   | 2 +-
 tests/reproducible_build.sh   | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
index 127640e158b70805..351412a4c6a8ccb9 100755
--- a/tests/btf_functions.sh
+++ b/tests/btf_functions.sh
@@ -8,7 +8,7 @@
 # also should have been.
 #
 
-source test_lib.sh
+source "$(dirname "$0")/test_lib.sh"
 
 vmlinux=$(get_vmlinux $1)
 if [ $? -ne 0 ] ; then
diff --git a/tests/btf_type_tag_order.sh b/tests/btf_type_tag_order.sh
index 09d1ac346000bb6b..0e671ae538603d2b 100755
--- a/tests/btf_type_tag_order.sh
+++ b/tests/btf_type_tag_order.sh
@@ -3,7 +3,7 @@
 
 # Check that pahole preserves btf_type_tag order when emitting BTF from DWARF.
 
-source test_lib.sh
+source "$(dirname "$0")/test_lib.sh"
 
 outdir=$(make_tmpdir)
 
diff --git a/tests/default_vmlinux_btf.sh b/tests/default_vmlinux_btf.sh
index 496e840bfbec8f3a..b3d6e9cff8719e5f 100755
--- a/tests/default_vmlinux_btf.sh
+++ b/tests/default_vmlinux_btf.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-source test_lib.sh
+source "$(dirname "$0")/test_lib.sh"
 
 title_log "Default BTF on a system without BTF."
 
diff --git a/tests/flexible_arrays.sh b/tests/flexible_arrays.sh
index 4e9e995271ce816f..6443449b50e6c9c2 100755
--- a/tests/flexible_arrays.sh
+++ b/tests/flexible_arrays.sh
@@ -5,7 +5,7 @@
 #
 # Arnaldo Carvalho de Melo <acme@redhat.com> (C) 2024-
 
-source test_lib.sh
+source "$(dirname "$0")/test_lib.sh"
 
 vmlinux=$(get_vmlinux $1)
 if [ $? -ne 0 ] ; then
diff --git a/tests/gcc_true_signatures.sh b/tests/gcc_true_signatures.sh
index 9ebe1fa6c32f7bf7..96b282be5dba721a 100755
--- a/tests/gcc_true_signatures.sh
+++ b/tests/gcc_true_signatures.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0-only
 
-source test_lib.sh
+source "$(dirname "$0")/test_lib.sh"
 
 outdir=$(make_tmpdir)
 
diff --git a/tests/inter_cu_refs.sh b/tests/inter_cu_refs.sh
index 6827bf83931eb3ed..0df0ce13cd948f1f 100755
--- a/tests/inter_cu_refs.sh
+++ b/tests/inter_cu_refs.sh
@@ -10,7 +10,7 @@
 # that the automatic detection produces the same output as explicitly
 # forcing CU merging.
 
-. ./test_lib.sh
+. "$(dirname "$0")/test_lib.sh"
 
 outdir=$(make_tmpdir)
 trap cleanup EXIT
diff --git a/tests/pfunct-btf-decl-tags.sh b/tests/pfunct-btf-decl-tags.sh
index 520148b2ccef15b2..25d9cd6d4ad8551f 100755
--- a/tests/pfunct-btf-decl-tags.sh
+++ b/tests/pfunct-btf-decl-tags.sh
@@ -3,7 +3,7 @@
 
 # Check that pfunct can print btf_decl_tags read from BTF
 
-source test_lib.sh
+source "$(dirname "$0")/test_lib.sh"
 
 outdir=$(make_tmpdir)
 
diff --git a/tests/prettify_perf.data.sh b/tests/prettify_perf.data.sh
index 384c250ff4e01a4c..ae0a7d995da6cad2 100755
--- a/tests/prettify_perf.data.sh
+++ b/tests/prettify_perf.data.sh
@@ -7,7 +7,7 @@
 # Check if the perf binary is available, if it is from a distro, normally it
 # will get the needed DWARF info using libddebuginfod, we'll check if the
 # needed types are available, skipping the test and informing the reason.
-. ./test_lib.sh
+. "$(dirname "$0")/test_lib.sh"
 
 outdir=$(make_tmpdir)
 
diff --git a/tests/reproducible_build.sh b/tests/reproducible_build.sh
index d8c6507526bdfbbc..7b7a5afd1fe4e50d 100755
--- a/tests/reproducible_build.sh
+++ b/tests/reproducible_build.sh
@@ -4,7 +4,7 @@
 # Test if BTF generated serially matches reproducible parallel DWARF loading + serial BTF encoding
 # Arnaldo Carvalho de Melo <acme@redhat.com> (C) 2024-
 
-source test_lib.sh
+source "$(dirname "$0")/test_lib.sh"
 
 vmlinux=$(get_vmlinux $1)
 if [ $? -ne 0 ]; then
-- 
2.54.0

