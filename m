Return-Path: <dwarves-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5395CC433EF
	for <linux-dwarves@archiver.kernel.org>; Mon, 25 Oct 2021 08:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A0E6054E
	for <linux-dwarves@archiver.kernel.org>; Mon, 25 Oct 2021 08:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhJYI4H (ORCPT
        <rfc822;linux-dwarves@archiver.kernel.org>);
        Mon, 25 Oct 2021 04:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhJYIz7 (ORCPT
        <rfc822;dwarves@vger.kernel.org>); Mon, 25 Oct 2021 04:55:59 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B00C061767
        for <dwarves@vger.kernel.org>; Mon, 25 Oct 2021 01:53:37 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g10so15375849edj.1
        for <dwarves@vger.kernel.org>; Mon, 25 Oct 2021 01:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=3aeqM6a7frSKQ5JtRWlHZsq2StUqg3WxWQ5cI4NmLbs=;
        b=hmm/NqTECjLRU22KIo86xbQOF5mXx8pN3R0BQIV7FCsW8CD1fNYaQVvHtP0YxZ4oiB
         MXGUCoRE1jpsZmF4lhFpmiyZtg0Wy7Uu29u3MC/Cb0ScuixuDlbkIjbvxAnRIpNrC2Iz
         IEFuAFbXmsc06jM5JPu6GdcGrbJ7YDst2mhtOHdqvWyU3xw3wPZ3Jj62NcjNkV/Y6lSJ
         U/spAiWh2QnjbC1arqUPTBJbpcXW3YJEDLoyX/glAQH1aVdBM+GWYvr8aybkH+bNBRWl
         yxx+dkbAKrgA6JgcJWViTqRe76cGAfNo/c57eliylZgjki9nWTirMxuWYRk3L5v4LN9F
         IciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :mime-version:content-disposition;
        bh=3aeqM6a7frSKQ5JtRWlHZsq2StUqg3WxWQ5cI4NmLbs=;
        b=zQY70lSuilLj5cuG6BoS4u8QyfYNtabgSjG0H2scRc3M7JR3MRUl3udPyD4u/VIt67
         vKAHCFSuFj8YxkQqa++pmvq+oVllOni6jQU1pmOFkTMyiJVDhKJH+muOG9FPJXeXQ2fz
         B4M29zje1w0e7PqyIh9yJyapVWy/8lO0CYmO/+6/OKUsPvhEbIXTczCueO6FZC9Pu2rt
         0tBMNyE9Hzkm1ErpVps2oAhNsnHe40KNbB6tcrN+j1Fa7rQDKMd3R8yoX5fm72MDnGXR
         3HNlj87QJc179IOsrmQaYTbP1vUncGRtp0SgiK8A7+qYvXr5F7YYczELcfHKl8sfMLjS
         9GjA==
X-Gm-Message-State: AOAM531WZUxutuclVDy79cC+gH1kucQbG7wexHEaJfXOnEkQW/IilDAE
        N28J2YtPsOz8a4Sy/hKSCPG4qf3FJWfD6+aadFg=
X-Google-Smtp-Source: ABdhPJyzQaJR0qyoNH3gNacOIeKpuC0OyFsxhQr7KDJ6RZv7qB79ZKtKuU0bfPPDSIXjTXm9Iuo0LQ==
X-Received: by 2002:a17:906:25d7:: with SMTP id n23mr21504895ejb.322.1635152013975;
        Mon, 25 Oct 2021 01:53:33 -0700 (PDT)
Received: from m4.home ([2a0b:f4c2:2::42])
        by smtp.gmail.com with ESMTPSA id s24sm8770739edy.38.2021.10.25.01.53.33
        for <dwarves@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 01:53:33 -0700 (PDT)
Sender: Domenico Andreoli <domenico.andreoli.it@gmail.com>
Received: from cavok by m4.home with local (Exim 4.94.2)
        (envelope-from <cavok@m4>)
        id 1mevjV-0001Fa-KW
        for dwarves@vger.kernel.org; Mon, 25 Oct 2021 10:53:29 +0200
Date:   Mon, 25 Oct 2021 10:53:29 +0200
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     dwarves@vger.kernel.org
Subject: [PATCH] Minor manpage fixes
Message-ID: <YXZwiaXX/jMKooQm@m4>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZVaSuO64qUlUNftt"
Content-Disposition: inline
Precedence: bulk
List-ID: <dwarves.vger.kernel.org>
X-Mailing-List: dwarves@vger.kernel.org


--ZVaSuO64qUlUNftt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
---
 man-pages/pahole.1 |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: b/man-pages/pahole.1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -100,7 +100,8 @@ or file URLs (e.g.: file://class_list.tx
 .B \-c, \-\-cacheline_size=3DSIZE
 Set cacheline size to SIZE bytes.
=20
-.TP \-\-sort
+.TP
+.B \-\-sort
 Sort the output by type name, maybe this will grow to allow sorting by oth=
er
 criteria.
=20
@@ -792,7 +793,7 @@ $ pahole ~/bin/perf --header=3Dperf_file_h
 		.size =3D 88,
 	},
 	.id =3D 13,
-	.path =3D "/machine.slice/machine-qemu\x2d1\x2drhel6.sandy.scope",
+	.path =3D "/machine.slice/machine-qemu\\x2d1\\x2drhel6.sandy.scope",
 },
 $=20
 .fi
@@ -805,7 +806,7 @@ $ pahole ~/bin/perf --header=3Dperf_file_h
 .P
 This uses ~/bin/perf to get the type definitions, the defines 'struct perf=
_file_header' as the header,
 then seeks '$header.data.offset' bytes from the start of the file, and con=
siders '$header.data.size' bytes
-worth of such records. The filter expression may omit a common prefix, in =
this case it could additonally be
+worth of such records. The filter expression may omit a common prefix, in =
this case it could additionally be
 equivalently written as both 'filter=3Dtype=3D=3DCGROUP' or the 'filter=3D=
' can also be omitted, getting as compact
 as 'type=3D=3DCGROUP':
 .P

--=20
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05

--ZVaSuO64qUlUNftt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE0znebYyV6RAN/q8htwRzp/vsqYEFAmF2cIUACgkQtwRzp/vs
qYGuCRAAvAamU8PLj+LFMYtWBR98lDDiLYNjvz2mepRxEAc0o6NR6J7/YbFek9zY
MdYxpJYiA5jlJlZ6RIjxK3cIgoZkzb3wz6nUsJJ74eKi/O4eG8iRIWCf6G2FrqH6
WM0Q222iMzwDmEJIu1WHbSWW5xd5vVz9USWp2gNECV3zJAiTWhcdmb6r5iE+ct0e
060U4GVRLGD9NCUXyc7lmzO3oZw8DleF0xnk+vs81DQ4hADcp9r6E49QZydXAI1G
wOfrw3Q+PCqT7bl8HVYjvrWmsR/Iw8AibA6tS27SrdF+hpkavYzzTo/huTt9X36I
NyaxfmlBsStdelu4nt37WWGfOzidkoKQPfHAiyzAv23w68GmkP7GFX2ZiyMc6hYf
i8dbdofMkqTGhW1VN+TrHn8DppQgnx1Kpl+omjLNOVrmI4E4mGlP1mKS743H83qX
oDl+GLRhGg1lM/nxXmYzswrwySO7J9IWMdLY0JcACJ8Fmgt8uLASfjMaumcI/fFY
2wlYSzZXzQGBIP4fIhrZgaqB6ntjJXrsoOGNZrHI5cPDT5Si3iFEpDqX37V5BPyb
P/vV9NPtZmpUBS4Ggj9pEscNI/sfqq2SDuOrHWFus27dDnnT9JuLTx8K7qtHxpLp
2TNVivzYDAoHlOn7ociyPwPu7rk6V/Kf+sPZxCobWosKZ7BQ+aM=
=0BPW
-----END PGP SIGNATURE-----

--ZVaSuO64qUlUNftt--
