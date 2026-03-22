Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FF41624D5
	for <dwarves@vger.kernel.org>; Sun, 22 Mar 2026 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774204459; cv=none; b=gEGIf5URAW3/uc6yf3nSKChOVzvl8yQrVNncndgPJDO3EDvOFXvuJDDCsYx9kgEcROGaRD8dHPTu820To2IT6Mr/tzIItuvnoY+gaJpfuUcopRehpDbkJca8mFTiVSGRlqNwEOr/i4a9QJJeShcOy5VdbFmtIgcuMwCxQHb63fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774204459; c=relaxed/simple;
	bh=Ci1pQ6kQtPBH9yjbazYgYQvYk3sbHGBc8r1MgPPyDWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4MvojcvjEdgnZ03elyLz/SR2sbmgvGFNhqRWc9jI+RcX6R1U12uUt3cq5mbAjcRZTi27mnTRC074sJCAUbi8vMG8WDQW2SQsjgKMMPQkD3hHKOo1uKtXSvPO8BpUdLVBWLqaN6BMSYZERsZgnr/eOVobfWKdTZAi1B1cnX0rzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OMXJR2Kf; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OMXJR2Kf"
Message-ID: <52d00c7b-c98f-4812-878e-7e1cae3e09d2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774204445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jQX7q8Ah1Zh/QfoAq4bQds6B2Iund1/RM0eIyjjG/kk=;
	b=OMXJR2Kfzymcocc4mhgodEe50tl5L0G1IMuL0FgI45d31h+FDpv4+LSg/iaqDRCSiU1/qZ
	S+cV6IyXGGRFzxA0IyQC8yL4AvyTFgxUU8oUPpIeGbx9HNk9HB7OnRY5XSGt8hworkNmq9
	Td8K2kQPUDghzmLfwQjhZINcG4LgK8Y=
Date: Sun, 22 Mar 2026 11:33:59 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v3 7/9] dwarf_loader: Handle expression lists
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, kernel-team@fb.com
References: <20260320190917.1970524-1-yonghong.song@linux.dev>
 <20260320190953.1974467-1-yonghong.song@linux.dev> <ab8lUbZE83_XEyyR@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ab8lUbZE83_XEyyR@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/21/26 4:10 PM, Jiri Olsa wrote:
> On Fri, Mar 20, 2026 at 12:09:53PM -0700, Yonghong Song wrote:
>
> SNIP
>
>> +	if (byte_size <= cu->addr_size || !cu->agg_use_two_regs) {
>> +		switch (expr[0].atom) {
>> +		case DW_OP_reg0 ... DW_OP_reg31:
>> +			if (loc_num != 0)
>> +				break;
>> +			*ret = expr[0].atom;
>> +			if (*ret == expected_reg)
>> +				return *ret;
>> +			break;
>> +		case DW_OP_breg0 ... DW_OP_breg31:
>> +			if (loc_num != 0)
>> +				break;
>> +			bool has_op_stack_value = false;
>> +			for (int i = 1; i < exprlen; i++) {
>> +				if (expr[i].atom == DW_OP_stack_value) {
>> +					has_op_stack_value = true;
>> +					break;
>> +				}
>> +			}
>> +			if (!has_op_stack_value)
>> +				break;
>> +			/* The existence of DW_OP_stack_value means that
>> +			 * DW_OP_bregX register is used as value.
>> +			 */
>> +			*ret = expr[0].atom - DW_OP_breg0 + DW_OP_reg0;
>> +			if (*ret == expected_reg)
>> +				return *ret;
>> +		}
>> +	} else {
>> +		/* cu->addr * 2 */
>> +		int off = 0;
>> +		for (int i = 0; i < exprlen; i++) {
>> +			if (expr[i].atom == DW_OP_piece) {
>> +				int num = expr[i].number;
>> +				if (i == 0) {
>> +					off = num;
>> +					continue;
>> +				}
>> +				if (off < cu->addr_size) (*lower_half) |= (1 << off);
>> +				else (*upper_half) |= (1 << (off - cu->addr_size));
>> +				off += num;
> this is really hard for me to read.. I think it needs to follow common
> formatting rules and it deserves some explanation either in comments
> or in changelog

Okay, I will add comments to explain what it is.

>
>> +			} else if (expr[i].atom >= DW_OP_reg0 && expr[i].atom <= DW_OP_reg31) {
>> +				if (off < cu->addr_size)
>> +					*ret = expr[i].atom;
>> +				else if (*ret < 0)
>> +					*ret = expr[i].atom;
>> +			}
>> +			/* FIXME: not handling DW_OP_bregX yet since we do not have
>> +			 * a use case for it yet for linux kernel.
>> +			 */
>> +		}
>> +	}
>> +
>>   	return PARM_CONTINUE;
>>   }
>>   
>> +/* The lower_half and upper_half, computed in parameter__multi_exprs(), are handled here.
>> + */
>> +static int parameter__handle_two_addr_len(int expected_reg, unsigned long lower_half, unsigned long upper_half,
>> +					  int ret, Dwarf_Die *die, struct conf_load *conf, struct cu *cu,
>> +					  struct parameter *parm) {
>> +	if (!lower_half && !upper_half)
>> +		return ret;
>> +
>> +	if (ret != expected_reg)
>> +		return ret;
>> +
>> +	if (!conf->true_signature)
>> +		return PARM_DEFAULT_FAIL;
>> +
>> +	/* Both halfs are used based on dwarf */
>> +	if (lower_half && upper_half)
>> +		return PARM_TWO_ADDR_LEN;
>> +
>> +	/* FIXME: parm->name may be NULL due to abstract origin. We do not want to
>> +	 * update abstract origin as the type in abstract origin may be used
>> +	 * in some other places. We could remove abstract origin in this parameter
>> +	 * and add name and type in parameter itself. Right now, for current bpf-next
>> +	 * repo, we do not have instances below where parm->name is NULL for x86_64 arch.
>> +	 */
>> +	if (!parm->name)
>> +		return PARM_TO_BE_IMPROVED;
>> +
>> +	/* FIXME: Only support single field now so we can have a good parameter name and
>> +	 * type for it.
>> +	 */
>> +	if (__builtin_popcountll(lower_half) >= 2 || __builtin_popcountll(upper_half) >= 2)
>> +		return PARM_TO_BE_IMPROVED;
>> +
>> +	int field_offset;
>> +	if (__builtin_popcountll(lower_half) == 1)
>> +		field_offset = __builtin_ctzll(lower_half);
>> +	else
>> +		field_offset = cu->addr_size + __builtin_ctzll(upper_half);
>> +
>> +	/* FIXME: Only struct type is supported. */
>> +	Dwarf_Die member_die;
>> +	if (!get_member_with_offset(die, field_offset, &member_die))
>> +		return PARM_TO_BE_IMPROVED;
>> +
>> +	const char *member_name = attr_string(&member_die, DW_AT_name, conf);
>> +	int len = sizeof(parm->name) + strlen(member_name) + 3;
> this seems wrong, shoud be strlen for parm->name? maybe asprintf is
> better option in here?

Thanks for spotting this. It should be strlen. asprintf is even better.

>
>> +	char *new_name = malloc(len);
> also there's cu__malloc, and we should check if the allocation failed

Ack

>
>> +	sprintf(new_name, "%s__%s", parm->name, member_name);
>> +	parm->name = new_name;
> I wonder this will leak, because normally the name is allocated with
> dwarf_formstring and we don't need to free it, but now we do

This will leak. I thought the number of functions for this pattern
is limited. But nevertheless, leaking is not good.

I will wait a little bit for more reviews before sending version 4.
Thanks for review!

>
> jirka

