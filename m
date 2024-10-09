Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D7217B4FE
	for <dwarves@vger.kernel.org>; Wed,  9 Oct 2024 23:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728516929; cv=none; b=Mq/tAjdiRCUajysRE7bCItTgYvDtxRv/DV4eLI0UaD0DLwjkGACKAziqBM+05b8tBA6uE5/MR285MzyXk7h4E5Vrea4g6dEowhBotJLZEqaocq3Jjfgab2SUNoB8KG47S4E2emwisMQP0HUHOBq2pvEOzim6GsZdTsEPJSic6jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728516929; c=relaxed/simple;
	bh=vnYjBxgyXqSGL4pfP6J4LC8mZh4K2QFnWWJWaHxU5xk=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=EcgBHxAC/WcyRUPxQrFlGwj2yuC6zAiuDJaCTB961IIuQ3lseRyVSvH8/b71edPUuKASlPe+PZdLrV+yplizflXJ1KrsuSz0DtGl0cp/1zWCB7JWHwn6M3ryQ9ulAqodXNo1hm/pFenCqWwaZmJ/7lpMEPeQOLS9blL82gN5xpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Ajc+HGMD; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Ajc+HGMD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728516925; x=1728776125;
	bh=OQb2DJpq6Jqo1/yjAUOyBVr5YHpSWRREzl3/HHKY71g=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Ajc+HGMDv+Apxz5/bvLhAqHSh226P/+YOFQ6vsqmvu0cD43E4m+Pp03dzg36RAAdE
	 JjNL4Bzs5tayR3l7NF+ixas7wV5+DPiYgW2R3MUmieVEqJcTZ3rHyyX4VeIhBS7WzQ
	 wLdDZHacFOaJLT8cvCFkIrXmEuCA6i9Zt3KU3748Wd5vFmxOiT1xTkwpe7sRWfLYxY
	 /lYBihoJRlkIoJCSMBG3Bin/HrOIi2LkR3Yz04/RZlS8a1AXAnZFAuGXsJYxo+iVSM
	 az2DObCa97/Dxk63laeEKxUjEi3MQ7Xw+29qL8JTDoQcf2sPk453cLR9AYRIBQjvUn
	 pQWMeiT/uGZcQ==
Date: Wed, 09 Oct 2024 23:35:23 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org, eddyz87@gmail.com
Subject: [PATCH v2 dwarves 0/5] btf_encoder: implement shared elf_functions table
Message-ID: <20241009233520.989453-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 415d99322b2822c9be704f011bb0e8cac01d3683
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This version of the patchset rebases the changes on top of next
(a1241b0).

In comparison to v1, elf_functions_entry struct and related code is
removed.

Originally (even before I submitted v1) I used gobuffer to store a
collection of elf_function-s. But that used too much memory, because
gobuffer allocates big chunks, and these lists mostly contain just a
few elements.  This prompted me to switch to a list in v1.

While rebasing I realized that we may avoid maintaining a mutex for
each elf_functions_entry if list updates are made atomically. With
that change it became obvious that elf_functions_entry abstraction is
unnecessary, so I removed it.

Also I removed reallocarray_grow logic, which was used for
elf_functions->entries. I noticed that the number of functions (at
least in vmlinux) is almost as big as the number of ELF symbols, and
we can use this to pre-allocate the entire table and then adjust after
function collection is complete.

A patch splitting btf_encoder__collect_symbols became unnecessary and
is removed.

v1: https://lore.kernel.org/dwarves/20241004051347.41143-1-ihor.solodrai@pm=
.me/

Ihor Solodrai (5):
  dwarf_loader: introduce pre/post cus__load_module hooks to conf_load
  btf_encoder: introduce elf_functions struct type
  btf_encoder: collect elf_functions in pre_cus__load_module
  btf_encoder: make elf_functions.entry an elf_function list
  btf_encoder: switch to shared elf_functions table

 btf_encoder.c  | 364 ++++++++++++++++++++++++++++++++++---------------
 btf_encoder.h  |   5 +-
 dwarf_loader.c |  21 ++-
 dwarves.h      |  18 ++-
 pahole.c       |  28 ++--
 5 files changed, 307 insertions(+), 129 deletions(-)

--=20
2.43.0


