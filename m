Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EAB14285;
	Fri,  7 Jun 2024 07:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717743802; cv=none; b=aAbWZUk5xWSUKbgvim9ul5aI/2N/GwxpNPG0iQRNFaNROge15cT05CUaqfrod8rk3i5LDNI57+aLOe3PlV1XEHlEiWEdzPQiOV9iREvgQvyMpubNhjaq1FzVbzxuZOqQBxVzbnGjMcpiTCcIHuEYFd3DhX5bjFTN82J62E0B+Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717743802; c=relaxed/simple;
	bh=wO2PzPoCQezCTD7afEp5BVpC169bwHolDmN76PUgCNM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PKRc05veqdXNfCfAo0xsmFSS8+1wPqnhJdjIuJytJoUdensVufFKDI/3vTxvWAdiDM+jG6vBpaDSdwA5iMYecdgC5be47LYrD7N6nqjFe/Y+gVmn541eLVwPGN6TqZyYg3/DsOsINFb4z0b+dMbDyye9hwx9tWtZCcmcM6jGROk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Message-ID: <f3fb90a2-5822-4cb9-ba5a-023f74f2e806@gentoo.org>
Date: Fri, 7 Jun 2024 09:03:14 +0200
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Matthias Schwarzott <zzam@gentoo.org>
Subject: Re: ANNOUNCE: pahole v1.26 (more holes, --bpf_features,
 --contains_enum)
To: Domenico Andreoli <domenico.andreoli@linux.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: dwarves@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
 Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Jan Engelhardt <jengelh@inai.de>, Viktor Malik <vmalik@redhat.com>,
 Eduard Zingerman <eddyz87@gmail.com>, J B <jb.1234abcd@gmail.com>
References: <YbC5MC+h+PkDZten@kernel.org> <ZkXTmTvII2PDqVvx@localhost>
Content-Language: en-GB, de-DE
In-Reply-To: <ZkXTmTvII2PDqVvx@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 16.05.24 um 11:36 schrieb Domenico Andreoli:
> On Wed, Feb 28, 2024 at 04:39:21PM -0300, Arnaldo Carvalho de Melo wrote:
>> Hi,
>>   
>> 	The v1.26 release of pahole and its friends is out, showing more
[...]
>>
>> tarball + gpg signature:
>>
>>     https://fedorapeople.org/~acme/dwarves/dwarves-1.26.tar.xz
>>     https://fedorapeople.org/~acme/dwarves/dwarves-1.26.tar.bz2
>>     https://fedorapeople.org/~acme/dwarves/dwarves-1.26.tar.sign
> 
> Which key do you use to sign this?          ^^^^^^^^^^^^^^^^^^^^^

Hi!

I found the matching key in git on kernel.org:

https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/plain/keys/D65016F35352AA40.asc

The gentoo package uses this key for verification now.

Regards
Matthias

