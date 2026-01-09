Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB0D340A6B
	for <dwarves@vger.kernel.org>; Fri,  9 Jan 2026 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947248; cv=none; b=kk1pxctHaH9G1/WRdKLJ0A7wkw4bcQbxCXGFhhlZwgZ1UkBcUfR96beVh2Aiamrx0EKi7jwr7g21nWVcWF92fN7ZwCsyBcZ1jNhDRE98Hic5yXDXIM+rdKAbm/HRjYIiKrJkYwKVE526X6DQ5yMqKzvuZdsFY7TXA0b16tUYos4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947248; c=relaxed/simple;
	bh=j0CFmj5uXQC/vw/BYL0kK2DjmcG0vUxX40xuyIUIz4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLoBBsuay/Ov42dJ3o6Ko3/TsSIrQeHuWRc/KVrJgdzHiG9SrGh8L8IIz/nQFSlodjZNoRnbYjbQrzDhugPl3krlwFB4IOn5dnj7MoWLy8QvLH5iw354unAk7I4AGGyQd7vtDJQWwPlBOeOM/av8l9fR3wQxzlQQVBK5z8P3b9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GEM3MfS8; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GEM3MfS8"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so830939766b.2
        for <dwarves@vger.kernel.org>; Fri, 09 Jan 2026 00:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767947242; x=1768552042; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NhcNVdVQhZPinLKh1jpeqgoQHiibL7zwCLP1Wwv50Rg=;
        b=GEM3MfS8YpbDNZ4BOiYyPWFhvhhRXj0XrJU/jk6kuTrv0Nx52LoFlJ0bUAQKnWX09J
         BOHnCPX1FUuF29OsROzqdIjs0FKXbBaGXs9fcC83pwm+p30UCPyOfKNxuykBy8p25WdZ
         TWdnnekV1e+aPEEmxLwPg8GVUpDsB7Aj6O9uvBy8gjRqbVApV8n7P/Cpmc0k2rYQ7SnL
         L8Mdie+G5Rf1+2ka6mdauIfSjX2aIBeZN9B41d3A/NzX+1ArDxLGBwjcsOppsTfuXCeq
         mfvbIp/1S1/TSXT7vXea7lPQdt0XOpDgtDtcU627CVeePGc6SJrt0SaorKNqlSfvC/CG
         CY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767947242; x=1768552042;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NhcNVdVQhZPinLKh1jpeqgoQHiibL7zwCLP1Wwv50Rg=;
        b=nwiMqOVVFEqhrGhxDmgyspK7Ggps3hiETJp79yFiDzJA4zU9Kedh83s7sU+C2mhBnD
         Ea475DEXhYwgsDUIDA6D06SC/5SXjvxWhpdznWczcThN7akUYNEyYmA1n6B3Wh/nWlqr
         5lYbnscvJXwlTUHZaO8VHxm7AZD95WD8ZNJ+chOMVYqYuEm4Y2qolX9SgduVDbGwe0aC
         8lgnp/FWiaWVc5mlwBntyvOEcHACLMpBpA+ulbBWaYzUJb/x2smGO4GMhAzKRHPyHEgA
         LPPeIi0VHD6HuvArze3Ja5hSA9Qevn3WZ8A9V8EYx2xchgXK74kz/yjJB9VwKUwJTcgY
         O1gQ==
X-Forwarded-Encrypted: i=1; AJvYcCV24hXkiT5YEiEiW6vY3x54w1CgrEJh+IglFIBmx56Axj3TqtVbciGgwCKSKfmrbaadpwTQfnGA@vger.kernel.org
X-Gm-Message-State: AOJu0YxQN9Igs855ty5A2xOGKr1+uii7dPL9+lsxDYnMkeIpyEqXfTi0
	KfOkDFU8aonwD9x9YxU1mCk9bGdPqhlCtLa4dZD2s2P04Ti0FwQ8wxaPylSphqusjw==
X-Gm-Gg: AY/fxX4O3S6jRufZhSUQYDEpTyW/VaE0t821cZSi2uZLLFFwODI4fimNeSlKIl4Dnea
	3C5dOeTV6S+4HikX0CHn5oZFyWhw6Rk0pmWa61e+GZlNvQo8c2PRAviFrQokA2qf0zspXUOxJqL
	Ht3c+QsBU+fGNdEtXVemqyO6URNcp3tI+zLKFyBv5ZyI0/Azlv38TrYVWTeP5j1V7OqgMyEohYh
	z2oaGDIfaRga6g3xDWF17kJgcSS49/tEHkv6tMF2NBOYX+EjyhHBg+276gOE+4R0h2UfNKE4wGV
	Yg55pVylk+XFUlAmp/D+OeL0y/h4x96gL8WEiewAUY+V//MahmRImK2q9qCZSy4mOSmUXUfaRbl
	+dBCxzphGGp1uGa7pPf3J2RtxiWkBa70XJQNJahv7oFLW53yRbfGhfoAumifhb30Dn9EhfuxEtK
	RS0qtqcW+liOsOHEF7x9PM5tuyQt3Jr2N7DkOPJM0sK4cBEXk/dIGkgQ==
X-Google-Smtp-Source: AGHT+IGCEJb/8nMNV4ll2AYwkVVw38xNVFNBZWCtO9DA5bm8fJKqYo9GPaWv4xHmda4gm2UOmFufdA==
X-Received: by 2002:a17:907:971d:b0:b83:a754:928c with SMTP id a640c23a62f3a-b8445190226mr920792866b.61.1767947241400;
        Fri, 09 Jan 2026 00:27:21 -0800 (PST)
Received: from google.com (14.59.147.34.bc.googleusercontent.com. [34.147.59.14])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507be642f5sm9373828a12.20.2026.01.09.00.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 00:27:20 -0800 (PST)
Date: Fri, 9 Jan 2026 08:27:17 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH dwarves] btf_encoder: prefer strong function definitions
 for BTF generation
Message-ID: <aWC75QonlmNVAGbO@google.com>
References: <20251231085322.3248063-1-mattbobrowski@google.com>
 <926aca4a-d7d5-4e7d-9096-77b27374c5cd@linux.dev>
 <aVt139VXMTka-hYw@google.com>
 <aVuk1e73g7ZTHqMY@google.com>
 <6b0968a3-406b-412f-acbb-c00ac2ad7c93@linux.dev>
 <aVwihhKEszvcyNKo@google.com>
 <ace92738-a52a-4248-b7d8-bcfce6f9af22@oracle.com>
 <aV6sNbs3vwCoGk49@google.com>
 <a25bddfb-4b43-47ab-a23c-03db99279435@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a25bddfb-4b43-47ab-a23c-03db99279435@oracle.com>

On Thu, Jan 08, 2026 at 06:18:07PM +0000, Alan Maguire wrote:
> On 07/01/2026 18:55, Matt Bobrowski wrote:
> > On Wed, Jan 07, 2026 at 03:50:40PM +0000, Alan Maguire wrote:
> >> On 05/01/2026 20:43, Matt Bobrowski wrote:
> >>> On Mon, Jan 05, 2026 at 08:23:29AM -0800, Yonghong Song wrote:
> >>>>
> >>>>
> >>>> On 1/5/26 3:47 AM, Matt Bobrowski wrote:
> >>>>> On Mon, Jan 05, 2026 at 08:27:11AM +0000, Matt Bobrowski wrote:
> >>>>>> On Fri, Jan 02, 2026 at 10:46:00AM -0800, Yonghong Song wrote:
> >>>>>>>
> >>>>>>> On 12/31/25 12:53 AM, Matt Bobrowski wrote:
> >>>>>>>> Currently, when a function has both a weak and a strong definition
> >>>>>>>> across different compilation units (CUs), the BTF encoder arbitrarily
> >>>>>>>> selects one to generate the BTF entry. This selection fundamentally is
> >>>>>>>> dependent on the order in which pahole processes the CUs.
> >>>>>>>>
> >>>>>>>> This indifference often leads to a mismatch where the generated BTF
> >>>>>>>> reflects the weak definition's prototype, even though the linker
> >>>>>>>> selected the strong definition for the final vmlinux binary.
> >>>>>>>>
> >>>>>>>> A notable example described in [0] involving function
> >>>>>>>> bpf_lsm_mmap_file(). Both weak and strong definitions exist,
> >>>>>>>> distinguished only by parameter names (e.g., file vs
> >>>>>>>> file__nullable). While the strong definition is linked into the
> >>>>>>>> vmlinux object, the generated BTF contained the prototype for the weak
> >>>>>>>> definition. This causes issues for BPF verifier (e.g., __nullable
> >>>>>>>> annotation semantics), or tools relying on accurate type information.
> >>>>>>>>
> >>>>>>>> To fix this, ensure the BTF encoder selects the function definition
> >>>>>>>> corresponding to the actual code linked into the binary. This is
> >>>>>>>> achieved by comparing the DWARF function address (DW_AT_low_pc) with
> >>>>>>>> the ELF symbol address (st_value). Only the DWARF entry for the strong
> >>>>>>>> definition will match the final resolved ELF symbol address.
> >>>>>>>>
> >>>>>>>> [0] https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/
> >>>>>>>>
> >>>>>>>> Link: https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/
> >>>>>>>> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> >>>>>>> LGTM with some nits below.
> >>>>>> Thanks for the review.
> >>>>>>
> >>>>>>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> >>>>>>>
> >>>>>>>> ---
> >>>>>>>>    btf_encoder.c | 36 ++++++++++++++++++++++++++++++++++++
> >>>>>>>>    1 file changed, 36 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/btf_encoder.c b/btf_encoder.c
> >>>>>>>> index b37ee7f..0462094 100644
> >>>>>>>> --- a/btf_encoder.c
> >>>>>>>> +++ b/btf_encoder.c
> >>>>>>>> @@ -79,6 +79,7 @@ struct btf_encoder_func_annot {
> >>>>>>>>    /* state used to do later encoding of saved functions */
> >>>>>>>>    struct btf_encoder_func_state {
> >>>>>>>> +	uint64_t addr;
> >>>>>>>>    	struct elf_function *elf;
> >>>>>>>>    	uint32_t type_id_off;
> >>>>>>>>    	uint16_t nr_parms;
> >>>>>>>> @@ -1258,6 +1259,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
> >>>>>>>>    	if (!state)
> >>>>>>>>    		return -ENOMEM;
> >>>>>>>> +	state->addr = function__addr(fn);
> >>>>>>>>    	state->elf = func;
> >>>>>>>>    	state->nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
> >>>>>>>>    	state->ret_type_id = ftype->tag.type == 0 ? 0 : encoder->type_id_off + ftype->tag.type;
> >>>>>>>> @@ -1477,6 +1479,29 @@ static void btf_encoder__delete_saved_funcs(struct btf_encoder *encoder)
> >>>>>>>>    	encoder->func_states.cap = 0;
> >>>>>>>>    }
> >>>>>>>> +static struct btf_encoder_func_state *btf_encoder__select_canonical_state(struct btf_encoder_func_state *combined_states,
> >>>>>>>> +									  int combined_cnt)
> >>>>>>>> +{
> >>>>>>>> +	int i, j;
> >>>>>>>> +
> >>>>>>>> +	/*
> >>>>>>>> +	 * The same elf_function is shared amongst combined functions,
> >>>>>>>> +	 * as per saved_functions_combine().
> >>>>>>>> +	 */
> >>>>>>>> +	struct elf_function *elf = combined_states[0].elf;
> >>>>>>> The logic is okay. But can we limit elf->sym_cnt to be 1 here?
> >>>>>>> This will match the case where two functions (weak and strong)
> >>>>>>> co-exist in compiler and eventually only strong/global function
> >>>>>>> will survive.
> >>>>>> In fact, checking again I believe that the loop is redundant because
> >>>>>> elf_function__has_ambiguous_address() ensures that if we reach this
> >>>>>> point, all symbols for the function share the same address. Therefore,
> >>>>>> checking the first symbol (elf->syms[0]) should be sufficient and
> >>>>>> equivalent to checking all of them.
> >>>>>>
> >>>>>> Will send through a v2 with this amendment.
> >>>>> Hm, actually, no. I don't think the addresses stored within
> >>>>> elf->syms[#].addr should all be assumed to be the same at the point
> >>>>> which the new btf_encoder__select_canonical_state() function is called
> >>>>> (due to things like skip_encoding_inconsistent_proto possibly taking
> >>>>> effect). Therefore, I think it's best that we leave things as is and
> >>>>> exhaustively iterate through all elf->syms? I don't believe there's
> >>>>> any adverse effects in doing it this way anyway?
> >>>>
> >>>> No. Your code is correct. For elf->sym_cnt, it covers both sym_cnt
> >>>> is 1 or more than 1. My previous suggestion is to single out the
> >>>> sym_cnt = 1 case since it is what you try to fix.
> >>>>
> >>>> I am okay with the current implementation since it is correct.
> >>>> Maybe Alan and Arnaldo have additional comments about the code.
> >>>
> >>> Sure, sounds good. I think leaving it as is probably our best bet at
> >>> this point.
> >>>
> >>
> >> hi Matt, I ran the change through github CI and there is some differences in
> >> the set of generated functions from vmlinux (see the "Compare functions generated"
> >> step):
> >>
> >> https://github.com/alan-maguire/dwarves/actions/runs/20786255742/job/59698755550
> >>
> >> Specifically we see changes in some function signatures like this:
> >>
> >> < int neightbl_fill_info(struct sk_buff * skb, struct neigh_table * tbl, u32 pid, u32 seq, int type, int flags);
> >> ---
> >>> int neightbl_fill_info(struct sk_buff * skb, struct neigh_table * tbl, u32 pid, u32 seq, int flags, int type);
> >>
> >> Note the reordering of the last two parameters. The "<" line matches the source code, and the
> >> ">" line is what we get from pahole with your change. We've seen this before and the reason is 
> >> that we're not paying close enough attention to cases where the actual function omits parameters
> >> due to optimization; that last "type" parameter doesn't have a DW_AT_location and that indicates 
> >> it's been optimized out. We should really get in this case is:
> >>
> >> int neightbl_fill_info.constprop.0(struct sk_buff * skb, struct neigh_table * tbl, u32 pid, u32 seq, int flags);
> >>
> >> So it's not that your change causes this exactly; it's that paradoxically because
> >> your change does a better job of selecting the real function signature in the CU
> >> (and then we go on to misrepresent it) the problem is more glaringly exposed.
> >>
> >> The good news is I think I have a workable fix for this problem; what I'd propose is - 
> >> presuming it works - we land it prior to your change. Once I've tested that out a bit
> >> I'll follow up. Thanks!
> > 
> > Ha, interesting! Curious, should the .constprop.0 based functions also
> > not be emitted within the generated BTF given that they too
> > technically would exist in the .text section and can be called?
> 
> Yep, but the original policy - that we are changing - was to avoid encoding
> anything that violated source-level expectations. So if a .constprop
> function omitted a parameter it was left out of BTF encoding. But annoyingly
> we often weren't detecting that correctly, so we would up with function signatures
> that had out-of-order parameters which should have been recognized as having
> missng parameters (and thus omitted). We're moving towards the concept of "true" 
> function signatures where we emit a possibly changed function with its "." suffix
> name; see Yonghong's presentation at Linux Plumbers for more details.

Noted, and appreciate the explanation here. I'll also watch Yonghong's
presentation [0] to get a little bit more of an idea on what we're
effectively moving towards.

> I've put together a series that weaves together better detection of
> misordered/missing parameters, optional support for emitting true function 
> signatures for optimized functions and finally your patch. With the prerequisite
> patches in place, your patch (which needed some merging but is essentially the
> same) no longer emits signatures with different ordered parameters; we better
> detect such cases. See [1]; changes are in branch in [2].
> 
> Most of the detected function signature changes are syscalls which have
> the pt_regs "regs" name rather than "__unused"; but in this case:
> 
> < int pcibios_enable_device(struct pci_dev * dev, int bars);
> < void pcibios_fixup_bus(struct pci_bus * bus);
> ---
> > int pcibios_enable_device(struct pci_dev * dev, int mask);
> > void pcibios_fixup_bus(struct pci_bus * b);
> 
> the signatures match the strong rather than weak declarations:
> 
> strong: 
> 
>  int pcibios_enable_device(struct pci_dev *dev, int mask);
>  void pcibios_fixup_bus(struct pci_bus *b);
> 
> weak:
> 
>   int __weak pcibios_enable_device(struct pci_dev *dev, int bars);
>   void __weak pcibios_fixup_bus(struct pci_bus *bus);
> 
> 
> so that's what we want.
>
> I need to do a bit more testing but it seems like this gets the behaviour
> you want without the side-effects due to existing brokenness in pahole.
> Let me know what you think. Thanks!

The prerequisite patches look OK to me, and the detected function
signature modifications bring us closer to where we want to be
IMO. So, LGTM overall.

> [1] https://github.com/alan-maguire/dwarves/actions/runs/20813525302/job/59783355126
> [2] https://github.com/acmel/dwarves/compare/master...alan-maguire:dwarves:refs/heads/pahole-next-true-sig-gcc
> 
> 
> > Apologies if I'm not understanding something correctly here, but my
> > current understanding is that non-.constprop.0 and .constprop.0
> > variants share differing addresses.
> > 
> > Anyway, please keep me updated on how you're progressing with the fix
> > that you're intending to work on.

[0] https://www.youtube.com/watch?v=u4-yWFiIZ98
