Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C620C433F5
	for <linux-dwarves@archiver.kernel.org>; Tue,  4 Oct 2022 18:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiJDSII (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 4 Oct 2022 14:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiJDSIE (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 4 Oct 2022 14:08:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9A153D3F
        for <dwarves@vger.kernel.org>; Tue,  4 Oct 2022 11:08:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C846B81B5E
        for <dwarves@vger.kernel.org>; Tue,  4 Oct 2022 18:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C55C433C1;
        Tue,  4 Oct 2022 18:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664906880;
        bh=/Q9uSy28JSebUq8KksQppeutHzZCYaW8fe5ulEAI+W8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cCkAqcyaqVfuDIGCtGK/KUmOgpiJEl9LZMveFMJIwE0K1W9F43hPNmwkGUNy/NW9Q
         HVHtmJtcaqq1XZtdJNeSTr8bSLjaSSpCzuv9oYHwATwXtY5NH/CM1eBAJB8+gEgiM8
         Ens2NgA9D2qxZJyDRzLWbfMMOb5vhlpntUcfOX7K3XgMW7XzXMT6X5eplgzpQALZDT
         wjzcYcBe4Vy0veaZYIZ40ec3Eg4bdoDXJRjYQzOqCf1VnIAyOwgb/EkJkAN/P9JzAN
         lFqbDm3lWb+v4si0mZly0fPuXzLPRg5BZRXLhoOKs0/mPyTs5V1Wie9SmyrE1apiQ4
         J4RWIl9FWDDDQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4DA684062C; Tue,  4 Oct 2022 15:07:57 -0300 (-03)
Date:   Tue, 4 Oct 2022 15:07:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Nick Clifton <nickc@redhat.com>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        dwarves@vger.kernel.org
Subject: Re: Encountered error while encoding BTF due to Unsupported
 DW_TAG_unspecified_type(0x3b)
Message-ID: <Yzx2fcq4s3umw8WY@kernel.org>
References: <878d0959-7f80-471e-69d5-5228822b4365@suse.cz>
 <YzwkazNc6wNCpQTN@kernel.org>
 <503357c8-39ad-8417-d55c-be6c04fbb27e@redhat.com>
 <81431BB6-D014-4623-BE8D-9BBB457EB687@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81431BB6-D014-4623-BE8D-9BBB457EB687@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Tue, Oct 04, 2022 at 10:25:31AM -0300, Arnaldo Carvalho de Melo escreveu:
> On October 4, 2022 9:33:05 AM GMT-03:00, Nick Clifton <nickc@redhat.com> wrote:
> >Hi Arnaldo,
> >
> >>>   <0><c>: Abbrev Number: 3 (DW_TAG_unspecified_type) <--- the problematic TAG
> >
> >>>   <1><29>: Abbrev Number: 2 (DW_TAG_subprogram)
> >>>      <2a>   DW_AT_name        : (indirect string, offset: 0x2e): entry_ibpb
> >>>      <2e>   DW_AT_type        : <0xc>
> >
> >If it helps the tag is used to tell consumers like GDB that the return
> >type of specific functions (eg entry_ibpb in the above example) is unknown.
 
> Sure helps, thanks!
 
> I noticed this is for assembly source code, I'll add it as a special
> "type" and probably for BTF mask it to void.

s/mask/map/g
 
- Arnaldo
