Return-Path: <dwarves-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54961C7EE23
	for <linux-dwarves@archiver.kernel.org>; Tue, 28 Feb 2023 02:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjB1Czo (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 27 Feb 2023 21:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjB1Czn (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 27 Feb 2023 21:55:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70C81EFDC
        for <dwarves@vger.kernel.org>; Mon, 27 Feb 2023 18:55:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 828E060DBB
        for <dwarves@vger.kernel.org>; Tue, 28 Feb 2023 02:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CBAC433EF
        for <dwarves@vger.kernel.org>; Tue, 28 Feb 2023 02:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677552939;
        bh=VBPG5iiLB6TmIOuFFxfUgwRC5mFm+MsCffw8ayRQero=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J9SgrXY+dTyY/KGoc5j+gIG5pWq2t3Vj4/bkRh2w1ar9OSCaME7hiueNCwmmaROzq
         F/a/Np7jLOnfPM28ZUwVH7pBPCYAoEpnBQIClubmVXQrsXuaSimfy4KW59aVODwdmN
         fiLW2Btq3jTI9tNdqy6wbyxm4beTv/yEWj738PLfsyxdsk9nVCyAUeQmXAKG5oKLgF
         7aV7w9r/lgWeU1AdKJk3v0LeiISoqjnD5v4BpItAc9IY6mkNfx0AJSPBvccz+nysGW
         QQTuAU1CocUO19MoqEwbYwn8fgX4tsw1jch6WSqNSmAuyDC7XU05M6zLViq1B0qm/g
         EKIeR8H0xUcig==
Received: by mail-ed1-f52.google.com with SMTP id cq23so34318699edb.1
        for <dwarves@vger.kernel.org>; Mon, 27 Feb 2023 18:55:39 -0800 (PST)
X-Gm-Message-State: AO0yUKVc0lpKsgVWNu8c/b2TyaGCsHoZym6dV63A+aYc1ENZiGN0UlFi
        KXilz7+9rPDYAVOqJ17iKI1gA6NjpZwO1r37So0pGw==
X-Google-Smtp-Source: AK7set9+s6RBs8R8IAa8yyX0HzzsKEa2VqfgH8veAjwahsiwqEzlCgeDlUVWUQKC43sxpKjtQKIpmuGpgFj/u2sQX6I=
X-Received: by 2002:a17:906:4bc4:b0:8b0:fbd5:2145 with SMTP id
 x4-20020a1709064bc400b008b0fbd52145mr441213ejv.15.1677552938135; Mon, 27 Feb
 2023 18:55:38 -0800 (PST)
MIME-Version: 1.0
References: <Y/P1yxAuV6Wj3A0K@google.com> <e9f7c86ff50b556e08362ebc0b6ce6729a2db7e7.camel@gmail.com>
 <Y/czygarUnMnDF9m@google.com> <17833347f8cec0e44d856aeafbb1bbe203526237.camel@gmail.com>
 <Y/hLsgSO3B+2g9iF@google.com> <8f8f9d43d2f3f6d19c477c28d05527250cc6213d.camel@gmail.com>
 <Y/p0ryf5PcKIs7uj@google.com> <c4cda35711804ec26ebaeedc07d10d5d51901495.camel@gmail.com>
 <693dffd9571073a47820653fd2de863010491454.camel@gmail.com>
 <CAEf4BzYaiD27y=Y85xhrj+VOvJY_5q1oVtg-4vYmFZFEpmW+nQ@mail.gmail.com>
 <CACYkzJ7tgbJqwUVxfGd4UKDUcOQjK8zsbEKUUjV79=xHQn1fFg@mail.gmail.com>
 <CAEf4BzZauF7V3pY1hgWgnJRN1F6eSkbTOTG3kM0c85uAX-vOfQ@mail.gmail.com>
 <9ea9b52fca1300265ce5639a2da809813edb774f.camel@gmail.com>
 <CAEf4BzYO+Rgcfbr+QzJ-8BdQg-x-mC6c4bOhA+Z4cvu_1ObX+g@mail.gmail.com> <b245e95e9028d4eb14febda06f9fb25139e5e122.camel@gmail.com>
In-Reply-To: <b245e95e9028d4eb14febda06f9fb25139e5e122.camel@gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 28 Feb 2023 03:55:27 +0100
X-Gmail-Original-Message-ID: <CACYkzJ4yR0n+kP9-G025uP2fwhyBh9DF2feA+H5mw+Re6GdkFQ@mail.gmail.com>
Message-ID: <CACYkzJ4yR0n+kP9-G025uP2fwhyBh9DF2feA+H5mw+Re6GdkFQ@mail.gmail.com>
Subject: Re: bpf: Question about odd BPF verifier behaviour
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Matt Bobrowski <mattbobrowski@google.com>, bpf@vger.kernel.org,
        andrii@kernel.org, acme@redhat.com, dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org

On Mon, Feb 27, 2023 at 9:48=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2023-02-27 at 11:31 -0800, Andrii Nakryiko wrote:
> [...]
> > > > I'd start with understanding what BTF and DWARF differences are
> > > > causing the issue before trying to come up with the fix. For that w=
e
> > > > don't even need config or repro steps, it should be enough to share
> > > > vmlinux with BTF and DWARF, and start from there.
> > > >
> > >
> > > Yes, I suspect that there is some kind of unanticipated
> > > anomaly for some DWARF encoding for some kind of objects,
> > > just need to find the root for the diverging type hierarchies.
> > >
> > > > But I'm sure Eduard is on top of this already (especially that he c=
an
> > > > repro the issue now).
> > >
> > > I'm working on it, nothing to report yet, but I'm working on it.
> > >
> >
> > Thanks, please keep us posted!
>
> It is interesting how everything is interconnected. The patch for
> pahole below happens to help. I prepared it last week while working on
> new DWARF encoding scheme for btf_type_tag.
>
> I still need to track down which "unspecified_type" entries caused the
> issue in this particular case. Will post an update tomorrow.
>
> Meanwhile, Matt, KP, could you please verify the patch on your side?
> It is for the "next" branch of pahole.
>
> ---
>
> From 09fac63ca08e25aea499f827283b07cc87a7daab Mon Sep 17 00:00:00 2001
> From: Eduard Zingerman <eddyz87@gmail.com>
> Date: Tue, 21 Feb 2023 19:23:00 +0200
> Subject: [PATCH] dwarf_loader: Fix for BTF id drift caused by adding
>  unspecified types
>
> Recent changes to handle unspecified types (see [1]) cause BTF ID drift.
>
> Specifically, the intent of commits [2], [3] and [4] is to render
> references to unspecified types as void type.
> However, as a consequence:
> - in `die__process_unit()` call to `cu__add_tag()` allocates `small_id`
>   for unspecified type tags and adds these tags to `cu->types_table`;
> - `btf_encoder__encode_tag()` skips generation of BTF entries for
>   `DW_TAG_unspecified_type` tags.
>
> Such logic causes ID drift if unspecified type is not the last type
> processed for compilation unit. `small_id` of each type following
> unspecified type in the `cu->types_table` would have its BTF id off by -1=
.
> Thus renders references established on recode phase invalid.
>
> This commit reverts `unspecified_type` id/tag tracking, instead:
> - `small_id` for unspecified type tags is set to 0, thus reference to
>   unspecified type tag would render BTF id of a `void` on recode phase;
> - unspecified type tags are not added to `cu->types_table`.
>
> [1] https://lore.kernel.org/all/Y0R7uu3s%2FimnvPzM@kernel.org/
> [2] bcc648a10cbc ("btf_encoder: Encode DW_TAG_unspecified_type returning =
routines as void")
> [3] cffe5e1f75e1 ("core: Record if a CU has a DW_TAG_unspecified_type")
> [4] 75e0fe28bb02 ("core: Add DW_TAG_unspecified_type to tag__is_tag_type(=
) set")
>
> Fixes: bcc648a10cbc ("btf_encoder: Encode DW_TAG_unspecified_type returni=
ng routines as void")
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Tested-by: KP Singh <kpsingh@kernel.org>
Reported-by: Matt Bobrowski <mattbobrowski@google.com>

Thank you so much Eduard, this worked:

* No duplicate BTF ID warnings
* No 15 minute BTF ID generation
* Matt's reproducer loads successfully.

I had a sneaky suspicion that it was these unspecified types, which is
why my hacky patch which got unspecified types out of the way got
things to *mostly* work.
