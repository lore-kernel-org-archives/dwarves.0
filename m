Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7C8C433FE
	for <linux-dwarves@archiver.kernel.org>; Fri,  4 Dec 2020 21:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43F0722A85
	for <linux-dwarves@archiver.kernel.org>; Fri,  4 Dec 2020 21:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgLDVY6 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 4 Dec 2020 16:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgLDVY5 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 4 Dec 2020 16:24:57 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6D1C0613D1
        for <dwarves@vger.kernel.org>; Fri,  4 Dec 2020 13:24:17 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id w135so1120572ybg.13
        for <dwarves@vger.kernel.org>; Fri, 04 Dec 2020 13:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dqtzOY0jRzHswbuk3NCKVui1FUN95X1ufg/ByHbCwiA=;
        b=UC+9vaK3R0BhS4g0MnXTq+/fQYYzvMB8EC//ClUnY46egpT3eQOgxIhGqYL0jgNmuT
         Z2OhBQVc+mZTOCD8u63oYVN/aptcvcEWsdKQf73wewYi4TY+46nWNqAsaLmcAzZp6hhf
         rKx8QI8TvivVTFcmO5aKLZ4WNhqXyoQfYtFuyKWg+YcZpOfTq73XX2akRXt+J9wApPu8
         MC0lEi9TY2fqfgwV+ZSpBw6WDXxADllzAQMsIXe9DwsswGNZ2mzXcztQhW/xjEVhMh3C
         rUqwCyjOXXOoq70xG0Cuyr090lnzaqLnRQTjGUNOHN2087r7busjG8st/oB1k8dGlyxE
         2UXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dqtzOY0jRzHswbuk3NCKVui1FUN95X1ufg/ByHbCwiA=;
        b=Ub4YrPABE3ItfIayGZ+WF9Hqsd0Kivby8G62uPpnQ4eTjpZaGUoYgCbULabKFlMwh1
         o9xGRerbTSP7VtL3b5VKiwPeyrmY5+/JFox+WhU1v4eZhurMesoIwrsfCFW9BbrZ2J5G
         lSPeUPqE2yfRkipwctZ11eKuHWjuEhUd6zrHfL6hiLCWasyK3WOShugfIiCxCMouf7M5
         GhWyY5CW63h++3L46mJBBHcYZVpOPDol12zVj7FYkJqbXDwn+2Rmzm8tlABYdlv/L5pW
         g4BCMrmNNfCiaFQhxg3t+sBcFEqMoAFQ5J0DcglHuFQuBhthvtwda5rtGRkgB+oKQqkA
         2T3Q==
X-Gm-Message-State: AOAM532F7c7NTxTRvsSL79F07RB9vrowpBaxAxRoZ3JweBVyRNdcaH2o
        8kVruKF5tHXVC1WgyG5hUNuYULcqv23yj9zXrUkvDL1suek=
X-Google-Smtp-Source: ABdhPJzSdlp4LmjeSvJwJBufIxwjvrUtScWUsPnm7QAiWyf4hk3Y1l68TDRYYZZwZ4qnTwxleWGhLBvVwT/QUIGP/+I=
X-Received: by 2002:a25:df82:: with SMTP id w124mr8623705ybg.347.1607117056936;
 Fri, 04 Dec 2020 13:24:16 -0800 (PST)
MIME-Version: 1.0
References: <20201204212014.2983374-1-andrii@kernel.org>
In-Reply-To: <20201204212014.2983374-1-andrii@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Dec 2020 13:24:05 -0800
Message-ID: <CAEf4BzYaLC42R3dTs29ZqvaBOCkdKL0QtY-2vN8HwpOj=Vczcg@mail.gmail.com>
Subject: Re: [PATCH dwarves] rpm: fix changelog date
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Fri, Dec 4, 2020 at 1:20 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> It causes errors when trying to import 1.19 version.
>
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

Arnaldo, would it be possible to re-generate RPM with this fix? I
currently can't import pahole 1.19 due to this problem.

>  - Rebuilt for https://fedoraproject.org/wiki/Fedora_15_Mass_Rebuild
>
>  * Fri Dec  4 2009 Arnaldo Carvalho de Melo <acme@redhat.com> - 1.8-1
> --
> 2.24.1
>
