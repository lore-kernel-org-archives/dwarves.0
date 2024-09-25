Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED27487B0
	for <dwarves@vger.kernel.org>; Wed, 25 Sep 2024 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727288089; cv=none; b=OGXXe8OCvIb0+Jdq8knOyod/UwrwilNoBIK73IwApCtjbW1PBjOL5dPWMoiIBTWNJvMHv3mDAsS+T/4q8u+O7wRUfBw9bj4gHGnWywaRgnCsDVIwfWAA8U6L1ddK6Q7YRyMzSp6yDDeRQSzuu7hZtKGQ/z7+BZMKor/lPjxIvxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727288089; c=relaxed/simple;
	bh=P5FsnnlnS2KRDKVh/C1xu/eQDZHeZaLkZKKf1z10NoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nLagBOzzZZMAzNMStoIzF2+ZRPi0HwEhf8PB6KXRJ+OZjI+IwFmXE80hPdX1POJMDqo+Qdb1y+yrvzJVPG+vsqIE5mf84kAhd6aQP96QDD5SPF4LKcvMdMcHOhGWxJoMFJ25X+T5GV8TShbQYhgfonwfvNg3BHUoIuSjhExJ1H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr; spf=none smtp.mailfrom=obs.cr; dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b=y618Np41; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=obs.cr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="y618Np41"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6c54a5fbceeso1075906d6.2
        for <dwarves@vger.kernel.org>; Wed, 25 Sep 2024 11:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1727288086; x=1727892886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVt8oOofTX7bHIWlQcajs1qP006KjmeHPn1D58lmWpM=;
        b=y618Np41JDByqI4SJKs6mA+3+ZXMfOKNtq9VQq/hEClNqkshu5QLI0lTqH/AQWvl1B
         XLt+/yC4sZ5zUitUqcLmmTs4tP3dj4KuJjZsZVO72WxZ9DN1VsmuIKB2njJOq7gO3+YG
         Xkaiz4dk2OiKRIIrQ6DFSj1bOJAgI72qxeulpqlDSvBSti5xvpzJLJZaNiLJFunY/4wz
         SFoNFK/QVVv5HJOSpFJf+NkYtgFAXm3VmoXUbcCYJnR4os95G76OI855Boa3Ette6qR5
         VsRzL/IEdycHxs9pjGy/ZAA/LVQXGJCFwXZdnwQ+/C4muWTW0I+2barkRh2b2M6ER2IN
         4OHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727288086; x=1727892886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVt8oOofTX7bHIWlQcajs1qP006KjmeHPn1D58lmWpM=;
        b=I1Jwzeekin5MBJCky5D9rn/65JzlnHeKBFmySyB0VmJjbIhkS3k+4qrSfFOjP4jrn9
         zoyIBUN6dnAzz67KFeK6h2vHN4WQXQztl1BLNtIvljgCK2q9cQ1/xb/ND1zODmxVnnNr
         UrpKuYG3u/Er5aY0ElNh2nni9GfU5HySfiEe9OMSWkZxhp3tgqBP8Z3G2yom4NoCmtnY
         TuF+eoE9jtuz5ksrFDroXP54kXGjyr5G8Sk+Q7d2rXI2ZvWW85UJWedK46FV6UeJXFX6
         zJ9EC3RMPYsdzbpjXM82kLqoH+BBl9/Plaxml8HNOyRDHA1CpKeFTDD/T2Qm0rTAqe+F
         QxPw==
X-Gm-Message-State: AOJu0YzhezkPYNJJAvY0pJaV5h7uqn5HZ/VTfFIWkic3sTPL9Z/l7x7J
	s0QEgCxSH/8TQ2lswkH5xD0CPjb85hfYqiU5amAr8yajmWvFGjCPsKz/dGhpDI0zUhuZbhMrbUh
	6DZkrci2dR+s+2UYZM6h3bJRkwvyWEly34P0vLQ==
X-Google-Smtp-Source: AGHT+IG06CgIB+fyPwy06UvnDBLtMQXSPawsNSVGJ74QtM7N5yVk/vigcv32opvCjVhXcARe84D7jB717f1JDnsflnE=
X-Received: by 2002:a05:6214:5685:b0:6cb:2f12:fd4e with SMTP id
 6a1803df08f44-6cb2f1300eemr5776446d6.48.1727288085651; Wed, 25 Sep 2024
 11:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4f09aa78-8a42-44dd-a685-37d6b9db7415@oracle.com>
 <20240919033057.2658569-2-hawkinsw@obs.cr> <f66e0667-37d8-40e7-9642-fc3bfa9ce678@oracle.com>
In-Reply-To: <f66e0667-37d8-40e7-9642-fc3bfa9ce678@oracle.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Wed, 25 Sep 2024 14:14:35 -0400
Message-ID: <CADx9qWjuhkcPdihbNtn7TVWf8OtkXkKjHwVf8_V=2xSMWmrSOQ@mail.gmail.com>
Subject: Re: [PATCH 1/1 v2] dwarves_fprintf: Handle pointer qualifiers correctly
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 6:07=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 19/09/2024 04:30, Will Hawkins wrote:
> > In certain cases, type qualifiers were attached to the wrong part
> > of a type.
> >
> > In C-like languages, a basic variable declaration can be augmented
> > with certain _qualifiers_. Qualifiers are used in declarations by the
> > programmer to specify additional properties about the type being
> > declared. When it comes to applying qualifiers to pointer types,
> > placement can sometimes be tricky.
> >
> > Because of the hierarchical nature of type encoding in both BTF and
> > DWARF, the representation of such confusing types is more natural.
> >
> > For example
> > volatile -> ptr -> const -> int
> > is the "chained" list of types that will exist (with a few minor
> > differences between the formats) for BTF and DWARF to encode a
> > volatile pointer to a constant int.
> >
> > To display types like these correctly, the modifier that applies
> > to the pointer must be a suffix modifier printed after the pointer,
> > and the modifier that applies to the pointer target must be printed
> > before the pointer.
> >
> > This patch teaches the dwarves family of programs to print qualified
> > pointer types correctly.
> >
> > Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
>
> Looks great, thanks for adding these valuable descriptions!
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>
> Future work for us as a community in general is to improve automated
> testing ; in the case of functionality like this, we could perhaps look
> at adding some simple programs that exercise complex type relationships
> and verify that everything is printed as expected. If you wanted to add
> a test in this area, your example from the v1 cover letter would be a
> great addition. We've started populating the tests/ directory, but more
> contributions in that area would be really valuable. Thanks again!

Thank you (again!) for being so welcoming! I saw that you were
starting to populate the test directory and I *will* start adding
tests.

Again, thank you for everything!
Will


>
> Alan
>
> > ---
> >
> > Notes:
> >             v1 -> v2:
> >                     Add additional comments inline.
> >                     Properly format comments using /**/.
> >                     Be more verbose in the commit message.
> >
> >  dwarves_fprintf.c | 90 ++++++++++++++++++++++++++---------------------
> >  1 file changed, 50 insertions(+), 40 deletions(-)
> >
> > diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> > index 54d2fc2..2c53638 100644
> > --- a/dwarves_fprintf.c
> > +++ b/dwarves_fprintf.c
> > @@ -542,16 +542,6 @@ static const char *tag__ptr_name(const struct tag =
*tag, const struct cu *cu,
> >                       char tmpbf[1024];
> >                       const char *const_pointer =3D "";
> >
> > -                     if (tag__is_const(type)) {
> > -                             struct tag *next_type =3D cu__type(cu, ty=
pe->type);
> > -
> > -                             if (next_type && tag__is_pointer(next_typ=
e)) {
> > -                                     if (!(conf && conf->skip_emitting=
_modifier))
> > -                                             const_pointer =3D "const =
";
> > -                                     type =3D next_type;
> > -                             }
> > -                     }
> > -
> >                       snprintf(bf, len, "%s %s%s",
> >                                __tag__name(type, cu,
> >                                            tmpbf, sizeof(tmpbf), conf),
> > @@ -612,25 +602,68 @@ static const char *__tag__name(const struct tag *=
tag, const struct cu *cu,
> >       case DW_TAG_restrict_type:
> >       case DW_TAG_atomic_type:
> >       case DW_TAG_unspecified_type:
> > +             /*
> > +             * In C-like languages, a basic variable declaration can b=
e augmented
> > +             * with certain _qualifiers_. In C++, the standard refers =
to them as
> > +             * cv-qualifiers (decl.type.cv). In C, the standard refers=
 to them as
> > +             * type qualifiers (6.7.3). Qualifiers are used in declara=
tions by the
> > +             * programmer to specify additional properties about the t=
ype being
> > +             * declared. When it comes to applying qualifiers to point=
er types,
> > +             * placement can sometimes be tricky.
> > +             * Example 1: "const int * foo": The target of the pointer=
 is const.
> > +             * Example 2: "const int * volatile foo" means that the ta=
rget of the
> > +             * pointer is const * ("const int *") _and_ the pointer it=
self (volatile
> > +             * foo) is volatile.
> > +             * Example 3: "volatile int * volatile foo" means that bot=
h the target
> > +             * of foo _and_ the pointer itself are volatile.
> > +             *
> > +             * Note: cdecl(1) is a fun command-line tool for helping d=
ecode the
> > +             * meaning of these complicated type signatures.
> > +             *
> > +             * Because of the hierarchical nature of type encoding in =
both BTF and
> > +             * DWARF, the representation of such confusing types is mo=
re natural.
> > +             * For example
> > +             *
> > +             * volatile -> ptr -> const -> int
> > +             *
> > +             * is the "chained" list of types that will exist (with a =
few minor
> > +             * differences between the formats) for BTF and DWARF to e=
ncode a
> > +             * volatile pointer to a constant int. To display types li=
ke these
> > +             * correctly, the modifier that applies to the pointer mus=
t be a
> > +             * suffix modifier printed after the pointer, and the modi=
fier that
> > +             * applies to the pointer target must be printed before th=
e pointer.
> > +             */
> >               type =3D cu__type(cu, tag->type);
> >               if (type =3D=3D NULL && tag->type !=3D 0)
> >                       tag__id_not_found_snprintf(bf, len, tag->type);
> >               else if (!tag__has_type_loop(tag, type, bf, len, NULL)) {
> >                       char tmpbf[128];
> > -                     const char *prefix =3D "", *suffix =3D "",
> > +                     const char *prefix_modifier =3D NULL, *suffix_mod=
ifier =3D NULL,
> >                                  *type_str =3D __tag__name(type, cu, tm=
pbf,
> >                                                          sizeof(tmpbf),
> >                                                          pconf);
> >                       if (!pconf->skip_emitting_modifier) {
> > +                             const char **modifier =3D &prefix_modifie=
r;
> > +
> > +                             /* If the modifier is addressing a pointe=
r, then we will need
> > +                              * put it after the type that is being pr=
inted.
> > +                              */
> > +                             if (tag__is_pointer(type))
> > +                                     modifier =3D &suffix_modifier;
> > +
> >                               switch (tag->tag) {
> > -                             case DW_TAG_volatile_type: prefix =3D "vo=
latile "; break;
> > -                             case DW_TAG_const_type: prefix =3D "const=
 "; break;
> > -                             case DW_TAG_restrict_type: suffix =3D " r=
estrict"; break;
> > -                             case DW_TAG_atomic_type:   prefix =3D "_A=
tomic ";  break;
> > +                             case DW_TAG_volatile_type: *modifier =3D =
"volatile"; break;
> > +                             case DW_TAG_const_type: *modifier =3D "co=
nst"; break;
> > +                             case DW_TAG_restrict_type: suffix_modifie=
r =3D " restrict"; break;
> > +                             case DW_TAG_atomic_type:   *modifier =3D =
"_Atomic";  break;
> >                               }
> >                       }
> > -                     snprintf(bf, len, "%s%s%s%s", prefix, type_str, s=
uffix,
> > -                              pconf->no_parm_names ? "" : " ");
> > +                     snprintf(bf, len, "%s%s%s%s%s%s", prefix_modifier=
 ? prefix_modifier : "",
> > +                                                                      =
                 prefix_modifier ? " " : "",
> > +                                                                      =
                 type_str,
> > +                                                                      =
                 suffix_modifier ? " " : "",
> > +                                                                      =
                 suffix_modifier ? suffix_modifier : "",
> > +                                                                      =
                 pconf->no_parm_names ? "" : " ");
> >               }
> >               break;
> >       case DW_TAG_array_type:
> > @@ -833,8 +866,6 @@ inner_struct:
> >               tconf.suppress_offset_comment =3D suppress_offset_comment=
;
> >       }
> >
> > -     const char *modifier;
> > -
> >  next_type:
> >       switch (type->tag) {
> >       case DW_TAG_pointer_type: {
> > @@ -870,7 +901,6 @@ next_type:
> >               /* Fall Thru */
> >       }
> >       default:
> > -print_default:
> >               printed +=3D fprintf(fp, "%-*s %s", tconf.type_spacing,
> >                                  tag__name(type, cu, tbf, sizeof(tbf), =
&tconf),
> >                                  name);
> > @@ -879,26 +909,6 @@ print_default:
> >               printed +=3D ftype__fprintf(tag__ftype(type), cu, name, 0=
, 0,
> >                                         tconf.type_spacing, true, &tcon=
f, fp);
> >               break;
> > -     case DW_TAG_atomic_type:
> > -             modifier =3D "_Atomic";
> > -             goto print_modifier;
> > -     case DW_TAG_const_type:
> > -             modifier =3D "const";
> > -print_modifier: {
> > -             if (!conf->skip_emitting_modifier) {
> > -                     size_t modifier_printed =3D fprintf(fp, "%s ", mo=
difier);
> > -                     tconf.type_spacing -=3D modifier_printed;
> > -                     printed            +=3D modifier_printed;
> > -             }
> > -
> > -             struct tag *ttype =3D cu__type(cu, type->type);
> > -             if (ttype) {
> > -                     type =3D ttype;
> > -                     goto next_type;
> > -             }
> > -     }
> > -             goto print_default;
> > -
> >       case DW_TAG_array_type:
> >               printed +=3D array_type__fprintf(type, cu, name, &tconf, =
fp);
> >               break;
>
