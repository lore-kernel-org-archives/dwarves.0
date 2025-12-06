Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8BF30F801
	for <dwarves@vger.kernel.org>; Sat,  6 Dec 2025 00:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764981189; cv=none; b=T83dF7VHvmTxF+E1p+P+2R3DeDmR47ylcYCJUWK5uLabflxMsfNRZMPm5t4JSPq32DpFPphr4CplNk70NxZxKKvmqmcl4c0OekEQDwy2701cuTRH6f7ZeXDN4p508I1rlLpdoV7l9X7v6x8kgwsn4pCxiZ5xPKEogjcREBUT1Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764981189; c=relaxed/simple;
	bh=mwsR3VdQIXmjSpIFQ6iYkZPs5XcFmLSjivzAJ/ScO/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ffqqn/4Awir0Gje3zh1unFcj3YMerNpY1nIeygTMRWXYa5xMF8HdhImVxLqpCGV9v1ilKjX4SmGrw6saTeBGanQ4bcE5aXAf8GcVoWeZPGsc495k76NN+2WSg1/eF8KCxrPBnRSNtNp/rkdDEICu7AoAE1LOuuyFQJBNHeoTKLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbFduZzo; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbFduZzo"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-341988c720aso2153267a91.3
        for <dwarves@vger.kernel.org>; Fri, 05 Dec 2025 16:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764981187; x=1765585987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FD3twwnahDeB5JzuuadsVrhVL7xA9ye+oGAnY3b9T1Y=;
        b=AbFduZzoqlisPC/XNMCfHCyHKJrnsxsedLTUBfw2TAVG5ISRNU75BmL4GbNt3cCvkO
         eva1DOiNEe5ph6ygfevB9Idar+5pTIxQuSOlKll48h2MFkjkMjIjLaWnpuPKZVUWmAbM
         in8pZodABrkmv3se9SUAUfKRxhQwgDmcgiX7xzRp7QXykUSTC8t4u56DlGYjtPjxL92D
         UWNvN3MtT3vmRqqA2BOZsiiysG2zaA+mPlZKzu4uljACg1hiJ8EdMVpy68TssPcNJeDn
         8uOq/tEHmXOZawCUuGG90hnpynSlbgZXs7n1h/Uv7pVP9+sfTiWaMFm+imle8M9uyxav
         daxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764981187; x=1765585987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FD3twwnahDeB5JzuuadsVrhVL7xA9ye+oGAnY3b9T1Y=;
        b=LmZj6ZZm5JKF81WABYcoRtROWB3+3Wvv2UmNbexWDXLk4qv8mESSrJtmYKTO/3uekv
         bgk0oXWIxwfWOaY12/o0OLnSeXUJqYM9/k79555X/zdlOYq+Uk+sIaY4Lk2q5W8nkdZz
         I8GVY/buKf0NhjHOOLYYxtVZpB6C/p5+wrVxvImpDp1/THGOVgaCKTydUedU72ZdSi75
         dkpjGzKpquybOCCZOS/NemmNmV3v3oMWZXc6ouNRcRiwZHQ/2T6vfODjVv2LlqyDg5wT
         mMs3Bz3GOt5nNHHVgT/sFUaDPNhAyWJPvPcFgIfMF9jdnTfHPTD29miGuJrIqVc/nYrQ
         d5nw==
X-Forwarded-Encrypted: i=1; AJvYcCU9Ky5ifIYheGGkVCRSu7oAbAlkBenBZY+8QMF6vYegNRoi2PKkX1xVH+jYR8oiTwviAYguiB7h@vger.kernel.org
X-Gm-Message-State: AOJu0Yw++mGXG544pTXQqosPs1CoABZ2F0qSSLP/4A6dLh5vvxc0MS0X
	6JHzb+t56ZcHkGjuLBRWtfFmlxlywvOpWUzn1G8viMdk5+BR1IhXcAppB/U42dZX8Ti3h/npgd1
	uZrsJooKw63Grzp1ALwuZ6xyV9S4Og38=
X-Gm-Gg: ASbGnctaHaFSt8YCLgUS0vOJlz0XW5TBDkKeLe2oqx4Irg9wWEYX8GRGeiZhTWMs8n6
	cyEkWBIckBXyIWp6MSGvvlCCXefKQSFoFNewHY9qIbHDMSYMx6segqjBlIwKcxRXrduNm8RG5a6
	iSVH3rWUu+bwQ5bzGuflTDYO7UdWEdhKQ8xj8CJBkCYEb9TMtL8VKz/CLlyqKmHpRYS6jtvGMTu
	DhsvXk8yBkVL3X4rTnOBv+Q4qOnBSCVATVMD25kxCstA5kmLX8UJblJUV8uh0i+A/7MEQiU5FQy
	g2pi/ozqDOk=
X-Google-Smtp-Source: AGHT+IGBCLfm4YRugKh2hJ+oVpnECHmhRwvYJM90dkgySXmk5N/rlKZJRH7MVNw3y3yGGRnyTrLvvcWm9HNWB8knfqY=
X-Received: by 2002:a17:90b:2691:b0:32c:2cd:4d67 with SMTP id
 98e67ed59e1d1-349a24f328emr624947a91.13.1764981186558; Fri, 05 Dec 2025
 16:33:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205223046.4155870-1-ihor.solodrai@linux.dev> <20251205223046.4155870-5-ihor.solodrai@linux.dev>
In-Reply-To: <20251205223046.4155870-5-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Dec 2025 16:32:54 -0800
X-Gm-Features: AWmQ_bktdNGDiOm2cGSNLZFFDhB1YVBRZ-JeCSzY-KUueJa7WjZLdTZHH8i7RBM
Message-ID: <CAEf4BzbwTWGs0g1dhrRGpYOxA-ce5n9z3FSKPHZ+KZ=fpJODag@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/6] lib/Kconfig.debug: Set the minimum
 required pahole version to v1.22
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Donglin Peng <dolinux.peng@gmail.com>, bpf@vger.kernel.org, dwarves@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 2:32=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
>
> Subsequent patches in the series change vmlinux linking scripts to
> unconditionally pass --btf_encode_detached to pahole, which was
> introduced in v1.22 [1][2].
>
> This change allows to remove PAHOLE_HAS_SPLIT_BTF Kconfig option and
> other checks of older pahole versions.
>
> [1] https://github.com/acmel/dwarves/releases/tag/v1.22
> [2] https://lore.kernel.org/bpf/cbafbf4e-9073-4383-8ee6-1353f9e5869c@orac=
le.com/
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  lib/Kconfig.debug         | 13 ++++---------
>  scripts/Makefile.btf      |  9 +--------
>  tools/sched_ext/README.md |  1 -
>  3 files changed, 5 insertions(+), 18 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 742b23ef0d8b..3abf3ae554b6 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -389,18 +389,13 @@ config DEBUG_INFO_BTF
>         depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
>         depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
>         depends on BPF_SYSCALL
> -       depends on PAHOLE_VERSION >=3D 116
> -       depends on DEBUG_INFO_DWARF4 || PAHOLE_VERSION >=3D 121
> +       depends on PAHOLE_VERSION >=3D 122
>         # pahole uses elfutils, which does not have support for Hexagon r=
elocations
>         depends on !HEXAGON
>         help
>           Generate deduplicated BTF type information from DWARF debug inf=
o.
> -         Turning this on requires pahole v1.16 or later (v1.21 or later =
to
> -         support DWARF 5), which will convert DWARF type info into equiv=
alent
> -         deduplicated BTF type info.
> -
> -config PAHOLE_HAS_SPLIT_BTF
> -       def_bool PAHOLE_VERSION >=3D 119
> +         Turning this on requires pahole v1.22 or later, which will conv=
ert
> +         DWARF type info into equivalent deduplicated BTF type info.
>
>  config PAHOLE_HAS_BTF_TAG
>         def_bool PAHOLE_VERSION >=3D 123
> @@ -422,7 +417,7 @@ config PAHOLE_HAS_LANG_EXCLUDE
>  config DEBUG_INFO_BTF_MODULES
>         bool "Generate BTF type information for kernel modules"
>         default y
> -       depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
> +       depends on DEBUG_INFO_BTF && MODULES
>         help
>           Generate compact split BTF type information for kernel modules.
>
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index db76335dd917..7c1cd6c2ff75 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -7,14 +7,7 @@ JOBS :=3D $(patsubst -j%,%,$(filter -j%,$(MAKEFLAGS)))
>
>  ifeq ($(call test-le, $(pahole-ver), 125),y)
>
> -# pahole 1.18 through 1.21 can't handle zero-sized per-CPU vars
> -ifeq ($(call test-le, $(pahole-ver), 121),y)
> -pahole-flags-$(call test-ge, $(pahole-ver), 118)       +=3D --skip_encod=
ing_btf_vars
> -endif
> -
> -pahole-flags-$(call test-ge, $(pahole-ver), 121)       +=3D --btf_gen_fl=
oats
> -
> -pahole-flags-$(call test-ge, $(pahole-ver), 122)       +=3D -j$(JOBS)
> +pahole-flags-$(call test-ge, $(pahole-ver), 122)       +=3D --btf_gen_fl=
oats -j$(JOBS)

this should be unconditional given we expect at least 1.22, no?

>
>  pahole-flags-$(call test-ge, $(pahole-ver), 125)       +=3D --skip_encod=
ing_btf_inconsistent_proto --btf_gen_optimized
>
> diff --git a/tools/sched_ext/README.md b/tools/sched_ext/README.md
> index 16a42e4060f6..56a9d1557ac4 100644
> --- a/tools/sched_ext/README.md
> +++ b/tools/sched_ext/README.md
> @@ -65,7 +65,6 @@ It's also recommended that you also include the followi=
ng Kconfig options:
>  ```
>  CONFIG_BPF_JIT_ALWAYS_ON=3Dy
>  CONFIG_BPF_JIT_DEFAULT_ON=3Dy
> -CONFIG_PAHOLE_HAS_SPLIT_BTF=3Dy
>  CONFIG_PAHOLE_HAS_BTF_TAG=3Dy
>  ```
>
> --
> 2.52.0
>
