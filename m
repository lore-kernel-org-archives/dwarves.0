Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579061F4737
	for <dwarves@vger.kernel.org>; Tue,  7 Jan 2025 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736276985; cv=none; b=jvPP2pfexE0ibWPAnNFtSAzup978bKd3RPwrxOeJa47+u+ZIC7Lyzmf+ZseOmQaHVXz4UPNPK7fU8zazrSwx65waVX2ClicyAPtra9wUIsajlmp0nQTil4N9o0NdvjOtJutyqbHrAjT/xI5BBVY+EW0NOyl13h3xiYe+opAloGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736276985; c=relaxed/simple;
	bh=7ovS2eeLPplqA/W3FmMin2daJhx7VohmQwMMXiEQ+RM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A16qqeCZUb9r7NLoI45V8vdpqpCrVA6rSwIqeo03lFi93a3zH2Zg3jM5IdMRwcaGftThEDF5tx2pDyp8K2VoA++hAm05cySE9wpBVENl0JAGfFTaRmwzJzFqsbOuk4PM6qwfRAQBiSHxNGIsxilzHrLBfyomLB5dh0ga51xMnn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=cCWoExFi; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="cCWoExFi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736276980; x=1736536180;
	bh=BHoWOF28SwETmN/kPdJjiJ0vWid8McdO7im7Usp3iGQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=cCWoExFiL8pOSn5TAIx8I2Xaa4Rj0Mj/+L5dnAe1lWD5NZzfq9sFURKr4fsZmHyvj
	 RG62z/HqwteyIs2c1USS/OcTk2JLDugXoRXiYFStTNTyoLgcN4Fxf8noJP8p4bHqlZ
	 76vQcmuAl+YCTdXb5KXZQcEjW5kb1YbIo992/17eISkkvIRIEziuD2OpY+UvkXmBS+
	 32+z3cPGV1X4duXGp+LobSC1eB+SMkLJbrXsP+r2zJZhiVZzqESFKt8FObCRV1cZzR
	 rrpt+JwzhtU81pU7YjUyjLmJG5+TfVscfstRvNcRcnup89mutVeJMZs0A4kSrKxGb6
	 X2bRUOt7CsZEA==
Date: Tue, 07 Jan 2025 19:09:37 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, olsajiri@gmail.com
Subject: [PATCH dwarves v4 07/10] dwarf_loader: introduce cu->id
Message-ID: <20250107190855.2312210-8-ihor.solodrai@pm.me>
In-Reply-To: <20250107190855.2312210-1-ihor.solodrai@pm.me>
References: <20250107190855.2312210-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: b403eedb1f6b467aab56613f796ce5d531955bb8
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
 dwarf_loader.c | 5 +++++
 dwarves.h      | 1 +
 2 files changed, 6 insertions(+)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 34376b2..39e4cba 100644
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
@@ -3783,6 +3787,7 @@ static int cus__load_module(struct cus *cus, struct c=
onf_load *conf,
 =09=09=09.type_dcu =3D type_cu ? &type_dcu : NULL,
 =09=09=09.build_id =3D build_id,
 =09=09=09.build_id_len =3D build_id_len,
+=09=09=09.nr_cus_created =3D 0,
 =09=09};
 =09=09res =3D dwarf_cus__process_cus(&dcus);
 =09}
diff --git a/dwarves.h b/dwarves.h
index 0a4d5a2..b28a66e 100644
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


