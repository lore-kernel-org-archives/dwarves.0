Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD851D47C3;
	Thu, 20 Feb 2025 02:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740018383; cv=none; b=D1/+gGzlo0QmstQQQ2qzzkI1SLUKJtyHKPZmI9LGtQxbPU6P/iLgjTdbpVnXT7yyEuwj3PP2AWApicYnJ/TzsilB/h6jkuLs7DdfPAQnVtVnsroO/rxKJSlHxUI0dGR6zcgsOAqnhYXBC3/EunysQI5YxWMUwsJ+NZ416fKPUbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740018383; c=relaxed/simple;
	bh=IDBT7Dt1IxzZD62YWILsIhVrGFvqURiW3eWV0ox6rRs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EdaPRpocBaV75gbKnojiNEd/+DltLHjicD8NXo1cHyAYBuJ6ZseRYfOTNxh08+EP0E5kgq7m9MTPN4g+JkvpAH0RVgaP7vUSr9581GQT+RvksLYhANnSPZWhDlOBmFv5TDfKm8qCJ17t56nILOxt5Cl6XPxqwQJkQYAkgw83HxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5yBl9ID; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5yBl9ID"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22101839807so7769845ad.3;
        Wed, 19 Feb 2025 18:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740018381; x=1740623181; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J1PleI1fzqZSpuYT7wu7xtufatEANUiorkb6/en6v/c=;
        b=R5yBl9IDEZlFEF/4riP6YDcSAxiRANQwSyJfiyjfxv1Zou/FdXUp7eKY3y7/1FEyFK
         uZ6qtrtnFpMHhWQLPxZqi7jFNXOyRkBR6BPFCrhXhcz/PFnZ3Ywzx/0QnCpQehmpzALk
         Xj3trzGP54hLGp28lq5PBDdTtSwAGJlUpMJyCylHTjaYix8ZXidV6wxCJhHYa46WTxES
         TGBarTl/I3hU52eehHvfOWepjKjYtXeiwUcPEf8YMs3TixhXJPnfsP4k9bb6l0cDtKlO
         sCMNiQUxTLYs8NuZwJGSY20R+zaFwbAh7s8SievilpXYei6rOw2bIzrTCIrXL8OvWL2W
         II0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740018381; x=1740623181;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J1PleI1fzqZSpuYT7wu7xtufatEANUiorkb6/en6v/c=;
        b=tbIJEoFVLPgT3C/dTpn8OTL4fpAQ0gAfwLANMe9mhwhn6AK0BbBQrlybtb8vfNGnba
         0Ft4d5B2n2TyKSNxqCVhUJUw8QMhRwEHEe7Svv2SLziPPDbsJPXMyr5WjWDDXSV8Irlg
         TYysb5ctJwItxVZLifiOwUORFpI5SmpBmuMp+bobgVuHbiYeg4GEjus0iNhTUTYmEJx8
         BT0IdGigPLAHq+8mjaA/+at2UB4NlZP7/xyWE7ZGWrKn8kwJyG1u0DUmOaUVo1+DuG91
         JMj+x54eKvm476kGHSGemoFME9+00AOHzg3Yu1WOhQtOxo/iuMms7+8IF5fJ8ZwLjEgk
         pXCg==
X-Forwarded-Encrypted: i=1; AJvYcCV0Ulwd8Q6Nk4B24rRS66YtCAk59letq9u6FykTbrh8FcYVT6FlMzkpbFO82qGQLVmtS8FyWOM8YfvBdJJlli/A@vger.kernel.org, AJvYcCVoC43iqnTvunkK5jLxsuY0rXyNvWCVobyQU8kaxWWbp4+JmGTHzp+9qsosGf85O7A1pzHRmPtd@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Cy2XTkSl3oGHhWKBcCInl1cFD9Q56VyoB6Wko+uADrQk+Rf6
	lomWot50Dxo8OF/RsyGhdr3kVevmqKIKWzUoh2i0OsFXs55bM0r4bAMZzC0l
X-Gm-Gg: ASbGnct+QyC35sdh0WSb6nM8gm08BNxVDy543zTLmfqyeNaboaQ6eDikeGhKd8YS24B
	93Znl7d/dsbT2gUmOGV+vjEXE8r28dIsi/oPY9fGguEaSa5rx4elE1xCVIo2ZYamtJDMT8v/blH
	kituOytzoQQ3Gu2VkcSYjHJD8+I4fjEE5OZnHjNJqbrEOYdzn7Glf6yAKSpqMhXjsZ4xx92e2oF
	Mm23uy34iJ7YsIQtzsykVUwCioGt4lm4Rij8G+/mx82M84ylU/vaQqOqdU3cQZ6bp3gmXDZY94o
	OI5IbiP3slKF
X-Google-Smtp-Source: AGHT+IH3CudIDcN6neWjFVjqSVnYe4sB5FmU5xFPojFqOSgpJOh2G/BpgJNiRvkLD7PKIl7TUkVKqQ==
X-Received: by 2002:a05:6a21:648f:b0:1ee:d418:f756 with SMTP id adf61e73a8af0-1eed4fd39bemr9723241637.38.1740018381079;
        Wed, 19 Feb 2025 18:26:21 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb58618479sm9849086a12.33.2025.02.19.18.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 18:26:20 -0800 (PST)
Message-ID: <1b0f9104586fa37a5480581e6dc59780b25d3b29.camel@gmail.com>
Subject: Re: [PATCH 0/3] Fix duplicated VAR and secinfo
From: Eduard Zingerman <eddyz87@gmail.com>
To: Stephen Brennan <stephen.s.brennan@oracle.com>, Arnaldo Carvalho de Melo
	 <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org, 
	linux-debuggers@vger.kernel.org
Date: Wed, 19 Feb 2025 18:26:16 -0800
In-Reply-To: <20250212005003.1413091-1-stephen.s.brennan@oracle.com>
References: <20250212005003.1413091-1-stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-11 at 16:49 -0800, Stephen Brennan wrote:

[...]

> I've gone ahead and tested this by building & booting a kernel with these
> changes, and the kernel patch series at [1]. The result exhibited no BPF
> varidation errors, and the drgn BTF branch[2] is working perfectly with i=
t!

I tried out this patch-set:
- applied it to pahole;
- applied [1] to kernel;
- configured kernel as in [2] to run BPF selftests.

With this all done none of BPF selftests could be run.
E.g. doing './test_progs -vvv -n 1' gets me the following error:

  libbpf: Error in bpf_object__probe_loading(): -EINVAL. Couldn't load triv=
ial BPF program. Make sure your kernel supports BPF (CONFIG_BPF_SYSCALL=3Dy=
) and/or that RLIMIT_MEMLOCK is set to big enough value.

If libbpf is hacked to print verifier log for
bpf_object__probe_loading, the log looks as follows:

  in-kernel BTF is malformed
  processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0

BTF is broken in some nasty way, as nothing is printed to dmesg,
even if I add some printk's inside bpf_get_btf_vmlinux().
All I can see is that 'btf_vmlinux' is set to 0xffffffffffffffea very
early in the boot process.

[1] https://lore.kernel.org/bpf/20250207012045.2129841-1-stephen.s.brennan@=
oracle.com/
[2] https://gist.github.com/eddyz87/5282db54255b81eed731b955dc5ea690

