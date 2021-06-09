Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DAEC48BCD
	for <linux-dwarves@archiver.kernel.org>; Wed,  9 Jun 2021 16:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB3BD613C7
	for <linux-dwarves@archiver.kernel.org>; Wed,  9 Jun 2021 16:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhFIQpd (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Wed, 9 Jun 2021 12:45:33 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:46709 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhFIQpc (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Wed, 9 Jun 2021 12:45:32 -0400
Received: by mail-wr1-f41.google.com with SMTP id a11so24351647wrt.13
        for <dwarves@vger.kernel.org>; Wed, 09 Jun 2021 09:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=58cjABfmGm7klz243CFUD6AM94AhlUV/Gg/mVOq8oPE=;
        b=dOanYnlGRCsBsui+mQPEpzeHIDXFCPb6UFvqR+zVlyRVG2zWqpxBFKsf5LvpGIJCce
         tH8328ZdE2gZ5+fSKHnWaixKqGLp1cgyPNfe3An8mIPzMAZzlhtrU89sL69NzXIzS7ok
         kpg/pGEkp/jooDVCyHHwliLMK3u480MDLM7Ugrfhel4ZUBrbLG+mk0dVSUeDdZSZDQ7v
         7CulZL4bqx3myaM/9v5aR8/rusvmHZtZBkzUSD9Qr4BH+E8lJ4kHn5UUb30d7yFYdCqS
         3+M7BpRBkBjLK0bEX0bg9CJf41bdXedtp0DtouI3Uvx/759j8oaZEjSN6LN3f05wdS6S
         1UmA==
X-Gm-Message-State: AOAM530Gd+kwVVoz0Mjg9P6mFZkf0Cyp2XclPTaeDixbYGhV7Kw9FxaZ
        ySY3IaThiaZYmRFUPgtcaU8=
X-Google-Smtp-Source: ABdhPJwPvo/TYYhs8iiqJHFv1h0i9AjsNvshJnsMA7Km4PKjxk8PYgdxJ/aZ0U8/xihxFjheH1ftoQ==
X-Received: by 2002:adf:f286:: with SMTP id k6mr771578wro.44.1623257001623;
        Wed, 09 Jun 2021 09:43:21 -0700 (PDT)
Received: from localhost ([137.220.125.106])
        by smtp.gmail.com with ESMTPSA id b62sm258201wmh.47.2021.06.09.09.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 09:43:20 -0700 (PDT)
Message-ID: <39ffc73b04ba05691a13d0a4325894a32cb9b259.camel@debian.org>
Subject: Re: [PATCH dwarves v3] libbpf: allow to use packaged version
From:   Luca Boccassi <bluca@debian.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Date:   Wed, 09 Jun 2021 17:43:19 +0100
In-Reply-To: <YMDubLyVLnVw//+g@kernel.org>
References: <20210103213201.829827-1-bluca@debian.org>
         <20210104221622.256663-1-bluca@debian.org> <YMDrhaRvsmuBRTL9@kernel.org>
         <YMDubLyVLnVw//+g@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-yrcqfq96FNeAoHtrNYYb"
User-Agent: Evolution 3.30.5-1.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org


--=-yrcqfq96FNeAoHtrNYYb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-06-09 at 13:38 -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jun 09, 2021 at 01:25:41PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Mon, Jan 04, 2021 at 10:16:22PM +0000, Luca Boccassi escreveu:
> > > Add a new CMake option, LIBBPF_EMBEDDED, to switch between the
> > > embedded version and the system version (searched via pkg-config)
> > > of libbpf. Set the embedded version as the default.
> > >=20
> > > Signed-off-by: Luca Boccassi <bluca@debian.org>
> > > ---
> > > v2: switched default to use embedded version
> > > v3: add lib/include/bpf -> lib/bpf/src symlink to allow using 'system=
'
> > >     style #include everywhere, rather than #ifdefs.
> > >     Thanks Andrii for the suggestion!
> >=20
> > I've updated it as I did a lot of refactorings, and here is why its
> > better to have it default to using the embedded libbpf:
>=20
> It is now at:
>=20
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=3Dtmp.ma=
ster&id=3Dae2581647e84948810ba209f3891359dd4540110
>=20
> After some more tests I'll move it to master.
>=20
> - Arnaldo

Fantastic, thank you very much!

If there are any issues encountered during testing, please do not
hesitate to contact myself or Dominique.

--=20
Kind regards,
Luca Boccassi

--=-yrcqfq96FNeAoHtrNYYb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmDA76cACgkQKGv37813
JB6ADRAAil70ztEe+CB0/myVezGHg6+kluXMEN2kLilsbWPkoNWvcFkbR9fxTCZ7
8lNFAZBl67ei6aveX4iXbZn56qTxAQvW06Rds8O3XafLvgvRb+QzWP8ZWzjfQO/a
USSIxqsMJ3oRipla/zp9ZCGEN0bEQHhwRzoiDZjfYTOeLqQOTuHGPgrKny11bhI5
hnPL6beCmhIzpkT1Fy+RyMwAYxQagNPi6GcN87rO0M9xPPv/EOCMH8ur0z7j7H3B
nX06fczmIXvHQipv/R1bHiEJR9rrJqb4KuxNF5//ru0kC1a20VIMfBR76tHXTGSx
UGssMpkNMHwTUdmyhMCwKl8KdY9SBm94Al7dPrHck9WumnlhdfvINxfB/qLXnGOx
EuqKfJLn7Th5T6gyy5glx1Egj/v4p2RHwlclEQDWOSFOlyEzDgD+POVvD2s/LnOW
T3csmYjAo0ST7CKgyuU4SkCYZ6KS5pi6iJ/Www6chQxv81k2leXiH+vzJXY54DuC
Fd19IRPa/UBH0fR3eVbzmiBaSZBbO/lp3dO//zC6METyITSu39K//27YM2Xz3vV+
DsvMyQDsv4AqLvFnwUIOglNBJUstWMtColN0QJoK/zkAcgzsugUDWtEPcG32KIUW
b3+It76HtL+vPt0yRo4SrT54tAQdCpQISxucy0W6UnWqsfM7usE=
=uooL
-----END PGP SIGNATURE-----

--=-yrcqfq96FNeAoHtrNYYb--
