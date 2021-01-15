Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D2DC433DB
	for <linux-dwarves@archiver.kernel.org>; Fri, 15 Jan 2021 15:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B70207D0
	for <linux-dwarves@archiver.kernel.org>; Fri, 15 Jan 2021 15:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbhAOPlT (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Fri, 15 Jan 2021 10:41:19 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:38908 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbhAOPlT (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Fri, 15 Jan 2021 10:41:19 -0500
Received: by mail-wr1-f51.google.com with SMTP id a9so6260064wrt.5
        for <dwarves@vger.kernel.org>; Fri, 15 Jan 2021 07:41:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=tyR33q0E9xrG/CvG/lOy2D9YZibkRmSCYtCkBVaLBxQ=;
        b=ERmUcP3usc7DSAPbzvwdsCd4+gCTP/Fx/TFnsaSKdfJNQ0pjUnU+TbYbX1lwoHPLPX
         bkdK7e1hsYZyYygfmMvnYdVn/DLKOA8WE3fmCMeyV+whmOT25bJBBfSHybzA3nJiUqtc
         vfwU60XJqKdenJweXqOWwfq45cuJBtCojIwXtd4YIQ6vSsyvRqv/xMJlaIjzwzh32QgO
         39vZBGynoAAcycAQkQCbEeIEZYklLnWxxEqTEIxUyj+orYdHHDhqnMJxb6++GSzAdvAX
         IPLeyHn0NTkbxBQi0FZLoaQD332wj8/kg+QltIO29vwLxrTD5UpE2oU9UP7JpVF3DlAh
         s0Nw==
X-Gm-Message-State: AOAM530GPe1qObbRd40jLT2LpoItelZ1VtnZkmZTu2hz1rrvKLlTIe9L
        Jo+HHChOSqJsPJ1ejIUwB6U=
X-Google-Smtp-Source: ABdhPJxsrypy8tbzGxyidIQUwDDx1iJbCjwb3KgLL/5M1KsERhu/Yg7Sy+A1Y5MmN1sM3O/UuTO8jw==
X-Received: by 2002:a5d:674c:: with SMTP id l12mr13673162wrw.399.1610725236797;
        Fri, 15 Jan 2021 07:40:36 -0800 (PST)
Received: from localhost ([2a01:4b00:f419:6f00:7a8e:ed70:5c52:ea3])
        by smtp.gmail.com with ESMTPSA id r2sm15629941wrn.83.2021.01.15.07.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 07:40:35 -0800 (PST)
Message-ID: <c3a211f0bef8aed1c097f13f0a178f838dc5f520.camel@debian.org>
Subject: Re: [PATCH dwarves] libbpf: allow to use packaged version
From:   Luca Boccassi <bluca@debian.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     dwarves@vger.kernel.org
Date:   Fri, 15 Jan 2021 15:40:34 +0000
In-Reply-To: <20210115152915.GA457607@kernel.org>
References: <20210102182201.122619-1-bluca@debian.org>
         <CAEf4Bzb3jtv4+KBRNOzfERWyx_4Wh_m7xRrWcc7nAgoXi+yW-Q@mail.gmail.com>
         <9809e2cd737edb9c70954b99bdf4ce874844965b.camel@debian.org>
         <CAEf4BzarBG3HnxTiCpum9i31cTTdqDKWnHeV4zbRrUgs2V1Rpw@mail.gmail.com>
         <20210115152915.GA457607@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-FtFV68+KEQvfyZHY9pbo"
User-Agent: Evolution 3.30.5-1.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org


--=-FtFV68+KEQvfyZHY9pbo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-01-15 at 12:29 -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jan 04, 2021 at 12:23:25PM -0800, Andrii Nakryiko escreveu:
> > On Sun, Jan 3, 2021 at 1:30 PM Luca Boccassi <bluca@debian.org> wrote:
> > > On Sun, 2021-01-03 at 11:10 -0800, Andrii Nakryiko wrote:
> > > > On Sat, Jan 2, 2021 at 10:25 AM Luca Boccassi <bluca@debian.org>
> > > > wrote:
> > > > > Add a new CMake option, LIBBPF_EMBEDDED, to switch between the
> > > > > embedded version and the system version (searched via pkg-config)
> > > > > of libbpf. Set the system version as the default.
> > > > >=20
> > > >=20
> > > > There's been a lot of arguments about libbpf as a submodule, so I
> > > > don't think we need to go about pros and cons again, but I just
> > > > wanted
> > > > to cast my vote against doing this at all. Having pahole built with
> > > > libbpf statically (only) was a great thing for me so far with
> > > > iterating quickly and adopting new APIs without overcomplicating th=
e
> > > > source code with all sorts of feature detection code. Without it,
> > > > adopting libbpf's faster string deduplication, BTF writing APIs,
> > > > module/split BTFs, etc, etc, would be much bigger PITA and/or would
> > > > prolong such changes. To the point that I personally wouldn't bothe=
r
> > > > with some of them at all. Distro maintainers obviously don't care
> > > > about such inconveniences for developers, but it's a real factor in
> > > > determining what kind of functionality is implemented in pahole, so=
 I
> > > > hope Arnaldo won't dismiss this without thinking about this
> > > > carefully.
>=20
> Hey, having tools/perf/ and tools/lib/perf, tools/lib/bpf, etc all in
> one place is really nice :-)
>=20
> > > You know very well that it's not about caring or not caring :-) There
> > > are simply conflicting interests, and both sides are valid.
> =20
> > I didn't mean it in a negative way. Different priorities and interests
> > is a better way to put it, sure.
>=20
> I think the default should be submodules as we're still very much in
> flux, adding new features, etc.
>=20
> Disto maintainers can make sure they know what they're doing when making
> tools use libbpf as a separate package.

Sure, v3 has the option as default-disabled already, not a problem at
all.

> I'm coming back from vacation, so trying to zip thru a lot of emails, so
> just thought about sharing my first reaction to this in a quick way.

No worries and no rush.

--=20
Kind regards,
Luca Boccassi

--=-FtFV68+KEQvfyZHY9pbo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE6g0RLAGYhL9yp9G8SylmgFB4UWIFAmABt3IACgkQSylmgFB4
UWInVQf/bJWXvZsBHe3KUfiXkPNOZ9CRmj8VRpdJOgWs0vNXolw1rmBQl3MtKXkQ
k9KSPSswaeC0cJCdTVcuQVO+V9nAmkL1Xjr4W8InyQygNOp8v9ZRpVODvYhdIehf
NIuhaX8Xv91aWb0N9R8N3BYjOgYHKy3EaKxknG072/Eeid6RpxTZqErwuHMilXSg
pHPr7Lnb8l5h3suN9O/CYZY1spC3t6uCb8jt01f9Vkurj/XmCYAt5U42DbJ5Fyq/
DKb5ZmiIigE6Dbdws9dLXDq7ZwJYyJ3ucCS2D3tcCZK7eMWXEbCHfks+HuGwsAQh
8+KnufsKEKjqTwMRnYmEO857HUzydw==
=zqos
-----END PGP SIGNATURE-----

--=-FtFV68+KEQvfyZHY9pbo--
