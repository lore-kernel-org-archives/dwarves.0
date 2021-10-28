Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F2CC433F5
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 14:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59AC660238
	for <linux-dwarves@archiver.kernel.org>; Thu, 28 Oct 2021 14:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhJ1OP2 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 28 Oct 2021 10:15:28 -0400
Received: from foss.arm.com ([217.140.110.172]:55632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231213AbhJ1OP2 (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 28 Oct 2021 10:15:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A8DA1FB;
        Thu, 28 Oct 2021 07:13:01 -0700 (PDT)
Received: from [10.57.46.169] (unknown [10.57.46.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 951AD3F70D;
        Thu, 28 Oct 2021 07:12:58 -0700 (PDT)
Subject: Re: [PATCH v3 6/6] btf_loader.c: Use cacheline size to infer
 alignment
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
References: <20211028122710.881181-1-douglas.raillard@arm.com>
 <20211028122710.881181-7-douglas.raillard@arm.com>
 <YXqknmflB1WS8rnE@kernel.org>
From:   Douglas Raillard <douglas.raillard@arm.com>
Message-ID: <0aaf2336-a7e6-992b-4f9e-ffdfd09254ef@arm.com>
Date:   Thu, 28 Oct 2021 15:12:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXqknmflB1WS8rnE@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On 10/28/21 2:24 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Oct 28, 2021 at 01:27:10PM +0100, Douglas RAILLARD escreveu:
>> From: Douglas Raillard <douglas.raillard@arm.com>
>>
>> When the alignment is larger than natural, it is very likely that the
>> source code was using the cacheline size. Therefore, use the cacheline
>> size when it would only result in increasing the alignment.
> 
> --- /tmp/btfdiff.dwarf.pXdgRU   2021-10-28 10:22:11.738200232 -0300
> +++ /tmp/btfdiff.btf.bkDkdf     2021-10-28 10:22:11.925205061 -0300
> @@ -107,7 +107,7 @@ struct Qdisc {
>          /* XXX 24 bytes hole, try to pack */
> 
>          /* --- cacheline 2 boundary (128 bytes) --- */
> -       struct sk_buff_head        gso_skb __attribute__((__aligned__(64))); /*   128    24 */
> +       struct sk_buff_head        gso_skb __attribute__((__aligned__(32))); /*   128    24 */
>          struct qdisc_skb_head      q;                    /*   152    24 */
>          struct gnet_stats_basic_packed bstats;           /*   176    16 */
>          /* --- cacheline 3 boundary (192 bytes) --- */
> 
> This one is gone with heuristic, thanks for accepting my suggestion and
> coding it this fast!

Thanks for the quick review !
 From my manual checks, I could basically not find any __aligned__(32) anymore
after this patch as expected. The main difference with dwarf left are missing
__aligned__ when the member was already aligned, but it should be harmless and
there is nothing we can do about that unless BTF is augmented.

> 
> Applied.
> 
> I'm pushing it out to the 'next' branch, please work from there, I'll
> move it to 'master' when it passes libbpf's CI tests.

noted, I rebased on "next", sorry for the repeated patches.

- Douglas

> 
> - Arnaldo
>   
>> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
>> ---
>>   btf_loader.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/btf_loader.c b/btf_loader.c
>> index e500eae..7a5b16f 100644
>> --- a/btf_loader.c
>> +++ b/btf_loader.c
>> @@ -476,6 +476,7 @@ static uint32_t class__infer_alignment(const struct conf_load *conf,
>>   				       uint32_t natural_alignment,
>>   				       uint32_t smallest_offset)
>>   {
>> +	uint16_t cacheline_size = conf->conf_fprintf->cacheline_size;
>>   	uint32_t alignment = 0;
>>   	uint32_t offset_delta = byte_offset - smallest_offset;
>>   
>> @@ -494,6 +495,15 @@ static uint32_t class__infer_alignment(const struct conf_load *conf,
>>   	/* Natural alignment, nothing to do */
>>   	if (alignment <= natural_alignment || alignment == 1)
>>   		alignment = 0;
>> +	/* If the offset is compatible with being aligned on the cacheline size
>> +	 * and this would only result in increasing the alignment, use the
>> +	 * cacheline size as it is safe and quite likely to be what was in the
>> +	 * source.
>> +	 */
>> +	else if (alignment < cacheline_size &&
>> +		 cacheline_size % alignment == 0 &&
>> +		 byte_offset % cacheline_size == 0)
>> +		alignment = cacheline_size;
>>   
>>   	return alignment;
>>   }
>> -- 
>> 2.25.1
> 

