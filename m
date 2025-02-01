Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648E6224FD
	for <dwarves@vger.kernel.org>; Sat,  1 Feb 2025 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738419917; cv=none; b=sUjA0DatvJ3zxXlm9i446Q+PZQFWqcBDi56yDDDCahgLJ08q1lroTrG5bAan8t4rJBFIjDoE1VRuWdQp/NgAdCkGX5SEXz/KkfSJobhnsVU9cFHRzuaCErOstJc8Ay6yppZCZFPNAXhW+Uqvzug3DAb7ofJvr1S2mrKC7NmxwEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738419917; c=relaxed/simple;
	bh=foVpzYD0h9ImYJS/tv+PdQzD8oKrcc1r0WUfaMKFPUo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dQEj2xLJ7ASgoD8S+eG07t12zBow04IRJOd87b270dK8IK0Bfn1pwjAL/hykB0yyY1Lgko+28WTzqnJn4rf+Kmh5o1dk1IrCTTQGCnlCw1r1ifnDIAEVbRQATROCiXtxQavZrJJIgoG1oB1EAKZ8PMyHKlAcZEogXlfFepIiC0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBjMH6oW; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBjMH6oW"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaee0b309adso519749366b.3
        for <dwarves@vger.kernel.org>; Sat, 01 Feb 2025 06:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738419914; x=1739024714; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Jm2It8fg+AyxjnR8wgMGdC6OIHoBxHZ9RIk2csmunac=;
        b=cBjMH6oWbN5DU2SS31xS/zyld8c/2Gz7zqs7ehO7k4CPtXdoG0eXbeAV3dTlkjudT5
         jruiVrpjMgsqhtlFcV8G6N0q+e+GemKbCuqdiT33auLcIoGqb3+oPK5bLzYLiVP3i2uB
         HE7qvKEdycHHywg9k1oPTfype8JIVGNFGVjXaV47aEIhWL8J5/qjLlAKjZbjRiPuEJCa
         GMx8U7t9Z5Ul1MERsgf2GHvI5T7OQ0wFxqXFjIqbPXcX2JC98UwIAgMtIWzRXeQYBNpb
         0geyic7Dr39kTSAxBAlkNGKc6Gb5Ivn5FK/p6V/t5tKO8pTaUi2Kvv82pmu8ftCKey5D
         ALZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738419914; x=1739024714;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jm2It8fg+AyxjnR8wgMGdC6OIHoBxHZ9RIk2csmunac=;
        b=FtTWVxRJOUcYbhUJpIiwbX0zyva41RTukOzFvhUumWC2jLVxbQCb9pW0Q6x1cIih5d
         +8+g7w51wNYc/AXMUvGfvuE+CJlTlG4eweiZ+9yiIR192t1A15Suzyw69kooBa68fh/z
         6QvpfzqGjWH4wfUUesZy36x/jJ/akJ07ytviKxYhs2J3+abB0gn8eIfGBqZRmmc2kH4N
         75fUrMpAHnm69mhs27W7PFFikilxKBaZzsIOzIB89F1yQ9poczorTqlML4jo6/h4CJ1y
         ey1Oo3CtATZ6/TgBVw1aOGmUFNjIycIjKiCNfHT+6TZLYjtGQrL2j9ar2z+PD0VQA7UK
         E/qA==
X-Gm-Message-State: AOJu0YyOMqMXteQ3SQoY3VtzOTt3/HU74nduPrQtzgKcGhXycZH06Yp1
	5eemPXhlZhBsvNO7eoeDu/bmw8unv6utRo/sKeXL4WVG2cyN/hGmIHPWS+VfDhfzdA==
X-Gm-Gg: ASbGnctDDn+AVuwmeXlyKotkTc9Hk7SbIKPkNDTQf9gjYgr68hV78UfAPnGJ9KU8oNS
	tVjb+lM8Dd7TnY8dekbCaRACLmHv4JOqAmbw8AlHSdbRVEVsEvxobtN4atVRBo/s/D3Gm3allVn
	SBp8PGN0TGf7bnfpEjBdiFHduyHrQCjreu9gsRUMTcRhpTnJI8qW0nNc2DpK7kFzmvswFADTt4i
	Vg53qty3ZCMIrGAz9OtKv0LDsWD5IGLnf5ykvGCH4fN5tbiWK52/IaOOxA5YM0DgU1Tvjd4Sd68
	nN8rrPswMAcWGdc5QsQflGkl83on
X-Google-Smtp-Source: AGHT+IEicCpaGJAjX43WCb4zP0dyGw3pN62oLha9J0ZdznDDDKwUjmIloyN+J4yOZEjGRz0hCLySGA==
X-Received: by 2002:a17:907:7f17:b0:ab6:eecb:41f0 with SMTP id a640c23a62f3a-ab6eecb47ecmr1115275166b.35.1738419913564;
        Sat, 01 Feb 2025 06:25:13 -0800 (PST)
Received: from m4.lan (13.tor-exit.nothingtohide.nl. [2001:67c:6ec:203:192:42:116:210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a2fa50sm447763566b.128.2025.02.01.06.25.12
        for <dwarves@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 06:25:12 -0800 (PST)
Sender: Domenico Andreoli <domenico.andreoli.it@gmail.com>
Received: from cavok by m4.lan with local (Exim 4.96)
	(envelope-from <cavok@localhost>)
	id 1teEQo-000wAs-1L
	for dwarves@vger.kernel.org;
	Sat, 01 Feb 2025 15:25:10 +0100
Date: Sat, 1 Feb 2025 15:25:10 +0100
From: Domenico Andreoli <domenico.andreoli@linux.com>
To: dwarves@vger.kernel.org
Subject: [PATCH] Fix spelling error.
Message-ID: <Z54uxjn-wDXi9LGq@localhost>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hRTTxpTdphI6doKE"
Content-Disposition: inline


--hRTTxpTdphI6doKE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Domenico Andreoli <domenico.andreoli@linux.com>

Fix spelling error.

Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>

---
 pahole.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/pahole.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/pahole.c
+++ b/pahole.c
@@ -1436,7 +1436,7 @@ static const struct argp_option pahole__
 	{
 		.name =3D "with_embedded_flexible_array",
 		.key  =3D ARGP_with_embedded_flexible_array,
-		.doc  =3D "show only structs with an embedded flexible array (contaning =
a struct that has a flexible array)",
+		.doc  =3D "show only structs with an embedded flexible array (containing=
 a struct that has a flexible array)",
 	},
 	{
 		.name =3D "expand_types",

--=20
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05

--hRTTxpTdphI6doKE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEGSWGdoKrcEzTtUezikr1XMf+zOIFAmeeLrYACgkQikr1XMf+
zOLzYw/+MRVioZvsHNAw45moK1jjxhbP9bO1R/qqC7omwK6jVIQFzGR/oYT+6O2D
N1N7WYVqWkLI5Hew1DUs6mw/IquQ2tu4/F/8u6Q3T3g5R6L2+sv8iJQs+8o5pQV5
JoP+UjLoFOlWiKVWI3ZcThAoKzK+0SNSV3KV7/qaaKOUT2x7XeT9UpS+mwpjUvNY
0eAYxuB/9amYLN6MESXzOtvIF+igfKCqFe0bE3AQCMmwOQCxhFmbJXW9+uhbBc4/
g5Om0WSmMZVTCOQLfbUuvKE1cPVoyMqMt2PTZKz3BeF3F0cBAA38oxmXo3fLfpnx
gbdaTmnAu0kPfCLd4oNkoGsKhZjbCqRkW/o2nolObosgenCR8dQWp/n72NSBXlgz
SvKzbtf7owFBVCrTwbdfxGTPUkXmHo8FwBxyZ2+M+G+ecd806o3iPfHpCDRrgi3G
t/BvDhkMW1JnSCKsLtI5U3yExZkYCMKPCyz8+ZuDphBt+DWqKgGrVikZQVfXTTCI
m/Pcz729LX2CbWng4R3zV94/B/KgnjbDahAl0k/PY8RlE0ACRnSB/Z37vbnGWw3r
n47SqKCvJCnkFgcX6hBFK/6kGoJCOhsIfu8qIWu3vHn42+Ou1fexmIdEKK6+13NY
tjzaRCT5mOLVQM1l6rrNlkZSK4bSdIyCdYEK6HZnce58wYH4CQk=
=qixd
-----END PGP SIGNATURE-----

--hRTTxpTdphI6doKE--
