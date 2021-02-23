Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C447C433E0
	for <linux-dwarves@archiver.kernel.org>; Tue, 23 Feb 2021 20:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CE9A64E60
	for <linux-dwarves@archiver.kernel.org>; Tue, 23 Feb 2021 20:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhBWUq6 (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 23 Feb 2021 15:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbhBWUqY (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 23 Feb 2021 15:46:24 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EC7C06174A
        for <dwarves@vger.kernel.org>; Tue, 23 Feb 2021 12:45:44 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id v22so4197edx.13
        for <dwarves@vger.kernel.org>; Tue, 23 Feb 2021 12:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NozYZU1bAfNdIG5JtSkKa87zG+RKiElyAQ58w2uVmeo=;
        b=agp6o9eThVt8g6uYecy/26AFJ+sZf2asJYY/D1b5z3LlpYuzgrW2ftto7UEQ4W3jcW
         swe6+KSKtIEbbCeOCTM+hY58p7RgPUgcicOAqT+sIYt4thhrYyRXx1M6kipY+7VVZORV
         NU+orB37SLwA3uxxg+RhC7CRpithufDilXPXC5fM832FbA3CgRgrf0JKtSdEC8abxQRZ
         KlYsvuE/2dbOkg7E5grvp+VNDaDbvdW9ISQuxcI5kFsByazw1+xKLC4SaUAJfBzlWjAm
         n/d0r4VP7c56SSmurZ6bdCuCYvV4AVMZRNno1za1JaV+IpM5yFMICQ3x/m9Lwe/WbzYO
         84lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NozYZU1bAfNdIG5JtSkKa87zG+RKiElyAQ58w2uVmeo=;
        b=DChSnVPIPFXXiDHSgHlE2IqcI+B1st50GNkw81/ukFABDJ7qc8T9G/A5mljelsdRXW
         S2NYzLp6/W06dF3IU3OnNWf3euUkPqF5oeNgfZxU2747Suv+YTEENkTdygeoGZw+DE/E
         xEiy05j9lXlKKsNInjap6yTVFo0xyDN3yWQqEW4O+aadegrS7ksmnGK0mSTQAjs7VXL4
         aqXDrQmqCRapyGcHk3zsSEOweLB6nvA+F7QP+U4B6xW+0Li4YIM4C/aSmaqnG0cMckyT
         xvN/qXqp/QBKum0dmTRDJuUUTnusgCDaVmsAGyMpA+bks0rfMAJ16mcH+05r5vuoSFYi
         4fVA==
X-Gm-Message-State: AOAM532u3a9N2HokSLJt0PBtXI8ItLdDyO670xOcU3yPm9pa4v12dWIN
        Q+1EyfexMfvJ7xOztprxNPzo+JFAKKACkZrS8kjrEmbdUw==
X-Google-Smtp-Source: ABdhPJyjgdQi2IP6HpUZrBMWFCYnTVpoLP8+fLj4S1n8ilxv8EoVfH867O0aR98uL7Kx7FmP8RAXtd6aoHHQeY2ga48=
X-Received: by 2002:a50:a086:: with SMTP id 6mr29295197edo.70.1614113142343;
 Tue, 23 Feb 2021 12:45:42 -0800 (PST)
MIME-Version: 1.0
References: <20210212211607.2890660-1-morbo@google.com>
In-Reply-To: <20210212211607.2890660-1-morbo@google.com>
From:   Bill Wendling <morbo@google.com>
Date:   Tue, 23 Feb 2021 12:44:58 -0800
Message-ID: <CAGG=3QWuxzwKGuYhVu+EfXPFZMNsO7-=NtHbdXAyvcVjvKF3hA@mail.gmail.com>
Subject: Re: [RFC 0/1] Combining CUs into a single hash table
To:     dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

Bump for exposure.

On Fri, Feb 12, 2021 at 1:16 PM Bill Wendling <morbo@google.com> wrote:
>
> Hey gang,
>
> I would like your feedback on this patch.
>
> This patch creates one hash table that all CUs share. The impetus for this
> patch is to support clang's LTO (Link-Time Optimizations). Currently, pahole
> can't handle the DWARF data that clang produces, because the CUs may refer to
> tags in other CUs (all of the code having been squozen together).
>
> One solution I found is to process the CUs in two steps:
>
>   1. add the CUs into a single hash table, and
>   2. perform the recoding and finalization steps in a a separate step.
>
> The issue I'm facing with this patch is that it balloons the runtime from
> ~11.11s to ~14.27s. It looks like the underlying cause is that some (but not
> all) hash buckets have thousands of entries each. I've bumped up the
> HASHTAGS__BITS from 15 to 16, which helped a little. Bumping it up to 17 or
> above causes a failure.
>
> A couple of things I thought of may help. We could increase the number of
> buckets, which would help with distribution. As I mentioned though, that seemed
> to cause a failure. Another option is to store the bucket entries in a
> non-list, e.g. binary search tree.
>
> I wanted to get your opinions before I trod down one of these roads.
>
> Share and enjoy!
> -bw
>
> Bill Wendling (1):
>   dwarf_loader: have all CUs use a single hash table
>
>  dwarf_loader.c | 45 +++++++++++++++++++++++++++++++++------------
>  1 file changed, 33 insertions(+), 12 deletions(-)
>
> --
> 2.30.0.478.g8a0d178c01-goog
>
