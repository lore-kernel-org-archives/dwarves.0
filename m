Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1961A5B84
	for <dwarves@vger.kernel.org>; Thu, 18 Dec 2025 21:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766091689; cv=none; b=CaR+BJshcIKfdk9jXYdMbSuleRu7AU3yFVCjxxg/qw0/ksHCMW9WxBt0nOPiM2j8lCuaBEKHftSd6yXEZmQN5mBZi9jVolM3/6ptjq5kQVDSdSML/EvUDAB0UAUTd6dx/F2VorOjnQ6zQZYZIAst0j0qjnpbj65xZKUh70A4QMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766091689; c=relaxed/simple;
	bh=jmXmw5asMTtXGIz/8lcXflbtO8gf8d9v00RouWwfLuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sr7gYd4eN/eiGNBrtzhWJ/ULNVFkR82BUTLDmIXHQBp2kqwmXSkSPZ98Ncqj807tSrVlyxyyZPgxjuy+ih+71Yek8D9+kPLSf1jAia87tbh20IgKAnzXzJngcv5qKnILxjXgqrtS8qoLJuU7h5ydNnHb7gFj02B21q5tHTc92ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kK62UqJF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kK62UqJF"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a0eaf55d58so13447725ad.1
        for <dwarves@vger.kernel.org>; Thu, 18 Dec 2025 13:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766091687; x=1766696487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+k0sBo8kGqSqYtBtyPmz0oTC29vtNufjE0L64aGxAA=;
        b=kK62UqJFVaDnqZhVU44u73kwbHQ+pQ0KOvepmM0BO0CPVOKebeLi/vdN0DZImYchOo
         wouf0Im236lENR5K/P5ksDCv1RYJIa3X6795n9icXXvMz91DDfzwCTsDkJ0iUFJLbYZa
         SBJlav65SJsm93kITEe5mV9TT9YOAzNKFDzFaKQDqqIvAoYmp91u18WkOlJsjMmR/lu+
         5dPIFakqvRwz7eVmv8sKdXAvVttXU7rZc6i1hPF44Kqq5QJQD9OZjbP2ZJLbiqkfF2O3
         v2IDdE1BAmnRM2/2FRA99sIpmkbNwJCECNl11zBBMd8MLmK5n1pAWPajGw+pqHVU34fx
         KUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766091687; x=1766696487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s+k0sBo8kGqSqYtBtyPmz0oTC29vtNufjE0L64aGxAA=;
        b=mFJ0cH0XIBEoYvv1qQ01yCYXx3PfwE1mIVnykRtgFNOz6kDooa2AmJ2/0qpuPuvLhT
         sRCGj6O1W40ifirhteMtC4fCCttlmMw3QVF7eXsSuRMsE+fFDoCORTBwVpmv/R5cRtHn
         DXNqhi2kRpMuu6nwdgGrSlZaUvwVzIi7a/JZ7XTLHxYmL15Bz6mwJOg1uABFVHdVvg6x
         0F/Cjel0QRXx6/KxrOXF6LeXmp5zdISaXjT6O5Kwl/arYZquf2Uc/uXNJrq3cbPR/Ovv
         byYo4kz9urZdWKp/hL+9bxbVBW+tEw72SFd3kATUteaRiJK3vkwxKvfFyoQ7aH2ro4KQ
         WTVg==
X-Forwarded-Encrypted: i=1; AJvYcCXxz1Nt+3qxwmhqAhtSapN3jMt3Bq/NDM4JWCAR4C9hPZ75CwX4KvvIrPJ54jDmjvRGTVyNA7vp@vger.kernel.org
X-Gm-Message-State: AOJu0YyHY+UJEDavzdJn0Z6VnOhGAJjliZMcLGRWY5iEN0NyHTuxed+Q
	4CanhHYMwzm5zs+1WfG+hi+aTMz5zAt2DIsiiFaQq6fh3sT5ypr3QEcJGh6fndgZgVbQ9HsFLCr
	fotTCq76KvfOYeHvFkXGI62acLznQ8yM=
X-Gm-Gg: AY/fxX786zggzqD0fflst9nNSjH/aU1DWe8/D8/Y2QegCSMwDzYWb9wbF9z3i6HhBbn
	kMDtKosOr2E16PiRssrg7w+3tsAqYBkQdoGBd6MglXbibkt0RC2txNxrdNbzFTTCjmxbG6NrkCb
	3F7DWscQh45/CvqqP68mmtjieKM0KXBDlPmkw+cZozUdpyZM4dxP9Ezs9ff7L8Q3SrwpH0uVuKt
	FVGM6AKSVU5n3Ig0vqXoyO4kaxN+3YuclLGh9xhfQpCgsmJsPSo8IQICNAUAi/YVJmXcIQ2uKYq
	woJ7DOWSzTw=
X-Google-Smtp-Source: AGHT+IFvxO++u168y/ZQIZTL6aX57IK2pSm13Cv1wVzQ3aSOnLQnrHhkdej5Dd5WyhHBMHif+7aTekMWxA8bTfSxggY=
X-Received: by 2002:a17:903:1b06:b0:2a1:3ad6:fab3 with SMTP id
 d9443c01a7336-2a2caa9cd35mr39266795ad.1.1766091687269; Thu, 18 Dec 2025
 13:01:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218003314.260269-1-ihor.solodrai@linux.dev> <20251218003314.260269-6-ihor.solodrai@linux.dev>
In-Reply-To: <20251218003314.260269-6-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 13:01:13 -0800
X-Gm-Features: AQt7F2pO_lFPayHYxhN87IzQtBu5GC3SicKONr1cvSuGE1FgcyvrGgbGAfOSm2Q
Message-ID: <CAEf4Bzb9BnSLmHOj=kdgC6is6_ZXHuHw_OyaMO_7xp+eWdtbPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 5/8] kbuild: Sync kconfig when PAHOLE_VERSION changes
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

On Wed, Dec 17, 2025 at 4:34=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> This patch implements kconfig re-sync when the pahole version changes
> between builds, similar to how it happens for compiler version change
> via CC_VERSION_TEXT.
>
> Define PAHOLE_VERSION in the top-level Makefile and export it for
> config builds. Set CONFIG_PAHOLE_VERSION default to the exported
> variable.
>
> Kconfig records the PAHOLE_VERSION value in
> include/config/auto.conf.cmd [1].
>
> The Makefile includes auto.conf.cmd, so if PAHOLE_VERSION changes
> between builds, make detects a dependency change and triggers
> syncconfig to update the kconfig [2].
>
> For external module builds, add a warning message in the prepare
> target, similar to the existing compiler version mismatch warning.
>
> Note that if pahole is not installed or available, PAHOLE_VERSION is
> set to 0 by pahole-version.sh, so the (un)installation of pahole is
> treated as a version change.
>
> See previous discussions for context [3].
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/scripts/kconfig/preprocess.c?h=3Dv6.18#n91
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Makefile?h=3Dv6.18#n815
> [3] https://lore.kernel.org/bpf/8f946abf-dd88-4fac-8bb4-84fcd8d81cf0@orac=
le.com/
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  Makefile     | 9 ++++++++-
>  init/Kconfig | 2 +-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>

This is great, we should have done that a long time ago :)

[...]
