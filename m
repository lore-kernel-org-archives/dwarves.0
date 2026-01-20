Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2ED42EED6
	for <dwarves@vger.kernel.org>; Tue, 20 Jan 2026 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931678; cv=none; b=H6KY//QUOomtSPFM283w3Rs7d4+uGsq/GUWA2/kk/59874UdmnnekkODWbK2ZLne3FpqGVQLNp9rtrFBmHcA2jqFd9vNn72RLJRIDf5WpPPJBuKNQZxppVLck0VxE+5Mbf5cq1kCT50wb++Yv0GNphUnh4HuIPz3IVh0rATcSY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931678; c=relaxed/simple;
	bh=NBwkl3L/qWZdERVFVMlJvthiX57LHnU+xEZMdYaMlo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kIt4dirCdojpVGBBX86jjCjuQYUBGbKAZT2oQtUby0zC+nVMQxwMYjLVsIJPT/Xtcpv1hFsfOmfOn07LoA1L0gpc+nNUXRTipS4LwiQkxi4va5H5CRWG/goxWFBoIbg0J0eWVFnOMuaDNFRrtJ4/o6hc8IyZiYyCTeiBHws6nFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WAEBNje/; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WAEBNje/"
Message-ID: <5f9ec651-337b-441a-9bd6-8e03e91e2eb2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768931674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NBwkl3L/qWZdERVFVMlJvthiX57LHnU+xEZMdYaMlo8=;
	b=WAEBNje/3YHB87sCep6qe7yE/b+eW4Mia6+J8QKLrjNGL6q4PEnE0Fov6epy1U7pPvVtAq
	pVIg91WKUqi60gqkyT8/pvXT4meUq+m3sfCeg8t0AKackYPksLPyogCYLLDqZfXoF7/EyU
	GMgIXm+zFYTLDz8Y9DXtUDb32sdv0hc=
Date: Tue, 20 Jan 2026 09:54:29 -0800
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves 4/4] btf_encoder: Prefer strong function
 definitions for BTF generation
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>, mattbobrowski@google.com
Cc: eddyz87@gmail.com, ihor.solodrai@linux.dev, jolsa@kernel.org,
 andrii@kernel.org, ast@kernel.org, dwarves@vger.kernel.org,
 bpf@vger.kernel.org
References: <20260113131352.2395024-1-alan.maguire@oracle.com>
 <20260113131352.2395024-5-alan.maguire@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260113131352.2395024-5-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/13/26 5:13 AM, Alan Maguire wrote:
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

Acked-by: Yonghong Song <yonghong.song@linux.dev>

