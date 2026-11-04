Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810319;
	b=e2QRtVsApf0V0IDHSdqxv7EMlMrRMWZAJCTiSW/+zE4cmQKaAje4/CbiwBoRytWMqpP9
	 iWXVY1WFN3Do73Li3pMsqrdu6bbMR4XJEvcIx+/h0VSmHYczuSJiVmEMDSKBQ9ddHZJ29
	 sGDIvToMClpdhiD7PfZqUI2Xnrh3UmDxk2BwryK1t55rMdc0fpgase46anKUXQPS/Di4H
	 X+2k1t/SAcyT9np2CQWCgVN9ZiL73cGJWDjVYY9Ir1jGT4y5mM9dwZSaJ6Xu9FMexQNCc
	 m9Q9AbSG1cD4RJW03EjQYE2I3NfIcedTlfo209ZYRZ5Je6qGlDqqXaJurOM0CmcMBOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810319;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:To:
	 Cc:References:Subject:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=N0muImAzdk2G4HZLLzIJnZcOiJybvTQLP1LgYzvtqc4=;
	b=FpY7c7g6LQg6RDUdu0qmVZZ6ZL/+1Co4sBZLwLYDJa2key0wufN9BSJXpG64NLgsty4s
	 D7USbwQDkuQIZxY6ULCoPjQTcCckzZNnasf6w9kboYSgVF1tZPB5fJSS9UBDYGYRadigg
	 SZqAMy3M3oWB4zVfCrqtfS/WtbxOfqAaJDyFI4yBD2RXGqWQCViVqC48V8EPwBhQkBfVq
	 rQ9tjL4AyatJUhWg7j4sMn51lAvR1XAJLzwEeR31fr/8KVKe8YxIOfj0skQn4jscoxxIT
	 xQFyjuS35OCQ+MAnofAd2liGK5EPaPk4X7oxlpSzrD/ulHN4oFU8Fq7IR5yPqghfm+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wi6HJwyi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A56E606D815;
	Wed,  4 Nov 2026 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wi6HJwyi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF411F00A1A;
	Wed,  4 Nov 2026 16:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793810318;
	bh=N0muImAzdk2G4HZLLzIJnZcOiJybvTQLP1LgYzvtqc4=;
	h=Date:To:Cc:References:Subject:From:In-Reply-To;
	b=Wi6HJwyiSGs0V9V3CzXYUgQnsulmkkv3mjnLpw18E11Ote71dKiP3yqSyqHE7knty
	 docxpxdSqrRA51GkOHmfzo2oMiGh4i2N9jKJoHdjlzEkYGeVmEKEBF9Fm1ov/BWUrs
	 rm+TJGu9BdkEl/T9JMgyUalAuRfwtjPhqtmvLyiUi8pTrw75PvzTIZ44tPL3LpKsrO
	 +bHEZsWNn00ikrQ3BmEr+vrTOPv2e+IAwfvEsaW1wGex4rgI0Ir3LUrDXVF7scQ8ub
	 QqVxfAhN5m9REAnpLOtxD+1QH97k47TuFCrPtwvVnnRXD+v5tt6HSCERgy9sBfdIJy
	 OBz/wf47OMaGw==
Message-ID: <87dfc1f8-6ef4-424c-a48d-62e935eeeb28@kernel.org>
Date: Wed, 4 Nov 2026 16:38:34 +0000
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
To: linux@alanderk.com
Cc: acme@kernel.org, alan.maguire@oracle.com, bpf@vger.kernel.org,
 dwarves@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20261010005227.976-1-linux@alanderk.com>
Subject: Re: [PATCH dwarves v2 0/2] dwarf_loader: Fix --lang_exclude on merged
 CUs
Content-Language: en-GB
From: Alan Maguire <almagui@kernel.org>
In-Reply-To: <20261010005227.976-1-linux@alanderk.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> From: Alan Derk <linux@alanderk.com>
> To: Arnaldo Carvalho de Melo <acme@kernel.org>,
> 	Alan Maguire <alan.maguire@oracle.com>
> Cc: dwarves@vger.kernel.org,
> 	bpf@vger.kernel.org,
> 	rust-for-linux@vger.kernel.org
> Subject: [PATCH dwarves v2 0/2] dwarf_loader: Fix --lang_exclude on merged CUs
> Date: Sat, 10 Oct 2026 00:52:25 +0000
> Message-ID: <20261010005227.976-1-linux@alanderk.com>
> X-Mailer: git-send-email 2.55.0
> Precedence: bulk
> X-Mailing-List: dwarves@vger.kernel.org
> List-Id: <dwarves.vger.kernel.org>
> List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
> List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
> MIME-Version: 1.0
> Content-Transfer-Encoding: 8bit
> 
> Two fixes for --lang_exclude when CUs are merged, as for LTO objects.
> 
> Patch 1 takes the merged CU's language from a CU that is kept, so that
> excluding the language of the first CU no longer drops the whole
> object. With LTO, this is what makes BTF generation fail for kernel
> modules that mix Rust and C.
> 
> Patch 2 fixes a second bug from the same commit, which I found while
> testing userspace LTO objects after sending v1. With clang LTO, a type
> such as int is emitted once and shared through DW_FORM_ref_addr, so
> skipping the excluded CUs left references into them dangling: pahole
> crashed printing such members, and -J encoded them as void. Patch 2
> loads the types that kept CUs use from the excluded CUs. Output without
> --lang_exclude does not change, and neither does the BTF of the LTO
> kernels I tested.
> 
> Patch 1 exposes this bug in one more link order. For a C++ object
> linked before a C one, pahole used to drop the C types without any
> error; with patch 1 alone it keeps them, and then crashes printing them,
> or encodes them as void with -J. Please apply the two together.
> 
> As far as I know, patch 1 removes the last thing that keeps the kernel's
> RUST option off when LTO and BTF are both on. Once these fixes are in a
> release, I'd like to propose relaxing that dependency to something like:
> 
>   depends on !DEBUG_INFO_BTF || (PAHOLE_HAS_LANG_EXCLUDE && (!LTO || PAHOLE_VERSION >= 133))
> 
> assuming they land in 1.33. The kernel tests in patch 1 ran with
> "&& !LTO" dropped from that line, hence the Cc to rust-for-linux.
> 
> Changes in v2:
> - Add patch 2.
> - Patch 1 is unchanged; its note about the Kconfig follow-up moved here.
> 
> v1: https://lore.kernel.org/all/20261009201032.40105-1-linux@alanderk.com/

Thanks for doing this work! Sorry for the delay in getting to it, I'm looking
at the patches now. 

In terms of enabling kernel builds to support adding BTF data for Rust, that's a
goal we're working towards too, but it turns out there are some complications.
We discussed a bit of this in Linux Plumbers in the BPF track [1], but the
main issue boils down to how bindgen-generated structures differ somewhat
from the C-based types; enums aren't always faithfully represented for example.
This has knock-on effects for BTF generation and we often end up with duplicate 
types for key kernel data structures; the bindgen and C versions of "struct sock"
for example. This in turn can confuse tooling which expects a canonical type
for the critical kernel structures.

We've been working on a solution; essentially, the idea is to detect such cases
and fix up the type graph in pahole using a new "rust_bindgen_replace" feature
so that the final BTF does not have to carry such duplicates. It will only run for
Rust CUs, and it is implemented in a work-in-progress series at [2]; the bindgen-related
changes are in [3].

The other commits in the series add BTF tags to allow tracers to use demangled names
in function tracing descriptors, and add testing etc.

[1] https://lpc.events/event/20/contributions/2408/
[2] https://github.com/alan-maguire/dwarves/tree/pahole-next-btf-rust
[3] https://github.com/acmel/dwarves/commit/68954b9e0d1b4a191a6d7e3329875c2acc983c8c
