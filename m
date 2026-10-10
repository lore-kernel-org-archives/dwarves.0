Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E76C1ADC83
	for <dwarves@vger.kernel.org>; Sat, 10 Oct 2026 00:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791593553; cv=none; b=qAEF4YawJLZzmveiUU+SCnv5KU8kV9uMQEZS0cR1XTPkbtn0xgXZmH5a6TyfAwRKvreVW/M6hDoyZqZ1qOJIVCkalDlsn/6bWWtLq1Tzsmo36laMI1x/NjUteMdmp9eUNV9nHaT1ipD3uWF45HjRBz+DFn8JqaPRT5BDLPdrHJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791593553; c=relaxed/simple;
	bh=D+QBlXfaJAUuhqc0hqAKzFkFktZSCD48uzIGapZcrPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gfxD7ZvQGSsjqQZKsc7I13g/l5yaw0A26k379xv+RyIVaGprGQDUPKwChr4RjR5g8jRN+oSdHvnmG2rncEuMlfYGdrMRKSwxKIsKSP1OgpHuIN8GJ9Q32BoiI2M5td7/Yj7xjRXY22KdFLLugmWgOK7OIT2kt7RfQVydNr2GmkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alanderk.com; spf=pass smtp.mailfrom=alanderk.com; dkim=pass (2048-bit key) header.d=alanderk.com header.i=@alanderk.com header.b=yoVF+14X; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alanderk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alanderk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alanderk.com header.i=@alanderk.com header.b="yoVF+14X"
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-39e501442e2so225611a91.0
        for <dwarves@vger.kernel.org>; Fri, 09 Oct 2026 17:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alanderk.com; s=googol; t=1791593551; x=1792198351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b+nv/ahniPVLz5y7JEZBuVoxLuh0JYLRNflwWsXXIGk=;
        b=yoVF+14XteZRFdXLE7G1aOL0rU6FjbWpcvH+rp/ofbc0zbTQzDbYqfWBJz2bX4NfHx
         oKh+mRolm4Nn+fvL/M5CuZLBwH+lZiSKNGEYJwFIDX9E9Tnr2DHElEKI7mUFdKJJl0IX
         n+zTVOBP4P/LCg/sE+43RlTIqZgHGzT5LX9Tzck/eEt6qZ5JLMfBACq9hU1hacvZYRk2
         8wMHzqvNw6QNEy7grVR1UG1zji2BH7mYEC14TvGXqIVnZ5cVAMZ8poguzx7Mc9/iR4aK
         9REhRFCrGu5AlwGP3e5TdBUQD9VyWtYH9fwsZykA/eklVaorzaHqaPMa7WQKBmqeKOcf
         x5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791593551; x=1792198351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b+nv/ahniPVLz5y7JEZBuVoxLuh0JYLRNflwWsXXIGk=;
        b=DFRKWBfbIlkigTHxk9d3SOklj5X/vU48GvBloBAMuS1Gx58vMYP+rtwQBxchTBEu7T
         IMrsHHPunoQNJF0D/R0BIe8OGaXP4OQZorwGdej5DMHZZmVqT/ju0lkGVC90NjWUYlEK
         1jMH4hcJW6aawJBvF2awKyeqW9zpvJcuNzOCZNKXA+dDrzIsbfftKfzh7juNg9wVnbdO
         uai3PTeJx2DwhZyo0768MJFzuiFCf3SZL+HMNZYYKgbTtBtpLUo6l7gTDLc+8YFnJs4N
         c5akhI9veiN3M9lLJPlT/VoUL/IdVAn9EdBnrAsYdmVrTmOFbUC+lyBPEgbIE9Swf8gw
         VP1g==
X-Gm-Message-State: AFq9FYLg27eIYhhWfWhtgQOMVVlrkIlZ07DtTSGFjMAC/CZOHnUQwBYG
	1sD1MASE0WX8i8Y52RtqY14j5gksnZBK7/XNF3AYaybSSTUm1b7ETtFXiLCUX4G1DFs=
X-Gm-Gg: AYBFou1335uy7ZELXk5F/8hL4ItJnZJ2EwOuTHH0gtSfuWVI1zxJkR5ZKfNeyRI3dAI
	7A1tq+NacbrxTOd5WTw7O1LkWK+pqTfdBbV0uTcQ93oxTPsDcd+xAlbLhzM7syfwGI/S0+lSjj/
	8TIkh3794Dn+BN6VG7JEcEqPmBUgkLIWY5j56U+ALkVnbLK7KGXhjWglpbR1aUto2fO9QvBc0FW
	CuE1Zfa3ofa5TQY/EYjug2nbqmvJGuLZBrF/TBDRCfmOlJSv/nkcT9WcqnUruGzU+0S+wolFuiU
	gtiOWKj5xSkZJi0+rKmzlgKLApO+1+0ecGbIDUuCGb+6L+WcIEdPyJwRmaeMLJwpY/emzVdKHL3
	ZwqgYawk+rVHZWqqPgY0liKljxo5pUkKuLvH96O4m5WCkIDWy3ZJcMNWxcILHdRg5v57melw5tf
	mVheaocdsVSCXXoZ5CFVCFGKHgiT9ZzYfLjqBHUSIk/Ge5q88Ylzwktb9tUO3XyFpR7+Il7UJ5K
	PwRpdC0piwmD48miIt5N5N8ej4nTm/cfQ==
X-Received: by 2002:a17:90b:48c7:b0:3ab:8b2:72bf with SMTP id 98e67ed59e1d1-3ab3a928525mr3305305a91.50.1791593551362;
        Fri, 09 Oct 2026 17:52:31 -0700 (PDT)
Received: from macmini4.tapir-palermo.ts.net ([138.199.43.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab50ce9d98sm4078226a91.9.2026.10.09.17.52.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Oct 2026 17:52:30 -0700 (PDT)
From: Alan Derk <linux@alanderk.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH dwarves v2 0/2] dwarf_loader: Fix --lang_exclude on merged CUs
Date: Sat, 10 Oct 2026 00:52:25 +0000
Message-ID: <20261010005227.976-1-linux@alanderk.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two fixes for --lang_exclude when CUs are merged, as for LTO objects.

Patch 1 takes the merged CU's language from a CU that is kept, so that
excluding the language of the first CU no longer drops the whole
object. With LTO, this is what makes BTF generation fail for kernel
modules that mix Rust and C.

Patch 2 fixes a second bug from the same commit, which I found while
testing userspace LTO objects after sending v1. With clang LTO, a type
such as int is emitted once and shared through DW_FORM_ref_addr, so
skipping the excluded CUs left references into them dangling: pahole
crashed printing such members, and -J encoded them as void. Patch 2
loads the types that kept CUs use from the excluded CUs. Output without
--lang_exclude does not change, and neither does the BTF of the LTO
kernels I tested.

Patch 1 exposes this bug in one more link order. For a C++ object
linked before a C one, pahole used to drop the C types without any
error; with patch 1 alone it keeps them, and then crashes printing them,
or encodes them as void with -J. Please apply the two together.

As far as I know, patch 1 removes the last thing that keeps the kernel's
RUST option off when LTO and BTF are both on. Once these fixes are in a
release, I'd like to propose relaxing that dependency to something like:

  depends on !DEBUG_INFO_BTF || (PAHOLE_HAS_LANG_EXCLUDE && (!LTO || PAHOLE_VERSION >= 133))

assuming they land in 1.33. The kernel tests in patch 1 ran with
"&& !LTO" dropped from that line, hence the Cc to rust-for-linux.

Changes in v2:
- Add patch 2.
- Patch 1 is unchanged; its note about the Kconfig follow-up moved here.

v1: https://lore.kernel.org/all/20261009201032.40105-1-linux@alanderk.com/

Alan Derk (2):
  dwarf_loader: Take the merged CU language from a CU that is kept
  dwarf_loader: Load types that kept CUs use from excluded CUs

 dwarf_loader.c                  | 129 +++++++++++++++++++++++++++-----
 tests/lang_exclude_lto_refs.sh  |  76 +++++++++++++++++++
 tests/lang_exclude_merged_cu.sh |  67 +++++++++++++++++
 3 files changed, 253 insertions(+), 19 deletions(-)
 create mode 100755 tests/lang_exclude_lto_refs.sh
 create mode 100755 tests/lang_exclude_merged_cu.sh


base-commit: 1e342ac44979748bcf5bb37f84ea055e7f4d7184
-- 
2.55.0

