Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A53F139D1B
	for <dwarves@vger.kernel.org>; Fri, 27 Sep 2024 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727465070; cv=none; b=nziC+BGUljYErprWEiPwCtT1hNDMhtaRVuvSMhkc1YbkGJrDEpdSA+/CTHRPwQqiHCZLbLaOZhWCxWkYt+2xUFlJ4HsXmmOgKYBbBsB3QLT9Z5+S3TIesQB9UOP3d4CXDFLqbqEBXfNWdbmWXIHgy2r7i87tCkHTzwpK1UqPCRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727465070; c=relaxed/simple;
	bh=pxrq78J0nc+xM0uROwHSQXiM3a+Mfjsw2UGkG1pri/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJPS7K1xJQungQKLUPAMCimpLhGFQ6J5oujAgCKvbhZY86smXc9F2CktZwpucSY744g63e3tLWqsN4K1jjdY0pR0T6YxY3c24bVLAZYRrkq83xOWLCtX53tzidHcjgRfIewdLRPrJA/4pdiakIrAWfShlepHeISsFqYTeI9/9HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=ud+XZT/v; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ud+XZT/v"
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id uFYjslpIHVpzpuGYGsrpkv; Fri, 27 Sep 2024 19:22:52 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id uGYEsenXk4aFuuGYFspbTJ; Fri, 27 Sep 2024 19:22:51 +0000
X-Authority-Analysis: v=2.4 cv=YY+75RRf c=1 sm=1 tr=0 ts=66f7060b
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=yaedEk91eZQBl80JN7XfQg==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7T7KSl7uo7wA:10 a=20KFwNOVAAAA:8
 a=VwQbUJbxAAAA:8 a=ayLr_CEeaL_6LRy27XIA:9 a=QEXdDO2ut3YA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RSwP98DEn36lEiJKN9Uhk0Kjqe7gqfkVVFuFdB60ZrI=; b=ud+XZT/vMubIYat+7aNtNKq1mj
	MlOGMCmZJi8ruY3uSwYtIIQX95w/mslzlfL36nz4n1+jRdN28khbtWHd1Hl7k+xqXrLO3tbRw9oM5
	ztLqb/r17meZYTGlZcOAE9TQN1oO9P2CCtcNfsONaE3+XcY6HL0SkyovMyD9dq3Gez8R5lu1sVXgs
	6w0AlLN78/R/Rdctly/2+KirdQE05M42xGcWqI8P30bngxImUctgEulAKLZFRSFx9lQEY1zgprCOa
	8uyqfw+wDR6+ByDPk5my1aXBzXl/6j8nLVWZo3uUe+d38+76rijPMEdbdHZeW2scknOB1hQ8dr/n/
	80Rf2rbA==;
Received: from [78.197.79.13] (port=58846 helo=[192.168.73.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1suGYE-0020jI-01;
	Fri, 27 Sep 2024 14:22:50 -0500
Message-ID: <b1bbd9c1-d9f7-4305-b107-f4dc3f9827a9@embeddedor.com>
Date: Fri, 27 Sep 2024 21:22:46 +0200
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] --padding option to combine with
 --with_flexible_array
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Willy Tarreau <w@1wt.eu>
Cc: dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
 Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
 Kate Carcia <kcarcia@redhat.com>, Arnaldo Carvalho de Melo
 <acme@redhat.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20240927185958.37310-1-acme@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240927185958.37310-1-acme@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 78.197.79.13
X-Source-L: No
X-Exim-ID: 1suGYE-0020jI-01
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.73.44]) [78.197.79.13]:58846
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGmXwL2OzGxQTfpInt5xzqiUVesfsXaDaRIE8p+QDS3r3bgskkLXKCBhbOtShFrCYjHytmswQlTco6gx2HZQdnvgVfMFAAocq8gX2TFdwUiKRt0iVlCa
 6WeCdVddpARlp2jmvN9EYTXQUDeJ35ItMGy1nP85RnbhgnOWhd94sFS7eEwWD6EP9ZpO5hIeZzYlYWhgDGRclPhf3/0W9vo6+Wg=



On 27/09/24 20:59, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Hi,
> 
> 	This implements --padding, that combined with the already
> available --with_flexible_array option may catch some questionable
> structs.
> 
> 	This comes from a quick discussion I had with Willy Tareau after
> Gustavo's talk at this year's Kernel Recipes.

Nice. :)

I think it'd be interesting to take a look at the output of the
following command:

$ pahole --padding_ge 1 --with_flexible_array

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> 
> 	I have this in the 'next' branch of:
> 
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git
> 
> 	Willy, is that what you had in mind?
> 
> Cheers,
> 
> - Arnaldo
> 
> Arnaldo Carvalho de Melo (2):
>    pahole: Add --padding_ge N to show only structs with at least N bytes of padding at its end
>    pahole: Add --padding N to show only structs with N bytes of padding at its end
> 
>   man-pages/pahole.1 |  8 ++++++++
>   pahole.c           | 17 ++++++++++++++++-
>   2 files changed, 24 insertions(+), 1 deletion(-)
> 
