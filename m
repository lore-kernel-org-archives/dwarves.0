Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439D5C43461
	for <linux-dwarves@archiver.kernel.org>; Tue, 18 May 2021 14:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2667961209
	for <linux-dwarves@archiver.kernel.org>; Tue, 18 May 2021 14:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349798AbhEROJO (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 18 May 2021 10:09:14 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:41675 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349797AbhEROJM (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 18 May 2021 10:09:12 -0400
Received: by mail-wr1-f44.google.com with SMTP id d11so10377813wrw.8
        for <dwarves@vger.kernel.org>; Tue, 18 May 2021 07:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=Lyn+GgfBHEIpdulB3Ve3nVUh8ILqBghcjEz9FXoWM8E=;
        b=bAkasyXTLAojS+ly3/sfbwqdapislN9p1WG4JHOSh08ce4Amslz9O1sdFHi19Ub0un
         2CkiohqGYS8XEj7IwVrJnZR3/zVTBausklNUC6SH918OJCOcD/QFPGUvMGT+y0bPXHsj
         3+qIz5sHcD8jtLro24gVxYhe/Y254CPNeWfez1fffcb9V+aqJvBDJuEpZmi8MYXsyFuu
         Oo3Qw/pAlzv/UK10n0xnRr5AKY/Du46i0a7plPkG0wL1geDa18Klj+1/IMdckFWLBRp+
         S30McyUvRXr+aHGJfgMBTxaIuuJbP/of8NEGDgSOaHQwzwrAM8GRLp+3kQWJcnbPaya3
         iMTQ==
X-Gm-Message-State: AOAM530yYFlVxSG1ehpsl7mSPaCHx58zb8EHWlzyRo/NpAmu6fxqeI5z
        XCAYjGPi2BfHNWUaO6UA9Kk=
X-Google-Smtp-Source: ABdhPJxf5XfiXCALZqBxOBuaDEERVCN8zyMiMF9XRL5cn+XULzFlYk5hXsnXkqzt0ACaNuHiYtB/nA==
X-Received: by 2002:a5d:500b:: with SMTP id e11mr7274890wrt.209.1621346873323;
        Tue, 18 May 2021 07:07:53 -0700 (PDT)
Received: from localhost ([2a01:4b00:f41a:3600:360b:9754:2e3a:c344])
        by smtp.gmail.com with ESMTPSA id y2sm3230228wmq.45.2021.05.18.07.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 07:07:52 -0700 (PDT)
Message-ID: <056f75e00fe796e3a9d634ec03afdf0a416fd9a0.camel@debian.org>
Subject: Re: [PATCH dwarves v3] libbpf: allow to use packaged version
From:   Luca Boccassi <bluca@debian.org>
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     dwarves@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Tue, 18 May 2021 15:07:50 +0100
In-Reply-To: <ca59c536e2dc66f6cb02f57d40b65702f7414ea9.camel@debian.org>
References: <20210104221622.256663-1-bluca@debian.org>
         <YGKtSXsLg4HV7eHL@codewreck.org> <YGM/x6Ohchorg2cf@kernel.org>
         <YGPK5WxS51eVKguU@codewreck.org>
         <ca59c536e2dc66f6cb02f57d40b65702f7414ea9.camel@debian.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-7cNmpc9y6m8yH9KN906l"
User-Agent: Evolution 3.30.5-1.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org


--=-7cNmpc9y6m8yH9KN906l
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2021-04-13 at 14:42 +0100, Luca Boccassi wrote:
> On Wed, 2021-03-31 at 10:05 +0900, Dominique Martinet wrote:
> > Arnaldo Carvalho de Melo wrote on Tue, Mar 30, 2021 at 12:12:07PM -0300=
:
> > > > I can understand reverting due to other pressure to get a release o=
ut
> > > > but most distros (including fedora) frown upon vendoring code so I =
think
> > > > it would be good to have back ultimately.
> > > >=20
> > > > Did you or someone else (Luca?) ever take the time to look at it?
> > >=20
> > > Not yet, I'm right now working on it, testing patches to support clan=
g's
> > > thin-LTO being used to build the kernel, so busy with it.
> >=20
> > Thanks
> >=20
> >=20
> > > > I don't see what would be so different with fedora to make this
> > > > unfixable, I'd be happy taking a look if nobody has so far.
> > >=20
> > > Please do.
> >=20
> > As said in my previous mail (in reply to Luca's), I cannot reproduce on
> > fedora 33 so I'm not sure where to look at.
> > Was the problem specific to one architecture (I only tried x86_64), or
> > maybe the build dir was tainted by a previous run of cmake with another
> > version of the patch? (if rpmbuild, build dir somehow included in the
> > tarball?)
> >=20
> > Looking at the timing the libbpf version should have been identical but
> > it's possible that system wasn't up to date or some other version chang=
e
> > since Feb?
> >=20
> > Either way I would appreciate if you could confirm you still have the
> > problem when you have a moment, and if so provide a bit more details on
> > your setup.
> >=20
> >=20
> > > > Would you take the patch back in if I somehow fix rpmbuild with a l=
ibbpf
> > > > package installed on fedora33?
> > >=20
> > > Sure. I had it merged, as, IIRC, it was a opt-in procedure.
> >=20
> > Yes, strictly opt-in and shouldn't affect developers or people building
> > from git without explicitly requiring to use the system's version.
> >=20
>=20
> Hello Arnaldo,
>=20
> Any update on this?
>=20
> Thanks!

Gentle ping. Anything we can do to help?

--=20
Kind regards,
Luca Boccassi

--=-7cNmpc9y6m8yH9KN906l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmCjyjYACgkQKGv37813
JB7efQ/8CBJtMkvtRVeeP9x8bxeNZAsvczKnDaFTcMZ1sEvFj/WmDN+rYVRDeLSF
5kDFHIF9gMcU/FzsdFaM8cW5cjJaRHspJM1gLPMPfKa+amR/xHgzXjBX/Lc1CAln
wn2dYstVVMHrM9vi5OAQ5PUQlm3bqQ51FtFP6WEkr+RL43muy8kg+ZY3PVUFVZmB
ogAzqLxmDvmL5PEwddQNv/uZuCN/IdVa1u9w7qXQuO0BIT7lJMuupEBlGBNcxJbJ
H/GGqf7wIDandzb7QVdl21dNnlCkkhFqftHlK8RCaBt7CzZ6OaJ6F7OH1+8HCQj4
iIg4gEeyMz5B/umn6+BDu49ffKY3qq1kqMQZoQB3zAGLcGLqS6XGo7SBGW57zlA6
408s626jiRp4SnLznWHcGcThiYvuTirUcKz5iJgq41V86z+OW6tks/DHbg7+4znc
BkC4O14PYwlsODSBK+2bwUyfetIQONENNMx2+fDb/nE45spiKdL1HBcqOLes3tuO
2Ib3KO94SumnUmfYOzrZ3YDU+KM/esQUOypeXO+jwZIflM7qsUYjhjXr7K9foqx6
8JC2fqg9hUDWI/2cF9DYoyCByF+ol3yiZyRKawXU4VrMNLmw8VzV4gcgnN4Hw8mU
2+vIZUjyrN63rUgLZEiYXxOButdID06WkcmGlunK9TR9RRY1ukA=
=JF4k
-----END PGP SIGNATURE-----

--=-7cNmpc9y6m8yH9KN906l--
