Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3937A223328
	for <dwarves@vger.kernel.org>; Fri, 23 Jan 2026 19:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769195278; cv=none; b=aFkDrbtJdtc6XVfCckeIr2YRgT6aOf4rlh95WD3hEgO4/CsgbbqfZJFhCX7Nk8kn1ssMwwPWo2YGRkZwdEQdpPigM4V2KaSgrqhAvI0IDatBokyT32PUwQ//X5vLU4ThGvBTnNRrcub0LV6hzig+GwtxoOcBTEaTyyr7gOI+/7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769195278; c=relaxed/simple;
	bh=/dDJkjeIEUZ0QrmpIxgnU4SvarDMl1u3MX7uC7dwTCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uiD/ncdVX5kfFVskHif3KrjvyN6zJDtHdZoIvKSjx1mpwIlPlJ4uODOBW1P40ff0IlGtmyLIhHbUXN7YdJj3w2egOuu4T/CLGVgmDwb98TA+43i+Uallb8xohQeP0zO1UZpkye+coQcGVadf51lYBnObql9UR6w+jLe0wDQrkrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FLGIulQI; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FLGIulQI"
Message-ID: <39784428-7547-4f2b-8d7a-d4b7a85991cc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769195275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/dDJkjeIEUZ0QrmpIxgnU4SvarDMl1u3MX7uC7dwTCI=;
	b=FLGIulQIkgFJo36SfxdrqWMmcT1kBYgSBEp78Xlx0oylX2o8KwgcnuiEEYVfQY0k571ycl
	o0kRJTngL46Rf1P03rJJg6vzSQ13BcqXYcWMvBzlsw1D3gGQlc3HtHNFPUm+r8ldbVbu8Q
	yBIX/tCIQnYdkY7gVEM6L1VJh1Sr3Ds=
Date: Fri, 23 Jan 2026 11:07:49 -0800
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 dwarves 4/5] man-pages: document true_signature
 btf_feature
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>, mattbobrowski@google.com
Cc: ihor.solodrai@linux.dev, eddyz87@gmail.com, jolsa@kernel.org,
 andrii@kernel.org, ast@kernel.org, david.faust@oracle.com,
 dwarves@vger.kernel.org, bpf@vger.kernel.org
References: <20260123172650.4062362-1-alan.maguire@oracle.com>
 <20260123172650.4062362-5-alan.maguire@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260123172650.4062362-5-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/23/26 9:26 AM, Alan Maguire wrote:
> Ensure non-default "true_signature" feature is documented in
> the manual page.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

