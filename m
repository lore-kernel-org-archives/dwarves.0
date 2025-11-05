Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906F92C08B0
	for <dwarves@vger.kernel.org>; Wed,  5 Nov 2025 07:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762326017; cv=none; b=LmHmOOhM+Z4nfCNqxTVA+c0uMXGNJN/4VBK9TZQSxQzjp5LxOxz6EUL/otGL5jxyZsTRkp6WVUrAT7D/MyUi1ZIts35+2NP8VagRvDBtFsqgJFIGaTTZqfwRQzoKgtVQcXJXAABpVCjqaMni2lIqIFaCh6ulxUrIeP6/QL2TiBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762326017; c=relaxed/simple;
	bh=b3uKeyCVpHhO/GtbxvdQHML0vlC2c6jyp+psIKo8yuQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GbXo0A7+Digr21Wd0+EbRcdSXv6aqIEh/8cbqkmTjlPjOtzusdb1b4EiyHvAbkxVviiR9v/xBKgcMQ/t0hu+t4fMXj0qsE2AGp5y65MSxv4J52mx+IzTKNx8dvBdjcoAsRZO+yU0yt+TQc6Iu+kAt9Ml779QbfsaqPblklw0MIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2001:a62:4d6:5401:ad99:51f1:12ea:ab02] (unknown [IPv6:2001:a62:4d6:5401:ad99:51f1:12ea:ab02])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zzam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 53DDA33DF47;
	Wed, 05 Nov 2025 07:00:01 +0000 (UTC)
Message-ID: <656efe8d-7214-4d5c-a47b-3ceb1eb5ff26@gentoo.org>
Date: Wed, 5 Nov 2025 08:00:19 +0100
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Matthias Schwarzott <zzam@gentoo.org>
Subject: Re: pahole: Fix deprecated cmake_minimum_required
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, dwarves@vger.kernel.org
References: <bef26065-2dd0-43df-9dfb-f3c4b7a17685@gentoo.org>
 <aQDY7_VtHlFP7ssB@x1>
Content-Language: en-US
In-Reply-To: <aQDY7_VtHlFP7ssB@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 28.10.25 um 15:53 schrieb Arnaldo Carvalho de Melo:
> On Tue, Oct 28, 2025 at 07:58:17AM +0100, Matthias Schwarzott wrote:
>> I got to know that using a cmake_minimum_required version of less than 3.10
>> is deprecated. Support for it will be removed from cmake.
> 
> Support for what? For features present before 3.10? So we better make
> sure that we have pahole use that 'cmake_minimum_required(3.10)' so that
> we don't end up using such deprecated cmake features and end up breaking
> the build in distros using, say, cmake 3.11?

Similar. If we declare cmake_minimum_version less than 3.10 then a new 
released cmake-4.3 might error out similar to this (when I reduce 
min-version to 3.0):

   CMake Error at CMakeLists.txt:1 (cmake_minimum_required):
     Compatibility with CMake < 3.5 has been removed from CMake.

     Update the VERSION argument <min> value.  Or, use the <min>...<max> 
syntax
     to tell CMake that the project requires at least <min> but has been 
updated
     to work with policies introduced by <max> or earlier.

     Or, add -DCMAKE_POLICY_VERSION_MINIMUM=3.5 to try configuring anyway.

> 
> Please CC dwarves@vger.kernel.org when sending patches, like I did in
> this reply :-)

Good to know.

Regards
Matthias

> 
> Thanks!
> 
> - Arnaldo
>   
>> I suggest to raise the minimum required cmake version to at least 3.10
>> (released 20 November 2017).
>> See attached patch.
> 
>> see gentoo pahole issue: https://bugs.gentoo.org/964482
>> gentoo overall issue: https://bugs.gentoo.org/964405
>   
>> cmake merge request:
>> https://gitlab.kitware.com/cmake/cmake/-/merge_requests/9875
>   
>> deprecate-pre-3.10
>> ------------------
>   
>> * Compatibility with versions of CMake older than 3.10 is now deprecated
>>    and will be removed from a future version.  Calls to
>>    :command:`cmake_minimum_required` or :command:`cmake_policy` that set
>>    the policy version to an older value now issue a deprecation diagnostic.
> 
>>  From b9e521ef5e9c01d8d19f505de778ceaef5ecd4eb Mon Sep 17 00:00:00 2001
>> From: Matthias Schwarzott <zzam@gentoo.org>
>> Date: Tue, 28 Oct 2025 07:52:00 +0100
>> Subject: [PATCH] CMakeLists.txt: Require cmake 3.10 or higher
>>
>> To fix this warning from cmake:
>>
>> CMake Deprecation Warning at CMakeLists.txt:1 (cmake_minimum_required):
>>    Compatibility with CMake < 3.10 will be removed from a future version of
>>    CMake.
>>
>>    Update the VERSION argument <min> value.  Or, use the <min>...<max> syntax
>>    to tell CMake that the project requires at least <min> but has been updated
>>    to work with policies introduced by <max> or earlier.
>>
>> Signed-off-by: Matthias Schwarzott <zzam@gentoo.org>
>> ---
>>   CMakeLists.txt | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/CMakeLists.txt b/CMakeLists.txt
>> index eb873000d7bf..91522c1382a5 100644
>> --- a/CMakeLists.txt
>> +++ b/CMakeLists.txt
>> @@ -1,4 +1,4 @@
>> -cmake_minimum_required(VERSION 3.5)
>> +cmake_minimum_required(VERSION 3.10)
>>   project(pahole C)
>>   cmake_policy(SET CMP0005 NEW)
>>   
>> -- 
>> 2.51.0
>>
> 

