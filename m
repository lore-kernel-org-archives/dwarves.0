Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B49361FC5
	for <dwarves@vger.kernel.org>; Wed, 26 Jun 2024 03:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719372204; cv=none; b=WsgsaXYA5GU40e3gCECknwWHsbmhRdFDDrnwMHZ0Fbv/GOouQMpDEZ7SweCBKTf3mYlg5kzJXLJcocLqUl2s3VRj1WC4fClQRjRv8VfGUDdnpKegwBVDbJrNCUdaZKkiijp6aGJ1qLyXqNPG2Y/3TT3aUAa4EbNGUgp6holCvUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719372204; c=relaxed/simple;
	bh=PP3pWRue+fVW8qkSLD4C2Ewl0LSGh74nSheMiTs4vS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iQ/x2mN579mgpsdKhNNiQ+ai2TdJazJ342CpWZkeOy6lkTF3g7s/5yrkIV1cwYchp4dRdz7egMS/r4cuvFXcziMG5giOH8A7PoGsScllxl5id9o0WM4lMGPM74yNoQkDCOsVuaHt3kkfOnQKreKaDEYMdl0KVrPMoNyq5XZE//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=axzPwRTk; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="axzPwRTk"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 0F3C714C1E1;
	Wed, 26 Jun 2024 05:23:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1719372193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0da/KkVCOeAa73utcgkcQ3pjqniKAAGhhU6PYZb7fd0=;
	b=axzPwRTkOaOjpR4wY8iZ/75UDi282WTU5+2DDf7w3xD6Zs4/RlXeOQ62vgUeMK81/p1HIR
	qHoHn9e6SB0cM9TD9iS3SwVjeViyMiUTf83tks/BAIiTh113ikhjKc6BjDSNyt/2o/t0T3
	m2hAUlrIXAQOTwFPJ1MuQpKl+t1IF2qzq3CVrsh97eq1eSnPCUXN1VovIt0HhcmXN71nI5
	ldqfglbHU35e8BGwGLivbBy546FVqS72Fm1m8REW75uVN2M6wQQ1fhIjwMiV1YALwHp1ew
	xuggwAK+onhxA1NXJz2dHWbZzYo8Vthx/7R6/rD36ABY1/FjayJzfm0swFEkiA==
Received: from gaia.codewreck.org (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 0682d12a;
	Wed, 26 Jun 2024 03:23:06 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
To: acme@kernel.org
Cc: andrii.nakryiko@gmail.com,
	dwarves@vger.kernel.org,
	jolsa@kernel.org,
	williams@redhat.com,
	kcarcia@redhat.com,
	dxu@dxuuu.xyz,
	eddyz87@gmail.com,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH dwarves] pahole: enable --reproducible_build when SOURCE_DATE_EPOCH is set
Date: Wed, 26 Jun 2024 12:22:53 +0900
Message-ID: <20240626032253.3406460-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.44.0
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
that the user wants a reproducible build if this variable is set.

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
---
I opened this as https://github.com/acmel/dwarves/pull/51 a couple of
weeks ago but I guess sending by e-mail is probably more appropriate.
(I didn't find a MAINTAINERS list or similar so sending to recipients of
a random patch I found, please tell me if I missed someone)

(Note that because --btf_feature init is lazy setting something like
--btf_feature=default could override this if we set it too early, so I'm
only checking the env var after argp parsing)

 pahole.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/pahole.c b/pahole.c
index 954498d2ad4f..2b010658330c 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3705,6 +3705,10 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
+	/* This being set means whoever called us tries to do a reproducible build */
+	if (getenv("SOURCE_DATE_EPOCH"))
+		conf_load.reproducible_build = true;
+
 	if (languages.str && parse_languages())
 		return rc;
 
-- 
2.44.0

