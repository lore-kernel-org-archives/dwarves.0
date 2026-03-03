Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6243264D1
	for <dwarves@vger.kernel.org>; Tue,  3 Mar 2026 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772557026; cv=pass; b=tsZStZOHVlcMsnp6VelMbie9JWRgxyqj84KxDu7Dw/7trSItr3jcioy1qt/3l14zM34MU8d34WaO8l3l6T0kAGo875d9OAqbo6TQ1EU+RRAhUDakK47D/8R/aM0tlFL9oCXmKet8qapnq0oOkWRmmdGUY+Lm81pb9m/ncaUZbN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772557026; c=relaxed/simple;
	bh=IEGVLKkyRX2CmiVfdaYDuDbH8C7Ff9yzlnH/vBjXtYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmhqiutHCTOnZWq1eTPj7hW9w5BfxB7A1rYME3h5pIcBl3EoOGfh2Xeo3TRU+TK1tvHZ2lhntpMbOzHDOvEDMHGm+gGfj0TeqX/yuLiNxDZkqJelI21U/I2xLZyJzce61c4C4N3qXcakac/iq5a6ujiGXu/RDaiemIKLe/Mxtik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lj9zqURz; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lj9zqURz"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-436e87589e8so5648150f8f.3
        for <dwarves@vger.kernel.org>; Tue, 03 Mar 2026 08:57:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772557023; cv=none;
        d=google.com; s=arc-20240605;
        b=QPVWL3sBkdRIBtIkCCcovkERs3bI94VvROKG3Rc2KU0tyh4c7npsielQSh2ldUw9BW
         aqJ89nnwFH85kwdFUQc7VJT9jxQ8ZzD+k5mrRusdNmwZh16e2Zcu1naD7pJUQ9/lwI9A
         SRpUX163l5k27Hrx9hIHxgcoBRps3etrYu1qLjql8DMSXgdkvKwTRqoFvEn1d5TxC0GS
         lg2hwZcYw573jy6b+sesAEPV1CBLa+PSxCS4PlaQLENV74bll+Ls1Ds85Ehx0KIYxrvD
         lZeqjlCcbwatn0k9LTi9NCGsWu5Ckb5DcIWgPEgFJyVNJtOJp8Mwp2H3uid0Xwc4zWl3
         A53A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qmVVCwSx9gOlnl+9iTJ9vMHKCvwk//C3zJgzS58JBmI=;
        fh=wd80/wOWfDvwHNQa6J1ohtTlaSXk6QPb+4de4yqTI/U=;
        b=WytL7XLPZ3fPmwMqxrpSuw4GJj2b9BRkPvkrubFPvDnjCGiLRMyHJdlXtTJ+/WeFAf
         Kbg17OmE2G9ozs/SH66ctTHqpMAYPT3JgOqs7CGSnP9X8cwPQFAp2ucjcS5cfme9qeiI
         FtFFeg61LA6cbp5WEqRujoyf4U7KpEu2pMuLbAJPSU7fmTAt1RcU5UhPDK5VcnKnM2wi
         YC80YFCVSq1XpIE7+mqk/owYyIQwEVp96fdmqwcFQRj/jepZbQXgpOozfH/lqodAFLMP
         hGXh+eZSXWEmRUqE4FI0obkSp7yIu4SyWCD2GuKDrLCghiW3KMmH2bVEjnrBiWR1mEjD
         kqzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772557023; x=1773161823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmVVCwSx9gOlnl+9iTJ9vMHKCvwk//C3zJgzS58JBmI=;
        b=Lj9zqURzNEwtfWqsR6wAOon+6hxNt4Y/9m5ZHCCM5+0J3X35H1c6xIf9a0XKRVXJRg
         yA8pm0wdvIDcTWwz3abpmH582Sxp7cfrBEtYnyeOlub+8faqYZNVaNOI/SR6QQWbDziu
         eAohHWIPPA4hpUFAYId96u5AqawwtUgkFNQOtroQFeqMCrzLTijER2H8YWdA3fGMikzY
         5/n/eT3SbupvRy/D7hLgLaqgxTwfhIhK5NKA38qbuQ4DT5eYUQY6SoDffytj7OEwHEQK
         +4RM6ApZjxFmfon4DrtKU0BP5f8S0eqmsZUdYeXv1Ffx04eNWnIVDlDGTNo2Hv3h4eKw
         vG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772557023; x=1773161823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qmVVCwSx9gOlnl+9iTJ9vMHKCvwk//C3zJgzS58JBmI=;
        b=tgoha44HDsc/FzBhKMSkNPuBf/+5eZrP7iMuofkAjGsI1DqUPxsPsTZ+CEjhosNco+
         OgG6KgJfARibnHYEJGV+6SqN28APBSC/KZ+HFnbc8zYFxO2C76NY7oNIlC2/Tg+TEf4u
         RDFvr1cbBPslu3yUxxuKFJfzraj6soMV6lUJujJzX0VMeKzTCzCIyuFvPzqO5SEjT86W
         eDOI0jzpP/apM4kb446A0JplJ3a2mHXhsWioGhmZvreKWNezqzUT8ILnp377kfLzMYK2
         jVKknbaUhyI/EihL3x18kXXFu2jodqpQ4fEUFs7IUJBKmNbZFVrtF97Ln1Q1rfmOddMe
         t0eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtdcm5plexmsbkk+wfAoZJeDcSkNSWCSvVvYNjIKt/wAkp8ARRa7CBdvdXlT9Lidbh6lDQN6rp@vger.kernel.org
X-Gm-Message-State: AOJu0YykN81TmcZFPxWTcIrdyOeLY3SokL9cAJH5UyuMD66f4wjv4nXO
	BWdhHP1L5+5kkyKYAAwiYm+prX8TY0o4z32+jBWbFZVgEiUW6ICxeGRjquJJ0DgCYLwpUXnoiTs
	iwNnlYK9kwTIMyPdsbnzyM9vPcqSNhQU=
X-Gm-Gg: ATEYQzxxkKAAmn8XA6aEf4MRbQCrgMbeBtwhDZJbybdK27/rbZoI7px/vD+z52J0Jgs
	g1zuFXY4zx/BTL6oAzGYzlJfRZKDmUmbLmPAzkxLPhcygUCetpmLBqwlVYMMXUHH4RwZWzvH8ga
	i8jCcVVvGIdrruPaQ2JOQbiNGMrUTKqfYB8fAx6rmwO+Ih0oedqI7h2LLj/f9OHjjYRjGyUnbbL
	le1hAd8RdZnBt/w0Heey6nV4f/pLGtxtxLv+prR5fMejngzoTdOD65WRHJ9Lg4ocd50gpAXISNp
	zquy8uFPeRBGQZUZkTcNxAEI2a4TSiVCRRQDRqS3DqZQWhzVdvxWrPG/k40ycU8Ie/9oNj05gnJ
	0y2mMfkeS6vsaw3+hV/NLgXQkww==
X-Received: by 2002:a05:6000:238a:b0:439:c550:d92a with SMTP id
 ffacd0b85a97d-439c550d9d5mr1891155f8f.53.1772557022817; Tue, 03 Mar 2026
 08:57:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302114059.3697879-5-alan.maguire@oracle.com> <81e5bdca3b0c4eb5703b200781e30fa14ac256ba8042bb27dac98d28e743b7de@mail.kernel.org>
In-Reply-To: <81e5bdca3b0c4eb5703b200781e30fa14ac256ba8042bb27dac98d28e743b7de@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Mar 2026 08:56:51 -0800
X-Gm-Features: AaiRm533ZWMH1jUzT31LWneje3U3H1DGZ53i3enu89tT9WS4SvRK1TKsMHFeFOs
Message-ID: <CAADnVQLSndJcV1wdBLZ8NP5_-do4cyJeQEGG+o03mJh3tPWi7A@mail.gmail.com>
Subject: Re: [PATCH v11 bpf-next 4/8] libbpf: Add layout encoding support
To: bot+bpf-ci@kernel.org
Cc: Alan Maguire <alan.maguire@oracle.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	dwarves <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 4:18=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 9f4d1bd73b4d..e87003711543 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
>
> [ ... ]
>
> > @@ -1186,12 +1229,26 @@ static struct btf *btf_new_empty(struct btf *ba=
se_btf)
> >
> >  struct btf *btf__new_empty(void)
> >  {
> > -     return libbpf_ptr(btf_new_empty(NULL));
> > +     LIBBPF_OPTS(btf_new_opts, opts);
> > +
> > +     return libbpf_ptr(btf_new_empty(&opts));
> >  }
>
> This isn't a bug, but Eduard Zingerman noted in v8 review that
> btf_new_empty(NULL) should work fine because OPTS_GET already
> handles NULL opts by returning default values. The LIBBPF_OPTS
> wrapper could be simplified back to just passing NULL here.
>
> https://lore.kernel.org/bpf/1456370aa292410bdda4bff85bead8e091675f4c.came=
l@gmail.com/

Agree with Eduard here. Why change it?

Also AI review on patch 6 makes sense too.
Pls respin.

pw-bot: cr
