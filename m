Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FE1C433E0
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Jan 2021 21:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39BF723381
	for <linux-dwarves@archiver.kernel.org>; Thu, 21 Jan 2021 21:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbhAUVXR (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Thu, 21 Jan 2021 16:23:17 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:42233 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbhAUVVe (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Thu, 21 Jan 2021 16:21:34 -0500
Received: by mail-lj1-f179.google.com with SMTP id j3so4161741ljb.9
        for <dwarves@vger.kernel.org>; Thu, 21 Jan 2021 13:20:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=/YkFiJIifV//DHauz/iJG1DU3XiDIvUpHe4FG0xs1Ak=;
        b=qRkyY8pVwTCYYNeelrRHv4XlX8HxmIBbT/OsvWNtHTIM50mKJi55B7BB4naC5rrbk6
         zae1cdMtDBf5gbBaxvS11iqr8F1xxdrcgY+X9Rkcegf2KF9N7xcZKKdh3im63QlblH+n
         ZvEmU50AuropuuhsNK2knqeVsmVgV2uuUIrhs2H7nthUix1QpeJrgimsl37p0OqVXq2L
         rrUT55MoExpYXSRYHxNp7ZVoKyQ5TSxDDlOjBwrYTdMTNZ1/NGTzlPV+e8lst6/psgJq
         Dwr2E3MTk89UsU9gmaTJZglBrCl3EGoSsZqTbtMbpOtvpDm5o+D0+yAgyqqfDux0Doif
         Cr0g==
X-Gm-Message-State: AOAM530S4paw0+E7b9HVnLZ9jDeHb0ATxcxzZBVqZJhNQul7GF1YPSjG
        NGm8tV+ZL0fCpKIQkV0jUTA=
X-Google-Smtp-Source: ABdhPJzEd9yl25zWI10ILU72/MmlXDXHn4Qrnla01zFye4LDsQAqoX5G16/n7OCPQk09eOfiep/Cmg==
X-Received: by 2002:a2e:9dc3:: with SMTP id x3mr639191ljj.326.1611263996216;
        Thu, 21 Jan 2021 13:19:56 -0800 (PST)
Received: from localhost ([2a01:4b00:f419:6f00:7a8e:ed70:5c52:ea3])
        by smtp.gmail.com with ESMTPSA id p5sm647481lfj.295.2021.01.21.13.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 13:19:54 -0800 (PST)
Message-ID: <76474a3f40605d6df334a03929764faeb6b2ce52.camel@debian.org>
Subject: Re: [PATCH dwarves] libbpf: allow to use packaged version
From:   Luca Boccassi <bluca@debian.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org
Date:   Thu, 21 Jan 2021 21:19:53 +0000
In-Reply-To: <20210121203446.GF356537@kernel.org>
References: <20210102182201.122619-1-bluca@debian.org>
         <CAEf4Bzb3jtv4+KBRNOzfERWyx_4Wh_m7xRrWcc7nAgoXi+yW-Q@mail.gmail.com>
         <9809e2cd737edb9c70954b99bdf4ce874844965b.camel@debian.org>
         <CAEf4BzarBG3HnxTiCpum9i31cTTdqDKWnHeV4zbRrUgs2V1Rpw@mail.gmail.com>
         <df6bebe13ac5d5a80563f56805dee127ad380401.camel@debian.org>
         <20210121132902.GA12699@kernel.org>
         <CAEf4BzZn_dkeWxfAB_ysWgLnAvUUcPoNi0yHbLPkiBWW9Lh5BA@mail.gmail.com>
         <20210121203446.GF356537@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-3Ee1XfC8Bjmg/i9BQp1D"
User-Agent: Evolution 3.30.5-1.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org


--=-3Ee1XfC8Bjmg/i9BQp1D
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-01-21 at 17:34 -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jan 21, 2021 at 12:02:53PM -0800, Andrii Nakryiko escreveu:
> > On Thu, Jan 21, 2021 at 5:29 AM Arnaldo Carvalho de Melo <arnaldo.melo@=
gmail.com> wrote:
> > > Em Mon, Jan 04, 2021 at 10:17:36PM +0000, Luca Boccassi escreveu:
> > > > On Mon, 2021-01-04 at 12:23 -0800, Andrii Nakryiko wrote:
> > > > > One quick and easy hack would be to put a symlink lib/include/bpf=
 ->
> > > > > lib/bpf/src into pahole repo. And add -Ilib/include to let compil=
er
> > > > > handle <bpf/*.h> properly.
> > > > Sure, that works for me if it's acceptable as a solution. Sent v3 t=
hat
> > > > implements it. Thanks for the suggestion.
> > >=20
> > > Andrii, can I have your Reviewed-by or Acked-by for v3?
> >=20
> > Well, I still think it's not good and not necessary for pahole. pahole
> > doesn't run under root. It's not a networking application open to the
> > world either. So I don't buy security arguments in this case at all.
> > So no, feel free to push this, but without my ack.
>=20
> Ok, fair enough, I applied the patch, the default behaviour is the one
> we like, so should be no problem for us :-)

Thank you!

--=20
Kind regards,
Luca Boccassi

--=-3Ee1XfC8Bjmg/i9BQp1D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE6g0RLAGYhL9yp9G8SylmgFB4UWIFAmAJ7/kACgkQSylmgFB4
UWJoLAf+OZVI6ZTHZ897ecRl74Fy2H2zOPbzRAyBw8xZ6TmlvEOHcUoikknOaGnA
qrMaBU43nHLLDfJI0GaQInGqSvEAnUTyAXmAUNJCeYM7R3MGZGEKmyRDZNNOK3bO
o+KUO7KdC4Zy6ETHmCfAwl+uvrF2WNn7lJcVW8Apk7FxzzxK0EUdL9mVid/sT4EX
39miJpJP9DmWL8hOZ8R+9PC/lW4Rom4EMNGP6cUTo1J1eEGx9kP+KTQKiIZvjpB/
8lTMFDry6XcICoElAAvq1V9hd93ILUOC/pbpjVPM7GuB2hfTnq47WwUYyCH/7nLn
xOOp0TuVJXGqEoqq6LFE9EF/hqb8tw==
=QK92
-----END PGP SIGNATURE-----

--=-3Ee1XfC8Bjmg/i9BQp1D--
