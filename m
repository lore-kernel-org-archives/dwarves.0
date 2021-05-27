Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848C2C4707F
	for <linux-dwarves@archiver.kernel.org>; Thu, 27 May 2021 16:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6430A61184
	for <linux-dwarves@archiver.kernel.org>; Thu, 27 May 2021 16:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbhE0QpW (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 27 May 2021 12:45:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233040AbhE0QpV (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Thu, 27 May 2021 12:45:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D8A7611C2;
        Thu, 27 May 2021 16:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622133828;
        bh=3CqvgNMMMHIx5BECCCKbosZ9ACUC2ExDdwwZuJ3VVNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BmJSiaY4ILfsh0Kvc/gOkMIfXUWnOvKz5IyYjKy2oun6Xil7lKaDrOys0ZR2NJplw
         cICqpOd9t4zrPyM+9FllAIp3Mfj7oMv9S2e4W5S+ytTo5KDMPLqmauLY+70nBwQVGY
         sFp91L50gv0SyVDZMN4xfvvwDClAATHVeARQYEjEQoYq3yGf31BKNaRAP7KyQGDz41
         BLmPZeKv5bOCfWgLJ8oBrtQmcVamvIe5W9DFpe//GBQBYPeLnCwsEYAzsSFLWavyOc
         8QxzWdEKymB1q2eq7YE5eXirAgQMZe3R4QE/4Z5chMdPPmy5KQJaqtQeEeZpTNbU4H
         03ZzA9iKsw5Yg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1CCE94011C; Thu, 27 May 2021 13:43:45 -0300 (-03)
Date:   Thu, 27 May 2021 13:43:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Shuyi Cheng <chengshuyi@linux.alibaba.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, wenan.mao@linux.alibaba.com,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v3] pahole: Add --kabi_prefix flag
Message-ID: <YK/MQcjahEhsWX1S@kernel.org>
References: <a249699a-7c6c-4d4a-71b0-87981c8d229e@linux.alibaba.com>
 <YKKA64WWqYN3P7YJ@kernel.org>
 <c3520803-77af-cc34-000a-de4ba6334bcb@linux.alibaba.com>
 <YKO34fq6P8G9IyMD@kernel.org>
 <CAEf4Bzazh4RNCY3rGRRXfO2wJ7DSiMx8w+61B_hjhu9FrOffpQ@mail.gmail.com>
 <ec80d351-ac2f-5c48-c339-c2c503d36d68@linux.alibaba.com>
 <YKZ/ZFRAQenJs0hB@krava>
 <482e5543-d7da-7bed-098d-cc879d8db253@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <482e5543-d7da-7bed-098d-cc879d8db253@linux.alibaba.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Fri, May 21, 2021 at 09:44:20AM +0800, Shuyi Cheng escreveu:
> To solve problems similar to _RH_KABI_REPLACE. The _RH_KABI_REPLACE(_orig,
> _new) macros perserve size alignment and kabi agreement between _orig and
> _new.Below is the definition of this macro:
> 
> # define _RH_KABI_REPLACE(_orig, _new)            \
>     union {                        \
>         _new;                    \
>         struct {                \
>             _orig;                \
>         } __UNIQUE_ID(rh_kabi_hide);        \
>         __RH_KABI_CHECK_SIZE_ALIGN(_orig, _new);    \
>     }

Thanks, applied.

- Arnaldo

