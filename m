Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4A7C433B4
	for <linux-dwarves@archiver.kernel.org>; Tue, 18 May 2021 09:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 923F561108
	for <linux-dwarves@archiver.kernel.org>; Tue, 18 May 2021 09:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347477AbhERJDr (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 18 May 2021 05:03:47 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:38877 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242344AbhERJDq (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 18 May 2021 05:03:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=chengshuyi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UZIdFKW_1621328546;
Received: from B-39YZML7H-2200.local(mailfrom:chengshuyi@linux.alibaba.com fp:SMTPD_---0UZIdFKW_1621328546)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 May 2021 17:02:27 +0800
From:   chengshuyi <chengshuyi@linux.alibaba.com>
Subject: Re: [PATCH] btf: Add --btf_prefix flag
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, wenan.mao@linux.alibaba.com,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
References: <a249699a-7c6c-4d4a-71b0-87981c8d229e@linux.alibaba.com>
 <YKKA64WWqYN3P7YJ@kernel.org>
Message-ID: <c3520803-77af-cc34-000a-de4ba6334bcb@linux.alibaba.com>
Date:   Tue, 18 May 2021 17:02:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKKA64WWqYN3P7YJ@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org


On 2021/5/17 10:42PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, May 17, 2021 at 08:06:30PM +0800, 程书意 escreveu:
>> To solve problems similar to _RH_KABI_REPLACE, _RH_KABI_REPLACE makes many
> Can you explain what is _RH_KABI_REPLACE, why it is needed so that
> people unfamiliar with it can make sense of your patch?

The _RH_KABI_REPLACE(_orig, _new) macros perserve size alignment and 
kabi agreement between _orig and _new.Below is the definition of this macro:

# define _RH_KABI_REPLACE(_orig, _new)         \
      union {                        \
          _new;                    \
          struct {                \
              _orig;                \
          } __UNIQUE_ID(rh_kabi_hide);        \
          __RH_KABI_CHECK_SIZE_ALIGN(_orig, _new);    \
      }


__UNIQUE_ID uses the __COUNTER__ macro, and the __COUNTER__ macro is 
automatically incremented by 1 every time it is precompiled. Therefore, 
in different compilation units, the same structure has different 
names.Here is a concrete example:

struct acpi_dev_node {
      union {
          struct acpi_device *companion;
          struct {
              void *handle;
          } __UNIQUE_ID_rh_kabi_hide29;
          union {        };
      };
};
struct acpi_dev_node {
      union {
          struct acpi_device *companion;
          struct {
              void *handle;
          } __UNIQUE_ID_rh_kabi_hide31;
          union {        };
      };
};

Finally, it will cause the btf algorithm to de-duplication efficiency is 
not high, and time-consuming.

>
> Also why "btf_prefix" when this is related to this other feature? Can
> you find a better name?

"btf_prefix" means that if two strings have the same prefix, treat them 
as the same string.From the above example,if btf_prefix is 
__UNIQUE_ID_rh_kabi_hide, then __UNIQUE_ID_rh_kabi_hide29 and 
__UNIQUE_ID_rh_kabi_hide31 are equal.Maybe "btf_kabi_prefix_string" is 
better

> You also forgot to update the man page at man-pages/pahole.1.
>
> - Arnaldo

Yes i forgot.

>> structures have different names, resulting in a
>> particularly large vmlinux btf. For example, running ./pahole -J
>> vmlinux-3.10.0-1160.el7.x86_64 without --btf_prefix flag,
>> the running time is:
>>                  real 8m28.912s
>>                  user 8m27.271s
>>                  sys 0m1.471s
>> And the size of the generated btf segment is 30678240 bytes.
>>
>> After adding the patch, running ./pahole
>> --btf_prefix=__UNIQUE_ID_rh_kabi_hide -J vmlinux-3.10.0-1160.el7.x86_64. The
>> running
>> time of the command is:
>>                  real 0m19.634s
>>                  user 0m18.457s
>>                  sys 0m1.169s
>> The size of the generated btf segment is 3117719 bytes.
>>
>> Thanks.
>>
>> Signed-off-by: chengshuyi<chengshuyi@linux.alibaba.com>
>> ---
>>   pahole.c         | 10 ++++++++++
>>   pahole_strings.h |  2 ++
>>   strings.c        |  9 +++++++--
>>   3 files changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/pahole.c b/pahole.c
>> index dc40ccf..0b4f4ca 100644
>> --- a/pahole.c
>> +++ b/pahole.c
>> @@ -24,6 +24,7 @@
>>   #include "btf_encoder.h"
>>   #include "libbtf.h"
>>   #include "lib/bpf/src/libbpf.h"
>> +#include "pahole_strings.h"
>>
>>   static bool btf_encode;
>>   static bool ctf_encode;
>> @@ -855,6 +856,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
>>   #define ARGP_btf_gen_floats       322
>>   #define ARGP_btf_gen_all       323
>>   #define ARGP_with_flexible_array   324
>> +#define ARGP_btf_prefix   325
>>
>>   static const struct argp_option pahole__options[] = {
>>       {
>> @@ -1140,6 +1142,12 @@ static const struct argp_option pahole__options[] = {
>>           .doc  = "Path to the base BTF file",
>>       },
>>       {
>> +        .name = "btf_prefix",
>> +        .key = ARGP_btf_prefix,
>> +        .arg = "STRING",
>> +        .doc = "Strings with the same prefix are considered the same.",
>> +    },
>> +    {
>>           .name = "btf_encode",
>>           .key  = 'J',
>>           .doc  = "Encode as BTF", @@ -1297,6 +1305,8 @@ static error_t pahole__options_parser(int 
>> key, char *arg,          btf_encode_force = true;        break;      
>> case ARGP_btf_base:          base_btf_file = arg;            break; 
>> +    case ARGP_btf_prefix: +        btf_prefix = arg;        break; 
>>      case ARGP_numeric_version:          print_numeric_version = 
>> true;        break;      case ARGP_btf_gen_floats: diff --git 
>> a/pahole_strings.h b/pahole_strings.h index 522fbf2..bf3dc7c 100644 
>> --- a/pahole_strings.h +++ b/pahole_strings.h @@ -14,6 +14,8 @@ 
>> struct strings {      struct btf *btf;  }; +extern const char 
>> *btf_prefix; +  struct strings *strings__new(void);  void 
>> strings__delete(struct strings *strings); diff --git a/strings.c 
>> b/strings.c index d37f49d..911ce25 100644 --- a/strings.c +++ 
>> b/strings.c @@ -16,6 +16,9 @@  #include "dutil.h"
>>   #include "lib/bpf/src/libbpf.h"
>> +#include "libbtf.h"
> Why do you need to add this new include? I guess you meant including
> pahole_strings.h to get the forward declaration for 'btf_prefix'?

It is of no use, I forgot to delete it.

>> +
>> +const char *btf_prefix;
>>
>>   struct strings *strings__new(void)
>>   {
>> @@ -47,8 +50,10 @@ strings_t strings__add(struct strings *strs, const char
>> *str)
>>
>>       if (str == NULL)
>>           return 0;
>> -
>> -    index = btf__add_str(strs->btf, str);
>> +    if(btf_prefix && strncmp(str,btf_prefix,strlen(btf_prefix))==0)
> Please also follow the existing coding style, i.e. use a space after
> 'if' and also after the commas.
>
> - Arnaldo
>

Okay, I know. If you want to receive this patch, I will send a complete 
patch later.

>> +        index = btf__add_str(strs->btf, btf_prefix);
>> +    else
>> +        index = btf__add_str(strs->btf, str);
>>       if (index < 0)
>>           return 0;
>>
>> -- 
>> 1.8.3.1
>>
>>
