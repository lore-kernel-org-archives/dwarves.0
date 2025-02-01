Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8571552ED
	for <dwarves@vger.kernel.org>; Sat,  1 Feb 2025 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738419961; cv=none; b=H29cweInA1jeha1tanRAOkda7LOyrsgoBW/PF0py1D4zXOTv8EqfHsdGfIDFeI2hcWUl98YaItzhVSeFaHtghY8KjsT6jun8y4EUR6rr1KK0Qf2ZbHf+e45egd8LwdkAo2TRDF9plabSMCztPcZlcq0U0qYzlZBBnAkmZH9gzK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738419961; c=relaxed/simple;
	bh=zKtyn7+pKD7Xoyuyi3Veamus1m+k2+phKni9SNZNG88=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RfmU6l6xdbOuqbvRByMEQEZh2xl0RQyn+lStZcXO7WHQSCXP4PXVsioCKdvPGR51y+RhnWfO6FpwXxh8lF0pLORBZPg/Qfd1lp24q3B4X4xei3GddPgbeWuA7H6+hLtCKq9QcZBSfKWN3577lsQA00lTXvT7gFv7aUdYfdtwbo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bwa3CRCH; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bwa3CRCH"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aab925654d9so559801666b.2
        for <dwarves@vger.kernel.org>; Sat, 01 Feb 2025 06:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738419958; x=1739024758; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8tzJ5qbJ8C8jfQV4XS6d9pc0EG4MZvNyCL1TvzLODks=;
        b=Bwa3CRCHMsQ5hqwDpWyy9gV3hFphbIMSAMSlh5WI79oG8ZZKssh4ZeVqziTXEaMxEU
         qm7BrGzQuoU3vyX++6AniVr5bt1QQgxyHwL77+pn9bI1x0M2eFIPaM/qYSj1tnasJ569
         8Mn0QkCC9hFP9ksc9RWUYN39eqZCpazBYk5hJdOAFn1XlFN7lp4wJgTbg2gD1SKXCMa5
         U2rZ0od80+Gxe+ucpM4HdfZbLVMB2PhRWIjh4bwM00DivfMgzY7OFHcD3icpuWVwu1cl
         uQa73PKUnYjfaoWdL9HqiN3Qr5+Nw0SH1dd/6S7kYZ/do/2IXfNC3fBJbGyhAx3RVzpK
         0wHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738419958; x=1739024758;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8tzJ5qbJ8C8jfQV4XS6d9pc0EG4MZvNyCL1TvzLODks=;
        b=hwkbBsCI5h0Vd/YgvmVTOieeE7/ADIJBy4D7EoYcItjMLU5EPki9Y2ggHv3rDgrHLS
         4MihiLWoy9orHxxkHOfonYzUSJIqrUXWOsgpz1M7K9Li7QUUZebK13FRtuOcH1x1Pbc3
         lz9jce+dkZIQn0h88q3iD14SF3ZX7KnkzJQP5V9t+ZSf8z4lKFhOvTihh/HVqOsJsLw2
         MHiH2bw2bKow6pXAILs8IBfvbxAZAxcib2TUjvpLpNkGNhZf5KUPbQfubfUhYvJuWM0H
         ig+KGwqVL2RbWCJlK89WkR1GCw6tE+ima+XFKGnm8mz7CVyChZGy4mvTsZb39yczJ+8G
         iKJQ==
X-Gm-Message-State: AOJu0Yz3bGMt9DeZZjqxeXoBxR/ZBgqAKWZTw9PX4QUNL75GXqPP6jKl
	2NH2XF6gjlGuuuRZxupnTsRxRFwiYzZzspQM07Xb+/ujZewgkFFfU88P2IKjVvXpfw==
X-Gm-Gg: ASbGncv8sxgLYU01D9OxPbAMnKuDMa3tEnMDZZQRTD5xEljpiPim6q9WEiUtY0q3uX4
	ylkg2nv4ddv/5Sl0DbB+xmQjPG1v3hLRsj4MLM/gKjCIRB8NIiJ5rOT1DQlkeZq/o3m/c8+VjHe
	v+ZR194VYICwhXJcuDLAnM0l9myfBpLwqNJJmEDwDLQnHEH7NnWNi81RWc6R+qLo3KWpOesFd5l
	pAwYVRJTxIi7UWi3uH8mShMcJu/NNNZVBIWqGieWzwrdENdR5So/pSK+NmyeAuoj107rrGxoEne
	nsiY+ykBrW/aZgwd9mdKto0jr1krwg==
X-Google-Smtp-Source: AGHT+IGZopWNi7mClrA4T2Xb2mHywmor7FB6KNXMEqgSleOJz9S9Ea++BqPjIHX3MJGmAO6mRgkXlw==
X-Received: by 2002:a17:906:241a:b0:ab6:d3e7:5b3e with SMTP id a640c23a62f3a-ab6d3e75c80mr1458890466b.3.1738419957946;
        Sat, 01 Feb 2025 06:25:57 -0800 (PST)
Received: from m4.lan (13.tor-exit.nothingtohide.nl. [2001:67c:6ec:203:192:42:116:210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a31624sm450196566b.142.2025.02.01.06.25.57
        for <dwarves@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 06:25:57 -0800 (PST)
Sender: Domenico Andreoli <domenico.andreoli.it@gmail.com>
Received: from cavok by m4.lan with local (Exim 4.96)
	(envelope-from <cavok@localhost>)
	id 1teERW-000wXj-36
	for dwarves@vger.kernel.org;
	Sat, 01 Feb 2025 15:25:54 +0100
Date: Sat, 1 Feb 2025 15:25:54 +0100
From: Domenico Andreoli <domenico.andreoli@linux.com>
To: dwarves@vger.kernel.org
Subject: [PATCH] Reformat a too long line.
Message-ID: <Z54u8vZh5tJBzv2V@localhost>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mx3ma+Wu604q02NM"
Content-Disposition: inline


--mx3ma+Wu604q02NM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Domenico Andreoli <domenico.andreoli@linux.com>

Reformat a too long line.

Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>

---
 man-pages/pahole.1 |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: b/man-pages/pahole.1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -304,7 +304,12 @@ Allow using all the BTF features support
=20
 .TP
 .B \-\-btf_features=3DFEATURE_LIST
-Encode BTF using the specified feature list, or specify 'default' for all =
standard features supported.  This option can be used as an alternative to =
using multiple BTF-related options, and 'default' represents the standard s=
et of BTF features that are in use for kernel BTF generation, so is useful =
as a shortcut for testing the latest set of standard features.  However ker=
nel builds will call out specific features rather than using 'default' to e=
nsure that the desired features are enabled regardless of pahole version an=
d associated 'default' set.  Supported standard features are
+Encode BTF using the specified feature list, or specify 'default' for all =
standard features
+supported.  This option can be used as an alternative to using multiple BT=
F-related options,
+and 'default' represents the standard set of BTF features that are in use =
for kernel BTF generation,
+so is useful as a shortcut for testing the latest set of standard features=
=2E  However kernel builds
+will call out specific features rather than using 'default' to ensure that=
 the desired features
+are enabled regardless of pahole version and associated 'default' set.  Su=
pported standard features are
=20
 .nf
 	encode_force       Ignore invalid symbols when encoding BTF; for example
--=20
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05

--mx3ma+Wu604q02NM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEGSWGdoKrcEzTtUezikr1XMf+zOIFAmeeLvIACgkQikr1XMf+
zOJ3+w//dIELPiDp34uIMPo8XUrj+7dyvs3wgajToEE+/ry747t3GgsmyMc7bkGJ
dyq7VbaMRC/pycgU+j0dBOJGS9pzUkRUpkUmrLlCPIBptjAtqPkoEuMcaLTU01dP
X6hl5sfOP9UxNyJLBz/PVOBU6jZynKQWdta3Ncr2EmRRNgZNlto0Qp5/r+3wC5VD
6TGjQuTVdZXq395gaXoGviroGpLQPZPLZMvdCJg3XOdzNSfXTmfdwV288nVJLgjJ
lbWWZv+PnYGrRS7mkFEuSiXSCp7p+Or25ceLkK2qrhSZlZ1w2cOK5omDtApqr3qz
O6UKOkfcLmQKkfnZpJCl+RMOyzglY/IBqdAOzOaHkoUHfzW7lISZ2NipjdAjkqG9
75BqyghIHLFMIrRIkVhL7SBdbgC3g4BWB6s4erIgGLy6u1vk8KzvF1Gp1HiQoABY
vFd7jkRHKseH/+E0QANJ3RSNuxKfyvMELDdb7Zv+xw1QvjXmfqLWQS8av1dKtJdA
ihua2dD4uXSyBnFe4dla0GhyJDQOuzv2BVMSpRrJOcu/8/pSBxqNVKwhH+6z6+pD
cQJcnJSXqxcIOEoAgkzLW7lpCBgSIYV4bAWa2tPCNMgCuZwfsCaeWiT+gQLpiA5e
kpTIB81YZIWeyDG+RnuQeXquAJKzQaXJGQHTYVM8JxuSLE/uktA=
=2JIN
-----END PGP SIGNATURE-----

--mx3ma+Wu604q02NM--
