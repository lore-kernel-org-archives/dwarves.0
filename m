Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BCB1096F
	for <dwarves@vger.kernel.org>; Sat, 21 Dec 2024 01:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734744218; cv=none; b=L6TUQYDMmFqw5cfR1GWNtOatVIK06m7aiVi11PtcfdTc8fivX9CtNBiSlodls7pvjKZ1vla1MAdHDLhh8sDgqy9owpuMf1we9MIj3WAAP4uWL8Mx6LlEMHfqmX4iuZkS8p6aHseJiUCeZklv+5R/Ud9wfFndSfky81qqdelXNqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734744218; c=relaxed/simple;
	bh=9VYo4eAq8RtKh26vAo1Pibss4Qs1/eQYick6zfQAWUw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSO/2TTCDeZ+pljbjobnCl+qMkr9NGjyoQnSIBDqClZ+Bb6TTabNSpDfGzBrMhkj/KEcOqNqXDJ3kCB5GTc3AIVdvsaZEWrDZW3dUwStGrQIBhk7FgoHtw5psRIkepqkbffPdrJpvWk34dpOdJkSLd/sowMpNsc8ozTjHNDR1Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=dmTci8vA; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="dmTci8vA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734744215; x=1735003415;
	bh=3HTyN4hBVyv4EZy8tnxCPMjsPI0vmWa0uqugOYJgCRM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=dmTci8vAO7YVk4oEjOA4+6RpurDxqq80l9pge9jmnm6xA+ZrcgmEeNHYKCE+bNKe6
	 0aZq1U5LwUsn9HVICtQndeB5kDIVIozPSWGHy+CnywdQsQcwnEStnKzmity6vx7lUR
	 YZSAzbT1IQE2f7JGJN+Y7IK0aLI4KOxIs6epnm9hCa5ymN9ijkbnLlDPLBtUK+cMAx
	 nCnWClxJlVVwEOMz8r9L5iu92Fdy7xuYMv/dGcQ06A5h/ExPP1Z29Z2vp4OfKgZmXC
	 vBXTsMnLTsJNHrwtsIL/RCUkMnEp3F6rRr30gU/3nxrNsNz/Nxp6EcqJ+pG/Gjl+hu
	 3zn8keq6j3gUA==
Date: Sat, 21 Dec 2024 01:23:30 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: [PATCH dwarves v3 6/8] dwarf_loader: introduce cu->id
Message-ID: <20241221012245.243845-7-ihor.solodrai@pm.me>
In-Reply-To: <20241221012245.243845-1-ihor.solodrai@pm.me>
References: <20241221012245.243845-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: c41e20e40a76bb309c60cd1a16b18dfd3a8c84e0
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add an id member to the struct cu.

An id is an index of a CU, in order they are created in dwarf_loader.c
This allows for an easy identification of a CU, particularly when they
need to be processed in order.

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 dwarf_loader.c | 4 ++++
 dwarves.h      | 1 +
 2 files changed, 5 insertions(+)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 598fde4..4f07e17 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3440,6 +3440,7 @@ struct dwarf_cus {
 =09int=09=09    build_id_len;
 =09int=09=09    error;
 =09struct dwarf_cu=09    *type_dcu;
+=09uint32_t=09nr_cus_created;
 };
=20
 struct dwarf_thread {
@@ -3472,6 +3473,9 @@ static struct dwarf_cu *dwarf_cus__create_cu(struct d=
warf_cus *dcus, Dwarf_Die *
 =09cu->priv =3D dcu;
 =09cu->dfops =3D &dwarf__ops;
=20
+=09cu->id =3D dcus->nr_cus_created;
+=09dcus->nr_cus_created++;
+
 =09return dcu;
 }
=20
diff --git a/dwarves.h b/dwarves.h
index 1cb0d62..2d08883 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -290,6 +290,7 @@ struct cu {
 =09struct ptr_table functions_table;
 =09struct ptr_table tags_table;
 =09struct rb_root=09 functions;
+=09uint32_t=09 id;
 =09const char=09 *name;
 =09char=09=09 *filename;
 =09void =09=09 *priv;
--=20
2.47.1


