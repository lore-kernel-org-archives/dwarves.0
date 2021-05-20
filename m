Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1732C433B4
	for <linux-dwarves@archiver.kernel.org>; Thu, 20 May 2021 12:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 928FD61355
	for <linux-dwarves@archiver.kernel.org>; Thu, 20 May 2021 12:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbhETMbn (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 20 May 2021 08:31:43 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:44610 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233460AbhETMbZ (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 20 May 2021 08:31:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=chengshuyi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UZW.oQZ_1621513802;
Received: from B-39YZML7H-2200.local(mailfrom:chengshuyi@linux.alibaba.com fp:SMTPD_---0UZW.oQZ_1621513802)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 20 May 2021 20:30:02 +0800
Subject: Re: [PATCH v2] pahole: Add --kabi_prefix flag
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, wenan.mao@linux.alibaba.com,
        Jiri Olsa <jolsa@kernel.org>
References: <a249699a-7c6c-4d4a-71b0-87981c8d229e@linux.alibaba.com>
 <YKKA64WWqYN3P7YJ@kernel.org>
 <c3520803-77af-cc34-000a-de4ba6334bcb@linux.alibaba.com>
 <YKO34fq6P8G9IyMD@kernel.org>
 <CAEf4Bzazh4RNCY3rGRRXfO2wJ7DSiMx8w+61B_hjhu9FrOffpQ@mail.gmail.com>
 <ec80d351-ac2f-5c48-c339-c2c503d36d68@linux.alibaba.com>
 <YKVv57HsgJYmCTFi@krava>
 <30cc773d-779f-9440-2f79-1fd642287cc4@linux.alibaba.com>
 <YKZMwmFVcYTTvEDW@krava>
 <ebbd7ace-f3ab-d104-c36c-788f4c169bbd@linux.alibaba.com>
 <YKZTjViH1uJoMSyI@krava>
From:   Shuyi Cheng <chengshuyi@linux.alibaba.com>
Message-ID: <f0fd4da4-ba2f-2a8b-9201-5803ff14fc39@linux.alibaba.com>
Date:   Thu, 20 May 2021 20:30:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKZTjViH1uJoMSyI@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org



On 5/20/21 8:18 PM, Jiri Olsa wrote:
> On Thu, May 20, 2021 at 08:08:44PM +0800, Shuyi Cheng wrote:
>>
>>
>> On 5/20/21 7:49 PM, Jiri Olsa wrote:
>>> On Thu, May 20, 2021 at 06:27:48PM +0800, Shuyi Cheng wrote:
>>>>
>>>>
>>>> On 5/20/21 4:07 AM, Jiri Olsa wrote:
>>>>> On Wed, May 19, 2021 at 10:44:44AM +0800, Shuyi Cheng wrote:
>>>>>> To solve problems similar to _RH_KABI_REPLACE. The _RH_KABI_REPLACE(_orig,
>>>>>> _new) macros perserve size alignment and kabi agreement between _orig and
>>>>>> _new.Below is the definition of this macro:
>>>>>>
>>>>>> # define _RH_KABI_REPLACE(_orig, _new)            \
>>>>>>        union {                        \
>>>>>>            _new;                    \
>>>>>>            struct {                \
>>>>>>                _orig;                \
>>>>>>            } __UNIQUE_ID(rh_kabi_hide);        \
>>>>>>            __RH_KABI_CHECK_SIZE_ALIGN(_orig, _new);    \
>>>>>>        }
>>>>>
>>>>> hi,
>>>>> that macro sounds familiar ;-) I think this should be already
>>>>> solved directly in the header file by this one:
>>>>>
>>>>>      https://gitlab.com/cki-project/kernel-ark/-/commit/331be9c5a436057ee852075c102d9d90a9046a30
>>>>>
>>>>> jirka
>>>>>
>>>>
>>>> Well, this patch solves this problem very well from the kernel level. But
>>>> there are many mirrors [here](http://debuginfo.centos.org/7/x86_64/) that
>>>> still have this problem. And these mirrors support ebpf, so it is very
>>>> important to effectively extract the btf segment from these mirrors. :-)
>>>
>>> hum, the link shows 3.10.* centos kernel, right?
>>> AFAIK there's no BTF support in those kernels..
>>>
>>> but maybe I'm missing some backporting channel,
>>> could you please point me to related sources?
>>>
>>> jirka
>>>
>>
>> Yes, it is the centos kernel of version 3.10. This version of the centos
>> kernel supports ebpf. As far as I think, BTF features don't depend on the
>> kernel much. Only when using the STRUCT OPS feature does the kernel support
>> BTF, see [here](https://github.com/libbpf/libbpf/blob/57375504c6c9766d23f178c40f71bf5e8df9363d/src/libbpf.c#L2549)
>> and [here](https://www.spinics.net/lists/netdev/msg637060.html). Therefore,
>> in the 3.10 version of the Centos kernel, with the help of the vmlinux btf
>> segment, libbpf CO-RE can be easily supported.
> 
> ok, so you're generating BTF for centos 3.10 kernel?
> 
> I think that fix would be easy kernel backport, but I guess
> we can go with pahole option just as well, if backport is
> not an option for you
> 
> jirka
> 

Yes, I am generating btf segment for centos 3.10 kernel. There are two 
main reasons for adding this patch:
1. There are too many kernel versions in centos 3.10, and a certain 
technical foundation is required to compile the kernel.
2. In my opinion, many people are using pahole to generate vmlinux btf 
segment, and there are still a large number of users on centos.


