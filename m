Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86EFC433FE
	for <linux-dwarves@archiver.kernel.org>; Fri,  4 Dec 2020 23:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8DFB22D01
	for <linux-dwarves@archiver.kernel.org>; Fri,  4 Dec 2020 23:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgLDXCC (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 4 Dec 2020 18:02:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgLDXCC (ORCPT <rfc822;dwarves@vger.kernel.org>);
        Fri, 4 Dec 2020 18:02:02 -0500
Date:   Fri, 4 Dec 2020 20:01:28 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607122881;
        bh=7g8/pM2wCzN6F1uVVguh3s5F0WUQj3smRzZkdO2lu8E=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=i/41qxiOYemx5D25FneXzDYxt1rZnlvAZ/Br9pTHVPUIcmrcCKSIIcbXQYXmpYtfz
         vN/KveG9pXOZlodwapQnv9rJ6XRBySz5WXe0BQYZG8v0JR4MC7tDVHRJXr80Pu/ngN
         jb9ZU90I7gpX71WSX1jkg0X0ye7sXoePQHxIfFdGbFaOMb9L8vxypZ1Va/vYUXIoxw
         0514ZWiCe5EgDHqsaMCewfSxJ/vcLEzIbErUieq3qKojQPJQ4cHx+AIraTHX8DMT3e
         TwHDiaZv6Jbp4IbmuKsSXUbLsYh4jZZV+LxK5Wi+6ckFWRP+e5f1zVZ/o5A19pQSUr
         xOVaexwY6CJTQ==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     dwarves@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH dwarves] rpm: fix changelog date
Message-ID: <20201204230128.GA122569@kernel.org>
References: <20201204212014.2983374-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204212014.2983374-1-andrii@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Em Fri, Dec 04, 2020 at 01:20:14PM -0800, Andrii Nakryiko escreveu:
> It causes errors when trying to import 1.19 version.

Thanks, applied, will go thru the fixes from Jiri that you already acked
and probably do a quick v1.20.

- Arnaldo
 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  rpm/SPECS/dwarves.spec | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rpm/SPECS/dwarves.spec b/rpm/SPECS/dwarves.spec
> index 9232002ccd28..693a9da19c82 100644
> --- a/rpm/SPECS/dwarves.spec
> +++ b/rpm/SPECS/dwarves.spec
> @@ -275,7 +275,7 @@ rm -Rf %{buildroot}
>  * Sat Nov 20 2010 Arnaldo Carvalho de Melo <acme@redhat.com> - 1.9-1
>  - New release
>  
> -* Tue Feb 08 2011 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 1.8-2
> +* Tue Feb 08 2010 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 1.8-2
>  - Rebuilt for https://fedoraproject.org/wiki/Fedora_15_Mass_Rebuild
>  
>  * Fri Dec  4 2009 Arnaldo Carvalho de Melo <acme@redhat.com> - 1.8-1
> -- 
> 2.24.1
> 

-- 

- Arnaldo
