Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D448C46B8
	for <dwarves@vger.kernel.org>; Fri, 27 Sep 2024 20:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727467748; cv=none; b=sU8REIbWKgT3aK8X1HPBI7Z6iK35F4sPOP8E5zZnQLFHZam8mLsNsjxNLrdqW3pPqlxVzpTV1pGQYua+aH0jZrNqds6AeX0ZZfy014xk5LbnBFAmP2Nnsfx4s4QAeqZLxtexp+n1Ka8xtqCxA5GGqAlCmvR4p80M/DvCAaMGVas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727467748; c=relaxed/simple;
	bh=E+jSmNTSxMkJbOqmyrMQjaFeZ12a73Pujpv6bsYLPFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vAivMVyt8SM20G0Ac9GYgim86vjEMJKdanwWrzJ6OwK8G2RAS4ywizH/yUfQ3uC9yL+5llFwmWu13VR88liwjWBYN4dNBWsy4iRFEdm+q2QwIPyV+50RUtXtatIPDwUMv8HU/fN78dLWipbhnPfZ20mElnPl8F37iSMPWq3EiGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=dP8O1JBb; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="dP8O1JBb"
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id u2m9siRKHnNFGuHGusZKgm; Fri, 27 Sep 2024 20:09:00 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id uHGtsfn2Z4aFuuHGusqWOC; Fri, 27 Sep 2024 20:09:00 +0000
X-Authority-Analysis: v=2.4 cv=YY+75RRf c=1 sm=1 tr=0 ts=66f710dc
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=yaedEk91eZQBl80JN7XfQg==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=dUpo_7X2abgxCebbql4A:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1LvW4I7BwJXo8YRsfhX9yk0XIvSGeOw9UTCXTo5U9nw=; b=dP8O1JBb+ksJeRQI+Ccbl3F8RC
	nps88VIj4NPMtEUyi2V21uDEFYaWDReLl5EC5LUZO0PneGmg2qjWtKY4sjGIMzlunw2mOT0HZDbJt
	dmUtWB7HJKKUSBdyyEA72Sk926Kd6YHNIr02i7K3t4qSqzm04R7gaw2ytn83rakpmYPUtelVFa9Fu
	UKC5+M4HiX2enveGvZV1L0vUD7hyHhm1RyWXd6f9BWmUN/Z6C4Hpf0TMhKnTzXOj3RYtYwhZPvHBr
	1MWRFTvIJzy1yulOmlP9vwW3NIfZ6NR2X2z5wtZORkvJQY91LBaCGtXROPjsAo/xXOj9GrdxHz5Kb
	/iCJYupA==;
Received: from [78.197.79.13] (port=33950 helo=[192.168.73.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1suHGt-002map-01;
	Fri, 27 Sep 2024 15:08:59 -0500
Message-ID: <91b1e52c-fba0-47a5-b105-d7c97cf6c322@embeddedor.com>
Date: Fri, 27 Sep 2024 22:08:54 +0200
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] --padding option to combine with
 --with_flexible_array
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>, dwarves@vger.kernel.org,
 Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>,
 Clark Williams <williams@redhat.com>, Kate Carcia <kcarcia@redhat.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20240927185958.37310-1-acme@kernel.org>
 <b1bbd9c1-d9f7-4305-b107-f4dc3f9827a9@embeddedor.com> <ZvcJ-REjrrUfImcZ@x1>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <ZvcJ-REjrrUfImcZ@x1>
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
X-Exim-ID: 1suHGt-002map-01
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.73.44]) [78.197.79.13]:33950
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAXaMQ/u2F0+FvY00zssA9j7wyTRbT0ECRJnEngcfFBfBZOTZEnhQ0tNP2YFfPtyCgYD57NYXU48dviIO6k1s5wE1wRZ/HAMTXieZF44J8X4MdWSzWOh
 cx7UaFCaPk1PACb4EQeBgVkQsfsYraRWQWl1Wcf7IS6DHFVgh5ZYJKssP6rtzIC2sPcLjH94ZbiCouvZ+V+lwmr2rJUaYHNK1ik=



> acme@x1:~$ pahole --padding_ge 1 --with_flexible_array > pahole--padding_ge_1_--with_flexible_array.`uname -r`.txt
> acme@x1:~$ ls -lart pahole--padding_ge_1_--with_flexible_array.6.10.10-200.fc40.x86_64.txt
> -rw-r--r--. 1 acme acme 172848 Sep 27 16:36 pahole--padding_ge_1_--with_flexible_array.6.10.10-200.fc40.x86_64.txt
> acme@x1:~$
> 
> It is at http://vger.kernel.org/~acme/pahole--padding_ge_1_--with_flexible_array.6.10.10-200.fc40.x86_64.txt

Awesome. :)

Thanks a lot!
--
Gustavo
