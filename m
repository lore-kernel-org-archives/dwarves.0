Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E6E1FB3
	for <dwarves@vger.kernel.org>; Wed, 16 Oct 2024 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729037438; cv=none; b=ZI2q9yyAts80jIkPcLmJhmI/gNSWzhb6Kw0/9NKxYIp0naI7NXvHTdwDoRgff8IOubXo0GBKltyPS/2DE9VmFR4bAUKrdGUuQQbuBS60H3Ovcxt+5FtWvnTmDvoQ1Znq26wHT6HU+B6Y1apJmczHzDVisNJA5MiCWltwsJ249+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729037438; c=relaxed/simple;
	bh=GYhm/XpruZcUELBIUVqARaDT3/b2rRm9GCyGUCASOtE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=J0OR14PPPA64J9ewz76JEfB/jCepa6Huq7ammMf0LA4JCgVl3mEH/h/ZqIy8iU0eN3Mx8nFCCcQT/eWDk8OqmSWXSBaBpatJFHhKhmfq4oAez5ze4f2aCvRoKyxJAvVP1Iun+cN5kbpw1eey2H6HGVI3pmTIo5LKpI0mMsuSyM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=nSgCM4Jf; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="nSgCM4Jf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1729037433; x=1729296633;
	bh=WXEzsSRdvQN7gybXREXVzMA0QdcWW8+lPQP/t4gvAos=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=nSgCM4JfLCHeYWGMd5hIxveUXTI0haPPVcZFzbFMDJj6xHQhFLqlxC4uKMqM/sj4P
	 9YUi8eqN3YwWeSI7R54dob6BJW/u1IqPoqu/WSCB752ePLi62Cco0IaOexLMZgr95t
	 dSY67W0Sf9bp24GkC7y2n6002FzP2Ozadn3JqdSmR5108Owm7Hdz1Y0GHpCZ39m+Xt
	 3W1dnWdDekYs153OupF70OmsXkJUfmqmsG7MMXVz+eBzEdktzUY7lIiDSgrimj7oQk
	 6sNL+CZfnUL8rZOGQJsonrvwdx3ZmlNCGfW3TY2MjWb99xsg1YQjyY9AfLMzZJKxBu
	 vNmliyQvyIBKQ==
Date: Wed, 16 Oct 2024 00:10:28 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org, eddyz87@gmail.com
Subject: [PATCH v3 dwarves 0/5] btf_encoder: implement shared elf_functions table
Message-ID: <20241016001025.857970-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: b3d8e3dbf100bd6c847540f6897c7f6f602c686c
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

v3 of the patchset fixes a couple of bugs and addresses feedback.

Notable changes in comparison to v2:

* use proper interface from stdatomic.h for atomic operations in
  btf_encoder__find_function()
* simplify btf_encoder__add_saved_funcs(), because actually we don't
  need to accumulate gathered elf_function states there, we only need
  to determine if a function should be added to BTF
* fix segfault in a case when the number of btf encoders is less than
  the number of threads
* correctly clean up elf_functions->entries in
  elf_functions__collect() when no functions are present in the Elf
* correctly clean up elf_functions_list at the end of
  btf_encoder__encode()
* remove post_cus__load_module() hook as it was unused
* remove btf_encoders__merge() as it is redundant

v2: https://lore.kernel.org/dwarves/20241009233520.989453-1-ihor.solodrai@p=
m.me/
v1: https://lore.kernel.org/dwarves/20241004051347.41143-1-ihor.solodrai@pm=
.me/

Ihor Solodrai (5):
  dwarf_loader: introduce pre_load_module hook to conf_load
  btf_encoder: introduce elf_functions struct type
  btf_encoder: collect elf_functions in btf_encoder__pre_load_module
  btf_encoder: store a list of elf_function per function name
  btf_encoder: switch to shared elf_functions table

 btf_encoder.c  | 387 +++++++++++++++++++++++++++++++++----------------
 btf_encoder.h  |   3 +
 dwarf_loader.c |  14 +-
 dwarves.h      |  11 +-
 pahole.c       |  12 +-
 5 files changed, 292 insertions(+), 135 deletions(-)

--=20
2.43.0


