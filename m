Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8244683
	for <dwarves@vger.kernel.org>; Mon, 14 Oct 2024 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728931870; cv=none; b=QZp574qjA1ttjgC+VPP/KBPz73D2EIRfL/9HPmyNciNj3JQOio/4UBy6s7beinatvEIJpgOCX60tCour6HqS41gAIZNAHfj/vFabBHNx4ifjVUJO6LOSQfxbrsw9bSzUqRKfgCxh7OI0TDajH8IM0aaasPjQv/b3XzZ/j9RwpvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728931870; c=relaxed/simple;
	bh=CA5+hfouZUptzaRYu8qBG4vYuufhOirjwE5gl3AK1vA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUzYTIJa3KGr84SNK22xgM0cffO+dIdXYh52xA6A9H+TVDN9qztWLkhx2POI8ED2Xsx0bfhUCA7m6qeZ8A9mHzD5vDacT5IwcBir2f6li8dx+CaqeYJ7osmAeUTfuHqxsnapx7qJcXAMA6kih5zAB5p90zCezOsBU59pMoKCXaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=UJHPeyon; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="UJHPeyon"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728931867; x=1729191067;
	bh=CA5+hfouZUptzaRYu8qBG4vYuufhOirjwE5gl3AK1vA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UJHPeyonaDURq2QlnLDFNa4cGG8IvrpNa4RL/a7rP09bVKcAdMB4eleRE6FzRxvm5
	 3wihFugFH0yGXNBfGczA3Kvm0rv+GkPcKGgZqpMpQWnmrFjsBDrl09Foh2YgAOLhYU
	 FCNEuA4k50BixOYS2iXjzrc3we4E05ZPy/6a11qkDiCV0Muzfo25e7JAYMyYYPIoLa
	 Ks+tJMSHxHuWyX2oZts3gANoDPH74QzCRqp4TmjGZtYzvjIo30yCtCBQstcXElLlsD
	 LaMUqb++rv+d3+dCAPV4/fPUMws5a8n4WXennr86fxiQMpkbhYqLYBI1LggtrFPCzU
	 jed+GCcTxiZ5w==
Date: Mon, 14 Oct 2024 18:51:02 +0000
To: Eduard Zingerman <eddyz87@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org
Subject: Re: [PATCH v2 dwarves 2/5] btf_encoder: introduce elf_functions struct type
Message-ID: <2WfzxylM8vqLQqRpXOeX7Ax22IaLHN6_SdaKHPDLoNUql8UzldKizhn0Tbs92MCC8e5ygfm7dUWNGilRcVbepcMibUMGWJDuA3D4O6kRQbk=@pm.me>
In-Reply-To: <94c828d87e3ae213526f1b403bdff4ad6d6f6a54.camel@gmail.com>
References: <20241009233520.989453-1-ihor.solodrai@pm.me> <20241009233520.989453-3-ihor.solodrai@pm.me> <94c828d87e3ae213526f1b403bdff4ad6d6f6a54.camel@gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 543d156484ab65b6f4c0abf91debe8b2022a3d9c
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, October 10th, 2024 at 1:57 AM, Eduard Zingerman <eddyz87@gmail=
.com> wrote:

>=20
>=20
> On Wed, 2024-10-09 at 23:35 +0000, Ihor Solodrai wrote:
>=20
> > Extract elf_functions struct type from btf_encoder.
> >=20
> > Rewrite btf_encoder__collect_function() into
> > elf_functions__collect_function(), and btf_encoder__collect_symbols()
> > into elf_functions__collect().
>=20
>=20
> Nit:
>=20
> the sentence above is somewhat cryptic. I think it's better to say
> something like:
>=20
> Extract struct elf_functions from btf_encoder.
> Replace methods operating functions table in btf_encoder by methods
> operating on elf_functions:
> - btf_encoder__collect_function -> elf_functions__collect_function;
>=20
> - btf_encoder__collect_symbols -> elf_functions__collect.

ok

>=20
> > Now these functions do not depend on btf_encoder being passed to them
> > as a parameter.
> >=20
> > Signed-off-by: Ihor Solodrai ihor.solodrai@pm.me
> > ---
>=20
>=20
> Modulo a few nitpicks this patch looks ok to me.
>=20
> Reviewed-by: Eduard Zingerman eddyz87@gmail.com
>=20
>=20
> [...]
>=20
> > @@ -2100,22 +2075,38 @@ int btf_encoder__encode(struct btf_encoder *enc=
oder)
> > }
> >=20
> > -static int btf_encoder__collect_symbols(struct btf_encoder *encoder)
> > +static int elf_functions__collect(struct elf_functions *functions)
> > {
> > - uint32_t sym_sec_idx;
> > + uint32_t nr_symbols =3D elf_symtab__nr_symbols(functions->symtab);
> > + Elf32_Word sym_sec_idx;
> > uint32_t core_id;
> > GElf_Sym sym;
> >=20
> > - elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_=
sec_idx) {
> > - if (btf_encoder__collect_function(encoder, &sym))
> > + // We know that number of functions is less than number of symbols,
> > + // so we can overallocate temporarily.
> > + functions->entries =3D calloc(nr_symbols, sizeof(struct elf_function)=
);
> > + if (!functions->entries) {
> > + fprintf(stderr, "could not allocate memory for elf_functions table\n"=
);
> > + return -ENOMEM;
> > + }
> > +
> > + functions->cnt =3D 0;
> > + elf_symtab__for_each_symbol_index(functions->symtab, core_id, sym, sy=
m_sec_idx) {;
> > + if (elf_functions__collect_function(functions, &sym))
> > return -1;
> > }
> >=20
> > - if (encoder->functions.cnt) {
> > - qsort(encoder->functions.entries, encoder->functions.cnt, sizeof(enco=
der->functions.entries[0]),
> > + if (functions->cnt)
> > + qsort(functions->entries,
> > + functions->cnt,
> > + sizeof(functions->entries[0]),
> > functions_cmp);
> > - if (encoder->verbose)
> > - printf("Found %d functions!\n", encoder->functions.cnt);
> > +
> > + // Reallocate to the exact size
> > + functions->entries =3D realloc(functions->entries, functions->cnt * s=
izeof(struct elf_function));
>=20
>=20
> You need to store realloc result to a temporary, otherwise pointer to
> previously allocated memory in functions->entries is lost.

Good point.

>=20
> (Although idk if such realloc could fail).

It might fail in principle, although it seems very unlikely [1].

[1] https://stackoverflow.com/questions/12125308/can-realloc-fail-return-nu=
ll-when-trimming

>=20
> > + if (!functions->entries) {
> > + fprintf(stderr, "could not reallocate memory for elf_functions table\=
n");
> > + return -ENOMEM;
> > }
> >=20
> > return 0;
>=20
>=20
> [...]

