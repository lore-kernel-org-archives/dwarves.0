Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08C21990C3
	for <dwarves@vger.kernel.org>; Fri, 13 Dec 2024 22:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734129456; cv=none; b=l/tJ6WKlbW2E5VwiayBsLZmCs5rhKz925yOa4CtzXklzGpF8qa94ocUQRBiRhekXaLK6h+ToiTLm6kSP3HOE5UotUdE8u7Pfnue2OACS1Are6VnB8DACe07c7OQhwLNuJP2A46ZsEkhfudrDPB0OYxSZH23tjjzl0rrEP2k6SQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734129456; c=relaxed/simple;
	bh=0VssLWOk2UU7fS00MwCYkZbz7h/Lqlg1EFIW4Yyanso=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n6GkMa0bpksR9eEvBZlrZWyigDOswvOspqONqVhzRnHKA0VhF67HcE/jNI1S1ChhAB+jtxgvd26NhFFEHbdbojzwHSJLhGd/MVTCmK0Y7JTHR1/DVI1Z1gzQGrU82W26dUbrAhNp3npzSsnBvNNsSu5+UHG+cSi+0MOxFS8FePU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=ivsLAQGh; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="ivsLAQGh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1734129453; x=1734388653;
	bh=5ymrtYpPn1cqLqx3araHNA7CvF23grHAah8LsflyIUs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=ivsLAQGhaTzt3Gdmp5lYLQsM+8cbRndE5t6ZUZhlHYcP30ZVAd6g7mgD62OOGvrUD
	 n2iNCx5/u+8fAOsgqsxjvzuDwjMecan+7ljSGf5h5gyoVkw7f04wzRy3ZLBXUaPn4b
	 drtOMAVQxPEhWDgbQUsNztCv7bH/braXlkGyGXm+BvJzgXYBwMVRx3/qw9OGBTpGkc
	 I/qVJcobksaFWDXYAyuUH9NJcktg/WobyMEuzs1HgvyhtxJnOBFTCDK05Pncf85BeK
	 F7XPcIshsnuvZ+IyGQHL+w07RMdA3PqT7uRgw8wWGNjEX7s6CuKClq2f71uDF3lkiw
	 dZvkwMteUtn/w==
Date: Fri, 13 Dec 2024 22:37:29 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: [PATCH dwarves v2 09/10] dwarf_loader: introduce cu->id
Message-ID: <20241213223641.564002-10-ihor.solodrai@pm.me>
In-Reply-To: <20241213223641.564002-1-ihor.solodrai@pm.me>
References: <20241213223641.564002-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 3333d4e7209d66795db7fce6cb9acaef58e2b548
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
index bd65c56..58b165d 100644
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
index d516d52..7c80b18 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -291,6 +291,7 @@ struct cu {
 =09struct ptr_table functions_table;
 =09struct ptr_table tags_table;
 =09struct rb_root=09 functions;
+=09uint32_t=09 id;
 =09const char=09 *name;
 =09char=09=09 *filename;
 =09void =09=09 *priv;
--=20
2.47.1


