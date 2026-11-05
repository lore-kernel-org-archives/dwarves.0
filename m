Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793897348;
	b=EWrw1WBzREfhT2feA3sH6euMAtobKfNX7cVB97Hh9b+MCKHxM0YQas9Y1ukkty1KDJi3
	 IcM+5gTDC4+HNWcrAI3lCs2PBnWf/ptIzv4mzDnRzM4V7BzIDusNgOC5SLWyFv3KLSExN
	 JLQRBJDKVSNNG1DsiB7Eqah35MspvpMfdGHclKGIWAGOHQI8STnSlbC6VdWUpQ/3pFFkb
	 pLv61n9AdGGoHe0N7seIIPVkX4l8DkeoJFyW4wcQcOdK88I3KVWWL35PFyP+CHwuTEnDx
	 T+sL3zcE0wQulcH0ycV30/A+hmOfGZOdZXqoO4VXm13uit+28UTbC5j2HyD5fwcfjzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=IofCeiQ6JCwrlt7o+A0pBeIgYyuiwZInCjl1yfHCeTU=;
	b=h5EEWt80XiurFookwPJ7cbxHBXNrbjQ4uovNq4fa1usgHuLlPlG63m5O6a6hkcoAgE/w
	 Kgx7pbCKjVHJ7dVVqtTETpE5uXROi8QPoXB8TG5l9Q/fe67Cq3SNAhXlRfmHx9ZpUXDCM
	 z+2bLo5w5yOLPFmALfqPeTXc7n+Ld2CfcVaQRJLnl8uQUwp4RV+HluxYVanfnONoJtlu2
	 a7CDBQ9KXsuB+u55vC1ipYgysu2xFZ0eCU0rfQBGzDoaDt0kGTcp23+flbLt4rPe2KxZc
	 VTVT/TTHUhSrwFmQ3M5XD8TuwbiOeJ1V84Pj1biQ1XnVCyNESmsV0o0/VN4Iu/9k5WA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=alanderk.com;
	spf=pass smtp.mailfrom=alanderk.com;
	dkim=pass header.d=alanderk.com header.i=@alanderk.com header.a=rsa-sha256 header.s=googol header.b=qSOwI09+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABD7606A329
	for <dwarves@vger.kernel.org>; Thu,  5 Nov 2026 16:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DABD7606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alanderk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alanderk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alanderk.com header.i=@alanderk.com header.a=rsa-sha256 header.s=googol header.b=qSOwI09+
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-490d59c3edaso670109f8f.1
        for <dwarves@vger.kernel.org>; Thu, 05 Nov 2026 08:49:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793897346; cv=none;
        d=google.com; s=arc-20260327;
        b=CE4HUp9MgT2WvSj6jPGrC2vQ3WM41sDsk2QqRbn20w6Y9TrhJvSTbBKvaJUgAmvGLn
         YC7ncGyzCk1f1Hm39k6sIz8ly4/4Xny7MM/DM7r1K+49RVMqaJdF+GOJqAej7nmdKspk
         YaKVY69YS6PrfITSYiNqi2d9bZOdOOxCfnn6U/ZdMzlDZ5ePxayb/DTPh8JTqoZPQG3i
         xKW6B7ZRN62ds2U1T2sVZ9Fc3kFAIzTBaC1cn24VFyYVD/nWKVilC4azWLl8QrXLkZSe
         WNvZUSfQxnplMyloPBkpR/Qyk58hBxkwN4VRVEC9EqQM1Qvo5TlelUEICvUsQPvY3P6v
         gN5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IofCeiQ6JCwrlt7o+A0pBeIgYyuiwZInCjl1yfHCeTU=;
        fh=9GVed6DTbRqKeDXWiY7SGKPxsQXhlV3SOdQAJ6IuoUI=;
        b=UmknAyKKwgIx1FkYnZWj6sg6oF9FYOm9izsgyxeZZGl5wiXonhGmY3g3rvvJI1wfg+
         RRm9Cj+JBRSjArvmx2o2jUEe6Rr62bZM/ot+ltiA3v6oZd5ebUMu+YUOeDwgp5WJHtLN
         GnnzBAiuyt4aq6zk37k58a/vZgaSYwc9NsidDhS35OeIKZWhFYFSnGfTAv2zy6BZNRTe
         oI19moCv11vPMTW9Rw7SxxH1M60eNPKSMgKXsGKm79dVr59mWuhXZX9BGGPrtoHPQWBd
         o3JklGDacB/irVvyaf3OT9yRIBhOq3qCrBK1IO2XGzIHRE88o1/q7gVUMYRSzF2Rt3T9
         fPfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alanderk.com; s=googol; t=1793897346; x=1794502146; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IofCeiQ6JCwrlt7o+A0pBeIgYyuiwZInCjl1yfHCeTU=;
        b=qSOwI09+JE7d7rKoZkTU3eUrTNzAE9STFkM9DkSP5Ze3kh3+lGIldrds9BDVDerlYw
         pp//qNE7JkxJL9n7SS97rNb+FPrL+U++gh0zccNBXcjvS0ZIgjvaT0ub4l2dWeyo+RWZ
         Cqv1YScQhGQYy0+XyJcz2v7G0Zkt2vrkzNBiCVOyBg2nsT/fVxGjNEyZFPYcuPic8MAY
         FQ8EAZlWN935gPO0mt5Mcp7TvdPRi+uJgXfyH2E1b7WcwlhUh9x6ZOWSwrghwqktlIUJ
         /4/1d/HG1aNeX9bfvGugyY8VJ6bAAwVbhSD7dZ+72aWlA7HmPb1BZjCm0DCbrrPRMO7l
         t2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793897346; x=1794502146;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IofCeiQ6JCwrlt7o+A0pBeIgYyuiwZInCjl1yfHCeTU=;
        b=ZxlEKynAt7NgPiHVa2AhzCXJrQMZEU503xaDTsXuUMAGhAN9ktLJQWFKeNISi++UQI
         2q1jsEdPFWgc5xnjNbI5XD/IcLk635vnvNqMeHO6jFEDb1ip8QOCS3ViYhEcVMDn+JYF
         u0ND10zsB6uJA3UBYAXoLLwDhuv5XjrC9nRejqoG/G4t+Wsf20hcFLeZ8pcg6Oi+atdO
         Lr5WqlZbCRAy87VCY7gP3NUXcfj2wHHbGUYm3dPN+AeZUTR7F1T5SAHHoNkTJwG0LfsN
         +slHyRMDjUVlgUCru9rXOos2dQJ+v+ELXMdHawSQ9gOBGzJ+ada+f1QMhdsUpigFhLS8
         cijQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQB/FaFOIFhGoeY+HQZHCEj9b0S9WvHRvDBiqOHXwo0IT0njn6LTLtCDCDoqxMexbdOLn5B/Fb@vger.kernel.org
X-Gm-Message-State: APuU4Z9S0At2+rXaIk1UBqOvDtO4mCyIxLX4Ec6t2vgiIM6RbggXg4IY
	nD9nKSlQswjPcTgAyBBLAxPTz4c1Mhv+TRWQ7Fr7xtyeMSEKCIFgHIeiE9wPi1hPi2ypIOLmEHX
	DY1qoNX5p9VqDVT4//iue7vL7Wz7jJoZEGeQidYaVyw==
X-Gm-Gg: AYBFou3TgbwroZ5FtEsXqQf2u3dWbjbMpfU/B7bCim4aeOBF4rd9LoxUp57DdMBs+ac
	+0NtxJDXVfvbm/ZSNU9jtDqsmef6yDkoSwldTVDutJLB2lQvGibnQXb2+0pa+NRhVQ/hYEyUUkz
	i/QIdE0UuEzoumRgCdc2LKOwyiseI8CLRNL118zuUYlbqbge63y1jb9S1zPzmoFfA4Zy/29Fbq3
	3Un0BreZ8nKVBFEq1J1qutsf0fSmdHJwU0e6yfIslEt3pBBlsJiomnpZuPHNyGItVYzDkuct2yP
	GfsfUlawrqxT0GcP2FEvlBVOj3gcN+5MW6R6V5lJSpf7r+qEaTK8fGNMYvPUfq0sUIqoBGgqACl
	kxB1ZSzh92bki3Zgij0RR2yfwabjl0rag8AO3sJOX2M1p4wGY
X-Received: by 2002:a05:6000:4a1c:b0:490:1395:9b00 with SMTP id
 ffacd0b85a97d-4911906d26fmr6264775f8f.10.1793897346089; Thu, 05 Nov 2026
 08:49:06 -0800 (PST)
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Post: <mailto:dwarves@vger.kernel.org>
List-Help: <mailto:dwarves+help@vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
List-Owner: <mailto:dwarves+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261010005227.976-1-linux@alanderk.com> <87dfc1f8-6ef4-424c-a48d-62e935eeeb28@kernel.org>
In-Reply-To: <87dfc1f8-6ef4-424c-a48d-62e935eeeb28@kernel.org>
From: Alan Derk <linux@alanderk.com>
Date: Thu, 5 Nov 2026 07:48:54 -0900
X-Gm-Features: AclHuK8vKOu24Bc8kFqanAhzIarNQKxJATur1LwcU5SeZGjflO0j-bEqaeTReYM
Message-ID: <CAPLSpGbV5RTSuMZPX=UgzniPtoT7jup7pCGw_Rt2tqiejKXmng@mail.gmail.com>
Subject: Re: [PATCH dwarves v2 0/2] dwarf_loader: Fix --lang_exclude on merged CUs
To: Alan Maguire <almagui@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org, 
	dwarves@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 4, 2026 at 7:38 AM Alan Maguire wrote:
> Thanks for doing this work! Sorry for the delay in getting to it, I'm
> looking at the patches now.

Of course. Please take your time on the review. And thanks for the
background on the Rust BTF work.

> We've been working on a solution; essentially, the idea is to detect
> such cases and fix up the type graph in pahole using a new
> "rust_bindgen_replace" feature so that the final BTF does not have to
> carry such duplicates. It will only run for Rust CUs, [...]

Patches 1-2 are general --lang_exclude fixes (both reproducers are
C++/C). The Kconfig follow-up keeps --lang_exclude=rust, so it is a
stopgap: Rust stays out of BTF, as it does without LTO, until
rust_bindgen_replace brings Rust types in. I realize it may not be
worth it, though it would -- if I understand correctly -- unblock RUST with
LTO and BTF in the meantime.

To check how this series of patches fits with your branch, I applied it on
top of pahole-next-btf-rust (b5e46f8; it applies cleanly) and tried both on
the 7.2.9 kernels I tested the series on (x86_64 ThinLTO, full LTO
and distributed ThinLTO, arm64 ThinLTO) and a non-LTO x86_64 build,
booting each in qemu and loading rust_minimal, rust_print and
kobject-example:

- With kbuild's flags (--lang_exclude=rust), the branch alone fails to
  build the Rust sample modules on the LTO kernels, as patch 1
  describes. With the series on top, all five kernels build, boot and
  load the three modules with BTF.
- With rust_bindgen_replace and nothing excluded, the series changes
  nothing: vmlinux and module BTF are byte-identical with and without
  it.

One thing I noticed along the way, since it's the merged-CU language
that patch 1 deals with: under LTO the merged CU has one language,
taken from its first CU (a C or asm file for vmlinux), so
cu__is_rust() is false and rust_bindgen_replace doesn't run on
vmlinux. Without LTO it replaced 564 types as expected.

Cheers,
Alan
