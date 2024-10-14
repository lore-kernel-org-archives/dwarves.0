Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734A34683
	for <dwarves@vger.kernel.org>; Mon, 14 Oct 2024 21:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728940545; cv=none; b=GVzmfq0QlpjEctys7H5Kvak9perqjRRxusk1zP5dE6PL8afuJ1lBu/FyFNt+IU2O0+kV4AQBZ6bz3bq/3kOEsRbDSqqYehTCSTO37sbXTdNx+z+mXWTJF15cIN2uS6ERPSZji6q6thaJR7XRg0btxeIPMu9Q3wFOtXZC7YxyeJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728940545; c=relaxed/simple;
	bh=rse0Mg54FB7vl7ojZ/7H/l/r2RCnCrk6A3OvKfo5CzU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0QvJVXQ7ebHrFQO/68nVSQamxWRCgCraVUZjLcfMC4oO4PMzdjN7uEehrP++ouHdEpaGuxZa5vlcUuOWtvIX5j3KSqNV+nNUzWt+eUF+eKMd/lyOFkOk+jdNwfOf0Ik1kvA+PhZ1HLzQu8GT6OHO2LPKpKI7W5lPxlBmCcWElQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=pE2bI8cy; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="pE2bI8cy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728940541; x=1729199741;
	bh=w9PjVhs1jsulmluk9HUIbokwoJ609q4w/ATF8uanYWw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=pE2bI8cyHLKW0WbmzVOcKoA3jU/hWbCWZFtgN1tOBciKCurciLRMO9myf7eTyKEqU
	 4dT2olosOHmDeVyKjGKoYWqFBeLE6XsdNXIkiFy1dbOoK39BUwQRHLZkg7GAEPJJub
	 6jOUO9bdh4sBzv96WLprY+a5WdNOqJ+PUuXDQUz53khA+jRU1mXydcgJsdzKaYJtpl
	 pOzcUh28DZPnHaqudNc+8W0v5SNa81UWyaNm3hOsyxQ5lx2ljZZgqGoYWB4EFIOHvt
	 oecnroA+5VcY/Tt5LonbNufHHF+FgBzsOcMuKy1ZMKt2E0fShIHtqI43kzEkAigxuF
	 L5wdEqCAxoHRQ==
Date: Mon, 14 Oct 2024 21:15:38 +0000
To: Eduard Zingerman <eddyz87@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org
Subject: Re: [PATCH v2 dwarves 3/5] btf_encoder: collect elf_functions in pre_cus__load_module
Message-ID: <hrfEwQ1OldXwSegRIZ9XpD6t7pJZJ6sMz7duwiE0dbi_lFlnjEphjTsjxJiakceGnR2_dNfhUp2oJrS2uShN9qHK2tf-32cFVWQS1r-eDds=@pm.me>
In-Reply-To: <7d6631c07df523103ae3a89ebeedf296074d6967.camel@gmail.com>
References: <20241009233520.989453-1-ihor.solodrai@pm.me> <20241009233520.989453-4-ihor.solodrai@pm.me> <268884d44497f30e561609ff982cfa87c1c24bb6.camel@gmail.com> <wh8Ne88FhIBrRfmV5_-tXL_BILUEFXXb6WONJvvucTJOwM56meP3VgKHyiE9qg-DIRQuR3lcmOmwGT53Xa9qBqwBkbDavDf_yCkOmJ5yXiA=@pm.me> <7d6631c07df523103ae3a89ebeedf296074d6967.camel@gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 7fd311dcca19b410ccde3cc10a899a234a026a2d
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, October 14th, 2024 at 12:38 PM, Eduard Zingerman <eddyz87@gmail.=
com> wrote:

>=20
>=20
> On Mon, 2024-10-14 at 19:03 +0000, Ihor Solodrai wrote:
>=20
> [...]
>=20
> > The elf_functions_list itself is static, this line initializes it:
> >=20
> > static LIST_HEAD(elf_functions_list);
> >=20
> > elf_functions__new() creates a new (single) elf_functions struct,
> > initializes it by collecting the functions, and adds it to the static
> > list.
> >=20
> > Maybe __new is too cryptic. What do you think about renaming to
> > elf_functions_list__add(), or maybe even split into
> > elf_functions__new() and _list__add()?
>=20
>=20
> On a second thought, it is called only from `btf_encoder__pre_cus__load_m=
odule`,
> hence I don't think it is needed as a separate function at all.

Right. No function, no need to name it :)

>=20
> [...]
>=20
> > > > @@ -2369,6 +2444,7 @@ struct btf_encoder *btf_encoder__new(struct c=
u *cu, const char *detached_filenam
> > > > goto out;
> > > > }
> > > > encoder->functions.symtab =3D encoder->symtab;
> > > > + encoder->functions.elf =3D cu->elf;
> > >=20
> > > This line is removed in a subsequent patches, is it needed because of
> > > the __delete call in the hunk above? Note, that if you want to accoun=
t
> > > for situation when multiple ELFs are processed the cu->elf might
> > > change, so that __delete call would only delete elf_functions for the
> > > last processed cu->elf.
> >=20
> > I wanted to keep intermediate patches small while maintaining that
> > nothing is broken. These lines are necessary, because on this patch
> > each encoder is still building it's own table, and each table needs a
> > reference to the elf.
>=20
>=20
> The accompanying __delete call would happen here:
>=20
> int btf_encoder__encode(struct btf_encoder *encoder)
> ...
> elf_functions__delete(elf_functions__get(encoder->functions.elf));
>=20
>=20
> Called from here:
>=20
> int main(int argc, char *argv[])
> ...
> err =3D btf_encoder__encode(btf_encoder);
>=20
> Encoders are per thread and elf table is reassigned upon each call to
> btf_encoder__new, so assume the following scenario:
> - single encoder;
> - multiple ELFs processed.

This is not what happens on this patch. Each encoder has it's own copy
of elf_functions allocated in btf_encoder__new():

=09struct btf_encoder *encoder =3D zalloc(sizeof(*encoder));

And then filled below by:

=09if (elf_functions__collect(&encoder->functions))
=09=09goto out_delete;

This part:

     encoder->functions.symtab =3D encoder->symtab;
     encoder->functions.elf =3D cu->elf;

Is necessary for elf_functions__collect() to work correctly.
And then this is freed in btf_encoder__delete():

=09for (i =3D 0; i < encoder->functions.cnt; i++)
=09=09btf_encoder__delete_func(&encoder->functions.entries[i]);
=09encoder->functions.cnt =3D 0;
=09free(encoder->functions.entries);
=09encoder->functions.entries =3D NULL;

The table created by the hook call is built *in addition* to tables
for each encoder, and then freed by elf_functions__delete() call in
btf_encoder__encode().

>=20
> In such scenario encoder->functions.elf would point to the last ELF proce=
ssed,
>=20
> thus function tables corresponding to other ELFs won't be deleted.
> (but see my suggestion below).
>=20
> > If I merge patches #3-#5, these changes would disappear. I can try
> > that, but then patch #3 will be quite big to review. What do you think?
>=20
>=20
> I think patch #3 is good as a separate patch.

This is why I thought of merging the patches. There is auxiliary code
necessary to not break intermediate state of the patchset, but it
makes review harder, because it's not obvious why this code is
there... An alternative is a bigger patch, which is also harder to review
=C2=AF\_(=E3=83=84)_/=C2=AF

>=20
> > > I think that elf_functions should be deleted in main() at the same
> > > level where btf_encoder__add_saved_funcs() is called.
> > >=20
> > > > /* index the ELF sections for later lookup */
> >=20
> > In this patch, the shared elf_functions is built but not used. It is
> > freed in btf_encoder__encode(), the line with TODO comment.
>=20
>=20
> My point was that the __delete call for all collected elf_function object=
s
> should be moved to main(). But maybe use `module_post_load()` hook instea=
d,
> look for specific `elf` and delete it from the list? This way it would be
> both symmetrical to `module_pre_load()` and encapsulated within btf_encod=
er.c.

I put the delete call in btf_encoder__encode() because I thought that
elf_functions information might be used there, but I haven't verified
that. It might be possible to do earlier.

I don't think we can do it in post_module_load hook, because
threads_collect happens before cus__load_module is done, and merge of
the encoders happens in threads_collect.

