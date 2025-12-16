Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A17311C37
	for <dwarves@vger.kernel.org>; Tue, 16 Dec 2025 22:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765924558; cv=none; b=J/Ky4Zj/0oNHvrcz3H83Y870z2ccPX9slLVbRT+jcmlrNy8zPOeJVQ7M70NMkrtK86keD4QxxllnG73lAtmBZIb59Rg1QvaxtkTBCI+bWjvMCQhNNUIZuX0NIemae9JxiHFKNdfu7KyZEG4xQRMJGMb35Nt4ij/tR/KwzORZAbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765924558; c=relaxed/simple;
	bh=WGWXYPcJmuvmwRCa3kvpN8lY0MC0ZrvAzxIclIoxP0U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AbUuhI+OG0x1chF6kpeMo+7hW+7MEosOueyyJWmInHfK1AZ0/f4YC0ij4a8k8biCgQwGBGk2T3CYVcbOmYh040YXc9axYqpE9kQeofpBiyct8wmQOa8bgVUjuka1NhFEyPsIiKKGskrXNzeYihgLLmqCo29nFUKCJFco5gZYtzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3cjKsQZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3cjKsQZ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a09757004cso42474975ad.3
        for <dwarves@vger.kernel.org>; Tue, 16 Dec 2025 14:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765924556; x=1766529356; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WGWXYPcJmuvmwRCa3kvpN8lY0MC0ZrvAzxIclIoxP0U=;
        b=V3cjKsQZyloBKrJuydyxJhM5eXON1SRP//sT3+dwlG09IP/11vXhujon1faWFBnMKD
         XOYIB8RYBUooKrmXezuNZlJj/1y0X93rCOiRefwOlkjSCDAD3rAGy2OvcBE+AzireZeh
         mANyFQhmyS305ArFt1/jCKud5+2bDvHnpPPoxg+XOYfDqm+IxyYjoW4iuspSNfg4JXe0
         6llAsOkxYdh5CQ1k63SWp3jHnB/lWUmitDHBhhR8glcKl3nzJtr21Tk3+FAwT9xsuEi1
         fv/x5jJUNCrvkrKPowncWBh1s+xRHwF/8DZy0jkmeEFffntUtWsZKTfHMC9Ue93ATcLl
         3oqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765924556; x=1766529356;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WGWXYPcJmuvmwRCa3kvpN8lY0MC0ZrvAzxIclIoxP0U=;
        b=YH85IY7Nc2mKrQhqZu59RztU1eQyB6wCz0HMMst/zFfocZQ61ktvzjbDY0gi+CZTib
         lAslao/R+4kaCnLFX1bQ60YYK4yyyqJNokQOu22idXP0XpyUPYhq0g4NF61D9JsJ1FS3
         3LeKHx5eUnJoGlDuBp4GhHeufxAJAAPUsrK6XlZyKvMvHKXcdzDiK+iFhc5HIl/oReSp
         cYdWFrFWIhdz72y7Z9isJ+ndOugXeWHDh/8vGM74vaLDG4ugqpq8mRFgy3jFx704vAZU
         fdgzex9xP6ZGGMGeNDNsc3zLh2G3SZoNc/esIAb1T38aT79O/YRCmAI8mxAdXL2OoMlw
         6mTw==
X-Forwarded-Encrypted: i=1; AJvYcCWSGWV4oNgFLyRhGwFNKw8k6FDGBrCuIoLmF85K4KMKEMyD61PX7HJJfAFB9nDzHHC3EjPcvCjD@vger.kernel.org
X-Gm-Message-State: AOJu0YwdU1lOZvQUpjwOQt4JX0MejsmpUWWP9vUpi9xnfc6oIDJaemF+
	pLgCkw8R4IGxIplYsPgmlrpqkogoTkjnwsfwlP/2iU52OxtwHsmwOU3C
X-Gm-Gg: AY/fxX6x6E4AfyF4f5PpB7GH0JZzqa7AtnPb/VeSszLyKKSY3R3lUDKzQ3pSfE7sOE4
	eLpKVBmIylxDlM8Ol8qQ/leJzwHI0aKjjYYfCCpEF8CHQBvdwWuoWcFnbiT5aAXwpsHrRZnVYmY
	UlF+1CK+rL39s9r+L1R8abiynKH3QFm9Vifc+JajKUwGMRd9eEeGuykTHSObRbHrSQ6rTGp9uWK
	Q0BBsof5YEBtsDVkt/VuG5TwgjifnxK3P1wH9fTvNwXRxPShDm6xJA8UC2p2gULIHgIAjkvxRU2
	wwWQpURUBTF8bEyxNcV4syo+dSnej1HdrTFfm9GK/5z3UAGcBxJYGqvbN7P4zvIAD0ajb8gj4Sr
	Hv7fiBbg62O9Yl659I4RjzaZELarX2dEZk4Yop3dF7VdoXToF0HTJczzjTmRdo3aL9WHY3qBYcX
	g14RDA4BKa
X-Google-Smtp-Source: AGHT+IFF1TvMbOgaX/N9aJcylJ0T2NIr4wu4xOMd9UY4g2QQhOhOrjjeZfuwhQiKW+MVRe5SVusfOA==
X-Received: by 2002:a17:902:c403:b0:29d:9db2:f833 with SMTP id d9443c01a7336-29f23b77308mr169678295ad.25.1765924556078;
        Tue, 16 Dec 2025 14:35:56 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f13d6a887sm148193835ad.91.2025.12.16.14.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 14:35:55 -0800 (PST)
Message-ID: <4b12236c974db52ea19985cc9c5e08e021db9ec1.camel@gmail.com>
Subject: Re: [PATCH v8 bpf-next 03/10] libbpf: use kind layout to compute an
 unknown kind size
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 ast@kernel.org, 	daniel@iogearbox.net, martin.lau@linux.dev,
 song@kernel.org, 	yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, 	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 qmo@kernel.org, 	ihor.solodrai@linux.dev, dwarves@vger.kernel.org,
 bpf@vger.kernel.org, 	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Date: Tue, 16 Dec 2025 14:35:52 -0800
In-Reply-To: <CAEf4BzawMy=woHx_yHY0iiD0x12B_+J8mFgV5zT3aCpG2N0s-g@mail.gmail.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
	 <20251215091730.1188790-4-alan.maguire@oracle.com>
	 <9e1b071598f9c1c1adcac0d8cb2591c452a675fd.camel@gmail.com>
	 <6f3027ee-576d-45de-9795-9a8e620292e9@oracle.com>
	 <CAEf4BzYQeiECx9UpDqv6zRjd1EPjw8B44YX3KPGR1Z4dFKi1UA@mail.gmail.com>
	 <27e4a60100602f769f3c5410a398a75fe0151967.camel@gmail.com>
	 <CAEf4BzayA6if0xcTLux=eyASM1kpARmrOdDRmgG9F1SFa-fEcg@mail.gmail.com>
	 <26e95f737d2de5133702c9b641946e70ec2d1dae.camel@gmail.com>
	 <CAEf4BzawMy=woHx_yHY0iiD0x12B_+J8mFgV5zT3aCpG2N0s-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-16 at 14:23 -0800, Andrii Nakryiko wrote:

[...]

> Ok, so what you are saying is that if there is layout info we should
> always use that instead of hard-coded knowledge about kind layout,
> right? Ok, I can agree to that, but see note about extensibility
> below.
>
> But that's a bit different from validating that the recorded layout
> of, say, BTF_KIND_STRUCT is what we expect (sizeof(struct btf_type) +
> vlen * sizeof(struct btf_member)). Because if we enforce that, then we
> still preclude any extensions to those layouts in the future. And if
> we do that, what's the point of looking at layout info for kinds we do
> know about?

If full flexibility is allowed, then all places where e.g. libbpf
iterates params or struct members require an update. That's a big
change.

I suggested checking layout sizes for existing types as a half-measure
allowing to avoid such changes.

> > Given that BTF rewrites would only be unsound in presence of unknown
> > types the whole feature looks questionable to me.
>=20
> What are those "BTF rewrites" you are referring to? I'm getting a bit
> lost in this discussion, tbh.

E.g. btf__permute(), as it will not permute all types if some of the
are unknown. Or dedup.

> This feature is designed to allow introducing new (presumably,
> optional) kinds and not break older versions of libbpf/bpftool to at
> least be able to dump known contents. Does the current implementation
> achieve that goal? What other goals do you think this feature should
> support?

I don't think anything other than dump is possible to support.

[...]
