Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DE7C4338F
	for <linux-dwarves@archiver.kernel.org>; Sun,  8 Aug 2021 11:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5746E61055
	for <linux-dwarves@archiver.kernel.org>; Sun,  8 Aug 2021 11:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhHHLhe (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Sun, 8 Aug 2021 07:37:34 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:57589 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229608AbhHHLhe (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Sun, 8 Aug 2021 07:37:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UiISsFc_1628422633;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UiISsFc_1628422633)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 08 Aug 2021 19:37:14 +0800
Subject: Re: [PATCH] pahole: correct libbpf git url
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     dwarves@vger.kernel.org
References: <1628244763-1113-1-git-send-email-joseph.qi@linux.alibaba.com>
 <YQ2Chd/j62NCY2NX@kernel.org>
 <CAEf4BzaNV7bkdDoO4HhcwRO+aY5M=9xxwsTWabUDjt-HzXRVMg@mail.gmail.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <ff4863e6-5b9b-d0c7-5e8c-368b640e2ebe@linux.alibaba.com>
Date:   Sun, 8 Aug 2021 19:37:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzaNV7bkdDoO4HhcwRO+aY5M=9xxwsTWabUDjt-HzXRVMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org



On 8/7/21 5:11 AM, Andrii Nakryiko wrote:
> On Fri, Aug 6, 2021 at 11:42 AM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
>>
>> Em Fri, Aug 06, 2021 at 06:12:43PM +0800, Joseph Qi escreveu:
>>> Otherwise it will encounter the following error:
>>> fatal: unable to access 'https://github.com/libbpf/libbpf/': Encountered end of file
>>> fatal: clone of 'https://github.com/libbpf/libbpf' into submodule path '/home/workspace/pahole/lib/bpf' failed
>>>
>>> Also update README to add step 'make'.
>>
>> You forgot to add Andrii, the author of the patch you're fixing, to the
>> CC list, please do it next time.
> 
> Heh, thanks! Don't worry, I'm subscribed to dwarves@vger, so I saw this anyways.
> 
>>
>> - Arnaldo
>>
>>> Fixes: 21507cd3e97b ("pahole: add libbpf as submodule under lib/bpf")
>>> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
>>> ---
>>>  .gitmodules | 2 +-
>>>  README      | 3 ++-
>>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/.gitmodules b/.gitmodules
>>> index 6be99dc..8be5eb6 100644
>>> --- a/.gitmodules
>>> +++ b/.gitmodules
>>> @@ -1,3 +1,3 @@
>>>  [submodule "lib/bpf"]
>>>       path = lib/bpf
>>> -     url = https://github.com/libbpf/libbpf
>>> +     url = https://github.com/libbpf/libbpf.git
> 
> This doesn't hurt, but as Arnaldo pointed out, it seems to work just
> fine as is. Not sure how you ran into this problem... And why did it
> append the final '/' (still don't know if that's the reason)?
> 

I just follow the README and have got the problem.
I'll try to figure it why I can't pass in my environment.

Thanks,
Joseph
