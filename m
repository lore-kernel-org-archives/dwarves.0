Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E8A4418FC
	for <dwarves@vger.kernel.org>; Tue, 20 Jan 2026 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925297; cv=none; b=sQ6aNAtbk/Th3G6TejwE7yiFOnDPO7oQ1F5exqQpn8IQjSqSnSwhDQGGsOejulqKslD/ANxRu6hpMmyT8S82x0psfb+xnNPcudO1EtaE1ldmAaZYZQbVW+q673jEoH9/sIh0RFcznnn9ggC/8kd9ftJJ8zmE6HvNTGrZPbhBMYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925297; c=relaxed/simple;
	bh=f/QC7FzwN9onimK80+gXZLxFwx7O7hVSRYIEouRG59c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVxkI1Yk0cSTcgb2H+JM0qphsFuZ0bgZiTp4WGV41HUaGGcDaBu70I+Sfo+AQSZOcVfm5+fYp/KH0UZ16cVl9bG2TXH7KWZpl5dEJfiJYe/YrIvlh2zOOmjof00CVVIqh58X8CI536GBePbUvmv3mZnoctUKOecXzIgWaUV51qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GyYyXxcK; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GyYyXxcK"
Message-ID: <b0a09b42-4858-4c28-b7a6-6ac1e856d7bc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768925283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6beUxqGFv/OlKjWUXcRthqjnv/MJaefBTXeSFu/wzgY=;
	b=GyYyXxcKjkNm3k0Vr+hZorNx+PxVfgjfv+Np7okYlTi9045XrFBA/x4UmtWoNY471F4W7J
	dom8FrfmsowtaDqqB83pewlq6OEQckcYKKppAW4FjYKGmspqdkQq2WKmPjJkSrqEB7BqA8
	7Sh2Vogv0xN7qBhqbNALvWZYmoOZHbs=
Date: Tue, 20 Jan 2026 08:07:57 -0800
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves 1/4] dwarf_loader/btf_encoder: Detect reordered
 parameters
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>, mattbobrowski@google.com
Cc: eddyz87@gmail.com, ihor.solodrai@linux.dev, jolsa@kernel.org,
 andrii@kernel.org, ast@kernel.org, dwarves@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260113131352.2395024-1-alan.maguire@oracle.com>
 <20260113131352.2395024-2-alan.maguire@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260113131352.2395024-2-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/13/26 5:13 AM, Alan Maguire wrote:
> When encoding concrete instances of optimized functions it is possible
> parameters get reordered, often due to a parameter being optimized out;
> in such cases the order of abstract origin references to the abstract
> function is different, and the parameters that are optimized out
> usually appear after all the non-optimized parameters with no
> DW_AT_location information [1].
>
> As an example consider
>
> static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu);
>
> It has - as expected - an abstract representation as follows:
>
>   <1><6392a2d>: Abbrev Number: 47 (DW_TAG_subprogram)
>      <6392a2e>   DW_AT_name        : (indirect string, offset: 0x261e25): __blkcg_rstat_flush
>      <6392a32>   DW_AT_decl_file   : 1
>      <6392a33>   DW_AT_decl_line   : 1043
>      <6392a35>   DW_AT_decl_column : 13
>      <6392a36>   DW_AT_prototyped  : 1
>      <6392a36>   DW_AT_inline      : 1   (inlined)
>      <6392a37>   DW_AT_sibling     : <0x6392bac>
>   <2><6392a3b>: Abbrev Number: 38 (DW_TAG_formal_parameter)
>      <6392a3c>   DW_AT_name        : (indirect string, offset: 0xa7a9f): blkcg
>      <6392a40>   DW_AT_decl_file   : 1
>      <6392a41>   DW_AT_decl_line   : 1043
>      <6392a43>   DW_AT_decl_column : 47
>      <6392a44>   DW_AT_type        : <0x638b611>
>   <2><6392a48>: Abbrev Number: 20 (DW_TAG_formal_parameter)
>      <6392a49>   DW_AT_name        : cpu
>      <6392a4d>   DW_AT_decl_file   : 1
>      <6392a4e>   DW_AT_decl_line   : 1043
>      <6392a50>   DW_AT_decl_column : 58
>      <6392a51>   DW_AT_type        : <0x6377f8f>
>
> However the concrete representation after optimization becomes:
>
> ffffffff8186d180 t __blkcg_rstat_flush.isra.0
>
> and has a concrete representation with parameter order switched:
>
> <1><6399661>: Abbrev Number: 110 (DW_TAG_subprogram)
>      <6399662>   DW_AT_abstract_origin: <0x6392a2d>
>      <6399666>   DW_AT_low_pc      : 0xffffffff8186d180
>      <639966e>   DW_AT_high_pc     : 0x169
>      <6399676>   DW_AT_frame_base  : 1 byte block: 9c    (DW_OP_call_frame_cfa)
>      <6399678>   DW_AT_GNU_all_call_sites: 1
>      <6399678>   DW_AT_sibling     : <0x6399a8a>
>   <2><639967c>: Abbrev Number: 4 (DW_TAG_formal_parameter)
>      <639967d>   DW_AT_abstract_origin: <0x6392a48>
>      <6399681>   DW_AT_location    : 0x1fe21fb (location list)
>      <6399685>   DW_AT_GNU_locviews: 0x1fe21f5
>   <2><63996e4>: Abbrev Number: 4 (DW_TAG_formal_parameter)
>      <63996e5>   DW_AT_abstract_origin: <0x6392a3b>
>      <63996e9>   DW_AT_location    : 0x1fe2387 (location list)
>      <63996ed>   DW_AT_GNU_locviews: 0x1fe2385
>
> In other words we end up with
>
> static void __blkcg_rstat_flush.isra(int cpu, struct blkcg *blkcg);
>
> We are not detecting cases like this in pahole, so we need to
> catch it to exclude such cases since they could lead to incorrect
> fentry attachment.
>
> Future work around true function signatures will allow such functions
> with their "." suffixes, but even for such cases it is good to
> detect the reordering.
>
> In practice we just end up excluding a few more .isra/.constprop
> functions which we cannot fentry-attach by name anyway; see [2] for an
> example list from CI.
>
> [1] https://lore.kernel.org/bpf/101b74c9-949a-4bf4-a766-a5343b70bdd2@oracle.com/
> [2] https://github.com/alan-maguire/dwarves/actions/runs/20031993822
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

