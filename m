Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9BD40DFB1
	for <dwarves@vger.kernel.org>; Tue, 10 Mar 2026 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149446; cv=none; b=tvfdWICx1EuCg92BZNY0td6n11iQRbG93qPTavxaN5cG+EpnCHxVEoLPo2oiOd0pFzQhOgtrFP1foHW/Z1sLOLCY/jdLbidcA+GBhjiPB1KWsrlqNCvVxpJzUhieUvlT92tC2m4ySU4tKE09qnohAGavn8RxsAEuN6ho9gTFeq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149446; c=relaxed/simple;
	bh=xQSRIB1WhFtlilJaeGLEkps4BlmwAawWkqYSAKv4hmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiTGOtVN6mEN73UJ8qa/BF0lNcOrcviS1KcRqCQPPzg45e/LIvtF7tzGlyClxIem5vCkcQJ9Cf1+pRRBarsq2KCok5S0sGDJY4I2K42OfXdeZkVc4PU0aW80/8PafDwd1prmh/NMOTjizAHUxWJReGIZy2gW0oQ1Sh7mMWcitAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geoide.fr; spf=pass smtp.mailfrom=geoide.fr; dkim=pass (2048-bit key) header.d=geoide.fr header.i=d.hourtoulle@geoide.fr header.b=UJGGXElz; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geoide.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geoide.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geoide.fr header.i=d.hourtoulle@geoide.fr header.b="UJGGXElz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geoide.fr;
	s=s1-ionos; t=1773149430; x=1773754230; i=d.hourtoulle@geoide.fr;
	bh=l/ZZLzi9SAhqelEFLkIYAaJPLEPJO+IYKldLLyD56iQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UJGGXElzY31iWwx+OWAwQgzP5Xa+IIB/umGdqz5Yi0to43RE2BDccz8gcRKRcKu0
	 19ZQpxpiEI2q2FR9OK78YQONGI0U1wBvSLUq6S1glXtV5sVqOfah3+ueFVKSCdQSy
	 MSkV71PjOvWUEiZzkPEQuNbIXVQmFDOs9kKFMYRn1d4+n9cr+kZanvo1bSsJ0c7Bp
	 pof61MFmtqmE7mX+XPrEv99PGvPKs3TcYaCc4sB8lUvYzFeK7KuznoWSbsAaH5v7l
	 cbJNafX6aU9wj1gv+F7E802GHNpLyEQtP8Ajrs6twwWGWu5aESUwewzJwU36oG5Hl
	 MpatoyMvVNrMfca3vw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [212.227.15.153]) with ESMTPSA (Nemesis) id 1MIxqu-1wKMdI3D0k-00V2hO; Tue, 10
 Mar 2026 14:30:30 +0100
From: "d.hourtoulle" <d.hourtoulle@geoide.fr>
To: alan.maguire@oracle.com
Cc: dwarves@vger.kernel.org,
	acme@redhat.com,
	Damien Hourtoulle <damien.hourtoulle@gmail.com>
Subject: [PATCH 2/2] libbpf: fix discarded-qualifiers for strchr/strstr.
Date: Tue, 10 Mar 2026 14:28:39 +0100
Message-ID: <20260310132837.129665-4-d.hourtoulle@geoide.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310132837.129665-2-d.hourtoulle@geoide.fr>
References: <20260310132837.129665-2-d.hourtoulle@geoide.fr>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mG0INMoV8JIRGc+pEv4mPS5RKYQdQjbxZ4nmC0lUcnx2ZTE3ksB
 1OnftMpiqSydPuxBQ6nPxnu75JZx2/qFB0Dvc5qbM4xobPpr95Y6ELansX1e3RMrWdszR2V
 fUI21TbqcI2GlGaR6OzjJ7gnE7Vzn6AEwrFGuSLPJxwLzRmJJyarTFTu3ZJlIlJoYJgoYk3
 1p6ntkM/u9j+HRHTeQIkA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aPqrnwExDdY=;bHZaZzwJ9T4k+S/pUbVlJOqx9ar
 Dfb+FlQbcsMgXB/IRSYqDKFFUrOJrlLPc4KSa3ddMgTZ3xNPC4AjVxSpivSyOk6FxPn6AYO5o
 yWNIzDCmr7bDuo4rbk/CkaON6T/gOI/vPAbTPy9f8Vd0f0jWPIXwgGh5IZS2ie1S/q80r5XEl
 RmXvNxeao8K2sGOocPVH7lXnF8vqZciEz/W0Cs8tOVqhEHGr6bDvc1voP01batHh0RHeIwqp7
 rS0uLeg89hs7/Z4yz/T6M7iGmFXmGLPegKLmW/CJub7iFBJCeXMXz4RR+azZbBfeX6NxdopQ/
 xRlY81PKZJXA6HHzG8SVnYJE5XdMToa65QVxhHuOyNqk/kMmmKkPNjsTkYBCR21hlrBPTVGwt
 VdZzkonSyFb0i9qxE6zMONMH8wfaFQ+8fjCY3A0edQ6Vj/uMsMlDYLentiWbVNaxQAtPSq519
 D9Q9w9svKJHEMHms0C9KriodIWXBtWZa8/I5mBno6bQhg/RXDroaPZXW8E1LpXZIkfe5zFI+a
 1c4huzaIOzIdzYGB9EaItfsC6kR+WKYBz8WgT/v06rcjGhwuHsHxgBBHUOMSdHsY8xLIMXA9M
 Lx/0rjhBIPdvMvUKZ93N43j9CKdfcZWOrLek5zVe2qmO1mp0LCX1tnN/Sj1ho8CJAUj815GhE
 Zkzd/Fxua8BPzWyJdFOThJeGh5nsfFmgP/zaOdNF7Zbn2h2KSrD/KD9v2VWvI6JuJpmKTqmR6
 DxsNg4knutrhcO+NQH3BgEUtAEdDAet3Yq37eCbkTOmyCIbhVQ5sHxF9sbhd8ATwI//5kC2LG
 nriiJy0htlOgBsAMwQzbBUNU+5oecqa5zT9+R/UWIjTT2t5OdsM0B4mwL81SpNHeYtTAPXXip
 hrdu5M+f54yyh09zTsAEFsJSz6gfNjIr6sndkJYA8xHZaftLKHZAwx1r1DsObIdkWj0tdgtmO
 T/jZIbuX7jS2DBs8JFHzWyIoX0MNEda4xiOulQ7O12mocBcjnKRoEGWTqmK/P17RPMNsuhY3m
 0Kx36vvfSEAiCRkP1mAgrA1u5h5X3a5jOhoCe1cP81w7BgnshC6LVQV/crs+OekeqEZwu1TDO
 V6UxCS4u6KPN/Lx5X0SPbetj88dvNDHnjYXkGLmmMoKQUXV2Tsc7goCgFdIP76IjYlq5lMbFq
 5FR8FsLBXHrkp7YHzcvvCEw04dqRqx8Me4qnQyQ+OjMwOVaFckjTPtuo/xsWnRaZnrpJnROyg
 YMso3IZnTvCjnrQYN1HWjb9jCnE//F2ZZUKrM1vTr0oiREQQVhYsNnFQlOohummNvH1j+zPTK
 APpfe+n8kyKa3TgE3fftkB2f51pqikR/wlGrs5R1vjepxH9mGPmd85B3mBM4TUz80NnJ+B6yE
 g6UV+fduGA5D5IRi+srDUD3Udwc95qWPi3C/Hr7nvlZAlq7nwRykxcPKZD+6lnOCUEt8NFNEO
 /SMCw30r+4Ht2nf2wawnTZ1PPc95E7oxjxI5aEuRaxEC+FHUJA1JMyloswmoTsQmRojalQNgd
 w80amTZurb4GgVcNWphGd6LKslhj9V6e/qZr/HjTaZ7vzBPnwkGLUJRlAi6F96nCVDPVtS9FY
 dkRnSdk1IAwNc3mJX5E1Pk96FjhM6WiI6zPwfRSRkMAA17tNjk0Fxh784uhtu7MqPh3RbMuqu
 tche5kDzW2TOfLUhoZkXLfHknzVtir8jkN3BqGavUUatxvVsjEsCDgzmPDy0d6Ex+z4SvilMx
 CcxfgLM3VfOjhLJWQHuyTRQlGcnulAHOJojrIeLbi2nhMZJd74Hh3gWMbLkHgUn36fB7IAWi3
 E2WGkp3sAQJVeXGPB0zKhWDN8zcAPjjDh60m6dXkFEO4ujj/SU0oI9EwERNeVEctO12w

From: Damien Hourtoulle <damien.hourtoulle@gmail.com>

Glibc 2.43 added C23 const-preserving overloads:
https://sourceware.org/glibc/wiki/Release/2.43.

Fix three local variable declarations to use const char* instead of
char*, removing the need to discard the const qualifier returned by
strstr/strchr.

Signed-off-by: Damien Hourtoulle <damien.hourtoulle@gmail.com>
=2D--
 lib/bpf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Submodule lib/bpf 374f780..6bba5da:
diff --git a/lib/bpf/src/libbpf.c b/lib/bpf/src/libbpf.c
index 617cfb9..9e88156 100644
=2D-- a/lib/bpf/src/libbpf.c
+++ b/lib/bpf/src/libbpf.c
@@ -8179,7 +8179,7 @@ static int kallsyms_cb(unsigned long long sym_addr, =
char sym_type,
 	struct bpf_object *obj =3D ctx;
 	const struct btf_type *t;
 	struct extern_desc *ext;
-	char *res;
+	const char *res;
=20
 	res =3D strstr(sym_name, ".llvm.");
 	if (sym_type =3D=3D 'd' && res)
@@ -11482,8 +11482,8 @@ static int avail_kallsyms_cb(unsigned long long sy=
m_addr, char sym_type,
 		 *
 		 *   [0] fb6a421fb615 ("kallsyms: Match symbols exactly with CONFIG_LTO=
_CLANG")
 		 */
-		char sym_trim[256], *psym_trim =3D sym_trim, *sym_sfx;
-
+		char sym_trim[256], *psym_trim =3D sym_trim;
+		const char *sym_sfx;
 		if (!(sym_sfx =3D strstr(sym_name, ".llvm.")))
 			return 0;
=20
@@ -12067,7 +12067,7 @@ static int resolve_full_path(const char *file, cha=
r *result, size_t result_sz)
 		if (!search_paths[i])
 			continue;
 		for (s =3D search_paths[i]; s !=3D NULL; s =3D strchr(s, ':')) {
-			char *next_path;
+			const char *next_path;
 			int seg_len;
=20
 			if (s[0] =3D=3D ':')
=2D-=20
2.53.0

