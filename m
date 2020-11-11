Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84346C388F9
	for <linux-dwarves@archiver.kernel.org>; Wed, 11 Nov 2020 18:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21C72206FB
	for <linux-dwarves@archiver.kernel.org>; Wed, 11 Nov 2020 18:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRJhSKoD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgKKS3p (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 11 Nov 2020 13:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgKKS3p (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 11 Nov 2020 13:29:45 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99CFC0613D1;
        Wed, 11 Nov 2020 10:29:43 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id 10so2781344ybx.9;
        Wed, 11 Nov 2020 10:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QAV7PrwQ2zPY3WXg+djmUbZuDNM+6xgvTGf3s+IjCwQ=;
        b=mRJhSKoDF5AXhMhWNian1jZhReGbQWqnMrIIJvm19xCJ3cVYGn19xvTOC93IRFInSH
         LUDlJpcAkIOzew8jlX94JYYp3Uakp6DL5qEEeYniZH+Mzga4QRFoOpKLappEcd1OwWjz
         N5ThM/dOs8h3gXYsHSaqNzomSSdO9rYKZOtpYOf1ZN5FFhbp/d4YDO1LngkRPcOaW3s3
         fKQdgqVyevP1Ydz9tzVehmO4q04EtrhC6tD1ILLZ09Rr0DZ5pcwB3rVJx4D9n15YaL05
         2XuoKx4XWB9VjCSlxjnm/K4bmyJNwiQNA/yYDXvU3Hm34TlRwhX5KJ+1KLWjcxqreCnY
         q86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QAV7PrwQ2zPY3WXg+djmUbZuDNM+6xgvTGf3s+IjCwQ=;
        b=L/kYzJfGuroa75uxPwIMufJzG6w7N0pssbNis1ZqmH/mRhiNWHARbWaBFfKgioVz0X
         hRqkciusgjRL25uhXNiI4FZeUacikNyquNk8Cd8c8sR3MbNWFWLzX/VZ2iJeD6xEbhv/
         El3OUzsVlFDag/lNbFswrxHsZWRyBmJP6g3Al9kmdP0FjO8L253JTN5LB4Pj8Y+4mPNV
         t6Sluy460mZHBt/4ttl4TH7hdSVo91VFgjPvqqlZNYFFaUaBi/wdSpUrRWRVT2gnntXO
         6TPwV4LgJCMAGVDrO67zD5oE+Jbki0MoNBBD/TlQF7JvsATkKedWpPVLdBhudIBWRXGT
         pqew==
X-Gm-Message-State: AOAM530jXwxA+TYLTO4I+teok8gxZoCOivw2AleVi6rlfNymhfhX8DGS
        kYhz4tHNLUfTVbmim050jq1en07ATgKuAbKrKwo=
X-Google-Smtp-Source: ABdhPJxTy8SEkZNOHCIA8wwrCI+hbxusQ6mgSzBWahJ+EURieg6YcSQqmccwZztAQNq/htXwhcYk0VfhW8lN5gfOkv8=
X-Received: by 2002:a25:7717:: with SMTP id s23mr22662260ybc.459.1605119382963;
 Wed, 11 Nov 2020 10:29:42 -0800 (PST)
MIME-Version: 1.0
References: <20201106052549.3782099-1-andrii@kernel.org> <20201106052549.3782099-5-andrii@kernel.org>
 <20201111115627.GB355344@kernel.org> <20201111121946.GD355344@kernel.org>
In-Reply-To: <20201111121946.GD355344@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 11 Nov 2020 10:29:32 -0800
Message-ID: <CAEf4BzajM3Pg13uTF7cKOWfASvhOPOx85ufcchuDcGLEq8d9fQ@mail.gmail.com>
Subject: Re: [PATCH dwarves 4/4] btf: add support for split BTF loading and encoding
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Wed, Nov 11, 2020 at 4:19 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Nov 11, 2020 at 08:56:27AM -0300, Arnaldo Carvalho de Melo escreveu:
> >
> > The entry for btf_encode/-J is missing, I'll add in a followup patch.
> >
> > Also I had to fixup ARGP_btf_base to 321 as I added this, to simplify
> > the kernel scripts and Makefiles:
> >
> >   $ pahole --numeric_version
> >   118
> >   $
>
> Added this:
>
> [acme@five pahole]$ git diff
> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
> index 20ee91fc911d4b39..f44c649924383a32 100644
> --- a/man-pages/pahole.1
> +++ b/man-pages/pahole.1
> @@ -181,6 +181,14 @@ the debugging information.
>  .B \-\-skip_encoding_btf_vars
>  Do not encode VARs in BTF.
>
> +.TP
> +.B \-J, \-\-btf_encode
> +Encode BTF information from DWARF, used in the Linux kernel build process when
> +CONFIG_DEBUG_INFO_BTF=y is present, introduced in Linux v5.2. Used to implement
> +features such as BPF CO-RE (Compile Once - Run Everywhere).
> +
> +See \fIhttp://vger.kernel.org/bpfconf2019_talks/bpf-core.pdf\fR.

Can you please point to [0] instead? That linked presentation is
already a bit out of date and will bitrot much faster. Blog post has
at least a chance at being updated with relevant important stuff. Plus
it has links both to the bpfconf2019 presentation, as well as some
other resources (including your presentation).

  [0] https://nakryiko.com/posts/bpf-portability-and-co-re/

> +
>  .TP
>  .B \-\-btf_encode_force
>  Ignore those symbols found invalid when encoding BTF.
> [acme@five pahole]$
