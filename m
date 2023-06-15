Return-Path: <dwarves-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A6CEB64DB
	for <linux-dwarves@archiver.kernel.org>; Thu, 15 Jun 2023 08:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244919AbjFOIjl (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 15 Jun 2023 04:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244971AbjFOIjY (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 15 Jun 2023 04:39:24 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930FB272E;
        Thu, 15 Jun 2023 01:39:22 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b203891b2cso23205821fa.3;
        Thu, 15 Jun 2023 01:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686818361; x=1689410361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UYPoBgKpff/N5vL2NYQromt5SJIv0kpE1F1g2CtiMe4=;
        b=K0mZGj+B9ju6bB+0Qnh6eiSvjANCsLZ0CLFLBr3swByr1+Tc0JtsD+9bHaqzQpR8oj
         h8fmUwy5bYXCo21mG2erVHK7RZ2v+iQ5YWF78S7MxPOUrQsjHhOeajT8I4xKy9nERPm4
         bfOAFczKEZNW9Ok3+Ph9wKztaxQfDmFccaIgn3GqbEf0tdcD4hzMEn4v65MwBQdlJEiB
         fSjAS1kE3KLquHrPude4U23PurDLZdnJRe82eWaCZgkRNXSLZzt6x09LiT1HVMgFTkPN
         r2jyD/p2Z+FkDc53LBig+w74l3VC9JXOvj+8Lgm7zlHNwvs7wJg7znHqveKgWfC1K5UO
         WTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686818361; x=1689410361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYPoBgKpff/N5vL2NYQromt5SJIv0kpE1F1g2CtiMe4=;
        b=iZ+ui+X4T3UgPTbH0j/TmWNgD4P+t4IcOfID8dVdL8kvZUO2I5O13Q252q8SeUgRMr
         mmbhi8IjO6LjrjNzlq4hF7kvn5nXv+1AIzO8/9T3IhBQuCNgju3uGGbwhX497okn0dsx
         EctQEfHB1P/UbJmrID9gu6Iz5jCRZbcighUFvoI8AmPiGIznx32E+GkG4vSijcPTnThK
         cflWGtHuBtvR06vxrb1KAZOp+iRDHUiU1IMyqJAPJ20kYaONcNBPgaHT0lt1peM4xbR7
         kxH8rdCQep+Vau5CGsCZctaKIYTQqgTAsSjHE5vi5MIADm7mxnhcyMTnwNAQvCMii+vt
         hMFA==
X-Gm-Message-State: AC+VfDwirdgGueQBBSj+6Fd1dTRB54nX+c3ljKN7BNgl5wVzawW6fYMu
        WOTWcev6rMVLciKXqcChNJODPII3DBV4Mw==
X-Google-Smtp-Source: ACHHUZ5ZN0KtTs6SA22L/Cs2r6tPgcsC5B3hsEh0GmIwaUcffQD+gUbnbGV5gcL3/ktPD6mQz/D9Yw==
X-Received: by 2002:a2e:9b8f:0:b0:2ad:c1ec:fa3 with SMTP id z15-20020a2e9b8f000000b002adc1ec0fa3mr8863129lji.20.1686818360423;
        Thu, 15 Jun 2023 01:39:20 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d5282000000b002fae7408544sm20394348wrv.108.2023.06.15.01.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 01:39:19 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 15 Jun 2023 10:39:18 +0200
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: ppc64le vmlinuz is huge when building with BTF
Message-ID: <ZIrONqGJeATpbg3Y@krava>
References: <ZIqGSJDaZObKjLnN@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIqGSJDaZObKjLnN@codewreck.org>
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Thu, Jun 15, 2023 at 12:32:24PM +0900, Dominique Martinet wrote:
> Hi,
> 
> coming from alpine: https://gitlab.alpinelinux.org/alpine/aports/-/issues/12563

hi,
it's probably burried somewhere in that discussion, but do you have
kernel version (or commit) where that increase happened?

also link for used config would be great

thanks,
jirka

> 
> alice noticed the kernel packages got quite bigger, in particular for
> ppc64le I've confirmed that the vmlinuz file size jump when building
> with BTF:
> currently released package with BTF:
> https://dl-cdn.alpinelinux.org/alpine/edge/main/ppc64le/linux-lts-6.1.33-r0.apk
> 272M	boot/vmlinuz-lts
> 
> test build without BTF:
> https://gitlab.alpinelinux.org/martinetd/aports/-/jobs/1049335
> 44M	boot/vmlinuz-lts
> 
> 
> Is that a known issue?
> We'll probably just turn off BTF for the ppc64le build for now, but it
> might be worth checking.
> 
> 
> While I have your attention, even the x86_64 package grew much bigger
> than I thought it would, the installed modules directory go from 90MB to
> 108MB gzipped); it's a 18% increase (including kernel: 103->122MB) which
> is more than what I'd expect out of BTF.
> Most users don't care about BTF so it'd be great if they could be built
> and installed separately (debug package all over again..) or limiting
> the growth a bit more if possible.
> I haven't tried yet but at this point ikheaders is probably worth
> considering instead..
> Perhaps we're missing some stripping option or something?
> 
> 
> Thanks!
> -- 
> Dominique Martinet | Asmadeus
> 
