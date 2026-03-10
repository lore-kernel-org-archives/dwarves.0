Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E74022FE0A
	for <dwarves@vger.kernel.org>; Tue, 10 Mar 2026 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149409; cv=none; b=fpaGle4M5FX+VRyTnn/LvNRUhBUcf0kkVjuW0F8HgzRZ698TV9j7rzOY9OfABRY+g1iBUhup4D29ofMfrAF2TnkLEZEP6spZa7jGQW4TglqgpWzBGaxRipnCGH1ArfQdMBYzzzuPuX6HUsvyte8RudsNTpE/FRxtb3ssnLfrHm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149409; c=relaxed/simple;
	bh=KAL5hPjtevHV+icq+ktnmrml7WaiD1EgWJ4xwUJlabE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uS+CjZs3dIYgFWVJhBlktdZhV8a6FMToEM4ZOE678jTrnixfxjqhvY+Wy2tuDwDvJGZ2fVj0KHxh0LD5ZLNnp6wpBqrqaUH8ytk2E0QgsnIlF4t1kQTalvy5u7weaEiKW0AiJ2LEAY3OsNARESi5RYG97Vv2VQpZM9Gba3YksD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geoide.fr; spf=pass smtp.mailfrom=geoide.fr; dkim=pass (2048-bit key) header.d=geoide.fr header.i=d.hourtoulle@geoide.fr header.b=VHyRaziu; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geoide.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geoide.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geoide.fr header.i=d.hourtoulle@geoide.fr header.b="VHyRaziu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geoide.fr;
	s=s1-ionos; t=1773149400; x=1773754200; i=d.hourtoulle@geoide.fr;
	bh=U4zh62SSc1NjVvWXxcsTc+0i8L+M0q8osYzaOdBjzrI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VHyRaziuiS7MtiWUKn2JxEmXG+qlbaCf4S1jzQqUNf6E5O84kB4fHLLs63LHDYtn
	 DRuE17XiL+KODFfPIAcvpsvZ4TFPqGABUMM3Mw+6nb0ZA9TvakoXoJ1ELBx/IDkVe
	 4iiSO2psdOBGKGNPeKsteH+8Z9QJXwn808KWtrf2O1cYW++yUM5QARHceVXDzDPp0
	 8LQuOW8kJ5Q6Pm4JfXncHCP45OmafgJgXqBlpD74soBiPRZIRKfsm3G5ekDAAZZHV
	 7k2qriso3jxFUO3JsaXXK2B6dDGMgCWhZqghPcMH/RPdyszR8O/cj85uVYDepvti8
	 ieINMoyOHBq7QO+qlA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [212.227.15.153]) with ESMTPSA (Nemesis) id 1M8hEd-1vvoQD1mt7-00C1sH; Tue, 10
 Mar 2026 14:30:00 +0100
From: "d.hourtoulle" <d.hourtoulle@geoide.fr>
To: alan.maguire@oracle.com
Cc: dwarves@vger.kernel.org,
	acme@redhat.com,
	Damien Hourtoulle <damien.hourtoulle@gmail.com>
Subject: [PATCH 1/2] pahole: fix discarded-qualifiers for strchr/strstr.
Date: Tue, 10 Mar 2026 14:28:37 +0100
Message-ID: <20260310132837.129665-2-d.hourtoulle@geoide.fr>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y2ulA6H0satIYNvLS0pw9DbbSonYYR5twEy8viGO5c9v6tmJbbr
 W5IPg+Y0GVhhkmqzJ2QkOhpL1vxxlOGqRLyegKSoMnN7p6QGxycb6yI8ZGQOlNzDNnE/h5D
 vdgVyj3RhzZ38a0NoTW1CpvbDiHpdD8vkVI6UwCuEOo2+d2zqsMkObvcKm7HiVB6SAZlrMN
 eRfXDF30I+fLWTVOv4I9A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:knL2PIFNIJA=;QKwxIs2X02RJTst1EL1IWH+l2HE
 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

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

