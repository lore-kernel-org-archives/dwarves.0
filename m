Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B23C433E0
	for <linux-dwarves@archiver.kernel.org>; Thu, 14 Jan 2021 14:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE1AE23A7D
	for <linux-dwarves@archiver.kernel.org>; Thu, 14 Jan 2021 14:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbhANOfT (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 14 Jan 2021 09:35:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25214 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729177AbhANOfS (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 14 Jan 2021 09:35:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610634832;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kQp/RaTS0AdR7v8Ttr5hokxGlnulkwjcKv1mMDM7DrE=;
        b=eeKluqVMCdD+Yx7TlyQI91+Slv9yubKQBgOhdjYcFE3zraiJbaPnQMpY3y1dBkhzIV5+CW
        B30pzWNZ3ntOfMKtoorvEM66X3EyzKydGKHVRXk+/VOUr46tNeOB90qKQp9zwkCxylDgGt
        5SGCK5QP6sbShCV1m7HUH4VLner7utc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-R5IuI7OUNXaXuQG-v2eP-Q-1; Thu, 14 Jan 2021 09:33:48 -0500
X-MC-Unique: R5IuI7OUNXaXuQG-v2eP-Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F5798066E0;
        Thu, 14 Jan 2021 14:33:46 +0000 (UTC)
Received: from tstellar.remote.csb (ovpn-113-214.phx2.redhat.com [10.3.113.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99865614FD;
        Thu, 14 Jan 2021 14:33:45 +0000 (UTC)
Reply-To: tstellar@redhat.com
Subject: Re: [PATCH] btf_encoder: Add extra checks for symbol names
To:     sedat.dilek@gmail.com
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
References: <20210112184004.1302879-1-jolsa@kernel.org>
 <f3790a7d-73bc-d634-5994-d049c7a73eae@redhat.com>
 <CA+icZUV9rdRuswqDa9u=VFcqgHp1x+jmz565QCFi=yC0D7hhVQ@mail.gmail.com>
From:   Tom Stellard <tstellar@redhat.com>
Organization: Red Hat
Message-ID: <dae1ec1e-7d19-e4c6-891b-ab774486dbee@redhat.com>
Date:   Thu, 14 Jan 2021 06:33:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CA+icZUV9rdRuswqDa9u=VFcqgHp1x+jmz565QCFi=yC0D7hhVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On 1/13/21 11:50 PM, Sedat Dilek wrote:
> On Wed, Jan 13, 2021 at 1:28 AM Tom Stellard <tstellar@redhat.com> wrote:
>>
>> On 1/12/21 10:40 AM, Jiri Olsa wrote:
>>> When processing kernel image build by clang we can
>>> find some functions without the name, which causes
>>> pahole to segfault.
>>>
>>> Adding extra checks to make sure we always have
>>> function's name defined before using it.
>>>
>>
>> I backported this patch to pahole 1.19, and I can confirm it fixes the
>> segfault for me.
>>
> 
> Thanks for testing.
> 
> Can you give me Git commit-id of LLVM-12 you tried?
> 

I was building with LLVM 11.0.1

-Tom

> - Sedat -
> 
>> -Tom
>>
>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>> ---
>>>    btf_encoder.c | 8 ++++++--
>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/btf_encoder.c b/btf_encoder.c
>>> index 333973054b61..17f7a14f2ef0 100644
>>> --- a/btf_encoder.c
>>> +++ b/btf_encoder.c
>>> @@ -72,6 +72,8 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
>>>
>>>        if (elf_sym__type(sym) != STT_FUNC)
>>>                return 0;
>>> +     if (!elf_sym__name(sym, btfe->symtab))
>>> +             return 0;
>>>
>>>        if (functions_cnt == functions_alloc) {
>>>                functions_alloc = max(1000, functions_alloc * 3 / 2);
>>> @@ -730,9 +732,11 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>>>                if (!has_arg_names(cu, &fn->proto))
>>>                        continue;
>>>                if (functions_cnt) {
>>> -                     struct elf_function *func;
>>> +                     const char *name = function__name(fn, cu);
>>> +                     struct elf_function *func = NULL;
>>>
>>> -                     func = find_function(btfe, function__name(fn, cu));
>>> +                     if (name)
>>> +                             func = find_function(btfe, name);
>>>                        if (!func || func->generated)
>>>                                continue;
>>>                        func->generated = true;
>>>
>>
> 

