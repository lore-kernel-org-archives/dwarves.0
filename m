Return-Path: <SRS0=Qilz=D4=vger.kernel.org=dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16214C56201
	for <linux-dwarves@archiver.kernel.org>; Wed, 21 Oct 2020 05:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92CB720770
	for <linux-dwarves@archiver.kernel.org>; Wed, 21 Oct 2020 05:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603259544;
	bh=FQuYS5uKq+i9aKct0MNZwBQsnDQ6/7v175jGjlBHi4U=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=knFsSAXsMahNfyMcONRpH6Bs9LwiyNhFdskKCFWpZmSxR3MJi1G9b2AXYUivkLyT1
	 06WnR/VnNEIdSbvcxjv2v/qp6+TiXbM61NptrGsJEH2Xtc5PRFqgpsXP1J1aNJAwb7
	 q5XgIbmaR0AvY0E1xkswxSews62WiWcENfE9KZXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393731AbgJUFwY (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 21 Oct 2020 01:52:24 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:38249 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393570AbgJUFwX (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 21 Oct 2020 01:52:23 -0400
Received: by mail-ej1-f66.google.com with SMTP id ce10so1322479ejc.5;
        Tue, 20 Oct 2020 22:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ql0foaRbL3lg/b/jhl8Q1apB2P43TnsO4Qk8XcA0+CQ=;
        b=okv9a+fzDSFgfKjoaQoLTHlSzKOnH99MRsX8+5Eh7ygBjkZImRLfwU7qtV8UkCj3dd
         fZYOYW8kI9VAdN3rXcCt+jy6dk90zxqzm2isy4GzjrN8ApuBBf3elhz/z5ywrT+z72PH
         r0LYc3JHtBlwvWWWd/PM0CCHR7YWwpXhtARIyJPFzRV64DU6hVAY29PIa9MJurqIC3Rz
         CI0HIVWlstUDFrxr9mR5jx/8ppPB7smB9Xnh8jMGY2dyxJh+W2tZBZpj4b56ZTpIpwHA
         tIsxL+yRvmjkUezwtg6edz52q1u0MtzYdtVGjA4KeKMbo747Lw2JYJL6/Wag9ffjRw0o
         d+Hg==
X-Gm-Message-State: AOAM533L6FLH0qpUk4ESLEHbybG7vMQsPgjk5AjvKQm148eV73aH+0k8
        RpEenhyfLOPGCZfc6iy6Rys=
X-Google-Smtp-Source: ABdhPJwqxJd22hZw5ifdcuRjQCbw+SS2XKSqRwmRnYpwYb3cFVhSVe+qZqAamH5/lDJCjnJyeYvgFg==
X-Received: by 2002:a17:906:234d:: with SMTP id m13mr1820133eja.497.1603259541936;
        Tue, 20 Oct 2020 22:52:21 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id l12sm1023074edj.75.2020.10.20.22.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 22:52:20 -0700 (PDT)
Subject: Re: Segfault in pahole 1.18 when building kernel 5.9.1 for arm64
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     =?UTF-8?Q?=c3=89rico_Rolim?= <erico.erc@gmail.com>,
        dwarves@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Hao Luo <haoluo@google.com>
References: <CAFDeuWM7D-Upi84-JovKa3g8Y_4fjv65jND3--e9u-tER3WmVA@mail.gmail.com>
 <82b757bb-1f49-ab02-2f4b-89577d56fec9@kernel.org>
 <CAEf4BzZBpnFx+03xE-a9wA1zHbH+HfEQPDWN5cdZ6y1wa9y7tA@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <c529897e-d33f-09b9-3142-bcc5db76d10f@kernel.org>
Date:   Wed, 21 Oct 2020 07:52:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZBpnFx+03xE-a9wA1zHbH+HfEQPDWN5cdZ6y1wa9y7tA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On 20. 10. 20, 19:15, Andrii Nakryiko wrote:
> On Tue, Oct 20, 2020 at 3:51 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>>
>> Hi,
>>
>> On 19. 10. 20, 1:18, Érico Rolim wrote:
>>> I'm trying to build kernel 5.9.1 for arm64, and my dotconfig has
>>> `CONFIG_DEBUG_INFO_BTF=y`, which requires pahole for building. However, pahole
>>> version 1.18 segfaults during the build, as can be seen below:
>>>
>>> PAHOLE: Error: Found symbol of zero size when encoding btf (sym:
>>> '__kvm_nvhe_arm64_ssbd_callback_required', cu:
>>> 'arch/arm64/kernel/cpu_errata.c').
>>
>> The symbol is an alias coming from arch/arm64/kernel/vmlinux.lds:
>> __kvm_nvhe_arm64_ssbd_callback_required = arm64_ssbd_callback_required;;
> 
> What's readelf's output for that symbol? If it's legal for SST_OBJECT
> to have size zero, then we should just skip those in pahole. But it
> shouldn't crash in either case, of course. But as Arnaldo mentioned,
> that code changed significantly recently, so please check with latest
> pahole from tmp.libbtf_encoder branch.
...
>> Yeah, I observe the very same. I reported it at:
>> https://bugzilla.suse.com/show_bug.cgi?id=1177921

If you looked here, you would see:
 > $ readelf -Ws vml |grep arm64_ssbd_callback_re
 > 154271: ffff80001133e000     0 OBJECT  GLOBAL DEFAULT   22 
__kvm_nvhe_arm64_ssbd_callback_required
 > 159609: ffff80001133e000     8 OBJECT  WEAK   DEFAULT   22 
arm64_ssbd_callback_required

Yes, its zero-sized. And yes, the error happens even with 
tmp.libbtf_encoder, but pahole doesn't crash and the build finishes fine.

thanks,
-- 
js
