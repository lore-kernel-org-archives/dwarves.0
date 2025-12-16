Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77732EA173
	for <dwarves@vger.kernel.org>; Tue, 16 Dec 2025 02:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765853689; cv=none; b=rhLL7JvBexZtmFyan4tDLvZHyQWFgZ7lIvLbmXe4BZpozhpeeUR+mtP/j6iaa/wTGFS9yxj5QKH5TUWDei3Xtxhvc+AABgwgWHyadCOrpfYtILlX0iGmBdV81SOdd6Xd2OD0Jk0CZfEZsygeYX6jAfO1kcyCayjQdqYKIthwzi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765853689; c=relaxed/simple;
	bh=numGoBvFqUmKgYq+gTvwU6RDyzW/FMMZFczl/Mu6Beo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GxXbryLLl/PUqH5QsnWVg/V3WoQ7aSXQDtxcgUljNG8zXkiYNihBSQLuDgHOCjIQvFe2wkGzSISPGGTuadNjKXaB1TVPpW3oke31RmMEcHQoTIOauYaeI8UyiyFS4ArQ8yJBb6qnLCXk3zVCJdC2aC0e05k9ix+rwQwRcvl7nwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkIJojbm; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkIJojbm"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0eaf55d58so9608195ad.1
        for <dwarves@vger.kernel.org>; Mon, 15 Dec 2025 18:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765853686; x=1766458486; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7WAisvZ8c0VsEQQ/ay4lGlVwantG9QHW/ILMt+qNiOc=;
        b=mkIJojbm5zOc5rIC91ptnT8r2j92xoAXz1j/E/L3aLFg8ub1IMoPhqnKI++9D53Za+
         3jqwNxHKrCSooTvu3e6y54PgZNOk9HDhpq25+OQNshLFKgI/TqO1KgJUvTtEzOtcy46r
         RQ5WFPcwf45PCSj9p/USVGJtPioSPXBvPJrvoRRhyOdRe6V/mxdvCQG2AyEyj82qfeKR
         fAQvoxU2Cs2365knGLsui0aJZ8CIKt2bu5ssUd0DJqMSlKBQWbQ7Jg22KbrNRu625R61
         /yEcjHo7mMFXPglshLsX+IaY8sVG2+B+8QN6Z21JY1RiFuOfaRFgJ1adniTuCyF9SqfT
         Fg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765853686; x=1766458486;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WAisvZ8c0VsEQQ/ay4lGlVwantG9QHW/ILMt+qNiOc=;
        b=UneLZ8O1rAXZRo7dwbMMslUK1JrOF4hk+m/jUaF6nIW8314aMV2gAqAvSa1AwuJPG5
         UDHfH2J3RRAmg9jzJ7+d+LAKfVox7JrUl1MtLSF/RY6ZO+ta4dMl62B8NlvhjmM7u4KP
         duj/7ufasTKlUt4o/1ixdTQ6Bsgnk7O4NkY8fPU+nBbR5p3njsvkPqUD72gBS31zdzrN
         3+AC9jKqd8LZqNkCwagLsRqfnlg9HpDpfJIjI4rTwLeCWf7F2DtQ6lA3ruvDswkeVMDW
         VXPrbY2j62gVVORy33vkcbFmE0fLMVTgcTBETkOGmrBCm3KuMBhDP2QDMlxTS8LBeZOb
         mo4A==
X-Forwarded-Encrypted: i=1; AJvYcCWQMz2GMub6ibiwi0h2aAPLcxjWD73jFycKiGSX1VnfScJDYq8YGkPrsgk6x9rJKBLO0Au1dxoz@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9pJGnsckFbNeuEtA7NJ/toU3UDwtx/1iSPON6vAmGOyeumAaV
	3V5jK+0fJ0VWSjv/BSWewcG24njfVYImskAcj7QtnVz7lqU3E7/xhVqX
X-Gm-Gg: AY/fxX4EIngm+a64fFTvlGEHNyI6y4SjtkDzgq37ZfTnlpAXxzDdVYRn2YNMXjnhIeg
	y5Jj2aW4FY4LyWDzPc+V/utUnxhrfURPjknJpZ3fFBhN2wvq1QeAy8pCtn5wtJMxMyfUkj/AYTr
	i5EdHuaZmweyCEocWi17OHfnwfz6LN1wg0U6++BVZzkUZWYBMHN+IFERWT/IJr4HOfYEeRXOiMR
	IqTt2HCMnnx3S6pIG+dFsAGILy/4oG70T2n2MSAA9xa2/wtzInAtTlN7EqolFxMiAreD8MXjG1x
	VEPZMKNY5/RhxvxiKeU0EP+5oC4Bl1FvX3Q+M1umKzJ8b+jipsIZLtw3C6UPzLQXY1Y3hgiOk++
	+fAhL5FG8P5JQENVzGKjl0C6s26FginLIu7MtPGeOjG1zvuiqjnoEue9RJbzyrLrC9b9Ol/6j1g
	3vWNCMU66a
X-Google-Smtp-Source: AGHT+IHCrdtZDAP84b4wHx8q9geC3s/5+S5GqytXyOs32NpX6TX024B5zSY7ifUNYMrtppDYkMvk6Q==
X-Received: by 2002:a17:903:fad:b0:298:639b:a64f with SMTP id d9443c01a7336-29f24d47166mr136419605ad.6.1765853686097;
        Mon, 15 Dec 2025 18:54:46 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a094398ed0sm84118975ad.27.2025.12.15.18.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 18:54:45 -0800 (PST)
Message-ID: <9c9ac17e916162d8921e4829153b350080923339.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] resolve_btfids: Introduce enum
 btf_id_kind
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>, Nathan
 Chancellor <nathan@kernel.org>, Nicolas Schier	 <nsc@kernel.org>, Tejun Heo
 <tj@kernel.org>, David Vernet <void@manifault.com>,  Andrea Righi
 <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Shuah Khan
 <shuah@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt	 <justinstitt@google.com>,
 Alan Maguire <alan.maguire@oracle.com>, Donglin Peng	
 <dolinux.peng@gmail.com>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-kbuild@vger.kernel.org
Date: Mon, 15 Dec 2025 18:54:42 -0800
In-Reply-To: <4daf5253-685b-4047-8e2a-06ed2c72c830@linux.dev>
References: <20251205223046.4155870-1-ihor.solodrai@linux.dev>
	 <20251205223046.4155870-4-ihor.solodrai@linux.dev>
	 <386068b11e146a9dbb502f770d7e012e3dea950f.camel@gmail.com>
	 <c857acb9-977a-49ca-a03f-ef3fd68fabae@linux.dev>
	 <b37bbff7486f47404872017faecba43833116d61.camel@gmail.com>
	 <4daf5253-685b-4047-8e2a-06ed2c72c830@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-15 at 18:52 -0800, Ihor Solodrai wrote:
> On 12/15/25 6:38 PM, Eduard Zingerman wrote:
> > On Mon, 2025-12-15 at 18:31 -0800, Ihor Solodrai wrote:
> > > On 12/11/25 11:09 PM, Eduard Zingerman wrote:
> > > > On Fri, 2025-12-05 at 14:30 -0800, Ihor Solodrai wrote:
> > > > > Instead of using multiple flags, make struct btf_id tagged with a=
n
> > > > > enum value indicating its kind in the context of resolve_btfids.
> > > > >=20
> > > > > Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > > > ---
> > > >=20
> > > > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > > >=20
> > > > (But see a question below).
> > > >=20
> > > > > @@ -213,14 +218,19 @@ btf_id__add(struct rb_root *root, char *nam=
e, bool unique)
> > > > >  			p =3D &(*p)->rb_left;
> > > > >  		else if (cmp > 0)
> > > > >  			p =3D &(*p)->rb_right;
> > > > > -		else
> > > > > -			return unique ? NULL : id;
> > > > > +		else if (kind =3D=3D BTF_ID_KIND_SYM && id->kind =3D=3D BTF_ID=
_KIND_SYM)
> > > >=20
> > > > Nit: I'd keep the 'unique' parameter alongside 'kind' and resolve t=
his
> > > >      condition on the function callsite.
> > >=20
> > > I don't like the boolean args, they're always opaque on the callsite.
> > >=20
> > > We want to allow duplicates for _KIND_SYM and forbid for other kinds.
> > > Since we are passing the kind from outside, I think it makes sense to
> > > check for this inside the function. It makes the usage simpler.
> >=20
> > On the contrary, the callsite knows exactly what it wants:
> > unique or non-unique entries. Here you need additional logic
> > to figure out the intent.
> >=20
> > Arguably the uniqueness is associated not with entry type,
> > but with a particular tree the entry is added to.
> > And that is a property of the callsite.
>=20
> You're right that the uniqueness is associated with a tree.
> This means we could even check the kind of the root...
>=20
> I'm thinking maybe it's cleaner to have btf_id__add() and
> btf_id__add_unique(). It can even be a wrapper around btf_id__add()
> with a boolean.  wdyt?

Well, sure, that would be a bit cleaner on the callsite.
Up to you, given the number of the callsites I wouldn't bother.
