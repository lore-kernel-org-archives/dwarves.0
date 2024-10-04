Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721BA4F5FB
	for <dwarves@vger.kernel.org>; Fri,  4 Oct 2024 05:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728018844; cv=none; b=pASEDp+Affsdp5pMTCs9GPwb2oEDdmNUPZjwnEfm5WT8kcEnMZQHUcls8nD8Xe4e9DRb2aqCP4Lcw5DmhmAp+DnNRYg/P1yxNFQSSDvIUkhwEf9w2MAKEjNHanH4lm+WQbRPVFj6RN6yJHDIItdvleT7gty3fP7TTwBVhcJ9VrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728018844; c=relaxed/simple;
	bh=+vitxXCbyFAJFo9NvTfwVeN75Io2fic16pMweodd9Dk=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hgXdSwgaQ3lLqrBD3BDT25Db9ulhy35+PDmSUyYdvR3CP92ZPtulJJv5BNaDNZ0myI0ZUIhjntUUry90KdHKTOlYaHmFd0crvwO1Y+9e23sZCqZWz93mW1inL+hHFror7LnbJZ1d5WPcPLSvVhKKTZ76tDq7fL3JTdvPzSTsBcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=FElSPfBH; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="FElSPfBH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728018834; x=1728278034;
	bh=YzocKP5mDB4rOXgo5S8OxAn7uE4GMFBx3/FMUUOtevk=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=FElSPfBHVPnI35Pag9GQU46ra7gMcCSyjkMrMws2xaLuQf43t0E82/aVR0VcaVsOL
	 K5dlC4/tc54SUV67XCeC6/sjNLHtSyceS3E0RdBmgyPpkW6sfrzdi53bqiBDPE9HU0
	 lKb4bdzGafFLHqjRCMoInQ5Fw9V/GdnZ5Y3O/glu4lunhEyeYREp6Gl2RmYv2IAp0t
	 SXt21uC4xbGBoaT/Dnvjv+7KzTisYExZV74FTC3ZFnvcCcS2CJltSxSNfj3XBiOHcM
	 rYwUCqotkjQ0Z4S5UZ2tdFvw2fOuZQFdbKNj/SbhSvmZjZnR1KHS5W/BBFc06/Q91/
	 iAUkYRb89B33Q==
Date: Fri, 04 Oct 2024 05:13:50 +0000
To: dwarves@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org, eddyz87@gmail.com
Subject: [PATCH dwarves 0/6] btf_encoder: implement shared elf_functions table
Message-ID: <20241004051347.41143-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 6e1364f1a836c10a27149c079c21d51ce2eb914f
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patchset changes how BTF encoders collect and store function
information in a table searcheable by name, where their
btf_encoder_function_state is maintained.

Previously a separate array of elf_function structs was built and
stored by each btf_encoder, and when the encoders were merged before
dumping BTF their function tables would be traversed and merged too.

With these changes, the table used for searching for elf_function
becomes shared between encoder threads. However, additional
information in the table and in each individual elf_function has to be
stored to accomodate the sharing.

The memory footprint is now slightly higher, although it degrades
faster when number of threads is increased without this patchset.

/usr/bin/time -v with -j8:

    With patchset: Maximum resident set size (kbytes): 1402792 (~2% higher)
    Without:       Maximum resident set size (kbytes): 1376700

/usr/bin/time -v with -j16:

    With patchset: Maximum resident set size (kbytes): 1456044
    Without:       Maximum resident set size (kbytes): 1450748

The idea to make function table shared between encoders has been
mentioned previously [1].

I've been looking into ways of improving parallel reproducible_build
time, ideally making it as fast as non-reproducible.  In an off-list
discussion Eduard Zingerman suggested creating a btf_encoder for each
input compilation unit. This would allow to enforce the order of BTF
merge after btf_encoders are done.

With each encoder maintaining it's own table this idea proved
infeasible [2]. And so making it shared became a requirement.

I implemented a prototype that improved the speed of parallel
reproducible_build by using a similar shared table and implementing
Eduard's idea [3]. On master (84ab453) reproducible_build was ~50%
slower than non-reproducible, and with my experimental changes it was
20% slower.

This patchset stems from that work and discussions. The longer term
goal is to make BTF encoding reproducible by default, and fast.

[1] https://lore.kernel.org/dwarves/20240909155031.1596249-1-alan.maguire@o=
racle.com/
[2] https://lore.kernel.org/dwarves/aQtEzThpIhRiwQpkgeZepPGr5Mt_zuGfPbxQxZg=
S6SSoPYoqM1afjDqEmIZkdH3YzvhWmWwqCS_8ZvFTcSZHvpkAeBpLRTAZEmrOhq0svfo=3D@pm.=
me/
[3] https://github.com/theihor/dwarves/pull/1/files

Ihor Solodrai (6):
  dwarf_loader: introduce pre/post cus__load_module hooks to conf_load
  btf_encoder: split btf_encoder__collect_symbols()
  btf_encoder: introduce elf_functions struct type
  btf_encoder: collect elf_functions in pre_cus__load_module
  btf_encoder: introduce elf_functions_entry
  btf_encoder: switch to shared elf_functions table

 btf_encoder.c  | 341 ++++++++++++++++++++++++++++++++++++-------------
 btf_encoder.h  |   5 +-
 dwarf_loader.c |  21 ++-
 dwarves.h      |  18 ++-
 pahole.c       |  28 ++--
 5 files changed, 303 insertions(+), 110 deletions(-)

--=20
2.34.1


