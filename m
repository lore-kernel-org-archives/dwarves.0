Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3714C433EF
	for <linux-dwarves@archiver.kernel.org>; Tue, 16 Nov 2021 14:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C3A061391
	for <linux-dwarves@archiver.kernel.org>; Tue, 16 Nov 2021 14:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237079AbhKPOMv (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 16 Nov 2021 09:12:51 -0500
Received: from foss.arm.com ([217.140.110.172]:45696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233147AbhKPOMs (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Tue, 16 Nov 2021 09:12:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 521716D;
        Tue, 16 Nov 2021 06:09:51 -0800 (PST)
Received: from [10.57.29.165] (unknown [10.57.29.165])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8D5E3F766;
        Tue, 16 Nov 2021 06:09:46 -0800 (PST)
Subject: Re: [PATCH v1 0/2] Anonymous inner struct
To:     acme@redhat.com
Cc:     dwarves@vger.kernel.org
References: <20211019100724.325570-1-douglas.raillard@arm.com>
From:   Douglas Raillard <douglas.raillard@arm.com>
Message-ID: <5bf579b2-aafc-2ce2-7c84-e06eb2b4d78c@arm.com>
Date:   Tue, 16 Nov 2021 14:09:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211019100724.325570-1-douglas.raillard@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Hi Arnaldo,

Any opinion on this series ?

Cheers,
Douglas

On 10/19/21 11:07 AM, Douglas RAILLARD wrote:
> From: Douglas Raillard <douglas.raillard@arm.com>
> 
> Add an --inner_anonymous pahole CLI option to make inner
> struct/enum/union anonymous. This allows turning this:
> 
>      struct foo { ... };
>      struct bar {
>          struct foo {
>           ....
>          } a;
>      };
>      
> into this:
> 
>      struct foo { ... };
>      struct bar {
>          struct /* foo */ {
>           ....
>          } a;
>      };
> 
> This avoids any conflict between the two definitions of struct foo. The
> case arises when dumping multiple types at once with -E, all depending
> on a same inner struct:
> 
>      struct bar {
>          struct foo {
>           ....
>          } a;
>      };
>      struct bar2 {
>          struct foo {
>           ....
>          } b;
>      };
> 
> 
> On top of that, struct foo could already be defined in a public header
> already imported in the compilation unit, leading to a redefinition
> error, while another nested struct is private and would still need -E
> for the type to be usable.
> 
> Douglas Raillard (2):
>    fprintf: Allow making struct/enum/union anonymous
>    pahole.c: Add --inner_anonymous option
> 
>   dwarves.h         |  4 +++-
>   dwarves_emit.c    |  2 +-
>   dwarves_fprintf.c | 52 ++++++++++++++++++++++++++++++-----------------
>   pahole.c          |  8 ++++++++
>   4 files changed, 45 insertions(+), 21 deletions(-)
> 

