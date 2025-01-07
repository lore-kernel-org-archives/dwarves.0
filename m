Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808F11F4E47
	for <dwarves@vger.kernel.org>; Tue,  7 Jan 2025 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736282117; cv=none; b=tnvItGWa6y5FSR31mMDLPXYs414uWt9b9I9nLiaRl8BjdZ/3sIBqAAuTSarBX+UJWhPjUpy1YvSdXX4GPILmw9lzl+aSgonAadZrUJdCgx4Tak/ti3Q40qZCKbhEt9y1vzRyz0kSXUSJOuR1BC9o1Fl39SEPX5ZX+ZMv+Kv1Tdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736282117; c=relaxed/simple;
	bh=mm+ZTBbnQHgEFMtxNMxBaCNH8iiVYBIW4JJNc64twKA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wikw3Ph+qKgL2woyp0GsR+CDv1AI8BXLFStzEfcgWMLWJEcq+Z+x0TNL9Zbhd4dl7hCVAjeefHCdthiwk7/jgIUkSCnpuwY5FpUxxfkrf0aDsbsE3GE9k7+6aJwKawWNOTm4kZSqt7LKnfGCy0BgrRm2XFAFfGKI8t8mlZpo0hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=RLE+gVky; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="RLE+gVky"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736282108; x=1736541308;
	bh=XEKzfoi3G3lwPriPI6AkJ5SlMXjAAi0kviQcypWe1oo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=RLE+gVkycY6m8aOtdsDWLJHZMoLDKFXi0q+KBhWCr5g7hQkAYbxoyItXUsXp/upwY
	 1XcsTKMd3X6YZYFhLf0qIHbO0otv8IpOD2wBbRaBgWLeGz5uOTRZCdYmy1qESJD12G
	 VOqqraTEMHOEqEJ4h6YWgXdSLcK/42L6rQaM07h0UYgRdZOh6BwMHaVHwA1RssuUop
	 mP57qEvuig/pHE8JTO6gEbt4aP0tDIu+bhhKCv/rtTTR3d/FGJWP3U5We/cBsMystu
	 9F/h8nYfksMtAZmVngcdQhX9jRzdhT1bh0oF1qZEhGeAAV/z5uVFaEnGZCmuqC7HXT
	 66XQ+YtkEPX7w==
Date: Tue, 07 Jan 2025 20:35:01 +0000
To: alan.maguire@oracle.com, acme@kernel.org, dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com, olsajiri@gmail.com
Subject: Re: [PATCH dwarves v4 00/10] pahole: faster reproducible BTF encoding
Message-ID: <ITLAjYpItfkWpWQEiz80tH1ACeynhOt3fy0-wdliNGQlzctskjBNpTXXMl6wdiNfQoNVNiCF4UYWlS3wblgyDrnjws1wi2MTkN4zILTa96s=@pm.me>
In-Reply-To: <20250107190855.2312210-1-ihor.solodrai@pm.me>
References: <20250107190855.2312210-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 91ec4e1854cf06b212fe9011b3f33b90f7198d49
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, January 7th, 2025 at 11:08 AM, Ihor Solodrai <ihor.solodrai@pm.=
me> wrote:

>=20
>=20
> This is v4 of the series aiming to speed up parallel reproducible BTF
> encoding. This version mostly addresses feedback from Jiri Olsa on v3.
>=20
> A notable adition is a patch 10/10, which changes func_states in
> btf_encoder from a list to an array.
>=20
> [...]

Alan, Arnaldo,

I'd like to also remind about two small patches that I sent separately:

  * dwarves: set cu->obstack chunk size to 128Kb
    * https://lore.kernel.org/dwarves/20241221030445.33907-1-ihor.solodrai@=
pm.me/
  * btf_encoder: fix memory access bugs
    * https://lore.kernel.org/dwarves/20241216183112.206072-1-ihor.solodrai=
@pm.me/

In particular, obstack chunk size change significantly improves the
runtime of BTF encoding on top of this patch series, on the machines\
with lots of cores.

Please take a look at them when you get a chance.
They can be applied independently.

Thanks.
