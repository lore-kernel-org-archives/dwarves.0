Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E13C47096
	for <linux-dwarves@archiver.kernel.org>; Thu,  3 Jun 2021 07:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45BAB613D6
	for <linux-dwarves@archiver.kernel.org>; Thu,  3 Jun 2021 07:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhFCHkM (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 3 Jun 2021 03:40:12 -0400
Received: from foss.arm.com ([217.140.110.172]:34368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229635AbhFCHkL (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 3 Jun 2021 03:40:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AC6611FB;
        Thu,  3 Jun 2021 00:38:27 -0700 (PDT)
Received: from [10.163.82.76] (unknown [10.163.82.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56DFA3F73D;
        Thu,  3 Jun 2021 00:38:26 -0700 (PDT)
Subject: Re: [PATCH 2/2] README: add documentation for -DBUILD_SHARED_LIBS
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, qais.yousef@arm.com
References: <cover.1622612388.git.deepakkumar.mishra@arm.com>
 <6307fc26935026e9c9a765ae2f0f50226c891d34.1622612388.git.deepakkumar.mishra@arm.com>
 <YLeFM9VnG/kBwlB2@kernel.org>
From:   Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
Message-ID: <7150cf9b-345e-dc38-4c60-1e51155ed69c@arm.com>
Date:   Thu, 3 Jun 2021 13:08:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YLeFM9VnG/kBwlB2@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hi Arnaldo,

On 6/2/21 6:48 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jun 02, 2021 at 11:26:24AM +0530, Deepak Kumar Mishra escreveu:
>> added a section in README to give details about use of -DBUILD_SHARED_LIBS
>> cmake option and existing documentation reformatted to accomodate this.
> 
> So are you changing the default to build as static? Please keep the
> existing default and make building statically the opt-in mode, ok?
> 
As per Cmake documentation if -DBUILD_SHARED_LIBS is present and true, 
cmake will cause all libraries to be built shared.
https://cmake.org/cmake/help/latest/variable/BUILD_SHARED_LIBS.html 

If you still suggest, I can override the default behavior to SHARED and 
only when -DBUILD_SHARED_LIBS=OFF is provided, it will make STATIC.

Kindly confirm. 
-Deepak 

> - Arnaldo
>  
>> Signed-off-by: Deepak Kumar Mishra <deepakkumar.mishra@arm.com>
>> ---
>>  README | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/README b/README
>> index 576cd42..40ca984 100644
>> --- a/README
>> +++ b/README
>> @@ -6,8 +6,17 @@ Build instructions:
>>  4. cmake -D__LIB=lib ..
>>  5. make install
>>  
>> -Default is to install to /usr/local, use -DCMAKE_INSTALL_PREFIX=
>> -when invoking cmake to specify another install location.
>> +cmake Options:
>> +  -DBUILD_SHARED_LIBS
>> +    By default STATIC libraries are created and applications are linked to it.
>> +    use -DBUILD_SHARED_LIBS=ON while invoking cmake to create SHARED libraries
>> +    and link applications to it.
>> +
>> +    Ex. cmake -D__LIB=lib -DBUILD_SHARED_LIBS=ON ..
>> +
>> +  -DCMAKE_INSTALL_PREFIX
>> +    Default is to install to /usr/local, use -DCMAKE_INSTALL_PREFIX=
>> +    when invoking cmake to specify another install location.
>>  
>>  Known to work scenarios:
>>  
>> -- 
>> 2.17.1
>>
> 
