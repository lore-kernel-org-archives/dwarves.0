Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D03832548C
	for <dwarves@vger.kernel.org>; Wed,  7 Jan 2026 18:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767812157; cv=none; b=dV+hxnu7BrX+OJ0YzdKuSc5WOsK1KHOlhdwgjpDDySXrr4cRbDkFDofQZrACqX01DuEKLRLseh28vJpIaxhM6BA+TIfA8z8si8AYn8Sz9gUnOa+eGwfuUK4BAVQG4XTuJRJNLivhrck70OTpZmQ0Qj6rYnlQqAXH2U1qjI/doac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767812157; c=relaxed/simple;
	bh=CQ15+jmMikIU6wFwTAHawuxypljghp7aaFnKSDLlmbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CI76wGiflYxDCgOzQXSxSud/sb2gVPK/BYNqc+qMdcTWFpSr7LbAvkhmH3kq/ewG8yWB6pUsxHmg/620zLMAGG9PZ5AISJNU4j41zOO0pbVj1BRnOr2pyex2iT8T7X03SNLu5hPJb7AmynCEAsm1b8SmtaGzXWJczW4Bvb7SR1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jtwzycjl; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jtwzycjl"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7277324054so424165566b.0
        for <dwarves@vger.kernel.org>; Wed, 07 Jan 2026 10:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767812154; x=1768416954; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iB6LLjvjWZkbTDtVG9wXI4w/k1j407j8ihh7yY47E7s=;
        b=jtwzycjlJCx+DR6Y2OMX5oausWYviVwjaknRiNWQExCL6H67K3vQ7obZMy9KxClFQJ
         YUP26at0eFNn80BLnzgE8DiXNCq7azqtacNzcmrqnOgv80XvMRmZYsQA227zJdbqiEoE
         g6b1c4QC55rmP+FG0JKzuBlgnOxqQpSWhYsPU6CpZkPsZTjj/+TtPDUDDA5xPOyMQaCX
         6TQhpNjHacX8pYhj43bnbPaKYnniG0UzJR5paXuxB9xrIOXsiP7roXHMlkWwgvPyT1QM
         /e2LRuhMx3W1OaaFFTnfGB3UdjtfrDO+SkHOcLPlZawWHEImeBTU83hxuHuLV9SOoQoB
         gCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767812154; x=1768416954;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iB6LLjvjWZkbTDtVG9wXI4w/k1j407j8ihh7yY47E7s=;
        b=YSx9NOpQmXoNlKMKToWyaDV0WSFPr5EFrBLITwbJDhwXP4w+NMukM/dObxroBqsQVZ
         xgcg6qmDbunIJm8H+96AEzio0glmJRs+6SU0qm3CPUw1bEiM6mtTY/Hh14IwB53FrgDx
         wds/nZgzcOQqbLVTRGeyuID1PchgKAnneytk+VGx8wwEmDEQk1eUetSPi61VtFr2zUzb
         OVkxq1DKy3OhMuJgOH65tGi1NyY2gEO/u4w1K8wAW1OsPdT15bUD3fMXblJbVtzrF9H0
         2XsAMemmYwxAVEEq1hUU6I9+ueT5B6Z//D4g3jeH9wk8lOZ53+oSeeJi9YhCVm5+JlmJ
         DjAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeiyShZdCsprEcQnI6XBsuuQeNLsNSF72VU250WOL36gwtNND6F7ki+9YgwaALnogUuy5QlWIu@vger.kernel.org
X-Gm-Message-State: AOJu0YwVN4PPEp75Y08ng3bJnltM/sQkPzpzIY3DoDbtphp0fNxk5cNc
	783ax3mwcM+ye6ve1VcVdHi0zXmDBs34Ra5UjK18TE2jCR9nntCToAv0MoklMQdrAQ==
X-Gm-Gg: AY/fxX6BU8Yg+N/fOjUCIANw3z7HFkmMiMxjx/dwnWhlzonGFYSRYpSGKoyKwJktpC8
	RXOQ9lZJBlCD8leIzHJkss+RkGJGA+y/lM5/P/Xdw3zS+UJT12csLqOe0wwlr3GI4p9DBjnuy+i
	h61m9qlcEWDTJHJefV9oAa2RxEJsq6SOuy9pKKvZFT/9V6JJFZFkT1w9mTK/usO8azu3waWqetP
	fcMxTnRotZ9In4MmiDZiGPNW6Q79vieEhrX+KpR02EgSJGjlsZ6JaF/32r7kpZUP0a1SbuhVGyy
	0MXgEzQAkq7kFrP1vLuzNTfoEOuoeULeNwuCmM+I/rPjzGU3ibzDiFYlY6qzugBvkqSrs1zr41f
	BZLruApDdWImINbrTwt4Mij2deQdAF3TKhIhbxFI4PvkctVU30y2ofaMEIek2/ttwxhwKkEohuH
	lUIBCjZxEM9vyMMy2c8D32263vLwfvLQXMGPSPWy21tneZ91yb123dyA==
X-Google-Smtp-Source: AGHT+IG74AldfrSONuxqlnKLU7sKe1MqJmVX+YHwA9ZTvdPW2tPkplovcq9bbWp+RX4ZX/ellmtV0A==
X-Received: by 2002:a17:907:9704:b0:b83:1341:18ce with SMTP id a640c23a62f3a-b844502c5cemr354283466b.13.1767812153418;
        Wed, 07 Jan 2026 10:55:53 -0800 (PST)
Received: from google.com (14.59.147.34.bc.googleusercontent.com. [34.147.59.14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a5187afsm577555366b.58.2026.01.07.10.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 10:55:52 -0800 (PST)
Date: Wed, 7 Jan 2026 18:55:49 +0000
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
Message-ID: <aV6sNbs3vwCoGk49@google.com>
References: <20251231085322.3248063-1-mattbobrowski@google.com>
 <926aca4a-d7d5-4e7d-9096-77b27374c5cd@linux.dev>
 <aVt139VXMTka-hYw@google.com>
 <aVuk1e73g7ZTHqMY@google.com>
 <6b0968a3-406b-412f-acbb-c00ac2ad7c93@linux.dev>
 <aVwihhKEszvcyNKo@google.com>
 <ace92738-a52a-4248-b7d8-bcfce6f9af22@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ace92738-a52a-4248-b7d8-bcfce6f9af22@oracle.com>

On Wed, Jan 07, 2026 at 03:50:40PM +0000, Alan Maguire wrote:
> On 05/01/2026 20:43, Matt Bobrowski wrote:
> > On Mon, Jan 05, 2026 at 08:23:29AM -0800, Yonghong Song wrote:
> >>
> >>
> >> On 1/5/26 3:47 AM, Matt Bobrowski wrote:
> >>> On Mon, Jan 05, 2026 at 08:27:11AM +0000, Matt Bobrowski wrote:
> >>>> On Fri, Jan 02, 2026 at 10:46:00AM -0800, Yonghong Song wrote:
> >>>>>
> >>>>> On 12/31/25 12:53 AM, Matt Bobrowski wrote:
> >>>>>> Currently, when a function has both a weak and a strong definition
> >>>>>> across different compilation units (CUs), the BTF encoder arbitrarily
> >>>>>> selects one to generate the BTF entry. This selection fundamentally is
> >>>>>> dependent on the order in which pahole processes the CUs.
> >>>>>>
> >>>>>> This indifference often leads to a mismatch where the generated BTF
> >>>>>> reflects the weak definition's prototype, even though the linker
> >>>>>> selected the strong definition for the final vmlinux binary.
> >>>>>>
> >>>>>> A notable example described in [0] involving function
> >>>>>> bpf_lsm_mmap_file(). Both weak and strong definitions exist,
> >>>>>> distinguished only by parameter names (e.g., file vs
> >>>>>> file__nullable). While the strong definition is linked into the
> >>>>>> vmlinux object, the generated BTF contained the prototype for the weak
> >>>>>> definition. This causes issues for BPF verifier (e.g., __nullable
> >>>>>> annotation semantics), or tools relying on accurate type information.
> >>>>>>
> >>>>>> To fix this, ensure the BTF encoder selects the function definition
> >>>>>> corresponding to the actual code linked into the binary. This is
> >>>>>> achieved by comparing the DWARF function address (DW_AT_low_pc) with
> >>>>>> the ELF symbol address (st_value). Only the DWARF entry for the strong
> >>>>>> definition will match the final resolved ELF symbol address.
> >>>>>>
> >>>>>> [0] https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/
> >>>>>>
> >>>>>> Link: https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/
> >>>>>> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> >>>>> LGTM with some nits below.
> >>>> Thanks for the review.
> >>>>
> >>>>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> >>>>>
> >>>>>> ---
> >>>>>>    btf_encoder.c | 36 ++++++++++++++++++++++++++++++++++++
> >>>>>>    1 file changed, 36 insertions(+)
> >>>>>>
> >>>>>> diff --git a/btf_encoder.c b/btf_encoder.c
> >>>>>> index b37ee7f..0462094 100644
> >>>>>> --- a/btf_encoder.c
> >>>>>> +++ b/btf_encoder.c
> >>>>>> @@ -79,6 +79,7 @@ struct btf_encoder_func_annot {
> >>>>>>    /* state used to do later encoding of saved functions */
> >>>>>>    struct btf_encoder_func_state {
> >>>>>> +	uint64_t addr;
> >>>>>>    	struct elf_function *elf;
> >>>>>>    	uint32_t type_id_off;
> >>>>>>    	uint16_t nr_parms;
> >>>>>> @@ -1258,6 +1259,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
> >>>>>>    	if (!state)
> >>>>>>    		return -ENOMEM;
> >>>>>> +	state->addr = function__addr(fn);
> >>>>>>    	state->elf = func;
> >>>>>>    	state->nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
> >>>>>>    	state->ret_type_id = ftype->tag.type == 0 ? 0 : encoder->type_id_off + ftype->tag.type;
> >>>>>> @@ -1477,6 +1479,29 @@ static void btf_encoder__delete_saved_funcs(struct btf_encoder *encoder)
> >>>>>>    	encoder->func_states.cap = 0;
> >>>>>>    }
> >>>>>> +static struct btf_encoder_func_state *btf_encoder__select_canonical_state(struct btf_encoder_func_state *combined_states,
> >>>>>> +									  int combined_cnt)
> >>>>>> +{
> >>>>>> +	int i, j;
> >>>>>> +
> >>>>>> +	/*
> >>>>>> +	 * The same elf_function is shared amongst combined functions,
> >>>>>> +	 * as per saved_functions_combine().
> >>>>>> +	 */
> >>>>>> +	struct elf_function *elf = combined_states[0].elf;
> >>>>> The logic is okay. But can we limit elf->sym_cnt to be 1 here?
> >>>>> This will match the case where two functions (weak and strong)
> >>>>> co-exist in compiler and eventually only strong/global function
> >>>>> will survive.
> >>>> In fact, checking again I believe that the loop is redundant because
> >>>> elf_function__has_ambiguous_address() ensures that if we reach this
> >>>> point, all symbols for the function share the same address. Therefore,
> >>>> checking the first symbol (elf->syms[0]) should be sufficient and
> >>>> equivalent to checking all of them.
> >>>>
> >>>> Will send through a v2 with this amendment.
> >>> Hm, actually, no. I don't think the addresses stored within
> >>> elf->syms[#].addr should all be assumed to be the same at the point
> >>> which the new btf_encoder__select_canonical_state() function is called
> >>> (due to things like skip_encoding_inconsistent_proto possibly taking
> >>> effect). Therefore, I think it's best that we leave things as is and
> >>> exhaustively iterate through all elf->syms? I don't believe there's
> >>> any adverse effects in doing it this way anyway?
> >>
> >> No. Your code is correct. For elf->sym_cnt, it covers both sym_cnt
> >> is 1 or more than 1. My previous suggestion is to single out the
> >> sym_cnt = 1 case since it is what you try to fix.
> >>
> >> I am okay with the current implementation since it is correct.
> >> Maybe Alan and Arnaldo have additional comments about the code.
> > 
> > Sure, sounds good. I think leaving it as is probably our best bet at
> > this point.
> >
> 
> hi Matt, I ran the change through github CI and there is some differences in
> the set of generated functions from vmlinux (see the "Compare functions generated"
> step):
> 
> https://github.com/alan-maguire/dwarves/actions/runs/20786255742/job/59698755550
> 
> Specifically we see changes in some function signatures like this:
> 
> < int neightbl_fill_info(struct sk_buff * skb, struct neigh_table * tbl, u32 pid, u32 seq, int type, int flags);
> ---
> > int neightbl_fill_info(struct sk_buff * skb, struct neigh_table * tbl, u32 pid, u32 seq, int flags, int type);
> 
> Note the reordering of the last two parameters. The "<" line matches the source code, and the
> ">" line is what we get from pahole with your change. We've seen this before and the reason is 
> that we're not paying close enough attention to cases where the actual function omits parameters
> due to optimization; that last "type" parameter doesn't have a DW_AT_location and that indicates 
> it's been optimized out. We should really get in this case is:
> 
> int neightbl_fill_info.constprop.0(struct sk_buff * skb, struct neigh_table * tbl, u32 pid, u32 seq, int flags);
> 
> So it's not that your change causes this exactly; it's that paradoxically because
> your change does a better job of selecting the real function signature in the CU
> (and then we go on to misrepresent it) the problem is more glaringly exposed.
>
> The good news is I think I have a workable fix for this problem; what I'd propose is - 
> presuming it works - we land it prior to your change. Once I've tested that out a bit
> I'll follow up. Thanks!

Ha, interesting! Curious, should the .constprop.0 based functions also
not be emitted within the generated BTF given that they too
technically would exist in the .text section and can be called?
Apologies if I'm not understanding something correctly here, but my
current understanding is that non-.constprop.0 and .constprop.0
variants share differing addresses.

Anyway, please keep me updated on how you're progressing with the fix
that you're intending to work on.
