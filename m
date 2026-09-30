Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75534EDCC3
	for <dwarves@vger.kernel.org>; Wed, 30 Sep 2026 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790783143; cv=none; b=G0oezfO4qu1Ap0LfSm2J1QvoLGSRbYOwdwv1tmvTks7yFpMXQzvlG4qdCP39Y/Sc1CJ77qKm9iq6nYuVez4pyCFGmG/g4PbcBJCQWi3etaqYJhzczrLU03ocym+4nMCBzSmyWL70CA8DLaGoXnBympvzDa4GEYh5YTa5aCX19mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790783143; c=relaxed/simple;
	bh=7GFIGS8nTaICIrcF0Ku+hXoe9VESh+Q8OTbnmMzJkwM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nj+0n5IYwVxR4s6JgZla6aHhh2vaoCS35dDi1L7rEVv1efMvl053Ld8pCG3p9c4TXxSQezNsKUTbiwhaqxl3AqLh340UzrwvrIpzbiTEBUMk+uZiMQCqH3sEpDFnGjqjNTUIypPKtvYMTFeJ4F4Rt7r6/9ETTtZjGu4vs89siGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsF72jyr; arc=none smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsF72jyr"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acbdf627ccso2290400a12.2
        for <dwarves@vger.kernel.org>; Wed, 30 Sep 2026 08:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790783131; x=1791387931; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SnuX1SOtp6v3Zz5dNVeJKCigck4bUGAuwqKalsntj8Q=;
        b=IsF72jyr6kTxff68qEOqRwWT2JtDj2vnshir6IKgIMy5DmMAfG9NlYMxx/Uk3rFpru
         EAWOxNMD3lXodhF+blRVU4Cwq3aydKlpn3A3YPe2B1dLf3PZwY0MHnrk/k0v/2GOnjia
         vXf57d6KlMyRe6XpAcIQTp+pnxl18dlhN3o09UQ0pZJQ7nDV9GAg2pIyaTLNhXw9f68Z
         S/MyTqUjLFCwGi/w3nJkv304TacEZ8q43Rg2CjLzgzCmF5OA6dCn/PsB0uSGbmlUiDiQ
         ZuBT3g+hAgI3rL2VQt9h5HljVytYq587HWEvq1P0MbIDW9vvx437PKndFSHK97+wdEFH
         BzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790783131; x=1791387931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SnuX1SOtp6v3Zz5dNVeJKCigck4bUGAuwqKalsntj8Q=;
        b=s08HbtByoYnmCrG1giWSs1yAL/sPcYJxgWJ/Wn+/I/Mn2YCV96voE0iltL28G1HLHm
         ezB0sWcxerZG4j+r8EnsbNUAE38Xa1I1fL/VnDtS6d6LlMNrUtnxHFD2TleN0B1OrRcO
         Xq2C60GLEdxTPxHLB/QY+rge5cGZYV+LvJSpJidduzF9XxR4j8ZhmNlcMCCWLTVpzioU
         AOFItjvqrh8h0TlUuwTsf84zvndO1cEHXwoFl7iRGq2HM02H/QPFFTp4Ru/ptdNUic/S
         7/UErLgZERxEGvZ8/JWvlQtpjgwrrcHNmqAodJHsln/DeLzstrELD4tCobuTku1GHYHK
         yk2Q==
X-Forwarded-Encrypted: i=1; AKwUvBwYXMc1SJGrzXDDSieKvt2eimlcSL4AM67Dk4S5KQj58+z0UWbh75dzPbgOqpeKubMjID669mmD@vger.kernel.org
X-Gm-Message-State: AFuF++mlTuukX8HWsnJAV+MhaS3XnOHOWRT3nSQHm7pMw42HXhfIfhrB
	V27VNZnwke+kLuMzjUZep2XHAkJJnw+1GyckO0xGO7sn7zQOf8Kp4Ncw
X-Gm-Gg: AYBFou02W5NMVd1D54ac5zi4hMnDvcjpeJAlrCOuq9AW9Q98b9hRSdVZ2HTydyfVj/1
	zGyXD9dRYXw1lR4VHcFtdzIrCZNAAY1xkl6J1bYSgXu6GI7B7WnZLptfuxVBeYOMyOn0C/6Mqt/
	jbsEIuzqhcFgDm0hb/a4Gs5/+rzHVpDj5H68eCuGrzuarpANgRV10X4hgcU/ZCtc8+sluUJTsyt
	MmTByfKCREd1aQFtDYR1ubngOXz2l/rUuJB6GsPVjezppYe3JtNXWs5ow6v08Uu56pGOOf2NHLr
	x8PMxTZ6/m2R+dMwg+PrUu54pY1K6dO2zTGBcACTI3XfgE+dXmEa1Gv0ij28RBZFx+bXR+EolVx
	YPZthhH4z69gYzNfGlLJJKsMQQMoR4nMDk/r1rhSKx+sL5PT2FhnLcsUgeneKAfb4y29uAHTAeR
	hT/temdDK0taVukPDJ+FFBCrFZWiw0CHlkJcC1ExNztqbrcoUTxiQKrLD2ew==
X-Received: by 2002:a17:907:969f:b0:c2e:42e:4da0 with SMTP id a640c23a62f3a-c2e23ce67ebmr160109666b.19.1790783130831;
        Wed, 30 Sep 2026 08:45:30 -0700 (PDT)
Received: from krava ([173.38.220.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31dc751dsm27611566b.67.2026.09.30.08.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 08:45:30 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 30 Sep 2026 17:45:28 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
	qmo@kernel.org, dwarves@vger.kernel.org, daniel@iogearbox.net,
	ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
	martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
	bpf@vger.kernel.org, nsc@kernel.org, puranjay@kernel.org,
	yatsenko@meta.com
Subject: Re: [PATCH v3 dwarves 1/9] dwarf_loader: Add parameter list to
 inlined expansions
Message-ID: <ar0umERDiFj2sN3W@krava>
References: <20260925185200.1318067-1-alan.maguire@oracle.com>
 <20260925185200.1318067-2-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260925185200.1318067-2-alan.maguire@oracle.com>

On Fri, Sep 25, 2026 at 07:51:50PM +0100, Alan Maguire wrote:

SNIP

> -static int die__process_inline_expansion(Dwarf_Die *die, struct lexblock *lexblock, struct cu *cu, struct conf_load *conf)
> +static int die__process_inline_expansion(Dwarf_Die *die,
> +					 struct inline_expansion *exp,
> +					 struct lexblock *lexblock,
> +					 struct cu *cu, struct conf_load *conf)
>  {
>  	Dwarf_Die child;
>  	struct tag *tag;
> +	int parm_idx = 0;
>  
>  	if (!dwarf_haschildren(die) || dwarf_child(die, &child) != 0)
>  		return 0;
> @@ -2957,6 +2965,7 @@ static int die__process_inline_expansion(Dwarf_Die *die, struct lexblock *lexblo
>  	die = &child;
>  	do {
>  		uint32_t id;
> +		bool add_to_inline_expansion = false;
>  
>  		switch (dwarf_tag(die)) {
>  		case DW_TAG_call_site:
> @@ -2975,13 +2984,10 @@ static int die__process_inline_expansion(Dwarf_Die *die, struct lexblock *lexblo
>  				goto out_enomem;
>  			continue;
>  		case DW_TAG_formal_parameter:
> -			/*
> -			 * Inline expansions can have their own formal
> -			 * parameter children duplicating the abstract
> -			 * origin's parameters.  These are not needed
> -			 * for type reconstruction — skip them.
> -			 */
> -			continue;
> +			tag = die__create_new_parameter(die, NULL, lexblock, exp,
> +							cu, conf, parm_idx++);
> +			add_to_inline_expansion = true;
> +			break;
>  		case DW_TAG_inlined_subroutine:
>  			tag = die__create_new_inline_expansion(die, lexblock, cu, conf);
>  			break;
> @@ -3010,6 +3016,8 @@ static int die__process_inline_expansion(Dwarf_Die *die, struct lexblock *lexblo
>  
>  		if (cu__table_add_tag(cu, tag, &id) < 0)
>  			goto out_delete_tag;
> +		if (add_to_inline_expansion)

could we just check (tag->tag == DW_TAG_formal_parameter) instead the
new bool?


> +			inline_expansion__add_parameter(exp, tag__parameter(tag));
>  hash:
>  		cu__hash(cu, tag);
>  		struct dwarf_tag *dtag = tag__dwarf(tag);
> @@ -3032,8 +3040,8 @@ static struct tag *die__create_new_inline_expansion(Dwarf_Die *die,
>  	if (exp == NULL)
>  		return NULL;
>  
> -	if (die__process_inline_expansion(die, lexblock, cu, conf) != 0) {
> -		tag__free(&exp->ip.tag, cu);
> +	if (die__process_inline_expansion(die, exp, lexblock, cu, conf) != 0) {
> +		tag__delete(&exp->ip.tag, cu);
>  		return NULL;
>  	}
>  
> @@ -3115,7 +3123,8 @@ static int die__process_function(Dwarf_Die *die, struct ftype *ftype,
>  			continue;
>  		}
>  		case DW_TAG_formal_parameter:
> -			tag = die__create_new_parameter(die, ftype, lexblock, cu, conf, param_idx++);
> +			tag = die__create_new_parameter(die, ftype, lexblock, NULL,
> +							cu, conf, param_idx++);
>  			break;
>  		case DW_TAG_variable:
>  			tag = die__create_new_variable(die, cu, conf, 0);
> @@ -3562,75 +3571,103 @@ static void __tag__print_abstract_origin_not_found(struct tag *tag,
>  #define tag__print_abstract_origin_not_found(tag) \
>  	__tag__print_abstract_origin_not_found(tag, __func__, __LINE__)
>  
> -static void ftype__recode_dwarf_types(struct tag *tag, struct cu *cu)
> +static void parameter__share_state_with_abstract_origin(struct parameter *parm,
> +							struct parameter *oparm)
> +{
> +	if (parm->has_loc)
> +		oparm->has_loc = parm->has_loc;
> +	if (parm->has_const_value)
> +		oparm->has_const_value = parm->has_const_value;
> +	if (parm->loc_const_value)
> +		oparm->loc_const_value = parm->loc_const_value;
> +	if (parm->loc_stack)
> +		oparm->loc_stack = parm->loc_stack;
> +	if (parm->loc_reg != PARAMETER_UNKNOWN_REG)
> +		oparm->loc_reg = parm->loc_reg;
> +	if (parm->type_byte_size != 0)
> +		oparm->type_byte_size = parm->type_byte_size;
> +	if (parm->passed_in_memory)
> +		oparm->passed_in_memory = parm->passed_in_memory;
> +	oparm->first_reg_fields |= parm->first_reg_fields;
> +	oparm->second_reg_fields |= parm->second_reg_fields;
> +	if (parm->true_sig_member_name && !oparm->true_sig_member_name) {
> +		oparm->true_sig_member_name = parm->true_sig_member_name;
> +		oparm->true_sig_type = parm->true_sig_type;
> +		oparm->true_sig_type_from_types = parm->true_sig_type_from_types;
> +	}
> +	if (parm->optimized)
> +		oparm->optimized = parm->optimized;
> +	if (parm->unexpected_reg)
> +		oparm->unexpected_reg = parm->unexpected_reg;
> +}
> +
> +static void parameter__recode_dwarf_type(struct parameter *parm, struct cu *cu,
> +						 struct ftype *ftype)

could this be added in separate change? seems like it could
ease up the readability a bit

>  {
> -	struct parameter *pos;
>  	struct dwarf_cu *dcu = cu->priv;
> -	struct ftype *type = tag__ftype(tag);
> -
> -	ftype__for_each_parameter(type, pos) {
> -		struct dwarf_tag *dpos = tag__dwarf(&pos->tag);
> -		struct parameter *opos;
> -		struct dwarf_tag *dtype;
> +	struct dwarf_tag *dparm = tag__dwarf(&parm->tag);
> +	struct dwarf_tag *dtype;
>  
> -		if (dpos->type == 0) {
> -			if (dpos->abstract_origin == 0) {
> -				/* Function without parameters */
> -				pos->tag.type = 0;
> -				continue;
> -			}
> -			dtype = dwarf_cu__find_tag_by_ref(dcu, dpos, abstract_origin);
> -			if (dtype == NULL) {
> -				tag__print_abstract_origin_not_found(&pos->tag);
> -				continue;
> -			}
> -			opos = tag__parameter(dtag__tag(dtype));
> -			pos->name = opos->name;
> -			if (pos->idx != opos->idx)
> -				type->reordered_parm = 1;
> -			pos->tag.type = dtag__tag(dtype)->type;
> -			/* share location information between parameter and
> -			 * abstract origin; if neither have location, we will
> -			 * mark the parameter as optimized out.  Also share
> -			 * info regarding unexpected register use for
> -			 * parameters.
> -			 */
> -			if (pos->has_loc)
> -				opos->has_loc = pos->has_loc;
> -			if (pos->has_const_value)
> -				opos->has_const_value = pos->has_const_value;
> -			if (pos->loc_const_value)
> -				opos->loc_const_value = pos->loc_const_value;
> -			if (pos->loc_stack)
> -				opos->loc_stack = pos->loc_stack;
> -			if (pos->loc_reg != PARAMETER_UNKNOWN_REG)
> -				opos->loc_reg = pos->loc_reg;
> -			if (pos->type_byte_size != 0)
> -				opos->type_byte_size = pos->type_byte_size;
> -			if (pos->passed_in_memory)
> -				opos->passed_in_memory = pos->passed_in_memory;
> -			opos->first_reg_fields |= pos->first_reg_fields;
> -			opos->second_reg_fields |= pos->second_reg_fields;
> -			if (pos->true_sig_member_name && !opos->true_sig_member_name) {
> -				opos->true_sig_member_name = pos->true_sig_member_name;
> -				opos->true_sig_type = pos->true_sig_type;
> -				opos->true_sig_type_from_types = pos->true_sig_type_from_types;
> -			}
> +	if (dparm->type == 0) {
> +		struct parameter *oparm;
>  
> -			if (pos->optimized)
> -				opos->optimized = pos->optimized;
> -			if (pos->unexpected_reg)
> -				opos->unexpected_reg = pos->unexpected_reg;
> -			continue;
> +		if (dparm->abstract_origin == 0) {
> +			parm->tag.type = 0;
> +			return;
>  		}
>  
> -		dtype = dwarf_cu__find_type_by_ref(dcu, dpos, type);
> +		dtype = dwarf_cu__find_tag_by_ref(dcu, dparm, abstract_origin);
>  		if (dtype == NULL) {
> -			tag__print_type_not_found(&pos->tag);
> -			continue;
> +			tag__print_abstract_origin_not_found(&parm->tag);
> +			return;
>  		}
> -		pos->tag.type = dtype->small_id;
> +
> +		oparm = tag__parameter(dtag__tag(dtype));
> +		parm->name = oparm->name;
> +		if (ftype != NULL && parm->idx != oparm->idx)
> +			ftype->reordered_parm = 1;

looks like we could end up with wrong argument index if the dwarf
info is missing for the argument, my agent is suggesting this fix

it gets me over 16k changes like this:

-0xffffffff8100e322 [__show_trace_log_lvl+0xb2, .text +0xe322] get_stack_pointer(struct task_struct * task [const 0], struct pt_regs * regs [%r14])
+0xffffffff8100e322 [__show_trace_log_lvl+0xb2, .text +0xe322] get_stack_pointer(struct task_struct * task [%r14], struct pt_regs * regs [const 0])

I tried to validate one against dwarf info and it seems
to be correct with the fix ;-)

thanks,
jirak


---
diff --git a/dwarf_loader.c b/dwarf_loader.c
index 49a88d526d9e..d0fb8fda08cd 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3867,8 +3867,15 @@ static void parameter__recode_dwarf_type(struct parameter *parm, struct cu *cu,
 
 		oparm = tag__parameter(dtag__tag(dtype));
 		parm->name = oparm->name;
-		if (ftype != NULL && parm->idx != oparm->idx)
-			ftype->reordered_parm = 1;
+		if (ftype != NULL) {
+			if (parm->idx != oparm->idx)
+				ftype->reordered_parm = 1;
+		} else {
+			/* Inline-site parameters may omit or reorder children;
+			 * use the abstract origin's position as the slot.
+			 */
+			parm->idx = oparm->idx;
+		}
 		parm->tag.type = dtag__tag(dtype)->type;
 		if (ftype != NULL)
 			parameter__share_state_with_abstract_origin(parm, oparm);
