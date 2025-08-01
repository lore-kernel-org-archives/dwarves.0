Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA9C21ABC9
	for <dwarves@vger.kernel.org>; Fri,  1 Aug 2025 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754080016; cv=none; b=j6GGFQrHI1E5m13Mx1DUnM3AxGJ57eB/cja0jBbpkkLfCqH55fdldsXud0OvlEWbhWe32aUPA2rtU4oUtxWmCQbeSTE8h1akYN/MI5SdoUu0UIc/+1nSbFHBySzQoWhY0iH9XWMNZcHwsi96OEB6vuXvNR9yw2i0BGQZviWc9ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754080016; c=relaxed/simple;
	bh=/oViQhBKat6ZeLJT18N8iVysoSuo/2mTpnQkaO6XPyA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=h9rciUfwZJHEBNGO1xnYD2FYGrDDhBQSDQfLfn6q9I3BJG/Q0a4F0OU1SesRtlBwOxCzAaOssFk3wVsiDJXqKc09m19CMBH5dLzv2/VAQqOmkrbhV7Nr4k6imy48Bq3pIKk0wIF6jzgiftuADYbOTtml+otXlme2GZ3p3P9wwbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TbTQ1u9L; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TbTQ1u9L"
Message-ID: <01897e65-19bb-4cfe-92fe-8d8170905d26@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754080012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/oViQhBKat6ZeLJT18N8iVysoSuo/2mTpnQkaO6XPyA=;
	b=TbTQ1u9LTiDbCTYp65HHzpbDh+cEkL05SiYkzriHtbWYQu5cP7fXORzkoN7v6OevtrAAqu
	xbAabYQXifh2xMKMl7sNxYfZuiK/bLDCd6GJzQbSfjHxZwp4HvRXI3q3KgaDn1tySPFHvd
	NLJ3j3mtl3i1Kn264fVTkNOfDkFb7Ls=
Date: Fri, 1 Aug 2025 13:26:45 -0700
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v3] btf_encoder: group all function ELF syms by
 function name
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves <dwarves@vger.kernel.org>
Cc: alan.maguire@oracle.com, domenico.andreoli@linux.com, acme@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, kernel-team@meta.com,
 olsajiri@gmail.com, menglong8.dong@gmail.com, song@kernel.org,
 yonghong.song@linux.dev
References: <20250801202009.3942492-1-ihor.solodrai@linux.dev>
Content-Language: en-US
In-Reply-To: <20250801202009.3942492-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Adding a few people to cc, used wrong sending script.
