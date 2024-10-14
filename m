Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFE44683
	for <dwarves@vger.kernel.org>; Mon, 14 Oct 2024 18:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728931822; cv=none; b=hfQqp0vqOSyr0Cbn0AKH9sahSoHRzZCJ1ENWVmcv7HaOilnieNp0twtg99zJz5i0OVUR8gW8WwdlgXXtMgwgGmLcEhTE8AjW5HljdFEaz07BIBRQPoKvu0ywgcV+pLGzAf2QZDJlByJ2IrEHPIQvD/NyoMDwZ0hPotsojmXeNd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728931822; c=relaxed/simple;
	bh=2+kWHFgX05K5dm69o1gUsSHuCsEsNuztCDH6cR4mBwU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKmqAMqrWmDFA9w2GinbC56ZMQEKBShgRE7+sd9aLWpCvmbbZUyTa6s+JdNnpUbFj2jSZ5yNLse0aWELxlaGT3SoB8730Sel6IgpiHGWherTQ6v7sLwjS/VFampCp6XoGwMpXnVFlEgb72HjSj9My4td3UFINIYxPxpUqo2G1RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=ooUZumq2; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="ooUZumq2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728931818; x=1729191018;
	bh=2+kWHFgX05K5dm69o1gUsSHuCsEsNuztCDH6cR4mBwU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ooUZumq2B8jwD1sunnbeDY48ht2CkrqiTEabMvQu3SxvkQ2T93o279Tto0/+AF9GK
	 aeEmFIVhxC62HU5TztqZwjQhY/mzG10hCmLgiodmfkmn8t41fS6D2X7z+bCLJJujnG
	 pgrJ/zxTaMt4KxQyQ55CteswvNXt6IfiQnYNvRUYYX3+I6qjz/KyKTl2Sj92D6B/Zh
	 7Kn/AJ4AqYU8szyR9GJ9Q8t96+9u4VT9OVXFWqgb2AMqqItR8aj0Lr4BSoy6sLXDXo
	 l4vAKy1fzPF7pif79iD1XF2K4tHwLQ3XDxczDgfES5/fr6EEk349ZP+EqZpgY1UCoD
	 3ajNYU5NhP6bQ==
Date: Mon, 14 Oct 2024 18:50:14 +0000
To: Eduard Zingerman <eddyz87@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org
Subject: Re: [PATCH v2 dwarves 1/5] dwarf_loader: introduce pre/post cus__load_module hooks to conf_load
Message-ID: <6Il82Jpy0bf96RO5Vr2PRs46GF6pnbcanxCJ0oym7pDBkRpdtRddo1cv7y08lVtRyIAHyMRHlx5_iEFU21dn7NAiTdnE7uPwZB3opLJWbJo=@pm.me>
In-Reply-To: <cb5084defae910442d1dc959d8c642b82ee76744.camel@gmail.com>
References: <20241009233520.989453-1-ihor.solodrai@pm.me> <20241009233520.989453-2-ihor.solodrai@pm.me> <cb5084defae910442d1dc959d8c642b82ee76744.camel@gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 2ec644d3e3d476915ee4d93d3c66def759671fe8
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, October 10th, 2024 at 1:56 AM, Eduard Zingerman <eddyz87@gmail=
.com> wrote:

>=20
>=20
> On Wed, 2024-10-09 at 23:35 +0000, Ihor Solodrai wrote:
>=20
> [...]
>=20
> > @@ -106,6 +114,14 @@ struct conf_load {
> > struct conf_fprintf *conf_fprintf;
> > int (*threads_prepare)(struct conf_load *conf, int nr_threads, void **t=
hr_data);
> > int (*threads_collect)(struct conf_load *conf, int nr_threads, void **t=
hr_data, int error);
> > + int (*pre_cus__load_module)(struct process_dwflmod_parms *parms,
> > + Dwfl_Module *mod,
> > + Dwarf *dw,
> > + Elf *elf);
> > + int (*post_cus__load_module)(struct process_dwflmod_parms *parms,
> > + Dwfl_Module *mod,
> > + Dwarf *dw,
> > + Elf *elf);
> > };
>=20
>=20
> I'd name these `module_pre_load` and `module_post_load`.
> The `post_cus__load_module` does not seem to be used in this
> patch-set, so I'd exclude it for now.

I used these names with the idea that more hooks may be added in the
future, so a convention like pre_<exact_fname> and post_<exact_fname>
is appropriate. Maybe that's too verbose. How about `pre_load_module`?

>=20
> I'd also keep the number of parameters to the minimum,
> this patch-set defines only btf_encoder__pre_cus__load_module and it
> only uses `elf` parameter. But since the hook goal is to operate on
> modules I'd pass only Dwfl_Module and use dwfl_module_getelf to get
> a link to Elf instance.
>=20
> > /** struct conf_fprintf - hints to the __fprintf routines

When I first introduced these hooks in WIP changes some values from
parms had to be passed, which is not true for this patchset.

However I tend to agree with the approach of adding as little code as
necessary. In v3 I am removing the post hook and leaving two arguments
(elf and mod).

>=20
>=20
> [...]

