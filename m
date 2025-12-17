Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293FB2192F4
	for <dwarves@vger.kernel.org>; Wed, 17 Dec 2025 04:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765944888; cv=none; b=n84CLUFkGR+2ftu/N0on74F+HoryWLgjq3iv3P/VP8ILTlGuEzKgd+yj93VqUUW16TYlk4v+IK7kWUvAddJJ8mFTnl8I4O5qnkjLPn9QE4saXTI+j/iqA1ipWAW77lfjI1WAeK+0x9tUL0W+8AkmLg5XefNwecinG4De+NwT/bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765944888; c=relaxed/simple;
	bh=3lAZQQL4Am4yzepVc4vhg1U8EkL2ZiU9oeAQGFws6Wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFybKLKZfq4mXhjktK4S9Mlh5OSAYq3f9fwYZltv6kI/RmXdtEox0Y4tjHlZPG7XcsWUIB677U/r9LbYxIhpYO9dEUK+MGbcmUiUtiMLOv/iMAv5Rbk1j50p+AeGUE3NZ1ZqfBD2ppUYv3XA+0ZxALeg1SHnYjYK+1BC4gdpo4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R5ZtTLWe; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R5ZtTLWe"
Message-ID: <3b3c5b4b-b4a3-402b-8d5d-507edaf4a814@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765944883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3lAZQQL4Am4yzepVc4vhg1U8EkL2ZiU9oeAQGFws6Wk=;
	b=R5ZtTLWe4eVZ6lfOrKiZ4bcdDsC0w6Hd7nnNKuUCFDTW3aljA+rUqjNZlkLEZPNrGEjmZH
	uRNc/lR5tj+aUGpfbOaSU62Dc0sY3GHWhBo3bLayxYL++45WQv7ckD/TkBPIcM9KnOYElM
	sKsdjIuhOI5qYsZKyhJnh6QYezr3yy8=
Date: Tue, 16 Dec 2025 20:14:37 -0800
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v2] dwarf_loader: Handle DW_AT_location attrs
 containing DW_OP_plus_uconst
Content-Language: en-GB
To: Yao Zi <me@ziyao.cc>, Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org, q66 <me@q66.moe>
References: <20251213082721.51017-2-me@ziyao.cc>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251213082721.51017-2-me@ziyao.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 12/13/25 12:27 AM, Yao Zi wrote:
> LLVM has a GlobalMerge pass, which tries to group multiple global
> variables together and address them with through a single register with
> offsets coded in instructions, to reduce register pressure. Address of
> symbols transformed by the pass may be represented by an DWARF
> expression consisting of DW_OP_addrx and DW_OP_plus_uconst, which
> naturally matches the way a merged variable is addressed.
>
> However, our dwarf_loader currently ignores anything but the first in
> the location expression, including the DW_OP_plus_uconst atom, which
> appears the second operation in this case. This could result in broken
> BTF information produced by pahole, where several merged symbols are
> given the same offset, even though in fact they don't overlap.
>
> LLVM has enabled MergeGlobal pass for PowerPC[1] and RISC-V[2] by
> default since version 20, let's handle DW_OP_plus_uconst operations in
> DW_AT_location attributes correctly to ensure correct BTF could be
> produced for LLVM-built kernels.
>
> Fixes: a6ea527aab91 ("variable: Add ->addr member")
> Reported-by: q66 <me@q66.moe>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2089
> Link: https://github.com/llvm/llvm-project/commit/aaa37d6755e6 # [1]
> Link: https://github.com/llvm/llvm-project/commit/9d02264b03ea # [2]
> Signed-off-by: Yao Zi <me@ziyao.cc>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

