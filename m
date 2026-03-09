Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD6B2BD5B4
	for <dwarves@vger.kernel.org>; Mon,  9 Mar 2026 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075952; cv=none; b=deaQD6TN/Fjk+prjvlepOvmc3GAE82eE+M3+HGIkmA5LsyjmBPsU3jIvyLKqo/4SezJcnPNsZtvfXmdWQS+dHooNK4tTodW4eJtAaZk5msHF0uAKtbUteDxwGxKnoq71Ulwih8fgWdAGopjD2hPufkwgaQrliqDDtCtHR4TpItU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075952; c=relaxed/simple;
	bh=0u5fm9mt6xFNcZ1QBXt2Kl0wrAVQqnKYZ+luRYu2Ur0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AzUecIP/87XVtkIM6KXVBBO8h/c7J0U+vuqnl5fvQxi6BeGD3LGODyUD5mZ+tnyWtsQsXxc3/DFCKoy/rdTwkOk1QGpJt4lEe7jLebrcTbjsnNouJrZrHgK3JWWjfShBdpcUv5KdaBPCUyh8Yqzjm3u9DnudYiTFswF1mDV7z1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geoide.fr; spf=pass smtp.mailfrom=geoide.fr; dkim=pass (2048-bit key) header.d=geoide.fr header.i=d.hourtoulle@geoide.fr header.b=xcFTfD/S; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geoide.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geoide.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geoide.fr header.i=d.hourtoulle@geoide.fr header.b="xcFTfD/S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geoide.fr;
	s=s1-ionos; t=1773075941; x=1773680741; i=d.hourtoulle@geoide.fr;
	bh=m6JghVr/A/sr67Bgtpa4d9VesdKNk2SkGyD/CMeexgg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=xcFTfD/SrHyt3guGpCZlpMd9ro30UQWZaNREW9xxwhQxmLHGsAMTob9RAsrUtg9/
	 Cpmf5sOMq6tuKR1uG6mZF2GIPfyGiI1mPHqprvkkGiQNjrr1lLGa/7QypB18iG5g9
	 litnDWbT+eRDeXrTmzWV8rVQ2wwPRTRdcua5KWqL9oWeSYEuLtIuR49MkmdLYuY9Y
	 6cbeOxdIheUH1bhFbLJS4PYVZj8y7wBKszCfCXqbsdMtLSRPPcu6HcBDZ8/E567dg
	 JPUJMkNS+Hyb+ebi3JQT61HgNf+QKFVcRfjRx/sLSOtJQrE9y4TznbxOyU6iKs/Xd
	 Hc8nVJUOa1KbrmT3zA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [213.165.67.119]) with ESMTPSA (Nemesis) id 1Mjjvp-1vEzII2l47-00dt14; Mon, 09
 Mar 2026 17:52:25 +0100
From: "d.hourtoulle" <d.hourtoulle@geoide.fr>
To: alan.maguire@oracle.com,
	acme@redhat.com
Cc: dwarves@vger.kernel.org,
	Damien Hourtoulle <damien.hourtoulle@gmail.com>
Subject: [PATCH v2] pahole: fix discarded-qualifiers for strchr/strstr.
Date: Mon,  9 Mar 2026 17:52:20 +0100
Message-ID: <20260309165220.2974165-1-d.hourtoulle@geoide.fr>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hBfgfkwLFjlVb6K34QnNItBwS9W9IvngkEg0TbIvwIMeCygxoJf
 5GX7zW3XwTeRLyNIEmtTWoVk+vLumkBpwo+eRl1sgpotfC514whPHPmE2gDS5O3LLBVKEzF
 Jcc1yETGq4DCQKeMD1M841lLXLfWUpmB25XrdHkODK/kbVf8iBi0OpLEIGj/lAyeQkZNOLE
 KrYD207Gu9KLcmCGG1AHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X4wfABglk2g=;4smEnjWd/YqnXFrD5DxnpRj4PsS
 JuWYdWUyfG8kqTc+VPyAjoS+pruZCiQtWCR6gA7fRJ9qnom6b9eKFQVJnyK3dHQRL0WE/SIqX
 ocpAP3MiD6jw9XfLZsSJk/1ixlVhU2ZHZ8coAVi6oX7NdsCn8TPr9/EPUCTRbQbBOrGIAW7Yw
 fbpBNWK0mjhHLaVpnXIi1LCFRVXLeloiG9D1fEBJ0iNxlWFk5nFTOVciXXuCgMR21tAFpud25
 t53BEM+i/VlM9hZ83diDrtn5UpoWdozBZN+gEYI/We/g5YRhGL+8b467ChLH8BH3ZQrWuSXmC
 F1+5o1x5/FdSz4bUQ5K8LnWveELegOIs8d5TQjXKL+FDNI6xz/38s044L3qj2+7zsTfTRAqAD
 CQUQzFpOBP1OD5K3jBm1gLrBWWDZlfS2VaK3HNXYwVX+kHR6q0dtirP12aLWT9XGotA0vWMfX
 Mpp4XwrwTOhJzImqG0+S+vEsQSZCwmgM+bpoySPrF2ErbFgNrDMAXcbQh4+FzmU75pwMPtlRw
 Hp3Umaab+64lXYmV+rcK3yFqR1j/SscUUT1ktu4xc+e+YFJhE8/54jzV2D4gh7n1X0nsuYAH8
 e2CeHYBSYKnij8TUkLBbIfIvZChu2fvAjGtS+giZqvW6xdMxCqteIyfytHeMdpwspDOrSqGQI
 CQKzteEyGO+IwdJLzxjnOnB4/y07TfyoIvrwzlavvA6rx1UB54gCJTu0DAMXm6J6K3JcjzI1p
 lmU2Vri+Bxxoiyn6G1AgeGfHGoQI65JwBKvcGtSwemKPcH46HrbBPzXb+i24ZAgZse0pMFZm4
 rWKMx/ZRynRmGOSIJaeiP77+/8HBNeMss+qXAipdQMEVdOINe6JWVbfK4ODHQJF/vN+Paioft
 FDlza5ePT85QBMMy5lVzJyTLsOW3e8YrViqiYRkZ5fzD/aAnnUSYeZdq6rLhSO2O/V5CMKL9c
 tq40ALFGARfXIZqnQvWRK8rpOYhJG7tvFtwPSFAJRZAXya0Rmew15V2TlmK99DE3WKasJBoXY
 sO6sDZ+j1uWDzgA7gix7YGV1VR/0KStkPdbEY1EtXZXClLWD5Xk9/APor3LZDyHwSjmQgTQt8
 H4l7Mq6A/ffO++SCznbWK0vkD2W/eorvL6DSGTWr2WXRJ1mplnDpKIVz+oJYD0zbhL1FLsIVv
 p1Zp9PwvNGVxSX8smyz3QZMYfldqdYhluOhaTVLYuD3ZD+d4iPL9VyweIOr2xorXf+7HN3gmq
 UNLlyrZqTyZXo6d6y5r3Xp9Ei+ZiM+ct/Hl75pdyo9tgtlp/L67SjThX8KbDh4k1HR/+O6MWP
 noRqhfSLXX+QBQRlbTgQmo/jf1SPx+b/ht1UWajU9g/P2ZFhOHY0EdiQOf+2CaRpp+CnBqfsS
 EGH6flWchwyReA8DyIQObbsykL1MvpQ0zQ90UOyb/2/XY6WQKqvGCGzuBkgwgb6WPOy7gZf6X
 UiCPQ82dXrh3L7BmF5L3sMuvFV5Am45ejHA38d9JRe5A7Y5pluT8umX0Rz2bzvg7dQLPVDssq
 sANQ//78QGgaMTfB+4k4OlQIyD5Jj5cymgQZlrGH+F0xekgzLHc9JIyiDd6FrSJ798FREXsEf
 hs4wv5xKh4+qiTOHsD07Qavsk4fFL4oBsU1ft8V4CXSV3fQF4/Qnqgh2BFO5GMD0NTiv4IWe4
 Zqwl/n5Cf2MrpDQNfUP4g74MvnBloy6l6AFVb9Vk6SOtB4gpF4RAoNTXisxQzDJRl9xNW9snW
 bjGWMEZxvbqMgCOeLuLCIc1BMHHTvJ44V9UtLgF3N6BWMVLn20KAUfHQ=

From: Damien Hourtoulle <damien.hourtoulle@gmail.com>

Glibc 2.43 added C23 const-preserving overloads :
https://sourceware.org/glibc/wiki/Release/2.43.

For the function prototype__new, fix local variable declaration to use
the correct const char* type instead of char*, removing the need to
discard the const qualifier.

Signed-off-by: Damien Hourtoulle <damien.hourtoulle@gmail.com>
=2D--
Changes in v2:
 - In type_instance__int_value loop: update sep_mutable instead of sep
 - In type__find_type_enum loop: introduce char *cur to iterate through
   the mutable copy, so sep_mutable stays const-correct and is updated
   correctly on each iteration

 btf_encoder.c |  2 +-
 pahole.c      | 33 ++++++++++++++++-----------------
 2 files changed, 17 insertions(+), 18 deletions(-)

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
index 02a0d19..9dfeeb2 100644
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
@@ -3141,10 +3140,10 @@ static int type__find_type_enum(struct type *type,=
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
 	}
=20
 	ret =3D 0;
=2D-=20
2.53.0

