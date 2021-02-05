Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB0FC433DB
	for <linux-dwarves@archiver.kernel.org>; Sat,  6 Feb 2021 03:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45C7264FA8
	for <linux-dwarves@archiver.kernel.org>; Sat,  6 Feb 2021 03:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhBFDjG (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 5 Feb 2021 22:39:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231335AbhBFDg4 (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Fri, 5 Feb 2021 22:36:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7663065007;
        Fri,  5 Feb 2021 23:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612569518;
        bh=XHitwT1/N1am1r3feUWrrAvvN2GhxDZgn6QMvVjDlPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E+zONWeq2kurOvejE/nwE/HeTUNLZB6N94kEfBdQV9HbDIyP1gbglIidjNY8h0/di
         mmPlaiFSpvQoEnOdqt4DL1DnpxA49LTBhFqvoj3nUxlIQ/roNFzkGTqVlNnd8lz/nl
         3MC9oAO0XKrYcqLyBkSuZUbh8s9YTtGngUnyEcOcCaiXkmT9EWJGiki+ypCp9mKjg2
         dfXf4dUQbOoVQTRX6AyhT1WHU6L+nJbFVQsLf3CTTFPbzpsVEE5UMgwj0sqfESETQx
         1AhSAEJF9jccYEwEnP81gIS1LDR0ndtp+M306E/OCz26zNt+w+x6f37xXLdH52cxJu
         Tp0IL3DkoED8w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5104740513; Fri,  5 Feb 2021 20:58:36 -0300 (-03)
Date:   Fri, 5 Feb 2021 20:58:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     dwarves@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH dwarves] spec: fix dates in RPM spec
Message-ID: <20210205235836.GF106434@kernel.org>
References: <20210205233505.79604-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205233505.79604-1-andrii@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Fri, Feb 05, 2021 at 03:35:05PM -0800, Andrii Nakryiko escreveu:
> Two dates have invalid days of the week. Fix that.

So yeah, you sent the patch, first ones to be applied for 1.21, now if
this would be the only problems to tackle in 1.21 I'd be super happy :)

Thanks a lot!

- Arnaldo
 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  rpm/SPECS/dwarves.spec | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/rpm/SPECS/dwarves.spec b/rpm/SPECS/dwarves.spec
> index 98433e395b6c..178d7c1397ec 100644
> --- a/rpm/SPECS/dwarves.spec
> +++ b/rpm/SPECS/dwarves.spec
> @@ -295,7 +295,7 @@ rm -Rf %{buildroot}
>  * Sat Nov 20 2010 Arnaldo Carvalho de Melo <acme@redhat.com> - 1.9-1
>  - New release
>  
> -* Tue Feb 08 2010 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 1.8-2
> +* Mon Feb 08 2010 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 1.8-2
>  - Rebuilt for https://fedoraproject.org/wiki/Fedora_15_Mass_Rebuild
>  
>  * Fri Dec  4 2009 Arnaldo Carvalho de Melo <acme@redhat.com> - 1.8-1
> @@ -446,7 +446,7 @@ rm -Rf %{buildroot}
>  - Fix emission of arrays of structs, unions, etc
>  - use sysconf for the default cacheline size
>  
> -* Wed Jan 18 2007 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
> +* Thu Jan 18 2007 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
>  - fab0db03ea9046893ca110bb2b7d71b764f61033
>  - pdwtags added
>  
> -- 
> 2.24.1
> 

-- 

- Arnaldo
