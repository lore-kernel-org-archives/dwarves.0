Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804144;
	b=vi+lcyAJTRKQ7hchlOiJjlyJuBhdNOXveZaQyM9qwvY/PMr0BufLu6vjc8d278MpnwF0
	 OQBKfFMp6dpjQVe5b6xaCop5/PI54zCGzBWN6nxWa3W92qgbnpjHZQDKYP7d5Fza4bAKF
	 ++D1sztfU6R2R4Mt6wepp7HUJErlg/F50S60ssaBB1Y20n37pkL1RJBMkknvNkORD9nKj
	 LbqKapFY0VdmI/YqIX075n1ExFD+jqXnnt1vIWwY5aiOGCgbH6SVI7xAynWHCuWhHTuq6
	 GnBrEC83zrnaFmDWwmj4pYkJ9tfJevehW7bejGQThwaA0Z/NoWaP10NIJczg3LTeqYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804144;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:To:
	 Cc:References:Subject:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=D08J6P6Wu6D2mwzjnEL6J9bKdYxdD83a0ox4a1pC1bQ=;
	b=bKK6Ad86LmV4eVY5cJSnobczKLSso4NKE9F65TLfzqQnwszMx2m2maQhF/uqbYLqdsKb
	 /7YXvIqApIkUpEmbMxmPUW2dMcEuno1APVjRzFzl2YDwZJ+NEN7SuNhVWpdqFex3kBB4+
	 Il04lkln74xsDbxOrMDPps+lRqGgegl6iga0auhaBzdk7UaBtdSixBFGS9rPiUhN9nvQS
	 GCZ8TeLIt6iAnY3hJoQez0+v8V4PKHgDRuQE3KOM0oRi3yvdXUHrZs8e33WpZVhUTABCy
	 V0+TSwBDiqjB2sqez2lLI08q3EE6mFZfJ9UA1s6jNnCrehV2Hvf2YSj3mQjv8D8vgZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1OtRLxp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959B4606A335;
	Wed,  4 Nov 2026 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1OtRLxp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000E11F000C1;
	Wed,  4 Nov 2026 14:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804144;
	bh=D08J6P6Wu6D2mwzjnEL6J9bKdYxdD83a0ox4a1pC1bQ=;
	h=Date:To:Cc:References:Subject:From:In-Reply-To;
	b=K1OtRLxpt/pv682efy+u+ItEpJ6mY9gp1UstqeoEx7QuyIK+glVsA6UphSMDG/Mxn
	 egUGGfQc6vKNtiyiRcJgByGTGSOCuM2RqPLBHmmuXOA4v9qc+307ocDum+Pb52cIMb
	 LvC2xDJFfq/t8uXqJ/zmsAGk/IFZVgE8v8ICMhxNYWfX7hyO25NNA6SHWCon27tVMh
	 GuAGWtpuRR0deHfAJmJ+Wix5IaDpTOPVK5jWNlBT9rPngOlf8M4pcr4nOqOEnWWgfl
	 6SXFwLRkUsH/chCm7Bk4bqSq6NAojWhkpw12kAkYPSH7jqeQMejIGuKosCEjl18/bD
	 vl3rX8UUJpqOA==
Message-ID: <26aca401-e6b0-4650-a6ef-af2e37ae5b2b@kernel.org>
Date: Wed, 4 Nov 2026 14:55:40 +0000
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Post: <mailto:dwarves@vger.kernel.org>
List-Help: <mailto:dwarves+help@vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
List-Owner: <mailto:dwarves+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ricardo.salveti@oss.qualcomm.com
Cc: acme@kernel.org, alan.maguire@oracle.com, bpf@vger.kernel.org,
 dwarves@vger.kernel.org
References: <20261022035604.3183589-1-ricardo.salveti@oss.qualcomm.com>
Subject: Re: [PATCH] dutil: Split the objcopy command into words in
 exec_objcopy()
Content-Language: en-GB
From: Alan Maguire <almagui@kernel.org>
In-Reply-To: <20261022035604.3183589-1-ricardo.salveti@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> From: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
> To: dwarves@vger.kernel.org
> Cc: acme@kernel.org, alan.maguire@oracle.com, bpf@vger.kernel.org
> Subject: [PATCH] dutil: Split the objcopy command into words in exec_objcopy()
> Date: Thu, 22 Oct 2026 03:56:04 +0000	[thread overview]
> Message-ID: <20261022035604.3183589-1-ricardo.salveti@oss.qualcomm.com> (raw)
> 
> pahole 1.31 ran objcopy through system(), so LLVM_OBJCOPY was a command
> line that could carry options, like the $(OBJCOPY) make variable the
> kernel build sets it from. Since the switch to exec_objcopy() the whole
> value of LLVM_OBJCOPY or OBJCOPY is passed to posix_spawnp() as the
> program name, so a value such as "objcopy --some-option", or one with a
> trailing blank, fails with ENOENT.
> 
> Kernel builds up to v6.19, including the LTS branches, run
> LLVM_OBJCOPY="${OBJCOPY}" pahole -J from link-vmlinux.sh and use
> ${OBJCOPY} unquoted for their own objcopy calls in the same script, so
> an OBJCOPY that works for the rest of the build now stops the link with:
> 
>   btf_encoder__write_elf: failed to add .BTF section to '.tmp_vmlinux1'
> 
> This breaks OpenEmbedded kernel builds, where OBJCOPY carries the
> machine's objcopy options and ends with a blank when there are none.
> 
> Split the command on blanks, like the shell's word splitting did with
> system(), for OBJCOPY as well. Quotes are not interpreted, so a path
> containing blanks can no longer be used, either quoted as with system()
> or as is as with v1.32. Name the file as both input and output, so that
> a stray word in the command makes objcopy fail instead of being taken
> as its input file and replacing the target.
> 
> Extend btf_write_elf.sh to check that options in LLVM_OBJCOPY reach
> objcopy.
> 
> Fixes: 6789ef8a16d5 ("btf_encoder: Fall back to objcopy when llvm-objcopy is not available")
> Assisted-by: Claude Code:claude-opus-5-5
> Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>

Applied, thank you!
