Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477F8C433B4
	for <linux-dwarves@archiver.kernel.org>; Tue, 13 Apr 2021 13:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16E2161042
	for <linux-dwarves@archiver.kernel.org>; Tue, 13 Apr 2021 13:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhDMNmd (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 13 Apr 2021 09:42:33 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:53074 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhDMNmc (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 13 Apr 2021 09:42:32 -0400
Received: by mail-wm1-f47.google.com with SMTP id y204so7377646wmg.2
        for <dwarves@vger.kernel.org>; Tue, 13 Apr 2021 06:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=3I9/OJ9lGHycnotK9q1ufN0/X8H6Kn8tf7WcuJ5BgFA=;
        b=pOQlu7f6Q7eiHTHGB4wB5d3FAOMuC6tIBu/Qn+QJnfI/4lc5MrZTZ71qM6+bYr/7O9
         a3hGrFkhT/HqQhtJvw1dCidBhbeBDYggjhrzC8ItPL427kLgOn2Esff+XShoRnWtco3O
         vh0DZAQ+D1iRnVwLmOoRzxVkYOUoDZl6KJpTg9LZbi9cjM9ad1uC/4cofJpYg5vPIoko
         ewwIcXQhrRpVEXAY5yZZdbquRjFi3EcyZ8p5MB3N4oyTkP5tu+to9w0AdftguL6vmJmX
         LkXeiy2a8UX62abTQDjYz4IFeyOtsw9LahGgSdBqJWfvBXwnCJxRWc5hnak49vrWLYJC
         GVCA==
X-Gm-Message-State: AOAM531lJeCRPJpdd3JFCClLSnNcGodifPOTgM4pq9hj0rT16rwOoYBZ
        n2GB5BWqzSFqSNYDtMLLS88=
X-Google-Smtp-Source: ABdhPJzxKYMmgyjfJZgzfKEG39Vve9oy7HNlWYIhgACLW3duOhTpppoIag0LlmVYiRG/H7le0Uph/g==
X-Received: by 2002:a05:600c:189e:: with SMTP id x30mr108707wmp.44.1618321331753;
        Tue, 13 Apr 2021 06:42:11 -0700 (PDT)
Received: from localhost ([2a01:4b00:f419:6f00:7a8e:ed70:5c52:ea3])
        by smtp.gmail.com with ESMTPSA id b6sm21587062wrv.12.2021.04.13.06.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 06:42:10 -0700 (PDT)
Message-ID: <ca59c536e2dc66f6cb02f57d40b65702f7414ea9.camel@debian.org>
Subject: Re: [PATCH dwarves v3] libbpf: allow to use packaged version
From:   Luca Boccassi <bluca@debian.org>
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Tue, 13 Apr 2021 14:42:09 +0100
In-Reply-To: <YGPK5WxS51eVKguU@codewreck.org>
References: <20210104221622.256663-1-bluca@debian.org>
         <YGKtSXsLg4HV7eHL@codewreck.org> <YGM/x6Ohchorg2cf@kernel.org>
         <YGPK5WxS51eVKguU@codewreck.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-hY6bviASSnjj48kGY28T"
User-Agent: Evolution 3.30.5-1.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org


--=-hY6bviASSnjj48kGY28T
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-03-31 at 10:05 +0900, Dominique Martinet wrote:
> Arnaldo Carvalho de Melo wrote on Tue, Mar 30, 2021 at 12:12:07PM -0300:
> > > I can understand reverting due to other pressure to get a release out
> > > but most distros (including fedora) frown upon vendoring code so I th=
ink
> > > it would be good to have back ultimately.
> > >=20
> > > Did you or someone else (Luca?) ever take the time to look at it?
> >=20
> > Not yet, I'm right now working on it, testing patches to support clang'=
s
> > thin-LTO being used to build the kernel, so busy with it.
>=20
> Thanks
>=20
>=20
> > > I don't see what would be so different with fedora to make this
> > > unfixable, I'd be happy taking a look if nobody has so far.
> >=20
> > Please do.
>=20
> As said in my previous mail (in reply to Luca's), I cannot reproduce on
> fedora 33 so I'm not sure where to look at.
> Was the problem specific to one architecture (I only tried x86_64), or
> maybe the build dir was tainted by a previous run of cmake with another
> version of the patch? (if rpmbuild, build dir somehow included in the
> tarball?)
>=20
> Looking at the timing the libbpf version should have been identical but
> it's possible that system wasn't up to date or some other version change
> since Feb?
>=20
> Either way I would appreciate if you could confirm you still have the
> problem when you have a moment, and if so provide a bit more details on
> your setup.
>=20
>=20
> > > Would you take the patch back in if I somehow fix rpmbuild with a lib=
bpf
> > > package installed on fedora33?
> >=20
> > Sure. I had it merged, as, IIRC, it was a opt-in procedure.
>=20
> Yes, strictly opt-in and shouldn't affect developers or people building
> from git without explicitly requiring to use the system's version.
>=20

Hello Arnaldo,

Any update on this?

Thanks!

--=20
Kind regards,
Luca Boccassi

--=-hY6bviASSnjj48kGY28T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmB1n7EACgkQKGv37813
JB6e/hAAxXNcOc8pMPMh/Vnn5oXUbMH7aqX2ChS3ijVC5gRlsXEYauthchr5i1yb
yd5lPSOxH4teSa40nXhQ4KVGWpuVkeQ5QU/fG36OEs0ysXo8X0PC0pPoho44ZjLx
URLkLUXFXabGWRy7opxtbUhEqN021sDI4038x7eEMiTP0lGMwQ3n7jn043d/xIHL
crGn67tR5hQY0hco4rXBPf1AeB6xsxcwXP5L5H189oKiEVvob8G23EhShvt6fgyt
CI5djR/wVqPnrvihBkq2PH9t7c4wzLtkJDAVG8XczZcMdLYZyRM5bBA4C0HR6m5+
gYp4hn3VUFWessr0of+A8rY9tp9T0+1f+CfCnm+Vv3u/Bcr24cstf61nS/3w5p1J
YGkPzC6B8jNV/GfiB9O0FxjRQK+t8YMoJP6MNZHVtUEStmaHRVCBaIkInueFPMiH
5w03czEdvl4MfqF4jU1eo/78iEhZwZ/Uuu5b/kgFnuFXjBCXLKxR79gBNRUDh9uw
QyPZAOwm7GCPfj18XdSAb0Ao9+yONadW4mcmCt4oNIrB49w0Vqd0TcLcthlLJJO3
dFwhmm1OaXJBHBndtNwIFFo222gQr9WHbIgWiG8k9P6dIr1yVbd0dGSOkjJ670BE
mRGshIKYajFH0DvtaHktDyT9wjCDvuh5SJj7wfE3mGEFpJLsBxU=
=iVLk
-----END PGP SIGNATURE-----

--=-hY6bviASSnjj48kGY28T--
