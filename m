Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4757D1CC179
	for <dwarves@vger.kernel.org>; Mon, 14 Oct 2024 22:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728945058; cv=none; b=bwk9NpyD7AK/eoursSUsaJkr9GAKPyF0HevRuxvTYDs/UvFDNifFtmhV2u1GRFNI/K8fm0l6Iy6s9yEzI9V9hCZpjKtTzqJRrr6dhU+NyOjaPzgCwGmJT3bP0pxoXRMqrut6PbH5JS1KBnN/MY9oTCkRnWHqWvHSdY8b/Q3uwAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728945058; c=relaxed/simple;
	bh=8skpbBfC0yrD5zBskT2/o4ZX5OqHyglVlsfIc2YS6zw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uzoTyyzzA7g8zvv8tiwuPM1tzMuso1i8qdToZjIwnQqLLnjTacfFAgndQWhpJkSjeWgnXH5+akP5tslDtqPrrXSzgBfTC/1uJ+7Lgq7CIJ/Vnjc5JHJVD8mKrefa9P0Cr/xd8JtKvfiyyIcGS3uv0H8QsGWN4nQzu9iywhTSXEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgKNxrRy; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgKNxrRy"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e483c83dbso2895172b3a.3
        for <dwarves@vger.kernel.org>; Mon, 14 Oct 2024 15:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728945056; x=1729549856; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mp2rJUS5rNa4eRDeF4CwG/gH6qeUOSQq+CsLOThrZiA=;
        b=KgKNxrRyejpg7pQA0GwHDSxjqH3Vzu0ajhAtkDKhNyFT/Gt+4LYU0ABJjSO88fddiN
         TJ+Y/1l6b2DSDG8EKD+OLip6gvZqn0EPOcy+WzYUyv7leJGqk3Y7d72B7a1fajYIrIxp
         QEllMHOUEix2y2WbOmw8DMiL6FC92Wk3KtUP7zIWOD+9313Mgw0q3JDUY6FuCjwDSnsz
         JKjjZN1IofCluundTSWijwt9/m/d9FMAkgQS/RlVDkyNWBnsaEOIaFEUjJXih9/K7ghu
         C+pLZDkSx2UGlHIoxjushAv2IIq4pSJVXbo4kigaEul2C73q+B/Lv5/JvSYz/OY5JNZA
         Picg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728945056; x=1729549856;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mp2rJUS5rNa4eRDeF4CwG/gH6qeUOSQq+CsLOThrZiA=;
        b=tOg1Ft3DwCD4eGAVOO8R0FCFXSfU6IxbSiWuI3vdgC+mLZAX5P7btSjrN6ggTlTW+I
         PqQCnbVmGCEv96SUKSZ7Vc/pK8Pgrmwxdchr83fkxIPZwYYmhVCQbrl8+/vMNNPJk8nM
         ZXlr4eY53Ib7AFD4MRrZld5ELi5LgC6KDQtjq5bD2GSPIoUlqrS+fsfajSPXVdHGkLOP
         eqR9Li71XBfwABgelCvKoqh1vBKrHdTZBywDBxxWC7ywNMo9Z69qnU0dTVwa/vssbi4f
         j3JeqwRgdqkT9t9c5ZF1VaXVhNfVeDOIkw9BVcr9/qCvDt0dS0PuV2rE4LgZdLdVfchi
         4xRg==
X-Gm-Message-State: AOJu0YxInVoMks14ZF1sfo2el46ceLuUirxe+PPEJIodMhBVmg48K7oS
	XmUEs7IMOsNc5KCjN/NWSbRtpJdrelKgk6iKIN9sxzo5Joe7tLkktChNFg==
X-Google-Smtp-Source: AGHT+IEB+zsa2pg8aPCkn9i44UajBX3muO9en2xxY7Eo7G9WI+oaosz22xZYpYqWqRVO/hSdQcrZWg==
X-Received: by 2002:a05:6a00:189d:b0:71e:768b:700a with SMTP id d2e1a72fcca58-71e768b7107mr541846b3a.23.1728945056452;
        Mon, 14 Oct 2024 15:30:56 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e7750a55esm28707b3a.203.2024.10.14.15.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 15:30:55 -0700 (PDT)
Message-ID: <19a0e258889f09feb27f6bff6965edee83c2fa16.camel@gmail.com>
Subject: Re: [PATCH v2 dwarves 3/5] btf_encoder: collect elf_functions in
 pre_cus__load_module
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, 
	andrii@kernel.org
Date: Mon, 14 Oct 2024 15:30:51 -0700
In-Reply-To: <hrfEwQ1OldXwSegRIZ9XpD6t7pJZJ6sMz7duwiE0dbi_lFlnjEphjTsjxJiakceGnR2_dNfhUp2oJrS2uShN9qHK2tf-32cFVWQS1r-eDds=@pm.me>
References: <20241009233520.989453-1-ihor.solodrai@pm.me>
	 <20241009233520.989453-4-ihor.solodrai@pm.me>
	 <268884d44497f30e561609ff982cfa87c1c24bb6.camel@gmail.com>
	 <wh8Ne88FhIBrRfmV5_-tXL_BILUEFXXb6WONJvvucTJOwM56meP3VgKHyiE9qg-DIRQuR3lcmOmwGT53Xa9qBqwBkbDavDf_yCkOmJ5yXiA=@pm.me>
	 <7d6631c07df523103ae3a89ebeedf296074d6967.camel@gmail.com>
	 <hrfEwQ1OldXwSegRIZ9XpD6t7pJZJ6sMz7duwiE0dbi_lFlnjEphjTsjxJiakceGnR2_dNfhUp2oJrS2uShN9qHK2tf-32cFVWQS1r-eDds=@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-14 at 21:15 +0000, Ihor Solodrai wrote:

[...]

> > > > > @@ -2369,6 +2444,7 @@ struct btf_encoder *btf_encoder__new(struct=
 cu *cu, const char *detached_filenam
> > > > > goto out;
> > > > > }
> > > > > encoder->functions.symtab =3D encoder->symtab;
> > > > > + encoder->functions.elf =3D cu->elf;
> > > >=20
> > > > This line is removed in a subsequent patches, is it needed because =
of
> > > > the __delete call in the hunk above? Note, that if you want to acco=
unt
> > > > for situation when multiple ELFs are processed the cu->elf might
> > > > change, so that __delete call would only delete elf_functions for t=
he
> > > > last processed cu->elf.
> > >=20
> > > I wanted to keep intermediate patches small while maintaining that
> > > nothing is broken. These lines are necessary, because on this patch
> > > each encoder is still building it's own table, and each table needs a
> > > reference to the elf.
> >=20
> >=20
> > The accompanying __delete call would happen here:
> >=20
> > int btf_encoder__encode(struct btf_encoder *encoder)
> > ...
> > elf_functions__delete(elf_functions__get(encoder->functions.elf));
> >=20
> >=20
> > Called from here:
> >=20
> > int main(int argc, char *argv[])
> > ...
> > err =3D btf_encoder__encode(btf_encoder);
> >=20
> > Encoders are per thread and elf table is reassigned upon each call to
> > btf_encoder__new, so assume the following scenario:
> > - single encoder;
> > - multiple ELFs processed.
>=20
> This is not what happens on this patch. Each encoder has it's own copy
> of elf_functions allocated in btf_encoder__new():
>=20
> 	struct btf_encoder *encoder =3D zalloc(sizeof(*encoder));
>=20
> And then filled below by:
>=20
> 	if (elf_functions__collect(&encoder->functions))
> 		goto out_delete;
>=20
> This part:
>=20
>      encoder->functions.symtab =3D encoder->symtab;
>      encoder->functions.elf =3D cu->elf;
>=20
> Is necessary for elf_functions__collect() to work correctly.
> And then this is freed in btf_encoder__delete():
>=20
> 	for (i =3D 0; i < encoder->functions.cnt; i++)
> 		btf_encoder__delete_func(&encoder->functions.entries[i]);
> 	encoder->functions.cnt =3D 0;
> 	free(encoder->functions.entries);
> 	encoder->functions.entries =3D NULL;
>=20
> The table created by the hook call is built *in addition* to tables
> for each encoder, and then freed by elf_functions__delete() call in
> btf_encoder__encode().

Consider the following pahole execution log when patches #1-3 are applied:

$ git log --oneline next..HEAD
ce72b07 (HEAD) btf_encoder: collect elf_functions in pre_cus__load_module
4369607 btf_encoder: introduce elf_functions struct type
e4ae1a0 dwarf_loader: introduce pre/post cus__load_module hooks to conf_loa=
d

$ git diff
diff --git a/btf_encoder.c b/btf_encoder.c
index 9e05b56..8527046 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -171,6 +171,7 @@ static struct elf_functions *elf_functions__get(Elf *el=
f)
=20
 static inline void elf_functions__delete(struct elf_functions *funcs)
 {
+       fprintf(stderr, "elf_functions__delete(%p)\n", funcs);
        free(funcs->entries);
        elf_symtab__delete(funcs->symtab);
        list_del(&funcs->node);
@@ -197,6 +198,7 @@ static struct elf_functions *elf_functions__new(Elf *el=
f)
                goto out_error;
=20
        list_add_tail(&funcs->node, &elf_functions_list);
+       fprintf(stderr, "elf_functions__new(), returning %p\n", funcs);
        return funcs;
=20
 out_error:

$ pahole --btf_encode_detached=3D/dev/null ~/work/bpf-next/kernel/bpf/verif=
ier.o ~/work/bpf-next/kernel/bpf/core.o
elf_functions__new(), returning 0x307653c0
elf_functions__new(), returning 0x30aa8e10
elf_functions__delete(0x307653c0)

Note that only one elf_function instance is freed.

[...]

> > > > I think that elf_functions should be deleted in main() at the same
> > > > level where btf_encoder__add_saved_funcs() is called.
> > > >=20
> > > > > /* index the ELF sections for later lookup */
> > >=20
> > > In this patch, the shared elf_functions is built but not used. It is
> > > freed in btf_encoder__encode(), the line with TODO comment.
> >=20
> >=20
> > My point was that the __delete call for all collected elf_function obje=
cts
> > should be moved to main(). But maybe use `module_post_load()` hook inst=
ead,
> > look for specific `elf` and delete it from the list? This way it would =
be
> > both symmetrical to `module_pre_load()` and encapsulated within btf_enc=
oder.c.
>=20
> I put the delete call in btf_encoder__encode() because I thought that
> elf_functions information might be used there, but I haven't verified
> that. It might be possible to do earlier.
>=20
> I don't think we can do it in post_module_load hook, because
> threads_collect happens before cus__load_module is done, and merge of
> the encoders happens in threads_collect.

Good point.

