Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0980D2C0291
	for <dwarves@vger.kernel.org>; Thu, 18 Dec 2025 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766097599; cv=none; b=nHer0TCIb64uFXxrF1O7MkS1xWCqIHenXppU1U3xqjZcLvDXwt89auUf6uE7e/ReIHkNu7ADRqy6X5/D6sOXhkVtZJh1xe1/hIPERfQcrmzxPnT5+c5Q7LH1y8KNyIcGjT+3dVX1cxI+tD9pyd1ZRY9KaWjXcEYN+h0+nWevQDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766097599; c=relaxed/simple;
	bh=eamKHa6W7ULY0ixSx/sof431csrKXdlpYvmmnDnJOFA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XJA/+38w1ihivS9NvIn35mHLYAqk+03rLe346KF1cCjP2gCiemcNwbMiMvYvIXUTDaL/dlo5Lvjy1+R0JDnU64WqzJ1oM9Hw9UUZQmC94PG+HaHhbZG5bJrd2RiFGYrCAGL2jAvvCba8FPXQy7B6F0pHl0terxBkS8/TbcOzbPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAZ0tnxv; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAZ0tnxv"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a1388cdac3so10615165ad.0
        for <dwarves@vger.kernel.org>; Thu, 18 Dec 2025 14:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766097597; x=1766702397; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eamKHa6W7ULY0ixSx/sof431csrKXdlpYvmmnDnJOFA=;
        b=jAZ0tnxv63j4DOvodBhWdTRwmrfNfUen/w5yFUlkAcD/EBvQzMK3Cm4wYcsRkZ7CBK
         4sz/2yI/lafXrnXEVoBkEsBKZKAE9HxUsBLGO7Qn2QZMZ02LPj48YWIYPoqZvSalkysA
         zuwJ2wPCbqN/tyd4fKR9glkI4s4H4ohAV5BdWZY50B1IIhTbj/xh/03LWPm9HZsLeeGF
         PuBgxvHQqjYuLwPZPHuI8ZNO3OcLQGLM/fzibopqhGZLHjzosQGGJx1r0PCxrh00P58Z
         NqSdkARs/ceSaP82PifVltK24F1o/zBO7P6zJ+hgiJeb1nbQoEkaAhzqlali3TVBWvQx
         0Ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766097597; x=1766702397;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eamKHa6W7ULY0ixSx/sof431csrKXdlpYvmmnDnJOFA=;
        b=I1hfNnSRxgXJiCWaSbLDQ2bobqzzfbZK2ZimTcIdddvdV2xppVLK2laa+uNL2tD0sZ
         0piBIhQ/1Y6of+lH4lgt6pmkNSueg2Se47m8Ffi8qyS4/E6xF6/eNeNpGcjjsVoBkwfA
         PA2fXN8d/NxmEY7bScRb0LC2MPgFaZewOnqAvcc48fiKSStcYhOOD/gtcRUovzXUBvKd
         0MJ+oxBgZBg1YZlOrICjTV/vIjSuGEMz8rdo8d+Tzp2CjcmCq0k3gDZGYCdST7vB6NUy
         7/rSK4o82a6muLsYidfiQM9xk5icbByq6ekzw/S3+3jLqS1fLpkW1qOlUxRw4EKXVfwU
         0g7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5lHBZnEKboKJbfANnN2ywj7y5Wr2s+7qzo6hdCorpbdP68J250rbGCzA6jcH4arZgu6YmygF9@vger.kernel.org
X-Gm-Message-State: AOJu0YzIM8+SSATllFikrw5jXCKuumf8aSxw0XP+rO1oaKQvrQ9ncOGY
	RV6Rux6mgBbCsg0khjFt+l5l6cE/TirazxXiNRrSsn0Y1mt9Wn6cu8fx
X-Gm-Gg: AY/fxX57mRkd7PBZEx5kbTrkJQVQXm2nJN8K6ff/PbNJKYt/hyuxC1husywkyj73kB6
	yftkvpJNCZHwCbMiVnRSqRUdmZwI2ZB+JRQQ7uyVWlrjSDK8oS6H7L2RSF7kTylF9Vuveewtu7I
	+hWqrhUeJRFrAKVeXEzBwGRyGixITPGNw/bI9d7OGJbfiA0X9W+7x9kEPsboyHIpp/QVgn1nf5P
	dRjkL/KXT2daKTNT/iQ1uBI4UDHfH2KiQstwcrMHHUZbcu4/8oWjGXpHhtFOJhS0MNTFKe1D8YL
	Lo2RrLEmE/oo5a+8ZkVG/mz/cBacnD/9ME3797QCCa2qAuyMKZuM2Pdg8JnbR3SNiIIsJPM/tHI
	dPqrh5p9f9sEXbZSmEozsJ6bXbuFVfYzgIIhFDztyKCNgTzwvVMl8UN3N1okYyHdTCevd2w5yWw
	vMud4UUYyfzD1RPFL+QX0/ezzXKnYif4/zCydK
X-Google-Smtp-Source: AGHT+IEVSlp9LXlzmaGmg8SZZsLd9mJhWKS6Iylg31EbQc75zWEKIMS5zueMBmRpuYcgZRvP0hKo6w==
X-Received: by 2002:a05:7022:2586:b0:119:e56c:18a7 with SMTP id a92af1059eb24-121722b4e90mr878908c88.15.1766097597216;
        Thu, 18 Dec 2025 14:39:57 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4779:aa2b:e8ff:52c4? ([2620:10d:c090:500::5:3eff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253bfe2sm1480954c88.10.2025.12.18.14.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 14:39:56 -0800 (PST)
Message-ID: <62a74bb81d7e791cffe4aa52bf3e18bc854f3edc.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 8/8] resolve_btfids: Change in-place update
 with raw binary output
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Ihor Solodrai
	 <ihor.solodrai@linux.dev>
Cc: Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrea Righi <arighi@nvidia.com>, Andrew Morton
 <akpm@linux-foundation.org>, Andrii Nakryiko	 <andrii@kernel.org>, Bill
 Wendling <morbo@google.com>, Changwoo Min	 <changwoo@igalia.com>, Daniel
 Borkmann <daniel@iogearbox.net>, David Vernet	 <void@manifault.com>,
 Donglin Peng <dolinux.peng@gmail.com>, Hao Luo	 <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, John Fastabend	 <john.fastabend@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Justin Stitt	 <justinstitt@google.com>,
 KP Singh <kpsingh@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers	
 <nick.desaulniers+lkml@gmail.com>, Nicolas Schier <nsc@kernel.org>, Shuah
 Khan	 <shuah@kernel.org>, Song Liu <song@kernel.org>, Stanislav Fomichev	
 <sdf@fomichev.me>, Tejun Heo <tj@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>, bpf@vger.kernel.org, dwarves@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sched-ext@lists.linux.dev
Date: Thu, 18 Dec 2025 14:39:54 -0800
In-Reply-To: <CAEf4BzZA4czi1KEOrW9tn8v18LZN4FAqzrHyB_78VatEZhb+Fw@mail.gmail.com>
References: <20251218003314.260269-1-ihor.solodrai@linux.dev>
	 <20251218003314.260269-9-ihor.solodrai@linux.dev>
	 <914f4a97-f053-4979-b63a-9b7a7f72369a@linux.dev>
	 <CAEf4BzZA4czi1KEOrW9tn8v18LZN4FAqzrHyB_78VatEZhb+Fw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-12-18 at 13:15 -0800, Andrii Nakryiko wrote:

[...]

> It all looks good to me, so don't wait for any more feedback from my
> side. If Eduard doesn't find anything in patch #8, please send new
> revision, thanks!

Lgtm, let's wrap this up.

[...]
