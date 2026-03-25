Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D961433FE06
	for <dwarves@vger.kernel.org>; Wed, 25 Mar 2026 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464767; cv=pass; b=og8QoWitPBdnAfnikFOn7XJjtbcsHoCC7zOkvTghHUg0MNuXYbjYh5dIfDUGypXZGZcwZ29vbrsmmsm766BSEOp8BkTgxZRPKNLhAVzMsa3YMwyjVhpQ4cjiNit5rNAiUXD/Ux60VLmElWVYD93NAC7mFOmE1m4LqRcTC+dp6S4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464767; c=relaxed/simple;
	bh=XAnsp3Ju0mcQEwB4s35QUWLMlqChw1RyN/3H8Af22/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAdl2n7bzf7i7Y2LxXIsrD60q0yG+OfEzm/Ugk0Jde3VCyoUU8fTcYaiTHYHjcvNvd8S21RbLxq7PrqDmw4HD9bTZAvpofdjKiOea3Mf3qRKrPf24wmhOuLwZLr/BfgoPzbNVZZpSmTcG6wArseUKlEvJpM+JTBZhw+OTUZOhb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpsEbnoo; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpsEbnoo"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43b40003d13so99158f8f.2
        for <dwarves@vger.kernel.org>; Wed, 25 Mar 2026 11:52:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774464764; cv=none;
        d=google.com; s=arc-20240605;
        b=iIQEeGhZpD0xapIB6JD60m3h5ZcGcYAJCpidqd+IzLAl/3K0jsVXIKDnozo8g4+zVl
         xtTUcvx+mUKoVJRizDscUZMjtJtpmKmCLEqA3cjoWoaRA2cSkBRNX8Rl21jkqE4pJgeZ
         X9FuaNeV9O50H6agbmlItH37BIkK/pleWPhMNpi1LxmQ6K17IPT/UFBkXrSGxB86fwAB
         pJ9385HCHoXWmjcOX1cSmbPiplTbJC1Ju6xonDNXrZ5CsiBTO0Bs8pUnclD6RcYLyDPp
         DU8bWEgHbwsIzB1gNX37yXshslx2o0CV5t7ZRSUqPGsdXbXpWXC4l73GSkDK/rrC5P4b
         izkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XAnsp3Ju0mcQEwB4s35QUWLMlqChw1RyN/3H8Af22/g=;
        fh=BJHtTJeS1UX0XRjX+m792sTEvcVgNSRaeuFRzYxceHs=;
        b=FJT95MHY4JMO0TJd0ibA+WJthH7sBRWszUsqvvHzsG/gCJRxLuEq4hacmJpKqyXLog
         v4V4wVBPy51pQZUQl/NzrjTExloHlyQFOUrVqZxENdK+0p3JBTXQHM5g06E/u5wy0wre
         Z2+b/gWIo/CyuGbbq1dCeklSjW6nphowLT/VY52jXVQt6PDYTnzS6lT9cHADJqZMO0kn
         HbEEg0BT9ATUZMk21f0Cy131jsytzzKUeDE+AnTs0NU8ofGNi9+UAGeiURc970pqxsaa
         znR9/G1gO2wTPNuQpv1HT+Um8rh40hHFE3w6lqzVkagoTXW+ZOqJiuBFsFhodqDXQ3zf
         KJDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774464764; x=1775069564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAnsp3Ju0mcQEwB4s35QUWLMlqChw1RyN/3H8Af22/g=;
        b=WpsEbnoooxXCNTJ11ktlsCFu5t71/WZDF1vW8qetyYcq2XARbPXZ8a48hlOV4hB2of
         gUrFH5B83F6ezS/zulaq2kJ3GQHu+zwaKy2S6ra1LLG0WwRy0AAxjsmFcfesqlctnWKM
         TELi5PbjmS2/t7tq4dp07/oS67NO7XjvnhjCSiEN8tlOmslaj9cRqKVBM/lF7J76m7gY
         d51SbZmK8hZ00+4Kwbhjzv5ZIJvQEPY1fgonUora/uFUUy6mhGB4Y3sS0TSa8kCzgGz9
         tREUNZoPlptKLVGYorsSYna0+qy03RxRU1AabnxSfxe1Knyogd3J/fyoK1/AAcqwdVzF
         mCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774464764; x=1775069564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XAnsp3Ju0mcQEwB4s35QUWLMlqChw1RyN/3H8Af22/g=;
        b=MzYPHSFe3Rtpaimyegg5y7Pr4lwjnKWN/qxsbwkXxnhMHbNknl7dQxc4kP3QPhghOc
         jJADAEpIIpPa7Zp9rYUZMBYWhXKQvNR0nDGqHhXjLp9g0qZ4sxDhqAPUMaeOO9yhvjv0
         phHr/GzAkhbxLh8DbHNy9CoBe6+ODyj1g775A/FrNJBPWoLjvL4A8UGRWpweXFNi4DSw
         b8hG0awxZB510AwmFtPfAaC4DpxW/P53ypQbENsPFeQO9SkPpPrwdmObnY1dwaN14wra
         RAYGqR4HpCzQzs6MeB/ZQwcblnv9KT1XVKyw9fZCcJ3xc524yogwduo5lg4Wh8sYmYEJ
         Rp/A==
X-Forwarded-Encrypted: i=1; AJvYcCUdTUhyHno3dcSGIu40CaYiarzn6tW+qtk4T/TKxro/o/Go51UyUbCSju+h3RtkLR2F62Whxc5w@vger.kernel.org
X-Gm-Message-State: AOJu0YwVFC0AQ9fjs9EQBBgmvCwrapvUO1H6zPBTEnIVd/iGiLXnVmYo
	aB7Cmn5CWt6gGdfNw8pF1/yjH4GGBSHKGLx7ZgZzH/S20lxWpMetii8CPklvEByCwutjfyI3OSR
	0X3n8+MWdBA8fK+f+u/WMN+v4I1TRM8k=
X-Gm-Gg: ATEYQzzVMr/abdnUd3n2UgpxwY1O/jPTidpU6jQUZJn2SJiRn6JvVb0SK9pjCKJ7iWv
	IjtwFeqTXpf4PfhXNjScPlApAtksK9R8x++XCB5srD5bjlEXammJU6KeE+KlSRf/bI1QVZM0Oqc
	+Q1WTis76q0rZkMxa/lBfvR9dECggZjBJ6qLNCE+QY1t/91AolNzI/LHGCKwRfFstEY2WUKlCTZ
	7Za1kdJ+sQAmQh9lQfoOJN7ePn4A2yWZ1ru/htuyctse5g4mcl1F+E8OBUNs6SCU355rNWugxCd
	jmJR+pUSCWfX+/IOgKSzwJvHFk3nszrWvoFUYoSpaVtOCaozKAkUdtQLLNYR6HnKGkZRZHj1XnJ
	OljqW2BwF7AOquSms2u6Tq8fl6g==
X-Received: by 2002:a05:6000:2902:b0:439:b203:7711 with SMTP id
 ffacd0b85a97d-43b88999255mr6286811f8f.3.1774464764139; Wed, 25 Mar 2026
 11:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324174450.1570809-7-alan.maguire@oracle.com>
 <ef3fe9d80d24f7498410bffe938da1882448e5b6012fcc3ca97fff5645018ba8@mail.kernel.org>
 <1cb3278e-90a0-48d3-91c6-4b7c552b96b0@oracle.com>
In-Reply-To: <1cb3278e-90a0-48d3-91c6-4b7c552b96b0@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 25 Mar 2026 11:52:33 -0700
X-Gm-Features: AQROBzBDpjXt-Sd5I3lcyCBSgDJ1prhwZly0KRnadhMExEvYEic6S-Jks5fAv-c
Message-ID: <CAADnVQJooXp+aVb9UTQN87=Bu8i6JAb18Rz7N-cZVVOKTLT3mQ@mail.gmail.com>
Subject: Re: [PATCH v15 bpf-next 6/9] libbpf: Support sanitization of BTF
 layout for older kernels
To: Alan Maguire <alan.maguire@oracle.com>
Cc: bot+bpf-ci@kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, dwarves <dwarves@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 10:40=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
>
> I'll wait a few days for additional feedback if any and roll v16..

No need to wait. Fix quickly and respin. Let's land it asap.
