Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F761CC16F
	for <dwarves@vger.kernel.org>; Mon, 14 Oct 2024 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728934729; cv=none; b=oM1Ce3wbDrEcy65qugUZrQ+YgE8TwNMIm7ZbNPkEph8ARxKxaupQv9OHq4+mWpOws7fleFNh93wFcYxR3TPp1B4fnheqBGViQJjujqyOeD4UYjfh48JiM7Y5H0EsiMKww+hHcW5koekABtkR0nJyns1nQue41d49tSJcwkDhTrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728934729; c=relaxed/simple;
	bh=XjLQGtNmOM3UojqDlnCcke9kCnNoToOqlSP1P6JvK4k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GlNHo+ZdqnDz//RsBN7EnP4drh6s3RefB9pBDpjl5o+NUa9XeLAHNftdWmeSr78RBb+pqdtls7lPuxIdaP2OhLl9PRfXaYlZeaHMzAIqVf84yCYXkR4mS4Haj5yAfGKgqK/Tn71d8LugztKVVDJrYKXW0BG/Eqgqvre7/AMOI6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kS6HTYBn; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kS6HTYBn"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e6f085715so726258b3a.2
        for <dwarves@vger.kernel.org>; Mon, 14 Oct 2024 12:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728934727; x=1729539527; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y0oZl5qsv4aLTfPMVq6ks3tKmD5bNVS6YcIOIcE5nO0=;
        b=kS6HTYBneqw4jac05dqjsOKqiAGwCTG4Jo5HBTk2kCqaXbkyT6qiG0TBWVWunr5mIs
         RVcDnZ61Swl8kT4t9FvpfAq/o/6+wHq0ZWXAgyml3UjO8MSeO/uvbRmm7Ccjzs/Zk+rj
         7fKv5DNgwoOT/dehygQDQAbNiX8rbiv7gDO6+lxU44+a++JV/ja4BL5I0tu51yqgUcP1
         wcBPda7WvGInUR05AR2h9uJ1Aoql3nYtoKUkAfKpx+5I6GC4Z3TJZMNgIaYy+cXo+18E
         6IlfY96fvhXZ3LF9KxNGGNQXkbsFq3UI8i4r3h8Y/Hedg6ZoCEhWN5PROgYRrYEjmm1b
         MJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728934727; x=1729539527;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y0oZl5qsv4aLTfPMVq6ks3tKmD5bNVS6YcIOIcE5nO0=;
        b=ok69BMmvXTblFo27sMDudZGTdHbnAqKZ7f3bTRR/cWXPQDSHTDdkbz8Fb1GlmuFxCr
         1bEXC/nfTB2Y6slcvj4AT2dSRyzf0OUYSoGa+ZZU7XD6dbZ9GsanwvoQn/FXRxARoM5U
         wS0NsQmnOjLIaxPdVhy7DAepD3oWYvKXrA5Pecge7RKEbkUoIi+jaqUcKkRY0aYd8UFB
         qFeFwgNG4ydDsXyrNnTcbgYnDC/9DnuB7qQhx6YhWxW3qCZANKL+Zv6UUkVhIUvB8FmA
         jl2Gl1UETj08Ib62knn98anQNu/CoWWIzhTAXEDoHRqBMNkTH2kwl8G3S+P9AlFSSL7x
         muZQ==
X-Gm-Message-State: AOJu0YwdwjkjA4Vn17Cy9Y2kwNgEtsSBhYlz9rAEIaVUZeZ7ZzWmAsno
	qhJdVA3dm0rc+ahT+UzS9Sc7Ci0GN4eVl+e62HhiXuyFFmgtBX4O
X-Google-Smtp-Source: AGHT+IE3KhH0Wk9G2SrdgaeJVes1eSkySod558gDSD4jn2thnRRrW0f/lsjDRMASkYUye60GvEWmJw==
X-Received: by 2002:a05:6a00:23c7:b0:71e:695:41ee with SMTP id d2e1a72fcca58-71e4c139383mr14352743b3a.5.1728934727092;
        Mon, 14 Oct 2024 12:38:47 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e725b36a1sm665089b3a.73.2024.10.14.12.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 12:38:46 -0700 (PDT)
Message-ID: <7d6631c07df523103ae3a89ebeedf296074d6967.camel@gmail.com>
Subject: Re: [PATCH v2 dwarves 3/5] btf_encoder: collect elf_functions in
 pre_cus__load_module
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, alan.maguire@oracle.com, 
	andrii@kernel.org
Date: Mon, 14 Oct 2024 12:38:41 -0700
In-Reply-To: <wh8Ne88FhIBrRfmV5_-tXL_BILUEFXXb6WONJvvucTJOwM56meP3VgKHyiE9qg-DIRQuR3lcmOmwGT53Xa9qBqwBkbDavDf_yCkOmJ5yXiA=@pm.me>
References: <20241009233520.989453-1-ihor.solodrai@pm.me>
	 <20241009233520.989453-4-ihor.solodrai@pm.me>
	 <268884d44497f30e561609ff982cfa87c1c24bb6.camel@gmail.com>
	 <wh8Ne88FhIBrRfmV5_-tXL_BILUEFXXb6WONJvvucTJOwM56meP3VgKHyiE9qg-DIRQuR3lcmOmwGT53Xa9qBqwBkbDavDf_yCkOmJ5yXiA=@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-14 at 19:03 +0000, Ihor Solodrai wrote:

[...]

> The elf_functions_list itself is static, this line initializes it:
>=20
>     static LIST_HEAD(elf_functions_list);
>=20
> elf_functions__new() creates a new (single) elf_functions struct,
> initializes it by collecting the functions, and adds it to the static
> list.
>=20
> Maybe __new is too cryptic. What do you think about renaming to
> elf_functions_list__add(), or maybe even split into
> elf_functions__new() and _list__add()?

On a second thought, it is called only from `btf_encoder__pre_cus__load_mod=
ule`,
hence I don't think it is needed as a separate function at all.

[...]

> > > @@ -2369,6 +2444,7 @@ struct btf_encoder *btf_encoder__new(struct cu =
*cu, const char *detached_filenam
> > > goto out;
> > > }
> > > encoder->functions.symtab =3D encoder->symtab;
> > > + encoder->functions.elf =3D cu->elf;
> >=20
> > This line is removed in a subsequent patches, is it needed because of
> > the __delete call in the hunk above? Note, that if you want to account
> > for situation when multiple ELFs are processed the cu->elf might
> > change, so that __delete call would only delete elf_functions for the
> > last processed cu->elf.
>=20
> I wanted to keep intermediate patches small while maintaining that
> nothing is broken. These lines are necessary, because on this patch
> each encoder is still building it's own table, and each table needs a
> reference to the elf.

The accompanying __delete call would happen here:

    int btf_encoder__encode(struct btf_encoder *encoder)
        ...
        elf_functions__delete(elf_functions__get(encoder->functions.elf));

Called from here:

    int main(int argc, char *argv[])
        ...
        err =3D btf_encoder__encode(btf_encoder);

Encoders are per thread and elf table is reassigned upon each call to
btf_encoder__new, so assume the following scenario:
- single encoder;
- multiple ELFs processed.

In such scenario encoder->functions.elf would point to the last ELF process=
ed,
thus function tables corresponding to other ELFs won't be deleted.
(but see my suggestion below).

> If I merge patches #3-#5, these changes would disappear. I can try
> that, but then patch #3 will be quite big to review. What do you think?

I think patch #3 is good as a separate patch.

> > I think that elf_functions should be deleted in main() at the same
> > level where btf_encoder__add_saved_funcs() is called.
> >=20
> > > /* index the ELF sections for later lookup */
>=20
> In this patch, the shared elf_functions is built but not used. It is
> freed in btf_encoder__encode(), the line with TODO comment.

My point was that the __delete call for all collected elf_function objects
should be moved to main(). But maybe use `module_post_load()` hook instead,
look for specific `elf` and delete it from the list? This way it would be
both symmetrical to `module_pre_load()` and encapsulated within btf_encoder=
.c.

