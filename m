Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0AEC433E0
	for <linux-dwarves@archiver.kernel.org>; Sun,  3 Jan 2021 21:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 485B320784
	for <linux-dwarves@archiver.kernel.org>; Sun,  3 Jan 2021 21:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbhACVas (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Sun, 3 Jan 2021 16:30:48 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:36391 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbhACVar (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Sun, 3 Jan 2021 16:30:47 -0500
Received: by mail-wm1-f54.google.com with SMTP id y23so16823116wmi.1
        for <dwarves@vger.kernel.org>; Sun, 03 Jan 2021 13:30:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=FXSMcRUjDgk9FSOsnzEQZXOI8PvYOtHjiNE/QQdWvds=;
        b=g6XgxkUax+4Tng+gNsl0BvWIZi0yR3vrXDM7CrWMgXdY1LE0cqz5FK2NN8BAhO9xgB
         7eztMlj5Mo3tLp/10/gkRtBwq61U40p8+IyywGMA8VSKP5xWE8DEhxuL6Ol7EaxKywwL
         bb8vCGzpRHUnzTNc+yhafZENt39COxGHy+9ntEFyicW30xb8nrtEef4u1b8yZbE2FMYB
         2eZ3uAD0WfeaPOteMSsl5JS5HgnpmN8bJ8M8SFE2tD4O/p+fra0StqJ1+hgJXlv3EfcW
         GeDv39LIZKqgCXwnA6AouEJf+ZoYvZ66QccEoq6ImOkOgdvT4DwsUuwp9paQtSplQO/w
         coBA==
X-Gm-Message-State: AOAM532ikAq47lIfyAmn54joBIukrbf8CB1DBWF9KPbRCRfN3dYbFN+y
        M2Lgql3cHtXoHePyt1Gf2ss=
X-Google-Smtp-Source: ABdhPJynJA2jhf6UHeAjwDc9VADXQoFgCj23a6Ptfi/hgzxJRFupcxifrorvxxWoGQd/Rwu9Bv8JmQ==
X-Received: by 2002:a1c:1d85:: with SMTP id d127mr23773667wmd.39.1609709405457;
        Sun, 03 Jan 2021 13:30:05 -0800 (PST)
Received: from localhost ([2a01:4b00:f419:6f00:e2db:6a88:4676:d01b])
        by smtp.gmail.com with ESMTPSA id j59sm92314150wrj.13.2021.01.03.13.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 13:30:04 -0800 (PST)
Message-ID: <9809e2cd737edb9c70954b99bdf4ce874844965b.camel@debian.org>
Subject: Re: [PATCH dwarves] libbpf: allow to use packaged version
From:   Luca Boccassi <bluca@debian.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     dwarves@vger.kernel.org
Date:   Sun, 03 Jan 2021 21:30:03 +0000
In-Reply-To: <CAEf4Bzb3jtv4+KBRNOzfERWyx_4Wh_m7xRrWcc7nAgoXi+yW-Q@mail.gmail.com>
References: <20210102182201.122619-1-bluca@debian.org>
         <CAEf4Bzb3jtv4+KBRNOzfERWyx_4Wh_m7xRrWcc7nAgoXi+yW-Q@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-AlxpC5zB5J8Uo+HYec3U"
User-Agent: Evolution 3.38.2-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org


--=-AlxpC5zB5J8Uo+HYec3U
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2021-01-03 at 11:10 -0800, Andrii Nakryiko wrote:
> On Sat, Jan 2, 2021 at 10:25 AM Luca Boccassi <bluca@debian.org>
> wrote:
> >=20
> > Add a new CMake option, LIBBPF_EMBEDDED, to switch between the
> > embedded version and the system version (searched via pkg-config)
> > of libbpf. Set the system version as the default.
> >=20
>=20
> There's been a lot of arguments about libbpf as a submodule, so I
> don't think we need to go about pros and cons again, but I just
> wanted
> to cast my vote against doing this at all. Having pahole built with
> libbpf statically (only) was a great thing for me so far with
> iterating quickly and adopting new APIs without overcomplicating the
> source code with all sorts of feature detection code. Without it,
> adopting libbpf's faster string deduplication, BTF writing APIs,
> module/split BTFs, etc, etc, would be much bigger PITA and/or would
> prolong such changes. To the point that I personally wouldn't bother
> with some of them at all. Distro maintainers obviously don't care
> about such inconveniences for developers, but it's a real factor in
> determining what kind of functionality is implemented in pahole, so I
> hope Arnaldo won't dismiss this without thinking about this
> carefully.

You know very well that it's not about caring or not caring :-) There
are simply conflicting interests, and both sides are valid.
I believe we can have best of both worlds with this. The user who does
the build is empowered to choose what they prefer. The additional cost
would be to set the correct minimum version required in the CMake file,
as it's done with other dependencies, including CMake itself.

> > Signed-off-by: Luca Boccassi <bluca@debian.org>
> > ---
> > Note: I can switch the default around if you prefer.
>=20
> With BCC you seem to go with the default preserving existing behavior
> (using libbpf from a submodule), so if we do this, I think the
> default
> should be flipped.

Sure, sent v2.

> >=20
> > =C2=A0CMakeLists.txt=C2=A0=C2=A0 | 49 +++++++++++++++++++++++++++++++++=
++---------
> > ----
> > =C2=A0btf_encoder.c=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++++
> > =C2=A0btf_loader.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++++
> > =C2=A0libbtf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
6 ++++++
> > =C2=A0libbtf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
4 ++++
> > =C2=A0pahole.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
4 ++++
> > =C2=A0pahole_strings.h |=C2=A0 4 ++++
> > =C2=A0strings.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +++=
+
> > =C2=A08 files changed, 67 insertions(+), 13 deletions(-)
> >=20
>=20
> [...]
>=20
> > =C2=A0#include "dutil.h"
> > +#ifdef LIBBPF_FOUND
> > +#include <bpf/libbpf.h>
> > +#else
> > =C2=A0#include "lib/bpf/src/libbpf.h"
> > +#endif
>=20
> this is horrible, are you sure there is no way to make <bpf/libbpf.h>
> work for both cases?

It really is, but unfortunately I don't see other ways that are not
just as horrible. Suggestions welcome. The only thing I can think of,
is if libbpf used the same directory hierarchy in-tree as it does in
the installed tree. Ie: move those headers from libbpf/src/foo.h to
libbpf/include/bpf/foo.h. Then we would just have the -Ilib/bpf/include
in CPPFLAGS for the embedded build defined in the CMake files, and the
sources would only use the "system" includes everywhere, without
ifdeffery.

Given you maintain libbpf, would that be something you'd accept? It's
quite a common pattern for libraries to store their public headers in a
separate directory in the git tree, after all.

--=20
Kind regards,
Luca Boccassi

--=-AlxpC5zB5J8Uo+HYec3U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE6g0RLAGYhL9yp9G8SylmgFB4UWIFAl/yN1sACgkQSylmgFB4
UWKHrAf7Bfbgj19vfkNLNas/w4ZmDSaG4q63tWsAVfN3et5uzhPHbnQh6WDUZlNl
OFCd0vq7hC2z6D50DM7feZLwMe1VVYVVLJ4QBtGjYUSRD550FUL1cTzPD+4FjeUN
NhzCX7NLkhMkjFjZLo8COaThE3cK3mGhzuwFP8yr1dangeWMQUh52auwXm4oYwk0
ktTtex7dkoP9YPn+YutOhnZ3zXWsyfjGRIQZimjKS+ygeChB1C4HWAx/HT9MwTT8
Z24xja/uycV7uzleDYRDUmc2uL/kpq7ccB0BnRzH4wU+h0Zqw16lY/GVA5TK8Ol1
IBcY9iy06mRoBgoc/HKENlwMqwFGrQ==
=p/oO
-----END PGP SIGNATURE-----

--=-AlxpC5zB5J8Uo+HYec3U--
