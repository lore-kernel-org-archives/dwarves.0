Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2E0C48BCD
	for <linux-dwarves@archiver.kernel.org>; Wed,  9 Jun 2021 16:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A563610A2
	for <linux-dwarves@archiver.kernel.org>; Wed,  9 Jun 2021 16:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbhFIQNs (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 9 Jun 2021 12:13:48 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:36494 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbhFIQNs (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 9 Jun 2021 12:13:48 -0400
Received: by mail-wm1-f53.google.com with SMTP id h11-20020a05600c350bb02901b59c28e8b4so4176067wmq.1
        for <dwarves@vger.kernel.org>; Wed, 09 Jun 2021 09:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=RaMrH4JKtQp+3kgdR6bLoqTtuo8cNRW23lXI6rUtpvQ=;
        b=WqLcRVrKWiFU8GRCWuLmiLNEeNnaAvX8hp0jOeoY1OPifFbWriKXuYNQ1y/GLZBeKL
         QDzbrPcGTq9mtsuQry4H7uEsEX93yR0abVqhz4Cp7SWqUzji7dmqaThWR6vFMgBWgjcw
         YM6j0N4C6dpWPQ+zK+LvbUQ0CiEBJJ1vCITI78+r4AYq0sSYBsBcnAXxuP5a0+44pPiF
         qDoasZEaB3yWMeBZcPh/+ABEPWOlaWmjXQL6nC1vNW+n2+K73Nji/Sylby5iB75NG3Ie
         iWiiphuG9LjFfSPut+aDH8Izqm2Rz+2tPAxf99qmTTbhQ6IaF7ro/nPsddASO4gkwWs2
         zMLQ==
X-Gm-Message-State: AOAM532FeL4v2WHKPIlkxWWRJ9dlST4sIur119pbmaErYQEBInIycwNU
        /sR/1kjSiduzPzPJNmjBIdk=
X-Google-Smtp-Source: ABdhPJyr2irm7dofiZAlrEjU/IN2QRH+Xq927QYoGp3yhawuhv5Q8OWRfBwj+bZcCSiFTAFXJ+nAAw==
X-Received: by 2002:a1c:e907:: with SMTP id q7mr10739940wmc.1.1623255099456;
        Wed, 09 Jun 2021 09:11:39 -0700 (PDT)
Received: from localhost ([2a01:4b00:f41a:3600:360b:9754:2e3a:c344])
        by smtp.gmail.com with ESMTPSA id n12sm353156wrw.83.2021.06.09.09.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 09:11:38 -0700 (PDT)
Message-ID: <03320662a97ca9c5ecc9bdf327aa274ff1b1f0ab.camel@debian.org>
Subject: Re: [PATCH dwarves] libbpf: allow to use packaged version
From:   Luca Boccassi <bluca@debian.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        dwarves@vger.kernel.org
Date:   Wed, 09 Jun 2021 17:11:37 +0100
In-Reply-To: <YMDnLoL3H7bo3HOv@kernel.org>
References: <20210102182201.122619-1-bluca@debian.org>
         <CAEf4Bzb3jtv4+KBRNOzfERWyx_4Wh_m7xRrWcc7nAgoXi+yW-Q@mail.gmail.com>
         <9809e2cd737edb9c70954b99bdf4ce874844965b.camel@debian.org>
         <CAEf4BzarBG3HnxTiCpum9i31cTTdqDKWnHeV4zbRrUgs2V1Rpw@mail.gmail.com>
         <20210115152915.GA457607@kernel.org>
         <c3a211f0bef8aed1c097f13f0a178f838dc5f520.camel@debian.org>
         <YMDnLoL3H7bo3HOv@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-7WmgMWVGIxNdoP+TCDau"
User-Agent: Evolution 3.30.5-1.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org


--=-7WmgMWVGIxNdoP+TCDau
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-06-09 at 13:07 -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jan 15, 2021 at 03:40:34PM +0000, Luca Boccassi escreveu:
> > On Fri, 2021-01-15 at 12:29 -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Mon, Jan 04, 2021 at 12:23:25PM -0800, Andrii Nakryiko escreveu:
> > > > On Sun, Jan 3, 2021 at 1:30 PM Luca Boccassi <bluca@debian.org> wro=
te:
> > > > > On Sun, 2021-01-03 at 11:10 -0800, Andrii Nakryiko wrote:
> > > > > > On Sat, Jan 2, 2021 at 10:25 AM Luca Boccassi <bluca@debian.org=
>
> > > > > > wrote:
> > > > > > > Add a new CMake option, LIBBPF_EMBEDDED, to switch between th=
e
> > > > > > > embedded version and the system version (searched via pkg-con=
fig)
> > > > > > > of libbpf. Set the system version as the default.
> > > > > > >=20
> > > > > >=20
> > > > > > There's been a lot of arguments about libbpf as a submodule, so=
 I
> > > > > > don't think we need to go about pros and cons again, but I just
> > > > > > wanted
> > > > > > to cast my vote against doing this at all. Having pahole built =
with
> > > > > > libbpf statically (only) was a great thing for me so far with
> > > > > > iterating quickly and adopting new APIs without overcomplicatin=
g the
> > > > > > source code with all sorts of feature detection code. Without i=
t,
> > > > > > adopting libbpf's faster string deduplication, BTF writing APIs=
,
> > > > > > module/split BTFs, etc, etc, would be much bigger PITA and/or w=
ould
> > > > > > prolong such changes. To the point that I personally wouldn't b=
other
> > > > > > with some of them at all. Distro maintainers obviously don't ca=
re
> > > > > > about such inconveniences for developers, but it's a real facto=
r in
> > > > > > determining what kind of functionality is implemented in pahole=
, so I
> > > > > > hope Arnaldo won't dismiss this without thinking about this
> > > > > > carefully.
> > >=20
> > > Hey, having tools/perf/ and tools/lib/perf, tools/lib/bpf, etc all in
> > > one place is really nice :-)
> > >=20
> > > > > You know very well that it's not about caring or not caring :-) T=
here
> > > > > are simply conflicting interests, and both sides are valid.
> > > =20
> > > > I didn't mean it in a negative way. Different priorities and intere=
sts
> > > > is a better way to put it, sure.
> > >=20
> > > I think the default should be submodules as we're still very much in
> > > flux, adding new features, etc.
> > >=20
> > > Disto maintainers can make sure they know what they're doing when mak=
ing
> > > tools use libbpf as a separate package.
> >=20
> > Sure, v3 has the option as default-disabled already, not a problem at
> > all.
>=20
> Does this mean that if I have libbpf-devel installed in my system the
> default build will _not_ link with it?
>=20
> I have libbpf-devel installed in my machine but, by default, I _don't_
> want pahole to build with it, libbpf-devel is there for other needs.
>=20

Hi,

Yes, that's correct - you have to explicitly pass -DLIBBPF_EMBEDDED=3Doff
to CMake to use libbpf-devel.

--=20
Kind regards,
Luca Boccassi

--=-7WmgMWVGIxNdoP+TCDau
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmDA6DkACgkQKGv37813
JB5vVQ//YZYDZYGmiIAxz+gZmfrB16bSzpxuv40hysM0jd4WQzcMUTLI9bHZOPrL
d/kmK2IApxZ3ZP9FTf/SAFHHawXJYgrimQ3X7DQwdOr9C48jOH9QqaD4xmnWHxAr
3QDmg3COu3zS+W/B6PX9vbmrPSz774BNMGIcK2Ip5JsCi0p5B8e+eGao5GmxONNJ
3bX6qd98Sp89GRkUkUORM+OE9VjtRBV//vr1gmMPVk9xq0UIADhVkSGZx9UMo7Mh
SGA6fYhjJ4AO5z14NZp3EhVvO7gBl6GF1BBKcCTVtP2HwP+rel6XA2v17iCm7I7y
hdfFnT3EmyNSlMgdMP7zQJ/6p3aCUyUMQMaEZ60kfAAnSHWNv4dqTS8e5skPTlMk
iXuBAcO8i11RxNHKCR6ozXz+9DD7ykjGqftuPD9RTy2LOb8Uy4o/UVPGzBVnAoMA
WgDyaJyIcZeqL86ARwG9EBjYvS5k6CaIUWy839SHGn2hSMCpRCiLg2cyXFavpQSM
XxUrpbZRwroK3aocuEJq+Px+yytHQDeN2fFJn8cfha4hTkVeVlSDf0kOeWDG9pvA
YALTx57rUzG46zWAc5TdBdIVq01u+yR29bXTfiIe4WIGkIZG7nP1czEqWIAKm3hx
jtL4ECcWhv7tlFuVyYRNnvnxQXCIaU1NlYOaCIMVEjcane3mQno=
=sptf
-----END PGP SIGNATURE-----

--=-7WmgMWVGIxNdoP+TCDau--
