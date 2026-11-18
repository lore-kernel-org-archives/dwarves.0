Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030764;
	b=bS2JO2fx3AyKBF6zu3B6EXxKcHkB9MPjpOQLg3Pg2ZOkJKRqzvGBd93L3M+wcuC6Ngpy
	 mVYA3ClWiQsLTfLK4LBwqll8B21Gz6mbK5AjFv13CfMef6dW3VjWDx1m9UiaL2HhHECsO
	 jdOXE4EYl59oS0tBP6rua6GsIXrxPb34ThjKnNqtf+Z1l0p5T4AM5mf0ltXihKHMsbS35
	 WL3i5Pmi/bJ7lBFVuT1EAllMyzzHUhvOU/iK0af/jailVbZlb0KkD5JyZLbnJIkfecUlI
	 NhSrGfDx6ed13V+kOUAfW8XRKy7joPKJrpXdNjIGZ4/94KF7w0806Y94cgzf9W31dKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030764;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=z4qWKqUAa7onEgKJeugndfpGUuL3ZOwBMNRcc965bGc=;
	b=hRRxXMts4dIRAFvNe8HhdIRSV/r7DhwPMF1RlvVFeJwb6FxakNOLseUkiMmCnuU5Iba/
	 as8WzJfE0RUo8M3+D+tU04eppBS6zxFHHpu3Luhrwmfj5u1RW7s9GZ4umyaCpuMoAnlfV
	 CzHZ3tj9bD861Tg/sfwse5sX5JIFM4dVP2iY+piEzOwpXMLRppkKHmeaF3In1ffAYHTyA
	 nN5m3mKJfIR1fhZEqUo5Zq5L40Ad4pLrBVDinRerKGpGUoPlI8k1FNGtQXOjXFKni8d7d
	 eS+egjibbsvyBI/23Si7dowLQIpRYs/wHgQ2OT0bvirmySW/nTz9bsuI11s9l0AVnFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U65CXNGt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F843606A93C
	for <dwarves@vger.kernel.org>; Wed, 18 Nov 2026 19:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U65CXNGt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1A11F000C4
	for <dwarves@vger.kernel.org>; Wed, 18 Nov 2026 19:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030763;
	bh=z4qWKqUAa7onEgKJeugndfpGUuL3ZOwBMNRcc965bGc=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=U65CXNGtAmSqxIVn4aLurIFGKvgzo2gFWJGMJbD5XRxbHTb8n7zXQewYKKHS/7mON
	 2oxof8pHqiEhDD5BDLleWiTxEfjiMIxjiubIG6P1VForX7ZzNIfg2jvuQNAElC58nR
	 yp9cVINd0QS4J/zLHQ3QYpPcNpHx4yxlSOdW4DQ/RIvxIjAgAvEeRk6Bkx0qSlwKAd
	 Bqel7rF1McoKhfqWkZHM/ioBX8EG0PgdjU3t7bc4CAqy7ObaSmd9fSWsuNDSBsNpv5
	 N4Rw+VsNhabNzBs5u0jBwu4kySRqEZxbQbNe54FPDFMsxxIFkRtkARFA+EV49RUL2U
	 nkVnu8Xm80q/g==
Message-ID: <5b86ef55-ffa7-44de-a15d-e21095b81a05@kernel.org>
Date: Wed, 18 Nov 2026 19:39:21 +0000
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
Subject: Re: [PATCH dwarves 0/6] Add support for LTO kernel builds, other CI
 fixes
To: dwarves@vger.kernel.org
References: <20261116112043.3831978-1-almagui@kernel.org>
Content-Language: en-GB
From: Alan Maguire <almagui@kernel.org>
In-Reply-To: <20261116112043.3831978-1-almagui@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/26 11:20 AM, Alan Maguire wrote:
> CI has been flaky lately, git.kernel.org clones in particular.
> Provide fallback locations for cloning and retry (patch 1).
> 
> When testing with LTO kernels, function comparisons between
> DWARF/BTF take a long time; use more efficient methods (patch 2).
> 
> Fix a few other issues in CI (patches 3, 4).
> 
> Finally add ThinLTO kernel build support (patch 5).
> 
> Results of this series on top of pahole's next branch at [1];
> all pass.
> 
> [1] https://github.com/alan-maguire/dwarves/actions/runs/43849750600
> 

Series applied to stabilize CI.
