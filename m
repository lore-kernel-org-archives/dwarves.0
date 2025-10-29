Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44AE3168FA
	for <dwarves@vger.kernel.org>; Wed, 29 Oct 2025 23:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761782389; cv=none; b=pjktC78mMZM2H1E4SMMAT2T1S0kdLd9Lr+045immV5rR1Drkpb0XWVAV5wwH7Wi2NYrj6zwwR54bMnW2ORti/DZPyQbXtE5H40gLn3q8WYvhY8qm+X+k392wHapldYqO2LaSkgCBpZpVz2ey56WDtsqjDATkbVE++s4RZrKP5qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761782389; c=relaxed/simple;
	bh=i2Tu3OERxIJU94p32GIwdUPm1ZC3DaalkCjMsoAxGjU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rNRbwNTwmZ7rXa/LUjrAkFM88523jWCFfE69LBJPcJ7hen/WgKj5Uj6/7ZCP2YwZkszGBWkW5gcHIb7HQ9BynEKrn5aXAXxnREugS1oPobVRcJ3Xp3kkNDRgZrutPHS+u1CpG39L9W+iim3rVgMYAtkbuPLG1lWmlwZF6qW+zdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKYt5kR0; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKYt5kR0"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b5579235200so245231a12.3
        for <dwarves@vger.kernel.org>; Wed, 29 Oct 2025 16:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761782387; x=1762387187; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zZPMEQHhY1SKu3WdzqqY8qEY3DLdmoW5FkRBPOLzvVI=;
        b=IKYt5kR0fPd44ZDSqWQQPVzfPFlbmyTJxr90zGnO8cLdZb5/Hj9J1BoZAz0uitouW+
         L/wzPVWo3X1njsazf3j31K/HhjbaGdHJ/3jlKPElzMU6r79HXDuKjaBUilXySA+8jy2I
         l1VqpmTdRZV/M8bSKnt73JkmE2aq6EC+r6u81A/lSjSSw8QHYRbUDDc4xvBMg3i7aw77
         cTgeN4b2z0SkFPrF299cJ8JxJ5cAs0iumXUj27SCUtq//ghwxq4qKQBixiXCv7HHUJmU
         Rw3DmVbu58LaNHhjH4A7p+XOJBuIceKPW0CnG/d3wkUsXXY2ZakMO2/PctTYBepkI9BA
         NDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761782387; x=1762387187;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZPMEQHhY1SKu3WdzqqY8qEY3DLdmoW5FkRBPOLzvVI=;
        b=voOFaaSxfJsVMGh5RuCgR+qTq91E4cnzUTPKi0W1S55/xDnbzNlkh3jHPKgKVG/NQj
         oLoP7fV5AEKEXaIOlxW8lvfTDHtCq/JNJQlB7Ge/UK8g323nc270gvoDjhmhRpMSYUjh
         9yqtWXEGbhse5sJw1Cl2OdJ4SU/ASEmdvlYWXidFKNzvsY7vbvvzUsJIiYGvZxcr3DjA
         H+35c0X5XfQkKYovdKkHexILzQEeqm9GlitpdPSP/jxV+N4tYOdD1KM+o/2tft6t2ljB
         oI6uZXRPfQ05f0qUNsussYmfM7jT4S35dtGC9ZGY//I8x90VCdmZ/h2gG5xNO1kPtQXA
         9agw==
X-Gm-Message-State: AOJu0YxJablzejy+cdT0wrtcHiuQDGsFcNwbzp73bNc1ITXN2Sbd6wn+
	cK34b3ghnyAjIcYSwVINWBnueSuMB2M3QOFOJwjTzMPN19o/zCOZ7ZPF
X-Gm-Gg: ASbGncuCvQUOIiUp/GMm9zJ5SNliL7WFyEgvpIlD7O4rOwjoIfMWWXZvTBgLKozUft2
	2yjbmuSe88FCST3uojHUsjrFgBycurBM53ZjeQyRShIuA47LLa7DbLeRVcZ5jhbC3Sfvdv0wBfT
	quO83tiZTRH6e2DzESdqc7++d9RplR9Xr6jc24nMFx5qHJtm+diKvE9EteImzffW+HcNOqTUuLd
	mUyASSSuWOMeR0rCJQK2QuSyMkeIZRFr67cadVe/v7Y2Il+l0100TvB/5smy/qQxTeWCMhzL66+
	kB7txk81TsvVOY/sVNOd/x/UgHvCnYHSvtSEd97AkX2X/YFONos59aKrQRCPFxZ6mj6mNS2qTWx
	azQ1iU846RQzugHfToKsGBqY6Pong2HGWGbOz/zO5ozR5CcGTWDlz80Sq+7DgonK3EvcZTFd2KZ
	2JS4maamfT9oLC9mKMxr8PaHTb+w==
X-Google-Smtp-Source: AGHT+IHLbqeKvJCQVr9MgwbQlo3UdbesRz5XASNZWgWFJ9mDBLDnX0HY1mebpt8cJ+csaC0o6OoFsw==
X-Received: by 2002:a17:903:234d:b0:290:7e29:f59f with SMTP id d9443c01a7336-294dee60875mr55661805ad.27.1761782386986;
        Wed, 29 Oct 2025 16:59:46 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:3086:7e8a:8b32:fa24? ([2620:10d:c090:500::5:6b34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e42afdsm162121235ad.99.2025.10.29.16.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 16:59:46 -0700 (PDT)
Message-ID: <36befdc138d8f1b15fab46c3d2c4d9f8b313779b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/8] bpf: Support for kfuncs with
 KF_MAGIC_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, bot+bpf-ci@kernel.org, 
	bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org
Cc: dwarves@vger.kernel.org, alan.maguire@oracle.com, acme@kernel.org, 
	tj@kernel.org, kernel-team@meta.com, daniel@iogearbox.net,
 martin.lau@kernel.org, 	yonghong.song@linux.dev, clm@meta.com
Date: Wed, 29 Oct 2025 16:59:45 -0700
In-Reply-To: <c974f5ed-b6d2-4716-a119-7efab07e2e8e@linux.dev>
References: <20251029190113.3323406-4-ihor.solodrai@linux.dev>
	 <39bb0d21fffe3855c246dd85b2e69524c8e31bc9d84b441b063f365e5cbf220c@mail.kernel.org>
	 <c974f5ed-b6d2-4716-a119-7efab07e2e8e@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-29 at 13:49 -0700, Ihor Solodrai wrote:

[...]

> > > +static s32 impl_by_magic_kfunc(s32 func_id)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i =3D 0; i < BTF_ID_LIST_SIZE(magic_kfuncs); i +=3D 2) {
> > > +		if (magic_kfuncs[i] =3D=3D func_id)
> > > +			return magic_kfuncs[i + 1];
> >                                     ^^^^^^^^^^^^^^^^^
> >=20
> > Can impl_by_magic_kfunc() overflow magic_kfuncs[]? With the current
> > initialization using BTF_ID_UNUSED, BTF_ID_LIST_SIZE(magic_kfuncs)
> > equals 1. The loop condition checks i < 1, so when i=3D0 it executes an=
d
> > accesses magic_kfuncs[i+1], which is magic_kfuncs[1]. This is outside
> > the array bounds.
>=20
> Hmm... Given we do i +=3D 2, this can't happen if magic_kfuncs table is
> defined correctly. Also if BTF_ID_UNUSED is passed in here, we have
> bigger problems.
>=20
> I guess changing the loop condition to size-1 wouldn't hurt.

The code is fine and there is no need to bow to the AI overlord.
That time will come, but it hasn't come yet.

[...]
