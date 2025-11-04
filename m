Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D00C2D0638
	for <dwarves@vger.kernel.org>; Tue,  4 Nov 2025 22:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295892; cv=none; b=GKkaCzXAXsh+M5kFemAg35OBog8TKW/4GTbyFjpG5kxYJ8EkZDzXQyFpLhorpbShYv9cVRoZu0cQnXszhWaXGTxfM4GT6FdG/8exp8P/S8DFbShXT9nJ/pFPNfol+IOMmdcCq/se37YIb6lLA3pytqY/AkmTDLQrp3hb7j7UcWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295892; c=relaxed/simple;
	bh=7MF25Q3wGEEdGh4DIpFO74rrmUwNRw+dQhOkjPEMyv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZWKjL2L2erjqet0C7dcVBWdsQ51E0qvUAOCDVHCnZuw04nhtKy02FDT6QDsDxEp0vqB5WPqPBiWozcaMu17i0twkpKNwxUnuZT8uIudAIf+17g3INqKfE5FpJ5ViPK8Qe3Al97hKrexWV7+/nZri1mc8wtRswibC1EstKR0NPeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MVnkouY2; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MVnkouY2"
Message-ID: <e4f4df9b-839b-4939-a413-f88eba562a9c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762295886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/QNbliKAyYhVskCt0RxnSd6MsBLzbaJ7Vz7N7Wd9qUk=;
	b=MVnkouY2EKqMrWBWXYOtKdS51DptXK1CWOZrbPw0jMycU1s0No4L0sohkltPPQv2S6QMp4
	qQqUED3GgkpnphkfBsQBc6FVZdhPWtGWASLO1hhEqS/y1ap2ZxWSqHaMO5T9bV2ya9YKcK
	RuGpt5cuqooOuAhTzZyyNLHbTDXtMcE=
Date: Tue, 4 Nov 2025 14:37:59 -0800
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v1 0/3] btf_encoder: support for BPF magic kernel
 functions
To: Eduard Zingerman <eddyz87@gmail.com>,
 Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 dwarves@vger.kernel.org, acme@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, tj@kernel.org, kernel-team@meta.com
References: <20251029190249.3323752-1-ihor.solodrai@linux.dev>
 <517837f0-127e-42bc-83f4-2c85203ef468@oracle.com>
 <ba1650aa-fafd-49a8-bea4-bdddee7c38c9@linux.dev>
 <0db4e51eed95f9d4616ff5936d335ae71ac2a016.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <0db4e51eed95f9d4616ff5936d335ae71ac2a016.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/4/25 2:33 PM, Eduard Zingerman wrote:
> On Tue, 2025-11-04 at 14:25 -0800, Ihor Solodrai wrote:
>> On 11/4/25 12:59 PM, Alan Maguire wrote:
>>> On 29/10/2025 19:02, Ihor Solodrai wrote:
>>>> This series implements BTF encoding of BPF kernel functions marked
>>>> with KF_MAGIC_ARGS flag in pahole.
>>>>
>>>> The kfunc flag indicates that the arguments of a kfunc with __magic
>>>> suffix are implicitly set by the verifier, and so pahole must emit two
>>>> functions to BTF:
>>>>   * kfunc_impl() with the arguments matching kernel declaration
>>>>   * kfunc() with __magic arguments omitted
>>>>
>>>> For more details see relevant patch series for BPF:
>>>> "bpf: magic kernel functions"
>>>>
>>>> This series is built upon KF_IMPLICIT_PROG_AUX_ARG support [1],
>>>> although the approach changed signifcantly to call it a v2.
>>>>
>>>> [1] https://lore.kernel.org/dwarves/20250924211512.1287298-1-ihor.solodrai@linux.dev/
>>>>
>>>> Ihor Solodrai (3):
>>>>   btf_encoder: refactor btf_encoder__add_func_proto
>>>>   btf_encoder: factor out btf_encoder__add_bpf_kfunc()
>>>>   btf_encoder: support kfuncs with KF_MAGIC_ARGS flag
>>>>
>>>>  btf_encoder.c | 292 ++++++++++++++++++++++++++++++++++++++------------
>>>>  1 file changed, 222 insertions(+), 70 deletions(-)
>>>>
>>>
>>> seems like we could potentially pull in patches 1 and 2 as cleanups
>>> prior to handling the KF_MAGIC/IMPLICIT change; would that be worthwhile?
>>>
>>
>> Hi Alan.
>>
>> Feel free to merge in the refactoring patches if you think they are
>> useful. No objections.
> 
> Hi Alan, Ihor,
> 
> If you thinking about merging patch #1, please consider my comment:
> 
>   > > +static int32_t btf_encoder__add_func_proto_for_state(struct btf_encoder *encoder, struct btf_encoder_func_state *state)
> 
>   > You can get rid of the `encoder` parameter here.
>   > See https://github.com/acmel/dwarves/commit/080d1f27ae71e30c269a1e26e85bb86c3683f195 .
> 
> I sound a bit like a broken record, sorry.

Oh, thanks for the ping, I missed this comment.

Alan, let me re-spin the refactoring patches separately.

> 
> [...]

