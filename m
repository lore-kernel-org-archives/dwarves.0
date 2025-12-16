Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A6C2E1730
	for <dwarves@vger.kernel.org>; Tue, 16 Dec 2025 21:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765919520; cv=none; b=J6O3ruVnvre2irX4MrSm5bryRnDmfyTLbMaO0uy6hIt3KJFimNeaHysRZ5CF8ZYJ/IFBT957JTjzC2VKenNW7XEESpNJKMam0LC+XZk4OzFy0n71uRsMB+TeWWqDKR4PfWPWd3RK1HGozgSK96SJj20UIAwRQ8RE2LsmZydhifQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765919520; c=relaxed/simple;
	bh=P1iDhPGQpGT7Gn8/5yTTP9Tp5exeIvhESA+wnLEM5tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPK/ciZXDJ8jQBG8wQW5hHqCd3YFx2ITCriQYh6Y/Y/hOw/Bg2mcJMEg1PtWwBbKAqmawY+1WZeGbEK3cE9k70QYM/AJHdxm2EFrCOCFFXuYAjSBruveEdiixYQxmNlJk6+iutVBk8ct/7Tv54f1gWgM8R1hnXe2p4SpB0cbn2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMDYyUAq; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMDYyUAq"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34a4078f669so5226447a91.1
        for <dwarves@vger.kernel.org>; Tue, 16 Dec 2025 13:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765919518; x=1766524318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPV4/GylRMbjunA3YLz0Ls4pnNL5ZTZ6Djd+QRQoDN4=;
        b=TMDYyUAqfIN3PJmnXRz/PbjsQUElelteOCDtcKElnAwm/63v48zx0mC2EpBD1SSW+w
         9Cs1XRy35AoFry9Say9BosVoHD9ltf8HXTYsCUTjxia0Pc3dTLtEiFeYxRqXdgN30sA7
         bcBIgUmZz5wGlbRwZvuZ6tCgVzPAHEMAMuTCFNqVnpSXqhUL+osQwOz3vc45YfuR7rXp
         3UJgi5VWU8m5SV2BRG1fLMHxsuybwDXBUjsq2SJjxNxeocwVe8e61qTvmaslqBpQrs2q
         Vbbr+SFCcsrXWyc4ck4n38yn4WKNzWLj7x7SShZNaitjHtWfz1GuTNpYbUQd3cHp/oul
         jgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765919518; x=1766524318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dPV4/GylRMbjunA3YLz0Ls4pnNL5ZTZ6Djd+QRQoDN4=;
        b=IV02Wm0PAGrEd6cRfHy0q+aIWlxxnzKCoKGTCEOSrj9zyg2OqxhENQl8T/3EWHV9pC
         Yp8I2nvzgPF8ICxGuTDQ1SXA4qoiadwLia6V4qIlkrRr/e6uVrh71/652jzLenDUqi04
         p/m2MLBMNWOSqa7exnlRCLcfUe9dguirR+vfFqqId/DywzFIT9iECSYrAR33vn7H4bY1
         /L0QwUurK7FutkGPNdsqURtpUsAfml8sN5/UCFNBmQX4F9+9AFSlDRAbniTn9mwGP1kV
         t2qhbBHxpxjio1uv6U0NzsD6JqeEsU0EkiAmeBLBe0NdiIYUNJhHmylBGC/fWw4t7KeA
         Fq8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIy64ctjkMCuIEpOvj/uXgOHGPNk70Nn8C3QVrY6lcxh+7th238GjHfM3v6Jpc7FU+VWVbQcXQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2IyIT1fMTAI4m3dPs6N4d/lwLqGnH33+zDDGgbm1wQEmXYIOz
	kkgqvj2dkvlo7bDqIHF14qx5Ddbr1oDMTw+R4Kpn4I1P+OjCPEwy4upCrpB5FW63tuAMg/Z8oGf
	U2YJuRdLXgnAQqyDVIHIpMCK7yxxzRNc=
X-Gm-Gg: AY/fxX6lID4QsqEZmz1mQSTmEsFfoOaRCHBLlvNKprmHKqBNeO8DhH/elUzBFvYzDy8
	lOA6qhNz3plx6IwImCnb8O4nY5hqbVq6+sQLTMGFnrMTtpVWPucSbSZ5zdXklCt1wjQV/Oa3g1m
	dm/EFu6WNxzuF0XOjsQG8Je+PshK1UG4le3R/kjxK8t5IfaJK0tuOS9u8ramYdbrDSYJDnryDF2
	hvQZhhjStLK2ISK07ncHAzESgjNYpK7ZMKED2QRKU72GzsKTpMeG8rhjt/GDWtqhELy9ba7ia2n
	saafo2HN8p4=
X-Google-Smtp-Source: AGHT+IEjsb6Lu0S7BNCWrUqFQwzPKsbwLwIR08c5CnFtuDuOIpIjEW084tf+OTznldd6O8A0c5S/IWgDDkNW8Xm5vW0=
X-Received: by 2002:a17:90b:1fc6:b0:339:cece:a99 with SMTP id
 98e67ed59e1d1-34abd6dd2fcmr15468261a91.13.1765919518305; Tue, 16 Dec 2025
 13:11:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-4-alan.maguire@oracle.com> <9e1b071598f9c1c1adcac0d8cb2591c452a675fd.camel@gmail.com>
 <6f3027ee-576d-45de-9795-9a8e620292e9@oracle.com> <CAEf4BzYQeiECx9UpDqv6zRjd1EPjw8B44YX3KPGR1Z4dFKi1UA@mail.gmail.com>
 <27e4a60100602f769f3c5410a398a75fe0151967.camel@gmail.com>
In-Reply-To: <27e4a60100602f769f3c5410a398a75fe0151967.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Dec 2025 13:11:46 -0800
X-Gm-Features: AQt7F2ruOvWAS0FgTpXdx5byi_LpnJVVf8-4crtpvM-_SSbg7Q-T8vxkE-o2CmM
Message-ID: <CAEf4BzayA6if0xcTLux=eyASM1kpARmrOdDRmgG9F1SFa-fEcg@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 03/10] libbpf: use kind layout to compute an
 unknown kind size
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 11:58=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Tue, 2025-12-16 at 11:42 -0800, Andrii Nakryiko wrote:
> > On Tue, Dec 16, 2025 at 7:00=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> > >
> > > On 16/12/2025 06:07, Eduard Zingerman wrote:
> > > > On Mon, 2025-12-15 at 09:17 +0000, Alan Maguire wrote:
> > > >
> > > > [...]
> > > >
> > > > > @@ -395,8 +416,7 @@ static int btf_type_size(const struct btf_typ=
e *t)
> > > > >      case BTF_KIND_DECL_TAG:
> > > > >              return base_size + sizeof(struct btf_decl_tag);
> > > > >      default:
> > > > > -            pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
> > > > > -            return -EINVAL;
> > > > > +            return btf_type_size_unknown(btf, t);
> > > > >      }
> > > > >  }
> > > > >
> > > >
> > > > That's a matter of personal preference, of-course, but it seems to =
me
> > > > that using `kind_layouts` table from your next patch for size
> > > > computation for all kinds would be a bit more elegant.
> > > >
> > > > Also, a question, should BTF validation check sizes for known kinds
> > > > and reject kind layout sections if those sizes differ from expected=
?
> > > >
> > >
> > > yeah, I'd say we'd need your second suggestion for the first to be sa=
fe,
> > > and it seems worthwhile doing both I think. Thanks!
> >
> > ... but we will just blindly trust layout for unknown kinds, though?
> > So it's a bit inconsistent. I'd say let's keep it simple and don't
> > overdo the checking? btf_sanity_check() will validate that all known
> > kinds are well-formed, isn't that sufficient to ensure that subsequent
> > use of BTF data in libbpf won't crash? If some tool generated a subtly
> > invalid layout section which otherwise preserves BTF data
> > correctness... I don't know, this seems fine. The goal of sanity
> > checking is just to prevent more checks in all different places that
> > will subsequently rely on IDs being valid, and stuff like that. If
> > layout info is wrong for known kinds, so be it, we are not using that
> > information anyways.
>
> Ignoring layout information for known kinds can lead to weird
> scenarios: e.g. suppose type size is N, but kind layout specifies that
> it is M > N, and the tool generating BTF uses M to actually layout the
> binary data. We are being a bit inconsistent with such encoding.

Who are "we" here? The tool that emitted incorrect layout information
-- yep, for sure. (But that shouldn't happen for correct BTF.)

We do btf_sanity_check() upfront to minimize various sanity checks
spread out in libbpf code when using BTF data later on. But the goal
there is not really to check "100% standards conformance" of whatever
BTF we are working with. Kernel is way more concerned about validity
and not letting anything unexpected get through, but libbpf is in user
space and it's a bit different approach there.

As long as BTF looks structurally sound (btf_sanity_check), it should
be fine for our needs. If BTF is corrupted or just uses invalid ID, or
whatnot, it will eventually fail somewhere, most probably. But the
goal is not to have NULL derefs and stuff like that.

Basically what I'm trying to say is that if some tool intentionally or
unintentionally generates invalid layout information, but the rest of
data is valid, and libbpf doesn't look at layout and otherwise makes
fine use of BTF. Then that's fine with me, that BTF fulfills its duty
as far as libbpf is concerned. Libbpf here is just a consumer that
tries to be as permissive (unlike kernel) as possible, while not
leading to a process crash.

With double checking that layout info matches our implicit knowledge
of type layout we are starting to move into BTF verification a bit,
IMO. And I think that's misleading and unnecessary.
