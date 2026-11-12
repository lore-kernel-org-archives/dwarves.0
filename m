Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480801;
	b=wrqkEKy/S9l5tVu3TpVgMg+x+NWRnGhBz1EoTkE7t/hkuS2KtaWVcrBNqB3RnCV0Wo5/
	 hNrRAibCLGgl9teqhYwJz0QQzPW8RvNKwLtAOvz7C9zemOwersiXL+2CznRjFiB+0Ya4T
	 9Fq46hN9kBQUrx/ZxORwUw6fNgZz7KDRJ5CZvve6s3FgamjQw5Ia2WKKGmk1nPwIQCJKy
	 h18LKahAYIsGXdZBkGQr1jirARlDbrQcbAiECL540Cmd+nwNNrGIrruT0/3z0wUNd7+HG
	 hYfojjz+u1bGUM1N7jI7ATrCYkmKHfW7snid9UiCyd2fqdukN5EAoOf268k1gpEbUOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480801;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=dpWVkgIAlZX8Vu+OGjIOuEfjiO2MgyeWWvRHXsSgUG0=;
	b=Lbot2deTUAHl+ZB8SYeP8UKa36UF/iBs6INnWM3oIKDlMsmfQM2ritvCk1to7EZElDUE
	 EjE2Qk5H2eTPCHwyn8eXDfLbnsPN3Z59qmBmJMz8eK6F4cMCYu9vJifU0jmN0h3l+hegz
	 Fx4eVAM9mlKBo1/TooX4W6zdxp3PpPCJmA04EJKXKYQpi3Yq2gnWXeDxmG5JK+wyewf8Q
	 ZG2fXaO9+1vilRycUqLGw++S5iJkOlomdohFWXlAaFmQmUCuEpy0AbjGMuUUpGiDYSIa1
	 MpoXVJQyWlkxO4mlzxt/l5lj++kH/LqlhVs1pkpqObqnIXPKA8TH6hyEvviOGch1SzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=ooi4bpXe;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A975606A327;
	Thu, 12 Nov 2026 10:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A975606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=ooi4bpXe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dpWVkgIAlZX8Vu+OGjIOuEfjiO2MgyeWWvRHXsSgUG0=; b=ooi4bpXeGWR5YsVhny7mkqjKQH
	cppE5FRcXZRTB8L1JSIpd4aebrSV2SeRc5yNGqQQGqnQ2f6JL+6AauEBPlzYNLfbJ9F9ll0t5hmX9
	7pRmhos89JZRWYRAVMbNKLtWVkUBOTb9U+Ek6JozPybHxFsbLT5gGVi4QqwlI5bG40TZBxm5+zAg4
	l7a4a6SXJxfxOnWvgxhUZR86I5e9F5NAGOHbiR1No2nLd/4X8LlvisN+bpBH4DhG2I+cPdD/ikAEB
	Na6CbHXFDKUFAhxTNNx1sk068ZTkBVlfZp9r7Eva4oT3DnxesfwDMkA289Hdry9boNzU2skeg4h1o
	JBSQlW9A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRSQa-00Dubr-3B;
	Thu, 12 Nov 2026 10:53:13 +0000
Date: Thu, 12 Nov 2026 02:53:08 -0800
From: Breno Leitao <leitao@debian.org>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>, 
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH dwarves] btf_encoder: Keep the source prototype of kfuncs
Message-ID: <avWaZSCBSZ7wcm5y@gmail.com>
References: <20261111222447.322978-1-yonghong.song@linux.dev>
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Post: <mailto:dwarves@vger.kernel.org>
List-Help: <mailto:dwarves+help@vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
List-Owner: <mailto:dwarves+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111222447.322978-1-yonghong.song@linux.dev>
X-Debian-User: leitao

On Wed, Nov 11, 2026 at 02:24:47PM -0800, Yonghong Song wrote:
> The location based checks can drop kfuncs from BTF even though their ABI
> did not change. With the arm64 KCSAN setup in the report, resolve_btfids
> fails with:
> 
>   WARN: resolve_btfids: no BTF func for kfunc bpf_tcp_ops_set_rcvlowat in bpf_tcp_ops_set_rcvlowat_kfunc_set
>   WARN: resolve_btfids: unresolved symbol bpf_tcp_ops_set_rcvlowat
> 
> The location list of 'rcvlowat' starts after the function entry, in a
> callee-saved register, so the function is marked unexpected_reg and
> skipped. scx_bpf_tid_to_task() hits the same skip through a
> different DWARF pattern.
> 
> Kfuncs are defined with __bpf_kfunc ("__used __retain __noclone
> noinline"), so the compiler keeps the calling convention of the C
> prototype. Odd parameter locations of a kfunc are debug info artifacts,
> not ABI changes.
> 
> For kfuncs, clear the location derived flags when saving the state,
> keep all source parameters, and skip the location based checks, also in
> btf_encoder__add_saved_funcs() where saved_functions_combine() can merge
> the flags back in. The inconsistent prototype and ambiguous address
> checks still apply.
> 
> Kfuncs were only collected with decl_tag_kfuncs, which the kernel no
> longer passes since commit 692393104909 ("resolve_btfids: Emit bpf_kfunc
> and bpf_fastcall decl tags"). Collect them whenever BTF is encoded; the
> decl tags are still only emitted with decl_tag_kfuncs.
> 
> With this change, bpf_tcp_ops_set_rcvlowat() and scx_bpf_tid_to_task()
> are encoded again, and no other function in vmlinux BTF changes.
> 
> Reported-by: Breno Leitao <leitao@debian.org>
> Closes: https://lore.kernel.org/all/au27Y9m78_3EH2v1@gmail.com/
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Thanks, this fixes my build. I tested it on top of pahole master
(9eb594d) with next-20261111 and clang 22.1.3:

 - arm64 KCSAN, CONFIG_WERROR=y: vmlinux links again,
   bpf_tcp_ops_set_rcvlowat() and scx_bpf_tid_to_task() are back in BTF,
   __bpf_tcp_ops_init() and scx_init() return 0 instead of -22, and the
   prog_tests/tcp_autolowat.c cases pass (run standalone).

 - x86_64 KCSAN drops bpf_tcp_ops_set_rcvlowat() in the same way, and
   this fixes it there too.

 - Running pahole with and without this patch on the same vmlinux, the
   only BTF difference on both architectures is the kfuncs coming back.

Tested-by: Breno Leitao <leitao@debian.org>

--breno
