Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5343E17BB6
	for <dwarves@vger.kernel.org>; Fri, 31 Jan 2025 22:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738363281; cv=none; b=iBVQdLugRaiY2UDU2pCUXGodngfTLl8p4r0tFGPUoeB0Qvh4eVlSaYgQIUNVB5qYwn9X9COTD5ASlUIzzz/Sb8xdgGdkhCHJgADjTASJYlDtpoFurNsdLontfH4fZ7h0HmVbEOnt+8YbFqV0aXTAQUG66NHwJ4gnT3VNUaBVnkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738363281; c=relaxed/simple;
	bh=tOKHEN2axlm26XMGbIBaYDPFTBzrz/07F0A7BbkFtkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+fOwX88IGGS64eGaXHRfxGV+/lH6z1g86oHdQgGw4u5BRWuc/fCP2hvbouthLPzag2LevW4HwrYULaymBFZZU0jy+PGzkvdTCgaknkUAMzekaR1zcwd8R1Q20Jw6E5qikwtF98lARWp++J1pW0/xET/YvvdYoHgkD2L9p7+8oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BgMd7By6; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BgMd7By6"
Message-ID: <c8cf76ab-b00d-42f2-aeb3-143332ea61f5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738363276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nrki2uidYl7o9A5bGtx9yqeMvkDktcHZQKIVPm9Iipc=;
	b=BgMd7By6C4Y70ux/OXs6HU1k2fT3iSrADks0A1NePIQ/tboocEfx9qSPWyCZlxp7ubuFbu
	xrs3DfQOfvxuAboiUYjArBqhh9x0ovW2OI9qpGldJS174cn2Bs372Hj2gOFuxzhcx6bWxx
	+MNPAl1GyJ5O/KK2qmnOSCXkWLTehRI=
Date: Fri, 31 Jan 2025 14:41:01 -0800
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v2] btf_encoder: fix memory access bugs
To: Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org
Cc: eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com,
 bpf@vger.kernel.org, dwarves@vger.kernel.org
References: <20241216183112.206072-1-ihor.solodrai@pm.me>
 <8bb182c6a5f7a7ac3668297bca5a31467fac93de@linux.dev>
 <c52fcd63-c85f-41a6-ade4-a42c24c8cef8@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <c52fcd63-c85f-41a6-ade4-a42c24c8cef8@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/31/25 5:14 AM, Alan Maguire wrote:
 >> [...]
 >
 > Thanks for the reminder; we'll make sure this one gets applied shortly.
 > I wonder if we should add the -fsanitize flags to CFLAGS for RELEASE 
mode?
 >

The issue with these flags is that they significantly reduce
performance. We might consider adding them for debug builds, but
certainly not for the release.
