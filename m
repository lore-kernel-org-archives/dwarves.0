Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C311C5F30
	for <dwarves@vger.kernel.org>; Tue, 15 Apr 2025 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709189; cv=none; b=spSu/HS98PwqYKo+/QikZdcrKL9LkOUSye/IBR9uqQBkuS2AoH5Avd7iNh0rCbPHVblsTb+4QOGzEMBJcvr3PwouHhj857rFhCFs0F9cbnEGh5QZ8PF+d2hPxLvQWHgibxKXA3QUM4mC1q1gNYbdbl5W17sJ4o0fenwuyNplEsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709189; c=relaxed/simple;
	bh=UaTqXksmK1K39uE7H1lZcomphah3YDpgzTAqN1+jS2k=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Eh+ZsfjxOaOb86VSW+CONcGZtysvOaTMHkNDdZCnm363rl/qA/zEQjnC8OxAZcA7lMe/Dsk8fEvLr11aM9Vfa8vksjrZ8yRhws4JyzVnLuvH5NM7yF21ZDMz/y99U/xzPnaPV9FvLhPMluqVePFnjEVugila/otD1D/0Rf6qWcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsmNEVQW; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsmNEVQW"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so3980985a12.1
        for <dwarves@vger.kernel.org>; Tue, 15 Apr 2025 02:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744709186; x=1745313986; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hNSUTKHDMuadPv7kNG0oqAzUzpVIGu0C+ohXTgUuy+0=;
        b=GsmNEVQWa2no0Yd3RhMKJRKn3c6hf4rlZwsAcNToryjebZ5v7AxTcW9bhEW/Avq6x+
         HPqbhdi7w1v56G6wqk1lZXgTKzEZW5ynqQ+HoROdkKJtP6a/dJysfvjX0Fr3JRKAi/Ba
         MJp3SjwirJ5DzJ015YFVIyIBXypXufL7rkcWrnsGPl1tKbaRqicHfkAfBr/nI1JzsvVw
         cFc3mElrylLhk92ByljIKXfzwnr6tle69U85gSVTpVuoyCChGCGUCfWKWuTL9li9Iwkh
         Vxw3ftVsAYm8c+r1BIYkywygo5wCLrLVa06Qa79YJbQYWt4+5VrldZFfKjRqmeAq0czd
         H9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744709186; x=1745313986;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hNSUTKHDMuadPv7kNG0oqAzUzpVIGu0C+ohXTgUuy+0=;
        b=SUeqoQCSwzCvxugvArzQc0y/hcSeUBmcUVBBNWY6CNRU4R6RMcR4zl81R0wkoVG3zd
         /MKGgd71mFuXQZ5KMtOZz5UAjlI81rMn5zZqWs7yzoD0k/VO+USAXHATncEQ4zkEfh+Q
         yVy3hSownycAyrhAKbN5H8h/eBsxOObKLjKg9dfYHl8VblrfJ9UMF6K5ldnvDreZ1hY2
         bRAfE4tB4R+2WuC/GCNSQzXB5+78lEy8qskpySMMRMDMm6dcLYP4IenOHsLHeKnV8Ywx
         UIIDgxHdZ0awttXIJ95STiAZBV89c71OLVitiiIbKJVs8DXz9r4PXmg7hEfrrz8MT4gu
         JCwg==
X-Gm-Message-State: AOJu0Yw+JL6rN9Wv2DH/u2/Q797wkepw71tj1euqnY2fKHW9F4UPQXCk
	uhI837QlaDPEDxOZbqAeHaKiu9yqiFdw92huAAyJ0dt54RyeLC71Lc4rYHbHpTfoHQ==
X-Gm-Gg: ASbGncsbUmAvgXr+cqOwB/CjWVtrG6tS4pqy4IgTqvKHFvm0BGUjG87DglekZt+xlYG
	w0kO6m5NQcoqAMqqaTFn/hunsbe2GbTOG7IhVil/7DfidrY/VAn/iXH7yAkp0tJxwA6uTRWI5KC
	KaUYA7G5vKMcPFksxPlNzmC2OQibNaDbu70MBmD9VlVflKI9CHlS2fhqBgw68RZ2cvE3GLxWwor
	DqWKJgy5ak+zPl8eoEHOO6jEiOKI5oHEYQd1j+sHDVmpuTBLG7p0Kqolp0JQbp9Gamw4Px2Cn4f
	odccvBMo
X-Google-Smtp-Source: AGHT+IHB4JzQZaQhuI+jo+vNwUeZZksu8PvsyvzMLXWecAc5s6SHDA78gUBk/1lA3F5U9CKkF3I4oQ==
X-Received: by 2002:a05:6402:5212:b0:5e5:ba77:6f42 with SMTP id 4fb4d7f45d1cf-5f45df9de11mr2262405a12.4.1744709185578;
        Tue, 15 Apr 2025 02:26:25 -0700 (PDT)
Received: from m4.lan ([2a06:1700:0:3c::1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f459a32596sm1784055a12.65.2025.04.15.02.26.24
        for <dwarves@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 02:26:24 -0700 (PDT)
Sender: Domenico Andreoli <domenico.andreoli.it@gmail.com>
Received: from cavok by m4.lan with local (Exim 4.96)
	(envelope-from <cavok@localhost>)
	id 1u4cYe-00056R-0j
	for dwarves@vger.kernel.org;
	Tue, 15 Apr 2025 11:26:20 +0200
Date: Tue, 15 Apr 2025 11:26:20 +0200
From: Domenico Andreoli <domenico.andreoli@linux.com>
To: dwarves@vger.kernel.org
Subject: Is 1.30 released?
Message-ID: <Z_4mPCCLXBCakppE@localhost>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="agIFj2vew5XuSCMM"
Content-Disposition: inline


--agIFj2vew5XuSCMM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I see from [0] that v1.30 has been tagged but I missed the announcement.
Additionally [1] does not show an updated (& signed) tarball.

Is everything in order here?

Regards,
Domenico


[0] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=3Db45=
268b74da1861577498cd5dd77103d55edc3e8
[1] https://fedorapeople.org/~acme/dwarves/

--=20
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05

--agIFj2vew5XuSCMM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEGSWGdoKrcEzTtUezikr1XMf+zOIFAmf+JjkACgkQikr1XMf+
zOKLdw//U3qK+fjx3UqBMCRLiFi+m+6RmHcf2zUXXlD6+EqQ1lz4JLo8r3TuyvIK
IASmggPaDAeMUk4MCATQaxc1zv3+h66zgtbsRLZTdxzAItU0dYw4hc4b8taFavLm
TGzV5Pzk1E8joHZKQTnzNhXD6yw63aSJIR1vQxkxQJTrcgGQjigb+qjP2z1mvQLO
qgUtoYBMb6B2PGkHnRkjgxG2cuZz6gyidTtH1NUY3KXvwyM+ZPrRBXeahOJ6+un7
F/oLvPU/YakwrbzNi0rsP7gBrb/ZmUKtmTw4pB+aslwPAGdGmnDlfAEnw175aSsg
xo2v3gz4dFZOxmrdxXCibr4YwQhKwkIPkPYDPdhTmXWVYEqqztFonzMDach98pOn
ogSsY4q1oX450nBBbVrw+Hp1nB+e58sO27aFawk/RsoqXTBk1UVuFkcX02KUt7kA
JBIbwgqB+EctzgWesMeb2miyf+I9hplHvs/RfYc3ks9Z2xk2o3QobEC+Z2EaYdVN
PBFlgZosPg04IRkXp6Mo3WC07LjI0qoE31VcdtAKlVrRBjDZ126KRchGh2Nu553R
72QkVd0RCO3mQQ95Dabmvp5O85c4/Yp2rE0oa/4sxS3JtS4X4CmCEjQH6yiFhbgL
6MSOOJicj50ea+o5MPb3V1xWck33Yiws4QK1DpwGxXYriLmUAAA=
=0WOK
-----END PGP SIGNATURE-----

--agIFj2vew5XuSCMM--
