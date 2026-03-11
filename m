Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C868282F33
	for <dwarves@vger.kernel.org>; Wed, 11 Mar 2026 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238651; cv=none; b=QKHR5jKxvnllIrpMMJVOGfZYgMeKFKGu60vMxXr/WfZL9tOSUbvu0//n9LceY1hAAoHclh2b3izC1Nio8rG4q5gM/7Vcaq3dUJojCh3hj+VOlJ2gZdueQRxNGjQdnZHb6k23ckuiDuSxQhk1j0MKbxwdvureIXd9OaU7iIekoNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238651; c=relaxed/simple;
	bh=KAL5hPjtevHV+icq+ktnmrml7WaiD1EgWJ4xwUJlabE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U5oLIIh+lsE8HJCJVtUHgVZP2nRxFo2B3A5W0j2/5had46kVyBwNTO8jC85H/R/QUR0z/qu2AXgYbCNcPvNDx88OWodasX7EV02MNC7fafGNZ4nTSwf//DCwV/T9AIXvecrYT3JxPCeybrOT5p0PlEhTZhV5KzFd0j62Aop75JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geoide.fr; spf=pass smtp.mailfrom=geoide.fr; dkim=pass (2048-bit key) header.d=geoide.fr header.i=d.hourtoulle@geoide.fr header.b=VtrR8NzG; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geoide.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geoide.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geoide.fr header.i=d.hourtoulle@geoide.fr header.b="VtrR8NzG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geoide.fr;
	s=s1-ionos; t=1773238647; x=1773843447; i=d.hourtoulle@geoide.fr;
	bh=U4zh62SSc1NjVvWXxcsTc+0i8L+M0q8osYzaOdBjzrI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VtrR8NzG8UtoxSdMfX4CH8UjhNlmzapHv6s8VCVl0W6nWVavTRSzmWaLvpRaNiop
	 njRO0i8c6inj/YZrpsuYRoYT24k6EvkpeldXauWmKG8C5ZtVJx/aWDHEvJzrfA9Zn
	 bbHZzL4ttqaGrj1lM6hAO0EcO4xamRAu0VnsfIZvN0Xvql06WWw3HVsWbYjGisVY3
	 uKyjimsVz2jphB28z9c3pxlvgujPx2LY9+JpgELTl9unt5SI+NQuQ60jg60+Cws5e
	 n8WwJ3s8X01ztm2oz3d958OVfpmWpbTWXjiw/MwgG1SFx6PTrwy07W9KD7hsuH321
	 x333N28LX/BNfgGD+g==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue012
 [212.227.17.165]) with ESMTPSA (Nemesis) id 1M4bd0-1w1yzG1tsU-00H5rz; Wed, 11
 Mar 2026 15:12:08 +0100
From: "d.hourtoulle" <d.hourtoulle@geoide.fr>
To: alan.maguire@oracle.com
Cc: dwarves@vger.kernel.org,
	acme@redhat.com,
	Damien Hourtoulle <damien.hourtoulle@gmail.com>
Subject: [PATCH v4] pahole: fix discarded-qualifiers for strchr/strstr.
Date: Wed, 11 Mar 2026 15:09:39 +0100
Message-ID: <20260311140938.81459-2-d.hourtoulle@geoide.fr>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RZyZelsrati3ExrtQbUgYSv7zrdl5usUX7PGVNGXOGIdvKtLvez
 9uHx8tCdBcZC6vEkZcJ55sykqUPv1XwY3f4ewr61hhK+74LE12AmqdFd3YRoLYEv3j0HpKR
 xe7Jj1rtV47TJsWXk3U4s+VoXMsz/RCz9kc6BzJtnOoGPDmpxWg+SGryu7koe90cmuwR7w4
 Za1gcB87hyYnyoAlsXBow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CrllrcpydCg=;+aE8YyqdtYYiLAA8eAsHSSQmGsw
 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
 EG8wZ29uSio1Y5VWDDjdd8pguEmGk=

From: Damien Hourtoulle <damien.hourtoulle@gmail.com>

Glibc 2.43 added C23 const-preserving overloads :
https://sourceware.org/glibc/wiki/Release/2.43.

For the function prototype__new, fix local variable declaration to use
the correct const char* type instead of char*, removing the need to
discard the const qualifier.

Also fix a pre-existing bug in type__find_type_enum: when iterating
over a '+'-concatenated list of enum names, after advancing to the next
segment the new separator was not nullified, causing "second+third" to
be passed to cu__find_enumeration_by_name instead of "second".  Add a
null check before writing to sep_mutable to avoid a null dereference
when no further '+' is present.

Signed-off-by: Damien Hourtoulle <damien.hourtoulle@gmail.com>
=2D--
 btf_encoder.c |  2 +-
 pahole.c      | 35 ++++++++++++++++++-----------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index aa7cd1c..d36984a 100644
=2D-- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1218,7 +1218,7 @@ static bool str_contains_non_fn_suffix(const char *s=
tr) {
 		".cold",
 		".part"
 	};
-	char *suffix =3D strchr(str, '.');
+	const char *suffix =3D strchr(str, '.');
 	int i;
=20
 	if (!suffix)
diff --git a/pahole.c b/pahole.c
index 02a0d19..e4bfb69 100644
=2D-- a/pahole.c
+++ b/pahole.c
@@ -2483,7 +2483,7 @@ static int64_t type_instance__int_value(struct type_=
instance *instance, const ch
 	int byte_offset =3D 0;
=20
 	if (!member) {
-		char *sep =3D strchr(member_name_orig, '.');
+		const char *sep =3D strchr(member_name_orig, '.');
=20
 		if (!sep)
 			return -1;
@@ -2496,8 +2496,8 @@ static int64_t type_instance__int_value(struct type_=
instance *instance, const ch
 		char *member_name =3D member_name_alloc;
 		struct type *type =3D instance->type;
=20
-		sep =3D member_name_alloc + (sep - member_name_orig);
-		*sep =3D 0;
+		char *sep_mutable =3D member_name_alloc + (sep - member_name_orig);  //=
 sep mutable for the copy
+		*sep_mutable =3D 0;
=20
 		while (1) {
 			member =3D type__find_member_by_name(type, member_name);
@@ -2510,9 +2510,9 @@ out_free_member_name:
 			type =3D tag__type(cu__type(cu, member->tag.type));
 			if (type =3D=3D NULL)
 				goto out_free_member_name;
-			member_name =3D sep + 1;
-			sep =3D strchr(member_name, '.');
-			if (!sep)
+			member_name =3D sep_mutable + 1;
+			sep_mutable =3D strchr(member_name, '.');
+			if (!sep_mutable)
 				break;
=20
 		}
@@ -2950,7 +2950,7 @@ static struct prototype *prototype__new(const char *=
expression)
=20
 	strcpy(prototype->name, expression);
=20
-	const char *name =3D prototype->name;
+	char *name =3D prototype->name;
=20
 	prototype->nr_args =3D 0;
=20
@@ -2964,10 +2964,9 @@ static struct prototype *prototype__new(const char =
*expression)
 	if (args_close =3D=3D NULL)
 		goto out_no_closing_parens;
=20
+	*args_open++ =3D *args_close =3D '\0';
 	char *args =3D args_open;
=20
-	*args++ =3D *args_close =3D '\0';
-
 	while (isspace(*args))
 		++args;
=20
@@ -3114,7 +3113,7 @@ static int type__find_type_enum(struct type *type, s=
truct cu *cu, const char *ty
 		return type__add_type_enum(type, te, cu);
=20
 	// Now look at a 'virtual enum', i.e. the concatenation of multiple enum=
s
-	char *sep =3D strchr(type_enum, '+');
+	const char *sep =3D strchr(type_enum, '+');
=20
 	if (!sep)
 		return -1;
@@ -3126,13 +3125,13 @@ static int type__find_type_enum(struct type *type,=
 struct cu *cu, const char *ty
=20
 	int ret =3D -1;
=20
-	sep =3D type_enums + (sep - type_enum);
+	char *sep_mutable =3D type_enums + (sep - type_enum);
+	char *cur =3D type_enums;
=20
-	type_enum =3D type_enums;
-	*sep =3D '\0';
+	*sep_mutable =3D '\0';
=20
 	while (1) {
-		te =3D cu__find_enumeration_by_name(cu, type_enum, NULL);
+		te =3D cu__find_enumeration_by_name(cu, cur, NULL);
=20
 		if (!te)
 			goto out;
@@ -3141,10 +3140,12 @@ static int type__find_type_enum(struct type *type,=
 struct cu *cu, const char *ty
 		if (ret)
 			goto out;
=20
-		if (sep =3D=3D NULL)
+		if (sep_mutable =3D=3D NULL)
 			break;
-		type_enum =3D sep + 1;
-		sep =3D strchr(type_enum, '+');
+		cur =3D sep_mutable + 1;
+		sep_mutable =3D strchr(cur, '+');
+		if (sep_mutable)
+			*sep_mutable =3D '\0';
 	}
=20
 	ret =3D 0;
=2D-=20
2.53.0

