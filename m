Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9789EC4167B
	for <linux-dwarves@archiver.kernel.org>; Fri,  4 Dec 2020 22:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 781E722287
	for <linux-dwarves@archiver.kernel.org>; Fri,  4 Dec 2020 22:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgLDWqA (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 4 Dec 2020 17:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLDWp7 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 4 Dec 2020 17:45:59 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EA0C061A4F
        for <dwarves@vger.kernel.org>; Fri,  4 Dec 2020 14:45:19 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id w135so1298449ybg.13
        for <dwarves@vger.kernel.org>; Fri, 04 Dec 2020 14:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2o4J1hGEW74BrcwMVHm4VOi+DF1zg+qHt4x+YoQHS3o=;
        b=XiCQj5eS44QooUadP2sVM7Ie9ME5ounFwOqo0lXRRnzulCgcSF1Kdg77og9sRmmt9L
         0i8CJynoycKsYQqvbTU+mNE+mCDsjfYD7Rn0jAu5Yw0lqRt1hp5dvxaJalxGxxMii47G
         Dvoe5Ff2pMAkDrAMz3nXe11giBiDvOImX2dwNtOEmHxvmBy+hdLsPLsza+c/OpC37KJI
         JhWoSOT+zm9FMj2PTDZ/ialxTa1rbx5y3cTvYtAYjL/59eZMnO/6h4TqwxloFl+n1oRE
         FHikm+6rkyEOR2gX1O75Lrqsu1uttv5XbQp3u8Abj7FkGDMusWloyDxu4l+xGbAM/E1s
         B02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2o4J1hGEW74BrcwMVHm4VOi+DF1zg+qHt4x+YoQHS3o=;
        b=Hrn6f6JM8bLCnVklqmLaiZidZBDFY/Ne20Upp1ZexGnT2FoB3RZEv4AJYNGdK5XrDs
         addxr19yk6/Tw1bX2pCC8bA604kyucP0kxtMBD1hl91eYiygP6b7/lhys0f5iBPmbsrf
         NfCYYa4RBdlxnUDY7ua4fKHaT1P0H3W12vqnijEHfC9tL4fKOmekKDhjfoszwWVOsD27
         t7i1RAR3ndfUZTncqz4ZPq3usEy+Bl2dxppzblyBFl79POEtiGbHyoYGB/uETsWSKMh9
         HDVZdxkcHsdrEI9Js49haJlEGRtO+sgPYmbAi579URmG36hggjUuMVbrrfbAVJNS6Rz/
         8HuA==
X-Gm-Message-State: AOAM531oykCvo3Z3Bjv92bF9mG4vIEM4xDEEoQynnd3WT2/OgO4ZLw6v
        qaXzDVLYVQAc6ykAyzuC2OLkCFXtlxzXMW2NbHZH1aFMMC0=
X-Google-Smtp-Source: ABdhPJxRED3ylneiSli5tZk/nPr5ITZ+DY9G0ZFF7y8oqkXI/JrQ8IsQPx9bDECRxUUTiIh8xmaqgKlDH99Orhu7BzI=
X-Received: by 2002:a25:df8e:: with SMTP id w136mr8752179ybg.230.1607121918273;
 Fri, 04 Dec 2020 14:45:18 -0800 (PST)
MIME-Version: 1.0
References: <20201204212014.2983374-1-andrii@kernel.org> <CAEf4BzYaLC42R3dTs29ZqvaBOCkdKL0QtY-2vN8HwpOj=Vczcg@mail.gmail.com>
 <16DA960B-67DC-4640-97A4-1173653B48C0@gmail.com>
In-Reply-To: <16DA960B-67DC-4640-97A4-1173653B48C0@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Dec 2020 14:45:07 -0800
Message-ID: <CAEf4BzbrwWGB=GyKk=2qwBDmHguJo10XcP3ju7OCPAnpus0_Rg@mail.gmail.com>
Subject: Re: [PATCH dwarves] rpm: fix changelog date
To:     Arnaldo <arnaldo.melo@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Fri, Dec 4, 2020 at 2:16 PM Arnaldo <arnaldo.melo@gmail.com> wrote:
>
> I'll fix it. But you mean in fedora? Or just the spec file on the git repo?


yeah, meant fedora's .src.rpm package, which I need to use to import
the package into our internal system

>
> - Arnaldo
>
>
>
> On December 4, 2020 6:24:05 PM GMT-03:00, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>>
>> On Fri, Dec 4, 2020 at 1:20 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>>>
>>>
>>>  It causes errors when trying to import 1.19 version.
>>>
>>>  Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>>> ________________________________
>>>   rpm/SPECS/dwarves.spec | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>>  diff --git a/rpm/SPECS/dwarves.spec b/rpm/SPECS/dwarves.spec
>>>  index 9232002ccd28..693a9da19c82 100644
>>>  --- a/rpm/SPECS/dwarves.spec
>>>  +++ b/rpm/SPECS/dwarves.spec
>>>  @@ -275,7 +275,7 @@ rm -Rf %{buildroot}
>>>   * Sat Nov 20 2010 Arnaldo Carvalho de Melo <acme@redhat.com> - 1.9-1
>>>   - New release
>>>
>>>  -* Tue Feb 08 2011 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 1.8-2
>>>  +* Tue Feb 08 2010 Fedora Release Engineering <rel-eng@lists.fedoraproject.org> - 1.8-2
>>
>>
>> Arnaldo, would it be possible to re-generate RPM with this fix? I
>> currently can't import pahole 1.19 due to this problem.
>>
>>>   - Rebuilt for https://fedoraproject.org/wiki/Fedora_15_Mass_Rebuild
>>>
>>>   * Fri Dec  4 2009 Arnaldo Carvalho de Melo <acme@redhat.com> - 1.8-1
>>>  --
>>>  2.24.1
>>>
>
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
