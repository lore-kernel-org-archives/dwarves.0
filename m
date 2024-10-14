Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED28231C92
	for <dwarves@vger.kernel.org>; Mon, 14 Oct 2024 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728932627; cv=none; b=S+jr0jFVkIWqZDlEB/Gf2MwO3JrwNFS4OPRWNHqP/Cy+EV8wLx/HPrJeDucKgD7+O6iX+9OHBCj/Eki2F6m7XEUTILO6N/0r6qDIpe5oZyCAc6pYn2UK0SaVEKhsIZ+fXqsflxRdGoyizHgL94/t2FMFBliXr0vUV1PToS6MoSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728932627; c=relaxed/simple;
	bh=H7VSBhwNFWwuKcdJw9drvI2rDd/zSuKwNhSzMdGFsGE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SOWaOfSEN8+c9GEK9uWnUXLeCjmGrwkqp3P/d6Wo7kWJ3Cw9h84e90nZ1fUrhUA9onrwMHA+T/UrEeOIeDjHWa6H4CyMImijA9x+NGa+iLiz5MVspVp4mb5eEGJ2uEtw4id/uTVgn3oxisnEVCCBx6mOTvyNrd1+w+2QXe4g5sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Mjy93bN6; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Mjy93bN6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728932623; x=1729191823;
	bh=GPv5WPW9zG2U/xlegnfRCwci7kSGgatOu4z22xbxYvs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Mjy93bN6Cs8DzTwkdxG7nkqXdvGl2kcBNkTkLM9N4TZgvA58L1EWXFTbF3M4uhd9l
	 s6IO5/7CyFGkIR6YWqqM/STWE8ndt2e8/w8jbY2fhgk+T/ATVLsBtd63cHIGfUdy4Z
	 Uhqf5mxpwyBvuRqIQjjo5RMgN6eQdbzGnfwLHC1PK3Jl9cVRBAMQckuqQCmyptdV9j
	 GMHvjHONx8O/ZUjmeTpRAj9Ws1kSbvKAd8/TxU8X9yrSUUMo9AYUUDf2ia2zoEZh/I
	 S9sq6HrZ8eVXo4l0nuRTBmkHiEDBICbF1xhkoZQfANk4rURAF/oQBVMKC/JvQqm9UE
	 1xyJXtofRUEPA==
Date: Mon, 14 Oct 2024 19:03:30 +0000
To: Eduard Zingerman <eddyz87@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org
Subject: Re: [PATCH v2 dwarves 3/5] btf_encoder: collect elf_functions in pre_cus__load_module
Message-ID: <wh8Ne88FhIBrRfmV5_-tXL_BILUEFXXb6WONJvvucTJOwM56meP3VgKHyiE9qg-DIRQuR3lcmOmwGT53Xa9qBqwBkbDavDf_yCkOmJ5yXiA=@pm.me>
In-Reply-To: <268884d44497f30e561609ff982cfa87c1c24bb6.camel@gmail.com>
References: <20241009233520.989453-1-ihor.solodrai@pm.me> <20241009233520.989453-4-ihor.solodrai@pm.me> <268884d44497f30e561609ff982cfa87c1c24bb6.camel@gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 2087ec95999649e8d603bc56d144e30d854d12b6
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
> [...]
>=20
> > diff --git a/btf_encoder.c b/btf_encoder.c
>=20
>=20
> [...]
>=20
> > +static struct elf_functions *elf_functions__new(Elf *elf)
> > +{
>=20
>=20
> I think this function should be renamed to elf_functions_list_init()
> and it should return int.

The elf_functions_list itself is static, this line initializes it:

    static LIST_HEAD(elf_functions_list);

elf_functions__new() creates a new (single) elf_functions struct,
initializes it by collecting the functions, and adds it to the static
list.

Maybe __new is too cryptic. What do you think about renaming to
elf_functions_list__add(), or maybe even split into
elf_functions__new() and _list__add()?

>=20
> [...]
>=20
> > @@ -2071,6 +2139,13 @@ int btf_encoder__encode(struct btf_encoder *enco=
der)
> > #endif
> > err =3D btf_encoder__write_elf(encoder, encoder->btf, BTF_ELF_SEC);
> > }
> > +
> > + // TODO: after moving encoders to shared elf_functions,
> > + // replace elf_functions__get(encoder->functions.elf) here
> > + // with encoder->functions
> > + // The pointer to shared elf_functions will be set in btf_encoder__ne=
w
>=20
>=20
> Nit: the TODO comment is not necessary here, as described change is
> done later in the patch.
>=20
> > + elf_functions__delete(elf_functions__get(encoder->functions.elf));
> > +
> > return err;
> > }
> >=20
> > @@ -2369,6 +2444,7 @@ struct btf_encoder *btf_encoder__new(struct cu *c=
u, const char *detached_filenam
> > goto out;
> > }
> > encoder->functions.symtab =3D encoder->symtab;
> > + encoder->functions.elf =3D cu->elf;
>=20
>=20
> This line is removed in a subsequent patches, is it needed because of
> the __delete call in the hunk above? Note, that if you want to account
> for situation when multiple ELFs are processed the cu->elf might
>=20
> change, so that __delete call would only delete elf_functions for the
> last processed cu->elf.
>

I wanted to keep intermediate patches small while maintaining that
nothing is broken. These lines are necessary, because on this patch
each encoder is still building it's own table, and each table needs a
reference to the elf.

If I merge patches #3-#5, these changes would disappear. I can try
that, but then patch #3 will be quite big to review. What do you think?


>=20
> I think that elf_functions should be deleted in main() at the same
> level where btf_encoder__add_saved_funcs() is called.
>=20
> > /* index the ELF sections for later lookup */

In this patch, the shared elf_functions is built but not used. It is
freed in btf_encoder__encode(), the line with TODO comment.

>=20
>=20
> [...]

