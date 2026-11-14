Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794673664;
	b=Zaw7q8SbFD5XEdEcO5lOvXXsXC4t2M2NQR1hk2TTbngWMv+9X/azKV/6FleuMdnb6WEW
	 HFj9lQd9VEoc0ZgwqL0YegR+GiTI26n2bFzLsJmqpk0ObmyvzuTJy9tF3Nb1Xzeyay6/Z
	 N1x16/qyGil3LMwz72akMHA8IGXztnWRsHuEnSuvZrGQzXq6tGXTY+okHOUmw37zFtQMF
	 n6oI4bFKxwKIzda/d3fTBhG65kE+TlfaAaxVR1jDCxxSvBBDh4fWXOo2GRFEx9Nx+iWqv
	 qAlolB1QupICG5b1DHx7s4nmxfSBIScOhOwaBu6WQQYvBH0rNNiiAYkTSxndGhXGvWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794673664;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=cKsXMJm7qHtIeItOHanqHmAChvQOpfvaDdCmiUL5Dq4=;
	b=H+eAlqmCQb7rYHlgMMPLQvGsyK9jPsBGdlqWoADJ+CFtV3BYmWL1Qt7fhuBsPtTM3OZO
	 RBmuoj0LnxPXLNTs3armEivWkzXTRmre9j65v6RtlYjIrhThPqwrRUakxcb++oB5Beees
	 /YebkfcTtG3u3eUxJem3EiT7LGyJ/iM49ZkHwy+2r09/+ynOyjOLPHAX3RTQ9l8hgo+sv
	 PBvahcRdnoAa569pN28urC6mWcQexUgAQuPq8oCkjM/xWTrJAsr8Or9jT7ojMpl2f02lb
	 HVRaJoQxvCkR7kkb9E3OEY4WEWjBPMT1ANBuKtNMt7m0bV3CYmTwBL70mibotLKwiPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EkLeA9CX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889CF606A32E;
	Sat, 14 Nov 2026 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EkLeA9CX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F7A1F000C4;
	Sat, 14 Nov 2026 16:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794673664;
	bh=cKsXMJm7qHtIeItOHanqHmAChvQOpfvaDdCmiUL5Dq4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EkLeA9CX02WM39SMgF/N3Oz2x4QDhvIf/Xh8J5fgM+MViwUbmldevE7jXqe0i91Kl
	 WpQtdQE5/wH3ANkfWDd4j/ybNMP6Rh8cXxxk18FGJBjnQoeJ7qfJ7iWiDegIV9+jox
	 5g07Itqy86vPq38ln/rwd6P2XwSHa7C4d9cyRmVZur12AofoTLSXRSvIzzdnSwWhHg
	 ysj1PT380/TDbcvefZOpQJbXFv2A21u73yUpDV+JUXEU7Ma8XjjtcTi1DPOWAGVkpF
	 Pch/VQTyiGA5CR4g4I3zPRQPdF1yHeNLL//+q/2xmHAxXQEzyrYjVefDfw4jVqkoU/
	 BPS6NMjJR4HXQ==
Message-ID: <4a5157e7-2261-49cd-80ef-38dcc2699741@kernel.org>
Date: Sat, 14 Nov 2026 16:27:41 +0000
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
Subject: Re: [PATCH dwarves v2 0/2] dwarf_loader: Fix --lang_exclude on merged
 CUs
To: Alan Derk <linux@alanderk.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org,
 dwarves@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20261010005227.976-1-linux@alanderk.com>
 <87dfc1f8-6ef4-424c-a48d-62e935eeeb28@kernel.org>
 <CAPLSpGbV5RTSuMZPX=UgzniPtoT7jup7pCGw_Rt2tqiejKXmng@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <almagui@kernel.org>
In-Reply-To: <CAPLSpGbV5RTSuMZPX=UgzniPtoT7jup7pCGw_Rt2tqiejKXmng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/26 4:48 PM, Alan Derk wrote:
> On Wed, Nov 4, 2026 at 7:38 AM Alan Maguire wrote:
>> Thanks for doing this work! Sorry for the delay in getting to it, I'm
>> looking at the patches now.
> 
> Of course. Please take your time on the review. And thanks for the
> background on the Rust BTF work.
>

Changes are applied, thanks for fixing these issues! I'm thinking we should
probably add a CI job that builds an LTO vmlinux; I'll look at doing that
shortly.
 
>> We've been working on a solution; essentially, the idea is to detect
>> such cases and fix up the type graph in pahole using a new
>> "rust_bindgen_replace" feature so that the final BTF does not have to
>> carry such duplicates. It will only run for Rust CUs, [...]
> 
> Patches 1-2 are general --lang_exclude fixes (both reproducers are
> C++/C). The Kconfig follow-up keeps --lang_exclude=rust, so it is a
> stopgap: Rust stays out of BTF, as it does without LTO, until
> rust_bindgen_replace brings Rust types in. I realize it may not be
> worth it, though it would -- if I understand correctly -- unblock RUST with
> LTO and BTF in the meantime.
> 
> To check how this series of patches fits with your branch, I applied it on
> top of pahole-next-btf-rust (b5e46f8; it applies cleanly) and tried both on
> the 7.2.9 kernels I tested the series on (x86_64 ThinLTO, full LTO
> and distributed ThinLTO, arm64 ThinLTO) and a non-LTO x86_64 build,
> booting each in qemu and loading rust_minimal, rust_print and
> kobject-example:
> 
> - With kbuild's flags (--lang_exclude=rust), the branch alone fails to
>   build the Rust sample modules on the LTO kernels, as patch 1
>   describes. With the series on top, all five kernels build, boot and
>   load the three modules with BTF.
> - With rust_bindgen_replace and nothing excluded, the series changes
>   nothing: vmlinux and module BTF are byte-identical with and without
>   it.
> 
> One thing I noticed along the way, since it's the merged-CU language
> that patch 1 deals with: under LTO the merged CU has one language,
> taken from its first CU (a C or asm file for vmlinux), so
> cu__is_rust() is false and rust_bindgen_replace doesn't run on
> vmlinux. Without LTO it replaced 564 types as expected.
> 

Ah, that's a great point. May have to rethink that part. Thanks again
for giving the changes a try!

Alan
