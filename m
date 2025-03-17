Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8F11FECB6
	for <dwarves@vger.kernel.org>; Mon, 17 Mar 2025 22:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250269; cv=none; b=jUSfQlzVL65k7yGidqJySsrcDFZ+yqmhDSxhZSUF73ohLiF0I9YfBYL0mtbBDsDgcAdADwqhxcLdFSuAqg8CZz/AYNW/2Z0wBJq0xxTvvdvqZUyP/PWiRKsVWnQdfohDK+x9I87y9GU/ZvUecYXM0am38kxYs9ZIcEPn9/XQdow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250269; c=relaxed/simple;
	bh=rKlaSfeOL/ClT9nMnyH/t8r9RRBB2gXlo6EGvOf05qo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=McSBBY8RjwiUbWC1DYNi5nEIJ13Yz78hnhBIZXPwDJ12wRqw4J/9wZad/ojjYPqZjXxcQT8FBU5CjiTQGglCRMb3T2Jh4RbYpUbHASUXAm2kQbwdTtJAZ8CG3Tl2DURNTzfkChDFa0aYnnGEirwyrgitpndgqlWyuoEUnKGrJBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3BtmeZ7M; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3BtmeZ7M"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2242f3fd213so72978685ad.1
        for <dwarves@vger.kernel.org>; Mon, 17 Mar 2025 15:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742250268; x=1742855068; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bppswTLwyuw8FSA9NviSJa6kYnh7VslUHPOj1zMFbvg=;
        b=3BtmeZ7MYCyQkldurUUHeiSdTh3T9LAG6hFk/ogmLxwu1DQofD36dB7vU0rYoUgcZn
         yKbscyeiYbYe1Lk0oa5Wk3IiuivTcdSvbks+IlxLzpUU5Rk8nB0A4gFYJaTgD7ESjldO
         h5l4OMmElZV2HnSZSDHbAaYA0oksbtGK7RLxSgoYGJCjQ+EVVuWi5Pm6NZbgrDx1tLuq
         7CELSq6jvLSrvCz6LB7HvSdn0TOJ68HZbOlJd+ds9wjLUrA6b0vhORYdNaAe833gzEWm
         U1Ktrpic4AblGe7G8eOhOG4413vUyKoCAXAMEGOgHlKVgjRiP5NypWnpwqfQp95c4uGf
         N/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742250268; x=1742855068;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bppswTLwyuw8FSA9NviSJa6kYnh7VslUHPOj1zMFbvg=;
        b=Tb6klR7nydoMbxBBwmORLD6n1rIaUuaFiDFZZM8bU2AofrpTNJf3J1niF58HPgAweO
         CGbE7AfIvPm9/m/ZVMVhQRyd8ooSpk/iR4ASgCFfWGl5pJtFCFX1aOMMOtKgGlCLdVSq
         L9tEoYLFmBvN7JgG1NcJiisvmkAB2TPF4QRrqN8DqUtBYHavX7M7+HESR3Ghh1KQDDe2
         gwJscb8yedFAGTTUwv9mY6UpC6wQKFYMwPdGslen8zSVgUm+rkvCKOnOYG2jvv0RwHAT
         IELGgz670YADabwJjcexJMcjC/BVAWFgW7SMhj8446S3t2iqsaIJy0ip0mufK95ihBVD
         Majg==
X-Gm-Message-State: AOJu0Yw/M3GJ4qRqPfYKbXVMpZGFw5+MX4qCC2SaNYS8xapkIW+ncqQz
	ZX+pwA6NFd91j0fSUdKSL8bW8bRwKl0OCcKi223HYy8ayKZHl3Yz/wJ3zqwjFq8wS2Dw2zKy9Uu
	MDg5NAEW6TG/UR1oDMPKedlfGqeH2WKeHFgGBlCHi9q+Xs0kByUBG6qzrLlKsNVPfQvwe98ig97
	cITpgKGQQvkFdFbpZtvcO5jOHpoCZtFofj7+1SG5zzzvaa2k6/xipmjB2SiwGKybgUZQ==
X-Google-Smtp-Source: AGHT+IHLmcNi0Ym0nS0iDdRoTURL2g7j6W6DLmylxhOIm26ynKdWVbz34Pa3vMP3oN303VoxmlsPmqhIQ7I9p8ETbhs=
X-Received: from pjbsd7.prod.google.com ([2002:a17:90b:5147:b0:2ff:6132:8710])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f70c:b0:225:ac99:ae08 with SMTP id d9443c01a7336-225e0a288c6mr192303765ad.5.1742250267625;
 Mon, 17 Mar 2025 15:24:27 -0700 (PDT)
Date: Mon, 17 Mar 2025 22:24:24 +0000
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250317222424.3837495-1-samitolvanen@google.com>
Subject: [PATCH dwarves] btf_encoder: Filter out __gendwarfksyms_ptr_
From: Sami Tolvanen <samitolvanen@google.com>
To: dwarves@vger.kernel.org
Cc: acme@kernel.org, yonghong.song@linux.dev, ast@kernel.org, 
	andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, song@kernel.org, 
	eddyz87@gmail.com, olsajiri@gmail.com, stephen.s.brennan@oracle.com, 
	laura.nao@collabora.com, ubizjak@gmail.com, alan.maguire@oracle.com, 
	xiyou.wangcong@gmail.com, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

With CONFIG_GENDWARFKSYMS, __gendwarfksyms_ptr_<symbol>
variables are added to the kernel in EXPORT_SYMBOL() to ensure
DWARF type information is available for exported symbols in the
TUs where they're actually exported. These symbols are dropped
when linking vmlinux, but dangling references to them remain
in DWARF, which results in thousands of 0 address variables
that pahole needs to validate (since commit 9810758003ce
("btf_encoder: Verify 0 address DWARF variables are in ELF
section")).

Filter out symbols with the __gendwarfksyms_ptr_ name prefix in
filter_variable_name() instead of calling variable_in_sec()
for all of them. This reduces the time it takes to process
.tmp_vmlinux1 by ~77% on my test system:

Before: 35.775 +- 0.121  seconds time elapsed  ( +-  0.34% )
 After: 8.3516 +- 0.0407 seconds time elapsed  ( +-  0.49% )

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 btf_encoder.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index 1bde310..2bf7c59 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -2239,6 +2239,7 @@ static bool filter_variable_name(const char *name)
 		X("__UNIQUE_ID"),
 		X("__tpstrtab_"),
 		X("__exitcall_"),
+		X("__gendwarfksyms_ptr_"),
 		X("__func_stack_frame_non_standard_")
 		#undef X
 	};

base-commit: a0be596ae76c720d21eef257dec1cf2462130da1
-- 
2.49.0.rc1.451.g8f38331e32-goog

