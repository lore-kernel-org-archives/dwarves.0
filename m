Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF50311C2A
	for <dwarves@vger.kernel.org>; Sat, 23 May 2026 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779553727; cv=none; b=R27iXrNxG0JR9mRHU+3U1FY579G97T1RRDnXs4G3jAhwyEZqjE44uk8Bp9y4URWfXNWDjv92+MFY5TQKCF3vR7zOJ1NVr4mRVt8JPuZTGWTGMQfMSbMp9I9y/JvC9KUGlVvvGbtsr6qDzb/mTG4tmJ1pAWUwGH8YwL3f9vLqg+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779553727; c=relaxed/simple;
	bh=pBBetVWGDQwnlxnz9CE+hUxknAr5QN7uQ7hk9r0LNLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NI0TnO5Foulfnh5yxLvp8ZLhZebZG8b70+/pORf4buTraCUrWy42RMA9julE/PSmau4QdEbiMZ2W3eaO008shTJ04DLUg//hJtNe8VaGqFmxAo9CS+6Cmps5v/6Hi/NELJNm1uz/denLnnT3M8fINGAIpYHjtopo0k2CjF/R27I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QUXdfKyT; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QUXdfKyT"
Message-ID: <8f56fb9d-5ef0-4d16-bc3d-f04df31cb058@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779553724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qKu2sFqBdehp17DizpDxx+FqnQ/UhTVc4hNShHJ41tM=;
	b=QUXdfKyTh86myUc+nUIsCfuxeIEFcxO2yE1OhCGT86adEKpnwzsZxTrP3z4S+2EDr4+Nky
	SjOf/hmC5f4WHENLVyRhlXUQkL49Z3Y/5HpCcHb1Ynau/eDzhATK/YYRLt3+PCZzIlQqZj
	CThH2r0IIPQ4UAA9bHdhNfm9j8qJjhY=
Date: Sat, 23 May 2026 09:28:38 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v4 03/11] dwarf_loader: Handle signatures with
 dead arguments
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, kernel-team@fb.com
References: <20260326013144.2901265-1-yonghong.song@linux.dev>
 <20260326013159.2904078-1-yonghong.song@linux.dev>
 <8b591079-987b-485f-b37d-f4207dbac08b@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <8b591079-987b-485f-b37d-f4207dbac08b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/30/26 3:13 AM, Alan Maguire wrote:
> On 26/03/2026 01:31, Yonghong Song wrote:
>> For llvm dwarf, the dead argument may be in the middle of
>> DW_TAG_subprogram. So we introduce skip_idx in order to
>> match expected registers properly.
>>
>> For example:
>>    0x00042897:   DW_TAG_subprogram
>>                    DW_AT_name      ("create_dev")
>>                    DW_AT_calling_convention        (DW_CC_nocall)
>>                    DW_AT_type      (0x0002429a "int")
>>                    ...
>>
>>    0x000428ab:     DW_TAG_formal_parameter
>>                      DW_AT_name    ("name")
>>                      DW_AT_type    (0x000242ed "char *")
>>                      ...
>>
>>    0x000428b5:     DW_TAG_formal_parameter
>>                      DW_AT_location        (indexed (0x3f) loclist = 0x000027f8:
>>                         [0xffffffff87681370, 0xffffffff8768137a): DW_OP_reg5 RDI
>>                         [0xffffffff8768137a, 0xffffffff87681392): DW_OP_reg3 RBX
>>                         [0xffffffff87681392, 0xffffffff876813ae): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
>>                      DW_AT_name    ("dev")
>>                      DW_AT_type    (0x00026859 "dev_t")
>>                      ...
>>
>> With skip_idx, we can identify that the second original argument
>> 'dev' becomes the first one after optimization.
>>
> Is there a way we could unify this a bit better with the existing approach
> where each struct parameter has an idx value associated with it? For gcc
> we compare concrete and abstract indices and if they mismatch we know a
> parameter is skipped and set reordered_parm at the function tag level.
> We could set the idx to -1 or similar for skipped parameters to cover
> the below cases maybe?
>
> Not sure how the skip_idx approach would generalize to multiple optimized
> out parameters; is there a way to handle that?

For this particular case (proper parameter indexes), gcc is better than
clang. For gcc, parameter are reordered to have dead arguments after
non-dead arguments. Compiler did the work here.

But for clang, parameters are still original parameter sequence.
For each parameter, we do not know that any particular parameter
is dead or not, unless we go through the whole parameter__reg().


>   
>> The previous patch has the following:
>>    0x0533fd03:   DW_TAG_subprogram
>>                    DW_AT_name      ("acpi_irq_penalty_update")
>>                    DW_AT_calling_convention        (DW_CC_nocall)
>>                    DW_AT_type      (0x05334dc7 "int")
>>                    ...
>>
>>    0x0533fd15:     DW_TAG_formal_parameter
>>                      DW_AT_name    ("str")
>>                      DW_AT_type    (0x05335918 "char *")
>>                      ...
>>
>>    0x0533fd1f:     DW_TAG_formal_parameter
>>                      DW_AT_location        (indexed (0x3b) loclist = 0x00eb9d83:
>>                         [0xffff80008419f2e0, 0xffff80008419f324): DW_OP_reg1 W1
>>                         [0xffff80008419f324, 0xffff80008419f47c): DW_OP_reg19 W19
>>                         [0xffff80008419f47c, 0xffff80008419f494): DW_OP_entry_value(DW_OP_reg1 W1), DW_OP_stack_value
>>                         [0xffff80008419f494, 0xffff80008419f498): DW_OP_reg19 W19)
>>                      DW_AT_name    ("used")
>>                      DW_AT_type    (0x05334dc7 "int")
>>                      ...
>>
>> It is also handled properly with parameter 'str' will have W0 register.
>>
>> With this patch, I checked x86_64 that the number of invalid true signatures is reduced
>> from 532 to 96. This suggests that majority of optimized functions are caused by
>> dead arguments.

[...]

