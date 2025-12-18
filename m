Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57463358D4
	for <dwarves@vger.kernel.org>; Thu, 18 Dec 2025 20:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766091500; cv=none; b=qxMC6hI+rqOAd5V8KoKcLY48e8DEtJ34SqTZTOtfG+TnkjiuZX0CtxtYcIuOWkL0IyG/QmdsIjuhQuBIkHXsrHznyYk2/uIBBP1khCSV4R/OALnY64lN8pNoWWq3gEdSlck/iSHQ/meulCT15mmCvRSry+UZxNPKt5B/QXXC7Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766091500; c=relaxed/simple;
	bh=cqUjv37bQrHWjLeiJzydyeedJGJwjMmSj74naJ3C0pE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cMDarJTz3yocBKHLCa1NwIty/yF9wg9NdQttsv0xhsNUGTDuUR5AarA+4wMO2ucwYeJWjsaYALbts4MCIgCKDq2jS2IhnPD9evkGGJdQ8Myz684LPjXpwEaCogU+D3YUMGW7Et3UlLeCQvMCTGooCBvmMNwZhZHrdzR3KDevZmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7wWP3Zl; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7wWP3Zl"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3e12fd71984so806936fac.2
        for <dwarves@vger.kernel.org>; Thu, 18 Dec 2025 12:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766091498; x=1766696298; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c9tipiql2onxACO3kjd/0S/XiUV13p9feMh/zj3zK8U=;
        b=U7wWP3ZlGqCOp3NfVpJBwpp9e//036Sp7OKeqIEhbC634XkPPuvq5tGCDXSOrx6Gf0
         ViGfriqXb81c736ofA99DcI7EwYnH5fEGnaACDyGRnOouzNihUYy2fA4KH+aUjJ2mVMD
         Y18KrGgIaecJIv6Q9Aqlp74IS8A6lHMymqUlrvP8kRP4G5kdiK+cVvbeHxCVe81Hz/W4
         gh31LCZWo3CAgDDz0H1KoWrV+gjAbHRYVBcydAYqPPoNTE57GGjYJJS0Gna9OfwyfDjY
         /yIAYsNKy1kJHAntjupoDYoKdL4PR5QJhQfdfgw54asixMwNGOH9dd33DVyBVkPoeLxq
         H7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766091498; x=1766696298;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9tipiql2onxACO3kjd/0S/XiUV13p9feMh/zj3zK8U=;
        b=A6cv4HKU/9J+rrEN+bD9fUekIHdsZbycs2zE37bJP/+3LbHW23L0dJzxISzWpXNAHL
         NbmVzVZfBvIx6ZSe81GnV2uG+rYy3PkmBx9LQeMWcz8xV3HaxG2BCKayhoSCpsKSUZxS
         JXWW7kNiFwXh+y/uYNLmfmWvgAeyjPG/P5yPpKb5Q7CWE6h+PbpOsJeJWUoH5HCBWWnj
         yAdZG3GTfXXn9ELDbajfNdCH3H3EojXs2ppQocZjVk0dMd4m2bG8WNsNexxVjQO7vtbz
         fkd8lxb5hWoMb4qA8Rswccn/QF3IUBlyQwUHvuOXWGiPFkJKwSqlQ3wbClC6I4e0VFCS
         pi3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWseVJ37KXHkeT67WVkxVWety8GrmyzpHGYrJGAbXIqdaK1akLTlnwz1qrXmQFwUbw6A66sJuuz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+91CJuR9B9ic8pmsJVqxy+kQAnt8+vsf6BaqpTTRjMr/Fq3qr
	Wpj+oqKJcCndyEPvr953Jd/OJf266gQHfmVCXkeKkvF9e6aSKvxfO3+E39nZsJDtf+s=
X-Gm-Gg: AY/fxX5BTzx9fn3kqs7c+YJidTNgLHft5QeDRB66Jre1rNqcPelxiI2Y3X4qaqovvi2
	V7KUGWDp3jGN0xb7HGBwGOkNVDyvQmHEZP7hjF+GguHWh1TQny1+Yw0d4s6GP/L81hCNzvikwcN
	S1efXtUjTCmo1F9iRwHhY9SElxH3JXrSsFV37Um5tWIoNiKjeYRdSSkw5DCLt6x/JGKp4JiloJ0
	+uzVwCO9Sp8CkNQlhH7GVCEM8RR0+Xdti0b79XOtZkCdJ7aJnGhyzv0bDoGAlm3hlk4Zh5JoMRl
	Cgc+V1NEKb0QEtQVVvvtqsDWRqca1j991J7wLMEoSbIXhh4PHTO+L4eb0S5uuqpWASpkLAOU/cY
	SH0E/MH8e95uyIFiqgO7n3DBmN/YYz7NT5mLCQFewZGcc61jUKgD6Z6r+a6V5DRl3NXeho4pYeN
	i8+kxh/eEjFhA/NIQ2kfYwjqJIO0T0UbTj3SxPvQCdotyfIXk=
X-Google-Smtp-Source: AGHT+IFmxk3YATonxLCiLcbn2iIMS7nFOUUgNJH1YIJWm9l0xXgphXvwi2zor2XCGLSbRXvcDbeAAQ==
X-Received: by 2002:a17:903:1249:b0:2a1:3cd9:a734 with SMTP id d9443c01a7336-2a2f2a4f99emr2804215ad.43.1766085667750;
        Thu, 18 Dec 2025 11:21:07 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:d912:2088:c593:6daa? ([2620:10d:c090:500::7:e642])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c9b52asm566865ad.45.2025.12.18.11.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 11:21:07 -0800 (PST)
Message-ID: <8be2cafa00b759220e73a6ce837ac9a3ff52da1f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 5/8] kbuild: Sync kconfig when
 PAHOLE_VERSION changes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alan Maguire	
 <alan.maguire@oracle.com>, Alexei Starovoitov <ast@kernel.org>, Andrea
 Righi	 <arighi@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 Andrii Nakryiko	 <andrii@kernel.org>, Bill Wendling <morbo@google.com>,
 Changwoo Min	 <changwoo@igalia.com>, Daniel Borkmann
 <daniel@iogearbox.net>, David Vernet	 <void@manifault.com>, Donglin Peng
 <dolinux.peng@gmail.com>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend	 <john.fastabend@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>, Justin Stitt	 <justinstitt@google.com>, KP Singh
 <kpsingh@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers	
 <nick.desaulniers+lkml@gmail.com>, Nicolas Schier <nsc@kernel.org>, Shuah
 Khan	 <shuah@kernel.org>, Song Liu <song@kernel.org>, Stanislav Fomichev	
 <sdf@fomichev.me>, Tejun Heo <tj@kernel.org>, Yonghong Song	
 <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
 linux-kbuild@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev
Date: Thu, 18 Dec 2025 11:21:04 -0800
In-Reply-To: <20251218003314.260269-6-ihor.solodrai@linux.dev>
References: <20251218003314.260269-1-ihor.solodrai@linux.dev>
	 <20251218003314.260269-6-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: dwarves@vger.kernel.org
List-Id: <dwarves.vger.kernel.org>
List-Subscribe: <mailto:dwarves+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dwarves+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-17 at 16:33 -0800, Ihor Solodrai wrote:
> This patch implements kconfig re-sync when the pahole version changes
> between builds, similar to how it happens for compiler version change
> via CC_VERSION_TEXT.
>=20
> Define PAHOLE_VERSION in the top-level Makefile and export it for
> config builds. Set CONFIG_PAHOLE_VERSION default to the exported
> variable.
>=20
> Kconfig records the PAHOLE_VERSION value in
> include/config/auto.conf.cmd [1].
>=20
> The Makefile includes auto.conf.cmd, so if PAHOLE_VERSION changes
> between builds, make detects a dependency change and triggers
> syncconfig to update the kconfig [2].
>=20
> For external module builds, add a warning message in the prepare
> target, similar to the existing compiler version mismatch warning.
>=20
> Note that if pahole is not installed or available, PAHOLE_VERSION is
> set to 0 by pahole-version.sh, so the (un)installation of pahole is
> treated as a version change.
>=20
> See previous discussions for context [3].
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/scripts/kconfig/preprocess.c?h=3Dv6.18#n91
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Makefile?h=3Dv6.18#n815
> [3] https://lore.kernel.org/bpf/8f946abf-dd88-4fac-8bb4-84fcd8d81cf0@orac=
le.com/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

When building BPF selftest modules the pahole version change was
detected, but it seems that BTF rebuild was not triggered:

  $ (cd ./tools/testing/selftests/bpf/test_kmods/; make -j)
  make[1]: Entering directory '/home/ezingerman/bpf-next'
  make[2]: Entering directory '/home/ezingerman/bpf-next/tools/testing/self=
tests/bpf/test_kmods'
    CC [M]  bpf_testmod.o
    CC [M]  bpf_test_no_cfi.o
    CC [M]  bpf_test_modorder_x.o
    CC [M]  bpf_test_modorder_y.o
    CC [M]  bpf_test_rqspinlock.o
    MODPOST Module.symvers
    CC [M]  bpf_testmod.mod.o
    CC [M]  .module-common.o
    CC [M]  bpf_test_no_cfi.mod.o
    CC [M]  bpf_test_modorder_x.mod.o
    CC [M]  bpf_test_modorder_y.mod.o
    CC [M]  bpf_test_rqspinlock.mod.o
    LD [M]  bpf_test_modorder_x.ko
    LD [M]  bpf_testmod.ko
    LD [M]  bpf_test_modorder_y.ko
    LD [M]  bpf_test_no_cfi.ko
    BTF [M] bpf_test_modorder_x.ko
    LD [M]  bpf_test_rqspinlock.ko
    BTF     bpf_test_modorder_x.ko
    BTF [M] bpf_test_no_cfi.ko
    BTF [M] bpf_test_modorder_y.ko
    BTF [M] bpf_testmod.ko
    BTF     bpf_test_no_cfi.ko
    BTF     bpf_test_modorder_y.ko
    BTF [M] bpf_test_rqspinlock.ko
    BTF     bpf_testmod.ko
    BTF     bpf_test_rqspinlock.ko
    BTFIDS  bpf_test_modorder_x.ko
    BTFIDS  bpf_test_modorder_y.ko
    BTFIDS  bpf_test_no_cfi.ko
    BTFIDS  bpf_testmod.ko
    OBJCOPY bpf_test_modorder_x.ko.BTF
    BTFIDS  bpf_test_rqspinlock.ko
    OBJCOPY bpf_test_no_cfi.ko.BTF
    OBJCOPY bpf_test_modorder_y.ko.BTF
    OBJCOPY bpf_testmod.ko.BTF
    OBJCOPY bpf_test_rqspinlock.ko.BTF
  make[2]: Leaving directory '/home/ezingerman/bpf-next/tools/testing/selft=
ests/bpf/test_kmods'
  make[1]: Leaving directory '/home/ezingerman/bpf-next'
  [~/bpf-next]
  $ (cd ./tools/testing/selftests/bpf/test_kmods/; make -j)
  make[1]: Entering directory '/home/ezingerman/bpf-next'
  make[2]: Entering directory '/home/ezingerman/bpf-next/tools/testing/self=
tests/bpf/test_kmods'
  make[2]: Leaving directory '/home/ezingerman/bpf-next/tools/testing/selft=
ests/bpf/test_kmods'
  make[1]: Leaving directory '/home/ezingerman/bpf-next'

... update pahole from version 131 to 132 ...

  [~/bpf-next]
  $ (cd ./tools/testing/selftests/bpf/test_kmods/; make -j)
  make[1]: Entering directory '/home/ezingerman/bpf-next'
  make[2]: Entering directory '/home/ezingerman/bpf-next/tools/testing/self=
tests/bpf/test_kmods'
  warning: pahole version differs from the one used to build the kernel
    The kernel was built with: 131
    You are using:             132
  make[2]: Leaving directory '/home/ezingerman/bpf-next/tools/testing/selft=
ests/bpf/test_kmods'
  make[1]: Leaving directory '/home/ezingerman/bpf-next'

Is this an expected behavior?
