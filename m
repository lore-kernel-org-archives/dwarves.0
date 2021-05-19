Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E849C433B4
	for <linux-dwarves@archiver.kernel.org>; Wed, 19 May 2021 21:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B319600CD
	for <linux-dwarves@archiver.kernel.org>; Wed, 19 May 2021 21:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhESVjK (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 19 May 2021 17:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhESVjK (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 19 May 2021 17:39:10 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D99C061574
        for <dwarves@vger.kernel.org>; Wed, 19 May 2021 14:37:49 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id o59so7628991qva.1
        for <dwarves@vger.kernel.org>; Wed, 19 May 2021 14:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=ECC59+OwV4NExtKLfok3DW5DINXnc3oxWwmG+JpoWDM=;
        b=RIjyHfzhZxYtgJjV7q5/YzeIUayBlxFJ+xeU+e/+ImEj46QHecXttaYEG3P9x5NzH3
         QOJvlzQexxTfhAmr6lRfCKMV9GH0KBi9PsXHw9uFHIY5j4g+Fg7HTt2tJeL8+zSdPjjN
         by/7sLa2HjaMCNRbaiE8YgXel9WPbkeustMfcQoliCgJUzfDLTMgy9DK550D/RLQQicl
         OnnL5/kyq8qPIZ367TtDqNTezZGY3SJvrCwFPkEdvQD0gu99EBUkL6e7SiqrG4eX7FBP
         5GLVy95S1K/JT8WUNoOi1l1lmc366Agglln5mSzDhuuRBLLMfkeSeWR+yxG0VkGL82zL
         n6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=ECC59+OwV4NExtKLfok3DW5DINXnc3oxWwmG+JpoWDM=;
        b=b+cCwww7xy4h3/nBGRpw09r0D2uz7dZVT8c3/FZrYlblKU6H6sGajINPPc3U5qyyIP
         Mzt4u9hfibVNmEVyZ1FTuguyVqI3aMPzM3mhQR+gqf4EH+W9XwnT2X855VGHhD7bDT6H
         kPAEF42pTrH1NXn6v6cnizFi8GgTshXORW8ojIXt+Jzff9TDMI5ahC4ymfPEyiR+EaQb
         O/S10sNjo+F4x4lviTWCb5zlHLB0gTFNXgcNcEAu1m9ciNi+ICk12IXkMHyvk/NClhU3
         Pp2ZeqVjYqmg8ehj+zsfByIifLv/C/J1a57llVlg9LwfrRS6M0vGGQw+ET+nBdsjA6Jk
         lrpw==
X-Gm-Message-State: AOAM533nMmt//Q7Z+PIcWrk08nZWR0+a9zoIAxV51KipS4znZPKcuAxI
        GvE7hVWnqbzC9T7vNdFVa3I=
X-Google-Smtp-Source: ABdhPJwJ7DneifBwHxx3vqw/3SjvEQvbeFbcWNWke/p6frvD03OOn1LJRxjIMFGdtMgm+M4eCH5GxA==
X-Received: by 2002:a0c:9ad4:: with SMTP id k20mr1950880qvf.57.1621460269106;
        Wed, 19 May 2021 14:37:49 -0700 (PDT)
Received: from [192.168.86.185] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id b17sm429676qtb.78.2021.05.19.14.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 14:37:48 -0700 (PDT)
Date:   Wed, 19 May 2021 18:36:50 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <YKWAlm5KO4S9HBmn@krava>
References: <a249699a-7c6c-4d4a-71b0-87981c8d229e@linux.alibaba.com> <YKKA64WWqYN3P7YJ@kernel.org> <c3520803-77af-cc34-000a-de4ba6334bcb@linux.alibaba.com> <YKO34fq6P8G9IyMD@kernel.org> <CAEf4Bzazh4RNCY3rGRRXfO2wJ7DSiMx8w+61B_hjhu9FrOffpQ@mail.gmail.com> <ec80d351-ac2f-5c48-c339-c2c503d36d68@linux.alibaba.com> <YKVv57HsgJYmCTFi@krava> <5D76A4F3-6F5A-4061-A274-34FFE5CBA338@gmail.com> <YKWAlm5KO4S9HBmn@krava>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pahole: Add --kabi_prefix flag
To:     Jiri Olsa <jolsa@redhat.com>
CC:     Shuyi Cheng <chengshuyi@linux.alibaba.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        dwarves@vger.kernel.org, wenan.mao@linux.alibaba.com,
        Jiri Olsa <jolsa@kernel.org>
From:   Arnaldo <arnaldo.melo@gmail.com>
Message-ID: <658F1703-ACA6-4BE5-913E-ADC0C403B568@gmail.com>
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org



On May 19, 2021 6:18:14 PM GMT-03:00, Jiri Olsa <jolsa@redhat=2Ecom> wrote=
:
>On Wed, May 19, 2021 at 05:23:31PM -0300, Arnaldo wrote:
>>=20
>>=20
>> On May 19, 2021 5:07:03 PM GMT-03:00, Jiri Olsa <jolsa@redhat=2Ecom>
>wrote:
>> >On Wed, May 19, 2021 at 10:44:44AM +0800, Shuyi Cheng wrote:
>> >> To solve problems similar to _RH_KABI_REPLACE=2E The
>> >_RH_KABI_REPLACE(_orig,
>> >> _new) macros perserve size alignment and kabi agreement between
>_orig
>> >and
>> >> _new=2EBelow is the definition of this macro:
>> >>=20
>> >> # define _RH_KABI_REPLACE(_orig, _new)            \
>> >>     union {                        \
>> >>         _new;                    \
>> >>         struct {                \
>> >>             _orig;                \
>> >>         } __UNIQUE_ID(rh_kabi_hide);        \
>> >>         __RH_KABI_CHECK_SIZE_ALIGN(_orig, _new);    \
>> >>     }
>> >
>> >hi,
>> >that macro sounds familiar ;-) I think this should be already
>> >solved directly in the header file by this one:
>> >
>>
>>https://gitlab=2Ecom/cki-project/kernel-ark/-/commit/331be9c5a436057ee85=
2075c102d9d90a9046a30
>> >
>>=20
>> But this means newer kernels will not have that issue, so perhaps we
>should just document this?
>
>I don't think there's released kernel with this issue
>
>>=20
>> Or would it be worth the effort of having a --ignore_prefix option
>for the people using all the kernels where this is applicable to and
>leave the option lingering there just in case?
>
>this is specific to rh kernels and fixed by that patch above,
>I wouldn't expect seeing it again

Cool, case closed then :-)=20
>
>jirka

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
