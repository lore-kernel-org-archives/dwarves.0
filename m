Received: from mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8986D37EFFF
	for <dwarves@vger.kernel.org>; Sat,  3 Oct 2026 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791017236; cv=none; b=Wj4OpmasoXNYzmafLx1iKR49A10yxo1B2WQIc5uS5I2Twr+Wv7J2O59JZLT5bPZem5tP5qVJZ0QNkA03OXf7YfSFKblau6ILE+dNSMHnXXwtfw8anhKTIzQe2NZxKJGw3/Xn2iHmqcnq1CtQAP9J9wlAsd0U+Q1c++dKKwXFhd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791017236; c=relaxed/simple;
	bh=5FO7I+EA1u4I5Yv5uTTc5LKX9uOhrqH2x7e8UUPtm/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WTEH/VU9x8tAgxbTzCLOktkwv0Jtcloi84SY/IPMDS1CbJfrV04vPgHD4gwcRsvW7bV3K5gVjq0fhdA4jiLYtw4IrTmdjF0vxmLWRxNBhWnqdH6OTP2eaBdH/6huRdeIfkQtQc00GAESk5CWai0Dt1Po2CupeyL6DtTgeOtExhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xRLmPnS1; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xRLmPnS1"
X-Envelope-To: dwarves@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5FO7I+EA1u4I5Yv5uTTc5LKX9uOhrqH2x7e8UUPtm/M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791017232; v=1; x=1791622032;
 b=xRLmPnS1GJLwBRt3RbN8V/kPWvTJuZ+ksbvMaw56XMJJJ3mKirZBedzUo7d/WvxBmZSwA80F
 ZO8DbSIwC50NwWHriTTlr/uT/h4hZQ11XSrEHCfKJ0X1tRzwnBtffa6o0Bk6IOqcs3QvhoiSUK7
 ah6jAJhv2kfcj9KBW69KpRh0=
X-Envelope-To: dwarves@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f4f8a3609a65bb88;
	Sat, 03 Oct 2026 08:47:12 +0000
X-Mizu-Trace-ID: f4f8a3609a65bb88
X-Migadu-Flow: FLOW_OUT
Message-ID: <35eb5dec-7b68-420e-8689-0ff91adf5e88@linux.dev>
Date: Sat, 3 Oct 2026 09:47:07 +0100
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Many instances of "no BTF func for kfunc ..." and "unresolved
 symbol ..." from resolve_btfids after pahole 1.32 upgrade
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>,
 Nathan Chancellor <nathan@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
 dwarves@vger.kernel.org
References: <20261001224346.GA576434@ax162>
 <efa1ae47-3ccf-4689-9fde-a0294985ccfb@linux.dev>
 <20261002162558.GB288990@ax162>
 <9b8b38fd-8f6c-4d2a-a6c1-0886c3a7de24@oracle.com>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <9b8b38fd-8f6c-4d2a-a6c1-0886c3a7de24@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/3/26 1:33 AM, Alan Maguire wrote:
> On 02/10/2026 17:25, Nathan Chancellor wrote:
>> Hi Yonghong,
>>
>> On Fri, Oct 02, 2026 at 10:40:12AM +0100, Yonghong Song wrote:
>>> Could you try the following patch to see whether it solved the issue.
>>> I didn't have environment to test arm, powerpc, riscv, etc.
>> Yes, I had to manually apply it but it does appear to resolve this
>> issue. I'll put it through my full build matrix soon but should you send
>> it formally, feel free to add
>>
>>    Tested-by: Nathan Chancellor <nathan@kernel.org> # build
>>
> thanks for doing that. If all looks good on your end with the build matrix
> let me know and we can land it asap. Thanks also for the quick turnaround
> Yonghong!

I just send the fix to the upstream. See
    https://lore.kernel.org/bpf/20261003084357.4185491-1-yonghong.song@linux.dev/

>   
>>> diff --git a/btf_encoder.c b/btf_encoder.c
>>> index d6b9be6..2f137ee 100644
>>> --- a/btf_encoder.c
>>> +++ b/btf_encoder.c
>>> @@ -2913,7 +2913,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>>>                  encoder->tag_kfuncs      = conf_load->btf_decl_tag_kfuncs;
>>>                  encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
>>>                  encoder->encode_attributes = conf_load->btf_attributes;
>>> -               encoder->true_signature = conf_load->true_signature;
>>> +               encoder->true_signature = conf_load->true_signature && cu->param_loc_supported;
>>>                  encoder->verbose         = verbose;
>>>                  encoder->has_index_type  = false;
>>>                  encoder->need_index_type = false;
>>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>>> index 1e5363a..9f9b9c9 100644
>>> --- a/dwarf_loader.c
>>> +++ b/dwarf_loader.c
>>> @@ -1518,6 +1518,22 @@ static bool arch__arg_align_two_regs(const GElf_Ehdr *ehdr)
>>>          }
>>>   }
>>> +/*
>>> + * Architectures whose argument register mapping has been validated for
>>> + * matching clang parameter locations and reconstructing true signatures.
>>> + * Other architectures keep only the basic optimized-out detection.
>>> + */
>>> +static bool arch__param_loc_supported(const GElf_Ehdr *ehdr)
>>> +{
>>> +       switch (ehdr->e_machine) {
>>> +       case EM_X86_64:
>>> +       case EM_AARCH64:
>>> +               return true;
>>> +       default:
>>> +               return false;
>>> +       }
>>> +}
>>> +
>>>   static struct template_type_param *template_type_param__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
>>>   {
>>>          struct template_type_param *ttparm = tag__alloc(cu, sizeof(*ttparm));
>>> @@ -3777,7 +3793,8 @@ static void function__analyze_parameter_locations(struct function *fn, struct cu
>>>   {
>>>          struct ftype *ftype = &fn->proto;
>>>          struct parameter *pos;
>>> -       bool true_sig_enabled = conf->true_signature && ftype->signature_changed;
>>> +       bool true_sig_enabled = cu->param_loc_supported && conf->true_signature &&
>>> +                               ftype->signature_changed;
>>>          bool check_locations = !cu->producer_clang || ftype->signature_changed;
>>>          int reg_idx = 0;
>>> @@ -3785,7 +3802,8 @@ static void function__analyze_parameter_locations(struct function *fn, struct cu
>>>                  /* Producer is clang and the signature was not changed: match
>>>                   * each parameter against its expected ABI argument register.
>>>                   */
>>> -               function__match_clang_parameter_locations(ftype, cu);
>>> +               if (cu->param_loc_supported)
>>> +                       function__match_clang_parameter_locations(ftype, cu);
>>>                  return;
>>>          }
>>> @@ -4533,6 +4551,7 @@ static int cu__set_common(struct cu *cu, struct conf_load *conf,
>>>          cu->nr_register_params = arch__nr_register_params(&ehdr);
>>>          cu->agg_use_two_regs = arch__agg_use_two_regs(&ehdr);
>>>          cu->arg_align_two_regs = arch__arg_align_two_regs(&ehdr);
>>> +       cu->param_loc_supported = arch__param_loc_supported(&ehdr);
>>>          arch__set_register_params(&ehdr, cu);
>>>          return 0;
>>>   }
>>> diff --git a/dwarves.h b/dwarves.h
>>> index f3453ed..6b75ece 100644
>>> --- a/dwarves.h
>>> +++ b/dwarves.h
>>> @@ -305,6 +305,7 @@ struct cu {
>>>          uint8_t          producer_clang:1;
>>>          uint8_t          agg_use_two_regs:1;    /* An aggregate like {long a; long b;} */
>>>          uint8_t          arg_align_two_regs:1;  /* An over-aligned arg starts on an even register */
>>> +       uint8_t          param_loc_supported:1; /* Parameter location analysis is validated for this arch */
>>>          uint8_t          nr_register_params;
>>>          int              register_params[ARCH_MAX_REGISTER_PARAMS];
>>>          int              functions_saved;
>>>

