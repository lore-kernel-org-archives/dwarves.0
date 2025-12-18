Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E6828369D
	for <dwarves@vger.kernel.org>; Thu, 18 Dec 2025 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766092520; cv=none; b=oy+HuesboZZCn1pUiBPe4cBzVFVbhpo71A3mGb5k7qPRnI66y9y8T4s3xmyVjXSEmVJ8d7R3bctpd2nqRU/OyGl55RqM0zs2TNsAJRdahAyxp8I5dbv9e5oc1E9ZKl1Xvyqq1Ob90rZpv93mcl4LKPSosgOyz85GiX48fDdASI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766092520; c=relaxed/simple;
	bh=+u/ndDGOy2lwYXuLEGONv5mRvTF27BKeHvqNtnHgUXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLerFU6D6f1oxbzAoZLxL2rSy3JtrrEd3bhVbqJiSu4YylVyndlWF/K2r32iFa9YmkCopgbewN1R2y4jiJmrx8PMRBC+3vFVcjSjJeo/Mi0we9qFEwmdbzQ2QjB8T+Gv8YxNvTyBEfmMrP0m490vbvDE5NPtNvaeYzhOyJG34eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRomzD5W; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRomzD5W"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c5f0222b0so946520a91.3
        for <dwarves@vger.kernel.org>; Thu, 18 Dec 2025 13:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766092512; x=1766697312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeHvMoDV0MwvWoUgAdr9jy+27FmRxctXzz6auzWCwT0=;
        b=bRomzD5WCVaGiStF4uMWFoyUQmggtiyNoSMZN0YYJr0AX6myvxMGXwNSxvEYywwIH7
         urvBhAKt7HqS5ZcmT6//NoKvKB30p7YbQKKUrxw/9Yp7NSWH7uf8nJj3rPSkeoqfASee
         bLwLLgs0UsApIV6EofnuSIy6x/BcXqy0bHbnIdWBGoSsWiwolwMwHa1Tis2JqL2LEchB
         exTcHaVC1iBaVStxPgjyZ0cZXZpSqHIjHmFbHc16yPtq16s/QhlrGtuOB/SE2GapzCXY
         GOAg2DaXPXpzPR4ebv4b0g2YsPaToxb4lI4ifLz0IbL3D41wVcLkDDoK7oCclOMFEdJW
         y1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766092512; x=1766697312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KeHvMoDV0MwvWoUgAdr9jy+27FmRxctXzz6auzWCwT0=;
        b=lziE+7DWix1rE38B/8vAq3vLrJ7yIAxp0yDCHfDtS70F6MNTUvVvYhfhhGeePAGPhQ
         2/DyDr3TLoRwCgstjK9ZVwDaklvi/CVuV39NJ5cdM2P9KSODRdfEmReySwPuVI+9JFlF
         clymxRFNoXtZJQrsObtXbKQo2KyjVhc/HXVVrioKrz53d602sDEJcjoLML76viki/u5n
         M0nNLuxbkgVZeZA5h/e4EQ2G+7HiChtbjRCNyb0CxwVi4/mq1AL28B8dv+4Fn4DTOj20
         p919CAdqMpkO2krBgGo95o4PV+l0Dgkt23SnxPRFaATvhTZnjrEZP2c9WDaYcqYrzcy5
         +f6g==
X-Forwarded-Encrypted: i=1; AJvYcCUj2XCWOJt9hYIjZUyjtVQaRzdwwPDnb8GRqTq3vRVxe0CnrXZVC4WH+d16DSxRRuIXSVQT3Sc5@vger.kernel.org
X-Gm-Message-State: AOJu0YzBCAkbtYYncmkVpvR5r3nR524UnNhrxkksgn7fKI3qkelVPNMu
	BnUtDS4XP74RHth3nk3goDt/DM5l98P7MBXp/a2KWfmsQEu1BEqToxSioSX9R05Bt3HIYxiUHsk
	vd6mXLy/hlHG57/twZ6M/Er6YCk/zCPg=
X-Gm-Gg: AY/fxX6cSM0yxeUwk4ETvgckQba8dc3aFKO2qMvjLBtqeh4ew3OE8dT32UWJP2l0ftC
	jvw4qINWGKzXa4mVtj/c379Cxwz0pfgzJjqf6wisq+lErrWYEDAjjrhogOGfoXLIuZo1QlZNseJ
	nghaNPwrLgg4aqaZ+fpuIX9s3RdugbYw7VakT6Of65eVcpCjGm9MRAtqGhlWjQWTKtc/LDU67tL
	+gLpdQPnTUeoTsVZ8PkXn72ORfilnLiWPgNPlQHVMaxtJ5+9rNj3OAB+pZg2AHnMaswMQ4WCgC1
	4Tn+Stb6jnE=
X-Google-Smtp-Source: AGHT+IEm3NVQEyLOx1ZLRWTiMXhCy/qfbgPRFyUTvXpjkk44dBjMEz9r6YNUjYCIBztbo3i6KidyFHyedRAP9nmcsxQ=
X-Received: by 2002:a17:90b:56cc:b0:34a:a1dd:1f2a with SMTP id
 98e67ed59e1d1-34e921ad800mr512802a91.20.1766092512329; Thu, 18 Dec 2025
 13:15:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218003314.260269-1-ihor.solodrai@linux.dev>
 <20251218003314.260269-9-ihor.solodrai@linux.dev> <914f4a97-f053-4979-b63a-9b7a7f72369a@linux.dev>
In-Reply-To: <914f4a97-f053-4979-b63a-9b7a7f72369a@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 13:15:00 -0800
X-Gm-Features: AQt7F2rLX8p5L_SWnAJnu2v6iF529lekiXcU8Qp40l-At9Q7hbzFSO_mSE-UP_c
Message-ID: <CAEf4BzZA4czi1KEOrW9tn8v18LZN4FAqzrHyB_78VatEZhb+Fw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 8/8] resolve_btfids: Change in-place update
 with raw binary output
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrea Righi <arighi@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Bill Wendling <morbo@google.com>, Changwoo Min <changwoo@igalia.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, David Vernet <void@manifault.com>, 
	Donglin Peng <dolinux.peng@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Justin Stitt <justinstitt@google.com>, KP Singh <kpsingh@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Nicolas Schier <nsc@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Tejun Heo <tj@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, 
	dwarves@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 9:54=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 12/17/25 4:33 PM, Ihor Solodrai wrote:
> > [...]
> > diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> > index 840a55de42da..b8569d450ed9 100644
> > --- a/scripts/Makefile.btf
> > +++ b/scripts/Makefile.btf
> > @@ -1,5 +1,10 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >
> > +gen-btf-y                            =3D
> > +gen-btf-$(CONFIG_DEBUG_INFO_BTF)     =3D $(srctree)/scripts/gen-btf.sh
> > +
> > +export GEN_BTF :=3D $(gen-btf-y)
> > +
>
> Ugh... GEN_BTF is not used anywhere in v4.
> Looks like I forgot a `git add` at some point.
>
> I'll wait a bit before sending a v5, in case there is more feedback.

It all looks good to me, so don't wait for any more feedback from my
side. If Eduard doesn't find anything in patch #8, please send new
revision, thanks!

>
> >  pahole-ver :=3D $(CONFIG_PAHOLE_VERSION)
> >  pahole-flags-y :=3D
> >
> > @@ -18,13 +23,15 @@ pahole-flags-$(call test-ge, $(pahole-ver), 126)  =
=3D -j$(JOBS) --btf_features=3Denc
> >
> >  pahole-flags-$(call test-ge, $(pahole-ver), 130) +=3D --btf_features=
=3Dattributes
> >
> > -ifneq ($(KBUILD_EXTMOD),)
> > -module-pahole-flags-$(call test-ge, $(pahole-ver), 128) +=3D --btf_fea=
tures=3Ddistilled_base
> > -endif
> > -
> >  endif
> >
> >  [...]
>
