Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F1DC433C1
	for <linux-dwarves@archiver.kernel.org>; Tue, 30 Mar 2021 10:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A0E061985
	for <linux-dwarves@archiver.kernel.org>; Tue, 30 Mar 2021 10:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhC3Kue (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Tue, 30 Mar 2021 06:50:34 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:39653 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhC3KuX (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Tue, 30 Mar 2021 06:50:23 -0400
Received: by mail-wr1-f48.google.com with SMTP id e18so15765682wrt.6
        for <dwarves@vger.kernel.org>; Tue, 30 Mar 2021 03:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=j5tv5i4YjO4q0yxyzOXnWrIqr1ZLbwL45Lg7wCUmhXo=;
        b=M+q600F109lAf/YzJWECEIpiUFygkE8J+nFCzE1JbHhhhHAiVN1seQhoPpPY3oPCPc
         o5CU/8qU9/enMG/Olt8SOctRZsoMUWJ+Zv5MmHhmiK57VO4LXU6+OYStl7c7WR6BvvGn
         j71glQVrMXe6V9HrNkHLi/Qr/+5hGRa+bY/SDqzgiv12cPVl9B7Ce68OF1yQAT7IBm0C
         r4OO2D/bUrABoeQ1M3S+gx0Oxfdm4E+X3BwTLd5m+kJyFVP2VPumWpSaATDEboxkQXhV
         Qtyd8l95bGGlFFprFEF/h71f5/z0wL70Gp4WidyKlnQRS3aojMD666Lgoc3JBa16w/gK
         d3nA==
X-Gm-Message-State: AOAM5309dCnQzveR+nDfONOTgoX7RQLBC9gCxILOqvUIer9Vbviz0I3R
        Wi2z3vpggkanyon9EEKGg/c=
X-Google-Smtp-Source: ABdhPJwTntIWOm2ekj4ZHNjPLzv+wztOCCeNM4DxzlDIkrUvfH1rUGG6gMDLMeQu9PGNNmegjOAvhg==
X-Received: by 2002:a05:6000:10d:: with SMTP id o13mr2310783wrx.106.1617101422645;
        Tue, 30 Mar 2021 03:50:22 -0700 (PDT)
Received: from localhost ([2a01:4b00:f419:6f00:7a8e:ed70:5c52:ea3])
        by smtp.gmail.com with ESMTPSA id c8sm38378131wrd.55.2021.03.30.03.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 03:50:15 -0700 (PDT)
Message-ID: <8cefd2c1cf59c1618365a738677afcb2ab6acd01.camel@debian.org>
Subject: Re: [PATCH dwarves v3] libbpf: allow to use packaged version
From:   Luca Boccassi <bluca@debian.org>
To:     Dominique Martinet <asmadeus@codewreck.org>,
        dwarves@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Tue, 30 Mar 2021 11:50:13 +0100
In-Reply-To: <YGKtSXsLg4HV7eHL@codewreck.org>
References: <YGKtSXsLg4HV7eHL@codewreck.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-HEQqB7Vtis8cm08pGl/Y"
User-Agent: Evolution 3.30.5-1.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org


--=-HEQqB7Vtis8cm08pGl/Y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2021-03-30 at 13:47 +0900, Dominique Martinet wrote:
> Hi,
>=20
> I see this commit has been reverted just before the 1.20 release in Feb:
> ---
> Revert "libbpf: allow to use packaged version"
>=20
> This reverts commit 82749180b23d3c9c060108bc290ae26507fc324e.
>=20
> Getting in the way of releasing 1.20, breaking the build of a dwarves
> rpm when a libbpf package is installed in a fedora 33 system:
>=20
> In file included from /home/acme/rpmbuild/BUILD/dwarves-1.20/strings.c:7:
> /home/acme/rpmbuild/BUILD/dwarves-1.20/pahole_strings.h:9:10: fatal error=
: bpf/btf.h: No such file or directory
>     9 | #include <bpf/btf.h>
>       |          ^~~~~~~~~~~
>=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>=20
> I can understand reverting due to other pressure to get a release out
> but most distros (including fedora) frown upon vendoring code so I think
> it would be good to have back ultimately.
>=20
> Did you or someone else (Luca?) ever take the time to look at it?
>=20
> I don't see what would be so different with fedora to make this
> unfixable, I'd be happy taking a look if nobody has so far.
> Would you take the patch back in if I somehow fix rpmbuild with a libbpf
> package installed on fedora33?
>=20
>=20
> Thanks,

Hi,

I did not realise it was reverted (if I was pinged and I missed it:
sorry about that) - what was the issue precisely? This has been used on
Ubuntu and Debian for a few months now, no problems reported.
Happy to have a look too if needed.

--=20
Kind regards,
Luca Boccassi

--=-HEQqB7Vtis8cm08pGl/Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmBjAmUACgkQKGv37813
JB6JXhAAwOKFtwmSeQknjY1SK8Q6Do9Xesak0MBt2t6wcL8WwvUvfxkYHR8/bBdY
KvFuph+4QAaCCct0D0pYG4bkPqYEx3CPjgADpJRrRarmBtP8rlQfel2akkQ9NJEJ
VW3eKRb+7+dpJGbty56lKA5Jst6Aft7zhe9lWvXqUus6FVXoyF7+/Wgoi5GgXnWj
FktSaeLGtRWRiFhGJwMt53mNibcazb6NGRZgLMgPNvxBDgUdoTFwpVuLvorQvO/N
McWwKMm3HuftULcYTj0C6eYBRR9ZZL/zpl07XkslqS35YNvffqoHc11OA14KC5Ru
RlfJmYXMMqrL7rV0iLNodYFXDDDzIzmeUZ2YxDe8BcIktI0Y3lwk+pFXQwawsXw3
ojhugzxspHz1FsLAkjf9IECsHdU+o9XLx8DI74fT05lM8NccVix0QBoMZgg8LYIZ
eG+LoOJ/pez4HlXcBh1BAcR/feQC/FtECbgkwz12tWxjypnNLiqimT0IdhKTDubb
b1cz1NDkmyvpGs7ltmhybeqjUmj5UE450+qzR4OtRcL1EMGk+0sBRJZl+sVxvUCt
5OxhTN3b9PgmDZenvwO0o9ibzoiWIe9BDG/DtRsbKyNE6Zd0AVMXij7RqLN2JKhq
feLSH8R8yQSUOl3HHHFLSzG3uRPm6rNio+HCYXbVfsW9QiM2g3A=
=FcXO
-----END PGP SIGNATURE-----

--=-HEQqB7Vtis8cm08pGl/Y--
