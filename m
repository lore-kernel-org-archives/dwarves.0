Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BF0DDC0
	for <dwarves@vger.kernel.org>; Sun,  7 Jul 2024 08:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720342257; cv=none; b=PDfqr9+8SmJbUuc6HgQqKb6FiOJWTb8RlNITf6TdnqiM+j8ncM5d8t1fKqpTHD7FT/OHweuQa2BOwwRClSM6MjrGJPO7KBFESIpXjo3t3VG1NgtG65rqacOBob9mSYfH+BSirgyq3yoiZWHnW7RxShfBSo33ldnToVUoZaRbM3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720342257; c=relaxed/simple;
	bh=vargsny2C6H0na9ykxzYu4whs6ohS8fIq6WM0+MP+xI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KaAyCaQFEk3Y2L6mXRijiz8r2PcyXvNPzxsxJy021k2DYL8N5DtM1KiGqGrTjqZrYWW1KLiWUfh4en7RLXvNsXvM7cVA2Ic/gBykAlaKVxo9Ps52Sw3dahaF+GuPtS+Okvryhyp4zbIeI3FK8lsXWO1XYFxEq4QLqLrk0qJSY+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=JJwJzKpB; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="JJwJzKpB"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id F15D514C1E1;
	Sun,  7 Jul 2024 10:50:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1720342245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tU1hGq5AwFBJkPdXAQ4rVTrSxm/oTvGD/FChlMYZw88=;
	b=JJwJzKpBa8llODdeP7LTmEBREhB6hMbujHfYKzoDcv0U0bdxxBE3heY0B75PtdXRgpAy1Q
	HPA3jSMLAVfcN8xQQH+1pequ6G9YxuEptzHJTIMUAWjPwJSM9Dup/UVxUF/1c+3+kPBaOO
	kRp+AwBU3GotABaTokTjviLevDFMwuqAJswKDOqt1KVnhawYceRgRb5wwdXuQdb4WZg/HZ
	/4wBiaRx5d6tvqF2nbbcjmPtrH0W79RDlpbc82yS5dnMQ71vWMW4HvvPLspXHZhC00ZMLI
	7JG0B9e5k2dCDnEapAo/IJsNYb9fDf62B2zE8ZJbHBa76EcpizRPXMIW2GrGgw==
Received: from gaia.codewreck.org (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id d64e22d5;
	Sun, 7 Jul 2024 08:50:41 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
To: Alan Maguire <alan.maguire@oracle.com>,
	acme@kernel.org
Cc: andrii.nakryiko@gmail.com,
	dwarves@vger.kernel.org,
	jolsa@kernel.org,
	williams@redhat.com,
	kcarcia@redhat.com,
	dxu@dxuuu.xyz,
	eddyz87@gmail.com,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH dwarves v3] pahole: enable --reproducible_build when SOURCE_DATE_EPOCH is set
Date: Sun,  7 Jul 2024 17:50:36 +0900
Message-ID: <20240707085036.562784-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The SOURCE_DATE_EPOCH environment variable is used in reproducible
builds to set build timestamps and is generally synonymous with
reproducible builds: instead of making users figure out how to pass
pahole flags (e.g. explicitly setting PAHOLE_FLAGS in linux) just assume
that the user wants a reproducible build if this variable is set,
printing a debug message in verbose mode.

The impact on build time appears to be minimal enough even if we
incorrectly make this decision (on a Ryzen 7 7735HS):
$ hyperfine 'sh pahole-test -j --reproducible_build' 'sh pahole-test -j1' 'sh pahole-test -j' -p 'cp .tmp_vmlinux.orig .tmp_vmlinux.btf' -m 4
Benchmark 1: sh pahole-test -j --reproducible_build
  Time (mean ± σ):      3.991 s ±  0.045 s    [User: 7.223 s, System: 3.741 s]
  Range (min … max):    3.950 s …  4.042 s    4 runs

Benchmark 2: sh pahole-test -j1
  Time (mean ± σ):      7.083 s ±  0.095 s    [User: 4.805 s, System: 2.242 s]
  Range (min … max):    6.964 s …  7.191 s    4 runs

Benchmark 3: sh pahole-test -j
  Time (mean ± σ):      3.858 s ±  0.089 s    [User: 13.447 s, System: 7.078 s]
  Range (min … max):    3.763 s …  3.978 s    4 runs

Summary
  sh pahole-test -j ran
    1.03 ± 0.03 times faster than sh pahole-test -j --reproducible_build
    1.84 ± 0.05 times faster than sh pahole-test -j1

Where pahole-test is the pahole command of the linux build (minus -j):
LLVM_OBJCOPY=objcopy pahole -J --btf_gen_floats --lang_exclude=rust --skip_encoding_btf_inconsistent_proto --btf_gen_optimized .tmp_vmlinux.btf "$@"

And .tmp_vmlinux.orig was the .tmp_vmlinux.btf binary before being
processed:
ld -m elf_x86_64 -z noexecstack --no-warn-rwx-segments --emit-relocs --discard-none -z max-page-size=0x200000 --build-id=sha1 --orphan-handling=warn --script=./arch/x86/kernel/vmlinux.lds -o .tmp_vmlinux.btf --whole-archive vmlinux.a .vmlinux.export.o init/version-timestamp.o --no-whole-archive --start-group --end-group

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
v2 -> v3:
 - added message about the env var to man page.
 - fixed typo / style of comment in code

v1 -> v2:
 - added message in verbose mode if setting reproducible build through
   this.

 man-pages/pahole.1 |  3 +++
 pahole.c           | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index f0605935a9f1..d9c2c1ac6912 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -327,6 +327,9 @@ If one wants to add an extra feature to the set of standard ones, the '+' prefix
 \-\-btf_features=+reproducible_build will add all default features plus the 'reproducible_build' extra
 feature.
 
+Alternatively, reproducible_build will also be enabled if the SOURCE_DATE_EPOCH environment variable
+is set, as that is commonly set in build systems that aim for reproducible builds.
+
 .TP
 .B \-\-btf_features_strict
 Identical to \-\-btf_features above, but pahole will exit if it encounters an unrecognized feature.
diff --git a/pahole.c b/pahole.c
index c866095c8be6..7724980ff106 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3705,6 +3705,17 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
+	/*
+	 * SOURCE_DATE_EPOCH being set means whoever called us likely tries
+	 * to do a reproducible build. The setting only impacts btf_encode code
+	 * so only check in this case to avoid needless messages.
+	 */
+	if (btf_encode && getenv("SOURCE_DATE_EPOCH")) {
+		if (!conf_load.reproducible_build && global_verbose)
+			printf("pahole: auto-enabling reproducible build (SOURCE_DATE_EPOCH set)\n");
+		conf_load.reproducible_build = true;
+	}
+
 	if (languages.str && parse_languages())
 		return rc;
 
-- 
2.45.1

