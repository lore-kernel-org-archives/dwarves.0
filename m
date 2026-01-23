Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ABD27703C
	for <dwarves@vger.kernel.org>; Fri, 23 Jan 2026 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769195222; cv=none; b=hxbfzPyatq0uZ+nnwNs9t6J9tvQSy0DKW0FUyiMjmq7EBHzW3hiocJcJMqQIs0FuJl90w/lc8slBzt29lkdNgCCa6LCgj8Kt7GLSUSVbVSzhHkxuwRoEKqHsolU7Oz6PyrBKQRsc7UNjltD62TYNEJJj9JPVjltCOmE3F1uPBMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769195222; c=relaxed/simple;
	bh=9gNEEHZWeZPGUz7Bg1RzDIw7ae4vY/3fiqNwShzMwS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+msaMPJuH2rtaySgjECPzFkWBv4RncKpGIgwk2j2+pSYNkcugQOjYQ52CEQeDiCy+XEWO5cw+PIkhlfFD49YJT8sCVaG0ehdgF95Z5Oipz18QMLtYW/8noNC0Kt5/+edKx+0RH+l5fDzFn0QbeunA5Zf/WoB4StADza1wwssIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LmgNKyPP; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LmgNKyPP"
Message-ID: <6b57f6c0-cd9c-43e0-b5dc-daa9fdef84bb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769195210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9gNEEHZWeZPGUz7Bg1RzDIw7ae4vY/3fiqNwShzMwS0=;
	b=LmgNKyPPH/Rt0ClhsttMn9HrWmQod5akBoDGLLnRE6s0xCPhDSrXRnHUjK4ZRSQd1E1z/H
	pqKBvtfUoRUJ5laTTHCLxfu5xDebhYYw93y7ZHpDb1mBwUT1CaetFDb8anRBVTIrrNns3y
	iixAfNAd1okpHrvQ4svw0s14UhsblRQ=
Date: Fri, 23 Jan 2026 11:06:44 -0800
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 dwarves 3/5] test: add gcc true signature test
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>, mattbobrowski@google.com
Cc: ihor.solodrai@linux.dev, eddyz87@gmail.com, jolsa@kernel.org,
 andrii@kernel.org, ast@kernel.org, david.faust@oracle.com,
 dwarves@vger.kernel.org, bpf@vger.kernel.org
References: <20260123172650.4062362-1-alan.maguire@oracle.com>
 <20260123172650.4062362-4-alan.maguire@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260123172650.4062362-4-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/23/26 9:26 AM, Alan Maguire wrote:
> Use Yonghong's true signature test program to verify signatures
> differ for function "foo" with optimized-out parameter.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Tested and it works fine to me.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

