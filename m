Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B1AC433FE
	for <linux-dwarves@archiver.kernel.org>; Tue, 14 Dec 2021 17:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbhLNRuH (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 14 Dec 2021 12:50:07 -0500
Received: from foss.arm.com ([217.140.110.172]:33806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229812AbhLNRuG (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Tue, 14 Dec 2021 12:50:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66159D6E;
        Tue, 14 Dec 2021 09:50:06 -0800 (PST)
Received: from [10.57.66.99] (unknown [10.57.66.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BC833F5A1;
        Tue, 14 Dec 2021 09:50:05 -0800 (PST)
Subject: Re: [PATCH v2 4/6] pahole.c: Add prefix to expanded type names
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     acme@redhat.com, dwarves@vger.kernel.org
References: <20211207173151.2283946-1-douglas.raillard@arm.com>
 <20211207173151.2283946-5-douglas.raillard@arm.com>
 <YbiwfOPqiuZE7SUX@kernel.org>
From:   Douglas Raillard <douglas.raillard@arm.com>
Message-ID: <a5b3b85e-1332-c244-08fb-8e51e9ab0fb4@arm.com>
Date:   Tue, 14 Dec 2021 17:50:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbiwfOPqiuZE7SUX@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On 12/14/21 2:55 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Dec 07, 2021 at 05:31:49PM +0000, Douglas RAILLARD escreveu:
>> From: Douglas Raillard <douglas.raillard@arm.com>
>>
>> Add the prefix specified by --expanded_prefix to type names that have
>> not been specificaly requested using -C. This allows manual namespacing
>> so that these inner types will not conflict with existing headers.
>>
>> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
>> ---
>>   dwarves.h |  1 +
>>   pahole.c  | 29 +++++++++++++++++++++++++++--
>>   2 files changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/dwarves.h b/dwarves.h
>> index fc5b3fa..0967e5c 100644
>> --- a/dwarves.h
>> +++ b/dwarves.h
>> @@ -90,6 +90,7 @@ struct conf_load {
>>    */
>>   struct conf_fprintf {
>>   	const char *prefix;
>> +	const char *name_prefix;
>>   	const char *suffix;
>>   	int32_t	   type_spacing;
>>   	int32_t	   name_spacing;
>> diff --git a/pahole.c b/pahole.c
>> index 42ba110..e0a1438 100644
>> --- a/pahole.c
>> +++ b/pahole.c
>> @@ -2882,6 +2882,33 @@ out_btf:
>>   
>>   	bool include_decls = find_pointers_in_structs != 0 || stats_formatter == nr_methods_formatter;
>>   	struct prototype *prototype, *n;
>> +	static type_id_t class_id;
>> +
>> +	uint32_t id;
>> +	struct tag *pos;
>> +	bool skip;
>> +	const char *prefix = conf_load->conf_fprintf->name_prefix;
>> +	const size_t prefix_len = prefix ? strlen(prefix) : 0;
>> +	cu__for_each_type(cu, id, pos) {
>> +		if (tag__is_type(pos)) {
>> +			const char *name = type__name(tag__type(pos));
>> +			if (name && prefix) {
>> +				skip = false;
>> +				list_for_each_entry_safe(prototype, n, &class_names, node) {
>> +					if (!strcmp(prototype->name, name)) {
>> +						skip = true;
>> +						break;
>> +					}
>> +				}
>> +				if (!skip) {
>> +					const size_t len = 1024 + prefix_len;
>> +					char *bf = malloc(len);
>> +					snprintf(bf, len, "%s%s", prefix, name);
>> +					tag__namespace(pos)->name = bf;
>> +				}
>> +			}
>> +		}
>> +	}
> 
> I don't like this change in place mode, but I understand it is easier to
> do it here instead of in all types fprintf routines, but perhaps its
> better that way, I'll check how big it would be.

I don't really like it either but the alternative is something like that:
https://github.com/douglas-raillard-arm/pahole/commit/a3d4e224b2a0cb8196db0f8536bd77f976e364ca

The worst is not the size of the patch, it's the inability to check that it's actually complete.
Any spot where the prefix should be applied and where it is not will result in a broken header.
This also stands for any future addition to dwarves_fprintf.c.

One way to make the substitution safer is to completely ban direct access to the name and force
to go through an accessor that would apply the prefix, but this leads to either memory management
issue or inefficiency (as we would need to return copies so the caller can free it).

> 
>>   
>>   	list_for_each_entry_safe(prototype, n, &class_names, node) {
>>   
>> @@ -2891,8 +2918,6 @@ out_btf:
>>   				prototype->type_enum_resolved = type__find_type_enum(tag__type(prototype->class), cu, prototype->type_enum) == 0;
>>   			continue;
>>   		}
>> -
>> -		static type_id_t class_id;
>>   		struct tag *class = cu__find_type_by_name(cu, prototype->name, include_decls, &class_id);
>>   
>>   		// couldn't find that class name in this CU, continue to the next one.
>> -- 
>> 2.25.1
> 

