Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEC530FC10
	for <dwarves@vger.kernel.org>; Mon,  5 Jan 2026 11:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613663; cv=none; b=Ad6FMiLTx9astaVB6PjEpoW9Z17XRqDB1APFzS/eUMQ5JhyYEgke5cOTUH1Fx8gRat3WSzCfoykzs6aN1S9lJDv8uT5plxMNzbxteJVcStOtPLx4BaanogwhaJu/xY/K2PaCgbb9p/FdqN5rPXx+XQtrmcHdtKE6cMSgMoJxZeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613663; c=relaxed/simple;
	bh=ts3iwxZ2cAbMT/W4sDfy5XyKUhMUiEEMD/Y4uJZyk30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mpgf/2U7hHfQE0jwuy+7mqzq3g18tS3Mrk/epFFfYdLab5gFB686U+bAyKmbSegO9gCppA36ncgd52RqdmZ3KWALPOHe6/9t2Qlv7XuP4zrswCQ5V4hxQQeTSPIKpreYjiD7RjJohfwS/4fwyxlqW5sTQ1tm+SuFs7lSc2vBPPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uLXoUlXn; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uLXoUlXn"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6505d3adc3aso431609a12.1
        for <dwarves@vger.kernel.org>; Mon, 05 Jan 2026 03:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767613658; x=1768218458; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m17uYCatZPNweCRBX/sngXFTPvpwP0pbjoi0G6O2mgc=;
        b=uLXoUlXnyBqVtEtaEEMaQ28y6E4o0ng7z+nOimkqAy3RG+v5BWJy4Gz/Xhw4U79zqE
         E6tXhJpMdrIPOcFwXyAYkLtw1+NFmqn7Oyiu131gk2p+3nM3Or/sG1Vv14hsp7WAmVLt
         z9txUgLLQj5wK0/r3NyK18a73jD4LAivfdCjox8b+xBQeDll7m5FDmF/CS60KzdZHuKj
         FopExmn6UO3xvp3lyQBYXcoLiO/BDlBZflxO1kagR1F5jrt38O/eAaijmIxV6ytdVOxD
         zE3Gx9Km23USHZU6LFHdIzZfqOQN55ik+HNr91ZmK57SSEWQL+fEEhLToWBbYcpmsvq/
         04fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767613658; x=1768218458;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m17uYCatZPNweCRBX/sngXFTPvpwP0pbjoi0G6O2mgc=;
        b=LnhJKgheO68o1HV+8Kkcw7Unvna1q/b/s3kYI/4BYdSM5Ybf7AjVZuFk3HKR9FTLWh
         KaoxRgEU7pBJOABwyrDghBs3vjo9Wzpri4XNfZMkHF47SRaMp9nu7SmF80idkdJfKyGG
         IjejXxbyqWHXgUg4kmHPM2GzwK7kK2pqwTwH69bw2JlamuVyGXUSdm0/LtiC3h0GHR9R
         gxTp9vxKiCoxAzKWirR/ghKn8lrEav3oQUABYh+JE1DQucxH0+rRQYy/mwLurXS6KIlK
         6jGJccWGdzZnrfY/crUc4+w3pnOYKsecTbvFcjl+ackVuTj5T+vveEGSocT5QGa0etOp
         xGyg==
X-Forwarded-Encrypted: i=1; AJvYcCVesAhnU/7xL+mZx6wUK688rnOjI2x3+KY1gs0pqRTKEeRalenwIMllvDAQ8F8HXGIH3AWrjm6G@vger.kernel.org
X-Gm-Message-State: AOJu0YwszHAvangG+oa6SoYmBWjJCn8XZOFmEAVr7I0RNO5lgJF0lsas
	K3IDIUosL58v1fn8Wvx7xhYR2WSo1ixzQPN/NOf1naRelf2YNJ7BZyZHXpuLyrLSPQ==
X-Gm-Gg: AY/fxX7DH9oHdEPUKQSggGb7s30StWZbu4nmnrx13fWyznsiAq7vqgqa87HvJh/bMfw
	zsRsOlN16BH+lwUWb8RU6sZEZJbf4O/V/mQEILfqG5fS/tSdaRJE/l0uzRXhgovtz2jEGfwSrqq
	NtLsmlxfdTsyYpWrzEQe3agUo8h5xoFv0tKG5LfgDzG9dPIMgHyNesKBn3W9RmRzGJIOYWuW8fk
	YNIfUzSiedU9E4NDtNrHROucipYgH0YXnLDBE/zv9Uf4e/+rBdsF0P1G+KAGfBBBkFnA7jOJwKc
	rzSP9AdFD/DgJhUDHk7VkWtv64u5uab2b83QWIOWEdC2Yjj9BPBHDIXHYqUz8+4/zfVYV2PvI2J
	+9/iX8kmtr+9KvlilrNy7yQZDr7QN3AFoJtAH8QgNqq4+26wJO42R2MYWD0FPThSIiwM23LcgeO
	Tf1ro1v8oXXF7xi6y+SQhLvNgV7jA4/lzcYMG6Gc6lS0HMUJ5uzEWo4Q==
X-Google-Smtp-Source: AGHT+IGuetLP0nVJFf8G40HuKlEjGvP4p2WkBVwDQXq6+Oe3bbGFu5XYHxd/BJZjAz7Mu37PliTbdQ==
X-Received: by 2002:a05:6402:2706:b0:64d:f39:3fdb with SMTP id 4fb4d7f45d1cf-64d0f3941a6mr42766682a12.13.1767613657383;
        Mon, 05 Jan 2026 03:47:37 -0800 (PST)
Received: from google.com (14.59.147.34.bc.googleusercontent.com. [34.147.59.14])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9105a9c4sm53770107a12.12.2026.01.05.03.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 03:47:36 -0800 (PST)
Date: Mon, 5 Jan 2026 11:47:33 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>,
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
Message-ID: <aVuk1e73g7ZTHqMY@google.com>
References: <20251231085322.3248063-1-mattbobrowski@google.com>
 <926aca4a-d7d5-4e7d-9096-77b27374c5cd@linux.dev>
 <aVt139VXMTka-hYw@google.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aVt139VXMTka-hYw@google.com>

On Mon, Jan 05, 2026 at 08:27:11AM +0000, Matt Bobrowski wrote:
> On Fri, Jan 02, 2026 at 10:46:00AM -0800, Yonghong Song wrote:
> > 
> > 
> > On 12/31/25 12:53 AM, Matt Bobrowski wrote:
> > > Currently, when a function has both a weak and a strong definition
> > > across different compilation units (CUs), the BTF encoder arbitrarily
> > > selects one to generate the BTF entry. This selection fundamentally is
> > > dependent on the order in which pahole processes the CUs.
> > > 
> > > This indifference often leads to a mismatch where the generated BTF
> > > reflects the weak definition's prototype, even though the linker
> > > selected the strong definition for the final vmlinux binary.
> > > 
> > > A notable example described in [0] involving function
> > > bpf_lsm_mmap_file(). Both weak and strong definitions exist,
> > > distinguished only by parameter names (e.g., file vs
> > > file__nullable). While the strong definition is linked into the
> > > vmlinux object, the generated BTF contained the prototype for the weak
> > > definition. This causes issues for BPF verifier (e.g., __nullable
> > > annotation semantics), or tools relying on accurate type information.
> > > 
> > > To fix this, ensure the BTF encoder selects the function definition
> > > corresponding to the actual code linked into the binary. This is
> > > achieved by comparing the DWARF function address (DW_AT_low_pc) with
> > > the ELF symbol address (st_value). Only the DWARF entry for the strong
> > > definition will match the final resolved ELF symbol address.
> > > 
> > > [0] https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/
> > > 
> > > Link: https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/
> > > Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> > 
> > LGTM with some nits below.
> 
> Thanks for the review.
> 
> > Acked-by: Yonghong Song <yonghong.song@linux.dev>
> > 
> > > ---
> > >   btf_encoder.c | 36 ++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 36 insertions(+)
> > > 
> > > diff --git a/btf_encoder.c b/btf_encoder.c
> > > index b37ee7f..0462094 100644
> > > --- a/btf_encoder.c
> > > +++ b/btf_encoder.c
> > > @@ -79,6 +79,7 @@ struct btf_encoder_func_annot {
> > >   /* state used to do later encoding of saved functions */
> > >   struct btf_encoder_func_state {
> > > +	uint64_t addr;
> > >   	struct elf_function *elf;
> > >   	uint32_t type_id_off;
> > >   	uint16_t nr_parms;
> > > @@ -1258,6 +1259,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
> > >   	if (!state)
> > >   		return -ENOMEM;
> > > +	state->addr = function__addr(fn);
> > >   	state->elf = func;
> > >   	state->nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
> > >   	state->ret_type_id = ftype->tag.type == 0 ? 0 : encoder->type_id_off + ftype->tag.type;
> > > @@ -1477,6 +1479,29 @@ static void btf_encoder__delete_saved_funcs(struct btf_encoder *encoder)
> > >   	encoder->func_states.cap = 0;
> > >   }
> > > +static struct btf_encoder_func_state *btf_encoder__select_canonical_state(struct btf_encoder_func_state *combined_states,
> > > +									  int combined_cnt)
> > > +{
> > > +	int i, j;
> > > +
> > > +	/*
> > > +	 * The same elf_function is shared amongst combined functions,
> > > +	 * as per saved_functions_combine().
> > > +	 */
> > > +	struct elf_function *elf = combined_states[0].elf;
> > 
> > The logic is okay. But can we limit elf->sym_cnt to be 1 here?
> > This will match the case where two functions (weak and strong)
> > co-exist in compiler and eventually only strong/global function
> > will survive.
> 
> In fact, checking again I believe that the loop is redundant because
> elf_function__has_ambiguous_address() ensures that if we reach this
> point, all symbols for the function share the same address. Therefore,
> checking the first symbol (elf->syms[0]) should be sufficient and
> equivalent to checking all of them.
> 
> Will send through a v2 with this amendment.

Hm, actually, no. I don't think the addresses stored within
elf->syms[#].addr should all be assumed to be the same at the point
which the new btf_encoder__select_canonical_state() function is called
(due to things like skip_encoding_inconsistent_proto possibly taking
effect). Therefore, I think it's best that we leave things as is and
exhaustively iterate through all elf->syms? I don't believe there's
any adverse effects in doing it this way anyway?

> > > +
> > > +	for (i = 0; i < combined_cnt; i++) {
> > > +		struct btf_encoder_func_state *state = &combined_states[i];
> > > +
> > > +		for (j = 0; j < elf->sym_cnt; j++) {
> > > +			if (state->addr == elf->syms[j].addr)
> > > +				return state;
> > > +		}
> > > +	}
> > > +
> > > +	return &combined_states[0];
> > > +}
> > > +
> > >   static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_encoding_inconsistent_proto)
> > >   {
> > >   	struct btf_encoder_func_state *saved_fns = encoder->func_states.array;
> > > @@ -1517,6 +1542,17 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
> > >   					0, 0);
> > >   		if (add_to_btf) {
> > > +			/*
> > > +			 * We're to add the current function within
> > > +			 * BTF. Although, from all functions that have
> > > +			 * possibly been combined via
> > > +			 * saved_functions_combine(), ensure to only
> > > +			 * select and emit BTF for the most canonical
> > > +			 * function definition.
> > > +			 */
> > > +			if (j - i > 1)
> > > +				state = btf_encoder__select_canonical_state(state, j - i);
> > > +
> > >   			if (is_kfunc_state(state))
> > >   				err = btf_encoder__add_bpf_kfunc(encoder, state);
> > >   			else
> > 
