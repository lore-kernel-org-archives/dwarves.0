Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E67F2848AA
	for <dwarves@vger.kernel.org>; Fri, 23 Jan 2026 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769195371; cv=none; b=TcFMXv71mAYFxUe8dsBXgfhjSUtS/W9QXZ88hlUNHoXegi7+NA0YSuyF7Jw3MYBSf3T4O4Z4fRi1MajuVjnRPO4VNpU4ycLwV+1AIhHZ4wwWC4zVWTWnK5tfsqPsln0eILeqsUwWuMWEprUs919KJcldzVDKxPAuaeyZ/k441/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769195371; c=relaxed/simple;
	bh=rHyoHYiJe1NSSbI9wKgeFZFr/60HKWlObMZBZd0MZbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKD6Dg60fB1BIMyyFIdaVdrDoP3Io6IWVxG8yYjUEbghYgbB3wAFJcMR7Eg2s3ZkfJBc7uMELpEBZNW61qiUY8niDK/9rrn7nksIJlAneUPpS8NQO1S+hBOICeOryBEwQHF/j02KlbXmfk6/PMRFNVIdytovS8Op4YOWa4YhcuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MfAIRmb5; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MfAIRmb5"
Message-ID: <c647240e-26c6-4d6b-8218-d3c0e17d9b00@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769195355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHyoHYiJe1NSSbI9wKgeFZFr/60HKWlObMZBZd0MZbE=;
	b=MfAIRmb5Jwl+3OJ3+LKsNgeke9b/IVfms1CgovK3jQ2GLj1KT6s+w62VWnMSByIUDwe67D
	6c6Ao5hswOYvAp30Z0LA3qYLebb9+SgsqXWUQTkgvYLKXlOdAthVhjGeT9Hs1MUi60X6oa
	IEm+exGW6vzq44v6fTNr8msbDmRqi7I=
Date: Fri, 23 Jan 2026 11:09:11 -0800
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 dwarves 5/5] btf_encoder: Prefer strong function
 definitions for BTF generation
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>, mattbobrowski@google.com
Cc: ihor.solodrai@linux.dev, eddyz87@gmail.com, jolsa@kernel.org,
 andrii@kernel.org, ast@kernel.org, david.faust@oracle.com,
 dwarves@vger.kernel.org, bpf@vger.kernel.org
References: <20260123172650.4062362-1-alan.maguire@oracle.com>
 <20260123172650.4062362-6-alan.maguire@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260123172650.4062362-6-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/23/26 9:26 AM, Alan Maguire wrote:
> From: Matt Bobrowski <mattbobrowski@google.com>
>
> Currently, when a function has both a weak and a strong definition
> across different compilation units (CUs), the BTF encoder arbitrarily
> selects one to generate the BTF entry. This selection fundamentally is
> dependent on the order in which pahole processes the CUs.
>
> This indifference often leads to a mismatch where the generated BTF
> reflects the weak definition's prototype, even though the linker
> selected the strong definition for the final vmlinux binary.
>
> A notable example described in [0] involving function
> bpf_lsm_mmap_file(). Both weak and strong definitions exist,
> distinguished only by parameter names (e.g., file vs
> file__nullable). While the strong definition is linked into the
> vmlinux object, the generated BTF contained the prototype for the weak
> definition. This causes issues for BPF verifier (e.g., __nullable
> annotation semantics), or tools relying on accurate type information.
>
> To fix this, ensure the BTF encoder selects the function definition
> corresponding to the actual code linked into the binary. This is
> achieved by comparing the DWARF function address (DW_AT_low_pc) with
> the ELF symbol address (st_value). Only the DWARF entry for the strong
> definition will match the final resolved ELF symbol address.
>
> [0] https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/
>
> Link: https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>

I have checked and verified that the logic is sound.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

