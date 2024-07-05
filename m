Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1141CD02
	for <dwarves@vger.kernel.org>; Fri,  5 Jul 2024 23:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720223748; cv=none; b=W30czpa1iaoqmYVV4Vsf4ehm7RWiOBNBdHZXTDS51umuuTR9IpfeZF0FfyI61C4udJWD2s6R15wy8eOo+1fFNYQqGQMfFL5Xp1W2coEUCRUTiCrRtKj4GNi3V1SMlAKBY5gCGPs3qbi3l+YBxXKRlR5iLCqVCrRLYcSe/+V3Cks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720223748; c=relaxed/simple;
	bh=A3jzj5QWMr6+9Soq5T4m3QWaFAstOUdbmf9v4z8+HRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oVesRVt1Lc1OUjdyITGdBiStnVDer7wmin/DfRob90l4pGxLgbTTthRqpSPpZiWzNeOui1YBuHCkki3lfZ8lu9qk9C739B9K9Ku33lWPC8uH3QgaUkJMkoQNz1oW8gWQ85c/mhVPQhag5q7jEtIbZFTe9gq/bioT6Vj1XnRcLZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Da4jWfSC; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Da4jWfSC"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id D6CAB14C1E1;
	Sat,  6 Jul 2024 01:55:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1720223736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xiHMRvuCBoFRvoyM8G6nICk3uXlp1xN9QywGfQvSBoQ=;
	b=Da4jWfSCu/X7d1udX8yyisJJ2CXdtYIKAqV0GV4Y67zmMrj3Wx06RVccJtgeLGChfkrJEk
	5F8YfcxSnCU+5+RitdmshQUWISCxYLCY5yLqwzUexcSrweiM5MG9oY2j91hmIr0M2Ou5Mj
	CGQFlCfedgUEhUByqgxlG4HLkyt6vxOuIVyZ+eDYa3yuMT3QQD+oKoEGaQxxQUHdVyY/O3
	sE+G4sIUhs+7AWOx3D8/5HV2hC2/o5QnrnDe9e/e1njDsfq5qv7Alw7BCtHu/PxQkHTsQL
	t5qhl1emDp0KGtfmPwo4vkjJPa2AOoy10whRWU/FpcjE9Bm+o9QtBNoAR2Ydjw==
Received: from gaia.codewreck.org (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 3d893385;
	Fri, 5 Jul 2024 23:55:32 +0000 (UTC)
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
Subject: [PATCH dwarves v2] pahole: enable --reproducible_build when SOURCE_DATE_EPOCH is set
Date: Sat,  6 Jul 2024 08:55:18 +0900
Message-ID: <20240705235518.504490-1-asmadeus@codewreck.org>
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
v1 -> v2:
 - added message in verbose mode if setting reproducible build through
   this.
   I wasn't quite sure what is least intrusive message-wise -- most
   verbose messages just go to stdout, but using pahole in a script to
   extract some c structs would see this mangled in output which is
   obviously not great. Since --reproducible_build only impacts BTF
   generation at this time, I'm only checking when generating BTF to
   avoid such needless messages -- btf generation always goes through a
   file so there is no risk of mangling the output in this case.

 pahole.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/pahole.c b/pahole.c
index c866095c8be6..2792e11265d6 100644
--- a/pahole.c
+++ b/pahole.c
@@ -3705,6 +3705,15 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
+	// SOURCE_DATE_EPOCH being set means whoever called us likeely tries
+	// to do a reproducible build. The setting only impacts btf_encode code
+	// so only check in this case to avoid needless messages.
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

