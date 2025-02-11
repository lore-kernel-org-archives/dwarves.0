Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E5F2594
	for <dwarves@vger.kernel.org>; Tue, 11 Feb 2025 00:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739233001; cv=none; b=Inq6dzGBO8yJ4+n3yZ6F19VGF7bGBHu73MRqLDx5xPP9Dng2+S92lK/E2OYAVSv/C7ryQ+cHtm35vuSMUy+blwwPdePF3NCEqspmij7MZFhdXVzaSHr1G3RPZdkAC+hb1G9y8UvDi7/EVvNMKqeBjAkXJVLUWad8IRRazh3wCNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739233001; c=relaxed/simple;
	bh=+w1muybnuRdnCE2SJBzU+6LEPFsK9+6Rv7KDcML39eI=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=EvdU1Q4r6Sajs7qMwxBgiYg/onbvIlgVfQwDn3CMCjaRgANmn1J4k3aL+FyHn3Z63Hc40C/qDUE/UMdaYrwVAEzv9b492713vPDCXTz3Tv9fspZoRnAWbGhIlsjFUqrTbO0A4XzbyNWlC55d1q5tVZ+95pCud908bFOQdy+Nvf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iTCVB7G9; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iTCVB7G9"
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739232987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+w1muybnuRdnCE2SJBzU+6LEPFsK9+6Rv7KDcML39eI=;
	b=iTCVB7G98yNaCVRay6TXG9NzjYkiNFzRyNmQVj0ovvCkpl+fhoFXfDGmfU60LGAGDEk/wl
	vG/KjrPkGaxPVGjDumj0smJE5T6pTntkdcDMSRkSJe1gbEgKi13DAs1a0ZEgvqJSWSSTuu
	01rpSU2N65Tt2J5aEmIA4BvPpstViRg=
Date: Tue, 11 Feb 2025 00:16:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <4d7b119dc632e0b8ea4ed6da4a5b49b20a521676@linux.dev>
TLS-Required: No
Subject: Re: [PATCH dwarves 3/3] pahole: introduce --btf_feature=attributes
To: "Alan Maguire" <alan.maguire@oracle.com>, dwarves@vger.kernel.org,
 bpf@vger.kernel.org
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 mykolal@fb.com, kernel-team@meta.com
In-Reply-To: <a1b4d24b-9d7b-464c-8055-f8a270082e65@oracle.com>
References: <20250207021442.155703-1-ihor.solodrai@linux.dev>
 <20250207021442.155703-4-ihor.solodrai@linux.dev>
 <a1b4d24b-9d7b-464c-8055-f8a270082e65@oracle.com>
X-Migadu-Flow: FLOW_OUT

On 2/10/25 2:13 PM, Alan Maguire wrote:
> On 07/02/2025 02:14, Ihor Solodrai wrote:
>> Add a feature flag "attributes" (default: false) controlling whether
>> pahole is allowed to generate BTF attributes: type tags and decl tags
>> with kind_flag =3D 1.
>>
>> This is necessary for backward compatibility, as BPF verifier does not
>> recognize tags with kind_flag =3D 1 prior to (at least) 6.14-rc1 [1].
>>
>> [1] https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai=
@linux.dev/
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Needs update to pahole man page describing the new "attributes"
> btf_feature, but aside from that LGTM.

I was wondering what have I missed. Thanks.

>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>
> [...]
