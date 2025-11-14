Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0D233469F
	for <dwarves@vger.kernel.org>; Fri, 14 Nov 2025 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763138152; cv=none; b=UwP+fAPiYDbyJJXRGl1oraliBWWiuqJJl2s3Oe0cY4fEGgvHv+04TPBneNVdnUEjBRnOaWOU7dUxgy1zzo0lwQma63mcf1ZpyWDEJbAgZDmjD4BxkwDmyHoB1MaWNBR/qt7N95SbeD8ccL3PqMFzxEFfoTx76h7jvbHfyXr3+Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763138152; c=relaxed/simple;
	bh=Xl5QLaKsroUW9SF19pUajhBIIA19ziJQBnwwtRl/LFg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Z831Xzf84Tn3OjVTTVXAjQR6iWJIAqOgtjLiWkvBpFwswNQWmTxJhXlZl2G8R6XHIPUzl03eRZ/To8mZUu09CEjcXTWcIXA59h/PZkTS9X/0IdswyP4CdU0GxFrkEf3eNNiGjbhb7B/fpgTEc4hpR97Lcze2SWCcGlhsIlKrzRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSVCwSij; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSVCwSij"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477632cc932so10829835e9.3
        for <dwarves@vger.kernel.org>; Fri, 14 Nov 2025 08:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763138149; x=1763742949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AejCe1AnGKxMQwM42EhlGVlRWc2gpkzytD6b1teK6Bo=;
        b=DSVCwSijmwj3QRBXRVCgdxub0m1cA1iipB9CpbU40g595aRFEnLIkKcEp2tTUVFrNP
         hPhz/dAGUiAxlcmIp514sEXy9OM0b2xCPYQ9OO+jrFHfpfIB8B27i+/kTrHmV/cRqBhF
         nHSAWIV//kZU3XImkc0WzFKQ4gxh2OIXgPdc6LbSHF+/M4aNpjBtQKukBz3G7e/rbTYL
         DwUz2v8hX/12Qz99Fn8C8YH7KTqEBQpmp1fIaHZpsRQ98G1bgKmxBzwayVDMesFg52OJ
         yR4bwc7PN3oHmuoT0gw8bA/zIiMV0S4znfqzvOlJtny5U/JDKwNv2YAOHbW3l0Bh6xh7
         jS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763138149; x=1763742949;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AejCe1AnGKxMQwM42EhlGVlRWc2gpkzytD6b1teK6Bo=;
        b=D2WWFD2yTkMsK334Ung98chqzqOSqk4FMF/H4okUbV0nDPhxuw1RYOPUlTaQw60+nf
         0aQJs5eGVavFokHBhr/NkyP7LaZM0t69kA2NTzpDyaj5tWBsyDnMW8mZQHgwyAHDOrKL
         iqIFVTxHxT3iJPNABeadgKHmHr6bIRHBUpEUs1m9PXKDuaRFqQgk9Y5LGRqlI6Bt4dhm
         oQsJLy7CM5frvB4lhXJjLjvhP/aE67G8KO+UmXcuMXWrecXuOdw4VQ+k/JQ7frW1cjdJ
         54ti09NeQQSZYF1ZTIlebMN7ws9PaMMLWvK6c8ebgU9z030T5GfhDnDQzQklpjLYRjMF
         qxvA==
X-Forwarded-Encrypted: i=1; AJvYcCXV4ISsPDjL4dVl77sbx536KYwVzY1WQQm4VkCYTGl/Wj6v4yg7Mj9r5q45J/UJRAJYoql9nGhD@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrtzl4cfO4yvEquPDhn/OFTVql2Yk10nBk+PP60cDVhZGEPFt/
	x4JpQqh8SXXMLHU3hIe9Kv/6yVOhrq/j24XOJSEEx87l1eX3+NdwNLS1
X-Gm-Gg: ASbGncuGnQ4KBepC+ZKTt2voFuzcDEg6kpKeHp+1u3d7G4R1idEjHtN+18CHPivuUWt
	FVUQ1hRFCiDzLkvE4MXRIfPHyfZPpOQDD1JLX42b64wcq9ojbzRPYUd7dZi6KGxEJjVcyLUt91S
	PeFhrHz0pQZ5L5W+mElt1BJ7mz5qJtcTg9bv3+XSHu7DX95Rb4tOXCqRI6pZFMEG9auPMUuTYi5
	o7Q3hxqAJ92OSjPpRY65E5pQVgjJz+8pH56k71IMZthiWPeZ4uIy/AS4BQ2oFs6aUexXv3r7A4D
	ErmoAdehpm0epnSlXI4u80m0+sCUecOY3DPyuOS17BDb6SHunHxwfgwy68QKh6d20IpIfPu3bvq
	JYKHJLn9gmBoXTbzYMnCpAAvk/DsxblK7ep/UT04u9PSnaqZZ8IypNQDpLVoU/uBm3nYRYFBD8Z
	8B4Yz6OYqitD8zlQ==
X-Google-Smtp-Source: AGHT+IFMxw/E0WMI+4r7Mu8aYWkB0mKLGicLqcZxZdWHoTwMNFrrH0PnDmIhtP1/6Fmivx7ublS0Pg==
X-Received: by 2002:a05:600c:6289:b0:477:54cd:200a with SMTP id 5b1f17b1804b1-4778fe50f5emr37643355e9.6.1763138148870;
        Fri, 14 Nov 2025 08:35:48 -0800 (PST)
Received: from ehlo.thunderbird.net ([176.223.172.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b589sm10547445f8f.23.2025.11.14.08.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 08:35:48 -0800 (PST)
Date: Fri, 14 Nov 2025 13:27:46 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves <dwarves@vger.kernel.org>,
 Eduard <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Kernel Team <kernel-team@meta.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_dwarves_v4_0/3=5D_btf=5Fenco?=
 =?US-ASCII?Q?der=3A_refactor_emission_of_BTF_funcs?=
User-Agent: Thunderbird for Android
In-Reply-To: <cf503462-6616-4cdc-ae63-b126b28ae66a@oracle.com>
References: <20251106012835.260373-1-ihor.solodrai@linux.dev> <520bd6d8-b0a1-40f2-a674-b4c6ed02e254@oracle.com> <CAADnVQJj6EcntgiAm6Kv8FJvP3tQcG=EzWt-uFuzszHtcw4gmg@mail.gmail.com> <aRaPnq2QJN1iFF_3@x1> <cf503462-6616-4cdc-ae63-b126b28ae66a@oracle.com>
Message-ID: <136B81FE-DD5C-4B3D-BE61-1C8912428130@gmail.com>
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

7

On November 14, 2025 12:40:36 PM GMT-03:00, Alan Maguire <alan=2Emaguire@o=
racle=2Ecom> wrote:
>On 14/11/2025 02:10, Arnaldo Carvalho de Melo wrote:
>> On Thu, Nov 13, 2025 at 09:20:44AM -0800, Alexei Starovoitov wrote:
>>> On Thu, Nov 13, 2025 at 8:37=E2=80=AFAM Alan Maguire <alan=2Emaguire@o=
racle=2Ecom> wrote:
>>>>
>>>> On 06/11/2025 01:28, Ihor Solodrai wrote:
>>>>> This series refactors a few functions that handle how BTF functions
>>>>> are emitted=2E
>>>>>
>>>>> v3->v4: Error handling nit from Eduard
>>>>> v2->v3: Add patch removing encoder from btf_encoder_func_state
>>>>>
>>>>> v3: https://lore=2Ekernel=2Eorg/dwarves/20251105185926=2E296539-1-ih=
or=2Esolodrai@linux=2Edev/
>>>>> v2: https://lore=2Ekernel=2Eorg/dwarves/20251104233532=2E196287-1-ih=
or=2Esolodrai@linux=2Edev/
>>>>> v1: https://lore=2Ekernel=2Eorg/dwarves/20251029190249=2E3323752-2-i=
hor=2Esolodrai@linux=2Edev/
>>>>>
>>>>
>>>> series applied to the next branch of
>>>> https://git=2Ekernel=2Eorg/pub/scm/devel/pahole/pahole=2Egit/
>>>
>>> Same rant as before=2E=2E=2E
>>> Can we please keep it normal with all changes going to master ?
>>> This 'next' branch confused people in the past=2E
>>=20
>> I think the problem before was that it sat there for far too long=2E
>>=20
>> I see value in it staying there for a short period for some eventual
>> rebase and for some CI thing, to avoid polluting, think of it as some
>> topic branch on the way to master=2E
>>
>
>Yeah, I think if we can augment CI to cover more we can narrow this
>window, aiming for zero as the test coverage improves=2E

I slept over this and think that is we can have the CI test patches direct=
ly from the mailing list, doing AI reviewing even, then the next thing can =
get a good riddance=2E

 The other thing
>we should think about maybe is syncing github=2Ecom/acmel/dwarves with
>pahole=2Egit as many people are pulling from github=2E Should we discoura=
ge
>using the github repo, or just find a way to mirror pahole=2Egit
>automatically? Thanks!

I think we should create a GitHub=2Ecom/pahole/ and have shared maintainer=
ship, will look into that=2E

Meanwhile, today, I'll check what's in next, test it and move it to master=
 both in kernel=2Eorg and GitHub=2E

- Arnaldo


>
>Alan
>
>> - Arnaldo
>>=20
>>> I see no value in this 'next' thing=2E
>>> All development should happen in master and every developer
>>> should base their changes on top of it=2E
>>> Eventually the release happens out of master too when it's deemed stab=
le=2E
>>=20
>

- Arnaldo 
