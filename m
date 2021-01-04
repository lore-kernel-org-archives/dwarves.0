Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12A9C433E0
	for <linux-dwarves@archiver.kernel.org>; Mon,  4 Jan 2021 22:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A02F422512
	for <linux-dwarves@archiver.kernel.org>; Mon,  4 Jan 2021 22:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbhADWSV (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 4 Jan 2021 17:18:21 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:43386 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbhADWSV (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 4 Jan 2021 17:18:21 -0500
Received: by mail-wr1-f51.google.com with SMTP id y17so33647578wrr.10
        for <dwarves@vger.kernel.org>; Mon, 04 Jan 2021 14:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=Y9uwCRJi7pkwzR5ZfJD8KrG8wRB7/g5mGytbpbR/1FE=;
        b=GaIqoRFB8OGnHzfNJbY7DYsSle+M60xLc1zpFI7iWvedoxW5HDDWIUVijZrjESwcyD
         9D40eohIg9p185EwRhWhKKE+RCdm9hnikC2wTCkY5qm3aAaucHN7UeLk0UElvQGlGSR9
         Iaa45kF2mxe4gnOZb9WE8ESH47tb1oqcyAEI1BUgbnl0QOwarkiVhgDt0oNVq9x7dbQ6
         Yrjw2i1pjNIwmZBcIsmOD48PB4Pe2fGZVy1AQY7a5xAMcdyHlz4a287SgfeYITMfL75A
         67G31ycuHXZ+VZle5ciwkszSm1I0D0Ysjk8fhimpQtkiPRHln8wU/ib+FXnyuImAJ9Gm
         0wuw==
X-Gm-Message-State: AOAM5331p6Eg4CfnE18KK2J/+K8dTTeceDisnuLztcARkwwCEhQGbFQr
        RLkWaUr9j7Iolkt+OQgCDOA=
X-Google-Smtp-Source: ABdhPJw5bJ1C4XOjA9jTh/tuLpGh9mLO92jgXP4P17hKXMuuuYA6yJQX1pe+CMl4HoGT6EEuEV1ekQ==
X-Received: by 2002:a05:6000:90:: with SMTP id m16mr82377674wrx.165.1609798658145;
        Mon, 04 Jan 2021 14:17:38 -0800 (PST)
Received: from localhost ([2a01:4b00:f419:6f00:e2db:6a88:4676:d01b])
        by smtp.gmail.com with ESMTPSA id y68sm1223151wmc.0.2021.01.04.14.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 14:17:37 -0800 (PST)
Message-ID: <df6bebe13ac5d5a80563f56805dee127ad380401.camel@debian.org>
Subject: Re: [PATCH dwarves] libbpf: allow to use packaged version
From:   Luca Boccassi <bluca@debian.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     dwarves@vger.kernel.org
Date:   Mon, 04 Jan 2021 22:17:36 +0000
In-Reply-To: <CAEf4BzarBG3HnxTiCpum9i31cTTdqDKWnHeV4zbRrUgs2V1Rpw@mail.gmail.com>
References: <20210102182201.122619-1-bluca@debian.org>
         <CAEf4Bzb3jtv4+KBRNOzfERWyx_4Wh_m7xRrWcc7nAgoXi+yW-Q@mail.gmail.com>
         <9809e2cd737edb9c70954b99bdf4ce874844965b.camel@debian.org>
         <CAEf4BzarBG3HnxTiCpum9i31cTTdqDKWnHeV4zbRrUgs2V1Rpw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-g5Bxur/M5KwU+7Wd9I92"
User-Agent: Evolution 3.38.2-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org


--=-g5Bxur/M5KwU+7Wd9I92
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2021-01-04 at 12:23 -0800, Andrii Nakryiko wrote:
> On Sun, Jan 3, 2021 at 1:30 PM Luca Boccassi <bluca@debian.org>
> wrote:
> >=20
> > On Sun, 2021-01-03 at 11:10 -0800, Andrii Nakryiko wrote:
> > > On Sat, Jan 2, 2021 at 10:25 AM Luca Boccassi <bluca@debian.org>
> > > wrote:
> > > >=20
> > > > Add a new CMake option, LIBBPF_EMBEDDED, to switch between the
> > > > embedded version and the system version (searched via pkg-
> > > > config)
> > > > of libbpf. Set the system version as the default.
> > > >=20
> > >=20
> > > There's been a lot of arguments about libbpf as a submodule, so I
> > > don't think we need to go about pros and cons again, but I just
> > > wanted
> > > to cast my vote against doing this at all. Having pahole built
> > > with
> > > libbpf statically (only) was a great thing for me so far with
> > > iterating quickly and adopting new APIs without overcomplicating
> > > the
> > > source code with all sorts of feature detection code. Without it,
> > > adopting libbpf's faster string deduplication, BTF writing APIs,
> > > module/split BTFs, etc, etc, would be much bigger PITA and/or
> > > would
> > > prolong such changes. To the point that I personally wouldn't
> > > bother
> > > with some of them at all. Distro maintainers obviously don't care
> > > about such inconveniences for developers, but it's a real factor
> > > in
> > > determining what kind of functionality is implemented in pahole,
> > > so I
> > > hope Arnaldo won't dismiss this without thinking about this
> > > carefully.
> >=20
> > You know very well that it's not about caring or not caring :-)
> > There
> > are simply conflicting interests, and both sides are valid.
>=20
> I didn't mean it in a negative way. Different priorities and
> interests
> is a better way to put it, sure.
>=20
> > I believe we can have best of both worlds with this. The user who
> > does
> > the build is empowered to choose what they prefer. The additional
> > cost
> > would be to set the correct minimum version required in the CMake
> > file,
> > as it's done with other dependencies, including CMake itself.
> >=20
> > > > Signed-off-by: Luca Boccassi <bluca@debian.org>
> > > > ---
> > > > Note: I can switch the default around if you prefer.
> > >=20
> > > With BCC you seem to go with the default preserving existing
> > > behavior
> > > (using libbpf from a submodule), so if we do this, I think the
> > > default
> > > should be flipped.
> >=20
> > Sure, sent v2.
> >=20
> > > >=20
> > > > =C2=A0CMakeLists.txt=C2=A0=C2=A0 | 49 +++++++++++++++++++++++++++++=
++++++-----
> > > > ----
> > > > ----
> > > > =C2=A0btf_encoder.c=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++++
> > > > =C2=A0btf_loader.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++++
> > > > =C2=A0libbtf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 6 ++++++
> > > > =C2=A0libbtf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 4 ++++
> > > > =C2=A0pahole.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 4 ++++
> > > > =C2=A0pahole_strings.h |=C2=A0 4 ++++
> > > > =C2=A0strings.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4=
 ++++
> > > > =C2=A08 files changed, 67 insertions(+), 13 deletions(-)
> > > >=20
> > >=20
> > > [...]
> > >=20
> > > > =C2=A0#include "dutil.h"
> > > > +#ifdef LIBBPF_FOUND
> > > > +#include <bpf/libbpf.h>
> > > > +#else
> > > > =C2=A0#include "lib/bpf/src/libbpf.h"
> > > > +#endif
> > >=20
> > > this is horrible, are you sure there is no way to make
> > > <bpf/libbpf.h>
> > > work for both cases?
> >=20
> > It really is, but unfortunately I don't see other ways that are not
> > just as horrible. Suggestions welcome. The only thing I can think
> > of,
> > is if libbpf used the same directory hierarchy in-tree as it does
> > in
> > the installed tree. Ie: move those headers from libbpf/src/foo.h to
> > libbpf/include/bpf/foo.h. Then we would just have the -
> > Ilib/bpf/include
> > in CPPFLAGS for the embedded build defined in the CMake files, and
> > the
> > sources would only use the "system" includes everywhere, without
> > ifdeffery.
> >=20
> > Given you maintain libbpf, would that be something you'd accept?
> > It's
> > quite a common pattern for libraries to store their public headers
> > in a
> > separate directory in the git tree, after all.
>=20
> It's quite risky, as there are plenty of (sometimes private)
> integrations that assume such a layout of libbpf, so we'll be
> breaking
> them badly. Makefile-based projects do `make install_headers` to put
> *only exported* headers into the desired location. I'm not sure
> what's
> the best way to achieve the same with Cmake, though.
>=20
> One quick and easy hack would be to put a symlink lib/include/bpf ->
> lib/bpf/src into pahole repo. And add -Ilib/include to let compiler
> handle <bpf/*.h> properly.

Sure, that works for me if it's acceptable as a solution. Sent v3 that
implements it. Thanks for the suggestion.

--=20
Kind regards,
Luca Boccassi

--=-g5Bxur/M5KwU+7Wd9I92
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE6g0RLAGYhL9yp9G8SylmgFB4UWIFAl/zlAAACgkQSylmgFB4
UWK+2wf+NboqnX87k5R0sVerQnnkFwL4CySBQSST5RGaacJ47iyk4HXnYoGumCNh
7hVPtq+FNdczCo7aMNqyDk7k7QWlx89DfExptWcSAVPlWLGQgv7/IbNdHEK7Eh3n
b4949A5o8aRApXNhSwlfsKoXepWSeztSmmmJKMLUU4aQb0oSFazde8s9N2oaD2fQ
EnJc7hFzZBQOyhaoI3tUjtVZuNhUsqzDBIG2ZXxLNkYfW1aR8iCzfQYNa5WIZOM2
DWRy8NS4wuQxhbwFg/o9WYBOOI1q9SdJ1j8QLPHJi402t7BRRcI3drjzVMoHmMip
BQ/gnrZAHMoPR3H4iY7NbtZywciCQQ==
=OHws
-----END PGP SIGNATURE-----

--=-g5Bxur/M5KwU+7Wd9I92--
