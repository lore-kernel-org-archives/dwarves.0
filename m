Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ADA1D5AD8
	for <dwarves@vger.kernel.org>; Mon, 14 Oct 2024 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728947346; cv=none; b=InijbRj0AjNkoir5HbArar23o7DtTn4uxetDWdWn8ts5GboJ+7ePHlb+eRSzouHr+DjKTbyHVJEsBtEO5EvgZbe4O4FaQGOX44nOO4OkqiL5zMwFcOFyxOftVuFb52CjUudOt3BnTUPrPQt6kyIN6aDH+u9I+59z5mWPCVkT43I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728947346; c=relaxed/simple;
	bh=7e/5RDgY2Nydnv0L9YDpjl9nMQ+qhrnORWhJcQWSsXQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=stRCHE+7bkt6Hnv8kcqln1MH4qaOT+jlGIBQF5k8DuYqoDIHTpLDbcudVH5Tw4k2rYL6AQ3Eun/XLwdNA3BG/Jt488ch23Pzs1RLw/jHU62/OyFESiRwfaKAMOYEGDZK7y+KYj7kLrlzoepPxIx3MFcGzK+rAEO4lkN+HsnskY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=PmMqmqkE; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="PmMqmqkE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728947337; x=1729206537;
	bh=lYSQyto8qqLLjiq3sQTyhMUGDdD6izUVWzw2fDm2esg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PmMqmqkEHwEvBqXJ2kE/3FK0vgjn3TbfJbfYNRA6QBqwJPnHMHaGnW+MeW/aYJcW3
	 8wkTSfvR9QsQLnt+mPYAZcxBt/ajrlSBWD4cxZZ6YclKyyLIZmtkDxi8Vsoch74Fy0
	 NvsxrXqLDb+M6F3J1Jz104Sb/G06+ImWcti4HXFYU24BRybjenZ0Vh9o/mfAKhY1d3
	 3TqWxcdfL1FaWiL8lp++XCQhOxLfaixr6Yvop6c63133CznrMD+t6r2Q/GUG9nqkO4
	 7n+Ec/61FfgWKKdmHwKPXROsAoXQ8Gtr8Wh/Ui7EIrKFrPvyCyTDRhlJ8+b0jKjr/o
	 uA4mVgupxMhoQ==
Date: Mon, 14 Oct 2024 23:08:51 +0000
To: Eduard Zingerman <eddyz87@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org
Subject: Re: [PATCH v2 dwarves 3/5] btf_encoder: collect elf_functions in pre_cus__load_module
Message-ID: <5BZh41mSYjQZMCaMwVmgId6qPAAI1LpidzKcJYqw5Pkj94jYwwuW5jGoZDwxmPkDHE6PXE_pAumBHmjmTqGuK4MEL3xTU_xAcw5xa9vCIlQ=@pm.me>
In-Reply-To: <19a0e258889f09feb27f6bff6965edee83c2fa16.camel@gmail.com>
References: <20241009233520.989453-1-ihor.solodrai@pm.me> <20241009233520.989453-4-ihor.solodrai@pm.me> <268884d44497f30e561609ff982cfa87c1c24bb6.camel@gmail.com> <wh8Ne88FhIBrRfmV5_-tXL_BILUEFXXb6WONJvvucTJOwM56meP3VgKHyiE9qg-DIRQuR3lcmOmwGT53Xa9qBqwBkbDavDf_yCkOmJ5yXiA=@pm.me> <7d6631c07df523103ae3a89ebeedf296074d6967.camel@gmail.com> <hrfEwQ1OldXwSegRIZ9XpD6t7pJZJ6sMz7duwiE0dbi_lFlnjEphjTsjxJiakceGnR2_dNfhUp2oJrS2uShN9qHK2tf-32cFVWQS1r-eDds=@pm.me> <19a0e258889f09feb27f6bff6965edee83c2fa16.camel@gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 31277d0e5c17f316620dd96695505f25013a1297
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, October 14th, 2024 at 3:30 PM, Eduard Zingerman <eddyz87@gmail.c=
om> wrote:

[...]
>=20
> Consider the following pahole execution log when patches #1-3 are applied=
:
>=20
> $ git log --oneline next..HEAD
> ce72b07 (HEAD) btf_encoder: collect elf_functions in pre_cus__load_module
> 4369607 btf_encoder: introduce elf_functions struct type
> e4ae1a0 dwarf_loader: introduce pre/post cus__load_module hooks to conf_l=
oad
>=20
> $ git diff
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 9e05b56..8527046 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -171,6 +171,7 @@ static struct elf_functions *elf_functions__get(Elf *=
elf)
>=20
> static inline void elf_functions__delete(struct elf_functions *funcs)
> {
> + fprintf(stderr, "elf_functions__delete(%p)\n", funcs);
> free(funcs->entries);
>=20
> elf_symtab__delete(funcs->symtab);
>=20
> list_del(&funcs->node);
>=20
> @@ -197,6 +198,7 @@ static struct elf_functions *elf_functions__new(Elf *=
elf)
> goto out_error;
>=20
> list_add_tail(&funcs->node, &elf_functions_list);
>=20
> + fprintf(stderr, "elf_functions__new(), returning %p\n", funcs);
> return funcs;
>=20
> out_error:
>=20
> $ pahole --btf_encode_detached=3D/dev/null ~/work/bpf-next/kernel/bpf/ver=
ifier.o ~/work/bpf-next/kernel/bpf/core.o
> elf_functions__new(), returning 0x307653c0
> elf_functions__new(), returning 0x30aa8e10
> elf_functions__delete(0x307653c0)
>=20
> Note that only one elf_function instance is freed.

Thank you for the example, I get the problem now.

I think this would be the fix:

diff --git a/btf_encoder.c b/btf_encoder.c
index cfe23d3..5317bce 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -177,6 +177,16 @@ static inline void elf_functions__delete(struct elf_fu=
nctions *funcs)
 =09free(funcs);
 }
=20
+static inline void elf_functions__delete_all()
+{
+=09struct list_head *pos, *tmp;
+
+=09list_for_each_safe(pos, tmp, &elf_functions_list) {
+=09=09struct elf_functions *funcs =3D list_entry(pos, struct elf_functions=
, node);
+=09=09elf_functions__delete(funcs);
+=09}
+}
+
 static int elf_functions__collect(struct elf_functions *functions);
=20
 int btf_encoder__pre_load_module(Dwfl_Module *mod, Elf *elf)
@@ -2136,8 +2146,7 @@ int btf_encoder__encode(struct btf_encoder *encoder)
 =09=09err =3D btf_encoder__write_elf(encoder, encoder->btf, BTF_ELF_SEC);
 =09}
=20
-=09elf_functions__delete(elf_functions__get(encoder->functions.elf));
+=09elf_functions__delete_all();

        return err;
 }

Can't think of a better place to call elf_functions__delete_all(). On
this patch, btf_encoder__add_saved_funcs() is still called at the
entry into btf_encoder__encode().


>=20
> [...]
>=20
> > > > > I think that elf_functions should be deleted in main() at the sam=
e
> > > > > level where btf_encoder__add_saved_funcs() is called.
> > > > >=20
> > > > > > /* index the ELF sections for later lookup */
> > > >=20
> > > > In this patch, the shared elf_functions is built but not used. It i=
s
> > > > freed in btf_encoder__encode(), the line with TODO comment.
> > >=20
> > > My point was that the __delete call for all collected elf_function ob=
jects
> > > should be moved to main(). But maybe use `module_post_load()` hook in=
stead,
> > > look for specific `elf` and delete it from the list? This way it woul=
d be
> > > both symmetrical to `module_pre_load()` and encapsulated within btf_e=
ncoder.c.
> >=20
> > I put the delete call in btf_encoder__encode() because I thought that
> > elf_functions information might be used there, but I haven't verified
> > that. It might be possible to do earlier.
> >=20
> > I don't think we can do it in post_module_load hook, because
> > threads_collect happens before cus__load_module is done, and merge of
> > the encoders happens in threads_collect.
>=20
>=20
> Good point.
